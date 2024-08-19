#!/usr/bin/env sh

clang -arch arm64  -DARCH="arm64"  -dynamiclib -undefined dynamic_lookup -Wl,-U,symbol_name -o HandmadeMathArm HandmadeMath.c && \
clang -arch x86_64 -DARCH="x86_64" -dynamiclib -undefined dynamic_lookup -Wl,-U,symbol_name -o HandmadeMath86  HandmadeMath.c && \
lipo -create HandmadeMathArm HandmadeMath86 -output HandmadeMath.dylib && \
rm HandmadeMath86 HandmadeMathArm

