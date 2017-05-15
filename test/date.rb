class Fixnum
  def seconds
    self
  end
  def minutes
    self * 60
  end
end

now = Time.now
puts now
puts now + 100.minutes

class String
  def -
    puts 'aa'
  end
end

'c'.-
