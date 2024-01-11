if(ENABLE_DOXYGEN)
  find_package(Doxygen)
  if(NOT DOXYGEN_FOUND)
    add_custom_target(doxygen COMMAND false COMMENT "Doxygen not found!")
    return()
  endif()

  macro(UseDoxygenAwesomeCss)
    include(FetchContent)
    FetchContent_Declare(
      doxygen-awesome-css
      GIT_REPOSITORY https://github.com/jothepro/doxygen-awesome-css.git
      GIT_TAG v2.2.1
    )
    FetchContent_MakeAvailable(doxygen-awesome-css)

    # Project related configuration
    set(DOXYGEN_ALWAYS_DETAILED_SEC YES)
    set(DOXYGEN_MULTILINE_CPP_IS_BRIEF YES)
    set(DOXYGEN_MARKDOWN_SUPPORT YES)
    set(DOXYGEN_MARKDOWN_ID_STYLE "DOXYGEN")
    set(DOXYGEN_BUILTIN_STL_SUPPORT NO)
    set(DOXYGEN_FULL_PATH_NAMES YES)
    set(DOXYGEN_INHERIT_DOCS YES)

    # Build related configuration
    set(DOXYGEN_EXTRACT_ALL YES)
    set(DOXYGEN_EXTRACT_PRIVATE YES)
    set(DOXYGEN_EXTRACT_PRIV_VIRTUAL YES)
    set(DOXYGEN_EXTRACT_PACKAGE NO)
    set(DOXYGEN_EXTRACT_STATIC YES)
    set(DOXYGEN_EXTRACT_LOCAL_CLASSES YES)
    set(DOXYGEN_EXTRACT_LOCAL_METHODS YES)
    set(DOXYGEN_EXTRACT_ANON_NSPACES YES)
    set(DOXYGEN_EXTRACT_UNNAMED_PARAMS YES)
    set(DOXYGEN_HIDE_UNDOC_MEMBERS NO)
    set(DOXYGEN_HIDE_UNDOC_CLASSES NO)
    set(DOXYGEN_HIDE_FRIEND_COMPOUNDS NO)
    set(DOXYGEN_SHOW_GROUPED_MEMB_INC YES)
    set(DOXYGEN_RECURSIVE YES)
    set(DOXYGEN_SHOW_HEADERFILE YES)
    set(DOXYGEN_SHOW_INCLUDE_FILES YES)

    # Configuration options related to the input files
    set(DOXYGEN_FILE_PATTERNS *.c* *.h* *.md)
    set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "${CMAKE_SOURCE_DIR}/README.md")

    # Configuration options related to source browsing
    set(DOXYGEN_INLINE_SOURCES YES)
    set(DOXYGEN_REFERENCED_BY_RELATION YES)
    set(DOXYGEN_REFERENCES_RELATION YES)

    # Configuration options related to the HTML output
    set(DOXYGEN_GENERATE_TREEVIEW YES)
    set(DOXYGEN_HTML_FORMULA_FORMAT png)
    set(DOXYGEN_USE_MATHJAX YES)
    set(DOXYGEN_MATHJAX_VERSION "MathJax_2")
    set(DOXYGEN_MATHJAX_FORMAT "HTML-CSS")
    set(DOXYGEN_DISABLE_INDEX NO)
    set(DOXYGEN_FULL_SIDEBAR NO)

    # Configuration options related to diagram generator tools
    set(DOXYGEN_HIDE_UNDOC_RELATIONS NO)
    set(DOXYGEN_HAVE_DOT YES)
    set(DOXYGEN_CLASS_GRAPH YES)
    set(DOXYGEN_COLLABORATION_GRAPH YES)
    set(DOXYGEN_GROUP_GRAPHS YES)
    set(DOXYGEN_UML_LOOK YES)
    set(DOXYGEN_UML_LIMIT_NUM_FIELDS 100)
    set(DOXYGEN_DOT_UML_DETAILS NO)
    set(DOXYGEN_DOT_WRAP_THRESHOLD 17)
    set(DOXYGEN_TEMPLATE_RELATIONS YES)
    set(DOXYGEN_INCLUDE_GRAPH YES)
    set(DOXYGEN_CALL_GRAPH YES)
    set(DOXYGEN_CALLER_GRAPH YES)
    set(DOXYGEN_DOT_IMAGE_FORMAT png)
    set(DOXYGEN_DOT_GRAPH_MAX_NODES 10000)
    set(DOXYGEN_MAX_DOT_GRAPH_DEPTH 1000)

    # Doxygen Awesome
    set(DOXYGEN_DOT_TRANSPARENT YES)
    set(DOXYGEN_HTML_EXTRA_STYLESHEET
        ${doxygen-awesome-css_SOURCE_DIR}/doxygen-awesome.css
        ${doxygen-awesome-css_SOURCE_DIR}/doxygen-awesome-sidebar-only-darkmode-toggle.css
    )
    set(DOXYGEN_HTML_COLORSTYLE LIGHT)

    set(DOXYGEN_STRIP_FROM_PATH "${CMAKE_SOURCE_DIR}")

  endmacro()

  set(DOXYGEN_GENERATE_HTML YES)
  set(DOXYGEN_HTML_OUTPUT ${PROJECT_SOURCE_DIR}/doc)

  UseDoxygenAwesomeCss()

  doxygen_add_docs(
    doxygen ${PROJECT_SOURCE_DIR}/header-only ${PROJECT_SOURCE_DIR}/include
    ${PROJECT_SOURCE_DIR}/app ${PROJECT_SOURCE_DIR}/src
    ${PROJECT_SOURCE_DIR}/README.md COMMENT "Generate HTML documentation"
  )

  # Show info where to find the documentation
  add_custom_command(
    TARGET doxygen
    POST_BUILD
    COMMAND ;
    COMMENT
      "${BoldMagenta}Open ${PROJECT_SOURCE_DIR}/doc/index.html in your browser to view the documentation.${ColourReset}"
  )
else()
  add_custom_target(
    doxygen
    COMMAND bash -c
            "echo ${Red}Please enable doxygen in config file.${ColourReset}"
  )
endif()
