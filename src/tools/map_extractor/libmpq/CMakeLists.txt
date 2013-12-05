# This file is part of the BlizzLikeCore Project. See CREDITS and LICENSE files
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

include_directories (
  ${CMAKE_SOURCE_DIR}/dep/src/zlib
)

if(WIN32)
  set(ZLIB_LIBRARIES "zlib")
elseif(UNIX)
  set(ZLIB_LIBRARIES "z")
endif()

add_library (libmpq common.cpp  explode.cpp  extract.cpp  huffman.cpp  mpq.cpp  parser.cpp  wave.cpp )
# link libmpq with zlib
target_link_libraries (libmpq ${ZLIB_LIBRARIES})
