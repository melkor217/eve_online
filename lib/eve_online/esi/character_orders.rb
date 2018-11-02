# frozen_string_literal: true

module EveOnline
  module ESI
    class CharacterOrders < Base
      API_ENDPOINT = 'https://esi.evetech.net/v2/characters/%<character_id>s/orders/?datasource=%<datasource>s'

      attr_reader :character_id

      def initialize(options)
        super

        @character_id = options.fetch(:character_id)
      end

      def orders
        @orders ||=
          begin
            output = []
            response.each do |order|
              output << Models::CharacterOrder.new(order)
            end
            output
          end
      end

      def scope
        'esi-markets.read_character_orders.v1'
      end

      def url
        format(API_ENDPOINT, character_id: character_id, datasource: datasource)
      end
    end
  end
end