#!/bin/bash

print_help() {
  echo -e 'Meteor app build - utility wrapper.

  Utility to clone a git repository to a local temp folder, build a meteor app from it and return the compressed file name.

  Options:
  -u : username. eg: felipe@bitbucket.org
  -r : repository url. Path to the repository. eg: felipe/vector.git
  -f : target folder (default /opt/meteor_webapps)
  -h : help.

  Usage:
  $(basename $0) -u "felipe@bitbucket.org" -r "felipe/vector.git"
  '
  exit 0;
}

GIT=$( which git );
METEOR=$( which meteor );

if [ -z "$GIT" -o -z "$METEOR" ] ; then
  echo "ERROR: tool requires both git and meteor utilities to build app";
  exit 1;
fi

while getopts u:r:a:f:h op
do
  case $op in
    u) username=$OPTARG ;;
    r) repo=$OPTARG ;;
    f) meteor_webapps=$OPTARG ;;
    h) print_help ;;
    *) print_help ;;
  esac
done

# Defaults
username=${username:-'felipealvarado@bitbucket.org'};
repo=${repo:-'felipe/vector.git'};
app_name=$( echo "$repo" | awk -F'/' '{print $NF}' | sed 's/.git//g' );
meteor_webapps=${meteor_webapps:-'./meteor_webapps'};
# Validate target folder exists
if [ -e "$meteor_webapps" ] ; then
  mkdir -p $meteor_webapps ;
fi
tempdir=$( mktemp -d );

# Bring repo, build and output tar file
cd $tempdir
git clone https://$username/$repo;
cd $app_name;
meteor build $tempdir
if [ $? -eq 0 ] ; then 
  mv $tempdir/"$app_name"* "$meteor_webapps"/ ;
  rm -rf $tmpdir

  echo "App build can be found here :" ;
  ls $meteor_webapps/$app_name* ;
else
  echo "ERROR: Build problems, please check stdout";
  exit 1;
fi;
exit 0;
