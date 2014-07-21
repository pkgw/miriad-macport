#! /bin/bash

desthost=newton.cx
destpath=public_html/files/mirstage.tgz
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
chmod 644 *
echo "tar: mirstage.tgz"
tar czf mirstage.tgz *

echo "dest: $desthost:$destpath"
echo =======================
scp mirstage.tgz $desthost:$destpath
echo =======================
cd /
rm -rf $workdir
echo ok

echo
echo "cleanup: ssh $desthost rm $destpath"
echo "[on cfa0] deploy: curl http://newton.cx/~peter/files/mirstage.tgz |tar xz -C public_html/miriad-macport"
