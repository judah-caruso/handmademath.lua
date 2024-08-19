// These are needed to make sure we can export functions correctly

#define static
#define inline

#if defined(_WIN32)
   #define COVERAGE(a, b) __declspec(dllexport)
#elif defined(__APPLE__)
   #define COVERAGE(a, b) __attribute__((visibility("default")))
#endif

// NOTE: if using 'HANDMADE_MATH_USE_DEGREES' or 'HANDMADE_MATH_USE_TURNS',
// you must modify wrapper.lua and uncomment the appropriate 'angleRad',
// 'angleDeg', and 'angleTurn' functions.

// #define HANDMADE_MATH_USE_TURNS
// #define HANDMADE_MATH_USE_DEGREES
#define HANDMADE_MATH_USE_RADIANS

// #define HANDMADE_MATH_NO_SIMD
#include "HandmadeMath.h"
