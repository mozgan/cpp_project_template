# Use threads
find_package(Threads)
set(CMAKE_THREAD_PREFER_PTHREAD ON)
set(THREADS_PREFER_PTHREAD_FLAG ON)

# Find dependency libraries
separate_arguments(P_DEPENDENCY_LIBRARIES)
foreach(lib ${P_DEPENDENCY_LIBRARIES})
  find_library(${lib}_FOUND ${lib} PATH /usr/lib /usr/local/lib)

  if(${lib}_FOUND)
    message(${BoldMagenta} "-- ${lib} found.")
  else()
    message(FATAL_ERROR "${lib} NOT FOUND!")
  endif()
endforeach()

# Find dependency packages
separate_arguments(P_DEPENDENCY_PACKAGES)
foreach(pkg ${P_DEPENDENCY_PACKAGES})
  find_package(${pkg})
  if(${pkg}_FOUND)
    message(${BoldMagenta} "-- ${pkg} found.")
    list(APPEND PACKAGES_INCLUDE_DIRS ${${pkg}_INCLUDE_DIR})
    list(APPEND PACKAGES_LIBRARIES ${${pkg}_LIBRARY})
  else()
    message(FATAL_ERROR "${pkg} not found!")
  endif()
endforeach()
