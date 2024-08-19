/* These are needed to make sure we can export things properly */

#define COVERAGE(a, b) __declspec(dllexport)
#define static
#define inline

#define HANDMADE_MATH_NO_SIMD
#define HANDMADE_MATH_USE_TURNS
#include "HandmadeMath.h"
