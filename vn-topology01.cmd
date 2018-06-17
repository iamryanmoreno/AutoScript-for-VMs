ECHO OFF
REM Create virtnet topology 1

ECHO You are about to clone the "base" VM to node(s). Make sure you
ECHO have deleted any existing nodes before continuing. In the 
ECHO VirtualBox GUI, if you have node1, node2, ... then right-click
ECHO on them and select "Remove..." and then "Delete all files". 
ECHO They need to be deleted before continuing.

PAUSE

REM Shortcut to the Virutal Box manager executable
SET vbm="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

REM Clone and configure each node

REM Node 1
%vbm% clonevm base --name node1 --snapshot base --options link --register
%vbm% modifyvm node1 --cableconnected2 off
%vbm% modifyvm node1 --cableconnected3 off
%vbm% modifyvm node1 --nic2 intnet --intnet2 neta
%vbm% modifyvm node1 --cableconnected2 on
%vbm% modifyvm node1 --natpf1 delete ssh
%vbm% modifyvm node1 --natpf1 ssh,tcp,,2201,,22

PAUSE

ECHO You should now have the following new VMs in VirtualBox:
ECHO    node1
ECHO If not, then make sure you deleted an OLD node1 VMs before 
ECHO running this command. 
ECHO You should now do the following for each node created:
ECHO    1. Start "node1" in VirtualBox
ECHO    2. Login with username "network" and password "network"
ECHO    3. Run the command:
ECHO       sudo bash virtnet/bin/vn-deploynode 1 1
ECHO Perform the above steps now. Once completed, press any key to quit.

PAUSE

