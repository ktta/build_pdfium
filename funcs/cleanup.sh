
cleanup ()
{
  cdf $TOPDIR
  rm -Rf build
  mkdirf build 
  echo "cleanup done"
}

