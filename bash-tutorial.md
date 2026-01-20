# Bash Scripting Tutorial

Learn Linux TV - Youtube

## Class 1: Introduction

Bash is a command interpreter or 'Shell' used on Linux or Unix  systems
However, Bash is basically a programming language

### Course Outline

1. Class 1: Introduction & Welcome
2. Class 2: Hello World
3. Class 3: Variables
4. Class 4: Math Functions
5. Class 5: If Statements
6. Class 6: Exit Codes
7. Class 7: While Loops
8. Class 8: Universal Script Update
9. Class 9: For Loops
10. Class 10: Filesystem Locations for Scripts
11. Class 11: Data Streams
12. Class 12: Functions
13. Class 13: Case Statements
14. Class 14: Scheduling Jobs (Part 1)
15. Class 15: Scheduling Jobs (Part 2)
16. Class 16. Arguments
17. Class 17: Creating a Backup Script
18. Class 18: Closing

## Class 2: Hello World

Bash is a Shell, anytime we open a terminal on a Linux or a Unix system and enter commands, we are interacting with a Shell. The Shell allows us to enter commands and then it presents us with results of those commands as output.

ls = list storage

A script can incorporate commands to automate processes.

The default Shell on most Linux systems is Bash, o determine which Shell you are actually using:

~~~s
echo $SHELL
~~~

Creating a basic script:

~~~s
nano myscript.sh
~~~

To execute the script, it first needs to be marked as executable.
Need to edit the execute permissions to enable us to execute the text file as if it were a program or a script.

~~~s
chmod +x myscript.sh
~~~

To run/execute the script:

~~~s
./myscript.sh
~~~

The `.sh` is not actually required, but it is standard practice. However, there are bash scripts without the `.sh` extension.
myscript.sh == myscript

If the name isn't structued with `.sh`, how can you know it's a Bash script?
A Bash script will have something very specific as the first line -- **shebang**

~~~s
#!/bin/bash
~~~

The shebang tells the script which interpreter the script is supposed to use. We are calling bash, and so this will always execute using Bash.

## Class 3: Variables

Variables allow us to save information for later use.

To declare a variable (no spaces):

~~~s
myname="Emily"
myage=24
~~~

How to reference a variable?
One way is to print the contents of it.

Whenever we reference a variable in bash, we have to include a `$` in front of the name of the variable.

~~~s
echo $myname
~~~

When a variable is declared, it is tied to the active session, so closing the terminal/current session will delete the variables.

Can avoid manually inputting the variables each time by using a script.

~~~s
nano aboutme.sh
~~~

A variable needs to be referenced in double quotes.

~~~s
echo "Hello, my name is $myname."
> Hello, my name is Emily.

echo 'Hello, my name is $myname.'
> Hello, my name is $myname.
~~~


Note: in Nano, CTRL+K deletes an entire line


Capture the output of a command and store it in a variable.

~~~s
files=$(ls)

echo $files
~~~

The `$(ls)` is a *subshell*, which allows you to execute a command in the background. So the output isn't shown, but the output has been saved to the variable.

It is proper etiquette to use lowercase for variables.

### Default/Environment Variables

Within your environment there are many default variables that are always declared.

E.g., `$USER` which contains the name of the user currently logged in

To list which environment variables you have within the session:

~~~s
env
~~~

## Class 4: Basic Math

Shells handle math differently than programming languages.

Bash has the *evaluate expressions* command which is abreviated `expr`.

~~~s
expr 30 + 10
expr 30 - 10
expr 30 / 10
expr 30 \* 10
~~~

`*` is a wildcard, so for multiplication you need to escape out the asterisk (`\*`).

Math functions can be used with variables too.

~~~s
mynum1=100
expr $mynum1 + 50

mynum2=88
expr $mynum1 - $mynum2
~~~

Can also use `$(())` for numeric calculations. It also allows for easier multiplication.

~~~s
echo $(($mynum1 + $mynum2))

echo $(($mynum1 * 2))
~~~


## Class 5: If Statements

An *if statement* begins with the word 'if' followed by some sort of test case (evaluates something).
On the following line is *then* - what will happen if the condition is met (evaluates to True). The thing that happens is indented.
The if statement is closed with *fi*.

If Statements are the most useful when they use a condition that can change.

~~~s
mynum=200

if [ $mynum -eq 200 ]
then
    echo "The condition is true."
fi
~~~

`-eq`-is *equal*.
The echo statement will only run if the condition is True.

~~~s
mynum=200

if [ $mynum -eq 200 ]
then
    echo "The condition is true."
else
    echo "The variable does not equal 200."
fi
~~~

~~~s
mynum=200

if [ ! $mynum -eq 200 ]
...
~~~

The `!` reverses the check - so if $mynum is NOT equal to 200. But, it is better in this case to use `-ne` or 'not equal'.

~~~s
if [ $mynum -ne 200 ]
...
~~~

Other examples:
`-gt` : greater than
`-ge` : greater than or equal to
`-lt` : less than
`-le` : less than or equal to


### Check Existence of File

~~~s
if [ -f aboutme.sh ]
then
    echo "The file exists."
else
    echo "The file does not exist."
fi
~~~

`-f` is a check for a file.

### Which Command

Linux has the `which` command - can find whether an application or binary command is present of the filesystem.

~~~s
which python
> /c/Users/User/AppData/Local/miniconda3/python
~~~

It can be used in a script too.

### Bash Script for Installing a Program If It Doesn't Exist

~~~s
#!/bin/bash

command=/usr/bin/program

