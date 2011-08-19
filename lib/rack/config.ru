
require './myapp'
require './book_split'

use Rack::ShowExceptions
use Rack::Reloader
run MyApp.new

