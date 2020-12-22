chunks = DATA.read.split("\n\n")
deck1 = chunks[0].lines[1..-1].map(&:to_i)
deck2 = chunks[1].lines[1..-1].map(&:to_i)

until deck1.empty? || deck2.empty?
  card1, card2 = deck1.shift, deck2.shift
  if card1 > card2
    deck1.push(card1, card2)
  else
    deck2.push(card2, card1)
  end
end

winning_deck = deck1.empty? ? deck2 : deck1

score = winning_deck.reverse.map.with_index { |card, i| (i+1) * card }.sum
p score

__END__
Player 1:
21
48
44
31
29
5
23
11
12
27
49
22
18
7
15
20
2
45
14
17
40
35
6
24
41

Player 2:
47
1
10
16
28
37
8
26
46
25
3
9
34
50
32
36
43
4
42
33
19
13
38
39
30
