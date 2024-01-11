file(GLOB_RECURSE srcs *.cpp)

if(srcs)
  if(project_type STREQUAL "LIBRARY")
    set(SRCS_OBJ ${CMAKE_PROJECT_NAME} CACHE INTERNAL "")
    add_library(${SRCS_OBJ} SHARED ${srcs})
    set_target_properties(${SRCS_OBJ} PROPERTIES SOVERSION ${VERSION_NO})
  elseif(project_type STREQUAL "EXECUTABLE")
    set(SRCS_OBJ ${CMAKE_PROJECT_NAME}_obj CACHE INTERNAL "")
    add_library(${SRCS_OBJ} OBJECT ${srcs})
  endif()

  # target_include_directories(${SRCS_OBJ} PUBLIC ${PACKAGES_INCLUDE_DIRS})
  target_link_libraries(
    ${SRCS_OBJ} PRIVATE ${P_DEPENDENCY_LIBRARIES} ${PACKAGES_LIBRARIES}
  )

  AddClangTidy(${SRCS_OBJ})
endif()
