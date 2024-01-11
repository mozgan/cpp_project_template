include(BuildInfo)

# Create executables
file(GLOB apps *.cpp)

foreach(app ${apps})
  get_filename_component(app_name "${app}" NAME_WLE)

  if(app_name STREQUAL "main")
    set(app_name ${CMAKE_PROJECT_NAME})
  endif()

  add_executable(${app_name} ${app})

  # target_include_directories(${app_name} PUBLIC ${PACKAGES_INCLUDE_DIRS})
  target_link_libraries(
    ${app_name} PRIVATE ${SRCS_OBJ} ${P_DEPENDENCY_LIBRARIES}
                        ${PACKAGES_LIBRARIES}
  )

  # add installation
  set_property(TARGET ${app_name} PROPERTY POSITION_INDEPENDENT_CODE 1)
  install(TARGETS ${app_name}
          RUNTIME DESTINATION bin CONFIGURATIONS ${BUILD_TYPE}
                  COMPONENT applications
  )

  AddBuildInfo(${app_name})
  AddMemcheck(${app_name})
  AddClangTidy(${app_name})
endforeach()
