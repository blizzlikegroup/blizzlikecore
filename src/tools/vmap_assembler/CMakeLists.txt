# This file is part of the BlizzLikeCore Project. See CREDITS and LICENSE files
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

set(CMAKE_VERBOSE_MAKEFILE true)

include_directories(
  ${CMAKE_SOURCE_DIR}/dep/include/g3dlite/
  ${CMAKE_SOURCE_DIR}/src/shared
  ${CMAKE_SOURCE_DIR}/src/game/vmap/
  ${CMAKE_SOURCE_DIR}/src/framework/
  ${CMAKE_SOURCE_DIR}/dep/src/zlib
)

if(WIN32)
  include_directories(
    ${CMAKE_SOURCE_DIR}/dep/ACE_wrappers/
  )
endif()

add_library(vmap
	${CMAKE_SOURCE_DIR}/src/game/vmap/BIH.cpp
	${CMAKE_SOURCE_DIR}/src/game/vmap/VMapManager2.cpp
	${CMAKE_SOURCE_DIR}/src/game/vmap/MapTree.cpp
	${CMAKE_SOURCE_DIR}/src/game/vmap/TileAssembler.cpp
	${CMAKE_SOURCE_DIR}/src/game/vmap/WorldModel.cpp
	${CMAKE_SOURCE_DIR}/src/game/vmap/ModelInstance.cpp
	)

add_definitions(-DNO_CORE_FUNCS)

if(WIN32)
  set(ZLIB_LIBRARIES "zlib")
elseif(UNIX)
  set(ZLIB_LIBRARIES "z")
endif()

add_executable(vmap_assembler vmap_assembler.cpp)
target_link_libraries(vmap_assembler vmap g3dlite ${ZLIB_LIBRARIES})

install(TARGETS vmap_assembler DESTINATION ${BIN_DIR}/tools)