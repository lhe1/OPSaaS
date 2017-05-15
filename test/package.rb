class Package
  attr_accessor :company, 
    :base,
    :fund,
    :perf_bonus,
    :stocks,
    :welfare
  
  def initialize(company, base, fund, perf_bonus, stocks, welfare)
    @company = company
    
    @base = base
    @fund = fund
    @perf_bonus = perf_bonus
    @stocks = stocks
    @welfare = welfare
  end
  
  def guarantee
    @base + @fund + @stocks + @welfare
  end
  
  def max
    @base + @fund + @stocks + @welfare + @perf_bonus
  end
end

bhp = Package.new("BHP",390000,(1425.4+356.4+89.1+1247)*12, 390000*0.15, 0, 0)
puts "BHP's Guarantee: #{bhp.guarantee}"
puts "BHP's Max: #{bhp.max()}"

apple = Package.new("Apple", 364000, (364000/13.0*0.1 - 1247)*12, 364000/13.0*2, 67200*6.679/4, 6000+2000)
puts "Apple's Guarantee: #{apple.guarantee}"
puts "Apple's Max: #{apple.max()}"

bb = Package.new("Blackboard", 290238.90, (1782-891)*12, 0, 0, 600*12)
puts "Blackboard's Guarantee: #{bb.guarantee}"
puts "Blackboard's Max: #{bb.max()}"

puts "BHP's increase: #{bhp.guarantee/bb.max}~#{bhp.max/bb.max}"
puts "Apple's increase: #{apple.guarantee/bb.max}~#{apple.max/bb.max}"