card_pub, door_pub = DATA.readlines.map(&:to_i)

def find_exp(target_pub)
  (1..).each do |loop_size|
    pub = 7.pow(loop_size, 20201227)
    return loop_size if pub == target_pub
  end
end

card_exp = find_exp(card_pub)
door_exp = find_exp(door_pub)

encryption_key1 = door_pub.pow(card_exp, 20201227)
encryption_key2 = card_pub.pow(door_exp, 20201227)

p encryption_key1
p encryption_key2

__END__
8987316
14681524
