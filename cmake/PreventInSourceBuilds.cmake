# This function will prevent in-source builds
function(AssureOutOfSourceBuilds)
  # make sure the user doesn't play dirty with symlinks
  get_filename_component(srcdir "${CMAKE_SOURCE_DIR}" REALPATH)
  get_filename_component(bindir "${CMAKE_BINARY_DIR}" REALPATH)

  # disallow in-source builds
  if("${srcdir}" STREQUAL "${bindir}")
    message("#################################################################")
    message("# The project should NOT be configured and/or built in the      #")
    message("# source directory!                                             #")
    message("#                                                               #")
    message("# Instead, use one of the following commands:                   #")
    message("# - cmake -B <build-directory>                                  #")
    message("# - mkdir build && cd build                                     #")
    message("#                                                               #")
    message("# Then you can proceed to configure and build by using the      #")
    message("# following commands:                                           #")
    message("#                                                               #")
    message("# cmake ..                                                      #")
    message("# make                                                          #")
    message("#                                                               #")
    message("# To remove files you accidentally created execute:             #")
    message("#                                                               #")
    message("# rm -rf CMakeFiles CMakeCache                                  #")
    message("#                                                               #")
    message("#################################################################")
    message(FATAL_ERROR "Quitting configuration")
  endif()
endfunction()

AssureOutOfSourceBuilds()