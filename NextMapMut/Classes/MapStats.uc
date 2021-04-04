class MapStats extends Object
	config(NextMapMut);

struct MapStatEntry
{
	var config string Name;
	var config int Counter;
};
var config array<MapStatEntry> MapStat;

static function int CounterSortAsc(MapStatEntry A, MapStatEntry B)
{
	return B.Counter < A.Counter ? -1 : 0;
}

static function int CounterSortDesc(MapStatEntry A, MapStatEntry B)
{
	return A.Counter < B.Counter ? -1 : 0;
}

static function int NameSortAsc(MapStatEntry A, MapStatEntry B)
{
	return B.Name < A.Name ? -1 : 0;
}

static function int NameSortDesc(MapStatEntry A, MapStatEntry B)
{
	return A.Name < B.Name ? -1 : 0;
}

static function IncMapStat(string Map)
{
	local int MapStatEntryIndex;
	local MapStatEntry NewEntry;

	MapStatEntryIndex = Default.MapStat.Find('Name', Map);
	if (MapStatEntryIndex == INDEX_NONE)
	{
		NewEntry.Name = Map;
		NewEntry.Counter = 1;
		Default.MapStat.AddItem(NewEntry);
	}
	else
	{
		Default.MapStat[MapStatEntryIndex].Counter++;
	}
}

static function Sort(optional bool Ascending = True)
{
	if (Ascending)
		Default.MapStat.Sort(CounterSortAsc);
	else
		Default.MapStat.Sort(CounterSortDesc);
}

DefaultProperties
{
}
