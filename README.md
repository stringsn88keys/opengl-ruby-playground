# opengl-ruby-playground
Ruby scripts with OpenGL

# Use
Start with [ruby-opengl](https://github.com/vaiorabbit/ruby-opengl.git)

You may also need [lib-glfw](https://www.glfw.org/)

## Manjaro


```sh
sudo pacman -S glfw
```
```txt
sample/util/setup_dll.rb:      '/usr/lib/x86_64-linux-gnulibGL.so'
sample/util/setup_dll.rb:      '/usr/lib/x86_64-linux-gnu/libGLU.so'
sample/util/setup_dll.rb:      '/usr/lib/x86_64-linux-gnu/libglfw.so'`
```


[GLFW download](https://www.glfw.org/download.html)
[Unity OpneGL reference](https://docs.unity3d.com/ScriptReference/GL.TRIANGLES.html)
[compiling glfw](https://www.glfw.org/docs/latest/compile.html)

```sh
cmake -S path/to/glfw -B path/to/build -D BUILD_SHARED_LIBS=ON
cd path/to/build
make
``

```sh
ruby -Ipath/to/ruby-opengl/lib playground_script_to_run.rb
```
