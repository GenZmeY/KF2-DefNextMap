class NmmVoteCollector extends KFVoteCollector
	dependson(MapStats);

var string SortPolicy;
var bool bEnableMapStats;
var bool bOfficialNextMapOnly;
var bool bRandomizeNextMap;

var private array<string> ActiveMapCycle;

function LoadActiveMapCycle()
{
	local KFGameInfo KFGI;

	if (ActiveMapCycle.Length > 0) return;		
	
	KFGI = KFGameInfo(WorldInfo.Game);
	if (WorldInfo.NetMode == NM_Standalone)
		ActiveMapCycle = Maplist;
	else if (KFGI != None) 
		ActiveMapCycle = KFGI.GameMapCycles[KFGI.ActiveMapCycle].Maps;
}

function bool IsOfficialMap(string MapName)
{
	local KFMapSummary MapData;
	MapData = class'KFUIDataStore_GameResource'.static.GetMapSummaryFromMapName(MapName);
	if (MapData == None) return False;
	return (MapData.MapAssociation != EAI_Custom);
}

function int GetNextMapIndex()
{
	local KFGameInfo KFGI;
	local array<string> AviableMaps;
	local string Map;
	local int CurrentMapIndex;
	
	KFGI = KFGameInfo(WorldInfo.Game);
	if (KFGI == None) return INDEX_NONE;

	LoadActiveMapCycle();
	if (bRandomizeNextMap)
	{
		foreach ActiveMapCycle(Map)
		{
			if (bOfficialNextMapOnly && !IsOfficialMap(Map))
				continue;
			if (KFGI.IsMapAllowedInCycle(Map))
				AviableMaps.AddItem(Map);
		}
		if (AviableMaps.Length > 0)
			return ActiveMapCycle.Find(AviableMaps[Rand(AviableMaps.Length)]);
	}
	else if (ActiveMapCycle.Length > 0)
	{
		// I don't use KFGameInfo.GetNextMap() because
		// it uses and changes global KFGameInfo.MapCycleIndex variable
		CurrentMapIndex = ActiveMapCycle.Find(WorldInfo.GetMapName(true));
		if (CurrentMapIndex != INDEX_NONE)
		{
			for (CurrentMapIndex++; CurrentMapIndex < ActiveMapCycle.Length; CurrentMapIndex++)
			{
				if (bOfficialNextMapOnly && !IsOfficialMap(ActiveMapCycle[CurrentMapIndex]))
					continue;
				if (KFGI.IsMapAllowedInCycle(ActiveMapCycle[CurrentMapIndex]))
					return CurrentMapIndex;
			}
		}
		return 0;
	}
	
	return INDEX_NONE;
}

function int GetNextMap()
{
	local int MapIndex;

	if (MapVoteList.Length > 0)
		MapIndex = MapVoteList[0].MapIndex;
	else
		MapIndex = GetNextMapIndex();

	if (bEnableMapStats)
	{
		if (MapIndex == INDEX_NONE)
		{
			`log("[NextMapMut] Warn: MapIndex == INDEX_NONE, stats not saved");
		}
		else
		{
			LoadActiveMapCycle();
			class'MapStats'.static.IncMapStat(ActiveMapCycle[MapIndex], SortPolicy);
		}
	}

	return MapIndex;
}

DefaultProperties
{
}
