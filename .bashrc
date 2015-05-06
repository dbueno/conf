# Settings for interactive shells
# .bashrc is executed for interactive non-login shells
    
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

. ~/.bashrc_personal

my_uname="$(uname)"

## OS-dependent aliases, Darwin first
if [ $my_uname = "Darwin" ]
then
    alias remove="/usr/bin/srm -mv"
    alias no='ls -FG'
    alias lo='ls -alFG'
    alias ho='ls -alFGh'
    alias lt='ls -alFGtr'
    alias lth='ls -alFGtrh'

    alias dusage='du -Pskx * 2>&1 | grep -v "Permission denied" | sort -nr | less'
    export EMACS="/Applications/Emacs.app/Contents/MacOS/Emacs"

## Linux-dependent aliases
elif [ $my_uname = "Linux" -o $my_uname = "CYGWIN_NT-5.1"  -o $my_uname = "MINGW32_NT-5.1" ]
then
    if test -n "$(which bcwipe 2>/dev/null)"; then
        alias remove="echo bcwipe install not detected"
    else
        alias remove="bcwipe -vf"
    fi
    alias aoeu="xmodmap /usr/X11R6/lib/X11/etc/xmodmap.std"
    alias asdf="xmodmap /usr/share/xmodmap/xmodmap.dvorak"
    alias no='ls -F --color'
    alias lo='ls -alF --color'
    alias lt='ls -alF --color -tr'
    alias lth='ls -alF --color -trh'
    alias dusage='ls -d */ | xargs du -cs | sort -nr'
#else
#    echo "Unrecognized host (i.e. not Darwin or Linux). Run 'uname'."
fi



alias pd='cd "$OLDPWD"'
alias packet_dump="sudo /usr/sbin/tcpdump -a -i en1 -vvv -XX -s 1500"
alias rmws="awk '{sub(/[ \t]+$/, \"\");print}'"

# Evaluates to an iso-conformant date.  The iso-conformance is good because
# lexicographic order coincides with date order.  'nows' just has seconds and
# is also iso-conformant.
alias now="date '+%Y-%m-%dT%H%M'"
alias nows="date '+%Y-%m-%dT%H%M%S'"

# example: makeiso -V vol_id -o output_filename
alias makeiso="mkisofs -l -pad -U -J -r -allow-leading-dots -iso-level 4"

# grabhttp is for mirroring a website onto a drive.  example: grabhttp --level=2
alias grabhttp="wget -v -F -N -x --cache=off --recursive --convert links"

# bash completion from homebrew
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi


# In absence of special direction, EDITOR is a running emacs instance.
export EDITOR="vim"
export ED="$EDITOR"

# Send command's output to less.  e.g. so ls
function so {
    eval "$@" | less
}


# Prompt settings #############################################################

# Echo "root" if the current user has root privs.  This is used to set my PS1I
# think, so I know I'm root.
my_whoami=`whoami`
disp_root_name() {
    if [ $my_whoami = "root" ]; then
        echo -n "root"
    fi
}

# Print out the number of jobs running with an argument format-string suitable
# for printf.  I use this to get an "(n jobs)" string in my prompt.
num_jobs() {
    local num_jobs
    num_jobs="$(jobs | wc -l)"
    if [ $num_jobs -ne 0 ]; then
        if [ $num_jobs -eq 1 ]; then
            printf " (1 job)"
        else
            printf " (%s jobs)" $num_jobs
        fi
    fi
}

# For Linux, pretty colors.
export LS_COLORS='di=00;36;40:ln=00;35:ex=00;31'
# For Darwin, pretty colors.
export LSCOLORS="ga"


# Shell settings
###############################################################################
# Ctrl-D shouldn't exit the shell.  Annoying.
set -o ignoreeof
# Correct transpositions and other minor details from 'cd DIR' command.
shopt -s cdspell
# Include hidden files in glob (*).
shopt -s dotglob
# Extra-special pattern matching in the shell.
shopt -s extglob
# Flatten multiple-line commands into the same history entry.
shopt -s cmdhist
# Don't complete when I haven't typed anything.
shopt -s no_empty_cmd_completion
# Let me know if I shift stupidly.
shopt -s shift_verbose

# The & removes dups; [ ]* ignores commands prefixed with spaces.  Other
# commands, like job control and ls'ing are also ignored.
export HISTIGNORE="&:[ ]*:exit:[bf]g:no:lo:pd"

export HISTSIZE=10000

export PS1='$(num_jobs "%s>")\A $ '