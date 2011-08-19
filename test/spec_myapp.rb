require 'rack/mock'

$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
require 'rack/myapp'





describe Rack::MyApp do
  should "result should be ok" do
    res = Rack::MockRequest.new(Rack::MyApp.new).get("/")
    res.should.be.ok
    res.body.should.include "Galaxy"
#    res.body.should.include "?flip"
#    res.body.should.include "crash"
  end

  should "be flippable" do
    res = Rack::MockRequest.new(Rack::MyApp.new).get("/?flip=left")
    res.should.be.ok
    res.body.should.include "yxalaG"
  end

  should "provide crashing for testing purposes" do
    lambda {
      Rack::MockRequest.new(Rack::MyApp.new).get("/?flip=crash")
    }.should.raise
  end
end

