# check for compatilibities
if(ENABLE_THREAD_SANITIZER AND (ENABLE_ADDRESS_SANITIZER
                                OR ENABLE_LEAK_SANITIZER)
)
  message(FATAL_ERROR "Thread sanitizer does not work with "
                      "Address and/or Leak sanitizers!"
  )
endif()

if(ENABLE_MEMORY_SANITIZER
   AND (ENABLE_ADDRESS_SANITIZER OR ENABLE_LEAK_SANITIZER
        OR ENABLE_THREAD_SANITIZER)
)
  message(FATAL_ERROR "Memory sanitizer does not work with "
                      "Address, Leak or Thread sanirizers!"
  )
endif()

# include check cxx compiler flag
include(CheckCXXCompilerFlag)

macro(add_sanitizer flag)
  message(${BoldBlue} "-- Looking for -fsanitize=${flag}${ResetColour}")
  set(CMAKE_REQUIRED_FLAGS "-Werror -fsanitize=${flag}")
  check_cxx_compiler_flag(-fsanitize=${flag} HAVE_FLAG_SANITIZER)
  if(HAVE_FLAG_SANITIZER)
    message(${BoldGreen} "-- Adding -fsanitize=${flag}${ResetColour}")
    list(APPEND LIST_OF_SANITIZERS "${flag}")
  else()
    message(${Red} "-- -fsanitize=${flag} unavailable!")
  endif()
endmacro()

if(ENABLE_ADDRESS_SANITIZER)
  add_sanitizer("address")
endif()

if(ENABLE_LEAK_SANITIZER)
  add_sanitizer("leak")
endif()

if(ENABLE_MEMORY_SANITIZER)
  if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    message(WARNING "GCC does not support memory sanitizer yet!")
  else() # Clang
    add_sanitizer("memory")
  endif()
endif()

if(ENABLE_THREAD_SANITIZER)
  add_sanitizer("thread")
endif()

if(ENABLE_UNDEFINED_BEHAVIOR_SANITIZER)
  add_sanitizer("undefined")
endif()

list(JOIN LIST_OF_SANITIZERS "," LIST_OF_SANITIZERS)
if(LIST_OF_SANITIZERS)
  add_compile_options(-fsanitize=${LIST_OF_SANITIZERS})
  link_libraries(
    -fsanitize=${LIST_OF_SANITIZERS}
    -fno-sanitize-recover=all
    -fsanitize=float-divide-by-zero
    -fsanitize=float-cast-overflow
    -fno-sanitize=null
    -fno-sanitize=alignment
    -fno-omit-frame-pointer
    -fPIE
  )
  if(${project_type} STREQUAL "EXECUTABLE")
    link_libraries(-pie)
  endif()

  if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    link_libraries(-static-libasan)
  endif()

else()
  add_compile_options(-fno-sanitize=all)
endif()
