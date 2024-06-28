get_steps ()
{
if [ "$STEP_NUMBER" = "" ]; then
  if [ -f "$step_file" ]; then
     read STEP_NUMBER < "$step_file"
  else
     STEP_NUMBER=0
  fi
fi

if [ "$LAST_STEP" = "" ]; then
  LAST_STEP=8
fi
}

run_steps ()
{
while [ "$STEP_NUMBER" -le $LAST_STEP ]; do
case "$STEP_NUMBER" in
0) download_pdfium ;;
1) patch_pdfium ;;
2) download_abseil ;;
3) download_lodepng ;;
4) create_config ;;
5) create_license_file ;;
6) compile_and_link ;;
7) compile_sample ;;
8) cleanup ;;
esac
let "STEP_NUMBER=$STEP_NUMBER+1"
echo "$STEP_NUMBER" > $step_file
done
}

