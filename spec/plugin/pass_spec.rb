require File.expand_path("spec_helper", File.dirname(File.dirname(__FILE__)))

describe "pass plugin" do 
  it "skips the current block if pass is called" do
    app(:pass) do |r|
      r.root do
        r.pass if env['FOO']
        'root'
      end

      r.on :id do |id|
        r.pass if id == 'foo'
        id
      end

      r.on ":x/:y" do |x, y|
        x + y
      end
    end

    body.should == 'root'
    status('FOO'=>true).should == 404
    body("/a").should == 'a'
    body("/a/b").should == 'a'
    body("/foo/a").should == 'fooa'
    body("/foo/a/b").should == 'fooa'
    status("/foo").should == 404
  end
end
