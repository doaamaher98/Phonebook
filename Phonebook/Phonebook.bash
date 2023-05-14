#!/bin/bash

# A database file to store the contacts in the Phonebook
file=Phonebook_database.txt

# Global var
i=0

# Checking if the database file didn't exist, then Make one.
if ! [ -f "$file" ]; then #file not exists
    clear
    echo "File does not exist! Creating a New Database..."
    echo "-----------------------------------------------"
    touch Phonebook_database.txt
    
    echo "Done, Database file is ready!"
    echo "-----------------------------"
    echo "-----------------------------"
fi 

# Showing the Menu & options for the user to choose.
if [ -z $1 ];then
	echo ">>>>>>>>>>>> MENU OPTIONS <<<<<<<<<<<<<<"
	echo "----------------------------------------"
	echo "|  Add a new Contact 		[-a]   |"
	echo "|  Search for a Contact 	[-s]   |"
	echo "|  Delete a Contact		[-d]   |"
	echo "|  View all Contacts 		[-v]   |"
	echo "|  Delete all Contacts 		[-o]   |"
	echo "|  Exit Menu			[-x]   |"	
	echo "----------------------------------------"
fi

#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
# Checking each Choice
# 1- Adding a New Contact
if [[ $1 == "-a" ]] ;then
	clear
	echo "Add a new Contact"
	echo "------------------"
	
	# Data Entry from User.
	read -p "Enter First Name: " firstName
	read -p "Enter Last Name: " lastName
	read -p "Enter Phone Number: " phoneNumber
	
	# Echoing the Data into the Phonebook_database to store it by Concatination.
	echo $firstName $lastName $phoneNumber >> Phonebook_database.txt
	echo "$firstName is Added Successfully!"
fi
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#
# 2- Searching for a Contact
if [[ $1 == "-s" ]] ;then
	clear
	echo "Search for a Contact"
	echo "--------------------"
	
	# Taking the Phone Number to search for.
	read -p "Enter Phone Number to be searched for : " search_phone_num
	
	# Creating a variable and store in it the searching of this search in the Phonebook_database file
	found=$(grep $search_phone_num $file)
	
	# If Contact isn't found, Echo not found [didn't find the match]
	if  [ -z "$found" ] ;then
	echo "Contact Doesn't Exist"
	# Search for the Contact Number at the lines presented at the database file, looping through those lines & reading them using a 
	# while do loop
	else 
	echo "Contact Found!"
	echo "---------------"
	grep $search_phone_num $file | while read -r line ; do
	# Increment the global var to move to the next file to search.
	i=$[ $i +1 ]
	# Echo the found Contact line & Command
    	echo "$i $line"
	done
	fi
fi
#""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""#




# 3- Deleting all Contacts & database file
if [[ $1 == "-o" ]] ;then
	read -p "Are you sure you want to delete all Contacts & Database file? (y/n)" ans
	if [[ $ans == 'Y' || $ans == 'y' ]];then
	echo "Deleted all Contacts Successfully!"
	 rm $file
	elif [[ $ans == 'N' || $ans == 'n' ]];then
	echo "Glad to Know! :)"
	else
	echo "Invalid Input, Try Again."
	fi
fi


# 4- View All Contacts
if [[ $1 == "-v" ]] ;then
	view_contacts=$(<Phonebook_database.txt)
	if [[ $view_contacts ]];then
		clear
		cat Phonebook_database.txt
	elif [[ ! $view_contacts ]];then
		clear
		echo "Phone book is Empty!"
	else
		clear
		echo "Invalid Entry, Try Again."
	 fi
fi


# 5- Delete Contact
if [[ $1 == "-d" ]] ;then
	clear
	# Searching for a Contact's Name
	echo "Search for Contact to be Deleted"
	read -p "Enter Name : " search_del
	# Check if it existed
	found=$(grep $search_del $file)
	if  [ -z "$found" ] ;then
	echo "No Item found"
	# Exists
	else 
	# Taking the Phone Number
	read -p "Enter Phone Number : " deleteNo
	i=0
	# Looping into the database to find the Number to be Deleted.
	grep $deleteNo $file | while read -r line ; do
	i=$[ $i +1 ]
	# Delete the match from the database.
	sed -i /"$deleteNo"/d Phonebook_database.txt
	echo "Delete Successfully"
	done
	fi		
fi



# 6- Exit Menu
if [[ $1 == '-x' ]]; then
	clear
	read -p "Are you sure you want to exit (y/n)?" answer
	if [[ $answer == 'y' || $answer == 'Y' ]];then
		 
		echo ">>>>>>>>>>>> Thank You for using my Phonebook! <<<<<<<<<<<<"
		echo "------------------------  Byeee ---------------------------"
	
	exit
	elif [[ $answer == 'n' || $answer == 'N' ]];then
	echo "Thank you for STAYING :)"
	echo "------------------------"
	
	else
	echo "Invalid Entry! Try Again..."
	fi	

fi
