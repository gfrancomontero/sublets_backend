# frozen_string_literal: true

# rubocop:disable Style/Documentation, Metrics/MethodLength

class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.references :house, foreign_key: true
      t.string :street
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :country_code
      t.st_point :geolocation, null: false, geographic: true

      t.timestamps
    end

    # Add an index on the geolocation for performance
    add_index :addresses, :geolocation, using: :gist
  end
end

# rubocop:enable Style/Documentation, Metrics/MethodLength
