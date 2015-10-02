
This script  places a watermark image on top of the icons for your iOS app by going through each file inside an appiconset folder and rendering the watermark on top of your image.  Tested on XCode 7, OSX 10.11 El Capitan
### Requirements

Install the two dependencies, ImageMagick and Ghostscript.
```sh
$ brew install imagemagick
$ brew install ghostscript
```


## Usage
```sh
  sh tag_icons.sh tag YourProject/Images.xcassets/AppIcons/YourSchema.appiconset/
```
## Before the script

<img src="https://github.com/ursu-daniil/AppIconTagger/blob/master/Before.png" alt="alt text" width="500px" height="280px">


## After running the script:
<img src="https://github.com/ursu-daniil/AppIconTagger/blob/master/After.png" alt="alt text" width="500px" height="280px">

