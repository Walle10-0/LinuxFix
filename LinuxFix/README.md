# Welcome to LinuxFix!
This README may be slightly out of date in some areas as as there is a bit to cover and it was not written all at once. However, it does provide a basic description of some of the functions of these scripts.

A collection of mini-script that run system admin tasks and help harden the computer. Please note that all of these script might cause unforseen problems if run on a host computer. Also, not all of these scripts work reliably as others. In other words, this is all a beta. Therefore, you might have to "fix" the scripts. This text file serves as a description of all the parts of LinuxFix, what they do, and how reliable they are.

## Directories :
### LinuxFix :
This is the root directory of the script. Everything is contained within it. All scripts were built to be run from this directory and not inside the core-files directory. However, I think I fixed that issue in the most recent update.
### LinuxFix/core-files :
This contains most/all of the scripts for LinuxFix. All scripts were meant to be run from the LinuxFix directory but I think I have fixed it so they can be run anywhere. It contains '.sh' files for the scripts that can be run with 'bash $filename' and '.config'  files for configurations for certian scripts. However, most scripts that take '.config' files will also accept another file if you specify it.
### LinuxFix/'old-stuff' (previously "Old Stuff") :
This is where I archive old scripts I don't need anymore. I doubt they will be any use anymore since they've been assimilated into larger scripts but you are welcome to look at them. You may find some useful stuff.
### LinuxFix/core-files/templates :
This is not the settings for LinuxFix. This is a database of settings that LinuxFix will use as templates for your computer. Settings contained here are simply copied into your computer's settings. While there may be other scripts that utilize it, it is mainly used by SettingsAssistant.

## Current Scripts :
### LinuxFix : 
This is the main init script for LinuxFix. If you want to run all of LinuxFix, run this. It runs a handful of system checks and starts all the other scripts in LinuxFix.
### ScriptTest :
As the name implies, this is a junk script that I use for testing. It has no significance for LinuxFix
### LinuxFixCore :
This is the counterpart for LinuxFix. Don't run this by itself, run LinuxFix instead. Once LinuxFix finishes system checks, it runs this script, which in turn, runs all the other scripts. It is very basic. I think I fixed it so you can run it from any directory but I haven't tested it.
### AutoUsers :
A useful script for automatically adding and deleting users (making sure only authorized users exist) I recently added file IO so you can easily specify authorized users in the text files Users.config and Admin.config. Just be careful not to make a mistake in the text file as it will add and delete users automatically.
### PasswdHack :
This is by far the most useful script in LinuxFix. Aside from disabling the guest account, it changes everybody's passwords instantly. Just be sure to write the new password down because it works! You can also specify a random password.
### BulkUninstall :
A simple script that uninstalls all software from a list specified by a config file.
### InstalLISTtion :
A simple script that installs/reinstalls software from a list specified by a config file.
### FileLock :
This script exists for litterally only one purpose, and that's to make sure files in the /etc directory have the right permissions. Examples of this include /etc/passwd and /etc/shadow.
It now includes file IO, so you can list files and permissions in FileLock.config
### MP3_Murderer :
This is a simple script that completely finds and destroys any MP3 files. It runs reliably
### SettingsAssistant :
This script has grown to be very large. It copies secure system settings onto your computer. It is useful, quick, and relatively easy to fix. While very long, the actual logic of the script is simple. It configures settings, the firewall, firefox (Debian only), and critical services.
### ServerSpy :
This is actually a pretty cool script that shows you the home directory of every user on the computer and gives you a glance at crontabs. It is really useful for auditing and can help you find suspicous files. It is also pretty hard to break.
### Graphics :
It's basically ASCII art. This script isn't for any cyber security puproses. It is a subscript that creates the nice graphics of LinuxFix that appear in your screen occasionally. I haven't found too many bugs, but even if there were bugs, they aren't important because this is a graphic script.
### Timewarp :
Creates a copy of everything in case something breaks (a backup essentially)

## Obsolete Scripts :
Software constantly changes, so there are some scripts that are no longer used. Some have been assimilated into other scripts, others just had useless features and were scrapped in favor of a more generalized solution. I kept them and documented them here in case you want to use some parts from them. However, basically all of them are broken because they are not inside 'LinuxFix/core-files'. If you want to see an older version of LinuxFix that uses more of these unused scripts, I suggest you check out the archive branch.
### HackZap :
This is the oldest of all the scripts. It simply runs through a list of known programs to delete, so it runs reliably. However, it also has a feaure that looks for backdoors. Despite the name, it doesn't just check for hacks. That is why it was scrapped in favor of BulkUninstall, which uses a file for the list of software to uninstall rather than coding it in the script.
### FirewallForger :
Time to build a wall! or at least a firewall... Because that's what this script does. It hasn't broken yet but that's mainly because it's just 3 commands that you could litterally type into the terminal in the same amount of time. So if you're really THAT lazy, you can use this script to make the firewall for you. I just put the code into SettingsAssistant for now.
### Update Protocal :
This is another simple script that does updates. Sometimes it is just easier to manually put this in the terminal and it doesn't always work because there are some settings that you need to fix in the GUI first. It's pretty bad, lol!
### FirefoxFix :
This is a script that does firefox settings through bash. While it can be at times convenient, it is more reliable just to do it through the GUI. Furthermore, this script only works on Debian so it's only good in very specific circumstances. It got moved into SettingsAssistant.
### SoftwareSuperman :
Originally this script just downloaded a handful of useful programs. However, I  added a feature that configures critical services that makes it one of the biggest scripts. It got split up and scrapped in favor of InstalLISTion and SettingsAssistant.
### ApacheArmor :
A very old script with some nice ASCII art but other than that it just copies and pastes a config file, so as you can imagine, it was quickly phased out.
### FTP_project : 
Much like ApacheArmor, except it also configures the firewall as well as ftp.
### TheLynisList :
This script copies and pastes various settings based on suggestions from the tool Lynis. Eventually, this turned into SettingsAssistant.
### LinuxFixV.0.0 :
A very old version of Linux that is all contained in 1 script rather than several modular scripts like it is now.
### rickroll :
a fake terminal prompt that rickrolls you when you press enter. Probably the most useful thing in 'old-stuff'

## I think that's it!
I'm surprised you read this far. I "could" go over some of the old scripts, but i think this is sufficent. Have fun using LinuxFix! I hope it helps. Please let me know about any bugs.
