/* These are needed to make sure we can export things properly */

#if defined(_WIN32)
   #define COVERAGE(a, b) __declspec(dllexport)
#elif defined(__APPLE__)
   #define COVERAGE(a, b) __attribute__((visibility("default")))
#endif

#define static
#define inline

#define HANDMADE_MATH_NO_SIMD
#define HANDMADE_MATH_USE_TURNS
#include "HandmadeMath.h"
