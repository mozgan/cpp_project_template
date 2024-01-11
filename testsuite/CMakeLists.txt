include(Testing)
include(CodeCoverage)

# collect all cpp files to one executable test file
file(GLOB test_apps *.cpp)

if(test_apps)
  set(TEST_NAME ${CMAKE_PROJECT_NAME}_test)

  add_executable(${TEST_NAME} ${test_apps})
  set_target_properties(
    ${TEST_NAME} PROPERTIES RUNTIME_OUTPUT_DIRECTORY
                            ${PROJECT_BINARY_DIR}/tests
  )

  target_include_directories(${TEST_NAME} PUBLIC ${PACKAGES_INCLUDE_DIRS})
  target_link_libraries(
    ${TEST_NAME} PRIVATE ${SRCS_OBJ} ${P_DEPENDENCY_LIBRARIES}
                         ${PACKAGES_LIBRARIES} gtest gtest_main
  )
  gtest_add_tests(TARGET ${TEST_NAME})

  AddMemcheck(${TEST_NAME})
  AddCodeCoverage(${TEST_NAME})
endif()
