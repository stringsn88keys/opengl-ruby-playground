class Cube
  attr_accessor :faces

  def initialize(origin:[0,0,0], volume:1, x:1, y:1, z:1)
    @volume = volume
    @origin = origin
  end

  def each_face
  end

  def transpose(x,y,z)
  end

  def scale(x,y,z)
  end

  def self.unit_cube
    @unit_cube ||= [0,1,2].map do |rot|
      # rot = 0, 1, 2 => z, x, y
      [0,1].map do |plane|
        # plane = 0, 1 on z,x,y for xy, yz, xz
        Face.new(
          [
            [0, 0, plane],
            [0, 1, plane],
            [1, 1, plane],
            [1, 0, plane]
          ].map do |point|
            point.rotate(rot)
          end
        )
      end
    end
  end

end
