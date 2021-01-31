class DnmVoteCollector extends KFVoteCollector;

function int GetNextMap()
{
	local KFGameInfo KFGI;
	local array<string> TripWireOfficialMaps;
	local array<string> CommunityOfficialMaps;
	local array<string> AviableMaps;
	local int i;
	
	KFGI = KFGameInfo(WorldInfo.Game);

	if(MapVoteList.Length > 0)
	{
		return MapVoteList[0].MapIndex;
	}
	else // random default map that exists in the active map cycle
	{
		TripWireOfficialMaps = class'KFGameViewportClient'.default.TripWireOfficialMaps;
		CommunityOfficialMaps = class'KFGameViewportClient'.default.CommunityOfficialMaps;
		
		for (i = 0; i < TripWireOfficialMaps.Length; i++)
			if (MapInTheCycle(KFGI, TripWireOfficialMaps[i]))
				AviableMaps.AddItem(TripWireOfficialMaps[i]);
			
		for (i = 0; i < CommunityOfficialMaps.Length; i++)
			if (MapInTheCycle(KFGI, CommunityOfficialMaps[i]))
				AviableMaps.AddItem(CommunityOfficialMaps[i]);
			
		if (AviableMaps.Length > 0)
			return KFGI.GameMapCycles[KFGI.ActiveMapCycle].Maps.Find(AviableMaps[Rand(AviableMaps.Length)]);
	}
	
	return -1;
}

function bool MapInTheCycle(KFGameInfo KFGI, string Map)
{
	return (KFGI.GameMapCycles[KFGI.ActiveMapCycle].Maps.Find(Map) != -1);
}

DefaultProperties
{
}
