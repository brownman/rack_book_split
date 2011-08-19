
require './book_split'

require 'rspec'
describe "BookSplit" do
  before :all do
    #=======================

    @reader  = BookSplit::Reader.new

  end

  it 'load txt file' do
    @reader.add_story '1.txt'
    @reader.story.length.should == 1
    @reader.add_story '2.txt'

    @reader.story.length.should == 2
  end

  it 'update symbols' do

    @reader.update_symbols ','
    @reader.update_symbols '.'

    @reader.symbols.length.should == 2
  end

  it 'knows to split a string to array' do
    arr = BookSplit::Splitter.split "hello, i expect 3 lines .. yes", [',','.']
    
    arr.length.should > 0
    
  end
  it 'so split..' do 
    @reader.column.length.should == 0
    @reader.create

    @reader.column.length.should == 2

    @reader.column[0].class.should == Array
    @reader.column[0].length.should == 6
    
  end



  it 'print the 2 columns nicely' do
    a = @reader.column[0].length 
    b = @reader.column[1].length 
    max = a >b ? a : b

    max.should >=  a 
    max.should >=  b 
    counter =  0
    max.times do
      puts "#{counter} | #{@reader.column[0][counter]} | #{@reader.column[1][counter]}"
      counter += 1
    end

  end

end

describe 'GUIDE TO THE GALAXY' do 

  before :all do

    @reader  = BookSplit::Reader.new
    @reader.add_story '3.txt'
    @reader.story.length.should == 1
    @reader.add_story '4.txt'

    @reader.story.length.should == 2

    @reader.update_symbols ','
    @reader.update_symbols '.'
    @reader.create

  end
  it  'load txt file' do

    @reader.result_string.class.should == String
    @reader.result_string.length.should > 1

  end
  it 'remove empty lines' do 
@reader.column[0].class.should == Array
old  =     @reader.column[0].length
    @reader.remove_empty! 

    @reader.column[0].length.should <= old
  end
  
  pending 'print the 2 columns nicely' do
    a = @reader.column[0].length 
    b = @reader.column[1].length 
    max = a >b ? a : b

    max.should >=  a 
    max.should >=  b 
    counter =  0
    20.times do
      puts "#{counter} | #{@reader.column[0][counter]} | #{@reader.column[1][counter]}"
      counter += 1
    end

  end


end


