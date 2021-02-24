# Main file for fish command completions. This file contains various
# common helper functions for the command completions. All actual
# completions are located in the completions subdirectory.
## Set environment
#set TERM "rxvt-unicode"
set EDITOR "nvim"
set VISUAL "kate"
set fish_greeting

# Set default field separators
#
set -g IFS \n\ \t
set -qg __fish_added_user_paths
or set -g __fish_added_user_paths

# For one-off upgrades of the fish version, see __fish_config_interactive.fish
if not set -q __fish_initialized
set -U __fish_initialized 0
if set -q __fish_init_2_39_8
set __fish_initialized 2398
else if set -q __fish_init_2_3_0
set __fish_initialized 2300
end
end

#
# Create the default command_not_found handler
#
function __fish_default_command_not_found_handler
printf "fish: Unknown command: %s\n" (string escape -- $argv[1]) >&2
end

if not status --is-interactive
# Hook up the default as the command_not_found handler
# if we are not interactive to avoid custom handlers.
function fish_command_not_found --on-event fish_command_not_found
__fish_default_command_not_found_handler $argv
end
end

#
# Set default search paths for completions and shellscript functions
# unless they already exist
#

# __fish_data_dir, __fish_sysconf_dir, __fish_help_dir, __fish_bin_dir
# are expected to have been set up by read_init from fish.cpp

# Grab extra directories (as specified by the build process, usually for
# third-party packages to ship completions &c.
        set -l __extra_completionsdir
        set -l __extra_functionsdir
        set -l __extra_confdir
        if test -f $__fish_data_dir/__fish_build_paths.fish
        source $__fish_data_dir/__fish_build_paths.fish
        end

# Compute the directories for vendor configuration.  We want to include
# all of XDG_DATA_DIRS, as well as the __extra_* dirs defined above.
        set -l xdg_data_dirs
        if set -q XDG_DATA_DIRS
        set --path xdg_data_dirs $XDG_DATA_DIRS
        set xdg_data_dirs (string replace -r '([^/])/$' '$1' -- $xdg_data_dirs)/fish
        else
        set xdg_data_dirs $__fish_data_dir
        end

        set -l vendor_completionsdirs
        set -l vendor_functionsdirs
set -l vendor_confdirs
# Don't load vendor directories when running unit tests
if not set -q FISH_UNIT_TESTS_RUNNING
set vendor_completionsdirs $xdg_data_dirs/vendor_completions.d
set vendor_functionsdirs $xdg_data_dirs/vendor_functions.d
set vendor_confdirs $xdg_data_dirs/vendor_conf.d

# Ensure that extra directories are always included.
if not contains -- $__extra_completionsdir $vendor_completionsdirs
set -a vendor_completionsdirs $__extra_completionsdir
end
if not contains -- $__extra_functionsdir $vendor_functionsdirs
set -a vendor_functionsdirs $__extra_functionsdir
end
if not contains -- $__extra_confdir $vendor_confdirs
set -a vendor_confdirs $__extra_confdir
end
end

# Set up function and completion paths. Make sure that the fish
# default functions/completions are included in the respective path.

if not set -q fish_function_path
set fish_function_path $__fish_config_dir/functions $__fish_sysconf_dir/functions $vendor_functionsdirs $__fish_data_dir/functions
else if not contains -- $__fish_data_dir/functions $fish_function_path
set -a fish_function_path $__fish_data_dir/functions
end

if not set -q fish_complete_path
set fish_complete_path $__fish_config_dir/completions $__fish_sysconf_dir/completions $vendor_completionsdirs $__fish_data_dir/completions $__fish_user_data_dir/generated_completions
else if not contains -- $__fish_data_dir/completions $fish_complete_path
set -a fish_complete_path $__fish_data_dir/completions
end

# Add a handler for when fish_user_path changes, so we can apply the same changes to PATH
function __fish_reconstruct_path -d "Update PATH when fish_user_paths changes" --on-variable fish_user_paths
set -l local_path $PATH

    for x in $__fish_added_user_paths
set -l idx (contains --index -- $x $local_path)
    and set -e local_path[$idx]
    end

    set -g __fish_added_user_paths
    if set -q fish_user_paths
