require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "MongoMapper::Plugins::Stripper" do

  it "should strip whitespace on strings before validating" do
    @item = Something.new(:title => " something \n")
    lambda{
      @item.valid?
    }.should change(@item, :title).from(" something \n").to("something")
  end

  it "should set blank strings to nil before validating" do
    @item = Something.new(:title => "   ")
    lambda{
      @item.valid?
    }.should change(@item, :title).from("   ").to(nil)
  end

  it "should not touch other kinds of fields" do
    @item = Something.new(:title => "test", :created_at => Time.now)
    lambda{
      @item.valid?
    }.should_not change(@item, :created_at)
  end

end
