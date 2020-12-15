nums = DATA.read.chomp.split(',').map(&:to_i)

turn = nums.length + 1
loop do
  last_num = nums[turn-2]
  prev_turn = nums[0...turn-2].rindex(last_num)
  if prev_turn
    nums << turn - prev_turn - 2
  else
    nums << 0
  end
  break if turn == 2020
  turn += 1
end

p nums.last

__END__
1,0,15,2,10,13
