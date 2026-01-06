#!/bin/bash

mynum=200

if [ $mynum -eq 200 ]
then
	echo "The condition is true."
else
	echo "The variable does not equal 200."
fi

if [ -f aboutme.sh ]
then
	echo "The file exists."
else
	echo "The file does not exist."
fi

