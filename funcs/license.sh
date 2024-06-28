create_license_file ()
{
  echo "creating license file"
  cdf $TOPDIR 
cat AUTHORS |  
sed -e 's/^#.*$//' -e '/^$/d' |
sed -e 's/"/\\"/g' |
sed -e 's/^/"/' -e 's/$/\\n" \\/' | 
sed -e '1i#ifndef PDFIUM_AUTHORS \
#define PDFIUM_AUTHORS \\'  | 
sed -e '$s/\\$//' |
cat > public/pdfium_license.h

cat LICENSE | 
sed -e 's@^//@@'  |
sed -e 's/"/\\"/g' |
sed -e 's/^/"/' -e 's/$/\\n" \\/' | 
sed -e '$s/\\$//' |
sed -e '1i#define PDFIUM_LICENSE \\' |
sed -e '1i 
' | 
sed -e '$a#endif' |
cat >> public/pdfium_license.h
}
