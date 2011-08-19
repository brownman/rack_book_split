require 'zlib'

require 'rack/request'
require 'rack/response'
$LOAD_PATH << File.dirname(__FILE__)
# + '/../lib'
#require 'myapp'




require 'book_split'

module Rack
  class MyApp

    # def initialize
    @reader = BookSplit::Reader.new

    @reader.add_story '3.txt'
    # @reader.story.length.should == 1
    @reader.add_story '4.txt'

    #   @reader.story.length.should == 2

    @reader.update_symbols ','
    @reader.update_symbols '.'
    @reader.create
    @reader.remove_empty!
     @result = @reader.result_string
MyAppString = @result


    # end

    #def call env
    #Rack::Handler::Thin.run lambda {|env|
    #  [200, {} , @result  ]
    #}
    #end
    def call(env)
      req = Request.new(env)
      if req.GET["flip"] == "left"
        myappstr = MyAppString.split("\n").
          map { |line| line.ljust(42).reverse }.
          join("\n")
        href = "?flip=right"
      elsif req.GET["flip"] == "crash"
        raise "MyApp crashed"
      else
        myappstr = MyAppString
        href = "?flip=left"
      end

      res = Response.new
      res.write "<title>MyAppicious!</title>"
      res.write "<pre>"
      res.write myappstr
      res.write "</pre>"
      res.write "<p><a href='#{href}'>flip!</a></p>"
      res.write "<p><a href='?flip=crash'>crash!</a></p>"
      res.finish
    end



  end

end

if $0 == __FILE__
  require 'rack'
  require 'rack/showexceptions'
  Rack::Handler::WEBrick.run \
    Rack::ShowExceptions.new(Rack::Lint.new(Rack::MyApp.new)),
    :Port => 9292
end
