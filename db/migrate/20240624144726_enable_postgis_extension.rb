# frozen_string_literal: true

# rubocop:disable Style/Documentation
class EnablePostgisExtension < ActiveRecord::Migration[7.1]
  def change
    enable_extension 'postgis'
  end
end
# rubocop:enable Style/Documentation
