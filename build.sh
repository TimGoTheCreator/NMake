#!/bin/sh

# 1. Check if the file exists
if [ ! -f "NMake.nmake" ]; then
    echo "Error: NMake.nmake not found!"
    exit 1
fi

# 2. Extract variables using grep/cut
CC=$(grep "COMPILER=" NMake.nmake | cut -d'=' -f2)
STD=$(grep "STANDARD=" NMake.nmake | cut -d'=' -f2)
FILES=$(grep "FILES=" NMake.nmake | cut -d'=' -f2)
OUT=$(grep "OUTPUT=" NMake.nmake | cut -d'=' -f2)

# 3. Execute build
echo "Building $OUT with $CC..."
mkdir -p $(dirname "$OUT")
$CC $STD $FILES -o $OUT

if [ $? -eq 0 ]; then
    echo "Done!"
else
    echo "Build failed."
fi
