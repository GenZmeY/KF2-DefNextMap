Class NextMapMut extends KFMutator
	config(NextMapMut);

var const int CurrentVersion;
var config int ConfigVersion;

var config bool bEnableMapStats;
var config string SortStats;
var config bool bOfficialNextMapOnly;
var config bool bRandomizeNextMap;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();

	if (WorldInfo.Game.BaseMutator == None)
		WorldInfo.Game.BaseMutator = Self;
	else
		WorldInfo.Game.BaseMutator.AddMutator(Self);
	
	if (bDeleteMe) return;

	Initialize();
}

function InitConfig()
{
	// Update from config version to current version if needed
	switch (ConfigVersion)
	{
		case 0: // which means there is no config right now
			bEnableMapStats = False;
			SortStats = "False";
			bOfficialNextMapOnly = True;
			bRandomizeNextMap = True;
		// case 1:
		// do something to update config v1 to config v2
		// and so on...
		case 2147483647:
			`log("[NextMapMut] Config updated to version"@CurrentVersion);
			break;
		case CurrentVersion:
			`log("[NextMapMut] Config is up-to-date");
			break;
		default:
			`log("[NextMapMut] Warn: The config version is higher than the current version (are you using an old mutator?)");
			`log("[NextMapMut] Warn: Config version is"@ConfigVersion@"but current version is"@CurrentVersion);
			`log("[NextMapMut] Warn: The config version will be changed to "@CurrentVersion);
			break;
	}
	
	// Check and correct some values
	if (!(SortStats ~= "CounterAsc"
		|| SortStats ~= "CounterDesc"
		|| SortStats ~= "NameAsc"
		|| SortStats ~= "NameDesc"
		|| SortStats ~= "False"))
	{
		`log("[NextMapMut] Warn: SortStats value not recognized ("$SortStats$") and will be set to False");
		`log("[NextMapMut] Warn: Valid values for SortStats: False CounterAsc CounterDesc NameAsc NameDesc");
		SortStats = "False";
	}

	ConfigVersion = CurrentVersion;
	SaveConfig();
}

function Initialize()
{
	local NmmVoteCollector VoteCollector;
	
	if (MyKFGI == None || MyKFGI.MyKFGRI == None)
	{
		SetTimer(1.f, false, nameof(Initialize));
		return;
	}
	
	InitConfig();
	
	MyKFGI.MyKFGRI.VoteCollector.Outer.Destroy();
	MyKFGI.MyKFGRI.VoteCollectorClass = class'NmmVoteCollector';
	MyKFGI.MyKFGRI.VoteCollector = new(MyKFGI.MyKFGRI) MyKFGI.MyKFGRI.VoteCollectorClass;
	
	VoteCollector = NmmVoteCollector(MyKFGI.MyKFGRI.VoteCollector);
	VoteCollector.bEnableMapStats = bEnableMapStats;
	VoteCollector.bOfficialNextMapOnly = bOfficialNextMapOnly;
	VoteCollector.bRandomizeNextMap = bRandomizeNextMap;
	VoteCollector.SortPolicy = SortStats;
	
	`Log("[NextMapMut] Mutator loaded.");
}

function AddMutator(Mutator Mut)
{
	if (Mut == Self) return;
	
	if (Mut.Class == Class)
		Mut.Destroy();
	else
		Super.AddMutator(Mut);
}

defaultproperties
{
	CurrentVersion=1 // Config
}
