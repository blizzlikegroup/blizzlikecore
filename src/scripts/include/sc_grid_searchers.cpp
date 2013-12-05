/* This file is part of the BlizzLikeCore Project. See CREDITS and LICENSE files
 * This program is free software licensed under GPL version 3
 * Please see the included README file for more information */

#include "precompiled.h"

#include "Cell.h"
#include "CellImpl.h"
#include "GridNotifiers.h"
#include "GridNotifiersImpl.h"

// return closest GO in grid, with range from pSource
GameObject* GetClosestGameObjectWithEntry(WorldObject* pSource, uint32 uiEntry, float fMaxSearchRange)
{
    GameObject* pGo = NULL;

    BlizzLike::NearestGameObjectEntryInObjectRangeCheck go_check(*pSource, uiEntry, fMaxSearchRange);
    BlizzLike::GameObjectLastSearcher<BlizzLike::NearestGameObjectEntryInObjectRangeCheck> searcher(pGo, go_check);

    Cell::VisitGridObjects(pSource, searcher, fMaxSearchRange);

    return pGo;
}

// return closest creature alive in grid, with range from pSource
Creature* GetClosestCreatureWithEntry(WorldObject* pSource, uint32 uiEntry, float fMaxSearchRange, bool bOnlyAlive/*=true*/, bool bOnlyDead/*=false*/)
{
    Creature* pCreature = NULL;

    BlizzLike::NearestCreatureEntryWithLiveStateInObjectRangeCheck creature_check(*pSource, uiEntry, bOnlyAlive, bOnlyDead, fMaxSearchRange);
    BlizzLike::CreatureLastSearcher<BlizzLike::NearestCreatureEntryWithLiveStateInObjectRangeCheck> searcher(pCreature, creature_check);

    Cell::VisitGridObjects(pSource, searcher, fMaxSearchRange);

    return pCreature;
}

void GetGameObjectListWithEntryInGrid(std::list<GameObject*>& lList , WorldObject* pSource, uint32 uiEntry, float fMaxSearchRange)
{
    BlizzLike::GameObjectEntryInPosRangeCheck check(*pSource, uiEntry, pSource->GetPositionX(), pSource->GetPositionY(), pSource->GetPositionZ(), fMaxSearchRange);
    BlizzLike::GameObjectListSearcher<BlizzLike::GameObjectEntryInPosRangeCheck> searcher(lList, check);

    Cell::VisitGridObjects(pSource, searcher, fMaxSearchRange);
}

void GetCreatureListWithEntryInGrid(std::list<Creature*>& lList, WorldObject* pSource, uint32 uiEntry, float fMaxSearchRange)
{
    BlizzLike::AllCreaturesOfEntryInRangeCheck check(pSource, uiEntry, fMaxSearchRange);
    BlizzLike::CreatureListSearcher<BlizzLike::AllCreaturesOfEntryInRangeCheck> searcher(lList, check);

    Cell::VisitGridObjects(pSource, searcher, fMaxSearchRange);
}
