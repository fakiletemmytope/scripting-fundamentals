#!/bin/bash

echo "Welcome to todo app"

file="$HOME/todo.txt"
displayMenu () {
    echo -e "View all tasks: press v or V\n"
    echo -e "Add a new task: press a or A\n"
    echo -e "Delete a task: press d or D\n"
    echo -e "Exit the program: press E or e\n"
}

display="displayMenu"
condition=true
while $condition; do
    $display
    read -p "Enter your choice: " userInput    
    case $userInput in
        a | A)
            echo -e "\n"
            read -p "Enter task details: " task
            if [ -f "$file" ]; then
                echo $task >> $file
            else
                touch $file
                echo $task > $file
            fi
            echo -e "\nTask added\n";;
        v | V)
            if [ -f "$file" ]; then
                cat -n $file
            else
                echo -e "\nNo task available\n"
            fi  
            ;;
        d | D)
            read -p "Enter task number: " number
            # Check if input is a number using regex
            if [[ $number =~ ^[0-9]+$ ]]; then
                # check the number of lines in file
                lines=$(wc -l < $file)
                if [ $number -gt $lines ]; then
                    echo -e "\n task doesn't exist"
                else
                    # delete line in todo file if the line exists
                    sed -i "${number}d" $file
                    echo -e "\nTask deleted"
                fi
            else
                echo "Not a valid number."
            fi            
            ;;
        e | E)            
            echo -e "\nAbout to exit"
            condition=false;; 
        * )
            echo -e "\nInvalid input" ;;
    esac
done
