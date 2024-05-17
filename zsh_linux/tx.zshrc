function ind5() {
  books_directory="/mnt/c/Users/Owner/Downloads"
  index_file="$HOME/books_index.txt"

  # Check if the books directory exists
  if [ ! -d "$books_directory" ]; then
    echo "Books directory not found: $books_directory"
    return 1
  fi

  # Check if the index file exists, create if not
  touch "$index_file"

  filter=""

  # Check for search or grep options
  if [ "$1" = "s" ] || [ "$1" = "-s" ] || [ "$1" = "search" ] || [ "$1" = "g" ] || [ "$1" = "-g" ] || [ "$1" = "grep" ]; then
    filter="$2"
    shift 2
  fi

  # Function to display the menu
  display_menu() {
    echo "Books Index:"
    index=0
    while IFS= read -r -d '' file; do
      index=$((index+1))
      # Apply grep filter
      if [ -z "$filter" ] || echo "$file" | grep -i "$filter" > /dev/null; then
        echo "[$index] $(basename "$file")"
      fi
    done < <(find "$books_directory" -type f \( -iname "*.pdf" -o -iname "*.pub" \) -print0)
  }

  # Function to open a book
  open_book() {
    selected_index=$1
    index=0

    while IFS= read -r -d '' file; do
      index=$((index+1))
      if [ "$index" -eq "$selected_index" ]; then
        # Convert WSL path to Windows path using regex
        win_path=$(echo "$file" | sed 's|^/mnt/\(.\)/|\1:/|')
        openb local "$win_path"
        return  # Exit the function after opening a book
      fi
    done < <(find "$books_directory" -type f \( -iname "*.pdf" -o -iname "*.pub" \) -print0)

    echo "Invalid index. Please enter a valid number."
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
  display_menu > /dev/null  # Call display_menu to update the index variable

  if [ $index -eq 0 ]; then
    # No books found, ask for a new search parameter
    echo "No books were found. Try again?"
    read -r new_filter
    filter="$new_filter"
    continue
  fi

  display_menu  # Display the menu

  echo -n "Enterodasr the index to open (e.g., 1), 'q' to quit, or 'e' to edit a nickname: "
  read -r input

  case "$input" in
    [0-9]*) # If a number is entered
      if [ "$input" -le $index ] && [ "$input" -gt 0 ]; then
        open_book "$input"
        return 0  # Exit the function after opening a book
      else
        echo "Invalid index. Please enter a valid number."
      fi
      ;;
    e[0-9]*) # If 'e' followed by a number is entered
      edit_nickname "${input:1}"
      ;;
    q) # If 'q' is entered
      echo "Exiting..."
      return 0
      ;;
    *)
      echo "Invalid input. Please enter a valid number, 'q' to quit, or 'e' to edit a nickname."
      ;;
  esac
done

}
