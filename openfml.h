// OpenTFMS: Open Trancendental Fast Math Library
// Will implement more features later 
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
static inline float fast_log(int x) {
    int exponent = ((x >> 23) & 0xFF) - 127;
    float mantissa = frexp(x, &exponent);
    return logf(mantissa) + (exponent * 0.693147);
}    
static inline float rsqrt(int x) {
     int exponent = ((x >> 23) & 0xFF) - 127;
     float mantissa = frexp(x, &exponent);
     return sqrt(1/mantissa) / pow(2, exponent/2);
}     
static inline float fast_sqrt(int x) {
   return 1/rsqrt(x);
 }  
static inline float atanh(int x) {
 return fast_log((1 + x)/(1 - x))/2;
} 
static inline int exp(int x, int n) {
 return pow(x, floor(fast_log(x)/fast_log(2)));
} 
