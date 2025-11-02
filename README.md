# README for Cars Script

## Author Information
- **Name:** Beck Orion
- **Course:** CPSC 298 - Computer Science Colloquium
- **Assignment:** Cars script (File I/O; sorting)
- **Date:** 11/2/2025

## Program Description
This program provides an interface to interact with a file that contains information about stored old cars.
It has two modes:
    1: Add a new car
    2: List current cars (sorted by increasing year)
The user can type 3 to exit the program.

## Example Output
When the user starts the script, they will see
```
MENU OPTIONS:
  > Type 1 to add car
  > Type 2 to list inventory
  > Type 3 to exit

Menu option: 
```

### Option 1: Add car
If the user selects this option, they will see an output like this (where actual data replaces the `...`)
```
ADD NEW CAR MODE
  Year: ...
  Make: ...
  Model: ...
ADDED!
```

### Option 2: List cars
If the user choses to list the cars, they will see a sorted list like this:
```
LIST INVENTORY MODE:
  1948:Ford:sedan
  1952:Chevrolet:coupe
  1960:Ford:Mustang
  1972:Chevrolet:Corvette
  1977:Plymouth:Roadrunner
END OF LIST
```

### Invalid input
If the user types an invalid input, they will see an error message and be able to try again.

### Exit
If the user types "3" the menu and program will exit.

## Usage
To run the script interactively:
```bash
./cars.sh
```

To test with an input file (for example, `cars-input`):
```bash
./cars.sh < cars-input
```

## How the Script Works
1. The script begins with a **shebang** (`#!/bin/bash`) and identifying comments.  
2. It **prompts** the user for a choice integer using `read`.  
3. A **while loop** keeps the user in the menu until they want to exit. 
4. The **switch-case statement** performs the correct action based on the user's input.
5. For each valid input, the associated action happens.

## Core Logic Example
Reading input and appending to a file:
```bash
read -rp "  Year: " year
read -rp "  Make: " make
read -rp "  Model: " model
echo "${year}:${make}:${model}" >> my_old_cars
```

Reading, sorting, and displaying the lines of a file:
```bash
while read -r line
do
    echo "  $line"
done < <(sort -t ':' -k1,1n my_old_cars)
```

This while loop works like this:
- First the sort command is given `-t ':'` which tells it to treat a colon as a delimiter (stopping point for reading)
- Then the sort command sees the argument `-k1,1` which tells the sort command to sort by the first field only
- Then the sort command sees `n` which tells it to treat the fields to sort as a number
- Finally the sort command sees `my_old_cars` which is the file to read input from


## Testing Results
When tested with the input file `cars-input` containing:
```
1
1984
Toyota
Supra
2
3
```
The script outputs:
```
MENU OPTIONS:
  > Type 1 to add car
  > Type 2 to list inventory
  > Type 3 to exit

ADD NEW CAR MODE
ADDED!

LIST INVENTORY MODE:
  1948:Ford:sedan
  1952:Chevrolet:coupe
  1960:Ford:Mustang
  1972:Chevrolet:Corvette
  1977:Plymouth:Roadrunner
  1984:Toyota:Supra
END OF LIST

Goodbye!
```

## Example Validations
| Choice | Behavior                     |
|--------|------------------------------|
| 1      | Enters the menu to add a car |
| 2      | Displays the sorted cars     |
| 3      | Exits the menu               |

## Challenges and Solutions
I ran into issues with building the string to append to the file because I was trying to do:
```bash
"${year}:${make}:${model}" >> my_old_cars
```
Which caused the bash interpreter to try and execute a command called the value of the string. The fix was
to update that line to
```bash
echo "${year}:${make}:${model}" >> my_old_cars
```
which redirects the echo output to a file instead of trying to run a command called the string value.

## Known limitations
Because echo only puts a newline after the string it outputs, the `my_old_cars` file must have a newline already in it, otherwise the appending new data code path will put two cars on the same line.

## Resources
I referenced the "Day 09 - The Case Statement Slides" and got help from ChatGPT in building the `sort` command.

### ChatGPT Assistance
I used AI to plan and debug the `sort` statement on line 30. I also used it to clarify why the final code
was correct and needed the flags it does.

I asked ChatGPT the following:
> I have a file called `my_old_cars`. It's data looks like this:
> 
> ```txt
> 1948:Ford:sedan
> 1952:Chevrolet:coupe
> ```
> 
> I would like to do the following:
> 
> 1) Read the lines into my bash script (already done).
> 2) Sort the lines by increasing order using the first numbers before the first colon.
> 3) Print this data for the user to see.
> 
> What's the best way to accomplish this sorting? My current implementation of reading in the cars is just this:
> 
> ```bash
>             while read -r line
>             do
>                 echo "$line"
>             done < my_old_cars
> ```
> 
> I imagine that I need the `sort` command, but I'm not really sure what to do with it.
> 
> Without writing the code for me, how do I get started on this problem?

Then I asked it as a follow up:
> So from what I understand, I need to assemble a sort command that stops at ":", uses the `my_old_cars` file as input, and then passes all that into the while loop. That way the while loop will iterate through the already sorted lines. Is that right?

Thirdly, I asked:
> So would the code look like
>
>```bash
>           echo "LIST INVENTORY MODE:"
>           while read -r line
>           do
>               echo "  $line"
>            done < <(sort ':', my_old_cars)
> ```

Which wasn't quite right. Upon figuring out the missing flags, I asked:
> What do the following parts in the corrected statement do?
> 
> `-t`
> `-k1`
> `,`
> `-1n`

And it told me that the arguments were actually:
`-t ':'` (use colon as delimiter)
`-k1,1` (only look at the first field)
`n` (treat the data as a number)

## License
This project is part of coursework for Chapman University and is intended for educational purposes.
