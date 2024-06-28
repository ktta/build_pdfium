


create_config ()
{
  echo "creating configuration"
  cdf $TOPDIR
  rm -Rf output
  rm -Rf build
  mkdirf output
  mkdirf build

  CONFIG_H=build/build_config.h
  sed -e "s/@CPU@/$ARCH_CPU/" > $CONFIG_H < $BSRC/data/build_config.h || fail "unable to create $CONFIG_H" 

}

