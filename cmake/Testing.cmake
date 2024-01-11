enable_testing()

include(FetchContent)

find_package(GTest QUIET)
if(NOT GTest_FOUND)
  set(GTEST_VERSION 1.12.1 CACHE STRING "Google test version")
  FetchContent_Declare(
    googletest GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG release-${GTEST_VERSION}
  )

  set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
  option(INSTALL_GMOCK "Insall GMock" OFF)
  option(INSTALL_GTEST "Insall GTest" OFF)
  FetchContent_MakeAvailable(googletest)
endif()

include(GoogleTest)
