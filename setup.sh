#!/bin/bash

PROG=`basename $0`
usage()
{
	echo "usage: $PROG CMD"
	echo ' install        : command to install'
	echo ' uninstall      : command to uninstall'
	echo ''
	echo '       -h       : display this help'
	echo ''
	echo 'Installs configuration files in /etc/lightdm/lightdm.conf.d, /etc/lightdm/scripts'
	echo ''
}

# error <error-code> <msg> ...
# if the error code is greater than zero, print the rest
# of the arguments as an error message. If no msg is given
# print "Unknown Error".
error()
{
	NUM="$#"
	if [ $NUM -gt 0 ] && [ "$1" -gt 0 ] ; then
		ERR_NUM=$1
		shift
		NUM="$#"
		if [ $NUM -gt 0 ] ; then
			MSG="$*"
		else
			MSG="Unknown Error"
		fi
		echo "ERROR($ERR_NUM): $*" >&2
		exit $ERR_NUM
	fi
}


CMD=
while getopts ":kh" opt; do
	case $opt in 
		k  ) CODE=1;;
		h  ) usage
				exit 1
				;;
		\? ) usage
				exit 1
	esac
done
shift $(($OPTIND -1))

if [ $UID -ne 0 ] ; then 
	usage
	echo "must be root"
	exit 2
fi

if [ $# -gt 0 ] ; then
	CMD=$1
fi

if [ "$CMD" = "" ] ; then
	usage
	exit 1
fi

copy_files()
{
	echo "Installing Files..."
	errors=0
	cp config/lightdm/lightdm.conf.d/dpms-disable.conf /etc/lightdm/lightdm.conf.d
  [ $? -ne 0 ] && errors=1	
	cp config/lightdm/scripts/dpms-disable /etc/lightdm/scripts
  [ $? -ne 0 ] && errors=1	
	chmod a+x /etc/lightdm/scripts/dpms-disable
  [ $? -ne 0 ] && errors=1	
	return $errors
}

remove_files()
{
	echo "Removing files..."
	rm -f /etc/lightdm/lightdm.conf.d/dpms-disable.conf >/dev/null 2>/dev/null
	rm -f /etc/lightdm/scripts/dpms-disable >/dev/null 2>/dev/null
	rmdir /etc/lightdm/lightdm.conf.d >/dev/null 2>/dev/null
	rmdir /etc/lightdm/scripts >/dev/null 2>/dev/null
}

case $CMD in
	install)
		# create directories for config files.
		echo "Creating directories...."
		mkdir -p "/etc/lightdm/lightdm.conf.d"
		error $? "Failed to create lightdm conf.d directory"
		mkdir -p "/etc/lightdm/scripts"
		error $? "Failed to create lightdm scripts directory"
		
		# copy files
		copy_files
		result=$?
		if [ $result -ne 0 ] ; then
			remove_files
			error $result "Failed to install files!! Installation Aborted."
		fi
		echo "Install Complete"
		;;

	uninstall)
		remove_files
		echo "Uninstall Complete"
		;;

	*)
	usage
	exit 1
esac


