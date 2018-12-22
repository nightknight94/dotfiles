cmake_minimum_required(VERSION 3.10)

project (tests)

# Should work without this
# find_library(gtest gtest)
# find_library(gmock gmock)

file(GLOB sources *.cpp) # test source files
add_executable(tests ${sources})

set(required_libs gtest gmock pthread)
set(additional_libs <additional_libs>)

target_link_libraries(tests ${required_libs} ${additional_libs})
