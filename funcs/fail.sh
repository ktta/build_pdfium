fail ()
{
  echo "$1"
  exit 1
}


cdf ()
{
  cd "$1" || fail "failed to change directory to <$1>"
}

mkdirf ()
{
  mkdir "$1" || fail "failed to make dir <$1>"
}


