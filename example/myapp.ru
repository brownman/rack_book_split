puts  File.dirname(__FILE__) 
$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
require 'rack/myapp'



use Rack::ShowExceptions
run Rack::MyApp.new
