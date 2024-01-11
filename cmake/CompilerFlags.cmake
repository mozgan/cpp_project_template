enable_language(CXX)

set(CMAKE_CXX_STANDARD ${P_CXX_VERSION})
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# enable output of compile commands during generation
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# strongly encouraged to enable this globally to avoid conflicts between
# -Wpedantic being enabled and -std=c++20 and -std=gnu++20 for example when
# compiling with PCH enabled.
set(CMAKE_CXX_EXTENSIONS OFF)

# === === === Compiler Flags === === === #

# === C++ Dialect === #
# https://gcc.gnu.org/onlinedocs/gcc/C_002b_002b-Dialect-Options.html

# Enable support for the C++ Concepts feature for constraining template
# arguments.
#[=[
if(P_CXX_VERSION GREATER_EQUAL 20 AND CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-fconcepts)
endif()

# Enable support for the C++ Coroutines extension
if(P_CXX_VERSION GREATER_EQUAL 20 AND CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-fcoroutines)
endif()
]=]

# Sets the limit for constexpr function invocations to N.
add_compile_options(-fconstexpr-depth=256)

# Make inline functions implicitly constexpr, if they satisfy the requirements
# for a constexpr function
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND CMAKE_CXX_COMPILER_VERSION
                                            GREATER_EQUAL 12
)
  add_compile_options(-fimplicit-constexpr)
endif()

# Enable generation of information about every class with virtual functions for
# use by the C++ run-time type identification features (dynamic_cast and typeid)
add_compile_options(-frtti)

# Enable C++14 sized global deallocation functions
add_compile_options(-fsized-deallocation)

# Enable optimizations based on the strict definition of an enum’s value range
add_compile_options(-fstrict-enums)

# Set the maximum depth of recursive template instantiation
add_compile_options(-ftemplate-depth=256)

# Warn about uses of a comma expression within a subscripting expression
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wcomma-subscript)
endif()

# Warn when performing class template argument deduction (CTAD) on a type with
# no explicitly written deduction guides
# add_compile_options(-Wctad-maybe-unsupported)

# Warn when a class seems unusable because all the constructors or destructors
# in that class are private, and it has neither friends nor public static member
# functions
add_compile_options(-Wctor-dtor-privacy)

# Warn when a reference is bound to a temporary whose lifetime has ended
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND CMAKE_CXX_COMPILER_VERSION
                                            GREATER_EQUAL 13
)
  add_compile_options(-Wdangling-reference)
endif()

# Warn when delete is used to destroy an instance of a class that has virtual
# functions and non-virtual destructor
add_compile_options(-Wdelete-non-virtual-dtor)

# Warn that the implicit declaration of a copy constructor or copy assignment
# operator is deprecated if the class has a user-provided copy constructor or
# copy assignment operator
add_compile_options(-Wdeprecated-copy)

# Warn when a function never produces a constant expression
if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  add_compile_options(-Winvalid-constexpr)
endif()

# Warn when a noexcept-expression evaluates to false because of a call to a
# function that does not have a non-throwing exception specification
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wnoexcept)
endif()

# Warn if the C++17 feature making noexcept part of a function type changes the
# mangled name of a symbol relative
add_compile_options(-Wnoexcept-type)

# Warn when the destination of a call to a raw memory function such as memset or
# memcpy is an object of class type, and when writing into such an object might
# bypass the class non-trivial or deleted constructor or copy assignment,
# violate const-correctness or encapsulation, or corrupt virtual table pointers
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wclass-memaccess)
endif()

# Warn when a class has virtual functions and an accessible non-virtual
# destructor itself or in an accessible polymorphic base class, in which case it
# is possible but unsafe to delete an instance of a derived class through a
# pointer to the class itself or base class
add_compile_options(-Wnon-virtual-dtor)

# Warn when the order of member initializers given in the code does not match
# the order in which they must be executed
add_compile_options(-Wreorder)

# This warning warns when a C++ range-based for-loop is creating an unnecessary
# copy
add_compile_options(-Wrange-loop-construct)

# Warn about redundant class-key and enum-key in references to class types and
# enumerated types in contexts where the key can be eliminated without causing
# an ambiguity
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wredundant-tags)
endif()

