cup_labels = DATA.readlines[0].chomp.chars.map(&:to_i)

class Cup
  attr_accessor :label, :next_cup

  def initialize(label, next_cup = nil)
    @label, @next_cup = label, next_cup
  end
end

MAX_CUP = 1_000_000

# create linked list of cups
cup_head = Cup.new(cup_labels[0])
cup_tail = cup_head
cup_labels[1..-1].each do |label|
  cup_tail.next_cup = Cup.new(label)
  cup_tail = cup_tail.next_cup
end
(cup_labels.max+1).upto(MAX_CUP).each do |label|
  cup_tail.next_cup = Cup.new(label)
  cup_tail = cup_tail.next_cup
end

# make it circular!
cup_tail.next_cup = cup_head

# create lookup table to find each cup by its label
cups_by_label = {}
cups_by_label[cup_head.label] = cup_head
cur_cup = cup_head.next_cup
until cur_cup == cup_head
  cups_by_label[cur_cup.label] = cur_cup
  cur_cup = cur_cup.next_cup
end

cur_cup = cup_head
10_000_000.times do |i|
  # report progress
  puts("#{i/100_000}% done") if i % 100_000 == 0

  # pick up 3 cups
  picked_up_labels = [
    cur_cup.next_cup.label,
    cur_cup.next_cup.next_cup.label,
    cur_cup.next_cup.next_cup.next_cup.label
  ]
  picked_up = cur_cup.next_cup
  cur_cup.next_cup = cur_cup.next_cup.next_cup.next_cup.next_cup

  # determine destination label
  dest_label = cur_cup.label - 1
  dest_label = MAX_CUP if dest_label < 1
  while picked_up_labels.include?(dest_label)
    dest_label = (dest_label <= 1) ? MAX_CUP : dest_label - 1
  end

  # look up destination cup
  dest_cup = cups_by_label[dest_label]

  # insert the 3 picked up cups
  picked_up.next_cup.next_cup.next_cup = dest_cup.next_cup
  dest_cup.next_cup = picked_up

  # advance to next cup
  cur_cup = cur_cup.next_cup
end

# find the '1' cup and the two cups that come after it
one_cup = cups_by_label[1]
star_cups = [one_cup.next_cup, one_cup.next_cup.next_cup]

p star_cups.map(&:label).inject(:*)

__END__
469217538
