
puts 'print path:'
puts $LOAD_PATH


require 'rack/mock'
$LOAD_PATH << File.dirname(__FILE__) + '/../lib'


require 'rack/lobster1'



puts 'print path:'
puts $LOAD_PATH
describe Rack::Lobster1 do
  should "look like a lobster" do
    res = Rack::MockRequest.new(Rack::Lobster1.new).get("/")
    res.should.be.ok
    res.body.should.include "(,(,,(,,,("
    res.body.should.include "?flip"
    res.body.should.include "crash"
  end

  should "be flippable" do
    res = Rack::MockRequest.new(Rack::Lobster1.new).get("/?flip=left")
    res.should.be.ok
    res.body.should.include "(,,,(,,(,("
  end

  should "provide crashing for testing purposes" do
    lambda {
      Rack::MockRequest.new(Rack::Lobster1.new).get("/?flip=crash")
    }.should.raise
  end
end

describe Rack::Lobster1::LambdaLobster1 do
  should "be a single lambda" do
    Rack::Lobster1::LambdaLobster1.should.be.kind_of Proc
  end

  should "look like a lobster" do
    res = Rack::MockRequest.new(Rack::Lobster1::LambdaLobster1).get("/")
    res.should.be.ok
    res.body.should.include "(,(,,(,,,("
    res.body.should.include "?flip"
  end

  should "be flippable" do
    res = Rack::MockRequest.new(Rack::Lobster1::LambdaLobster1).get("/?flip")
    res.should.be.ok
    res.body.should.include "(,,,(,,(,("
  end
end


