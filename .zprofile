###### Build Flags #####
# LDFLAGS and CPPFLAGS are used by Compilers while PKG_CONFIG_PATH is used by pkg-config

# libxml2
export LDFLAGS="-L/opt/homebrew/opt/libxml2/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libxml2/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libxml2/lib/pkgconfig"

# zlib
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/zlib/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/zlib/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/zlib/lib/pkgconfig"

# bzip2
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/bzip2/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/bzip2/include"

# Openssl
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/openssl@3/lib/pkgconfig"

# curl
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/curl/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/curl/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/curl/lib/pkgconfig"

# llvm
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/llvm/include"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# libpq (postgres)
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/libpq/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/libpq/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/libpq/lib/pkgconfig"

# mysql-client
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/mysql-client/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/mysql-client/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/mysql-client/lib/pkgconfig"

# ruby
# export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/ruby/lib"
# export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/ruby/include"
# export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/ruby/lib/pkgconfig"

# ICU 4 C
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/icu4c/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/icu4c/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/icu4c/lib/pkgconfig"

##### Path #####
export npm_config_prefix="$HOME/.local"

# GNU
export PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"

export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# flutter bin
export PATH="$PATH":"$HOME/.pub-cache/bin"

# TCL-TK
export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/tcl-tk/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/tcl-tk/include"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/opt/tcl-tk/lib/pkgconfig"

# android studio path
# export ANDROID_HOME="/Users/xylonx/Library/Android/sdk"
# export ANDROID_SDK_ROOT="/Users/xylonx/Library/Android/sdk"
# export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
# #export JAVA_HOME="/Library/Java/JavaVirtualMachines/zulu-20.jdk/Contents/Home"
# #export JAVA_HOME="/Users/xylonx/Library/Android/sdk/tools/bin"
# export NDK_HOME="$ANDROID_HOME/ndk/25.1.8937393"
# export PATH="$ANDROID_HOME/tools:$PATH"
# export PATH="$ANDROID_HOME/tools/bin:$PATH"
# export PATH="$ANDROID_HOME/platform-tools:$PATH"


# podman
# export DOCKER_HOST='unix:///Users/xylonx/.local/share/containers/podman/machine/qemu/podman.sock'
