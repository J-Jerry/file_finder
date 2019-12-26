#!bin/bash
clear
wc -w MPNS.txt > columns     #counts quantity of words and place them into columns file
i=$(cut -dM -f1 columns)

echo "Searching $i libraries...." #prints quantity of libraries that user needs
rm columns > /dev/null 2>&1

rm -r info_lib > /dev/null 2>&1
rm -r custom_lib > /dev/null 2>&1
#rm libraries_not_found.txt
#rm libraries_found.txt
mkdir custom_lib
mkdir info_lib


#Creating empty files
touch libraries_found.txt
touch libraries_not_found.txt

while read line
do
	
	if [ $line != " " ] ; then
         grep -ri "$line" Libraries > found_in_all_locations.txt 
         sed -n '1p' found_in_all_locations.txt > found_in_single_loc.txt
	 str=$(cut -d: -f1  found_in_single_loc.txt) 
         str_len = ${#str} 

         if [ $str != ""]; then
          echo "$str<---->$line" >> libraries_not_found.txt 
         else
          echo "$str<---->$line" >> libraries_found.txt
         fi

 	else
	 echo "nothing" > /dev/null 2>&1

	fi
	
	cp ${str} custom_lib/.

done < MPNS.txt >/dev/null 2>&1


#Counting number of libraries found
if [ -s libraries_found.txt ]; then #if file is not empty
  while read line_found
  do
	if [ $line_found != " " ] ; then
	let val_line+=1
	fi

  done < libraries_found.txt
fi

#Counting  number of libraries not found 
if [ -s libraries_not_found.txt ]; then  #if file is not empty
  while read line_not_found
  do
    if [ $line_not_found != " " ] ; then
     let val_line_n+=1
    fi

  done < libraries_not_found.txt
fi
echo ""
echo "\e[0;32m Libraries found: $val_line \e0"
echo ""
echo "\e[0;31m Libraries not found: $val_line_n \e[0m"
mv libraries_found.txt info_lib
mv libraries_not_found.txt info_lib
rm found_in_all_locations.txt
rm found_in_single_loc.txt
echo "" 
echo ""
echo " Please check custom_lib and info_lib directories                 "
echo "                                                                  "
echo " Thanks for use this script !!                                    "
echo ""
echo "                                     Created by Gerardo Alvarez :)"
