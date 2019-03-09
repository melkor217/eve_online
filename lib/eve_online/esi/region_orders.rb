# frozen_string_literal: true

module EveOnline
  module ESI
    class RegionOrders < Base
      API_PATH = '/v1/markets/%<region_id>s/orders/?datasource=%<datasource>s&order_type=%<order_type>s&page=%<page>s&type_id=%<type_id>s'

      attr_reader :region_id, :page, :type_id, :order_type

      def initialize(options)
        super

        @region_id = options.fetch(:region_id)
        @page = options.fetch(:page, 1)
        @type_id = options.fetch(:type_id, "")
        @order_type = options.fetch(:order_type, "all")
      end

      def orders
        @orders ||=
          begin
            output = []
            response.each do |order|
              output << Models::RegionOrder.new(order)
            end
            output
          end
      end

      def url
        format("#{ API_HOST }#{ API_PATH }", region_id: region_id, datasource: datasource, page: page, type_id: type_id, order_type: order_type)
      end
    end
  end
end
