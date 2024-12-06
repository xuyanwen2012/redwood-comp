#pragma once

#include <spdlog/spdlog.h>

#include <future>

#include "../app_data.hpp"
#include "host_kernels.hpp"

namespace cpu {

[[nodiscard]] inline std::future<void> run_stage1(AppData &app_data) {
  spdlog::debug("CPU kernel 'vector_add', n = {}", app_data.n);

  return std::async(std::launch::async, [&]() {
    cpu::kernels::vector_add(app_data.u_input_a.data(),
                             app_data.u_input_b.data(),
                             app_data.u_output.data(),
                             0,
                             app_data.n);
  });
}

}  // namespace cpu
