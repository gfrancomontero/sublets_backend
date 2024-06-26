# frozen_string_literal: true

FactoryBot.define do
  factory :house do
    user { nil }
    bathrooms { 1 }
    bedrooms { 1 }
    price_per_night { 1 }
    price_per_week { 1 }
    price_per_month { 1 }
    available_from { '2024-06-24' }
    available_until { '2024-06-24' }
    general_address { 'MyString' }
    title { '' }
    subtitle { '' }
    description { '' }
    property_status { 1 }
    paid { false }
    admin_approved { false }
    published { false }
  end
end
