# This file is part of the BlizzLikeCore Project. See CREDITS and LICENSE files
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

if(CMAKE_COMPILER_IS_GNUCXX)
  add_definitions(--no-warnings)
elseif(MSVC)
  add_definitions(/W0)
endif()

add_subdirectory (libmpq)
add_subdirectory (loadlib)

include_directories (${CMAKE_CURRENT_SOURCE_DIR}/libmpq)
include_directories (${CMAKE_CURRENT_SOURCE_DIR}/loadlib)

link_directories (${CMAKE_CURRENT_SOURCE_DIR}/libmpq)
link_directories (${CMAKE_CURRENT_SOURCE_DIR}/loadlib)

add_executable (ad dbcfile.cpp mpq_libmpq.cpp System.cpp)

target_link_libraries (ad libmpq)
target_link_libraries (ad loadlib)

install(TARGETS ad DESTINATION ${BIN_DIR}/tools)
