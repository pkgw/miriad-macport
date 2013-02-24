#! /bin/bash

dest=cfa0:public_html/miriad-macport/
maninst=/a/share/doc/miriad
files="index.html style.css"

set -e
cd web

workdir=$(mktemp -d)
echo "work: $workdir"

echo "files: $files"
cp -p $files $workdir

for f in $maninst/*.ps.gz ; do
    echo "pdf: $(basename $f |sed -e 's/ps.gz/pdf/')"
    d=$workdir/$(basename $f |sed -e 's/ps.gz/pdf/')
    zcat $f |ps2pdf - $d
done

cd $workdir
echo "dest: $dest"
echo =======================
scp -r . $dest
echo =======================
cd /
rm -rf $workdir
echo ok
