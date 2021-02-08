class DnmVoteCollector extends KFVoteCollector;

function int GetNextMap()
{
	local KFGameInfo KFGI;
	local array<string> ActiveMapCycle;
	local array<string> AviableMaps;
	local string Map;

	if(MapVoteList.Length > 0)
	{
		return MapVoteList[0].MapIndex;
	}
	else // random default map that exists in the active map cycle and allowed for current gamemode
	{
		KFGI = KFGameInfo(WorldInfo.Game);
		if (KFGI == None) return -1;
		
		ActiveMapCycle = KFGI.GameMapCycles[KFGI.ActiveMapCycle].Maps;

		foreach class'KFGameViewportClient'.default.TripWireOfficialMaps(Map)
			if (ActiveMapCycle.Find(Map) != -1 && KFGI.IsMapAllowedInCycle(Map))
				AviableMaps.AddItem(Map);

		foreach class'KFGameViewportClient'.default.CommunityOfficialMaps(Map)
			if (ActiveMapCycle.Find(Map) != -1 && KFGI.IsMapAllowedInCycle(Map))
				AviableMaps.AddItem(Map);

		if (AviableMaps.Length > 0)
			return ActiveMapCycle.Find(AviableMaps[Rand(AviableMaps.Length)]);
	}

	return -1;
}

DefaultProperties
{
}
