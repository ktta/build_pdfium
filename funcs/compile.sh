filetime ()
{
  if [ -e $1 ]; then
    stat -c %Y $1
  else
    echo 0
  fi
}

objname ()
{
  echo $1 | sed -e 's@/@D_D@g' -e 's/^[.]/PD/' -e 's/cpp$/o/' -e 's/cc$/o/' -e 's/c$/o/'
}

compile_cxx_if ()
{
  inpf=$1
  outf="build/`objname $1`"
  inptime=`filetime $inpf`
  outtime=`filetime $outf`
  if [ $inptime -ge $outtime ]; then
    echo compiling $inpf 
    $CXX -o $outf -c $inpf $CXXFLAGS || fail "failed to compile $inpf"
  else
    echo skipping $inpf
  fi
}

compile_c_if ()
{
  inpf=$1
  outf="build/`objname $1`"
  inptime=`filetime $inpf`
  outtime=`filetime $outf`
  if [ $inptime -ge $outtime ]; then
    echo compiling $inpf 
    $CC -o $outf -c $inpf $CFLAGS || fail "failed to compile $inpf"
  else
    echo skipping $inpf
  fi
}


