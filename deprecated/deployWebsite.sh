#!/bin/bash

myDate=`date '+%Y%m%d'`
filename="BPAWebsite_${myDate}"
keyFile="/home/ajmanly/bluehost"
remoteUN="kslnvlmy"
remoteHost="bremertonpilotsassociation.org"
remoteDirectory="/home1/kslnvlmy/www"

if [ -f "${filename}.tgz" ]
then
  echo "${filename}.tgz already exists - skipping creation"
else
  if [ -d public ]
  then
    cd public
    if [ -d images ]
    then
      echo "images not there. Linking..."
      rm -r images
      ln -s ../BPAStaticContent/images images
    fi
   
    if [ -d Documents ]
    then
      echo "Documents directly not there. Linking..."
      rm -r Documents
      ln -s ../BPAStaticContent/Documents Documents
    fi
    cd ..
  
    if [ ! -e "${filename}.tgz" ]
    then
      echo "Creating tarfile..."
      tar cvfz "${filename}.tgz" public --transform s/public/${filename}/
      echo "Done."
    else
      echo "The tarfile \"${filename}.tgz\" already exists. Please remove or rename and try again"
    fi
  fi
fi

# File Upload
echo "Would you like to upload the newly created file to the server? [y/n]"
read fileUploadAnswer
case ${fileUploadAnswer} in
  Y|y) 
    echo "Uploading"
    scp -i ${keyFile} ${filename}.tgz ${remoteUN}@${remoteHost}:${remoteDirectory}/${filename}.tgz
    ;;
  N|n)
    echo "You said NO!"
    ;;
esac

# File Cleanup
echo "Moving the file to the archive"
if [ ! -f ARCHIVE/${filename}.tgz ]
then
  mv ${filename}.tgz ARCHIVE
  echo "Done."
else
  echo "Oops! It looks a file with the same name is already in the ARCHIVE directory. I'll let you deal with it!"
fi
