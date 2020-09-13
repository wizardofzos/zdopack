#!/bin/sh

#
# Script to package a bunch of OMVS and MVS stuff
# into a single shell script...
# make sure to "cp -B" your //'PATH.TO.XMIT' into the USS folder :)


workdir=".pack-work-dir"
medir=$(dirname "$0")


echo "USS-Folder to package (no trailing slash): \c"
read srcuss
echo "Where you want to store it (again, no trainling slash): \c"
read target

mkdir -p  $workdir


if [ -z $srcuss ]; then
  echo "Well, that's easy...."
else
  echo "Paxing your USS folder to $workdir/paxfile"
  pax -s ",$srcuss,distfolder," -wzvf $workdir/file.pax $srcuss
  echo "Mime encoding it to $workdir/mimefile"
  uuencode -m $workdir/file.pax $workdir/mimefile > $workdir/mimefile
  echo "Creating the receiver"
  cat $medir/receive-template.sh $workdir/mimefile > $target/receive.sh
fi

#rm -rf $workdir

