# frozen_string_literal: true

require 'forwardable'

module EveOnline
  module ESI
    class UniverseStation < Base
      extend Forwardable

      API_PATH = '/v2/universe/stations/%<station_id>s/?datasource=%<datasource>s'

      attr_reader :id

      def initialize(options)
        super

        @id = options.fetch(:id)
      end

      def_delegators :model, :as_json, :max_dockable_ship_volume, :name,
                     :office_rental_cost, :owner, :race_id,
                     :reprocessing_efficiency, :reprocessing_stations_take,
                     :services, :station_id, :system_id, :type_id, :position

      def model
        @model ||= Models::Station.new(response)
      end

      def scope; end

      def url
        format("#{ API_HOST }#{ API_PATH }", station_id: id, datasource: datasource)
      end
    end
  end
end
