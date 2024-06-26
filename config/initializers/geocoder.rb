# frozen_string_literal: true

Geocoder.configure(
  timeout: 10,
  http_headers: { 'User-Agent' => 'geocoder@gonzalofranco.com' }
)
