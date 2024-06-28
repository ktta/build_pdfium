

compile_sample ()
{
  cdf $BSRC/sample 
  
  $CC -c pdf_render_png.c -I ../pdfium/build/include/pdfium || fail "can not compile sample"
  $CC -c lodepng.c || fail "can not compile lodepng.c"
  $CXX -o pdf_render_png pdf_render_png.o lodepng.o -L ../pdfium/build/lib -lpdfium $LIBS_ICU $LIBS_FREETYPE $LIBS_JPEG -lz || fail "can not link sample"
  echo sample program $BSRC/sample/pdf_render_png ready
}