# Warn about violations of the style guidelines from Scott Meyers’ Effective C++
# series of books
add_compile_options(-Weffc++)

# Warn about the use of an uncasted NULL as sentinel
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wstrict-null-sentinel)
endif()

# Warn if an old-style (C-style) cast to a non-void type is used within a C++
# program
add_compile_options(-Wold-style-cast)

# Warn when a function declaration hides virtual functions from a base class
add_compile_options(-Woverloaded-virtual)

# Warn when overload resolution chooses a promotion from unsigned or enumerated
# type to a signed type, over a conversion to an unsigned type of the same size
add_compile_options(-Wsign-promo)

# Warn for mismatches between calls to operator new or operator delete and the
# corresponding call to the allocation or deallocation function
add_compile_options(-Wmismatched-new-delete)

# Warn for declarations of structs, classes, and class templates and their
# specializations with a class-key that does not match either the definition or
# the first declaration if no definition is provided
add_compile_options(-Wmismatched-tags)

# Warn about the most vexing parse syntactic ambiguity. This warns about the
# cases when a declaration looks like a variable definition, but the C++
# language requires it to be interpreted as a function declaration
add_compile_options(-Wno-vexing-parse)

# Warn when a literal ‘0’ is used as null pointer constant
add_compile_options(-Wzero-as-null-pointer-constant)

# Warn about placement new expressions with undefined behavior, such as
# constructing an object in a buffer that is smaller than the type of the object
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wplacement-new=2)
endif()

# Warn about redundant semicolons after in-class function definitions
add_compile_options(-Wextra-semi)

# This option controls warnings when a base class is inaccessible in a class
# derived from it due to ambiguity
add_compile_options(-Wno-inaccessible-base)

# Warn about a definition of an unsized deallocation function
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wsized-deallocation)
endif()

# Warn about types with virtual methods where code quality would be improved if
# the type were declared with the final specifier, or, if possible, declared in
# an anonymous namespace or with the final specifier
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wsuggest-final-types)
  add_compile_options(-Wsuggest-final-methods)
endif()

# Warn about overriding virtual functions that are not marked with the override
# keyword
add_compile_options(-Wsuggest-override)

# Warn when an expression is cast to its own type
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wuseless-cast)
endif()

# Warn for conversions between NULL and non-pointer types
add_compile_options(-Wconversion-null)

# === Diagnostic Messages Formatting === #
# https://gcc.gnu.org/onlinedocs/gcc/Diagnostic-Message-Formatting-Options.html

# Use color in diagnostics
add_compile_options(-fdiagnostics-color)

# Emit fix-it hints in a machine-parseable format
add_compile_options(-fdiagnostics-parseable-fixits)

# === Warning Options === #
# https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html

# Make all warnings into errors add_compile_options(-Werror)

# This option causes the compiler to abort compilation on the first error
# occurred rather than trying to keep going and printing further error messages
add_compile_options(-Wfatal-errors)

# Issue all the warnings demanded by strict ISO C and ISO C++; diagnose all
# programs that use forbidden extensions, and some other programs that do not
# follow ISO C and ISO C++
add_compile_options(-Wpedantic)
add_compile_options(-pedantic-errors)

# This enables all the warnings about constructions
add_compile_options(-Wall)

# This enables some extra warning flags that are not enabled by -Wall
add_compile_options(-Wextra)

# Warn if an array subscript has type char
add_compile_options(-Wchar-subscripts)

# Warn if the compiler detects paths that trigger erroneous or undefined
# behavior due to dereferencing a null pointer
add_compile_options(-Wnull-dereference)

# Give a warning when a value of type float is implicitly promoted to double
add_compile_options(-Wdouble-promotion)

# Warn on security issues around functions that format output (ie printf)
add_compile_options(-Wformat=2)

# Warn about infinitely recursive calls
if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  add_compile_options(-Winfinite-recursion)
endif()

# Warn about uninitialized variables that are initialized with themselves
add_compile_options(-Winit-self)

# Warn on statements that fallthrough without an explicit annotation
add_compile_options(-Wimplicit-fallthrough)

# Warn when the indentation of the code does not reflect the block structure
add_compile_options(-Wmisleading-indentation)

