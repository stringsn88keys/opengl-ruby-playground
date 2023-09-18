# LD_LIBRARY_PATH for Linux
# DYLD_LIBRARY_PATH for Mac

export DYLD_LIBRARY_PATH=/opt/homebrew/Cellar/glfw/3.3.8/lib
export DYLD_FRAMEWORK_PATH=/opt/homebrew/Cellar/glfw/3.3.8/lib

LD_LIBRARY_PATH=/opt/homebrew/Cellar/glfw/3.3.8/lib ruby -I../ruby-opengl/lib:. $*
