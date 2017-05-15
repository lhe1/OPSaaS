#!/usr/bin/ruby

x, y = 'a', 'a'
puts x == y
puts x.eql? y
puts x.equal? y
puts x === y
puts 'a'.equal? 'a'

puts '##############'

class Person
  attr_accessor :name, :age
end

lei = Person.new
lei.name = "Lei"
lei.age = 30
felix = lei

nan = Person.new
nan.name = "lei"
nan.age = 30

puts lei == felix
puts lei.eql? felix
puts lei.equal? felix
puts lei === felix

puts '-----'

puts lei == nan
puts lei.eql? nan
puts lei.equal? nan
puts lei === nan

puts '##############'

x = [1, 2]
y = [1, 2]
puts x == y
puts x.eql? y
puts x.equal? y
puts x === y
