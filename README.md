BlizzLikeCore
-------
**BlizzLikeCore** is a MMORPG framework that's built using C++, and using a 
back-end of MySQL for the DB content. **BlizzLikeCore** is an individual project 
based on the code of [CMaNGOS](http://cmangos.net/ "CMaNGOS") and 
[ScriptDev2](http://www.scriptdev2.com/ "SD2") with extensive changes over time 
to optimize, improve and cleanup the codebase at the same time as improving the 
ingame mechanics and functionality.
if you have code for us to merge into the repo (please file a pull request), 
or help us by posting issues, patches and enhancement suggestions on the 
forum: [BlizzLikeGroup](http://www.blizzlikegroup.dx.am/ "Forum")

How to Install
-------
Check: [BlizzLikeGroup](http://www.blizzlikegroup.dx.am/ "Forum")

**In support of the environment:**`Linux and Windows7 or 8 `

**You need to install the software:**

 - [MySQL](http://dev.mysql.com/downloads/mysql/) 5.2
 - [Git](http://msysgit.github.io/)
 - Visual Studio (2010 or 2012 or 2013)
 - Heidsql(Optional Software)
 - OpenSSL 1.0.1
 - CMake 2.8 (`In the installation, you must choose the Add CMake to the system PATH for all users`)

**Downloading the BlizzLikeGroup Source Code:**

`git clone https://github.com/blizzlikegroup/blizzlikecore.git`

**Build and compile:**

 - Run `Windows_build.Bat`
 - when the build is completed, Will ask you:` Do you want the compile the core now`, you Can choose Y compile directly, default yes
 - the generated files by default in the `C:\\BlizzLikeCore`

**Extracting Game Data:**

We get everything ready!
In the source directory found `contrib`!All the `tools`!

 - Copy all files within the Tools to the world of warcraft (TBC)
   directory.
   
 - Run `windows_tools.bat`

Then you will see three options:(`Mmaps extraction was slow`)

 1. Extract dbc/maps
 2. Extract vmaps
 3. Extract mmaps

when all the selected extraction is completed, you will see four folders

`dbc`,`maps`,`mmaps`,`vmaps`

Copy them to `C:\\BlizzLikeCore\bin\`

**Now our `C:\\BlizzLikeCore\` all the files in the directory is like this:**

***`C:\\BlizzLikeCore\bin\`***

 - dbc(folder)
 - maps(folder)
 - mmaps(folder)
 - vmaps(folder)
 - ACE.dll
 - blizzlikescript.dll
 - dbghelp.dll
 - libeay32.dll
 - libmySQL.dll
 - authserver.exe
 - worldserver.exe

***`C:\\BlizzLikeCore\etc\`***

 - ahbot.conf
 - authserver.conf
 - scripts.conf
 - worldserver.conf

**Database of import:**

In the source directory found `sql` folder

Run `Windows_sql.bat` Enter your MySQL database user name and password

Get the menu, `1 to 5` is the import database,Now we only need to use these

If you encounter any problems, please go to the [BBS](http://www.blizzlikegroup.dx.am/) for help
-------
License
-------
**BlizzLikeCore** is free software; you can redistribute it and/or modify it 
under the terms of the GNU General Public License as published by the 
Free Software Foundation; version 3 of the License.

Contact: blizzlikegroup@gmail.com