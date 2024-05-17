# Quicksave

Quick and dirty commands to save and load sessions (`:h mksession`) .

Some comments:

- Sessions are uniquely identified by the current working directory, so you can
save/load only one single session for any directory.

- Sessions are stored in `~/.local/share/nvim/quicksave/`.

- Sessions are not automatically saved.

> This is just a PoC. I just want to save some time by not having to reopen
every file I was working on.

## Install

### Lazy

You know the drill.

```lua
return {
    "enricava/quicksave",
    config = function()
        require("quicksave").setup()
        -- Add your own keymaps here
        vim.keymap.set("n", "<leader>ss", "<CMD>SessionSave<CR>", { silent = true })
        vim.keymap.set("n", "<leader>sl", "<CMD>SessionLoad<CR>", { silent = true })
    end
}
```
