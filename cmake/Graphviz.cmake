if(ENABLE_GRAPHVIZ)
  #[==[
  set(GRAPHVIZ_EXTERNAL_LIBS FALSE)
  # only dependencies between libraries
  set(GRAPHVIZ_EXECUTABLES FALSE)
  ]==]

  add_custom_target(
    graphviz
    COMMAND
      ${CMAKE_COMMAND}
      "--graphviz=${CMAKE_BINARY_DIR}/graphviz/${CMAKE_PROJECT_NAME}.dot" .
    COMMAND dot -Tpng ${CMAKE_BINARY_DIR}/graphviz/${CMAKE_PROJECT_NAME}.dot -o
            ${CMAKE_BINARY_DIR}/graphviz/${CMAKE_PROJECT_NAME}.png
    COMMAND dot -Tsvg ${CMAKE_BINARY_DIR}/graphviz/${CMAKE_PROJECT_NAME}.dot -o
            ${CMAKE_BINARY_DIR}/graphviz/${CMAKE_PROJECT_NAME}.svg
    WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
    COMMENT "Plotting dependencies graph..."
  )

  add_custom_command(
    TARGET graphviz
    POST_BUILD
    COMMAND ;
    COMMENT
      "${BoldMagenta}The images are saved in ${CMAKE_BINARY_DIR}/graphviz."
  )
else()
  add_custom_target(
    graphviz
    COMMAND bash -c
            "echo ${Red}Please enable graphviz in config file.${ColourReset}"
  )
endif()
