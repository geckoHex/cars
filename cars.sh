#!/bin/bash
# cars.sh
# Beck Orion

echo "MENU OPTIONS:"
echo "  > Type 1 to add car"
echo "  > Type 2 to list inventory"
echo "  > Type 3 to exit"
echo ""

read -rp "Menu option: " choice

while [ "$choice" -ne 3 ]
do
    case "$choice" in
        1)
            echo "ADD NEW CAR MODE"
            read -rp "  Year: " year
            read -rp "  Make: " make
            read -rp "  Model: " model
            echo "${year}:${make}:${model}" >> my_old_cars
            echo "ADDED!"
            echo "";;

        2)
            echo "LIST INVENTORY MODE:"
            while read -r line
            do
                echo "  $line"
            done < <(sort -t ':' -k1,1n my_old_cars) # See README for details about AI usage in this line
            echo "END OF LIST"
            echo "";;
        *)
            echo "Invalid choice!";;
    esac
    read -rp "Menu option: " choice
done

echo "Goodbye!"