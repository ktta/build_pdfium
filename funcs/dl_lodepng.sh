download_lodepng ()
{
  echo "downloading lodepng"
  cdf $BSRC
  wget https://raw.githubusercontent.com/lvandeve/lodepng/master/lodepng.h -O sample/lodepng.h || fail "can not get lodepng.h"
  wget https://raw.githubusercontent.com/lvandeve/lodepng/master/lodepng.cpp -O sample/lodepng.c  || fail "can not get lodepng.c"
}
