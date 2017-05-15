class Person
  def initialize(name)
   raise ArgumentError, "No name provided" if name.empty?
  end
end

p = Person.new('')
