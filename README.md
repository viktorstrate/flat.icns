<p align="center">
  <img width="730" height="323" src="flaticns.png"><br>
  A flat icon set for macOS, for a more uniform dock. Originally by <a href="https://github.com/tinalatif/flat.icns">Tina Latif</a>.
</p>

# Installation

## Method 1: Icon Manager (Recommended)

There are a few icon managers out there. I use and recommend [LiteIcon](http://www.freemacsoft.net/liteicon).

Just drag and drop the icons onto their corresponding applications, and then log out and back in to refresh the dock.

## Method 2: Automated Script

The Automated Script downloads the latest flat.icns zip and replaces the icons for you.

Open the terminal and run this command, to download and execute the script

```shell
curl https://raw.githubusercontent.com/tinalatif/flat.icns/master/install.sh | sudo sh
```

Note: The script isn't perfect and doesn't have a revert option, use with conscience.
</br> This will be updated in near future.

## Method 3: Manual installation

Some programs may require manual installation (for example, if they are not directly in the Applications folder). The icns folder contains all the .icns files for this.

1. Find the .icns file for the program
2. Navigate to the program
3. Right-click on the program and select 'Get Info'
4. Drag the .icns file onto the existing icon for the program in the info panel

### To install the Calender app:
1. Choose which icons you want to use from the flaticns folder and change the names to 'App.icns' and 'App-empty.icns' by right-clicking and selecting 'Get Info'
2. Go to Applications, right click on the Calendar app, and select "Show Package Contents"
3. Navigate to Calendar.app/Contents/Resources to find the 'App.icns' and the 'App-empty.icns' (recommended to make a back-up of these!)
4. Drag the .icns files from the flaticns folder into the Calendar app's to overwrite it.
5. Navigate to Calendar.app/Contents/Resources/Calendar.docktileplugin/Contents/Resources
6. Repeat step 4
7. Go to terminal and enter "killall Dock" to refresh your dock

## Flat dock

For the best results, I recommend you use a [2D dock instead of a 3D dock](http://hints.macworld.com/images/105dockcomparo.jpg).

## Requests

If you want an icon that's not there, the preferred way of requesting is to file an issue for it.

## Contribute

If you want to add icons, I've provided a template for the size.
</br>Use the red as a guideline for centered icons.
