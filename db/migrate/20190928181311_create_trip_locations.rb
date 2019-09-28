# frozen_string_literal: true

class CreateTripLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_locations do |t|
      t.string :location
      t.references :trip, foreign_key: true
      t.timestamps
    end
  end
end
