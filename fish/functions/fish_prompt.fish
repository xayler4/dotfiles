function fish_prompt
    set cwd (set_color $fish_color_cwd)(prompt_pwd --full-length-dirs=2)
    set git_prompt (set_color $fish_color_git_status)(fish_git_prompt)
    set combined "$cwd$git_prompt"

	echo -n (set_color $fish_color_login)$USER'@'(prompt_hostname)(set_color $fish_color_separator)':'$combined(set_color $fish_color_suffix)'$ '
end

funcsave fish_prompt
