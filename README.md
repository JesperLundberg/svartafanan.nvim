# svartafanan.nvim

#### Demo

#### Why?

Mostly becasue I wanted to create another plugin but also because I use the cube to get micropauses to think during my daily development work, or when I wait for something (compilation, rebuild or similar).

Why the name SvartaFanan? Well, there are a few reasons. The main one was that I listened to [Nasum - Den Svarta Fanan](https://open.spotify.com/track/0gdarqfBPUKnSdbfaNA34t?si=799baa90579a4818) when I got the idea and wanted to honor Miezsko, vocalist, guitarist and frontman of the band.

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

- [x] Allow more package managers than just lazy
- [ ] Add more sizes to get scrambles for
- [ ] Add timing functionality
- [ ] Be able to get another scramble if the window is already opened

#### Local development

To run tests:

```bash
nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/ {minimal_init = 'tests/minimal.vim'}"
```

#### Credits

Miezsko Talarczyk - for creating great music. RIP.
