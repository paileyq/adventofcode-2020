nums = DATA.read.split(',').map(&:to_i)

last_seen = {}
nums[0..-2].each.with_index do |num, i|
  last_seen[num] = i + 1
end

cur_num = nums.last
(nums.length...30_000_000).each do |turn|
  prev_turn = last_seen[cur_num]
  last_seen[cur_num] = turn
  cur_num = prev_turn ? turn - prev_turn : 0
end

p cur_num

__END__
1,0,15,2,10,13
