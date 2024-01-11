if(ENABLE_FORMATTING)
  find_program(CLANG_FORMAT_BINARY "clang-format")
  mark_as_advanced(CLANG_FORMAT_BINARY)

  file(
    GLOB_RECURSE
    project_files
    "${CMAKE_CURRENT_SOURCE_DIR}/header-only/*.h*"
    "${CMAKE_CURRENT_SOURCE_DIR}/include/*.h*"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.c**"
    "${CMAKE_CURRENT_SOURCE_DIR}/app/*.c*"
    "${CMAKE_CURRENT_SOURCE_DIR}/testsuite/*.h*"
    "${CMAKE_CURRENT_SOURCE_DIR}/testsuite/*.c*"
  )

  if(NOT FORMAT_STYLE)
    set(FORMAT_STYLE file)
  endif()

  if(CLANG_FORMAT_BINARY)
    add_custom_target(
      clang-format COMMAND ${CLANG_FORMAT_BINARY} --verbose
                           -style=${FORMAT_STYLE} -i ${project_files}
      WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}
    )
  else()
    add_custom_target(
      clang-format COMMAND bash -c
                           "echo ${Red}`clang-format` not found!${ColourReset}"
    )
  endif()
endif()
