// These defines are needed to make sure we can export functions correctly.
#define static
#define inline

#if defined(_WIN32)
   #define COVERAGE(a, b) __declspec(dllexport)
#elif defined(__APPLE__)
   #define COVERAGE(a, b) __attribute__((visibility("default")))
#endif

// #define HANDMADE_MATH_USE_RADIANS
// #define HANDMADE_MATH_USE_DEGREES
#define HANDMADE_MATH_USE_TURNS

// #define HANDMADE_MATH_NO_SIMD
#include "HandmadeMath.h"


// Allows hmm.lua to have knowledge about the compiled library.
COVERAGE(0, 0) int __definedAngleUnits() {
#if defined(HANDMADE_MATH_USE_RADIANS)
   return 0;
#elif defined(HANDMADE_MATH_USE_DEGREES)
   return 1;
#elif defined(HANDMADE_MATH_USE_TURNS)
   return 2;
#endif
}

COVERAGE(0, 0) int __definedSIMD() {
#if defined(HANDMADE_MATH__USE_SSE) || defined(HANDMADE_MATH__USE_NEON)
   return 1;
#else
   return 0;
#endif
}
