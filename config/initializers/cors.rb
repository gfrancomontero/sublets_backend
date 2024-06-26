# frozen_string_literal: true

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3000',
            'openbroker-frontend.vercel.app',
            'www.openbroker.com', 'openbroker.com',
            'https://www.elliottjames.es', 'www.elliottjames.es', 'elliottjames.es',
            'https://www.almahomes.es', 'www.almahomes.es', 'almahomes.es',
            'https://www.ownersdirect.es', 'www.ownersdirect.es', 'ownersdirect.es'
    resource '*',
             headers: :any,
             methods: %i[get post patch put delete options head],
             credentials: true
  end
end
