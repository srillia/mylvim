# A Basic Stable IDE config for Neovim

> Why does this repo exist?

This config attempts to provide a rock solid fully featured starting point for someone new to Neovim, or just tired of maintaining the basic IDE components of their config.

> What makes it "rock solid"?

All of the included plugins are pinned to a version that ensures they are compatible and will not update potentially introducing errors into your config. For every Neovim release I will update this repo along with the community to keep it up to date with the newest versions.

As I mentioned, this config is meant as a starting point for people new to Neovim who want a familiar IDE experience. The config has a very simple structure that makes it easy to add new plugins.

## Install Neovim 0.8

You can install Neovim with your package manager e.g. brew, apt, pacman etc.. but remember that when you update your packages Neovim may be upgraded to a newer version.

If you would like to make sure Neovim only updates when you want it to than I recommend installing from source:

**NOTE** Verify the required [build prerequisites](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites) for your system.

```sh
git clone https://github.com/neovim/neovim.git
cd neovim
git checkout release-0.8
make CMAKE_BUILD_TYPE=Release
sudo make install
```

## Install the config

Make sure to remove or move your current `nvim` directory

```sh
git clone https://github.com/LunarVim/nvim-basic-ide.git ~/.config/nvim
```

Run `nvim` and wait for the plugins to be installed

**NOTE** (You will notice treesitter pulling in a bunch of parsers the next time you open Neovim)

**NOTE** Checkout this file for some predefined keymaps: [keymaps](https://github.com/LunarVim/nvim-basic-ide/blob/master/lua/user/keymaps.lua)

## Get healthy

Open `nvim` and enter the following:

```
:checkhealth
```

You'll probably notice you don't have support for copy/paste also that python and node haven't been setup

So let's fix that

First we'll fix copy/paste

- On mac `pbcopy` should be builtin

- On Ubuntu

  ```sh
  sudo apt install xsel # for X11
  sudo apt install wl-clipboard # for wayland
  ```

Next we need to install python support (node is optional)

- Neovim python support

  ```sh
  pip install pynvim
  ```

- Neovim node support

  ```sh
  npm i -g neovim
  ```

We will also need `ripgrep` for Telescope to work:

- Ripgrep

  ```sh
  sudo apt install ripgrep
  ```

---

**NOTE** make sure you have [node](https://nodejs.org/en/) installed, I recommend a node manager like [fnm](https://github.com/Schniz/fnm).

## Fonts

I recommend using the following repo to get a "Nerd Font" (Font that supports icons)

[getnf](https://github.com/ronniedroid/getnf)

## Configuration

### LSP

To add a new LSP

First Enter:

```
:LspInstallInfo
```

and press `i` on the Language Server you wish to install

Next you will need to add the server to this list: [servers](https://github.com/LunarVim/nvim-basic-ide/blob/8b9ec3bffe8c8577042baf07c75408532a733fea/lua/user/lsp/lsp-installer.lua#L6)

### Formatters and linters

Make sure the formatter or linter is installed and add it to this setup function: [null-ls](https://github.com/LunarVim/nvim-basic-ide/blob/8b9ec3bffe8c8577042baf07c75408532a733fea/lua/user/lsp/null-ls.lua#L13)

**NOTE** Some are already setup as examples, remove them if you want

### Plugins

You can install new plugins here: [plugins](https://github.com/LunarVim/nvim-basic-ide/blob/8b9ec3bffe8c8577042baf07c75408532a733fea/lua/user/plugins.lua#L42)

---

## Plugins
 - Comment.nvim
 - LuaSnip
 - alpha-nvim
 - bufdelete.nvim
 - bufferline.nvim
 - cmp-buffer
 - cmp-nvim-lsp
 - cmp-nvim-lua
 - cmp-path
 - cmp_luasnip
 - darkplus.nvim
 - diffview.nvim
 - dressing.nvim
 - exrc.nvim
 - friendly-snippets
 - gitsigns.nvim
 - hop.nvim
 - impatient.nvim
 - indent-blankline.nvim
 - lsp_signature.nvim
 - lualine.nvim
 - markdown-preview.nvim
 - mason-lspconfig.nvim
 - mason.nvim
 - neoscroll.nvim
 - null-ls.nvim
 - nvim-autopairs
 - nvim-bqf (not loaded)
 - nvim-cmp
 - nvim-colorizer.lua
 - nvim-dap
 - nvim-dap-ui
 - nvim-jdtls (not loaded)
 - nvim-lspconfig
 - nvim-navic
 - nvim-notify
 - nvim-spectre
 - nvim-surround
 - nvim-tree.lua
 - nvim-treesitter
 - nvim-treesitter-context
 - nvim-ts-autotag
 - nvim-ts-context-commentstring
 - nvim-ts-rainbow
 - nvim-web-devicons
 - overseer.nvim
 - packer.nvim
 - plenary.nvim
 - project.nvim
 - rnvimr
 - schemastore.nvim
 - symbols-outline.nvim
 - tabout.nvim
 - telescope.nvim
 - toggleterm.nvim
 - tokyonight.nvim
 - trouble.nvim
 - vim-illuminate
 - which-key.nvim

---

> The computing scientist's main challenge is not to get confused by the complexities of his own making.

\- Edsger W. Dijkstra
