# Default Next Map

[![Steam Workshop](https://img.shields.io/badge/steam-workshop-0)](https://steamcommunity.com/sharedfiles/filedetails/?id=2379979801)
[![Steam Favorites](https://img.shields.io/steam/favorites/2379979801)](https://steamcommunity.com/sharedfiles/filedetails/?id=2379979801)
[![Steam Update Date](https://img.shields.io/steam/update-date/2379979801)](https://steamcommunity.com/sharedfiles/filedetails/?id=2379979801)
[![GitHub tag (latest by date)](https://img.shields.io/github/v/tag/GenZmeY/KF2-DefNextMap)](https://github.com/GenZmeY/KF2-DefNextMap/tags)
[![GitHub](https://img.shields.io/github/license/GenZmeY/KF2-DefNextMap)](https://www.gnu.org/licenses/gpl-3.0.en.html)

If players have not voted for the next map, a random official map from the current map cycle will be selected.

When connecting to a server, players no longer need to load a custom map if they are not going to play on it.

It's a server-side mutator, it doesn't need to be loaded on the client.

# Build
1. Install [Killing Floor 2](https://store.steampowered.com/app/232090/Killing_Floor_2/), Killing Floor 2 - SDK and [git for windows](https://git-scm.com/download/win);
2. Open git-bash, clone this repository and go to the source folder:  
`git clone https://github.com/GenZmeY/KF2-DefNextMap && cd KF2-DefNextMap`  
3. Run make.sh script:  
`./make.sh --compile`  
4. The compiled files will be here:  
`C:\Users\<USERNAME>\Documents\My Games\KillingFloor2\KFGame\Unpublished\BrewedPC\Script\`  

# Usage (Server)
1. Open your PCServer-KFEngine.ini / LinuxServer-KFEngine.ini;  
2. Add the following string to the [OnlineSubsystemSteamworks.KFWorkshopSteamworks] section:  
`ServerSubscribedWorkshopItems=2379979801`  
3. Start the server and wait while the mutator is downloading;  
4. Add the following line to the startup parameters and restart the server:  
`?Mutator=DefNextMap.DefNextMapMut`  

# Bug reports
If you find a bug, create new issue here: [Issues](https://github.com/GenZmeY/KF2-DefNextMap/issues)  
Describe what the bug looks like and how to reproduce it.  

# License
The mutator is licensed under the [GNU GPLv3](LICENSE).
