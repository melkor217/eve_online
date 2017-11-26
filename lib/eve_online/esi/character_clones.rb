module EveOnline
  module ESI
    class CharacterClones < Base
      API_ENDPOINT = 'https://esi.tech.ccp.is/v2/characters/%s/clones/?datasource=tranquility'.freeze

      attr_reader :character_id

      def initialize(options)
        super

        @character_id = options[:character_id]
      end

      def last_jump_date
        last_jump_date = response['last_jump_date']

        parse_datetime_with_timezone(last_jump_date) if last_jump_date
      end

      def home_location
        Models::HomeLocation.new(response['home_location'])
      end
      memoize :home_location

      def jump_clones
        output = []
        response['jump_clones'].each do |jump_clone|
          output << Models::JumpClone.new(jump_clone)
        end
        output
      end
      memoize :jump_clones

      def scope
        'esi-clones.read_clones.v1'
      end

      def url
        API_ENDPOINT % character_id
      end
    end
  end
end