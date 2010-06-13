require 'mongo_mapper'

module MongoMapper
  module Plugins
    module Stripper
      def self.included(model)
        model.plugin self
      end

      def self.configure(base)
        base.before_validation :strip_attributes
      end

      module InstanceMethods
        def strip_attributes
          attributes.each do |key, value|
            if value.is_a?(String)
              value = value.strip
              value = nil if value.blank?
              self[key] = value
            end
          end
        end
      end
    end
  end
end