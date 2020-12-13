lines = DATA.readlines.map(&:chomp)

# { bus_id => minute_offset }
bus_offsets = Hash[lines[1].split(',').map.with_index { |bus, i| [bus.to_i, i] unless bus == 'x' }.compact]
buses = bus_offsets.keys.sort.reverse

# we need to find `t` which satisfies:
#     t % bus_id == (bus_id - minute_offset) % bus_id
# ...for every bus.

offset = buses[0] - bus_offsets[buses[0]]
multiplier = buses[0]

buses[1..-1].each do |bus|
  offset = (0..).each do |k|
    t = offset + multiplier*k
    break t if t % bus == (bus - bus_offsets[bus]) % bus
  end
  multiplier *= bus
end

p offset

# um I barely know what I just wrote. Let's see.
#
# The example problem: 7,13,x,x,59,x,31,19
#
# This is 5 buses. We need to find `t` which satisfies these 5 equations:
#
#   t % 59 == 55
#   t % 31 == 25
#   t % 19 == 12
#   t % 13 == 12
#   t % 7 == 0
#
# From the first equation we know that we'll get to `t` by starting with 55 and
# adding 59 to it over and over. I tried brute forcing this way, using the largest
# bus_id first, but the solution is way too big to brute force, as the puzzle
# hints at.
#
# Eventually I tried doing (t % 31) for each number in the sequence (55 + 59*k),
# and saw a pattern: each number in this sequence was the previous number minus
# 3. This, along with very vague memories from number theory class, led me to
# realize that every (11 + 31*j)th number in the sequence will satisfy (t % 31 == 25).
#
# This means we can now brute force much faster by starting on that 11th number,
# and adding 59*31 to it over and over. OR we can look at the next equation and
# look for the exact same pattern, and so on, until there's nothing left to
# brute force.
#
# So what we end up doing is:
#
#   1. Find the first number in the sequence (55 + 59*k) that satisfies (t % 31 == 25).
#   2. Make that number (645) the new offset, and 59*31 the new multiplier.
#   3. Find the first number in the sequence (645 + 59*31*k) that satisfies (t % 19 == 12).
#   4. Make that number (26251) the new offset, and 59*31*19 the new multiplier.
#   5. Find the first number in the sequence (26251 + 59*31*19*k) that satisfies (t % 13 == 12).
#   6. Make that number (165255) the new offset, and 59*31*19*13 the new multiplier.
#   7. Find the first number in the sequence (165255 + 59*31*19*13*k) that satisfies (t % 7 == 0).
#   8. That number (1068781) is the solution.

__END__
1000186
17,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,907,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,x,x,x,x,x,x,x,23,x,x,x,x,x,29,x,653,x,x,x,x,x,x,x,x,x,41,x,x,13
