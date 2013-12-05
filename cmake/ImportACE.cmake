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

if(NOT ACE_USE_EXTERNAL)
  set(ACE_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/dep/ACE_wrappers)
  set(ACE_LIBRARIES_DIR ${CMAKE_SOURCE_DIR}/Libraries)
  set(ACE_LIBRARIES ACE)
else()
  set(ACE_INCLUDE_DIR ${CMAKE_INSTALL_PREFIX}/include)
  set(ACE_LIBRARIES_DIR ${CMAKE_INSTALL_PREFIX}/lib)
  set(ACE_LIBRARIES ACE)
endif()

link_directories(
  ${ACE_LIBRARIES_DIR}
)

set(HAVE_ACE_STACK_TRACE_H ON) # config.h.cmake