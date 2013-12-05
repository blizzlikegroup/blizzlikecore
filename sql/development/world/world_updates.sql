ALTER TABLE db_version CHANGE COLUMN required_world_13_09_2013_12250317 required_world_13_09_2013_12250317 bit;

-- Vale Moth Fix
-- old `inhabitType` = '3'
UPDATE `creature_template` SET `inhabitType` = '4' WHERE `entry` = '16520';
-- Ember of Al'ar
-- old `inhabitType` = '3'
UPDATE `creature_template` SET `inhabitType` = '4' WHERE `entry` = '19551';

-- Go Silithyst Geyser
UPDATE `gameobject_template` SET `ScriptName` = 'go_silithyst_geyser' WHERE `entry` = '181598';
-- Help Account Create
UPDATE `command` SET help = 'Syntax: .account create $account $password [$expansion]\r\n\r\nCreate account and set password to it. Optionally, you may also set another expansion for this account than the defined default value.' WHERE name = 'account create';
-- NPC Netherspite Portal
UPDATE `creature_template` SET `ScriptName` = 'npc_netherspite_portal' WHERE `entry` IN (17367,17368,17369);

-- Update:Mission Gateways Murketh and Shaadraz (by ysfl <ysfllxcn@live.com>)
REPLACE INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (1929201, 19292, 8, 0, 100, 0, 33655, -1, 0, 0, 33, 19292, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Legion Transporter: Beta - Quest Credit on Dropping The Nether Modulator Spellhit (Quest: 10146)');
REPLACE INTO `creature_ai_scripts` (`id`, `creature_id`, `event_type`, `event_inverse_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action1_type`, `action1_param1`, `action1_param2`, `action1_param3`, `action2_type`, `action2_param1`, `action2_param2`, `action2_param3`, `action3_type`, `action3_param1`, `action3_param2`, `action3_param3`, `comment`) VALUES (1929101, 19291, 8, 0, 100, 0, 33655, -1, 0, 0, 33, 19291, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Legion Transporter: Alpha - Quest Credit on Dropping The Nether Modulator Spellhit (Quest: 10129)');
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = '19291';
UPDATE `creature_template` SET `AIName`='EventAI' WHERE `entry` = '19292';
-- Repair_Quest_GUID_9723_NPC
UPDATE `creature_template` SET `minlevel` = '60', `maxlevel` = '60', `maxhealth` = '3451', `maxmana` = '2475' WHERE `entry` = '25223';

-- Fix some errors (by Vstar <vstar0v0@hotmail.com>)
UPDATE `creature_template_addon` SET `auras` = '1787 18950' WHERE `entry` = '16164';

-- Update: Our Boy Wants To Be A Skyguard Ranger (by ysfl <ysfllxcn@live.com>)
UPDATE `gameobject_template` SET `ScriptName`='go_fel_crystalforge' WHERE `entry` = '185919';

-- UpdateRewardQuest: Blood of the Warlord (by ysfl <ysfllxcn@live.com>)
UPDATE `quest_template` SET `RewItemId1` = '29434', `RewItemCount1` = '10', `RewOrReqMoney` = '132000', `RewMoneyMaxLevel` = '114000' WHERE  `entry` = '11178';
UPDATE `creature_template` SET `faction_A` = '14', `faction_H` = '14' WHERE `entry` = '22920';
UPDATE `creature_template` SET `faction_A` = '14', `faction_H` = '14' WHERE `entry` = '22826';
UPDATE `creature_template` SET `faction_A` = '14', `faction_H` = '14' WHERE `entry` = '22930';
UPDATE `item_template` SET `class` = '12', `delay` = '0' WHERE `entry` = '10515';

-- Update Movement: Alliance Rifleman 
DELETE FROM `creature_movement` WHERE `id` = '51475';
UPDATE `creature` SET `spawnDist` = '5', `MovementType` = '1' WHERE `guid` = '51475';

-- Update Movement: Mmmrrrggglll
SET @GUID := 41792;
SET @PATH := 41792;
-- Set creature location
UPDATE `creature` SET `MovementType` = '2', `position_x` = '8869.872', `position_y` = '-5775.960', `position_z` = '0.405', `spawnDist` = '0', `currentwaypoint` = '1' WHERE `guid` = @GUID;
-- Creature Movement Data
DELETE FROM `creature_movement` WHERE `id` = @PATH;
INSERT INTO `creature_movement` (`id`,`point`,`position_x`,`position_y`,`position_z`,`waittime`) VALUES
(@PATH, 1, 8880.688, -5754.608, 0.25531, 0),
(@PATH, 2, 8873.341, -5735.012, 0.43308, 0),
(@PATH, 3, 8862.790, -5722.625, 0.42263, 0),
(@PATH, 4, 8846.429, -5720.661, 0.49396, 0),
(@PATH, 5, 8836.920, -5726.737, 0.83736, 0),
(@PATH, 6, 8828.789, -5743.622, 0.82590, 0),
(@PATH, 7, 8818.041, -5755.890, 0.64673, 0),
(@PATH, 8, 8804.548, -5762.792, 0.51199, 0),
(@PATH, 9, 8791.789, -5762.271, 0.45083, 0),
(@PATH, 10, 8777.225, -5753.970, 0.55571, 0),
(@PATH, 11, 8776.860, -5738.229, 0.61609, 0),
(@PATH, 12, 8785.234, -5722.790, 0.75764, 0),
(@PATH, 13, 8786.402, -5701.790, 0.67103, 0),
(@PATH, 14, 8771.277, -5696.080, 0.67596, 0),
(@PATH, 15, 8758.604, -5694.220, 0.55669, 0),
(@PATH, 16, 8746.010, -5704.514, 0.50786, 0),
(@PATH, 17, 8735.815, -5722.942, 0.94607, 0),
(@PATH, 18, 8720.269, -5730.856, 0.89406, 0),
(@PATH, 19, 8706.965, -5730.076, 0.77437, 0),
(@PATH, 20, 8693.575, -5720.971, 0.86999, 0),
(@PATH, 21, 8679.183, -5710.540, 1.10842, 0),
(@PATH, 22, 8656.022, -5704.337, 1.80973, 0),
(@PATH, 23, 8640.976, -5691.507, 0.47690, 0),
(@PATH, 24, 8635.418, -5689.706, 0.53144, 0),
(@PATH, 25, 8620.438, -5687.679, 0.86486, 0),
(@PATH, 26, 8601.687, -5688.443, 0.49338, 36000),
(@PATH, 27, 8619.985, -5679.970, 0.75128, 0),
(@PATH, 28, 8635.668, -5671.577, 0.53144, 0),
(@PATH, 29, 8648.297, -5670.150, 0.49488, 0),
(@PATH, 30, 8664.989, -5679.421, 0.55752, 0),
(@PATH, 31, 8679.183, -5710.540, 1.10842, 0),
(@PATH, 32, 8693.575, -5720.971, 0.86999, 0),
(@PATH, 33, 8706.965, -5730.076, 0.77437, 0),
(@PATH, 34, 8721.716, -5745.012, 0.62278, 0),
(@PATH, 35, 8735.529, -5753.923, 1.24721, 0),
(@PATH, 36, 8767.193, -5758.179, 0.50536, 0),
(@PATH, 37, 8791.789, -5762.271, 0.45083, 0),
(@PATH, 38, 8804.548, -5762.792, 0.51199, 0),
(@PATH, 39, 8818.041, -5755.890, 0.64673, 0),
(@PATH, 40, 8828.789, -5743.622, 0.82590, 0),
(@PATH, 41, 8836.920, -5726.737, 0.83736, 0),
(@PATH, 42, 8846.429, -5720.661, 0.49396, 0),
(@PATH, 43, 8873.341, -5735.012, 0.43308, 0),
(@PATH, 44, 8880.688, -5754.608, 0.25531, 60000);