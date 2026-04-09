function fish_prompt
    # Salva o status do último comando
    set -l last_status $status

    # Cores
    set -l reset (set_color normal)
    set -l red (set_color red)
    set -l green (set_color green)
    set -l blue (set_color blue)
    set -l yellow (set_color yellow)
    set -l cyan (set_color cyan)
    set -l magenta (set_color magenta)
    set -l bold_white (set_color --bold white)

    # --- Usuário e Host ---
    set -l user_color $green
    if test $USER = "root"
        set user_color $red
    end

    # --- Diretório atual ---
    set -l full_path $PWD
    set -l home_replaced (string replace -r "^$HOME" "~" $full_path)
    set -l depth (count (string split "/" (string replace "~/" "" $home_replaced | string trim -c "/")))

    set -l cwd
    if test $depth -ge 7
        set cwd (prompt_pwd)
    else
        set cwd $home_replaced
    end

    # --- Informações do Git ---
    set -l git_info ""
    if command -q git
        if git rev-parse --is-inside-work-tree >/dev/null 2>/dev/null
            set -l branch (git symbolic-ref --short HEAD 2>/dev/null)
            if test -z "$branch"
                set branch (git rev-parse --short HEAD 2>/dev/null)
            end

            set -l git_icons ""

            # Modified
            if not git diff --quiet 2>/dev/null
                set git_icons "$git_icons $yellow󰗖"
            end

            # Staged
            if not git diff --cached --quiet 2>/dev/null
                set git_icons "$git_icons $green"
            end

            # Untracked
            if test -n "$(git ls-files --others --exclude-standard 2>/dev/null)"
                set git_icons "$git_icons $cyan󰮍"
            end

            # Conflicts
            if test -n "$(git diff --name-only --diff-filter=U 2>/dev/null)"
                set git_icons "$git_icons $red"
            end

            # Ahead / Behind
            set -l upstream (git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)
            if test -n "$upstream"
                set -l counts (git rev-list --left-right --count HEAD...$upstream 2>/dev/null)
                set -l ahead (echo $counts | awk '{print $1}')
                set -l behind (echo $counts | awk '{print $2}')

                if test "$ahead" -gt 0
                    set git_icons "$git_icons $blue$ahead"
                end
                if test "$behind" -gt 0
                    set git_icons "$git_icons $blue$behind"
                end
            end

            set git_info " $brblack$reset$magenta $branch$git_icons $brblack$reset"
        end
    end

    # --- Status do último comando ---
    set -l status_symbol
    if test $last_status -eq 0
        set status_symbol "$green❯$reset"
    else
        set status_symbol "$red❯$reset"
    end

    # --- Prompt em 2 linhas ---
    echo
    # Linha 1: usuário | diretório | git
    echo -e "$user_color$USER$reset$bold_white in $reset$blue$cwd$reset$git_info"

    # Linha 2: símbolo de entrada
    echo -e "$status_symbol "
end
