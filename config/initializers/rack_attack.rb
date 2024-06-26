# frozen_string_literal: true

# rubocop:disable Style/Documentation
module Rack
  class Attack
    if 1 == 2
      throttle('search/ip', limit: 100, period: 30.minute) do |request|
        if request.path.start_with?('/houses')
          Rails.logger.info("Throttled: #{request.ip}")
          request.ip
        end
      end

      # Implement a cooldown period by blocking IPs that have been throttled
      blocklist('allow2ban search scrapers') do |req|
        Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 5, findtime: 15.minutes, bantime: 30.minutes) do
          # The count for the IP is incremented if the throttle block previously defined was triggered
          puts 'RACKATTACK TOO MANY REQUESTS'
        end
      end
    end
  end
end
# rubocop:enable Style/Documentation
