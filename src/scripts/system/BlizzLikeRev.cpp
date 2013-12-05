/* This file is part of the BlizzLikeCore Project. See CREDITS and LICENSE files
* This program is free software licensed under GPL version 3
* Please see the included README file for more information */

#include "../../shared/revision_nr.h"

#ifdef WIN32
#   define BLIZZLIKE_DLL_EXPORT extern "C" __declspec(dllexport)
#elif defined( __GNUC__ )
#   define BLIZZLIKE_DLL_EXPORT extern "C"
#else
#   define BLIZZLIKE_DLL_EXPORT extern "C" export
#endif

BLIZZLIKE_DLL_EXPORT
char const* GetBlizzLikeRevStr()
{
    return REVISION_NR;
}
