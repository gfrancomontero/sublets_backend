# frozen_string_literal: true

class User < ApplicationRecord
  has_many :houses, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  before_validation :titleize_name
  before_validation :downcase_email

  private

  def titleize_name
    self.name = name.titleize if name.present?
  end

  def downcase_email
    self.email = email.downcase if email.present?
  end
end
