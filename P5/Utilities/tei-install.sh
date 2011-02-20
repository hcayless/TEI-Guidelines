#!/bin/bash
#
# Install TEI packages on web site
#
# Sebastian Rahtz, March 2011
# copyright: TEI Consortium
# license: GPL
#
die()
{
    echo; echo
    echo "ERROR: $@."
    D=`date "+%Y-%m-%d %H:%M:%S"`
    echo "$D. That was a fatal error"
    exit 1
}

Vault=/projects/tei/web/Vault
Jenkins=http://tei.oucs.ox.ac.uk/jenkins/job
ECHO=
version=
package=TEIP5-Release
while test $# -gt 0; do
  case $1 in  
    --dummy)       ECHO=echo;;
    --package=*)   package=`echo $1 | sed 's/.*=//'`;;
    --version=*)   version=`echo $1 | sed 's/.*=//'`;;
   *) if test "$1" = "${1#--}" ; then 
	   break
	else
	   echo "WARNING: Unrecognized option '$1' ignored"
	   echo "For usage syntax issue $0 --help"
	fi ;;
  esac
  shift
done
dir=${Jenkins}/${package}/lastSuccessfulBuild/artifact
echo Try to fetch $version package from $dir
case $package in 
  Roma)          name=Roma;        pname=tei-roma;;
  TEIP5-Release) name=P5;          pname=tei;;
  Stylesheets)   name=Stylesheets; pname=tei-xsl;;
    *) echo "Error: package $package unsupported"; exit 1;;
esac

${ECHO} curl -O -s $dir/${pname}-${version}.zip || \
    die "Unable to fetch package $dir/${pname}-${version}.zip"
${ECHO} unzip -o ${pname}-${version}.zip -d /usr/share
${ECHO} mkdir -p ${Vault}/${name}/${version}
${ECHO} unzip -o ${pname}-${version}.zip -d ${Vault}/${name}/${version}
${ECHO} rm ${Vault}/${name}/current
${ECHO} ln -s ${Vault}/${name}/${version} ${Vault}/${name}/current

