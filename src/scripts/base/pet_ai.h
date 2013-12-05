/* This file is part of the BlizzLikeCore Project. See CREDITS and LICENSE files
 * This program is free software licensed under GPL version 3
 * Please see the included README file for more information */

#ifndef SC_PET_H
#define SC_PET_H

// Using CreatureAI for now. Might change later and use PetAI (need to export for dll first)
class BLIZZLIKE_DLL_DECL ScriptedPetAI : public CreatureAI
{
    public:
        explicit ScriptedPetAI(Creature* pCreature);
        ~ScriptedPetAI() {}

        void MoveInLineOfSight(Unit* /*pWho*/) override;

        void AttackStart(Unit* /*pWho*/) override;

        void AttackedBy(Unit* /*pAttacker*/) override;

        bool IsVisible(Unit* /*pWho*/) const override;

        void KilledUnit(Unit* /*pVictim*/) override {}

        void OwnerKilledUnit(Unit* /*pVictim*/) override {}

        void UpdateAI(const uint32 uiDiff) override;

        virtual void Reset() {}

        virtual void UpdatePetAI(const uint32 uiDiff);      // while in combat

        virtual void UpdatePetOOCAI(const uint32 /*uiDiff*/) {} // when not in combat

    protected:
        void ResetPetCombat();
};

#endif
