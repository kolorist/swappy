# 1. required version
cmake_minimum_required(VERSION 3.4.1)

# 2. initial setup
project (swappy)

file (GLOB_RECURSE file_list
	LIST_DIRECTORIES false
	"${PROJECT_SOURCE_DIR}/src/*.cpp")

# 4.2 exclude file according to platform
if (${TARGET_PLATFORM} STREQUAL "arm64-v8a" OR ${TARGET_PLATFORM} STREQUAL "arm-v7a")
	# nothing, because we use unity build
else ()
endif ()

# 5. specify target
add_library(swappy ${file_list})

# 6. compiling
target_include_directories (swappy
	PRIVATE		$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
	PRIVATE		$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/src/common>
	PRIVATE		$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/src/opengl>
	PRIVATE		$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/src/vulkan>
	PUBLIC		$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>)

# 7. linking
target_link_libraries (swappy
	android
	GLESv2
	log
	atomic)