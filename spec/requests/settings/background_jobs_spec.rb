require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/settings/background_jobs", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # Settings::BackgroundJob. As you add validations to Settings::BackgroundJob, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Settings::BackgroundJob.create! valid_attributes
      get settings_background_jobs_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      background_job = Settings::BackgroundJob.create! valid_attributes
      get settings_background_job_url(background_job)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_settings_background_job_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      background_job = Settings::BackgroundJob.create! valid_attributes
      get edit_settings_background_job_url(background_job)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Settings::BackgroundJob" do
        expect {
          post settings_background_jobs_url, params: { settings_background_job: valid_attributes }
        }.to change(Settings::BackgroundJob, :count).by(1)
      end

      it "redirects to the created settings_background_job" do
        post settings_background_jobs_url, params: { settings_background_job: valid_attributes }
        expect(response).to redirect_to(settings_background_job_url(Settings::BackgroundJob.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Settings::BackgroundJob" do
        expect {
          post settings_background_jobs_url, params: { settings_background_job: invalid_attributes }
        }.to change(Settings::BackgroundJob, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post settings_background_jobs_url, params: { settings_background_job: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested settings_background_job" do
        background_job = Settings::BackgroundJob.create! valid_attributes
        patch settings_background_job_url(background_job), params: { settings_background_job: new_attributes }
        background_job.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the settings_background_job" do
        background_job = Settings::BackgroundJob.create! valid_attributes
        patch settings_background_job_url(background_job), params: { settings_background_job: new_attributes }
        background_job.reload
        expect(response).to redirect_to(settings_background_job_url(background_job))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        background_job = Settings::BackgroundJob.create! valid_attributes
        patch settings_background_job_url(background_job), params: { settings_background_job: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested settings_background_job" do
      background_job = Settings::BackgroundJob.create! valid_attributes
      expect {
        delete settings_background_job_url(background_job)
      }.to change(Settings::BackgroundJob, :count).by(-1)
    end

    it "redirects to the settings_background_jobs list" do
      background_job = Settings::BackgroundJob.create! valid_attributes
      delete settings_background_job_url(background_job)
      expect(response).to redirect_to(settings_background_jobs_url)
    end
  end
end
