git() {
  if [ "$1" == "check" ]; then
    bash <(curl -s https://raw.githubusercontent.com/MichaelDimmitt/git_check_computer/master/git_check_computer.sh)
  elif [ "$1" == "add" ]; then
    $(which git) "$@"
    if [ -f ".hide_tracked" ]; then
      while IFS='' read -r LINE || [ -n "${LINE}" ]; do
        $(which git) reset HEAD $LINE;
      done < .hide_tracked
    fi
  else
    $(which git) "$@"
  fi
}
ht() {
  if_not_found_append_to_file ".hide_tracked" ".gitignore"
  if_not_found_append_to_file ".gitignore" ".hide_tracked"
  read -p "Enter a new file to be tracked: " newfile
  if_not_found_append_to_file "$newfile" ".hide_tracked"
}
if_not_found_append_to_file() {
  # $1=pattern, $2=filename
  [ -f "$2 ] if grep -q "$1" "$2"; then :; else echo "$1" >> $2; fi
}
