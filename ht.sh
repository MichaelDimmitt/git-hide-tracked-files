ht() {
  if_not_found_append_to_file ".hide_tracked" ".gitignore"
  if_not_found_append_to_file ".gitignore" ".hide_tracked"
  read -p "Enter a new file to be tracked: " newfile
  if_not_found_append_to_file "$newfile" ".hide_tracked"
}
if_not_found_append_to_file() {
  # $1=filename, $2=pattern
  if grep -q "$1" "$2"; then :; else echo "$1" >> $2; fi
}