# Warn if a user-supplied include directory does not exist
add_compile_options(-Wmissing-include-dirs)

# Warn if left shifting a negative value
add_compile_options(-Wshift-negative-value)

# Warn whenever a switch statement has an index of enumerated type and lacks a
# case for one or more of the named codes of that enumeration
add_compile_options(-Wswitch)

# Warn whenever a switch statement does not have a default case
add_compile_options(-Wswitch-default)

# Warn whenever a switch statement has an index of enumerated type and lacks a
# case for one or more of the named codes of that enumeration
add_compile_options(-Wswitch-enum)

# All the -Wunused-* options combined
add_compile_options(-Wunused)

# All the above -Wunused options combined
add_compile_options(-Wuninitialized)

# Warn when an if-else has identical branches
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wduplicated-branches)
endif()

# Warn about duplicated conditions in an if-else-if chain
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wduplicated-cond)
endif()

# Warn about accesses to elements of zero-length array members that might
# overlap other members of the same object
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wzero-length-bounds)
endif()

# Warn if floating-point values are used in equality comparisons
add_compile_options(-Wfloat-equal)

# Warn whenever a local variable or type declaration shadows another variable,
# parameter, type, class member or whenever a built-in function is shadowed.
if(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  add_compile_options(-Wshadow-all)
else()
  add_compile_options(-Wshadow)
endif()

# Warn if the loop cannot be optimized because the compiler cannot assume
# anything on the bounds of the loop indices
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wunsafe-loop-optimizations)
endif()

# Warn if an undefined identifier is evaluated in an #if directive
add_compile_options(-Wundef)

# Warn whenever a pointer is cast so as to remove a type qualifier from the
# target type
add_compile_options(-Wcast-qual)

# Warn whenever a pointer is cast such that the required alignment of the target
# is increased
add_compile_options(-Wcast-align)

# Warn for implicit conversions that may alter a value
add_compile_options(-Wconversion)

# Warn for implicit conversions that may change the sign of an integer value,
# like assigning a signed integer expression to an unsigned integer variable
add_compile_options(-Wsign-conversion)

# Warn about suspicious uses of logical operators in expressions
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wlogical-op)
endif()

# Warn if any functions that return structures or unions are defined or called
# add_compile_options(-Waggregate-return)

# Warn if in a loop with constant number of iterations the compiler detects
# undefined behavior in some statement during one or more of the iterations
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  add_compile_options(-Wno-aggressive-loop-optimizations)
endif()

# Warn if a structure is given the packed attribute, but the packed attribute
# has no effect on the layout or size of the structure
add_compile_options(-Wpacked)

# Warn if padding is included in a structure, either to align an element of the
# structure or to align the whole structure add_compile_options(-Wpadded)

# Warn if anything is declared more than once in the same scope, even in cases
# where multiple declaration is valid and changes nothing
add_compile_options(-Wredundant-decls)

# Warn if a function that is declared as inline cannot be inlined
# add_compile_options(-Winline)

# Warn if a variable-length array is used in the code
add_compile_options(-Wvla)

# === Debugging Options === #
# https://gcc.gnu.org/onlinedocs/gcc/Debugging-Options.html

# set DWARF debugging format to version 4
if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  add_compile_options(-gdwarf-4)
endif()

# use -O0 for code coverage
if(ENABLE_CODE_COVERAGE AND CMAKE_BUILD_TYPE STREQUAL "Debug")
  add_compile_options(-O0)
  add_compile_options(--coverage)
  add_link_options("--coverage")
endif()

# === Control Optimization === #
# https://gcc.gnu.org/onlinedocs/gcc/Optimize-Options.html

# === Instrumentation Options === #
# https://gcc.gnu.org/onlinedocs/gcc/Instrumentation-Options.html

# === Controlling the Preprocessor === #
# https://gcc.gnu.org/onlinedocs/gcc/Preprocessor-Options.html

# === Assembler Options === #
# https://gcc.gnu.org/onlinedocs/gcc/Assembler-Options.html

# === Code Generation Conventions === #
# https://gcc.gnu.org/onlinedocs/gcc/Code-Gen-Options.html

# === Developer Options === #
# https://gcc.gnu.org/onlinedocs/gcc/Developer-Options.html
