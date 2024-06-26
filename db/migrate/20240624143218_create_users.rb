# frozen_string_literal: true

# rubocop:disable Style/Documentation
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
# rubocop:enable Style/Documentation
