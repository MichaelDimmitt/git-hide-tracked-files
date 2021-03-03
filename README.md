## git-hide-tracked-files

### .gitignore does not always work
1) Using a gitignore will not work if your files are already being tracked by git
2) Sometimes you want to add a change temporarily for a local environment but do not have the luxury of using local environment variables.

## Now add a .hide_tracked file!
1) add .hide_tracked to your .gitignore - so that it does not get in version control.
2) add .gitignore to .hide_tracked - so that the .hide_tracked change does get tracked in project gitignore
<br/>Note: (if you want to make an update to .gitignore later you will need to remove .gitignore from .hide_tracked.)
3) add yourfile to the .hide_tracked file.
4) update git add to use the .hide_tracked file.

quick setup using bash commands: 
```bash
{
cd yourproject;
if grep -q .hide_tracked .gitignore; then :; else echo ".hide_tracked" >> .gitignore; fi
if grep -q .gitignore .hide_tracked; then :; else echo ".gitignore" >> .hide_tracked; fi
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
    if [ -f "$FILE" ]; then
      while IFS='' read -r LINE || [ -n "${LINE}" ]; do
        $(which git) reset HEAD $LINE;
      done < .hide_tracked
    fi
    # git reset HEAD 
  else
    $(which git) "$@"
  fi
}
```
## Example on a real world project:
![image](https://user-images.githubusercontent.com/11463275/109428445-2a4ade80-79c5-11eb-9128-f0fd02fb38bc.png)

## ht - How does this function work?
The ht function makes setup and adding a new files to .hide_tracked easy and user friendly 🎉
1) add the contents of `packaged-bashrc-stuff.sh` to your bashrc if you are using bash.
2) source your bash shell. 
3) cd to your project and type: `ht`</br>
This will run all of the setup needed for the repo.</br> 
It does not ever get tracked in your codebase!</br>
And it will prompt you for a file name to add to .hide_tracked each time.</br>
If you think you can improve this section please open an issue in this github project.
4) future invocations of ht will prompt for new file names to add to .hide_tracked! 🎉
5) to remove items from .hide_tracked, open the file and delete the lines using vim or other editor.


