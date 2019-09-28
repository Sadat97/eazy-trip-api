# frozen_string_literal: true

class TripController < ApplicationController
  before_action :set_trip, only: %i[show destroy update submit_location]
  before_action :check_location, only: %i[submit_location]
  # GET /trips
  def index
    @trips = Trip.all
    json_response(@trips)
  end

  # POST /trips
  def create
    @trip = Trip.create(trip_params)
    json_response(@trip, :created)
  end

  # GET /trips/:id
  def show
    json_response(@trip)
  end

  # PUT /trips/:id
  def update
    @trip.update(trip_params)
    json_response @trip
  end

  def submit_location
    SubmitLocationWorker.perform_async(@trip.id, params[:location])
    json_response({message: 'the location is being updated'}, :ok)
  end

  # DELETE /trips/:id
  def destroy
    @trip.destroy
    head :no_content
  end

  private

  def set_trip
    @trip = Trip.find(params[:id])
  end

  def check_location
    unless params[:location].present?
      json_response({message: 'Location is needed'}, :unprocessable_entity)
    end
  end

  def trip_params
    params.permit(:status)
  end
end
