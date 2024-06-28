#!/bin/sh

#
# This script cleans up the remaining things from the build.
# use it ONLY after making use of the generated TAR file.
# 

cd `dirname $0`
rm -Rf pdfium
rm -f sample/*.o sample/pdf_render_png sample/lodepng.[ch]
echo "all done"
