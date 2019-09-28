require 'rails_helper'

RSpec.describe 'trips API', type: :request do
# initialize test data 
  let!(:trips) { create_list(:trip, 10) }
  let(:trip_id) { trips.first.id }
  let!(:valid_trip) {create(:trip, status: 1)}

  # Test suite for GET /trips
  describe 'GET /trip' do
    # make HTTP get request before each example
    before { get '/trip' }

    it 'returns trips' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /trips/:id
  describe 'GET /trip/:id' do
    before { get "/trip/#{trip_id}" }

    context 'when the record exists' do
      it 'returns the trip' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(trip_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:trip_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(json).to have_key 'message'
      end
    end
  end

  # Test suite for POST /trip
  describe 'POST /trip' do
    # valid payload
    let(:valid_attributes) {  }

    context 'when the request is valid' do
      before { post '/trip', params: valid_attributes }

      it 'creates a trip' do
        expect(json['status']).to eq('ongoing')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/trip', params: { status: -1 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(json).to have_key 'message'
      end
    end
  end

  # Test suite for PUT /trip/:id
  describe 'PUT /trip/:id' do
    let(:valid_attributes) { {  } }
    let(:invalid_attributes) { {  status: 0  } }

    context 'when the record exists' do
      before { put "/trip/#{trip_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

    end

    context 'when the status is not in the right direction'  do

      before do
        put "/trip/#{valid_trip.id}", params: invalid_attributes
      end
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  # Test suite for DELETE /trip/:id
  describe 'DELETE /trip/:id' do
    before { delete "/trip/#{trip_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
