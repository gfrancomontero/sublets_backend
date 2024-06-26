# frozen_string_literal: true

require 'faker'

# rubocop:disable Metrics/BlockLength,Layout/LineLength
# db/seeds.rb

Geocoder.configure(
  timeout: 10
)

200.times do
  25.times do
    user = User.create!(
      name: Faker::Name.first_name,
      email: Faker::Internet.unique.email,
      phone_number: Faker::PhoneNumber.cell_phone_in_e164
    )
    puts "User #{User.last.id}: #{user.email} created."

    # Create Houses, Addresses, and Images for each user
    4.times do |i|
      house = House.create!(
        user_id: user.id,
        bedrooms: [0, 1, 2, 3, 4].sample,
        bathrooms: [0, 1, 2, 3, 4].sample,
        price_per_night: rand(100..1500),
        price_per_week: rand(1500..5000),
        price_per_month: rand(2500..25000),
        available_from: Date.today,
        available_until: Date.tomorrow,
        general_address: ['Brooklyn', 'Manhattan', 'Long Island', 'Queens', 'Harlem'].sample,
        title: { en: "Title of Generated House #{i}" },
        subtitle: { en: "Subtitle House #{i}" },
        description: { en: "An Amazing description of the Seed Generated House #{i}. Luxurious, stylish, amazing." },
        paid: [true, false].sample,
        admin_approved: [true, false].sample,
      )

      puts "  House #{House.last.id} for User #{User.last.id} created."


      latitude = rand(40.5..40.9)
      longitude = rand(-74.2..-73.7)

      if (place = Geocoder.search([latitude, longitude])[0]&.data)
        puts 'geocoder loaded!'
      else
        puts 'geocoder didnt load'
      end

      geolocation_point = "POINT(#{longitude} #{latitude})"

      Address.create!(
        house_id: House.last.id,
        street: place ? place['display_name'] : 'seed street',
        neighborhood: place && place['address'] ? (place['address']['neighbourhood'] || place['address']['suburb'] || place['address']['city']) : 'seed neighborhood',
        city: place && place['address'] ? (place['address']['suburb'] || place['address']['city']) : 'seed city',
        state: place && place['address'] ? place['address']['state'] : 'seed state',
        zip_code: place && place['address'] ? place['address']['postcode'] : 'seed zip_code',
        country_code: place && place['address'] ? place['address']['country_code'] : 'seed country_code',
        geolocation: "SRID=4326;#{geolocation_point}"
      )
      puts "    Address for House #{House.last.id} added."

      5.times do |k|
        Image.create!(
          house_id: house.id,
          url: "https://source.unsplash.com/random/#{%w[800x600 400x200 1100x900 600x800].sample}/?house",
          position: k + 1
        )
        puts "Image #{Image.last.id} for House #{House.last.id} added."
      end
    end
  end
end

puts 'Database seeded!'
# rubocop:enable Metrics/BlockLength,Layout/LineLength
