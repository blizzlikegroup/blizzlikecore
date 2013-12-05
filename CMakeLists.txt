#
# This file is part of the BlizzLikeCore Project. See CREDITS and LICENSE files
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#

cmake_minimum_required(VERSION 2.8)

if(WIN32 AND NOT CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/server" CACHE INTERNAL "")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_INSTALL_PREFIX}" CACHE INTERNAL "")
endif()

project(BlizzLikeCore)
set(BLIZZLIKE_VERSION TBC)

set(CMAKE_MODULE_PATH
  ${CMAKE_MODULE_PATH}
  ${CMAKE_SOURCE_DIR}/cmake
)

# Output description of this script
message(
  "\nThis script builds the BlizzLikeCore server.
  To set an option simply type -D<OPTION>=<VALUE> after 'cmake <srcs>'.
  For example: cmake ../blizzlikecore/ -DPREFIX=/home/<username>/server -DTOOLS=1\n"
)

# Force out-of-source build
if(${CMAKE_SOURCE_DIR} STREQUAL ${CMAKE_BINARY_DIR})
  message(FATAL_ERROR
    "This project requires an out of source build. Remove the file 'CMakeCache.txt' found in this directory before continuing, create a separate build directory and run 'cmake [options] <srcs>' from there."
  )
endif()

if(WIN32 AND NOT MSVC)
  message(FATAL_ERROR
    "Under Windows other compiler than Microsoft Visual Studio are not supported."
  )
endif()

# Set installation prefix
if(PREFIX)
  set(CMAKE_INSTALL_PREFIX "${PREFIX}")
endif()

# TODO: use MSVC_CXX_ARCHITECTURE_ID instead to identify platform on windows (not required on other systems)
# Find platform: required to build 3rd party libraries w/o CMake files
find_package(Platform REQUIRED)

# Find out what system we use to include the needed libs
if(WIN32)
  if(PLATFORM MATCHES X86) # 32-bit
    set(DEP_ARCH win32)
  else() # 64-bit
    set(DEP_ARCH x64)
  endif()
endif()

# Find Git: used to get the revision number
find_package(Git)

# Check if the platform supports precomiled headers
find_package(PCHSupport)

# Options for compile of BlizzLikeCore
option(DEBUG "Debug mode" 0)
if(WIN32)
  set(ACE_USE_EXTERNAL 0)
else()
  set(ACE_USE_EXTERNAL 1)
endif()
# Option(CLI "With CLI" 1) # Not used by BlizzLikeCore so far
# Option(RA "With Remote Access" 0) # TODO: support remote access
option(SCRIPTS "Build scripts" 1)
option(TOOLS "Build tools" 0)
# Option(SQL "Copy SQL files" 0)
option(PCH "Use precompiled headers" 1)

if(NOT ACE_USE_EXTERNAL)
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/Libraries" CACHE INTERNAL "")
endif()

# Config DIR
set(BIN_DIR ${CMAKE_INSTALL_PREFIX}/bin)
set(CONF_DIR ${CMAKE_INSTALL_PREFIX}/etc)
# If win32 put it in the bin dir not lib
if(WIN32)
  set(LIBS_DIR ${CMAKE_INSTALL_PREFIX}/bin)
else()
  set(LIBS_DIR ${CMAKE_INSTALL_PREFIX}/lib)
endif()

# For Unix systems set the rpath so that libraries are found
set(CMAKE_INSTALL_RPATH ${LIBS_DIR})
set(CMAKE_INSTALL_NAME_DIR ${LIBS_DIR})
# Run out of build tree
set(CMAKE_BUILD_WITH_INSTALL_RPATH OFF)

# Find needed packages and if necessery abort if something important is missing
unset(ACE_INCLUDE_DIR CACHE)
unset(ACE_LIBRARIES CACHE)
unset(ACE_LIBRARIES_DIR CACHE)
unset(ACE_INCLUDE_DIR)
unset(ACE_LIBRARIES)
unset(ACE_LIBRARIES_DIR)
if(ACE_USE_EXTERNAL)
  find_package(ACE)
  if(NOT ACE_FOUND)
    message(FATAL_ERROR
      "This project requires ACE installed when ACE_USE_EXTERNAL is set. Please download the ACE Micro Release Kit from http://download.dre.vanderbilt.edu/ and install it. If this script didn't find ACE and it was correctly installed please set ACE_ROOT to the correct path."
    )
  endif()
  if(EXISTS ${ACE_INCLUDE_DIR}/ace/Stack_Trace.h)
    set(HAVE_ACE_STACK_TRACE_H ON) # config.h.cmake
  endif()
