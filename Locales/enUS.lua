local e=select(2,...)
if e.locale ~= "enUS" and e.locale ~= "enGB" then return end

e[1]="RaidFramesPlus  Config  Panel"
e[2]="Player position"
e[3]="Double sort raid"
e[4]=" Place pets under owner"
e[5]="Aura sizes"
e[6]=" Hide roles"
e[7]=" Hide names"
e[8]="|cff00F0F0RaidFramesPlus|r: exclusive macro created."   -- print()
e[9]="|cff00F0F0RaidFramesPlus|r: exclusive macro already exists." -- print()
e[10]="Too much macros ?"  -- print()
e[11]="Ignore sort"
e[12]="Set to end"
e[13]="Both sort can only works on 'combined groups' raid and party frames" -- 'combined groups' must be equal to the string in EditMode > Raid frames > Groups option
e[14]="Create Macro"