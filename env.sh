# usage:
# source <this> puts Debug euforia into path
# source <this> Release

flavor="RelWithDebInfo"
if test -n "$1"; then
  flavor="$1"
fi

euforia_path="$HOME/work/inprogress/euforia/dev/code/euforia/build/$flavor/bin"
add_to_path "$euforia_path"
add_to_path "$euforia_path/../../../lib/boolector/build/bin"

add_to_path "$HOME/code/ic3ia-bueno/build"

# seahorn="seahorn-release"
# # [[ $flavor = "Release" ]] && seahorn="seahorn-release"
# add_to_path "$HOME/code/seahorn/$seahorn/build/run/bin"

add_to_path "/opt/z3-4.8.7/bin"
