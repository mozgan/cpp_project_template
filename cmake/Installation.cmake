# include(GNUInstallDirs)

if(project_type STREQUAL "HEADER_ONLY")
  install(
    DIRECTORY ${CMAKE_SOURCE_DIR}/header-only/
    DESTINATION include
    CONFIGURATIONS ${CMAKE_BUILD_TYPE}
    FILES_MATCHING
    PATTERN *.h*
  )
elseif(project_type STREQUAL "LIBRARY")
  set_property(
    TARGET ${CMAKE_PROJECT_NAME} PROPERTY POSITION_INDEPENDENT_CODE 1
  )
  install(TARGETS ${CMAKE_PROJECT_NAME}
          RUNTIME DESTINATION lib CONFIGURATIONS ${CMAKE_BUILD_TYPE}
                  COMPONENT libraries
  )
  install(
    DIRECTORY ${CMAKE_SOURCE_DIR}/include/ ${CMAKE_SOURCE_DIR}/header-only/
    DESTINATION include
    CONFIGURATIONS ${CMAKE_BUILD_TYPE}
    FILES_MATCHING
    PATTERN *.h*
  )
endif()
