# This class stores infomation about people.
class Person
  attr_accessor :name, :age

  # Initialize with name and age.
  def initialize(name, age)
    @name = name
    @age = age
  end

  # Print info.
  def info
    puts "#@name is #@age years old."
  end
  
  def isme?
    puts @name
    if @name.match(/Le/)
      puts 'It\'s me.'
    end
  end
end

lei = Person.new('Lei', 30)
lei.info()
lei.isme?()