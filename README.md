# build_pdfium

pdfium is the PDF component of the Chrome web browser. It was apparently
bought from FoxPDF by Google. It can be built as a library to view and
extract information from PDF files.

Using the scripts in this package, you may can build pdfium without using
complicated Google build systems, which are not even documented very well.

The code actually doesn't use any sophisticated mechanisms for feature
control. There is just a bunch of ifdefs.

My configuration doesn't support JavaScript or forms handling. These can
be added later if needed. However, this will probably require much more
work.

Prerequisites
-------------

You need the following tools, which are quite common but listed just
for completeness:
- git
- sed
- ed
- tar
- C and C++ compilers
- bash

The following packages need to be installed on your system before
you can compile pdfium:
- freetype2
- libjpeg
- icu: Code by Unicode consortium. Ubuntu package name is libicu-dev.

Building
--------

Currently, only Linux is supported as a host and target. I haven't worked
at all on cross compilations. 

You need to edit config.linux to reflect your system and then run
build.sh. If you have multiple configurations, you can store them
as config.linux-x64, config.linux-arm64 etc. and then give the second
part of the file name as the first argument to build.sh. For example, 
```
./build.sh linux-x64
```
would use the configuration stored in config.linux-x64.

At the end of the build, you will get a sample program under sample/
and a TAR archive under pdfium.

The generated library within the TAR file will need to be linked using
a C++ compiler.

Cleanup
-------

After building, the ./build.sh script cleans up all temporary files.
The script ./clean.sh removes everything except the sources for this
package.

Network Usage
--------------

The script downloads pdfium (~200MB), abseil-cpp and lodepng.

If you already have pdfium downloaded, you may copy it under the
top directory and start from step 1.
```
cp -R /downloaded/pdfium ~/build_pdfium
~/build_pdfium/build.sh linux 1
```

