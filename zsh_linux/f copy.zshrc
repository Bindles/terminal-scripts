echo -n "\033[0;94m|Z|"
sleep .16
echo -n "\033[1;92m|$|"
sleep .16
echo -n "\033[0;96m|H|"
sleep .16
echo -n " \033[0;91m@"
sleep .16
echo "DIR:\033[0;93m[$(pwd)]\033[00m"

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# enhanced web_search from terminal
function web_search() {
  emulate -L zsh
  
  # define search engine URLS
  typeset -A urls
  urls=(
    $ZSH_WEB_SEARCH_ENGINES
    google          "https://www.google.com/search?q="
    bing            "https://www.bing.com/search?q="
    brave           "https://search.brave.com/search?q="
    yahoo           "https://search.yahoo.com/search?p="
    duckduckgo      "https://www.duckduckgo.com/?q="
    startpage       "https://www.startpage.com/do/search?q="
    yandex          "https://yandex.ru/yandsearch?text="
    github          "https://github.com/search?q="
    baidu           "https://www.baidu.com/s?wd="
    ecosia          "https://www.ecosia.org/search?q="
    goodreads       "https://www.goodreads.com/search?q="
    qwant           "https://www.qwant.com/?q="
    givero          "https://www.givero.com/search?q="
    stackoverflow   "https://stackoverflow.com/search?q="
    wolframalpha    "https://www.wolframalpha.com/input/?i="
    archive         "https://web.archive.org/web/*/"
    scholar         "https://scholar.google.com/scholar?q="
    ask             "https://www.ask.com/web?q="
    youtube         "https://www.youtube.com/results?search_query="
  )

  hart="C:/Users/Owner/Downloads/TorrentDev/Hartl%20M.%20Ruby%20on%20Rails%20Tutorial.%20Learn%20Web%20Development..7ed%202022/Hartl%20M.%20Ruby%20on%20Rails%20Tutorial.%20Learn%20Web%20Development..7ed%202022.pdf"
  codex="C:/Users/Owner/Downloads/TorrentDev/Hotwire-Codex-Newatia-A/HotwireCodex.pdf"
  if [[ $1 == "openb" ]]; then
    if [[ $2 == "local" ]]; then
      local_file="file:///${3:-}"
      if typeset -p "$3" &>/dev/null; then
        local_file="file:///${(P)3}"
      fi
      open_command "$local_file"
    else
      # Check if the third argument is set
      if [[ -n $3 ]]; then
        url="http://www.$2.com/$3"
      else
        url="http://$2"
      fi
      if typeset -p "$2" &>/dev/null; then
        url="${(P)2}"
      fi
      open_command "$url"
    fi
  else
    # Check whether the search engine is supported
    if [[ -z "$urls[$1]" ]]; then
      echo "Search engine '$1' not supported."
      return 1
    fi

    if [[ $# -gt 1 ]]; then
      url="${urls[$1]}$(omz_urlencode ${@[2,-1]})"
    else
      url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
    fi

    open_command "$url"
  fi
}
alias openb="web_search openb"
alias bing='web_search bing'
alias brs='web_search brave'
alias google='web_search google'
alias yahoo='web_search yahoo'
alias ddg='web_search duckduckgo'
alias sp='web_search startpage'
alias yandex='web_search yandex'
alias github='web_search github'
alias baidu='web_search baidu'
alias ecosia='web_search ecosia'
alias goodreads='web_search goodreads'
alias qwant='web_search qwant'
alias givero='web_search givero'
alias stackoverflow='web_search stackoverflow'
alias wolframalpha='web_search wolframalpha'
alias archive='web_search archive'
alias scholar='web_search scholar'
alias ask='web_search ask'
alias youtube='web_search youtube'

#add your own !bang searches here
alias wiki='web_search duckduckgo \!w'
alias news='web_search duckduckgo \!n'
alias map='web_search duckduckgo \!m'
alias image='web_search duckduckgo \!i'
alias ducky='web_search duckduckgo \!'

# other search engine aliases
if [[ ${#ZSH_WEB_SEARCH_ENGINES} -gt 0 ]]; then
  typeset -A engines
  engines=($ZSH_WEB_SEARCH_ENGINES)
  for key in ${(k)engines}; do
    alias "$key"="web_search $key"
  done
  unset engines key
fi

setfn() {
    local files=( ~/dev/bash_functions/*.txt )
    local num=1

    current_fn_color_matcher=$(cat ~/dev/bash_functions/_current.ini)
    

    for file in "${files[@]}"; do
        filename=$(basename "$file" .txt)
        if [ "$filename" = "$current_fn_color_matcher" ]; then
            echo -e "[\033[0;93m$num\033[00m] \033[0;93m$filename\033[00m"
        else
	        echo "[$num] $filename"
        fi
        (( num++ ))
    done

    echo -n "Enter the number of the file you want to append (or 0 to cancel): "
    read choice

    if [[ $choice =~ ^[0-9]+$ && $choice -ge 1 && $choice -le ${#files[@]} ]]; then
        chosen_filename="${files[$((choice))]}"
        backup_filename="g_zshrc_$(date +"%m_%d_%H_%M_%S").txt"

        cp ~/dev/bash_functions/g.zshrc ~/dev/bash_functions/backup/"$backup_filename"
        cat "$chosen_filename" >> ~/dev/bash_functions/g.zshrc
        echo "File '$chosen_filename' appended to g.zshrc"
    elif [ "$choice" -eq 0 ]; then
        echo "Canceled."
    else
        echo "Invalid choice. Exiting."
    fi
}

function laa() {
    local files=( ~/dev/bash_functions/*.txt )
    local num=1

    for file in "${files[@]}"; do
        filename=$(basename "$file" .txt)
        if [ "$filename" = "$function_name" ]; then
            echo -e "[\033[0;93m$num\033[00m] \033[0;93m$filename\033[00m"
        else
	        echo "[$num] $filename"
        fi
        (( num++ ))
    done

    echo -n "Enter the number of the file you want to append (or 0 to cancel): "
    read choice

    if [[ $choice =~ ^[0-9]+$ && $choice -ge 1 && $choice -le ${#files[@]} ]]; then
        chosen_filename="${files[$((choice))]}"
        backup_filename="g_zshrc_$(date +"%m_%d_%H_%M_%S").txt"

        cp ~/dev/bash_functions/g.zshrc ~/dev/bash_functions/backup/"$backup_filename"
        cat "$chosen_filename" >> ~/dev/bash_functions/g.zshrc
        echo "File '$chosen_filename' appended to g.zshrc"
    elif [ "$choice" -eq 0 ]; then
        echo "Canceled."
    else
        echo "Invalid choice. Exiting."
    fi
}

function list_and_append() {
    local files=( ~/dev/bash_functions/*.txt )
    local num=1

    for file in "${files[@]}"; do
        filename=$(basename "$file" .txt)
        echo "[$num] $filename"
        (( num++ ))
    done

    echo -n "Enter the number of the file you want to append (or 0 to cancel): "
    read choice

    if [[ $choice =~ ^[0-9]+$ && $choice -ge 1 && $choice -le ${#files[@]} ]]; then
        chosen_filename="${files[$((choice))]}"
        backup_filename="g_zshrc_$(date +"%m_%d_%H_%M_%S").txt"

        cp ~/dev/bash_functions/g.zshrc ~/dev/bash_functions/backup/"$backup_filename"
        cat "$chosen_filename" >> ~/dev/bash_functions/g.zshrc
        echo "File '$chosen_filename' appended to g.zshrc"
    elif [ "$choice" -eq 0 ]; then
        echo "Canceled."
    else
        echo "Invalid choice. Exiting."
    fi
}


function list_and_choose() {
    local files=( ~/dev/bash_functions/*.txt )
    local num=1

    for file in "${files[@]}"; do
        filename=$(basename "$file" .txt)
        echo "[$num] $filename"
        (( num++ ))
    done

    echo -n "Enter the number of the file you want to display: "
    read choice

    if [[ $choice =~ ^[0-9]+$ ]] && (( choice >= 1 )) && (( choice <= ${#files[@]} )); then
        local selected_file="${files[$((choice-1))]}"
        echo ""
        cat "$selected_file"
    else
        echo "Invalid choice"
    fi
}


listfngpt() {
    i=1
    options=()
    filenames=()

    for file in ~/dev/bash_functions/*.txt; do
        filename=$(basename "$file" .txt)
        filenames+=("$filename")
        if [ "$filename" = "$function_name" ]; then
            options+=("[$i] $filename")
        else
            options+=("[$i] $filename")
        fi
        ((i++))
    done

    for option in "${options[@]}"; do
        echo "$option"
    done

    read -p "Enter the number of the function you want to append (or 0 to cancel): " choice
    if [[ $choice =~ ^[0-9]+$ && $choice -ge 1 && $choice -le ${#filenames[@]} ]]; then
        chosen_filename="${filenames[$((choice-1))]}"
        backup_filename="g_zshrc_$(date +"%m_%d_%H_%M_%S").txt"

        cp ~/dev/bash_functions/g.zshrc ~/dev/bash_functions/backup/"$backup_filename"
        cat ~/dev/bash_functions/"$chosen_filename".txt >> ~/dev/bash_functions/g.zshrc
        echo "Function '$chosen_filename' appended to g.zshrc"
    elif [ "$choice" -eq 0 ]; then
        echo "Canceled."
    else
        echo "Invalid choice. Exiting."
    fi

}






listf() {
    i=1
    for file in ~/dev/bash_functions/*.txt; do
        filename=$(basename "$file" .txt)
        if [ "$filename" = "$function_name" ]; then
            echo -e "[\033[0;93m$i\033[00m] \033[0;93m$filename\033[00m"
        else
            echo "[$i] $filename"
        fi
        ((i++))
    done
}


listfnzz() {
    i=1
    for file in ~/dev/bash_functions/*.txt; do
        filename=$(basename "$file" .txt)
        echo "[$i] $filename"
        ((i++))
    done
}




makefnz() {
    [ $# -ne 1 ] && echo "Usage: makefn <function_name>" && return 1
    echo "function $1 () {" > ~/dev/bash_functions/$1.txt
    echo "}" >> ~/dev/bash_functions/$1.txt
    echo -e "\nFunction created in ~/dev/bash_functions/$1.txt:"
    cat ~/dev/bash_functions/$1.txt
    micro ~"/dev/bash_functions/$1.txt"
}


makefnc() {
	if [ -n $1 ]; then
	echo "hi"
	fi
	
}

makefn() {
    if [ $# -ne 1 ]; then
        echo "Usage: makefn <function_name>"
        return 1
    fi

    function_name="$1"
    file_path="$HOME/dev/bash_functions/${function_name}.txt"

    echo "Creating function ${function_name} in ${file_path}"
    echo "function ${function_name} () {" > "$file_path"
    echo "}" >> "$file_path"
    echo "${function_name}" > ~/dev/bash_functions/_current.ini
    echo "opening ${file_path}"

    micro "$file_path"
}

makefnsh() {
    if [ $# -ne 1 ]; then
        echo "Usage: makefn <function_name>"
        return 1
    fi

    function_name="$1"
    file_path="$HOME/dev/bash_functions/${function_name}.sh"
	fnpath="$HOME/dev/bash_functions/"

    echo "Creating function ${function_name} in ${file_path}"
    echo "function ${function_name} () {" > "$file_path"
    echo "}" >> "$file_path"
    echo "${function_name}" > ~/dev/bash_functions/_current.ini
    echo "opening ${file_path}"

    micro "$file_path"
}


getfn() {
  if [[ $# -eq 1 ]]; then
    sed -n "/$1() {/,/^}$/p" ~/f.zshrc
  else
    list_my_functions
  fi
}

function list_my_functions() {
  local functions=( $(grep -E '^([a-zA-Z_]+[a-zA-Z0-9_]*)\(\) \{' ~/f.zshrc | cut -d '(' -f 1 | sort) )
  local num=1

  for func in "${functions[@]}"; do
    echo "[$num] $func"
    (( num++ ))
  done

  echo -n "Enter the number of the function you want to display: "
  read choice

  if [[ $choice =~ ^[0-9]+$ ]] && (( choice >= 1 )) && (( choice <= ${#functions[@]} )); then
    local selected_function="${functions[$((choice))]}"
    echo ""
    sed -n "/^${selected_function}() {/,/^}$/p" ~/f.zshrc
  else
    echo "Invalid choice"
  fi
}


listfn() {
  local functions=( $(grep -E '^([a-zA-Z_]+[a-zA-Z0-9_]*)\(\) \{' ~/f.zshrc | cut -d '(' -f 1 | sort) )
  local num=1

  for func in "${functions[@]}"; do
    echo "[$num] $func"
    (( num++ ))
  done

  echo -n "Enter the number of the function you want to display: "
  read choice

  if [[ $choice =~ ^[0-9]+$ ]] && (( choice >= 1 )) && (( choice <= ${#functions[@]} )); then
    local selected_function="${functions[$((choice))]}"
    sed -n "/^${selected_function}() {/,/^}$/p" ~/f.zshrc
  else
    echo "Invalid choice"
  fi
}

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



mkdirz(){
mkdir $1
cd $1
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

gitcfgbindles() {
	git config user.name = 'bindles'
	git config user.email = 'bindlez@gmail.com'
	git config user.password = ''
	echo git config user.name = 'bindles'
	echo git config user.email = 'bindlez@gmail.com'
	echo git config user.password = ''
}

pgcreatedb() {
    if [ "$#" -ne 3 ]; then
        echo "Usage: pgcreatedb <username> <password> <database_name>"
        return 1
    fi

    username="$1"
    password="$2"
    database="$3"

    sudo -u postgres psql -c "CREATE USER $username WITH PASSWORD '$password';" &&
    sudo -u postgres psql -c "CREATE DATABASE $database OWNER $username;" &&
    sudo -u postgres psql -c "ALTER USER $username CREATEDB;"

    return $?
}

pgcrdbhelp() {
	echo "Usage: pgcrdb /  pgcreatedb <username> <password> <database_name>"
	echo "Usage: pgcrdb2 <database_name> <username> <password>"	
}

pgcrdb2() {
    if [ "$#" -ne 3 ]; then
        echo "Usage: pgcreatedb <username> <password> <database_name>"
        return 1
    fi

	database="$1"
    username="$2"
    password="$3"

    sudo -u postgres psql -c "CREATE USER $username WITH PASSWORD '$password';" &&
    sudo -u postgres psql -c "CREATE DATABASE $database OWNER $username;" &&
    sudo -u postgres psql -c "ALTER USER $username CREATEDB;"

    if [ $? -eq 0 ]; then
        echo -n "Append to end of \033[0;93mconfig/database.yml\033[00m? (y/yes/ok to confirm, any other key will cancel): "
        read confirm
        case "$confirm" in
            [yY]|[yY][eE][sS]|[oO][kK])
                echo "database: '$database'" >> config/database.yml
                echo "username: '$username'" >> config/database.yml
                echo "password: '$password'" >> config/database.yml
                echo "Appended to config/database.yml. Don't forget to copy and paste it from the bottom to the proper matching location"
                ;;
            *)
                # Copy to xclip with newlines
                echo -e "$database\n$password\n$username" | xclip -selection clipboard
                echo "Cancelled write of \033[0;93mconfig/database.yml\033[00m credentials. Enjoy your new Postgres database. Ctrl+v for credentials."
                ;;
        esac
    fi
}

pgcrdb() {
    if [ "$#" -ne 3 ]; then
        echo "Usage: pgcreatedb <username> <password> <database_name>"
        return 1
    fi

    username="$1"
    password="$2"
    database="$3"

    sudo -u postgres psql -c "CREATE USER $username WITH PASSWORD '$password';" &&
    sudo -u postgres psql -c "CREATE DATABASE $database OWNER $username;" &&
    sudo -u postgres psql -c "ALTER USER $username CREATEDB;"

    if [ $? -eq 0 ]; then
        echo -n "Append to end of \033[0;93mconfig/database.yml\033[00m? (y/yes/ok to confirm, any other key will cancel): "
        read confirm
        case "$confirm" in
            [yY]|[yY][eE][sS]|[oO][kK])
                echo \n "database: '$database'" >> config/database.yml
                echo   "username: '$username'" >> config/database.yml
                echo   "password: '$password'" >> config/database.yml
                echo   "Appended to config/database.yml. dont forget to copy and paste it from the bottom to the proper matching location"
                ;;
            *)
                echo "Cancelled write of database.yml. Enjoy your new postgres database"
                ;;
        esac
    fi
}


gemcatbe() {
cat ~/dev/gemcat/gem-berror.txt >> Gemfile;
echo 'writing the following to [Gemfile]:\n (dont forget to put in dev)\n';
cat ~/dev/gemcat/gem-berror.txt
}

xtch() {
  local ext
  case "$1" in
    t|txt) ext=".txt";;
    h|html) ext=".html";;
    he|htmlerb|html_erb) ext=".html.erb";;
    r|rb|ruby) ext=".rb";;
    j|js) ext=".js";;    
    p|py|python) ext=".py";;
    m|md) ext=".md";;
    cs|css) ext=".css";;
    s|scss) ext=".scss";;
    *) echo "Invalid alias. Usage: touch_alias <alias> <filename(s)>"; return;;
  esac
  
  shift
  for filename in "$@"; do
    touch "${filename}${ext}"
    echo "Created:\033[0;93m ${filename}${ext} \033[00m"
  done
}

alias ttch='xtch'

ctch() {
  local ext
  case "$1" in
    t|txt) ext=".txt";;
    h|html) ext=".html";;
    he|htmlerb|html_erb) ext=".html.erb";;
    r|rb|ruby) ext=".rb";;
    j|js) ext=".js";;    
    p|py|python) ext=".py";;
    m|md) ext=".md";;
    cs|css) ext=".css";;
    s|scss) ext=".scss";;
    *) echo "Invalid alias. Usage: touch_alias <alias> <filename(s)>"; return;;
  esac
  
  shift
  for filename in "$@"; do
    code -r "${filename}${ext}"
    echo "Code -r:\033[0;93m ${filename}${ext} \033[00m"
  done
}

xrm() {
  local ext
  case "$1" in
    t|txt) ext=".txt";;
    h|html) ext=".html";;
    he|htmlerb|html_erb) ext=".html.erb";;
    r|rb|ruby) ext=".rb";;
    j|js) ext=".js";;    
    p|py|python) ext=".py";;
    m|md) ext=".md";;
    cs|css) ext=".css";;
    s|scss) ext=".scss";;
    *) echo "Invalid alias. Usage: rm_alias <alias> <filename(s)>"; return;;
  esac

  shift
  for filename in "$@"; do
    if [ -f "${filename}${ext}" ]; then
      echo -n "Are you sure you want to delete\033[0;93m ${filename}${ext}\033[00m? (y/yes/ok to confirm, any other key will cancel): "
      read confirm
      case "$confirm" in
        [yY]|[yY][eE][sS]|[oO][kK])
          echo -n "Press Enter again to delete, any other key will cancel: "
          read second_confirm
          case "$second_confirm" in
            "") rm "${filename}${ext}"; echo "Removed\033[0;93m ${filename}${ext} \033[00m";;
            *) echo "Canceled deletion of\033[0;93m ${filename}${ext}\033[00m";;
          esac
          ;;
        *) echo "Canceled deletion of\033[0;93m ${filename}${ext}\033[00m";;
      esac
    else
      echo "File\033[0;93m ${filename}${ext}\033[00m not found."
    fi
  done
}



#super remove with confirmation
xrmreadunable() {
  local ext
  case "$1" in
    t|txt) ext=".txt";;
    h|html) ext=".html";;
    he|htmlerb|html_erb) ext=".html.erb";;
    r|rb|ruby) ext=".rb";;
    j|js) ext=".js";;    
    p|py|python) ext=".py";;
    m|md) ext=".md";;
    cs|css) ext=".css";;
    s|scss) ext=".scss";;
    *) echo "Invalid alias. Usage: rm_alias <alias> <filename(s)>"; return;;
  esac
  
  shift
  for filename in "$@"; do
    if [ -f "${filename}${ext}" ]; then
      read -rp "Are you sure you want to delete ${filename}${ext}? (y/yes/ok to confirm, x/no to cancel): " confirm
      case "$confirm" in
        y|yes|ok) 
          read -rp "Press Enter again to delete, any other key will cancel: " second_confirm
          case "$second_confirm" in
            "") rm "${filename}${ext}"; echo "Removed \033[0;93m ${filename}${ext} \033[00m";;
            *) echo "Canceled deletion of \033[0;93m ${filename}${ext} \033[00m";;
          esac
          ;;
        *) echo "Canceled deletion of \033[0;93m ${filename}${ext} \033[00m";;
      esac
    else
      echo "File \033[0;93m ${filename}${ext} \033[00m not found."
    fi
  done
}



xrm_confirm_confirm() {
  local ext
  case "$1" in
    t|txt) ext=".txt";;
    h|html) ext=".html";;
    he|htmlerb|html_erb) ext=".html.erb";;
    r|rb|ruby) ext=".rb";;
    p|py|python) ext=".py";;
    *) echo "Invalid alias. Usage: rm_alias <alias> <filename(s)>"; return;;
  esac
  
  shift
  for filename in "$@"; do
    if [ -f "${filename}${ext}" ]; then
      rm "${filename}${ext}"
      echo "Removed\033[0;93m ${filename}${ext} \033[00m"
    else
      echo "File\033[0;93m ${filename}${ext}\033[00m not found."
    fi
  done
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
