class SubmitLocationWorker
  include Sidekiq::Worker

  def perfom(trip_id, location)
    trip = Trip.find trip_id
    trip.trip_locations.create! location
  end

end
