# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

export OSH='/home/daniel/.oh-my-bash'

OSH_THEME="font"
OMB_HYPHEN_SENSITIVE="false"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
OMB_USE_SUDO=true
OMB_PROMPT_SHOW_PYTHON_VENV=true

completions=(
  git
  ssh
  docker
  docker-compose
  pip
  terraform
  tmux
  uv
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
  #tmux-autoattach
)

source "$OSH"/oh-my-bash.sh

[[ -f ~/.bash_aliases.sh ]] && source ~/.bash_aliases.sh

export LANG=en_IE.UTF-8
export SSH_KEY_PATH="~/.ssh/rsa_id"
export PATH="/home/daniel/.local/bin:$PATH" # uv
export PATH="$PATH:$HOME/.cargo/bin" # cargo
export LD_LIBRARY_PATH=/run/opengl-driver/lib:$LD_LIBRARY_PATH # cuda
