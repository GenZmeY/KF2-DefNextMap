Class DefNextMapMut extends KFMutator;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();

	if (WorldInfo.Game.BaseMutator == None)
		WorldInfo.Game.BaseMutator = Self;
	else
		WorldInfo.Game.BaseMutator.AddMutator(Self);
	
	if (bDeleteMe)
		return;
	
	Initialize();
}

function Initialize()
{
	if (MyKFGI == None || MyKFGI.MyKFGRI == None)
	{
		SetTimer(2.f, false, nameof(Initialize));
		return;
	}
	
	MyKFGI.MyKFGRI.VoteCollectorClass = class'DnmVoteCollector';
	MyKFGI.MyKFGRI.PostBeginPlay();
	
	`Log("[DefNextMap] Mutator loaded.");
}

function AddMutator(Mutator Mut)
{
	if (Mut == Self)
		return;
	
	if (Mut.Class == Class)
		Mut.Destroy();
	else
		Super.AddMutator(Mut);
}

defaultproperties
{
}
