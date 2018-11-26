<p align="center">
  <img width="730" height="323" src="flaticns.png"><br>
  A flat icon set for macOS, for a more uniform dock. Originally by <a href="https://github.com/tinalatif/flat.icns">Tina Latif</a>.
</p>

# About this fork

This is a [fork](https://help.github.com/articles/fork-a-repo/) of the original repository by Tina Latif.
I have made this fork, to keep the project alive and up to date with icons for new apps.

I have tried to make the project more generic, by replacing the Adobe Illustrator files with svg files. Which makes it easier for people without Creative Cloud to contribute.
Some new scripts have been added to make it easier to convert svg files to icns and png, see [contributing](https://github.com/viktorstrate/flat.icns#contribute).

# Installation

> NOTE: To change icons for system apps (App Store, Safari, Mail etc.) on computers running OS X El Capitan (version 10.11) and later, system integrity protection must be disabled. [Read more about SIP and how to disable it.](https://www.howtogeek.com/230424/how-to-disable-system-integrity-protection-on-a-mac-and-why-you-shouldnt/)

## Method 1: Automator application
The easiest way to install the icons, is to use the `Update flat icons` application, which is included with this repository.
This method uses the automated script under the hood, and does the therefore not change system icons.

1. Download the iconpack [here](https://github.com/viktorstrate/flat.icns/archive/master.zip), or by clicking `Clone or download` -> `Download ZIP`
2. Doubleclick on the `Update flat icons` application, and follow the instructions.

## Method 2: Automated script
The fastest way to install the icons, is using the `install.sh` script.
This method in does only install icons for applications, and does therefore not replace system icons, like folders.
To change system apps, it is recommended to use an icon manager as described with method 2.

1. Download the iconpack [here](https://github.com/viktorstrate/flat.icns/archive/master.zip), or by clicking `Clone or download` -> `Download ZIP`
2. Open `Terminal`, by searching for it with Spotlight (`⌘`+`Space`).
3. Drag 'n drop `install.sh`, from the downloaded folder, to the `Terminal` window.
4. Press enter to start installation

To restore the icons, run `./install.sh restore`

## Method 3: Icon Manager

There are a few icon managers out there. I use and recommend [LiteIcon](http://www.freemacsoft.net/liteicon).

Just drag and drop the icons onto their corresponding applications, and then log out and back in to refresh the dock.

## Method 4: Manual installation

Some programs may require manual installation (for example, if they are not directly in the Applications folder). The icns folder contains all the .icns files for this.

1. Find the .icns file for the program
2. Navigate to the program
3. Right-click on the program and select 'Get Info'
4. Drag the .icns file onto the existing icon for the program in the info panel

### To install the Calender app:
1. In Finder, in the menu bar, navigate to `Go` -> `Go to Folder` (<kbd>⇧</kbd><kbd>⌘</kbd><kbd>G</kbd>),
a popup should appear
2. Type the following path `/Applications/Calendar/Contents/Resources/`, and press `Go`
3. Find the file named `App.icns` and rename it to `App backup.icns`
4. Find the folder named `Calendar.docktileplugin` and rename it to `Calendar.docktileplugin backup`
5. Copy the icon you want to use for the calendar app from `./icns/`
6. Paste the copied icon into the `Resources` folder, you navigated to in step 2
7. Rename the newly pasted icon to `App.icns`
8. Go to terminal and enter "killall Dock" to refresh your dock, or log out and back in again


# Requests

If you want an icon that's not there, the preferred way of requesting is to file an issue for it.

You are more than welcome to send a pull request with a new icon, see [contribute](https://github.com/viktorstrate/flat.icns#contribute).

# Contribute

## Step 1: Making icons
If you want to add icons, I've provided some [templates](https://github.com/viktorstrate/flat.icns/tree/master/templates) for the size.
Use the red as a guideline for centered icons.

## Step 2: Saving and generating required files
Before you can send a pull request, you must generate a 1024x1024 size PNG image, and a ICNS file, these image files are required to install the icon pack.

1. Save the icon to `./vectors` as an svg file.

2. Generate required files, by running `./build.sh -ai` from the terminal. You might need some dependencies for the script to work.

The easiest way to install the dependencies is by using [Homebrew](https://brew.sh/), which you can install from their website. After installing Homebrew run the following command from the terminal.

```shell
brew install imagemagick libicns rsvg-convert
```