else()
  include(cmake/ImportACE.cmake)
endif()

# Win32 delivered packages
if(WIN32)
  set(MYSQL_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/dep/include/mysql)
  set(MYSQL_LIBRARY ${CMAKE_SOURCE_DIR}/dep/lib/${DEP_ARCH}_release/libmySQL.lib)
  set(MYSQL_DEBUG_LIBRARY ${CMAKE_SOURCE_DIR}/dep/lib/${DEP_ARCH}_debug/libmySQL.lib)
  set(OPENSSL_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/dep/include/openssl)
  set(OPENSSL_LIBRARIES ${CMAKE_SOURCE_DIR}/dep/lib/${DEP_ARCH}_release/libeay32.lib)
  set(OPENSSL_DEBUG_LIBRARIES ${CMAKE_SOURCE_DIR}/dep/lib/${DEP_ARCH}_debug/libeay32.lib)
  # zlib is build
endif()

# *nix-specific packages
if(UNIX)
  find_package(MySQL REQUIRED)
  find_package(OpenSSL REQUIRED)
  find_package(ZLIB REQUIRED)
endif()

# Add uninstall script and target
configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/cmake_uninstall.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
  IMMEDIATE @ONLY
)

add_custom_target(uninstall
  "${CMAKE_COMMAND}" -P "${CMAKE_CURRENT_BINARY_DIR}/cmake_uninstall.cmake"
)

# Handle debugmode compiles (this will require further work for proper WIN32-setups)
if(UNIX)
  set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -g")
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -g")
endif()

# Set warning levels for different builds
if(UNIX)
  set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} --no-warnings")
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} --no-warnings")
  set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -Wall -Wfatal-errors")
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Wall -Wfatal-errors")
elseif(WIN32)
  # Disable warnings in Visual Studio and add /MP /Zm1000 /bigobj
  if(MSVC AND NOT CMAKE_GENERATOR MATCHES "Visual Studio 7")
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /wd4996 /wd4355 /wd4244 /wd4985 /wd4267 /MP /Zm1000")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /wd4996 /wd4355 /wd4244 /wd4267 /MP /Zm1000")
    set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} /wd4996 /wd4355 /wd4244 /wd4985 /wd4267 /MP /Zm1000 /bigobj")
    set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /wd4996 /wd4355 /wd4244 /wd4985 /wd4267 /MP /Zm1000 /bigobj")
  endif()
endif()

if(PCH AND NOT PCHSupport_FOUND)
  set(PCH 0 CACHE BOOL
    "Use precompiled headers"
    FORCE)
  message(
    "No PCH for your system possible but PCH was set to 1. Resetting it."
  )
endif()

# Find core revision
if(GIT_EXECUTABLE)
  execute_process(
    COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    OUTPUT_VARIABLE GIT_REVISION
    RESULT_VARIABLE GIT_RESULT
    ERROR_QUIET
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )
  if(GIT_RESULT)
    set(GIT_REVISION "Git repository not found")
  endif()
else()
  set(GIT_REVISION "Git not found")
endif()

message("")
message("BlizzLikeCore revision : ${GIT_REVISION}")
message("Install server to      : ${CMAKE_INSTALL_PREFIX}")
message("")

# if(CLI)
#   message("Build with CLI        : Yes (default)")
#   add_definitions(-DENABLE_CLI)
# else()
#   message("Build with CLI        : No")
# endif()

# if(RA)
#   message("* Build with RA         : Yes")
#   add_definitions(-DENABLE_RA)
# else(RA)
#   message("* Build with RA         : No  (default)")
# endif(RA)

if(WIN32)
  if(ACE_USE_EXTERNAL)
    message("Use Ace External      : Yes")
  else()
    message("Use Ace External      : No  (default)")
  endif()
else()
  if(ACE_USE_EXTERNAL)
    message("Use Ace External      : Yes (default)")
  else()
    message("Use Ace External      : No")
  endif()
endif()

if(DEBUG)
  message("Debug Mode            : Yes")
  set(CMAKE_CONFIGURATION_TYPES Debug)
  set(CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}" CACHE STRING "" FORCE)
  set(CMAKE_BUILD_TYPE Debug)
else()
  set(CMAKE_CONFIGURATION_TYPES Release)
  set(CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}" CACHE STRING "" FORCE)
  set(CMAKE_BUILD_TYPE Release)
  message("Debug Mode            : No  (default)")
