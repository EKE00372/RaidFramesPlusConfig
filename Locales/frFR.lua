local locale, e = GetLocale(), select(2,...)
e.locale = locale
if locale ~= "frFR" then return end

e[1]="Panneau  de  Config.  RaidFramesPlus"
e[2]="Position du joueur"
e[3]="Double tri des frames du raid 'groupes combinés' et du groupe" -- 'combined groups' must be equal to the string in EditMode > Raid frames > Groups option
e[4]=" Placer les familiers sous leur maître"
e[5]="Taille des buffs et débuffs"
e[6]=" Cacher les rôles"
e[7]=" Cacher les noms"
e[8]="Macro |cff00F0F0RaidFramesPlus|r créée."
e[9]="Macro |cff00F0F0RaidFramesPlus|r existe déjà."
e[10]="Trop de macros ?"
