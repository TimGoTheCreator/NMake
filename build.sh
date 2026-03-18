#!/bin/sh
# NMake Build System - Shell (Linux/Android)

# Set Defaults
COMPILER="g++"
STANDARD="-std=c++20"
FILES=""

while IFS='=' read -r key val || [ -n "$key" ]; do
    # Strip spaces from the key
    k=$(echo "$key" | tr -d '[:space:]')
    
    case "$k" in
        COMPILER)
            COMPILER=$(echo "$val" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            ;;
        STANDARD)
            STANDARD=$(echo "$val" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')
            ;;
        FILES)
            # Strip { } and , to make it a clean list for g++
            FILES=$(echo "$val" | tr -d '{},')
            ;;
        OUTPUT)
            OUT=$(echo "$val" | tr -d '[:space:]')
            echo "[BUILD] Generating $OUT..."
            mkdir -p "$(dirname "$OUT")"
            $COMPILER $STANDARD $FILES -o "$OUT"
            [ $? -eq 0 ] && echo "Success." || echo "Build Failed."
            ;;
        RUN)
            # Execute the command exactly as written in the value
            cmd=$(echo "$val" | sed 's/^[[:space:]]*//')
            echo "[EXEC] $cmd"
            eval "$cmd"
            ;;
    esac
done < NMake.nmake
