require 'mongo_mapper'

module MongoMapper
  module Plugins
    module Sluggable
      def self.included(model)
        model.plugin self
      end

      module ClassMethods
        def sluggable(to_slug = :title, options = {})
          @slug_options = {
            :to_slug      => to_slug,
            :key          => :slug,
            :index        => true,
            :method       => :parameterize,
            :scope        => nil,
            :callback     => :before_validation_on_create
          }.merge(options)

          key @slug_options[:key], String, :index => @slug_options[:index]

          self.send(@slug_options[:callback], :set_slug)
        end

        class_eval do
          attr_reader :slug_options
        end
      end

      module InstanceMethods
        def set_slug
          options = self.class.slug_options
          return unless self.send(options[:key]).blank?

          to_slug = self[options[:to_slug]]
          return if to_slug.blank?

          the_slug = raw_slug = to_slug.send(options[:method]).to_s

          conds = {}
          conds[options[:key]]   = the_slug
          conds[options[:scope]] = self.send(options[:scope]) if options[:scope]

          # todo - remove the loop and use regex instead so we can do it in one query
          i = 0
          while self.class.first(conds)
            i += 1
            conds[options[:key]] = the_slug = "#{raw_slug}-#{i}"
          end

          self.send(:"#{options[:key]}=", the_slug)
        end
      end
    end
  end
end