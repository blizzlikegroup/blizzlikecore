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

#ifndef BLIZZLIKE_NULLCREATUREAI_H
#define BLIZZLIKE_NULLCREATUREAI_H

#include "CreatureAI.h"

class BLIZZLIKE_DLL_DECL NullCreatureAI : public CreatureAI
{
    public:

        explicit NullCreatureAI(Creature* c) : CreatureAI(c) {}
        ~NullCreatureAI();

        void MoveInLineOfSight(Unit*) override {}
        void AttackStart(Unit*) override {}
        void AttackedBy(Unit*) override {}
        void EnterEvadeMode() override {}

        bool IsVisible(Unit*) const override { return false;  }

        void UpdateAI(const uint32) override {}
        static int Permissible(const Creature*) { return PERMIT_BASE_IDLE;  }
};
#endif
