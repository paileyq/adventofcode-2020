cups = DATA.readlines[0].chomp.chars.map(&:to_i)

cur_idx = 0
100.times do |i|
  picked_up = []
  3.times do
    to_pick_up = (cur_idx + 1) % cups.length
    picked_up << cups.delete_at(to_pick_up)
    cur_idx -= 1 if to_pick_up < cur_idx
  end

  dest_cup = cups[cur_idx] - 1
  until cups.include?(dest_cup)
    dest_cup = (dest_cup == 0) ? 9 : dest_cup - 1
  end

  dest_cup_idx = cups.index(dest_cup)
  cups.insert(dest_cup_idx + 1, *picked_up)
  cur_idx += 3 if dest_cup_idx < cur_idx

  cur_idx = (cur_idx + 1) % cups.length
end

cups_ordered = []
one = cups.index(1)
(1...cups.length).each do |i|
  cups_ordered << cups[(one + i) % cups.length]
end

puts cups_ordered.join

__END__
469217538
