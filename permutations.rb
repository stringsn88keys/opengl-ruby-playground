class Cube
  def self.cube_squares
    @cube_squares ||= cube_square_points.map do |square|
      order_square_points(square)
    end
  end
  def self.cube_square_points
    @cube_square_points ||= [-1,1]. # all cube points are either -1 or 1
      repeated_permutation(3). # all permutation, with replacement, of (x,y,z)
      to_a. # unroll the enumerator
      combination(4). # all combinations of 4 points
      select do |perm|
        (perm.inject([0,0,0]) do |a,pm|
          # sum the x,y,z of the 4 points
          a[0]+=pm[0]
          a[1]+=pm[1]
          a[2]+=pm[2]
          a
          # only if one of the sums is 4 or -4
          # are the points of a square on a x/y/z plane
        end.select {|a| a.abs==4}.size)==1
      end
  end
end

