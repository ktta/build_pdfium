


create_archive ()
{
  cdf $TOPDIR/build 
  mkdir -p lib
  ar rc lib/libpdfium.a *.o || fail "can not create archive"
  mkdir -p include/pdfium
  cp ../public/*.h include/pdfium || fail "can not copy headers"
  tar cjf $TOPDIR/pdfium.tar.bz2 lib include || "fail can not make tarfile"
  echo archive ready in $TOPDIR/pdfium.tar.bz2
}

compile_and_link ()
{
  cdf $TOPDIR 

  while read -r line 
  do
    compile_c_if "$line" 
  done < $BSRC/data/file_list_c

  while read -r line 
  do
    compile_cxx_if "$line" 
  done < $BSRC/data/file_list_cxx

  create_archive
}
