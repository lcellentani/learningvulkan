cmake_minimum_required (VERSION 3.2 FATAL_ERROR)
project (learningvulkan VERSION 0.1 LANGUAGES C CXX)

set(CMAKE_SUPPRESS_REGENERATION true)
# explicitly specify which configurations we want
set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# make all binary artifacts end up on the same place
set(CMAKE_BINARY_DIR ${PROJECT_SOURCE_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})

include_directories("${PROJECT_SOURCE_DIR}/3rdparty/glm")
include_directories("${PROJECT_SOURCE_DIR}/3rdparty/glfw/include")
include_directories("${PROJECT_SOURCE_DIR}/3rdparty/stb")

link_directories("${PROJECT_SOURCE_DIR}/3rdparty/glfw/lib/x86")

include(${PROJECT_SOURCE_DIR}/source/CMakeCommon.cmake)
#add_subdirectory(source/common)
add_subdirectory(source/00-hellotriangle)

if (MSVC)
	set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT 00-hellotriangle)
endif()

#file(COPY ${PROJECT_SOURCE_DIR}/3rdparty/glfw/lib/x86/glfw3.dll DESTINATION ${CMAKE_BINARY_DIR})