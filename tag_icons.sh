# Overlay the build version and the git hash on the app icon
#
# Inspired by @merowing and @bejo script
# who were inspired initially by Evan Doll's talk
#
# http://www.merowing.info/2013/03/overlaying-application-version-on-top-of-your-icon/#.VCg9li5_v6A
# https://github.com/bejo/XcodeIconTagger/blob/master/tagIcons.sh



# script subcommands
mode=$1
tagMode="tag"
cleanupMode="cleanup"

function processIcon() {
    export PATH=$PATH:/usr/local/bin:/opt/boxen/homebrew/bin/
    icon_path=$1
    width=`identify -format %w ${icon_path}`
    height=`identify -format %h ${icon_path}`
    #create a resized watermark image which will be placed above the original image
    convert $(dirname $0)/watermark.png -resize ${width}x${height} ${icon_path}.watermark
    #apply it on top of the original image
    composite  -gravity center -quality 100 ${icon_path}.watermark ${icon_path} ${icon_path}
    #remove the resized image as it not needed.
    rm ${icon_path}.watermark
    echo "Icon '$icon_path' updated"
}

# retrieve the icon list from the assets catalogue
iconsDirectory=`cd $2 && pwd`
if [ $(echo "${iconsDirectory}" | grep -E "\.appiconset$") ]; then
    icons=(`grep 'filename' "${iconsDirectory}/Contents.json" | cut -f2 -d: | tr -d ',' | tr -d '\n' | tr -d '"'`)
else
    icons=(`/usr/libexec/PlistBuddy -c "Print CFBundleIconFiles" "${INFOPLIST_FILE}" | grep png | tr -d '\n'`)
fi

iconsCount=${#icons[*]}
for (( i=0; i<iconsCount; i++ ))
do
    icon="$iconsDirectory/${icons[$i]}"

    if [ -f $icon ]; then
        if [ $mode == $tagMode ]; then
            # tag it
            processIcon $icon
        else
            echo " ! Unknown mode `$mode`"
        fi
    else 
        echo " ! No icon for path `$icon`" 
    fi
done
