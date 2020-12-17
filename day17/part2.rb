slice = DATA.readlines.map(&:chomp)

world = {}
z = 0
w = 0
slice.each.with_index do |row, y|
  row.chars.each.with_index do |cube, x|
    world[[x, y, z, w]] = true if cube == '#'
  end
end

def count_neighbours(world, x, y, z, w)
  sum = 0
  (-1..1).each do |dx|
    (-1..1).each do |dy|
      (-1..1).each do |dz|
        (-1..1).each do |dw|
          sum += 1 if [dx, dy, dz, dw] != [0, 0, 0, 0] && world[[x+dx, y+dy, z+dz, w+dw]]
        end
      end
    end
  end
  sum
end

6.times do
  next_world = {}

  xs = world.keys.map { |x, _, _, _| x }
  ys = world.keys.map { |_, y, _, _| y }
  zs = world.keys.map { |_, _, z, _| z }
  ws = world.keys.map { |_, _, _, w| w }

  min_x, max_x = xs.min, xs.max
  min_y, max_y = ys.min, ys.max
  min_z, max_z = zs.min, zs.max
  min_w, max_w = ws.min, ws.max

  (min_x-1).upto(max_x+1).each do |x|
    (min_y-1).upto(max_y+1).each do |y|
      (min_z-1).upto(max_z+1).each do |z|
        (min_w-1).upto(max_w+1).each do |w|
          is_active = world[[x, y, z, w]]
          num_neighbours = count_neighbours(world, x, y, z, w)
          if (is_active && [2, 3].include?(num_neighbours)) || (!is_active && num_neighbours == 3)
            next_world[[x, y, z, w]] = true
          end
        end
      end
    end
  end

  world = next_world
end

p world.length

__END__
####...#
......#.
#..#.##.
.#...#.#
..###.#.
##.###..
.#...###
.##....#
