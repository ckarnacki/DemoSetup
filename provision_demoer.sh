#!/bin/bash

echo 'What is the name of the new demoer (first and last)? '
read username
usernameArray=($username)
demoer=${username:0:1}${usernameArray[1]}
email="$demoer@pagerduty.com"

curDirs=$(ls)
#echo 1 $curDirs
#echo 2 $(pwd)/$demoer
while [ -d $(pwd)/$demoer ] || grep -i $email instance/main_instance.tf
do
	echo "User already exists, choose another"
	read username
	usernameArray=($username)
	demoer=${username:0:1}${usernameArray[1]}
	email="$demoer@pagerduty.com"
done
mkdir $demoer
echo -e "resource \"pagerduty_user\" \"${usernameArray[0]:0:1}${usernameArray[1]:0:1}\" {\n\tname  = \"$username\" \n\temail = \"$email\" \n\trole  = \"admin\" \n}" >> instance/main_instance.tf

cp demoer_template/* $demoer

files=$(ls $demoer | grep tf)
#echo 4 $files

# Maybe rename append demoer to the end of file names?

for file in $files; do
	#echo 5 changing $demoer'/'$file to contain $demoer instead of template
	sed -i '' "s/template/$demoer/"  $demoer'/'$file
done

for f in $demoer/*.tf; do NEW=${f%_template.tf}_$demoer.tf; mv ${f} "${NEW}"; done
