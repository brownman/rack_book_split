
module BookSplit
class FileLoader
  attr_accessor :file 

PATH = File.dirname __FILE__

  def initialize file_name

file_path = File.expand_path('../../../' , __FILE__   ) + '/txt/' + file_name
puts file_path

    @file = File.open file_path
  end

  def get_string
    str = ""
    while  line = @file.gets
      str << line
    end
    str
  end
end


class Splitter

  def self.split str , symbols
   
      arr = []
    symbols.each do
      |symbol|
      str = str.gsub "#{symbol}" , "#{symbol}\n"


    end

      arr = str.split "\n"
    arr 
  end
end



class Story 
  attr_accessor :story_str,
    :file_name

  def initialize 
    @story_str = ""

  end

  def add file_name
    file = FileLoader.new file_name
    @story_str =  file.get_string
  end


  def divide symbols 
    story_arr = Splitter.split @story_str , symbols
    story_arr
  end
end

class Reader 
  attr_accessor :story, :column , :symbols

  def initialize
   @story = []
   @symbols = []
    @column = []
  end

  def add_story file_name 

    story = Story.new
    
    story.add file_name
    @story.push story 


    puts "we have #{@story.length} stories so far!"
  end
  
  def update_symbols sym
    @symbols.push sym 
  end

  def create 
    @column = []
    @story.each do |story| 
    divided =  story.divide @symbols 
    @column.push divided
    end
  end
  def result_string amount = 20 

    counter =  0
    str = ""
    amount.times do
     str <<  "#{counter} | #{@column[0][counter]} | #{@column[1][counter] }\n"
      counter += 1
    end
    str
  end
  
  def column_limit id = 0 , from = 0 , amount = 20
    @column[id].slice(0 , 20)
  end
  def remove_empty!
    @column.each do |column|
       column.each_with_index do |object , i|
       column.delete_at(i)  if column[i].size <= 1
       end
    end
  end
  def  max a , b
    max = a >b ? a : b
    max
  end
end

end

