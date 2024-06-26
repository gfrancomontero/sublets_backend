# frozen_string_literal: true

class CreateHouses < ActiveRecord::Migration[7.1]
  def change
    create_table :houses do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :bathrooms
      t.integer :bedrooms
      t.integer :price_per_night
      t.integer :price_per_week
      t.integer :price_per_month
      t.date :available_from
      t.date :available_until
      t.string :general_address
      t.json :title
      t.json :subtitle
      t.json :description
      t.boolean :paid
      t.boolean :admin_approved

      t.timestamps
    end

    add_index :houses, :bathrooms
    add_index :houses, :bedrooms
    add_index :houses, :paid
    add_index :houses, :admin_approved
    add_index :houses, :available_from
    add_index :houses, :available_until
  end
end
