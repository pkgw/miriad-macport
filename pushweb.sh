#! /bin/bash
#
# Well, this is kind of ridiculously simple.... for now!

dest=$HOME/public_html/miriad-macport/
files="index.html style.css"

set -e -x

cd web
cp -p $files $dest
