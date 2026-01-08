#!/bin/bash

package=htop

sudo apt install $package >> package_install_results.log

if [ $? -eq 0 ]
then
	echo "The intstallation of $package was successful."
	echo "The new command is available here:"
	which $package
else
	echo "$package failed to install." >> package_install_failure.log
fi

# Another example

directory=/etc

if [ -d $directory ]
then
	echo "The directory $directory exists."
else
	echo "The directory $directory doesn't exist."
fi

echo "The exit code for this script is $?"


# Another example

echo "Hello World"
exit 1
echo $?


