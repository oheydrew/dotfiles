# Yay! High voltage and arrows!

prompt_setup_pygmalion(){
  ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}"
  ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
  ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}⚡%{$reset_color%}"
  ZSH_THEME_GIT_PROMPT_CLEAN=""

  # base_prompt='%{$fg[magenta]%}%n%{$reset_color%}%{$fg[red]%}@%{$reset_color%}%{$fg[cyan]%}%m%{$reset_color%}%{$fg[red]%}:%{$reset_color%}%{$fg[yellow]%}%0~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}'
  base_prompt='%{$reset_color%}%{$fg[yellow]%}%0~%{$reset_color%}%{$fg[red]%}|%{$reset_color%}'
  post_prompt=' $%{$reset_color%} '

  # green $
  # post_prompt='%{$fg[green]%} $ %{$reset_color%}'

  base_prompt_nocolor=$(echo "$base_prompt" | perl -pe "s/%\{[^}]+\}//g")
  post_prompt_nocolor=$(echo "$post_prompt" | perl -pe "s/%\{[^}]+\}//g")

  precmd_functions+=(prompt_pygmalion_precmd)
}

prompt_pygmalion_precmd(){
  local gitinfo=$(git_prompt_info)
  local gitinfo_nocolor=$(echo "$gitinfo" | perl -pe "s/%\{[^}]+\}//g")
  local exp_nocolor="$(print -P \"$base_prompt_nocolor$gitinfo_nocolor$post_prompt_nocolor\")"
  local prompt_length=${#exp_nocolor}

  local nl=""
  local venv_info=""

  if [[ $prompt_length -gt 50 ]]; then
    nl=$'\n%{\r%}' ;
  fi
  PROMPT="$base_prompt$nl$post_prompt "

  # right prompt
  if type "virtualenv_prompt_info" > /dev/null
  then
      venv_info="%{$fg[cyan]%}$(virtualenv_prompt_info)%{$reset_color%}"
  else
      venv_info=""
  fi

  # Right hand Git Prompt
  RPROMPT="$(git_prompt_info)$venv_info"

  #Right hand Time '%*'
  # RPROMPT='%{$fg[cyan]%} %*%{$reset_color%}'
}

prompt_setup_pygmalion


