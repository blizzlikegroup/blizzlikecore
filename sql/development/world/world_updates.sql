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

-- Netherspite Infernal
UPDATE `creature_template` SET `faction_A` = '114', `faction_H` = '114', `ScriptName` = 'netherspite_infernal' WHERE `entry` = '17646';

-- Heroic mode loot increases
UPDATE `creature_template` SET `lootid` = '18495' WHERE `entry` = '20302';
UPDATE `creature_template` SET `lootid` = '18497' WHERE `entry` = '20299';
UPDATE `creature_template` SET `lootid` = '24777' WHERE `entry` = '25571';
UPDATE `creature_template` SET `lootid` = '24777' WHERE `entry` = '25571';
UPDATE `creature_template` SET `lootid` = '24698' WHERE `entry` = '25551';
UPDATE `creature_template` SET `lootid` = '24696' WHERE `entry` = '25547';
UPDATE `creature_template` SET `lootid` = '24689' WHERE `entry` = '25575';
UPDATE `creature_template` SET `lootid` = '24684' WHERE `entry` = '25565';
UPDATE `creature_template` SET `lootid` = '22128' WHERE `entry` = '22129';
UPDATE `creature_template` SET `lootid` = '21904' WHERE `entry` = '21990';
UPDATE `creature_template` SET `lootid` = '21891' WHERE `entry` = '21989';
UPDATE `creature_template` SET `lootid` = '21702' WHERE `entry` = '22346';
UPDATE `creature_template` SET `lootid` = '21696' WHERE `entry` = '21916';
UPDATE `creature_template` SET `lootid` = '21695' WHERE `entry` = '21917';
UPDATE `creature_template` SET `lootid` = '21694' WHERE `entry` = '21914';
UPDATE `creature_template` SET `lootid` = '21338' WHERE `entry` = '21915';
UPDATE `creature_template` SET `lootid` = '21127' WHERE `entry` = '21843';
UPDATE `creature_template` SET `lootid` = '21126' WHERE `entry` = '21842';
UPDATE `creature_template` SET `lootid` = '21104' WHERE `entry` = '22170';
UPDATE `creature_template` SET `lootid` = '20990' WHERE `entry` = '21523';
UPDATE `creature_template` SET `lootid` = '20988' WHERE `entry` = '21540';
UPDATE `creature_template` SET `lootid` = '20911' WHERE `entry` = '21588';
UPDATE `creature_template` SET `lootid` = '20910' WHERE `entry` = '21618';
UPDATE `creature_template` SET `lootid` = '20909' WHERE `entry` = '21616';
UPDATE `creature_template` SET `lootid` = '20908' WHERE `entry` = '21617';
UPDATE `creature_template` SET `lootid` = '20906' WHERE `entry` = '21606';
UPDATE `creature_template` SET `lootid` = '20905' WHERE `entry` = '21589';
UPDATE `creature_template` SET `lootid` = '20902' WHERE `entry` = '21611';
UPDATE `creature_template` SET `lootid` = '20901' WHERE `entry` = '21610';
UPDATE `creature_template` SET `lootid` = '20900' WHERE `entry` = '21621';
UPDATE `creature_template` SET `lootid` = '20898' WHERE `entry` = '21598';
UPDATE `creature_template` SET `lootid` = '20897' WHERE `entry` = '21597';
UPDATE `creature_template` SET `lootid` = '20896' WHERE `entry` = '21596';
UPDATE `creature_template` SET `lootid` = '20883' WHERE `entry` = '21615';
UPDATE `creature_template` SET `lootid` = '20882' WHERE `entry` = '21613';
UPDATE `creature_template` SET `lootid` = '20881' WHERE `entry` = '21619';
UPDATE `creature_template` SET `lootid` = '20880' WHERE `entry` = '21594';
UPDATE `creature_template` SET `lootid` = '20879' WHERE `entry` = '21595';
UPDATE `creature_template` SET `lootid` = '20875' WHERE `entry` = '21604';
UPDATE `creature_template` SET `lootid` = '20873' WHERE `entry` = '21605';
UPDATE `creature_template` SET `lootid` = '20869' WHERE `entry` = '21586';
UPDATE `creature_template` SET `lootid` = '20868' WHERE `entry` = '21593';
UPDATE `creature_template` SET `lootid` = '20867' WHERE `entry` = '21591';
UPDATE `creature_template` SET `lootid` = '20866' WHERE `entry` = '21614';
UPDATE `creature_template` SET `lootid` = '20865' WHERE `entry` = '21607';
UPDATE `creature_template` SET `lootid` = '20864' WHERE `entry` = '21608';
UPDATE `creature_template` SET `lootid` = '20859' WHERE `entry` = '21587';
UPDATE `creature_template` SET `lootid` = '20857' WHERE `entry` = '21585';
UPDATE `creature_template` SET `lootid` = '20059' WHERE `entry` = '21541';
UPDATE `creature_template` SET `lootid` = '19865' WHERE `entry` = '21562';
UPDATE `creature_template` SET `lootid` = '19843' WHERE `entry` = '21565';
UPDATE `creature_template` SET `lootid` = '19735' WHERE `entry` = '21542';
UPDATE `creature_template` SET `lootid` = '19716' WHERE `entry` = '21531';
UPDATE `creature_template` SET `lootid` = '19713' WHERE `entry` = '21532';
UPDATE `creature_template` SET `lootid` = '19712' WHERE `entry` = '21528';
UPDATE `creature_template` SET `lootid` = '19633' WHERE `entry` = '21547';
UPDATE `creature_template` SET `lootid` = '19632' WHERE `entry` = '20174';
UPDATE `creature_template` SET `lootid` = '19608' WHERE `entry` = '21554';
UPDATE `creature_template` SET `lootid` = '19598' WHERE `entry` = '21561';
UPDATE `creature_template` SET `lootid` = '19557' WHERE `entry` = '21555';
UPDATE `creature_template` SET `lootid` = '19513' WHERE `entry` = '21560';
UPDATE `creature_template` SET `lootid` = '19512' WHERE `entry` = '21564';
UPDATE `creature_template` SET `lootid` = '19511' WHERE `entry` = '21563';
UPDATE `creature_template` SET `lootid` = '19510' WHERE `entry` = '21522';
UPDATE `creature_template` SET `lootid` = '19509' WHERE `entry` = '21575';
UPDATE `creature_template` SET `lootid` = '19508' WHERE `entry` = '21576';
UPDATE `creature_template` SET `lootid` = '19507' WHERE `entry` = '21573';
UPDATE `creature_template` SET `lootid` = '19505' WHERE `entry` = '21571';
UPDATE `creature_template` SET `lootid` = '19486' WHERE `entry` = '21572';
UPDATE `creature_template` SET `lootid` = '19429' WHERE `entry` = '20686';
UPDATE `creature_template` SET `lootid` = '19428' WHERE `entry` = '20688';
UPDATE `creature_template` SET `lootid` = '19307' WHERE `entry` = '20265';
UPDATE `creature_template` SET `lootid` = '19306' WHERE `entry` = '20263';
UPDATE `creature_template` SET `lootid` = '19231' WHERE `entry` = '21527';
UPDATE `creature_template` SET `lootid` = '19209' WHERE `entry` = '20661';
UPDATE `creature_template` SET `lootid` = '19208' WHERE `entry` = '20660';
UPDATE `creature_template` SET `lootid` = '19168' WHERE `entry` = '21539';
UPDATE `creature_template` SET `lootid` = '19167' WHERE `entry` = '21524';
UPDATE `creature_template` SET `lootid` = '19166' WHERE `entry` = '21543';
UPDATE `creature_template` SET `lootid` = '18983' WHERE `entry` = '22162';
UPDATE `creature_template` SET `lootid` = '18982' WHERE `entry` = '22173';
UPDATE `creature_template` SET `lootid` = '18934' WHERE `entry` = '20525';
UPDATE `creature_template` SET `lootid` = '18894' WHERE `entry` = '21645';
UPDATE `creature_template` SET `lootid` = '18848' WHERE `entry` = '20656';
UPDATE `creature_template` SET `lootid` = '18830' WHERE `entry` = '20644';
UPDATE `creature_template` SET `lootid` = '18796' WHERE `entry` = '20652';
UPDATE `creature_template` SET `lootid` = '18794' WHERE `entry` = '20645';
UPDATE `creature_template` SET `lootid` = '18702' WHERE `entry` = '20300';
UPDATE `creature_template` SET `lootid` = '18663' WHERE `entry` = '20655';
UPDATE `creature_template` SET `lootid` = '18642' WHERE `entry` = '20651';
UPDATE `creature_template` SET `lootid` = '18641' WHERE `entry` = '20643';
UPDATE `creature_template` SET `lootid` = '18640' WHERE `entry` = '20649';
UPDATE `creature_template` SET `lootid` = '18639' WHERE `entry` = '20647';
UPDATE `creature_template` SET `lootid` = '18638' WHERE `entry` = '20650';
UPDATE `creature_template` SET `lootid` = '18637' WHERE `entry` = '20646';
UPDATE `creature_template` SET `lootid` = '18636' WHERE `entry` = '20639';
UPDATE `creature_template` SET `lootid` = '18635' WHERE `entry` = '20641';
UPDATE `creature_template` SET `lootid` = '18634' WHERE `entry` = '20648';
UPDATE `creature_template` SET `lootid` = '18633' WHERE `entry` = '20638';
UPDATE `creature_template` SET `lootid` = '18632' WHERE `entry` = '20642';
UPDATE `creature_template` SET `lootid` = '18631' WHERE `entry` = '20640';
UPDATE `creature_template` SET `lootid` = '18587' WHERE `entry` = '21552';
UPDATE `creature_template` SET `lootid` = '18559' WHERE `entry` = '20313';
UPDATE `creature_template` SET `lootid` = '18558' WHERE `entry` = '20312';
UPDATE `creature_template` SET `lootid` = '18557' WHERE `entry` = '20310';
UPDATE `creature_template` SET `lootid` = '18556' WHERE `entry` = '20311';
UPDATE `creature_template` SET `lootid` = '18524' WHERE `entry` = '20298';
UPDATE `creature_template` SET `lootid` = '18521' WHERE `entry` = '20315';
UPDATE `creature_template` SET `lootid` = '18503' WHERE `entry` = '20309';
UPDATE `creature_template` SET `lootid` = '18499' WHERE `entry` = '20322';
UPDATE `creature_template` SET `lootid` = '18498' WHERE `entry` = '20321';
UPDATE `creature_template` SET `lootid` = '18497' WHERE `entry` = '20299';
UPDATE `creature_template` SET `lootid` = '18495' WHERE `entry` = '20302';
UPDATE `creature_template` SET `lootid` = '18493' WHERE `entry` = '20301';
UPDATE `creature_template` SET `lootid` = '18422' WHERE `entry` = '21570';
UPDATE `creature_template` SET `lootid` = '18421' WHERE `entry` = '21577';
UPDATE `creature_template` SET `lootid` = '18420' WHERE `entry` = '21574';
UPDATE `creature_template` SET `lootid` = '18419' WHERE `entry` = '21546';
UPDATE `creature_template` SET `lootid` = '18405' WHERE `entry` = '21578';
UPDATE `creature_template` SET `lootid` = '18404' WHERE `entry` = '21549';
UPDATE `creature_template` SET `lootid` = '18331' WHERE `entry` = '20256';
UPDATE `creature_template` SET `lootid` = '18328' WHERE `entry` = '20694';
UPDATE `creature_template` SET `lootid` = '18327' WHERE `entry` = '20691';
UPDATE `creature_template` SET `lootid` = '18326' WHERE `entry` = '20699';
UPDATE `creature_template` SET `lootid` = '18325' WHERE `entry` = '20695';
UPDATE `creature_template` SET `lootid` = '18323' WHERE `entry` = '20692';
UPDATE `creature_template` SET `lootid` = '18322' WHERE `entry` = '20696';
UPDATE `creature_template` SET `lootid` = '18321' WHERE `entry` = '20701';
UPDATE `creature_template` SET `lootid` = '18320' WHERE `entry` = '20698';
UPDATE `creature_template` SET `lootid` = '18319' WHERE `entry` = '20697';
UPDATE `creature_template` SET `lootid` = '18318' WHERE `entry` = '20693';
UPDATE `creature_template` SET `lootid` = '18317' WHERE `entry` = '20257';
UPDATE `creature_template` SET `lootid` = '18315' WHERE `entry` = '20261';
UPDATE `creature_template` SET `lootid` = '18314' WHERE `entry` = '20264';
UPDATE `creature_template` SET `lootid` = '18313' WHERE `entry` = '20259';
UPDATE `creature_template` SET `lootid` = '18312' WHERE `entry` = '20260';
UPDATE `creature_template` SET `lootid` = '18311' WHERE `entry` = '20255';
UPDATE `creature_template` SET `lootid` = '18309' WHERE `entry` = '20258';
UPDATE `creature_template` SET `lootid` = '18172' WHERE `entry` = '20533';
UPDATE `creature_template` SET `lootid` = '18170' WHERE `entry` = '20534';
UPDATE `creature_template` SET `lootid` = '18155' WHERE `entry` = '21544';
UPDATE `creature_template` SET `lootid` = '18094' WHERE `entry` = '20546';
UPDATE `creature_template` SET `lootid` = '18093' WHERE `entry` = '20547';
UPDATE `creature_template` SET `lootid` = '18092' WHERE `entry` = '20545';
UPDATE `creature_template` SET `lootid` = '17994' WHERE `entry` = '21545';
UPDATE `creature_template` SET `lootid` = '17993' WHERE `entry` = '21548';
UPDATE `creature_template` SET `lootid` = '17964' WHERE `entry` = '19904';
UPDATE `creature_template` SET `lootid` = '17963' WHERE `entry` = '19902';
UPDATE `creature_template` SET `lootid` = '17962' WHERE `entry` = '19903';
UPDATE `creature_template` SET `lootid` = '17961' WHERE `entry` = '19887';
UPDATE `creature_template` SET `lootid` = '17960' WHERE `entry` = '19890';
UPDATE `creature_template` SET `lootid` = '17959' WHERE `entry` = '19889';
UPDATE `creature_template` SET `lootid` = '17958' WHERE `entry` = '19886';
UPDATE `creature_template` SET `lootid` = '17957' WHERE `entry` = '19885';
UPDATE `creature_template` SET `lootid` = '17940' WHERE `entry` = '19891';
UPDATE `creature_template` SET `lootid` = '17938' WHERE `entry` = '19888';
UPDATE `creature_template` SET `lootid` = '17917' WHERE `entry` = '20627';
UPDATE `creature_template` SET `lootid` = '17871' WHERE `entry` = '20190';
UPDATE `creature_template` SET `lootid` = '17860' WHERE `entry` = '20529';
UPDATE `creature_template` SET `lootid` = '17846' WHERE `entry` = '20543';
UPDATE `creature_template` SET `lootid` = '17840' WHERE `entry` = '20528';
UPDATE `creature_template` SET `lootid` = '17839' WHERE `entry` = '20744';
UPDATE `creature_template` SET `lootid` = '17833' WHERE `entry` = '20530';
UPDATE `creature_template` SET `lootid` = '17820' WHERE `entry` = '20526';
UPDATE `creature_template` SET `lootid` = '17819' WHERE `entry` = '20527';
UPDATE `creature_template` SET `lootid` = '17817' WHERE `entry` = '19892';
UPDATE `creature_template` SET `lootid` = '17816' WHERE `entry` = '19884';
UPDATE `creature_template` SET `lootid` = '17815' WHERE `entry` = '20537';
UPDATE `creature_template` SET `lootid` = '17814' WHERE `entry` = '20538';
UPDATE `creature_template` SET `lootid` = '17805' WHERE `entry` = '20624';
UPDATE `creature_template` SET `lootid` = '17803' WHERE `entry` = '20622';
UPDATE `creature_template` SET `lootid` = '17802' WHERE `entry` = '20626';
UPDATE `creature_template` SET `lootid` = '17801' WHERE `entry` = '20623';
UPDATE `creature_template` SET `lootid` = '17800' WHERE `entry` = '20621';
UPDATE `creature_template` SET `lootid` = '17799' WHERE `entry` = '20628';
UPDATE `creature_template` SET `lootid` = '17771' WHERE `entry` = '20179';
UPDATE `creature_template` SET `lootid` = '17735' WHERE `entry` = '20193';
UPDATE `creature_template` SET `lootid` = '17734' WHERE `entry` = '20187';
UPDATE `creature_template` SET `lootid` = '17732' WHERE `entry` = '20175';
UPDATE `creature_template` SET `lootid` = '17731' WHERE `entry` = '20173';
UPDATE `creature_template` SET `lootid` = '17730' WHERE `entry` = '20177';
UPDATE `creature_template` SET `lootid` = '17729' WHERE `entry` = '20180';
UPDATE `creature_template` SET `lootid` = '17728' WHERE `entry` = '20181';
UPDATE `creature_template` SET `lootid` = '17727' WHERE `entry` = '20192';
UPDATE `creature_template` SET `lootid` = '17726' WHERE `entry` = '20191';
UPDATE `creature_template` SET `lootid` = '17725' WHERE `entry` = '20188';
UPDATE `creature_template` SET `lootid` = '17724' WHERE `entry` = '20185';
UPDATE `creature_template` SET `lootid` = '17723' WHERE `entry` = '20164';
UPDATE `creature_template` SET `lootid` = '17722' WHERE `entry` = '20625';
UPDATE `creature_template` SET `lootid` = '17721' WHERE `entry` = '20620';
UPDATE `creature_template` SET `lootid` = '17695' WHERE `entry` = '20580';
UPDATE `creature_template` SET `lootid` = '17694' WHERE `entry` = '20577';
UPDATE `creature_template` SET `lootid` = '17671' WHERE `entry` = '20584';
UPDATE `creature_template` SET `lootid` = '17670' WHERE `entry` = '20588';
UPDATE `creature_template` SET `lootid` = '17669' WHERE `entry` = '20574';
UPDATE `creature_template` SET `lootid` = '17626' WHERE `entry` = '18609';
UPDATE `creature_template` SET `lootid` = '17624' WHERE `entry` = '18611';
UPDATE `creature_template` SET `lootid` = '17517' WHERE `entry` = '18057';
UPDATE `creature_template` SET `lootid` = '17491' WHERE `entry` = '18610';
UPDATE `creature_template` SET `lootid` = '17478' WHERE `entry` = '18050';
UPDATE `creature_template` SET `lootid` = '17465' WHERE `entry` = '20583';
UPDATE `creature_template` SET `lootid` = '17464' WHERE `entry` = '20586';
UPDATE `creature_template` SET `lootid` = '17462' WHERE `entry` = '20595';
UPDATE `creature_template` SET `lootid` = '17461' WHERE `entry` = '20581';
UPDATE `creature_template` SET `lootid` = '17455' WHERE `entry` = '18051';
UPDATE `creature_template` SET `lootid` = '17429' WHERE `entry` = '18603';
UPDATE `creature_template` SET `lootid` = '17427' WHERE `entry` = '20579';
UPDATE `creature_template` SET `lootid` = '17420' WHERE `entry` = '20587';
UPDATE `creature_template` SET `lootid` = '17414' WHERE `entry` = '18618';
UPDATE `creature_template` SET `lootid` = '17401' WHERE `entry` = '18605';
UPDATE `creature_template` SET `lootid` = '17400' WHERE `entry` = '18604';
UPDATE `creature_template` SET `lootid` = '17398' WHERE `entry` = '18612';
UPDATE `creature_template` SET `lootid` = '17397' WHERE `entry` = '18615';
UPDATE `creature_template` SET `lootid` = '17395' WHERE `entry` = '18617';
UPDATE `creature_template` SET `lootid` = '17371' WHERE `entry` = '18619';
UPDATE `creature_template` SET `lootid` = '17370' WHERE `entry` = '18608';
UPDATE `creature_template` SET `lootid` = '17356' WHERE `entry` = '20565';
UPDATE `creature_template` SET `lootid` = '17309' WHERE `entry` = '18058';
UPDATE `creature_template` SET `lootid` = '17281' WHERE `entry` = '18055';
UPDATE `creature_template` SET `lootid` = '17280' WHERE `entry` = '18059';
UPDATE `creature_template` SET `lootid` = '17271' WHERE `entry` = '18052';
UPDATE `creature_template` SET `lootid` = '17270' WHERE `entry` = '18048';
UPDATE `creature_template` SET `lootid` = '17269' WHERE `entry` = '18049';
UPDATE `creature_template` SET `lootid` = '17264' WHERE `entry` = '18054';
UPDATE `creature_template` SET `lootid` = '17259' WHERE `entry` = '18053';
UPDATE `creature_template` SET `lootid` = '16704' WHERE `entry` = '20594';
UPDATE `creature_template` SET `lootid` = '16700' WHERE `entry` = '20589';
UPDATE `creature_template` SET `lootid` = '16699' WHERE `entry` = '20590';
UPDATE `creature_template` SET `lootid` = '16594' WHERE `entry` = '20576';
UPDATE `creature_template` SET `lootid` = '16593' WHERE `entry` = '20582';
UPDATE `creature_template` SET `lootid` = '16523' WHERE `entry` = '20591';
UPDATE `creature_template` SET `lootid` = '16507' WHERE `entry` = '20593';

-- Sethekk Prophet Faction  error modification
UPDATE `creature_template` SET `faction_A` = '16', `faction_H` = '16' WHERE `entry` = '20695';

-- Avian Ripper Faction  error modification
UPDATE `creature_template` SET `faction_A` = '14', `faction_H` = '14' WHERE `entry` IN (21891, 21989);

-- Black Temple BOSS Reliquary of the Lost HP correction
UPDATE `creature_template` SET `minhealth` = '2300000', `maxhealth` = '2300000' WHERE `entry` IN (23418, 23419, 23420);