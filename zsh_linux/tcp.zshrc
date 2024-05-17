#!/bin/bash

books_directory="C:/Users/Owner/books"
index_file="books_index.txt"

# Check if the books directory exists
if [ ! -d "$books_directory" ]; then
  echo "Books directory not found: $books_directory"
  exit 1
fi

# Check if the index file exists, create if not
touch "$index_file"

# Function to display the menu
display_menu() {
  echo "Books Index:"
  index=0
  while IFS= read -r -d '' file; do
    index=$((index+1))
    echo "[$index] $(basename "$file")"
  done < <(find "$books_directory" -type f \( -iname "*.pdf" -o -iname "*.pub" \) -print0)
}

# Function to open a book
open_book() {
  selected_index=$1
  file=$(find "$books_directory" -type f \( -iname "*.pdf" -o -iname "*.pub" \) -print0 | sed -n "${selected_index}p" -z)
  openb local "$file"
}

# Function to edit book nickname
edit_nickname() {
  selected_index=$1
  file=$(find "$books_directory" -type f \( -iname "*.pdf" -o -iname "*.pub" \) -print0 | sed -n "${selected_index}p" -z)
  
  echo -n "Enter nickname for $(basename "$file"): "
  read -r nickname

  # Save the index, filename, and nickname to the index file
  echo "$selected_index,$file,$nickname" >> "$index_file"
}

# Main loop
while true; do
  display_menu

  echo -n "Enter the index to open (e.g., 1), or 'q' to quit: "
  read -r input

  case "$input" in
    [0-9]*) # If a number is entered
      if [ "$input" -le $index ] && [ "$input" -gt 0 ]; then
        open_book "$input"
        ;;
      else
        echo "Invalid index. Please enter a valid number."
      fi
      ;;
    e[0-9]*) # If 'e' followed by a number is entered
      edit_nickname "${input:1}"
      ;;
    q)
      echo "Exiting..."
      exit 0
      ;;
    *)
      echo "Invalid input. Please enter a valid number or 'q' to quit."
      ;;
  esac
done
