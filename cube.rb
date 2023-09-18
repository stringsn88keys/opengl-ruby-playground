require 'face'
class Cube
  attr_accessor :faces

  def self.from_cube(cube)
    Marshal.load(Marshal.dump(cube))
  end

  def initialize(origin:[0,0,0], volume:1, x:1, y:1, z:1)
    @faces = self.class.unit_cube.dup
    transpose!(origin[0], origin[1], origin[2])
    scale!(x,y,z) # intended for orientation only
    scale!(volume**(1.0/3), volume**(1.0/3), volume**(1.0/3))
  end

  def transpose!(x,y,z)
    faces.each do |face|
      face.points.each do |point|
        point[0] += x
        point[1] += y
        point[2] += z
      end
    end
  end

  def transpose(x,y,z)
    Cube.from_cube(self).tap { |d| d.transpose!(x,y,z) }
  end

  def scale!(x,y,z)
    faces.each do |face|
      face.points.each do |point|
        point[0] *= x
        point[1] *= y
        point[2] *= z
      end
    end
  end

  def scale(x,y,z)
    Cube.from_cube(self).tap { |d| d.scale!(x,y,z) }
  end

  def self.unit_cube
    @unit_cube ||= [0,1,2].map do |rot|
      # rot = 0, 1, 2 => z, x, y
      [0,1].map do |plane|
        # plane = 0, 1 on z,x,y for xy, yz, xz
        # define face CW from +side of plane
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
    end.flatten
  end
end
