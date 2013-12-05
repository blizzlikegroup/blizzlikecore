/*
 * This file is part of the BlizzLikeCore Project. See CREDITS and LICENSE files
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef BLIZZLIKE_DEFINE_H
#define BLIZZLIKE_DEFINE_H

#include <sys/types.h>

#include <ace/Basic_Types.h>
#include <ace/Default_Constants.h>
#include <ace/OS_NS_dlfcn.h>
#include <ace/ACE_export.h>

#include "Platform/CompilerDefs.h"

#define BLIZZLIKE_LITTLEENDIAN 0
#define BLIZZLIKE_BIGENDIAN    1

#if !defined(BLIZZLIKE_ENDIAN)
#  if defined (ACE_BIG_ENDIAN)
#    define BLIZZLIKE_ENDIAN BLIZZLIKE_BIGENDIAN
#  else // ACE_BYTE_ORDER != ACE_BIG_ENDIAN
#    define BLIZZLIKE_ENDIAN BLIZZLIKE_LITTLEENDIAN
#  endif // ACE_BYTE_ORDER
#endif // BLIZZLIKE_ENDIAN

typedef ACE_SHLIB_HANDLE BLIZZLIKE_LIBRARY_HANDLE;

#define BLIZZLIKE_SCRIPT_NAME "blizzlikescript"
#define BLIZZLIKE_SCRIPT_SUFFIX ACE_DLL_SUFFIX
#define BLIZZLIKE_SCRIPT_PREFIX ACE_DLL_PREFIX
#define BLIZZLIKE_LOAD_LIBRARY(libname)    ACE_OS::dlopen(libname)
#define BLIZZLIKE_CLOSE_LIBRARY(hlib)      ACE_OS::dlclose(hlib)
#define BLIZZLIKE_GET_PROC_ADDR(hlib,name) ACE_OS::dlsym(hlib,name)

#define BLIZZLIKE_PATH_MAX PATH_MAX                            // ace/os_include/os_limits.h -> ace/Basic_Types.h

#if PLATFORM == PLATFORM_WINDOWS
#  define BLIZZLIKE_EXPORT __declspec(dllexport)
#  define BLIZZLIKE_IMPORT __cdecl
#else // PLATFORM != PLATFORM_WINDOWS
#  define BLIZZLIKE_EXPORT export
#  if defined(__APPLE_CC__) && defined(BIG_ENDIAN)
#    define BLIZZLIKE_IMPORT __attribute__ ((longcall))
#  elif defined(__x86_64__)
#    define BLIZZLIKE_IMPORT
#  else
#    define BLIZZLIKE_IMPORT __attribute__ ((cdecl))
#  endif //__APPLE_CC__ && BIG_ENDIAN
#endif // PLATFORM

#if PLATFORM == PLATFORM_WINDOWS
#  ifdef BLIZZLIKE_WIN32_DLL_IMPORT
#    define BLIZZLIKE_DLL_DECL __declspec(dllimport)
#  else //!BLIZZLIKE_WIN32_DLL_IMPORT
#    ifdef BLIZZLIKE_WIND_DLL_EXPORT
#      define BLIZZLIKE_DLL_DECL __declspec(dllexport)
#    else //!BLIZZLIKE_WIND_DLL_EXPORT
#      define BLIZZLIKE_DLL_DECL
#    endif // BLIZZLIKE_WIND_DLL_EXPORT
#  endif // BLIZZLIKE_WIN32_DLL_IMPORT
#else // PLATFORM != PLATFORM_WINDOWS
#  define BLIZZLIKE_DLL_DECL
#endif // PLATFORM

#if PLATFORM == PLATFORM_WINDOWS
#  define BLIZZLIKE_DLL_SPEC __declspec(dllexport)
#  ifndef DECLSPEC_NORETURN
#    define DECLSPEC_NORETURN __declspec(noreturn)
#  endif // DECLSPEC_NORETURN
#else // PLATFORM != PLATFORM_WINDOWS
#  define BLIZZLIKE_DLL_SPEC
#  define DECLSPEC_NORETURN
#endif // PLATFORM

#if !defined(DEBUG)
#  define BLIZZLIKE_INLINE inline
#else // DEBUG
#  if !defined(BLIZZLIKE_DEBUG)
#    define BLIZZLIKE_DEBUG
#  endif // BLIZZLIKE_DEBUG
#  define BLIZZLIKE_INLINE
#endif //!DEBUG

#if COMPILER == COMPILER_GNU
#  define ATTR_NORETURN __attribute__((noreturn))
#  define ATTR_PRINTF(F,V) __attribute__ ((format (printf, F, V)))
#else // COMPILER != COMPILER_GNU
#  define ATTR_NORETURN
#  define ATTR_PRINTF(F,V)
#endif // COMPILER == COMPILER_GNU

typedef ACE_INT64 int64;
typedef ACE_INT32 int32;
typedef ACE_INT16 int16;
typedef ACE_INT8 int8;
typedef ACE_UINT64 uint64;
typedef ACE_UINT32 uint32;
typedef ACE_UINT16 uint16;
typedef ACE_UINT8 uint8;

#if COMPILER != COMPILER_MICROSOFT
typedef uint16      WORD;
typedef uint32      DWORD;
#endif // COMPILER

#define CONCAT(x, y) CONCAT1(x, y)
#define CONCAT1(x, y) x##y
#define STATIC_ASSERT_WORKAROUND(expr, msg) typedef char CONCAT(static_assert_failed_at_line_, __LINE__) [(expr) ? 1 : -1]

#if COMPILER == COMPILER_GNU
#  if !defined(__GXX_EXPERIMENTAL_CXX0X__) || (__GNUC__ < 4) || (__GNUC__ == 4) && (__GNUC_MINOR__ < 7)
#    define override
#    define static_assert(a, b) STATIC_ASSERT_WORKAROUND(a, b)
#  endif
#elif COMPILER == COMPILER_MICROSOFT
#  if _MSC_VER < 1600
#    define static_assert(a, b) STATIC_ASSERT_WORKAROUND(a, b)
#  endif
#endif

typedef uint64 OBJECT_HANDLE;

#endif // BLIZZLIKE_DEFINE_H
