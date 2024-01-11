function(AddCodeCoverage target)
  if(NOT ENABLE_CODE_COVERAGE)
    add_custom_target(
      coverage
      COMMAND
        bash -c
        "echo ${Red}Please enable code coverage in config file and build the project with type \"Coverage\".${ColourReset}"
    )
    return()
  endif()

  if(NOT CMAKE_BUILD_TYPE STREQUAL "Debug")
    add_custom_target(
      coverage
      COMMAND
        bash -c
        "echo ${Red}Please build the project with build type Debug.${ColourReset}"
    )
    return()
  endif()

  find_program(GCOV_BINARY gcov)
  find_program(LCOV_BINARY lcov)
  find_program(GENHTML_BINARY genhtml)
  find_program(GCOVR_BINARY gcovr PATHS ${CMAKE_SOURCE_DIR}/testsuite)

  if(NOT GCOV_BINARY)
    message(FATAL_ERROR "gcov not found!")
  endif()

  if(NOT LCOV_BINARY)
    message(FATAL_ERROR "lcov not found!")
  endif()

  if(NOT GENHTML_BINARY)
    message(FATAL_ERROR "genhtml not found!")
  endif()

  #[=[
  set(CMAKE_CXX_FLAGS_COVERAGE
      "-g -O0 -fprofile-arcs -ftest-coverage -fno-inline"
      CACHE STRING "Flags used by the C++ compiler during coverage builds."
            FORCE
  )
  mark_as_advanced(CMAKE_CXX_FLAGS_COVERAGE)
  ]=]

  add_custom_target(
    coverage
    # cleanup
    COMMAND ${LCOV_BINARY} --directory . --zerocounters
    # run tests
    COMMAND $<TARGET_FILE:${target}>
    # capturing lcov counters and generating report
    COMMAND ${LCOV_BINARY} --directory . --capture --output-file coverage.info
    COMMAND ${LCOV_BINARY} --remove coverage.info '*/build/*' '*/testsuite/*'
            '/usr/*' --output-file filtered.info
    COMMAND ${GENHTML_BINARY} -o coverage filtered.info
    COMMAND ${LCOV_BINARY} --list filtered.info
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Running coverage..."
  )

  # Show info where to find the report
  add_custom_command(
    TARGET coverage
    POST_BUILD
    COMMAND ;
    COMMENT
      "${BoldMagenta}Open ${CMAKE_BINARY_DIR}/coverage/index.html in your browser to view the coverage report.${ColourReset}"
  )

endfunction()
