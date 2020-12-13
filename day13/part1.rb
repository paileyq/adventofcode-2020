lines = DATA.readlines.map(&:chomp)
earliest_timestamp = lines[0].to_i
buses = lines[1].split(',').reject { |bus| bus == 'x' }.map(&:to_i)

bus_id = nil
timestamp = earliest_timestamp
loop do
  bus_id = buses.find { |bus| timestamp % bus == 0 }
  break if bus_id

  timestamp += 1
end

minutes_to_wait = timestamp - earliest_timestamp
p (minutes_to_wait * bus_id)

__END__
1000186
17,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,907,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,x,x,x,x,x,x,x,23,x,x,x,x,x,29,x,653,x,x,x,x,x,x,x,x,x,41,x,x,13
