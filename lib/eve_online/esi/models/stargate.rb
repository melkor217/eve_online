# frozen_string_literal: true

module EveOnline
  module ESI
    module Models
      class Stargate < Base
        def as_json
          {
            name: name,
            stargate_id: stargate_id,
            system_id: system_id,
            type_id: type_id
          }
        end

        def name
          options['name']
        end

        def stargate_id
          options['stargate_id']
        end

        def system_id
          options['system_id']
        end

        def type_id
          options['type_id']
        end

        def destination
          @destination ||= StargateDestination.new(options['destination'])
        end

        def position
          @position ||= Position.new(options['position'])
        end
      end
    end
  end
end
