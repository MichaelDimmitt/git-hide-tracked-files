## git-hide-tracked-files

### .gitignore does not always work
1) Using a gitignore will not work if your files are already being tracked by git
2) Sometimes you want to add a change temporarily for a local environment but do not have the luxury of using local environment variables.

## Now add a .hide_tracked file!
1) add .hide_tracked to your .gitignore - so that it does not get in version control.
2) add yourfile to the .hide_tracked file.
3) update git add to use the .hide_tracked file.

quick setup using bash commands: 
```bash
{
cd yourproject;
if grep -q PATTERN file.txt; then echo "found"; echo "found2"; else echo "not found"; echo ".hide_tracked" >> .gitignore; fi
echo ".hide_tracked" >> .gitignore;
echo "yourfile1.ext\nyourfile2.ext\nyourfile3.ext" > .hide_tracked;
}
```

## How it works:
1) user runs `git add .` - git adds the changes like normal.
2) .hide_tracked is iterated line by line running the command git reset HEAD 'yourfile'
3) result: your file never gets staged !

```bash
git() {
  if [ "$1" == "add" ]; then
    $(which git) "$@"
    while IFS='' read -r LINE || [ -n "${LINE}" ]; do
      $(which git) reset HEAD $LINE;
    done < .hide_tracked
    # git reset HEAD 
  else
    $(which git) "$@"
  fi
}
```
## Example on a real world project:
![image](https://user-images.githubusercontent.com/11463275/109428445-2a4ade80-79c5-11eb-9128-f0fd02fb38bc.png)

