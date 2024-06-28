download_abseil ()
{
  echo "downloading abseil-cpp"
  cdf $TOPDIR/third_party 
  git clone https://github.com/abseil/abseil-cpp  || fail "can not download abseil-cpp"
}
