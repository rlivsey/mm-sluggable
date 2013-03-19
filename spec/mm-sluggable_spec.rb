require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MongoMapper::Plugins::Sluggable" do

  before(:each) do
    @klass = article_class
  end

  describe "with defaults" do
    before(:each) do
      @klass.sluggable :title
      @article = @klass.new(:title => "testing 123")
    end

    it "should add a key called :slug" do
      @article.keys.keys.should include("slug")
    end

    it "should set the slug on validation" do
      lambda{
        @article.valid?
      }.should change(@article, :slug).from(nil).to("testing-123")
    end

    it "should add a version number starting at 2 if the slug conflicts" do
      @klass.create(:title => "testing 123")
      lambda{
        @article.valid?
      }.should change(@article, :slug).from(nil).to("testing-123-2")
    end

    it "should truncate slugs over the max_length default of 256 characters" do
      @article.title = "a" * 300
      @article.valid?
      @article.slug.length.should == 256
    end
  end

  describe "with scope" do
    before(:each) do
      @klass.sluggable :title, :scope => :account_id
      @article = @klass.new(:title => "testing 123", :account_id => 1)
    end

    it "should add a version number if the slug conflics in the scope" do
      @klass.create(:title => "testing 123", :account_id => 1)
      lambda{
        @article.valid?
      }.should change(@article, :slug).from(nil).to("testing-123-2")
    end

    it "should not add a version number if the slug conflicts in a different scope" do
      @klass.create(:title => "testing 123", :account_id => 2)
      lambda{
        @article.valid?
      }.should change(@article, :slug).from(nil).to("testing-123")
    end
  end

  describe "with different key" do
    before(:each) do
      @klass.sluggable :title, :key => :title_slug
      @article = @klass.new(:title => "testing 123")
    end

    it "should add the specified key" do
      @article.keys.keys.should include("title_slug")
    end

    it "should set the slug on validation" do
      lambda{
        @article.valid?
      }.should change(@article, :title_slug).from(nil).to("testing-123")
    end
  end

  describe "with different slugging method" do
    before(:each) do
      @klass.sluggable :title, :method => :upcase
      @article = @klass.new(:title => "testing 123")
    end

    it "should set the slug using the specified method" do
      lambda{
        @article.valid?
      }.should change(@article, :slug).from(nil).to("TESTING 123")
    end
  end

  describe "with a different callback" do
    before(:each) do
      @klass.sluggable :title, :callback => :before_create
      @article = @klass.new(:title => "testing 123")
    end

    it "should not set the slug on the default callback" do
      lambda{
        @article.valid?
      }.should_not change(@article, :slug)
    end

    it "should set the slug on the specified callback" do
      lambda{
        @article.save
      }.should change(@article, :slug).from(nil).to("testing-123")
    end
  end

  describe "with custom max_length" do
    before(:each) do
      @klass.sluggable :title, :max_length => 5
      @article = @klass.new(:title => "testing 123")
    end

    it "should truncate slugs over the max length" do
      @article.valid?
      @article.slug.length.should == 5
    end
  end

  describe "with custom start" do
    before(:each) do
      @klass.sluggable :title, :start => 42
      @article = @klass.new(:title => "testing 123")
    end

    it "should start at the supplied version" do
      @klass.create(:title => "testing 123")
      lambda{
        @article.valid?
      }.should change(@article, :slug).from(nil).to("testing-123-42")
    end
  end
end