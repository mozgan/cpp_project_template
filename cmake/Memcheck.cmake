function(AddMemcheck target)

  if(ENABLE_MEMCHECK)
    include(FetchContent)
    FetchContent_Declare(
      memcheck-cover GIT_REPOSITORY https://github.com/Farigh/memcheck-cover.git
      GIT_TAG release-1.2
    )
    FetchContent_MakeAvailable(memcheck-cover)

    set(MEMCHECK_PATH ${memcheck-cover_SOURCE_DIR}/bin)
    set(REPORT_PATH "${CMAKE_BINARY_DIR}/memcheck-${target}")

    add_custom_target(
      memcheck-${target}
      COMMAND ${MEMCHECK_PATH}/memcheck_runner.sh -o "${REPORT_PATH}/report" --
              $<TARGET_FILE:${target}>
      COMMAND ${MEMCHECK_PATH}/generate_html_report.sh -i ${REPORT_PATH} -o
              ${REPORT_PATH}
      WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
      COMMENT "Creating report for ${target}"
    )

    # Show info where to find the report
    add_custom_command(
      TARGET memcheck-${target}
      POST_BUILD
      COMMAND ;
      COMMENT
        "${BoldMagenta}Open ${CMAKE_BINARY_DIR}/memcheck-${target}/index.html in your browser to view the report.${ColourReset}"
    )
  else()
    add_custom_target(
      memcheck-${target}
      COMMAND bash -c
              "echo ${Red}Please enable memcheck in config file.${ColourReset}"
    )
  endif()
endfunction()
