class SubmitLocationWorker
  include Sidekiq::Worker

  def perform(trip_id, location)
    Trip.find(trip_id).trip_locations.create! location: location
  end

end
