# frozen_string_literal: true

module EveOnline
  module ESI
    class CharacterWallet < Base
      API_PATH = '/v1/characters/%<character_id>s/wallet/?datasource=%<datasource>s'

      attr_reader :character_id

      def initialize(options)
        super

        @character_id = options.fetch(:character_id)
      end

      def as_json
        {
          wallet: wallet
        }
      end

      def wallet
        response
      end

      def scope
        'esi-wallet.read_character_wallet.v1'
      end

      def url
        format("#{ API_HOST }#{ API_PATH }", character_id: character_id, datasource: datasource)
      end
    end
  end
end