# Explicitly split on ":" because $fish_user_paths might not be a path variable,
# but $PATH definitely is.
    for x in (string split ":" -- $fish_user_paths[-1..1])
if set -l idx (contains --index -- $x $local_path)
    set -e local_path[$idx]
    else
    set -ga __fish_added_user_paths $x
    end
    set -p local_path $x
    end
    end

    set -xg PATH $local_path
    end

#
# Launch debugger on SIGTRAP
#
    function fish_sigtrap_handler --on-signal TRAP --no-scope-shadowing --description "Signal handler for the TRAP signal. Launches a debug prompt."
    breakpoint
    end

#
# When a prompt is first displayed, make sure that interactive
# mode-specific initializations have been performed.
# This handler removes itself after it is first called.
#
    function __fish_on_interactive --on-event fish_prompt
    __fish_config_interactive
    functions -e __fish_on_interactive
    end

# Set the locale if it isn't explicitly set. Allowing the lack of locale env vars to imply the
# C/POSIX locale causes too many problems. Do this before reading the snippets because they might be
# in UTF-8 (with non-ASCII characters).
    __fish_set_locale

# Upgrade pre-existing abbreviations from the old "key=value" to the new "key value" syntax.
# This needs to be in share/config.fish because __fish_config_interactive is called after sourcing
# config.fish, which might contain abbr calls.
    if test $__fish_initialized -lt 2300
    if set -q fish_user_abbreviations
    set -l fab
    for abbr in $fish_user_abbreviations
    set -a fab (string replace -r '^([^ =]+)=(.*)$' '$1 $2' -- $abbr)
    end
    set fish_user_abbreviations $fab
    end
    end

#
# Some things should only be done for login terminals
# This used to be in etc/config.fish - keep it here to keep the semantics
#
    if status --is-login
    if command -sq /usr/libexec/path_helper
# Adapt construct_path from the macOS /usr/libexec/path_helper
# executable for fish; see
# https://opensource.apple.com/source/shell_cmds/shell_cmds-203/path_helper/path_helper.c.auto.html .
    function __fish_macos_set_env -d "set an environment variable like path_helper does (macOS only)"
    set -l result

# Populate path according to config files
    for path_file in $argv[2] $argv[3]/*
                                         if [ -f $path_file ]
                                         while read -l entry
                                         if not contains -- $entry $result
                                         test -n "$entry"
                                         and set -a result $entry
                                         end
                                         end <$path_file
                                         end
                                         end

# Merge in any existing path elements
for existing_entry in $$argv[1]
if not contains -- $existing_entry $result
set -a result $existing_entry
end
end

set -xg $argv[1] $result
end

__fish_macos_set_env PATH /etc/paths '/etc/paths.d'
if [ -n "$MANPATH" ]
__fish_macos_set_env MANPATH /etc/manpaths '/etc/manpaths.d'
end
functions -e __fish_macos_set_env
end

#
# Put linux consoles in unicode mode.
#
if test "$TERM" = linux
and string match -qir '\.UTF' -- $LANG
and command -sq unicode_start
unicode_start
end
end

# Invoke this here to apply the current value of fish_user_path after
# PATH is possibly set above.
__fish_reconstruct_path

# Allow %n job expansion to be used with fg/bg/wait
# `jobs` is the only one that natively supports job expansion
function __fish_expand_pid_args
for arg in $argv
if string match -qr '^%\d+$' -- $arg
if not jobs -p $arg
return 1
end
else
printf "%s\n" $arg
end
end
end

for jobbltn in bg wait disown
function $jobbltn -V jobbltn
builtin $jobbltn (__fish_expand_pid_args $argv)
end
end
function fg
builtin fg (__fish_expand_pid_args $argv)[-1]
end

function kill
command kill (__fish_expand_pid_args $argv)
end

# As last part of initialization, source the conf directories.
# Implement precedence (User > Admin > Extra (e.g. vendors) > Fish) by basically doing "basename".
    set -l sourcelist
    for file in $__fish_config_dir/conf.d/*.fish $__fish_sysconf_dir/conf.d/*.fish $vendor_confdirs/*.fish
                                           set -l basename (string replace -r '^.*/' '' -- $file)
    contains -- $basename $sourcelist
    and continue
    set sourcelist $sourcelist $basename
