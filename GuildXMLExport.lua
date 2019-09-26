function RosterExporter_OnLoad(self)
    self:RegisterEvent("GUILD_ROSTER_UPDATE");
end

function RosterExporter_OnEvent(self, event, ...)
    SlashCmdList["GUILDEXPORT"] = RosterExporter_SlashCmdHandler;
    SLASH_GUILDEXPORT1 = "/exportguild";
    SLASH_GUILDEXPORT2 = "/exportroster";

    GuildRoster();
end

function RosterExporter_SlashCmdHandler()
    Population = GetNumGuildMembers(true);
	local realmName = GetRealmName();
    output = "\<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<guild>\n";
    for i = 1, Population do
        name, rank, rankIndex, level, class, zone, note, officernote, online, status, classFileName, achievementPoints, achievementRank, isMobile = GetGuildRosterInfo(i);
        output = output .. "<members>\n<character>" .. name:gsub("-"..realmName, "") .. "</character>\n<rank>" .. rank .. "</rank>\n<ranknumber>" .. rankIndex .. "</ranknumber>\n<level>" .. level .. "</level>\n<class>" .. class .. "</class>\n<guildnote>" .. note .. "</guildnote>\n<officernote>" .. officernote .. "</officernote>\n<achievementpoints>" .. achievementPoints .. "</achievementpoints>\n<achievementrank>" .. achievementRank .. "</achievementrank>\n</members>\n";
    end

    output = output .. "</guild>";
    EditBox:SetText(output);
    RosterCopyFrame:Show();
    EditBox:HighlightText();
    RosterCopyFrame:SetClampedToScreen(true)
    RosterCopyFrame:SetFrameStrata(HIGH)
	EditBox:SetFrameStrata(HIGH);
    DEFAULT_CHAT_FRAME:AddMessage("|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t|cffe66600 Guild XML Export: Copy roster text and paste into a text file to use as an XML document. |TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t  ");

end

function RosterExporterPanel_OnLoad (panel)
    panel.name = "Guild XML Exporter"
    InterfaceOptions_AddCategory(panel);

    function ExportMe_Click()
        RosterExporter_SlashCmdHandler();
    end
end


