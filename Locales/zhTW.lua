local e=select(2,...)
if e.locale ~= "zhTW" then return end

e[1]="RaidFramesPlus 設定選項"
e[2]="玩家位置排序"
e[3]="團隊雙重排序" -- 'combined groups' must be equal to the string in EditMode > Raid frames > Groups option
e[4]=" 將寵物錨點至主人下方"
e[5]="光環大小"
e[6]=" 隱藏角色類型"
e[7]=" 隱藏名字"
e[8]="|cff00F0F0RaidFramesPlus|r：巨集已創建。"   -- print()
e[9]="|cff00F0F0RaidFramesPlus|r：巨集已存在。" -- print()
e[10]="巨集滿了？"  -- print()
e[11]="不排序"
e[12]="團隊最末位"
e[13]="兩種排序功能均只適用於以「各隊合併」排序的團隊框架和團隊風格的隊伍框架。"
e[14]="創建專用巨集"
