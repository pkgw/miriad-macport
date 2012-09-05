#! /bin/bash
#
# Well, this is kind of ridiculously simple.... for now!

desthost=cfa0
destdir=/data/wdocs/pwilliam/www-docs/miriad-macport/
maninst=/opt/miriad/share/doc/miriad
files="index.html style.css"

set -e -x

cd web
scp -p $files $desthost:$destdir

for f in $maninst/*.ps.gz ; do
    d=$destdir$(basename $f |sed -e 's/ps.gz/pdf/')
    ssh $desthost "zcat |ps2pdf - $d" <$f
done