# Also skip non-files or unreadable files.
# This allows one to use e.g. symlinks to /dev/null to "mask" something (like in systemd).
    [ -f $file -a -r $file ]
    and source $file
    end

# moved from Garuda config.fish
#
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
    function __history_previous_command
switch (commandline -t)
    case "!"
    commandline -t $history[1]; commandline -f repaint
    case "*"
    commandline -i !
    end
    end

    function __history_previous_command_arguments
switch (commandline -t)
    case "!"
    commandline -t ""
    commandline -f history-token-search-backward
    case "*"
    commandline -i '$'
    end
    end

    if [ $fish_key_bindings = fish_vi_key_bindings ];
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
    else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
    end

## Fish command history
    function history
    builtin history --show-time='%F %T '
    end

    function backup --argument filename
    cp $filename $filename.bak
    end

## Copy DIR1 DIR2
    function copy
set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
    set from (echo $argv[1] | trim-right /)
set to (echo $argv[2])
    command cp -r $from $to
    else
    command cp $argv
    end
    end

## Useful aliases
    alias ls='exa -al --color=always --group-directories-first' # preferred listing
    alias la='exa -a --color=always --group-directories-first'  # all files and dirs
    alias ll='exa -l --color=always --group-directories-first'  # long format
    alias lt='exa -aT --color=always --group-directories-first' # tree listing
    alias l.="exa -a | egrep '^\.'"

    alias aup="pamac upgrade --aur"
    alias grubup="sudo update-grub"
    alias fixpacman="sudo rm /var/lib/pacman/db.lck"
    alias tarnow='tar -acf '
    alias untar='tar -zxvf '
    alias wget='wget -c '
    alias psmem='ps auxf | sort -nr -k 4'
    alias psmem10='ps auxf | sort -nr -k 4 | head -10'
    alias upd='sudo reflector --latest 5 --age 2 --fastest 5 --protocol https --sort rate --save /etc/pacman.d/mirrorlist && cat /etc/pacman.d/mirrorlist && sudo pacman -Syu && fish_update_completions'
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'
    alias .....='cd ../../../..'
    alias ......='cd ../../../../..'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias hw='hwinfo --short'                                   #Hardware Info
    alias big="expac -H M '%m\t%n' | sort -h | nl"              #Sort installed packages according to size in MB (expac must be installed)

#get fastest mirrors
    alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
    alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
    alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
    alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"


## Import colorscheme from 'wal' asynchronously
    if type "wal" >> /dev/null 2>&1
    cat ~/.cache/wal/sequences
    end


# USER EDITED

    alias pi="sudo pacman -S"
    alias pr="sudo pacman -R"
    alias pu="sudo pacman -Sy"
    alias puu='sudo pacman -Syu'
    alias puuf='sudo pacman -Syyu'
    alias yi='yay -S'
    alias s.="source ~/.config/fish/config.fish"
    alias s="sudo"
    alias v="nvim"
    alias sv="sudoedit"
    alias vimrc="nvim ~/.config/nvim/init.vim"
    alias autoremove="sudo pacman -Qtdq | pacman -Rns"
    alias fishrc="nvim ~/.config/fish/config.fish"
    alias fstab="nvim /etc/fstab"
    alias msurface="sudo mount -t cifs //192.168.1.3/surface-home /home/yasser/surface -o username=yasser,password=17038,uid=1000,gid=1000,workgroup=workgroup"
    alias senable="sudo systemctl enable"
    alias i3rc="nvim /home/yasser/.config/i3/config"
    alias sshx="ssh -Y"
    alias update-mirror="sudo reflector --verbose --latest 200 --protocol http --protocol https --sort rate --save /etc/pacman.d/mirrorlist"
    alias cat="bat"
    alias svim="nvim -u ~/.SpaceVim/vimrc"
    alias tree="tree -C -a"

# vi mode
    fish_vi_key_bindings
    fish_user_key_bindings

## Run paleofetch if session is interactive
    if status --is-interactive
    paleofetch
    end

    set -x PYTHONSTARTUP "$HOME/.pythonrc"
    set -x EDITOR /bin/nvim
    starship init fish | source


