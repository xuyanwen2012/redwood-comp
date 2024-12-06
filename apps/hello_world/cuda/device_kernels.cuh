#pragma once

#include <cuda_runtime.h>

#include <cstddef>

namespace cuda {

namespace kernels {

__global__ void vector_add(const float *input_a,
                           const float *input_b,
                           float *output,
                           size_t start,
                           size_t end);

}

}  // namespace cuda
