ECHO OFF
REM Create virtnet topology 5

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

REM Node 2 
%vbm% clonevm base --name node2 --snapshot base --options link --register
%vbm% modifyvm node2 --cableconnected2 off
%vbm% modifyvm node2 --cableconnected3 off
%vbm% modifyvm node2 --nic2 intnet --intnet2 neta
%vbm% modifyvm node2 --nic3 intnet --intnet3 netb
%vbm% modifyvm node2 --cableconnected2 on
%vbm% modifyvm node2 --cableconnected3 on
%vbm% modifyvm node2 --natpf1 delete ssh
%vbm% modifyvm node2 --natpf1 ssh,tcp,,2202,,22

REM Node 3 
%vbm% clonevm base --name node3 --snapshot base --options link --register
%vbm% modifyvm node3 --cableconnected2 off
%vbm% modifyvm node3 --cableconnected3 off
%vbm% modifyvm node3 --nic2 intnet --intnet2 netb
%vbm% modifyvm node3 --cableconnected2 on
%vbm% modifyvm node3 --natpf1 delete ssh
%vbm% modifyvm node3 --natpf1 ssh,tcp,,2203,,22

PAUSE

ECHO You should now have the following new VMs in VirtualBox:
ECHO    node1 node2 node3
ECHO If not, then make sure you delete any OLD node VMs before 
ECHO running this command again. 
ECHO You should now do the following for each node created:
ECHO    1. Start "node1" in VirtualBox
ECHO    2. Login with username "network" and password "network"
ECHO    3. Run the command:
ECHO       sudo bash virtnet/bin/vn-deploynode 5 1
ECHO    4. Repeat steps 1, 2 and 3 for node2, but with command:
ECHO       sudo bash virtnet/bin/vn-deploynode 5 2
ECHO    5. Repeat steps 1, 2 and 3 for node3, but with command:
ECHO       sudo bash virtnet/bin/vn-deploynode 5 3
ECHO Perform the above steps now. Once completed, press any key to quit.

PAUSE