# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Gpx::TrackParser do
  describe '#call' do
    subject(:parser) { described_class.new(import, user.id).call }

    let(:user) { create(:user) }
    let(:file_path) { Rails.root.join('spec/fixtures/files/gpx/gpx_track_single_segment.gpx') }
    let(:raw_data) { Hash.from_xml(File.read(file_path)) }
    let(:import) { create(:import, user:, name: 'gpx_track.gpx', raw_data:) }

    context 'when file has a single segment' do
      it 'creates points' do
        expect { parser }.to change { Point.count }.by(301)
      end

      it 'broadcasts importing progress' do
        expect_any_instance_of(Imports::Broadcaster).to receive(:broadcast_import_progress).exactly(301).times

        parser
      end
    end

    context 'when file has multiple segments' do
      let(:file_path) { Rails.root.join('spec/fixtures/files/gpx/gpx_track_multiple_segments.gpx') }

      it 'creates points' do
        expect { parser }.to change { Point.count }.by(558)
      end

      it 'broadcasts importing progress' do
        expect_any_instance_of(Imports::Broadcaster).to receive(:broadcast_import_progress).exactly(558).times

        parser
      end
    end

    context 'when file has multiple tracks' do
      let(:file_path) { Rails.root.join('spec/fixtures/files/gpx/gpx_track_multiple_tracks.gpx') }

      it 'creates points' do
        expect { parser }.to change { Point.count }.by(407)
      end

      it 'broadcasts importing progress' do
        expect_any_instance_of(Imports::Broadcaster).to receive(:broadcast_import_progress).exactly(407).times

        parser
      end

      it 'creates points with correct data' do
        parser

        expect(Point.first.latitude).to eq(37.17221.to_d)
        expect(Point.first.longitude).to eq(-3.55468.to_d)
        expect(Point.first.altitude).to eq(1066)
        expect(Point.first.timestamp).to eq(Time.zone.parse('2024-04-21T10:19:55Z').to_i)
        expect(Point.first.velocity).to eq('2.9')
      end
    end
  end
end
