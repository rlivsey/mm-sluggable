require 'mongo_mapper'

module MongoMapper
  module Plugins
    module Sluggable
      extend ActiveSupport::Concern

      module ClassMethods
        def sluggable(to_slug = :title, options = {})
          class_attribute :slug_options

          self.slug_options = {
            :to_slug      => to_slug,
            :key          => :slug,
            :method       => :parameterize,
            :scope        => nil,
            :max_length   => 256,
            :start        => 2,
            :callback     => [:before_validation, {:on => :create}]
          }.merge(options)

          key slug_options[:key], String

          if slug_options[:callback].is_a?(Array)
            self.send(slug_options[:callback][0], :set_slug, slug_options[:callback][1])
          else
            self.send(slug_options[:callback], :set_slug)
          end
        end
      end

      def set_slug
        klass = self.class
        while klass.respond_to?(:single_collection_parent)
          superclass = klass.single_collection_parent
          if superclass && superclass.respond_to?(:slug_options)
            klass = superclass
          else
            break
          end
        end

        options = klass.slug_options
        return unless self.send(options[:key]).blank?

        to_slug = self[options[:to_slug]]
        return if to_slug.blank?

        the_slug = raw_slug = to_slug.send(options[:method]).to_s[0...options[:max_length]]

        conds = {}
        conds[options[:key]]   = the_slug
        conds[options[:scope]] = self.send(options[:scope]) if options[:scope]

        # todo - remove the loop and use regex instead so we can do it in one query
        i = options[:start]

        while klass.first(conds)
          conds[options[:key]] = the_slug = "#{raw_slug}-#{i}"
          i += 1
        end

        self.send(:"#{options[:key]}=", the_slug)
      end

    end
  end
end