require File.expand_path("spec_helper", File.dirname(__FILE__))

describe "Roda.freeze" do
  before do
    app{}.freeze
  end

  it "should make opts not be modifiable after calling finalize!" do
    proc{app.opts[:foo] = 'bar'}.should raise_error
  end

  it "should make use and route raise errors" do
    proc{app.use Class.new}.should raise_error
    proc{app.route{}}.should raise_error
  end

  it "should make plugin raise errors" do
    proc{app.plugin Module.new}.should raise_error
  end

  it "should make subclassing raise errors" do
    proc{Class.new(app)}.should raise_error
  end

  it "should freeze app" do
    app.frozen?.should == true
    app.app.frozen?.should == true
  end
end
