if(ENABLE_CPPCHECK)
  find_program(CPPCHECK_BINARY cppcheck)
  if(NOT CPPCHECK_BINARY)
    message(WARNING "cppcheck not found!")
    return()
  endif()

  set(CMAKE_CXX_CPPCHECK
      ${CPPCHECK_BINARY}
      --template=gcc
      --enable=style,performance,warning,portability
      --inline-suppr
      --quiet
      --std=c++${CMAKE_CXX_STANDARD}
      --suppress=missingInclude
      # if a file does not have an internalAstError, we get an
      # unmatchedSuppression error
      --suppress=unmatchedSuppression
      # We cannot act on a bug/missing feature of cppcheck
      --suppress=cppcheckError
      --suppress=internalAstError
      # noisy and incorrect sometimes
      --suppress=passedByValue
      # ignores code that cppcheck thinks is invalid C++
      --suppress=syntaxError
      --suppress=preprocessorErrorDirective
      --inconclusive
  )

  message(${BoldBlue} "-- cppcheck finished setting up.${ResetColour}")
endif()
