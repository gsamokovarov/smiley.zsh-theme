autoload -U add-zsh-hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' actionformats \
       '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*' formats '%F{2}%s%F{7}:%F{2}(%F{1}%b%F{2})%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git

add-zsh-hook precmd prompt_vcs

prompt_vcs () {
  vcs_info

  if [ "${vcs_info_msg_0_}" != "" ]; then
    vcs_info_msg_0_=" ${vcs_info_msg_0_}"
  fi
}

function {
  if [[ -n "$SSH_CLIENT" ]]; then
    PROMPT_HOST="($HOST)"
  else
    PROMPT_HOST=''
  fi
}

local ret_status="%(?:%{$fg_bold[green]%}☺ :%{$fg_bold[red]%}☹ )"

PROMPT='${ret_status}%{$fg[blue]%} ${PROMPT_HOST}%{$fg_bold[green]%}%p%{$reset_color%}'
RPROMPT='%{$fg_bold[yellow]%}%2~${vcs_info_msg_0_}%{$reset_color%}'

#  vim: set ft=zsh ts=4 sw=4 et:
