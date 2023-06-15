local e=select(2,...)
if e[1] then return end

e[1]="RaidFramesPlus  Kontrol  Panelo"
e[2]="Player pozicio"
e[3]="Double sort raid 'combined groups' and party frames"
e[4]=" Place "..PETS:lower().." under owner"
e[5]=AURAS.." : "..HUD_EDIT_MODE_SETTING_AURA_FRAME_ICON_SIZE:lower()
e[6]=" "..HIDE.." : "..HUD_EDIT_MODE_SETTING_UNIT_FRAME_SORT_BY_SETTING_ROLE:lower()
e[7]=" "..HIDE.." : "..NAME:lower()
e[8]=MACRO.." |cff00F0F0RaidFramesPlus|r created."
e[9]=MACRO.." |cff00F0F0RaidFramesPlus|r already exists."
e[10]=MACRO.." bank full ?"
