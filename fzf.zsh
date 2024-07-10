# Setup fzf
# ---------
if [[ ! "$PATH" == */home/elgordoponcio/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/elgordoponcio/.fzf/bin"
fi

source <(fzf --zsh)
