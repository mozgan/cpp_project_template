function(AddClangTidy target)

  if(ENABLE_CLANG_TIDY)
    find_program(CLANG_TIDY_BINARY "clang-tidy")
    mark_as_advanced(CLANG_TIDY_BINARY)

    if(CLANG_TIDY_BINARY)
      set_target_properties(
        ${target}
        PROPERTIES
          CXX_CLANG_TIDY
          "${CLANG_TIDY_BINARY};--fix;--fix-errors;--format-style=Google,--config-file=${CMAKE_SOURCE_DIR}/.clang-tidy;-extra-arg=-std=c++${CMAKE_CXX_STANDARD}"
          # "${CLANG_TIDY_BINARY};--fix-errors;-checks=*;modernize-use-nullptr;-extra-arg=-std=c++${CMAKE_CXX_STANDARD}"
      )
    else()
      message(WARNING "`clang_tidy` not found!")
    endif()
  endif()

endfunction()
