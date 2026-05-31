#include <stdio.h>
#include <math.h>
#include <time.h>

#include "openfml.h"  

#define N 10000000

static inline double now_sec()
{
    return (double)clock() / CLOCKS_PER_SEC;
}

volatile float sink = 0.0f; // prevents optimization

// -------------------------
// OpenFML version
// -------------------------
float bench_openfml(float *data, int n)
{
    float acc = 0.0f;

    for (int i = 0; i < n; i++) {
        float x = data[i];

        float l = fast_log(x);
        float r = rsqrt(x);

        acc += l * r;
    }

    return acc;
}

// -------------------------
// libc version
// -------------------------
float bench_libc(float *data, int n)
{
    float acc = 0.0f;

    for (int i = 0; i < n; i++) {
        float x = data[i];

        float l = logf(x);
        float r = 1.0f / sqrtf(x);

        acc += l * r;
    }

    return acc;
}

int main()
{
    static float data[N];

    // init deterministic input (avoid cache randomness)
    for (int i = 0; i < N; i++) {
        data[i] = (float)(i % 10000 + 1);
    }

    // warmup
    sink += bench_openfml(data, N);
    sink += bench_libc(data, N);

    // ---------------- OpenFML ----------------
    double t1 = now_sec();
    sink += bench_openfml(data, N);
    double t2 = now_sec();

    // ---------------- libc ----------------
    double t3 = now_sec();
    sink += bench_libc(data, N);
    double t4 = now_sec();

    printf("OpenFML: %.6f sec\n", t2 - t1);
    printf("LibC   : %.6f sec\n", t4 - t3);

    // prevent optimization removal
    printf("sink: %f\n", sink);

    return 0;
}