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

## magic to include revision data in SD2 version string
# revision.h: FORCE
#   $(top_builddir)/src/tools/genrevision/genrevision $(srcdir)

file(GLOB_RECURSE blizzlikescript_SRCS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp *.h)

source_group("Other"
  REGULAR_EXPRESSION .*
)

foreach(SRC ${blizzlikescript_SRCS})
  get_filename_component(PTH ${SRC} PATH)
  if(PTH)
    if(NOT XCODE) # FIXME: Xcode Generator has bug with nested dirs
      string(REPLACE "/" "\\\\" PTH ${PTH})
    endif()
    source_group(${PTH} FILES ${SRC})
  endif()
endforeach(SRC)

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}/base
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  ${CMAKE_SOURCE_DIR}/src/shared
  ${CMAKE_SOURCE_DIR}/src/framework
  ${CMAKE_SOURCE_DIR}/src/game
  ${CMAKE_SOURCE_DIR}/dep/include
  ${CMAKE_SOURCE_DIR}/dep/include/g3dlite
  ${CMAKE_BINARY_DIR}
  ${ACE_INCLUDE_DIR}
  ${MYSQL_INCLUDE_DIR}
)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.in ${CMAKE_CURRENT_SOURCE_DIR}/config.h)

if(PCH)
  include_directories(
    ${CMAKE_CURRENT_BINARY_DIR}
  )
endif()

add_library(blizzlikescript SHARED
  ${blizzlikescript_SRCS}
)

if(WIN32)
  SET_TARGET_PROPERTIES(worldserver PROPERTIES
    ENABLE_EXPORTS TRUE)

  target_link_libraries(blizzlikescript
    worldserver
    ${ACE_LIBRARIES}
#    debug ${WIN_DEBUGLIBS}
  )
endif()

add_dependencies(blizzlikescript revision.h)
add_dependencies(blizzlikescript shared)

if(NOT ACE_USE_EXTERNAL)
  add_dependencies(blizzlikescript ACE)
endif()

if(UNIX)
  set(blizzlikescript_LINK_FLAGS "-pthread")
  if(APPLE)
    set(blizzlikescript_LINK_FLAGS "-framework Carbon ${blizzlikescript_LINK_FLAGS}")
    # Needed for the linking because of the missing symbols
    set(blizzlikescript_LINK_FLAGS "-Wl,-undefined -Wl,dynamic_lookup ${blizzlikescript_LINK_FLAGS}")
  endif()

  if(APPLE)
    set(blizzlikescript_PROPERTIES INSTALL_NAME_DIR "${LIBS_DIR}")
  else()
    set(blizzlikescript_PROPERTIES INSTALL_RPATH ${LIBS_DIR})
  endif()

  # Run out of build tree
  set(blizzlikescript_PROPERTIES
    ${blizzlikescript_PROPERTIES}
    BUILD_WITH_INSTALL_RPATH OFF
  )

  set_target_properties(blizzlikescript PROPERTIES
    LINK_FLAGS ${blizzlikescript_LINK_FLAGS}
    ${blizzlikescript_PROPERTIES}
  )
endif()

# Because size for linker is to big - seriously ?!
if(WIN32)
  set_target_properties(blizzlikescript PROPERTIES
      LINK_FLAGS_DEBUG "/DEBUG /INCREMENTAL:NO"
  )
endif()

## libtool settings
#  API versioning
#  Link against dependencies
#  How to increase version info:
#  - only bug fixes implemented:
#    bump the version to LTBLIZZLIKE_CURRENT:LTBLIZZLIKE_REVISION+1:LTBLIZZLIKE_AGE
#  - augmented the interface:
#    bump the version to LTBLIZZLIKE_CURRENT+1:0:LTBLIZZLIKE_AGE+1
#  - broken old interface:
#    bump the version to LTBLIZZLIKE_CURRENT+1:0:0
# set(LTBLIZZLIKE_CURRENT 0)
# set(LTBLIZZLIKE_REVISION 0)
# set(LTBLIZZLIKE_AGE 0)
# set_target_properties(script PROPERTIES LINK_FLAGS
#   "-version-info ${LTBLIZZLIKE_CURRENT}:${LTBLIZZLIKE_REVISION}:${LTBLIZZLIKE_AGE}"
# )

# Generate precompiled header
if(PCH)
  if(MSVC OR XCODE)
    if(MSVC)
      set(blizzlikescript_pch "${CMAKE_CURRENT_SOURCE_DIR}/include/precompiled.cpp")
    endif()
    add_native_precompiled_header(blizzlikescript ${CMAKE_CURRENT_SOURCE_DIR}/include/precompiled.h)
  elseif(CMAKE_COMPILER_IS_GNUCXX)
    add_precompiled_header(blizzlikescript ${CMAKE_CURRENT_SOURCE_DIR}/include/precompiled.h)
  endif()
endif()

# LIBRARY = dyld / so, RUNTIME = dll
install(TARGETS blizzlikescript
  LIBRARY DESTINATION ${LIBS_DIR}
  RUNTIME DESTINATION ${LIBS_DIR}
)

install(FILES scripts.conf.dist.in DESTINATION ${CONF_DIR} RENAME scripts.conf)

if(WIN32 AND CMAKE_RUNTIME_OUTPUT_DIRECTORY)
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/scripts.conf.dist.in ${CMAKE_INSTALL_PREFIX}/etc/scripts.conf)
endif()