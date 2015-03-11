#!/bin/bash
{
CWD="$PWD"
echo CWD=$CWD

updversion ()
{
  BASE=$(basename $1)
  DIRE="$(dirname $1)/$BASE"
  pushd "$DIRE"
  LASTCOMMIT=$(git log --pretty=format:%H --max-count=1 -- .)
  COMMITDATE=$(git log --date=short --pretty=format:%ad --max-count=1 -- .)
  echo COMMITDATE=$COMMITDATE
  sed 's/\(creationDate>\)[^<]\+/\1'"$COMMITDATE"'/' -bi "$BASE.xml"
  VER=$(git describe $LASTCOMMIT | sed 's/^v//');
  echo VER=$VER
  sed 's/\(version>\)[^<]\+/\1'"$VER"'/' -bi "$BASE.xml"
  NEWVERSION=$(grep '</version>' $BASE.xml | sed 's#.*n>\([^<]*\)</v.*#v\1#')
  export GZIP=-9
  ARC="$CWD/$BASE-$NEWVERSION-$COMMITDATE.tar.gz"
  echo ARC=$ARC
  tar -czf "$ARC" .
  popd
}

updversion cf

}