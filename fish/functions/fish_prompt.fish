function fish_prompt
	echo -n (set_color $fish_color_login)$USER'@'(prompt_hostname) (set_color $fish_color_cwd)(prompt_pwd)(set_color $fish_color_git_status)(fish_git_prompt) (set_color $fish_color_suffix)'󰽰 '
end

funcsave fish_prompt
