# tomat.nvim

#### Demo

#### Why?

[Black Flag]()

#### Requirements

You must run [lazy.nvim](https://github.com/folke/lazy.nvim) package manager for the file to be found.

#### How to install

Using lazy package manager:

```lua
"JesperLundberg/svartafanan.nvim",
event = "VeryLazy"
```

#### Available commands

Example (To start a session):

```
:SvartaFanan 2x2
```

| Command | Description        |
| ------- | ------------------ |
| 2x2     | Get a 2x2 scramble |
| 3x3     | Get a 3x3 scramble |

#### TODO

- [ ] Allow more package managers than just lazy

#### Local development

To run tests:

```bash
nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal.vim'}"
```

#### Credits
