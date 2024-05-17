echo -n "\033[0;94m|Z|"
sleep .16
echo -n "\033[1;92m|$|"
sleep .16
echo -n "\033[0;96m|H|"
sleep .16
echo -n " \033[0;91m@"
sleep .16
echo "DIR:\033[0;93m[$(pwd)]"



create_leetcode_problem() {
  create_problem_directory() {
    # Extract problem number using regex
    problem_num=$(echo "$1" | grep -oP '\d+')

    # Create directory in C:/dev/leetcode
    dir_path="C:/dev/leetcode/$1"
    mkdir -p "$dir_path"

    # Create .rb file with start function
    file_path="$dir_path/$problem_num.rb"
    echo -e "def $2\n  # Your code here\nend" > "$file_path"

    echo "Directory and Ruby file created successfully at $dir_path"
  }

  # Get user input for problem name
  read -p "Enter the Problem name (usually starts with a number, ex: 198. House Robber): " problem_name

  # Get start function from clipboard
  echo "Copy the start function to the clipboard before proceeding."
  read -p "Press Enter when ready..."

  # Read clipboard content into a variable
  start_function=$(pbpaste)

  # Call the function to create the directory and Ruby file
  create_problem_directory "$problem_name" "$start_function"
}

create_leetcode_porblem








# Function to get user input, open the index.html file, and populate the text field
update_index_html() {
    read -p "Enter your input: " user_input
    local website_file="C:/dev/update_index.html"
    local encoded_input=$(printf "%s" "$user_input" | jq -s -R -r @uri)
    explorer "file://$website_file?input=$encoded_input"
    echo "Opened the website and populated the text field with user input: $user_input"
}


x() {
    # Get the command as a string
    command_str="$*"

    # Get the last word from the command and store it in a variable
    last_word="${command_str##* }"

    # Execute the command provided as arguments
    eval "$command_str"

    # Check if the command was successful (exit code 0) and if the last word is a valid directory
    if [ $? -eq 0 ] && [ -d "$last_word" ]; then
        # Change directory to the last word
        cd "$last_word"
    fi
}


gclo() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: gclo <username> <repository>"
    else
        url="https://github.com/$1/$2.git"
        echo "$url"
        git clone "$url"
    fi
}



mkdirz(){
mkdir $1
cd $1
}


open_chatgpt() {
    read -p "Enter your question: " QUESTION
    ENCODED_QUESTION=$(echo "$QUESTION" | urlencode)

    start "https://chat.openai.com/?q=$ENCODED_QUESTION"
}



padad() {
if [ -n "$1" ] && [ "$1" != "add" ]; then
#echo "" >> padz.txt
echo "$1" >>  ~/padz.txt
echo -e "[padz.txt] >> \n '$1'"
elif [ "$1" = "add" ]; then
read padadstring
  echo "[padz.txt] >>\n$padadstring" 
  echo "$padadstring" >> ~/padz.txt
fi
}


padac() {
if [ -n "$(pbpaste)" ]; then
#echo "" >> padz.txt
echo "$(pbpaste)"
echo "OK To Paste?:"
echo ">> [\033[0;93m padz.txt\033[00m ]"
read okpaste
  if [ "$okpaste" != "x" ]; then
    echo "[\033[0;93m padz.txt\033[00m ] backed up\n[\033[0;91m padz.txt\033[00m ]"
    cp  ~/padz.txt ~/padzcp.txt
    echo "$(pbpaste)" >> ~/padz.txt
    echo "[\033[0;93m padz.txt\033[00m ] >>\n'$(pbpaste)'"
    echo "$okpaste"
  fi
  if [ "$okpaste" = "s" ]; then
    cat ~/padz.txt
  fi
elif [ -z "$(pbpaste)" ]; then
  echo "Clipboard: Empty"
fi
}

padcat() {
cat ~/padz.txt
}


cmdzz() {
  if [ -z "$1" ]; then
    cat ~/cmdbook.txt
  elif [ "$1" = "add" ]; then
    if [ -z "$2" ]; then
      echo "Nothing to add"
    else
      echo "$2" >> ~/cmdbook.txt
    fi
  fi
}


cmdz() {
  if [ -z "$1" ]; then
    cat ~/cmdbook.txt
  elif [ "$1" = "add" ]; then
    read ztexti
    if [ -n "$ztexti" ] && [ "$ztexti" != "x" ]; then
      echo "$ztexti" >> ~/cmdbook.txt
    fi
  fi
}

jjjj() {
a="COMMANDS"
#commands.length
#b=$(echo ${#ZARRAY[@]})
#((b--))
b=$(( ${#ZARRAY[@]} - 1 ))
#b=$(echo ${#ZARRAY[1]}-1 | bc)
#b=$((${#ZARRAY[1]} - 1))
# Array pretending to be a Pythonic dictionary
ZARRAY=( "$a:$b"
        "dinosaur:roar"
        "bird:chirp"
        "bash:rock"
	"bobofdsfssdsdsdsdrmdirdfsdffdsdsdsdsdfsdfsdffssdsdds:jobogfdgf -r gfdgfdg")

# Sort the array by key length in descending order
sorted_array=($(printf "%s\n" "${ZARRAY[@]}" | awk -F: '{print length($1) ":" $0}' | sort -nr | cut -d: -f2-))

#b=echo "[COMMANDS]: ( ${#ZARRAY[@]} found)"

for animal in "${ZARRAY[@]}" ; do
    KEY="${animal%%:*}"
    VALUE="${animal##*:}"
    KEY_LENGTH=${#KEY}
    SPACES=$(printf "%*s" $((${#sorted_array[1]%%:*} - ${KEY_LENGTH})))
    printf " %s %s| %s\n" "$KEY" "$SPACES" "$VALUE"
done
}
