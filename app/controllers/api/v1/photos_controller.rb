# frozen_string_literal: true

class Api::V1::PhotosController < ApiController
  def index
    @photos = Rails.cache.fetch("photos_#{params[:start_date]}_#{params[:end_date]}", expires_in: 1.day) do
      Photos::Request.new(current_api_user, start_date: params[:start_date], end_date: params[:end_date]).call
    end

    render json: @photos, status: :ok
  end

  def thumbnail
    return unauthorized_integration unless integration_configured?

    response = fetch_cached_thumbnail(params[:source])
    handle_thumbnail_response(response)
  end

  private

  def fetch_cached_thumbnail(source)
    Rails.cache.fetch("photo_thumbnail_#{params[:id]}", expires_in: 1.day) do
      source_url = current_api_user.settings["#{source}_url"]
      source_api_key = current_api_user.settings["#{source}_api_key"]

      HTTParty.get(
        "#{source_url}/api/assets/#{params[:id]}/thumbnail?size=preview",
        headers: {
          'x-api-key' => source_api_key,
          'accept' => 'application/octet-stream'
        }
      )
    end
  end

  def handle_thumbnail_response(response)
    if response.success?
      send_data(response.body, type: 'image/jpeg', disposition: 'inline', status: :ok)
    else
      render json: { error: 'Failed to fetch thumbnail' }, status: response.code
    end
  end

  def integration_configured?
    (params[:source] == 'immich' && current_api_user.immich_integration_configured?) ||
      (params[:source] == 'photoprism' && current_api_user.photoprism_integration_configured?)
  end

  def unauthorized_integration
    render json: { error: "#{params[:source].capitalize} integration not configured" },
           status: :unauthorized
  end
end
