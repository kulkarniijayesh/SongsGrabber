#!/bin/bash

showPlaylists() {
	echo "Available playlists - "

	counter=1

	for i in $(ls *.txt)
		do
		echo $counter : $i
		counter=$(( counter++ ))
		done


}

burnSongs(){

echo "Burning songs from playlist $1 to drive - " $2

outFolderName=${1%.*}
echo "Output folder will be: " $2/$outFolderName/


mkdir $2/$outFolderName 2>/dev/null


outFolderName=$2/$outFolderName

local IFS=$'\n'
for i in $(cat $1)
do
	cp $i $outFolderName	
done

echo "Your jukebox is ready!"



}

echo "Running SongsGrabber for " $(whoami)


if [ -z $1 ]
then
	showPlaylists
else
	echo "Selected Playlist - " $1
	if [ $(ls $1 2> /dev/null | wc -l) == 0 ]
	then
		echo "This playlist is not valid!"
		showPlaylists
		exit
	fi

	if [ -z $2 ]
	then
		echo "Ouput location can not be empty!"
	else
		if [ $(ls $2 2> /dev/null | wc -l ) == 0 ]
		then
			echo "Provided output location is not valid."
			exit
		else
			[ -w $2 ]
			if [ $? -ne 0 ]
			then
				echo "It seems like you don't have access to provided output location."
				exit
			fi
		fi
	fi

	#Now burning the songs to output location
	burnSongs $1 $2

fi







