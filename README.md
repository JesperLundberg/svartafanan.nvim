# tomat.nvim

#### Demo

#### Why?

I wanted to work more with writing plugins for neovim and I also wanted to use the pomodoro method more in my daily work flow.

#### Required system dependencies

You also need nerdfonts patched version installed to get proper symbols.
Get fonts from [here](https://github.com/ryanoasis/nerd-fonts).

#### How to install

Using lazy package manager:

```lua
"JesperLundberg/tomat.nvim",
dependencies = {
    "rcarriga/nvim-notify",
    "nvim-lua/plenary.nvim",
},
config = function()
    require("tomat").setup({})
end,
```

#### Available commands

Example (To start a session):

```
:Tomat start
```

| Command | Description                           |
| ------- | ------------------------------------- |
| start   | Start a session                       |
| stop    | Stop a session                        |
| show    | Show when the current timer is ending |

#### Configuration

You must always run the setup method like this:

```lua
config = function()
	require("tomat").setup()
end
```

There are a few settings that might be relevant to change. The defaults are as follows:

```lua
local defaults = {
	session_time_in_minutes = 25,
	automatic = {
		create_a_new_session = false,
		break_time_in_minutes = 5,
	},
	icon = {
		in_progress = "",
		done = "",
	},
	notification = {
		title = "Tomat",
		timeout = 10000, -- 10 seconds
		timeout_on_timer_done = 600000, -- 10 minutes
	},
	persist = {
		enabled = true,
	},
}
```

Most are self explanatory but I think notification and persist warrant some elaboration.

Notification is settings for the instance of notify. If you want another title or timeout then you're free to change those.
Persist handles saving a session across restarts of neovim. If persist is enabled it writes a file with the session timer. If neovim is restarted it checks the file and restarts the session (provided it's not passed).

#### TODO

- [x] Write session to file so it can be resumed if neovim is restarted
- [x] Automatically resume session at start up (if it exists)
- [ ] Allow user to set the path for the file themselves
- [ ] Implement the functionality for automatically starting a new pomodoro session
  - [ ] Add break time

#### Local development

To run tests:

```bash
nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal.vim'}"
```

#### Credits
