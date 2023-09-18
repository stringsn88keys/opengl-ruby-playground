#
# For more samples, visit https://github.com/vaiorabbit/ruby-opengl/tree/master/sample .
#
# Ref.: /glfw-3.0.1/examples/simple.c
#
require 'opengl'
require 'glfw'
require 'cube'

ZOOM_OUT = 2
# Press ESC to exit.
key_callback = GLFW::create_callback(:GLFWkeyfun) do |window, key, scancode, action, mods|
  GLFW.SetWindowShouldClose(window, 1) if key == GLFW::KEY_ESCAPE && action == GLFW::PRESS
end
if __FILE__ == $PROGRAM_NAME
  GLFW.load_lib(File.join(ENV['LD_LIBRARY_PATH'], 'libglfw.dylib')) # Give path to "glfw3.dll (Windows)" or "libglfw.dylib (macOS)" if needed
  GLFW.Init()

  window = GLFW.CreateWindow(640, 480, "Simple example", nil, nil)
  GLFW.MakeContextCurrent(window)
  GLFW.SetKeyCallback(window, key_callback)

  GL.load_lib() # Call GL.load_lib after OpenGL context is available

  width_buf = ' ' * 8
  height_buf = ' ' * 8

  unit_cube=Cube.new(origin:[-0.5,-0.5,-0.5], volume:1, x:1, y:1, z:1)
  cubes=[unit_cube]
  [-1,1].each do |xt|
    [-1,1].each do |yt|
      [-1,1].each do |zt|
        cubes << unit_cube.transpose(xt,yt,zt)
      end
    end
  end

  until GLFW.WindowShouldClose(window) == GLFW::TRUE
    GLFW.GetFramebufferSize(window, width_buf, height_buf)
    width = width_buf.unpack1('L')
    height = height_buf.unpack1('L')
    ratio = width.to_f / height.to_f * ZOOM_OUT

    GL.Viewport(0, 0, width, height)
    # http://www.opengl-tutorial.org/beginners-tutorials/tutorial-4-a-colored-cube/
    # need to clear both color buffer and depth buffer
    GL.Clear(GL::COLOR_BUFFER_BIT | GL::DEPTH_BUFFER_BIT)
    GL.MatrixMode(GL::PROJECTION)
    GL.LoadIdentity()
    GL.Ortho(-ratio, ratio, -ZOOM_OUT, ZOOM_OUT, ZOOM_OUT, -ZOOM_OUT)
    GL.MatrixMode(GL::MODELVIEW)

    # need to have this in order to not just draw in order of shape definition
    GL.Enable(GL::DEPTH_TEST)
    GL.DepthFunc(GL::LESS)

    GL.LoadIdentity()
    GL.Rotatef(GLFW.GetTime() * 50.0, GLFW.GetTime*25.0, GLFW.GetTime*12.5, 1.0)

    cubes.each do |cube|
      cube.faces.each do |face|
        GL.Begin(GL::QUADS)
        face.points.each do |point|
          GL.Color3f(point[0]*0.5+0.5, point[1]*0.5+0.5, point[2]*0.5+0.5)
          GL.Vertex3f(point[0]*0.5, point[1]*0.5, point[2]*0.5)
        end
        GL.End()
      end
    end

    GLFW.SwapBuffers(window)
    GLFW.PollEvents()
  end

  GLFW.DestroyWindow(window)
  GLFW.Terminate()
end
