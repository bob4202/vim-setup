# Shortcuts Cheatsheet

Leader key is `<space>`.

## Windows / Editing

- `<C-h/j/k/l>` — move focus between split windows — `<C-l>` jumps to the split on the right
- `<Esc>` — clear search highlight — after `/foo<CR>`, press `<Esc>` to remove the highlight
- `<leader>f` — format current buffer — save-worthy code without leaving insert mode habits
- `<leader>q` — open diagnostics in the quickfix list — see every error/warning in the file at once
- `jk` (insert mode, in Telescope prompt only) — acts like `<Esc>`

## Motions / Text Objects

- `vi{` / `va{` — select inside/around `{}` — cursor inside a function body, `vi{` grabs just the body
- `V]}` — visual-line select down to the matching unmatched `}` — cursor on `func foo() {`, selects the whole function
- `saiw)` — surround add: wrap inner word in `()` — cursor on `foo`, `saiw)` → `(foo)`
- `sd'` — surround delete: remove surrounding `'` — `'foo'` → `foo`
- `sr)'` — surround replace: `()` → `''` — `(foo)` → `'foo'`
- `ci'` — change inside quotes — cursor anywhere in `'foo'`, `ci'` clears it, ready to type

## Telescope (fuzzy finder)

- `<leader>fd` — find files in project (respects `.gitignore`) — quick file jump
- `<leader>fD` — find files, including ignored/hidden ones — when `.gitignore` is hiding what you need
- `<leader>sg` — live grep across the whole project — search for a string everywhere
- `<leader>sw` — grep the word under the cursor — instant "where else is this used"
- `<leader>/` — fuzzy search inside the current buffer only
- `<leader>sr` — resume the last Telescope search exactly where you left off
- `<leader><leader>` — list open buffers

## Harpoon

- `<leader>a` — add current file to Harpoon — mark a file you'll come back to
- `<C-e>` — toggle the Harpoon quick menu — see/edit all marked files
- `<leader>1..4` — jump straight to Harpoon slot 1-4
- `<leader>r12` — swap Harpoon slots 1 and 2
- `<leader>ra1` — replace Harpoon slot 1 with the current file

## Oil (file explorer)

- `-` — open the parent directory as an editable buffer — edit the directory like text, `:w` to apply

## LSP

- `grd` — go to definition — cursor on a function call, jumps to where it's defined
- `grr` — find references — cursor on a symbol, lists every place it's used
- `gra` — code actions menu — cursor on an error, shows quick fixes
- `grn` — rename symbol everywhere — cursor on a variable, renames all usages
- `<leader>oi` — add/organize missing imports, one keypress, no menu
- `<leader>th` — toggle inlay hints (inline type/param hints)
- `[d` / `]d` — jump to previous/next diagnostic in the file

## Completion (insert mode)

- `<Tab>` / `<S-Tab>` — move to next/previous completion suggestion
- `<Enter>` — accept the highlighted suggestion (only if you've navigated to one with `<Tab>` first — otherwise it's just a newline)
- `<C-space>` — open the completion menu / show docs
