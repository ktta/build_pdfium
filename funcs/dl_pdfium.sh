

download_pdfium ()
{
  echo "downloading pdfium"
  cdf $BSRC 
  git clone https://pdfium.googlesource.com/pdfium || fail "can not download pdfium"
  mkdir -p $TOPDIR/build
}

patch_pdfium ()
{
  cdf $TOPDIR
  ed -s core/fxge/freetype/fx_freetype.cpp << EOF || fail "failed to patch fx_freetype.cpp"
/#define DEFINE_PS_TABLES/
i
#ifndef DEFINE_PS_TABLES_DATA
#define    DEFINE_PS_TABLES_DATA
#endif
.
w
EOF
}
