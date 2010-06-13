$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rubygems'
gem 'rspec'

require 'mm-stripper'
require 'spec'

MongoMapper.database = 'mm-stripper-spec'

class Something
  include MongoMapper::Document
  
  plugin MongoMapper::Plugins::Stripper
  
  key :title,       String
  key :created_at,  Time
  key :body,        String
  key :thing,       Boolean
end

Spec::Runner.configure do |config|
end
