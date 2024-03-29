# include(CMakePrintHelpers)

macro(print_all_variables)
  message(STATUS "=== === === CMAKE ALL VARIABLES === === ===")
  get_cmake_property(_variableNames VARIABLES)
  foreach(_variableName ${_variableNames})
    message(INFO "${_variableName}=${${_variableName}}")
  endforeach()
  message(STATUS "=== === === === === === === === === === ===")
endmacro()

macro(write_all_variables filename)
  file(REMOVE ${filename})
  get_cmake_property(_variableNames VARIABLES)
  foreach(_variableName ${_variableNames})
    file(APPEND ${filename} "${_variableName}=${${_variableName}}\n")
  endforeach()
  message(STATUS "All variables are written to the file ${filename}")
endmacro()
