s = ARGV[0]
h = {}
h.default = 0

sorted_arr = s.scan(/\w/).sort_by do |ch|
  ch
end

sorted_arr.each do |ch|
  h[ch] += 1
end

r = ''
h.each do |key, value|
  r += "#{key}#{value}"
end

puts r
