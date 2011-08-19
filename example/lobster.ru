puts  File.dirname(__FILE__) 
$LOAD_PATH << File.dirname(__FILE__) + '/../lib'
require 'rack/lobster1'



use Rack::ShowExceptions
run Rack::Lobster1.new