endif()

if(PCH)
  message("Use PCH               : Yes (default)")
else()
  message("Use PCH               : No")
endif()

if(SCRIPTS)
  message("Scripts SD2           : Yes (default)")
else()
  message("Scripts SD2           : No")
endif()

if(TOOLS)
  message("Tools map/vmap/mmaps  : Yes")
else()
  message("Tools map/vmap/mmaps  : No  (default)")
endif()

# if(SQL)
#   message("Install SQL-files     : Yes")
# else()
#   message("Install SQL-files     : No  (default)")
# endif()

message("")

# Some small tweaks for Visual Studio 7 and above.
if(MSVC)
  # Mark 32 bit executables large address aware so they can use > 2GB address space
  if(PLATFORM MATCHES X86)
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} /LARGEADDRESSAWARE")
  endif()
endif()

set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH TRUE)
set(CMAKE_INSTALL_RPATH ${LIBS_DIR})
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

# Generate revision-extractor
set(GENREV_SRC
  src/tools/genrevision/genrevision.cpp
)

add_executable(genrev
  ${GENREV_SRC}
)

get_target_property(GENERATE_EXE genrev LOCATION)
add_custom_target("revision.h" ALL
  COMMAND ${GENERATE_EXE} ${CMAKE_SOURCE_DIR}
  WORKING_DIRECTORY "${CMAKE_BINARY_DIR}"
  DEPENDS genrev
)

if(WIN32)
  install(
    FILES
      ${CMAKE_SOURCE_DIR}/dep/lib/${DEP_ARCH}_release/libeay32.dll
      ${CMAKE_SOURCE_DIR}/dep/lib/${DEP_ARCH}_release/libmySQL.dll
    DESTINATION ${LIBS_DIR}
    CONFIGURATIONS Release
  )
  install(
    FILES
      ${CMAKE_SOURCE_DIR}/dep/lib/${DEP_ARCH}_debug/libeay32.dll
      ${CMAKE_SOURCE_DIR}/dep/lib/${DEP_ARCH}_debug/libmySQL.dll
    DESTINATION ${LIBS_DIR}
    CONFIGURATIONS Debug
  )
  if(PLATFORM MATCHES X86)
    # Copy dll's Windows needs
    install(
      FILES
        ${CMAKE_SOURCE_DIR}/dep/lib/win32_release/dbghelp.dll
      DESTINATION ${LIBS_DIR}
      CONFIGURATIONS Release
    )
    install(
      FILES
        ${CMAKE_SOURCE_DIR}/dep/lib/win32_debug/dbghelp.dll
      DESTINATION ${LIBS_DIR}
      CONFIGURATIONS Debug
    )
  endif()
endif()

if(XCODE)
  if(PLATFORM MATCHES X86)
    set(CMAKE_OSX_ARCHITECTURES i386)
  else()
    set(CMAKE_OSX_ARCHITECTURES x86_64)
  endif()
endif()

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake ${CMAKE_CURRENT_BINARY_DIR}/config.h)

add_subdirectory(dep) # TODO: add vmap extractor build support

# Add definitions for all build types
# Don't place this above 'dep' subdirectory! Because of defines build will crash.
set(DEFINITIONS
  DO_MYSQL
  HAVE_CONFIG_H
  VERSION="${BLIZZLIKE_VERSION}"
)
if(WIN32)
  set(DEFINITIONS ${DEFINITIONS} SYSCONFDIR="../etc/")
else()
  set(DEFINITIONS ${DEFINITIONS} SYSCONFDIR="${CONF_DIR}/")
endif()
set(DEFINITIONS_RELEASE NDEBUG)
set(DEFINITIONS_DEBUG _DEBUG BLIZZLIKE_DEBUG)
if(WIN32)
  set(DEFINITIONS ${DEFINITIONS} WIN32 _WIN32)
  set(DEFINITIONS_RELEASE ${DEFINITIONS_RELEASE} _CRT_SECURE_NO_WARNINGS)
endif()

set_directory_properties(PROPERTIES COMPILE_DEFINITIONS "${DEFINITIONS}")
set_directory_properties(PROPERTIES COMPILE_DEFINITIONS_RELEASE "${DEFINITIONS_RELEASE}")
set_directory_properties(PROPERTIES COMPILE_DEFINITIONS_DEBUG "${DEFINITIONS_DEBUG}")

add_subdirectory(src)

# if(SQL)
#   add_subdirectory(sql)
# endif()
