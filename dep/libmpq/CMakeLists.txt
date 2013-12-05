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

file(GLOB sources_mpq libmpq/*.c libmpq/*.h)

set(mpq_STAT_SRCS
  ${sources_mpq}
)

if(UNIX)
  include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_SOURCE_DIR}/dep/src/zlib
    ${CMAKE_SOURCE_DIR}/dep/src/bzip2
  )
elseif(WIN32)
  include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/win
    ${CMAKE_SOURCE_DIR}/dep/src/zlib
    ${CMAKE_SOURCE_DIR}/dep/src/bzip2
  )
endif()

add_library(mpq STATIC ${mpq_STAT_SRCS})

set_target_properties(mpq PROPERTIES LINKER_LANGUAGE CXX)
