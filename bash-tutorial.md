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