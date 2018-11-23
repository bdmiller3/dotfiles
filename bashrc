# .bashrc
# Mostly the stock Fedora bashrc, modified with a few aliases
# and tool-specific changes.

# Show an asterisk when the branch has uncommmitted changes
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWSTASHSTATE=1

source ~/.git-prompt.sh

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

#if [ -f ~/.bash_profile ]; then
#    source ~/.bash_profile
#fi

if [ -f ~/.profile ]; then
    source ~/.profile
fi

# Set up PS1, PATH, and few other shell variables
export PS1='[\u@\h \W\[\033[01;33m\]$(__git_ps1)\[\033[00m\]]\$ '

export EDITOR="vim"
export PATH="$PATH:/home/bmiller/bin/phabricator/arcanist/bin"
export PATH="$PATH:/usr/java/jdk1.7.0_75/bin"

export PATH="/home/bmiller/go1.11/bin:/usr/local/go/bin:$PATH"
export GOPATH="/home/bmiller/code/go"
export PATH="$GOPATH/bin:$PATH"

# Aliases
alias dammitsqldeveloper="/home/bmiller/bin/shscripts/dammitsqldeveloper.sh"
alias fuckyousqldeveloper="/home/bmiller/bin/shscripts/dammitsqldeveloper.sh"
alias mutt="neomutt"
alias code="cd /home/bmiller/code"
alias weechat="weechat-curses"

# Useful for turning the Thinkpad nub and touchpad on and off
#alias nubdisable="xinput set-prop 'TPPS/2 IBM TrackPoint' 'Device Enabled' 0"
#alias nubenable="xinput set-prop 'TPPS/2 IBM TrackPoint' 'Device Enabled' 1"
#alias touchpaddisable="xinput set-prop 'Synaptics tm2964-001' 'Device Enabled' 0"
#alias touchpadenable="xinput set-prop 'Synaptics tm2964-001' 'Device Enabled' 1"

# Xrandr aliases for enabling\/disabling a 3 monitor setup
alias disablemonitorswork="xrandr --output DP-2-2 --off --output DP-2-3 --off"
alias enablemonitorswork="xrandr --output DP-2-2 --auto --right-of eDP-1 --output DP-2-3 --auto --right-of DP-2-2"

# This is for a very rare, but very annoying case in which gnome tries to
# helpfully open a dialog requesting your username and pass when pushing
# to an https github remote
unset SSH_ASKPASS

# Perl 5
PATH="/home/bmiller/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/bmiller/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/bmiller/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/bmiller/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/bmiller/perl5"; export PERL_MM_OPT;

[[ -s "/home/bmiller/.gvm/scripts/gvm" ]] && source "/home/bmiller/.gvm/scripts/gvm"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/bmiller/.sdkman"
[[ -s "/home/bmiller/.sdkman/bin/sdkman-init.sh" ]] && source "/home/bmiller/.sdkman/bin/sdkman-init.sh"
