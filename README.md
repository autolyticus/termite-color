# termite-color
A shell script to painlessly switch between termite color schemes

#### Pre-requisites: 

 - fzf
 - bash
 - Termite (obviously)


Recommended: Clone this repo to your termite config folder for seamless integration.

#### Installation:

1. First backup your termite config folder
```
mv ~/.config/termite ~/.config/termite.bak
```
2. Next, clone this repo to your termite config directory
```
git clone https://github.com/reisub0/termite-color ~/.config/termite
```
3. You're done! Copy back your termite config from the backup folder
```
cp ~/.config/termite.bak/config ~/.config/termite/
```
4. (Optional) Make a symlink to /usr/bin so that you can execute it easily
```
sudo ln -s ~/.config/termite/termite-color /usr/bin/termite-color
```

#### Usage:

If you followed step 4
(OR)
```
termite-color set
```
If you haven't
```
cd ~/.config/termite
./termite-color set
```

To see the currently applied theme
```
termite-color
```