if [ -f $command ]
then
    echo "$command is available, let's run it..."
else
    echo "$command is not available, installing it..."
    sudo apt update && sudo apt install -y program
fi

$command
~~~

`sudo apt update` command - the apt makes it so the update doesn't update packages, but synchronize with the mirror (the repository)
`&&` allows us to chain commands - if the *sudo apt update* is successful it will immediately run the second command
`sudo apt install -y program` where *-y* assumes yes, so no prompt given (useful for automation)

A better version of the script:

~~~s
#!/bin/bash

command=htop

if command -v $command
then
    echo "$command is available, let's run it..."
else
    echo "$command is not available, installing it..."
    sudo apt update && sudo apt install -y $command
fi

$command
~~~

The brackets after the if statement have been removed. Brackets are only needed if running a test command. Instead we are using a normal command.
`command -v` is a command that checks for the existence of a command.


## Class 6: Exit Codes

Exit codes allow us to determine whether the command was successful or not. 

Bash represents success or failure using a variable that contains an exit code -- `$?`

~~~s
ls -l /etc

echo $?
> 0

ls -l /misc

echo $?
> 2
~~~

`0`: success
`1 - 125`: standard errors (general, file issues, permissions, etc.)
`126 - 127`: shell-specific (command execution failures)
`128 - 165`: signal-related exits
`166 - 254`: user-defined (scripts/apps can use freely)
`255`: reserved (out of range workflow)

~~~s
#!/bin/bash

package=htop

sudo apt install $package

if [ $? -eq 0 ]
then
    echo "The installation of $package was successful."
    echo "The new command is available here:"
    which $package
else
    echo "$package failed to install."
fi
~~~

`>>` is a redirect.

~~~s
#!/bin/bash

package=htop

sudo apt install $package >> package_install_results.log

if [ $? -eq 0 ]
then
    echo "The installation of $package was successful."
    echo "The new command is available here:"
    which $package
else
    echo "$package failed to install." >> package_install_failure.log
fi
~~~

The 'sudo apt install $package' output will not be printed in the terminal, and will just be found in the package_install_results.log
'$package failed to install.' will not print in the terminal, but will be added to the package_install_failure.log

~~~s
directory=/etc

if [ -d $directory ]
then
    echo "The directory $directory exists."
else
    echo "The directory $directory doesn't exist."
fi

echo "The exit code for this script is $?"
~~~

This doesn't work as intended, because the exit code is based on the echos being able to run, not if the directory exists.
This is why testing is important!

### Manipulating the Exit Code

~~~s
#!/bin/bash

echo "Hello World"
exit 1
echo $?

> Hello World
~~~

Does not output the $?, because `exit 0` will exit the script with whatever exit code is given (in this case 0). Nothing below the exit will be run, so the `echo $?` will never run.


## Class 7: While Loops

A *While Loop* allows us to continually do something until a particular condition is met.

~~~s
#!/bin/bash

myvar=1

while [ $myvar -le 10 ]
do
    echo $myvar
    myvar=$(( $myvar +1 ))
    sleep 0.5
done
~~~

The script counts from 1 to 10 in +1 increments.

## Class 8: Update Script

Creation of a *Universal Update Script*.
This script will be updated over the course of the classes, so initially there will be some reducancies and issues.

Two `if` statements that check for a directory, then acts accordingly.

~~~s
#!/bin/bash

if [ -d /etc/pacman.d ]
then
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu
fi

if [ -d /etc/apt ]
then
    # The host is based on Debian or Ubuntu,
    # Run the apt version of the command
    sudo apt update
    sudo apt dist-upgrade
fi
~~~

`sudo apt update` has the system check the repository server (catalogs the software that is available on that server) and refreshes its local index.

Updating the file:

~~~s
#!/bin/bash

release_file=/etc/os-release

if grep -q "Arch" $release_file
then
    # The host is based on Arch, run the pacman update command
    sudo pacman -Syu
fi

if grep -q "Ubuntu" $release_file || grep -q "Ubuntu" $release_file
then
    # The host is based on Debian or Ubuntu,
    # Run the apt version of the command
    sudo apt update
    sudo apt dist-upgrade
fi
~~~

`/etc/os-release` is a file that contains release/distribution information.
`grep` is a standard linux command that searches text files specific strings/regular expressions
`-q` means 'quiet mode' = won't print on screen.

No brackets as we are not using the Test command, instead using a Linux command (however, Linux commands can be used as the conditions for a test command).

`||` is a pipe which means *OR* = if either side evaluates to TRUE, then the check statment is also true, and the command can be run.
`&&` = *AND* = both statements have to be TRUE

## Class 9: For Loops

A `For Loop` allows you to perform a task repeatedly for every item in a set.
An *if statement* performs a task once if a certain set of conditions evaluate to True, whereas a *for loop* performs a task or a set of tasks over and over until a particular state is reached.

When the loop iterates over the final element in the set, the loop is done and it exits.

~~~s
#!/bin/bash

for n in {1..10}
do
    echo $n
    sleep 1
done

echo "This is outside of the for loop."
~~~

`{1..10}` = 1 2 3 4 5 6 7 8 9 10

A more useful example, that will look through a directory and for every file that ends in `.log`, it will run a tar command to make a zipped file. The compressed file is called a *tarball*.

~~~s
#!/bin/bash

for file in logfiles/*.log
do
    tar -czvf $file.tar.gz $file    # filename will be filename.log.tar.gz, then $file is the file to be compressed
done
~~~

v = verbose

This script can be used if we want to compress a large amount of files.