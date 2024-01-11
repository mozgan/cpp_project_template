# supported project types
set(PROJECT_TYPES HEADER_ONLY LIBRARY EXECUTABLE)

# supported build types
set(BUILD_TYPES debug release relwithdebinfo minsizerel)

# read trom file and set environment variables
macro(get_config config_file)
  file(STRINGS ${config_file} PROJECT_CONFIG REGEX "^[ ]*[A-Za-z0-9_]+[ ]*=")
  list(TRANSFORM PROJECT_CONFIG STRIP)
  list(TRANSFORM PROJECT_CONFIG REPLACE "([^=]+)=[ ]*(.*)" "set(\\1 \"\\2\")\n")

  cmake_language(EVAL CODE ${PROJECT_CONFIG})

  set(VERSION_NO "${P_VERSION_MAJOR}.${P_VERSION_MINOR}.${P_VERSION_PATCH}")
  set(VERSION_NAME "${P_NAME} v${VERSION_NO}")

  check_project_type()
  set_install_prefix()
  set_build_type()
  set_output_directories()
endmacro()

# Check project type if known
macro(check_project_type)
  string(TOUPPER "${P_TYPE}" project_type)
  if(NOT ${project_type} IN_LIST PROJECT_TYPES)
    message("#################################################################")
    message("# ${BoldRed}${P_TYPE}${ColourReset} is not a known project type!"
            "                      #"
    )
    message("#                                                               #")
    message("# Use one of the following build option:                        #")
    message("#                                                               #")
    message("# - ${Green}HEADER_ONLY${ColourReset}: The source files must be "
            "located in the        #"
    )
    message("#   `header-only` directory."
            "                                    #"
    )
    message("#                                                               #")
    message("# - ${Green}LIBRARY${ColourReset}: The sources should take place"
            " in `src` directory   #"
    )
    message("#   and their include fires are in `include` directory.         #")
    message("#                                                               #")
    message("# - ${Green}EXECUTABLE${ColourReset}: The source files are located"
            " in `app` directory #"
    )
    message("#   and use the sources from `src` and `header-only`.           #")
    message("#                                                               #")
    message("#################################################################")
    message(FATAL_ERROR "Quitting configuration")
  endif()
endmacro()

# Set install prefix directory
macro(set_install_prefix)
  if(P_INSTALL_PREFIX)
    set(CMAKE_INSTALL_PREFIX "${P_INSTALL_PREFIX}"
        CACHE INTERNAL "Set CMAKE_INSTALL_PREFIX to ${P_INSTALL_PREFIX}" FORCE
    )
  endif()
endmacro()

# Set build type
macro(set_build_type)
  string(TOLOWER "${P_BUILD_TYPE}" build_type_lower)
  if(NOT ${build_type_lower} IN_LIST BUILD_TYPES)
    message("#################################################################")
    message("# ${BoldRed}${P_BUILD_TYPE}${ColourReset} is not a known "
            "build type!                            #"
    )
    message("#                                                               #")
    message("# Use one of the following build option:                        #")
    message("#                                                               #")
    message("# - ${Green}Debug${ColourReset}: No optimization, "
            "asserts enabled, full debug info    #"
    )
    message("# included. (Compiler flags: ${BoldYellow}-O0 -g${ColourReset})"
            "                            #"
    )
    message("#                                                               #")
    message("# - ${Green}Release${ColourReset}: High optimization level, "
            "no debug info, code or    #"
    )
    message(
      "# asserts. (Compiler flags: ${BoldYellow}-O3 -DNDEBUG${ColourReset})"
      "                       #"
    )
    message("#                                                               #")

    message("# - ${Green}RelWithDebInfo${ColourReset}: Optimized, "
            "with debug info, but no debug    #"
    )
    message("# (output) code or asserts. "
            "(Compiler flags: ${BoldYellow}-O2 -g -DNDEBUG${ColourReset})   #"
    )
    message("#                                                               #")
    message("# - ${Green}MinSizeRel${ColourReset}: Same as "
            "Release but optimizing for size rather  #"
    )
    message("# than speed. "
            "(Compiler flags: ${BoldYellow}-Os -DNDEBUG${ColourReset})"
            "                    #"
    )
    message("#                                                               #")
    message("#################################################################")
    message(FATAL_ERROR "Quitting configuration")
  endif()

  if(${build_type_lower} STREQUAL "debug")
    set(CMAKE_BUILD_TYPE "Debug" CACHE INTERNAL "Set CMAKE_BUILD_TYPE to Debug"
                                       FORCE
    )
  elseif(${build_type_lower} STREQUAL "release")
    set(CMAKE_BUILD_TYPE "Release"
        CACHE INTERNAL "Set CMAKE_BUILD_TYPE to Release" FORCE
    )
  elseif(${build_type_lower} STREQUAL "relwithdebinfo")
    set(CMAKE_BUILD_TYPE "Release"
        CACHE INTERNAL "Set CMAKE_BUILD_TYPE to RelWithDebInfo" FORCE
    )
  elseif(${build_type_lower} STREQUAL "minsizerel")
    set(CMAKE_BUILD_TYPE "Release"
        CACHE INTERNAL "Set CMAKE_BUILD_TYPE to MinSizeRel" FORCE
    )
  endif()
endmacro()

# Set output directories globally
macro(set_output_directories)
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
endmacro()

# print configuration
function(print_config)
  message(${Blue} "=== === === AUTHOR INFO === === ===")
  message("AUTHOR NAME       : ${Cyan} ${P_AUTHOR_NAME}")
  message("AUTHOR E-MAIL     : ${Cyan} ${P_AUTHOR_MAIL}")
  message("VENDOR NAME       : ${Cyan} ${P_VENDOR_NAME}")

  message(${Blue} "=== === === PROJECT INFO === === ===")
  message("NAME              : ${Cyan} ${P_NAME}")
  message("DESCRIPTION       : ${Cyan} ${P_DESCRIPTION}")
  message("SUMMARY           : ${Cyan} ${P_SUMMARY}")
  message("HOMEPAGE          : ${Cyan} ${P_HOMEPAGE}")
  message("VERSION           : ${Red} ${VERSION_NO}")
  message("VERSION NAME      : ${Red} ${VERSION_NAME}")
  message("PROJECT TYPE      : ${Magenta} ${P_TYPE}")
  message("BUILD TYPE        : ${Magenta} ${P_BUILD_TYPE}")
  message("INSTALL PREFIX    : ${Cyan} ${CMAKE_INSTALL_PREFIX}")

  message(${Blue} "=== === === DEPENDENCIES === === ===")
  message("DEPENDENCY LIBS   : ${Yellow} ${P_DEPENDENCY_LIBRARIES}")
  message("DEPENDENCY PKGS   : ${Yellow} ${P_DEPENDENCY_PACKAGES}")

  message(${Blue} "=== === === === === === === === ===")
endfunction()
