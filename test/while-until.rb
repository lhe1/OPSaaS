x = 1
while (x < 10)
  x *= 2
  puts x
end

x = 1
until x > 10
  x *= 2
  puts x
end

x = 1
x += 1 until x > 1000
puts x

for i in 1..5
  puts i
end
