#! /bin/bash
#
# Well, this is kind of ridiculously simple.... for now!

dest=$HOME/public_html/miriad-macport/
files="index.html style.css"

set -e -x

cd web
cp -p $files $dest

for f in /cosmic1/pkwill/miriad/$BADOS/share/doc/miriad/*.ps.gz ; do
    zcat $f |ps2pdf - $dest$(basename $f |sed -e 's/ps.gz/pdf/')
done
