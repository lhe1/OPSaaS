def abc(&block)
  %w{a e i o u}.each do |e|
    block.call(e)
  end
end

abc do |e|
  puts e
end

############

def efg
  %w{a e i o u}.each do |e|
  yield e
  end
end

efg do |e|
  puts e
end

############

xyz = lambda do |e|
  puts e
end

xyz.call 100

# abc xyz
# abc xyz.call
