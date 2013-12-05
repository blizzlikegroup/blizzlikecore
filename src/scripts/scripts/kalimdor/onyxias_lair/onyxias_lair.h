/* This file is part of the BlizzLikeCore Project. See CREDITS and LICENSE files
 * This program is free software licensed under GPL version 3
 * Please see the included README file for more information */

#ifndef DEF_ONYXIA_H
#define DEF_ONYXIA_H

enum
{
    TYPE_ONYXIA                 = 0,

    // Special data fields for Onyxia
    DATA_LIFTOFF                = 4,

    NPC_ONYXIA_WHELP            = 11262,
    NPC_ONYXIA_TRIGGER          = 12758,
};

class BLIZZLIKE_DLL_DECL instance_onyxias_lair : public ScriptedInstance
{
    public:
        instance_onyxias_lair(Map* pMap);
        ~instance_onyxias_lair() {}

        void Initialize() override;

        bool IsEncounterInProgress() const override;

        void OnCreatureCreate(Creature* pCreature) override;

        void SetData(uint32 uiType, uint32 uiData) override;

    protected:
        uint32 m_uiEncounter;

        time_t m_tPhaseTwoStart;
};

#endif
