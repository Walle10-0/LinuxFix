# Welcome to LinuxFix!
This README may be slightly out of date in some areas as it has not been updated in a while. However, it does provide a basic description of some of the functions of these scripts.

A collection of mini-script that run system admin tasks and help harden the computer. Please note that all of these script might cause unforseen problems if run on a host computer. Also, not all of these scripts work reliably as others. In other words, this is all a beta. Therefore, you might have to "fix" the scripts. This text file serves as a description of all the parts of LinuxFix, what they do, and how reliable they are.

## Directories :
### LinuxFix :
This is the root directory of the script. Everything is contained within it. Please run any scripts from this directory and not inside the core-files directory.
### LinuxFix/core-files :
This contains most/all of the scripts for LinuxFix. Please do not run the scripts from this directory and only run LinuxFix scripts from the LinuxFix directory. Running from elsewhere may cause some scripts to break.
### LinuxFix/'Old stuff' :
This is where I archive old scripts I don't need anymore. I doubt they will be any use anymore since they've been assimilated into larger scripts but you are welcome to look at them.
### LinuxFix/core-files/settings :
This is not the settings for LinuxFix. This is a database of settings that LinuxFix will use for your computer. Settings contained here are simply copied into your computer's settings.

## Scripts :
### LinuxFixV.2.0 : 
This is the main init script for LinuxFix. It runs a handful of system checks and starts all the other scripts in LinuxFix. However, it is currently undergoing a revamp and it might be better to run each script indivdually.
### ScriptTest :
As the name implies, this is a junk script that I use for testing. It has no significance for LinuxFix
### LinuxFixCore :
This is the counterpart for LinuxFixV.2.0. Don't run this by itself, run LinuxFixV.2.0 Once LinuxFixV.2.0 finishes system checks, it runs this script, which in turn, runs all the other scripts. It is currently being redesigned and although I "think" I fixed it, it still might not work. Run at your own risk
### FileLock :
This script exists for litterally only one purpose, and that's to make sure files in the /etc directory have the right permissions. Examples of this include /etc/passwd and /etc/shadow. There is also a feature that says "potentially dangerous files." Ignore that. Unless there is something REALLY suspicous, it doesn't know what it is looking for. I'm not sure what I was thinking when I made that feature. Other than that, I'm 90% sure it works.
### SoftwareSuperman :
Originally this script just downloaded a handful of useful programs. However, I recently added a feature that configures critical services that makes it one of the biggest scripts. it "should" work, but there is a slight chance it might break. Run it and let me know how it goes.
### FirefoxFix :
This is a script that does firefox settings through bash. While it can be at times convenient, it is more reliable just to do it through the GUI. Furthermore, this script only works on Debian so it's only good in very specific circumstances.
### MP3_Murderer :
This is a simple script that completely finds and destroys any MP3 files. It runs reliably
### ServerSpy :
This is actually a pretty cool script that shows you the home directory of every user on the computer and gives you a glance at crontabs. It is really useful for auditing and can help you find suspicous files. It is also pretty hard to break.
### Update Protocal :
This is another simple script that does updates.Sometimes it is just easier to manually put this in the terminal and it doesn't always work because there are some settings that you need to fix in the GUI first. I need to update this script, lol!
### PasswdHack :
This is by far the most useful script in LinuxFix. Aside from disabling the guest account, it changes everybody's passwords instantly. Just be sure to write the new password down because it works! I have not yet made a feature that allows you to choose the new password so for not it's just (g3_WASD[c00k]
### FirewallForger :
Time to build a wall! or at least a firewall... Because that's what this script does. It hasn't broken yet but that's mainly because it's just 3 commands that you could litterally type into the terminal in the same amount of time. So if you're really THAT lazy, you can use this script to make the firewall for you.
### Graphics :
This script isn't for cyber security puproses. It is a subscript that creates the nice graphics of LinuxFix that appear in your screen occasionally. (it's basically ASCII art) I haven't found too many bugs, but I recently made a few changes and even if there were bugs, they aren't important because this is a graphic script.
### SettingsAssistant :
This is a simple script that copies secure system settings onto your computer. It was broken for a while, but (at least I hope) I've finally fixed it. It is useful, quick, and relatively easy to fix. The actual core of the script is simple and can be done manually if needed.
### HackZap :
This is the oldest of all the scripts. I simply runs through a list of known programs to delete, so it runs reliably. However, I've recently added a feaure that looks for backdoors, and I have not tested it yet. Despite all that, it is still good to manually check for maleware and not just rely on the script.
### Timewarp :
Creates a copy of everything ini case something breaks (a backup essentially)
### AutoUsers :
A beta for automatically adding and deleting users (making sure only authorized users exist) It is not finished and probably never will be though, so I'm not responsible if the script or your computer breaks.

## I think that's it!
I'm surprised you read this far. I "could" go over some of the old scripts, but i think this is sufficent. Have fun using LinuxFix! I hope it helps. Please let me know about any bugs.