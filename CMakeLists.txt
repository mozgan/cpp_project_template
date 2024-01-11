cmake_minimum_required(VERSION 3.20 FATAL_ERROR)

# Disable in-source builds
include("cmake/PreventInSourceBuilds.cmake")

# === Include cmake modules === #
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(GenerateExportHeader)
include(CMakeDependentOption)
include(CheckCXXCompilerFlag)

include(Colors)
include(Utils)

# === Get configs === #
get_config("${CMAKE_CURRENT_SOURCE_DIR}/config.txt")

# === Set the name of project === #
project(
  ${P_NAME}
  VERSION ${VERSION_NO}
  DESCRIPTION ${P_DESCRIPTION}
  HOMEPAGE_URL ${P_HOMEPAGE}
  LANGUAGES CXX
)

print_config()

# === Include compiler flags === #
include(CompilerFlags)
include(InterproceduralOptimization)

# === Include checking tools === #
include(Memcheck)
include(ClangTidy)
include(CppCheck)
include(Sanitizers)

# === Check dependencies === #
include(Dependencies)

# === Include header files globally === #
include_directories(include header-only)

# === Build project === #
if(project_type STREQUAL "HEADER_ONLY")
  # nothing to do here
elseif(project_type STREQUAL "LIBRARY")
  add_subdirectory(src)
elseif(project_type STREQUAL "EXECUTABLE")
  add_subdirectory(src)
  add_subdirectory(app)
endif()

# === Tests === #
if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/testsuite")
  add_subdirectory(${CMAKE_CURRENT_SOURCE_DIR}/testsuite)
endif()

# === Include other modules === #
include(Doxygen)
include(Graphviz)
include(CodeFormatting)

include(Installation)
include(Packing)

include(CTest)

# === Use this to debug cmake variables === #
#[=[
include(CmakeDebug)
write_all_variables("${CMAKE_BINARY_DIR}/var.txt")
]=]
