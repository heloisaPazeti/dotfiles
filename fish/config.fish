if status is-interactive
    set -U fish_greeting ""
    set -Ux EDITOR nvim
    set -Ux VISUAL nvim

    alias ls='eza --icons=auto --group-directories-first --color=auto'

    fish_vi_key_bindings
    bind -M insert -m default jk backward-char force-repaint

    if status is-interactive
    and not set -q TMUX
    and test -z "$NO_TMUX"
    and type -q tmux
        if tmux has-session -t Main 2>/dev/null
            set -l attached (tmux display-message -p -t Main "#{?session_attached,1,0}" 2>/dev/null)
            if test "$attached" = "0"
                exec tmux attach -t Main
            end
        else
            exec tmux new-session -s Main
        end
    end

    alias rm='trash-put'
    alias esp_env="source $HOME/esp/esp-idf/export.fish"
end

