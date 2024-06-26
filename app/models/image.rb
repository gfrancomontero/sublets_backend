# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :house, optional: true

  # Validations
  validates :url, presence: true
end
