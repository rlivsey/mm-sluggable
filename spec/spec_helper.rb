$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
gem 'rspec'

require 'mm-sluggable'
require 'spec'

MongoMapper.database = 'mm-sluggable-spec'

def article_class
  klass = Class.new do
    include MongoMapper::Document
    set_collection_name :articles

    plugin MongoMapper::Plugins::Sluggable

    key :title,       String
    key :account_id,  Integer
  end

  klass.collection.remove
  klass
end

Spec::Runner.configure do |config|
end
