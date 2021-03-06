# frozen_string_literal: true

require 'forwardable'

module EveOnline
  module ESI
    class CharacterPortrait < Base
      extend Forwardable

      API_PATH = '/v2/characters/%<character_id>s/portrait/?datasource=%<datasource>s'

      attr_reader :character_id

      def initialize(options)
        super

        @character_id = options.fetch(:character_id)
      end

      def_delegators :model, :as_json, :medium, :large, :huge, :small

      def model
        @model ||= Models::CharacterPortrait.new(response)
      end

      def scope; end

      def url
        format("#{ API_HOST }#{ API_PATH }", character_id: character_id, datasource: datasource)
      end
    end
  end
end
