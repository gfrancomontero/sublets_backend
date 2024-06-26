# frozen_string_literal: true

# rubocop:disable Style/Documentation

class CreateImages < ActiveRecord::Migration[7.1]
  def change
    create_table :images do |t|
      t.references :house, foreign_key: true, null: true
      t.string :url
      t.integer :position

      t.timestamps
    end
  end
end
# rubocop:enable Style/Documentation
