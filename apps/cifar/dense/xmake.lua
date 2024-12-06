
target("app-cifar-dense")
    set_kind("binary")
    add_includedirs("$(projectdir)")
    add_headerfiles("*.hpp", "host/*.hpp")
    add_files("main.cpp", "host/*.cpp", "app_data.cpp")
    add_packages("spdlog", "cli11", "yaml-cpp")
    add_deps("cpu-backend")
    if is_plat("android") then
      on_run(run_on_android)
    end

    -- CUDA related (optional)
    if has_config("cuda-backend") then
      add_defines("REDWOOD_CUDA_BACKEND")
      add_deps("cu-backend")
      add_headerfiles("cuda/*.cuh")
      add_files("cuda/*.cu")
      add_cugencodes("native")
    end

    -- Vulkan related (optional)
    if has_config("vulkan-backend") then
      add_defines("REDWOOD_VULKAN_BACKEND")
      add_headerfiles("vulkan/*.hpp")
      add_files("vulkan/*.cpp")      
      add_deps("vk-backend")
      add_packages("vulkan-hpp", "vulkan-memory-allocator")
    end

target("bm-cifar-dense-cpu")
    set_kind("binary")
    add_includedirs("$(projectdir)")
    add_headerfiles("*.hpp", "host/*.hpp")
    add_files("bm_pinned.cpp", "host/*.cpp", "app_data.cpp")
    add_packages("spdlog", "cli11", "yaml-cpp")
    add_deps("cpu-backend")
    if is_plat("android") then
      on_run(run_on_android)
    end

    add_packages("benchmark")

if has_config("vulkan-backend") then

target("bm-cifar-dense-vk")
    set_kind("binary")
    add_includedirs("$(projectdir)")
    add_headerfiles("*.hpp")
    add_files("bm_vulkan.cpp", "app_data.cpp")
    add_packages("spdlog", "cli11", "yaml-cpp")

    if is_plat("android") then
      on_run(run_on_android)
    end

    add_packages("benchmark")

    add_defines("REDWOOD_VULKAN_BACKEND")
    add_headerfiles("vulkan/*.hpp")
    add_files("vulkan/*.cpp")      
    add_deps("vk-backend")
    add_packages("vulkan-hpp", "vulkan-memory-allocator")
target_end()

end

if has_config("cuda-backend") then

target("bm-cifar-dense-cuda")
    set_kind("binary")
    add_includedirs("$(projectdir)")
    add_headerfiles("*.hpp")
    add_files("bm_cuda.cpp", "app_data.cpp")
    add_packages("spdlog", "cli11", "yaml-cpp")

    if is_plat("android") then
      on_run(run_on_android)
    end

    add_packages("benchmark")
    
    add_defines("REDWOOD_CUDA_BACKEND")
    add_deps("cu-backend")
    add_headerfiles("cuda/*.cuh")
    add_files("cuda/*.cu")
    add_cugencodes("native")

target_end()

end
