# kaggle-switch

`kgs` keeps several Kaggle API accounts on one Mac and lets you pick which one the `kaggle` CLI uses, per shell or per command.

It is a single bash script with no dependencies. It works with the bash 3.2 that ships with macOS, and on Linux.

## Install

Homebrew:

```bash
brew tap ridh21/kaggle-switch https://github.com/ridh21/kaggle-switch
brew trust ridh21/kaggle-switch
brew install kaggle-switch
```

Recent Homebrew versions refuse to load formulae from a third-party tap until you trust it. If your `brew` has no `trust` command, skip that line.

Without Homebrew:

```bash
curl -fsSL https://raw.githubusercontent.com/ridh21/kaggle-switch/main/install.sh | bash
```

Then add the shell hook to `~/.zshrc` (or `~/.bashrc`) and open a new terminal:

```bash
eval "$(kgs shell-init)"
```

The hook is what lets `kgs use` change the account in your current shell. Everything else works without it.

You also need the Kaggle CLI itself: `pip install kaggle`.

## Usage

```bash
kgs add personal                              # prompts for username and API key
kgs add lab --file ~/Downloads/kaggle.json    # import a downloaded kaggle.json
kgs add work --token                          # prompts for a KGAT_... API token

kgs list                                      # * marks the active account
kgs use lab                                   # switch this shell
kaggle kernels list --mine                    # runs as "lab"

kgs run personal -- kaggle kernels push -p ./notebook   # one command as "personal"
kgs current
kgs quota                                     # weekly GPU hours left on every account
kgs quota lab personal                        # or just some of them
kgs remove work
```

`kgs quota` needs Kaggle CLI 2.2 or newer, because it relies on the `kaggle quota` command.

`kgs run` only affects the command it launches, so you can run jobs as different accounts in separate terminals at the same time.

## How it works

Each account is stored in its own directory:

```
~/.config/kaggle-accounts/
├── .current              # name of the default account
├── personal/kaggle.json
├── lab/kaggle.json
└── work/access_token
```

Directories are `700` and credential files are `600`. `kgs` points the Kaggle CLI at an account by setting `KAGGLE_CONFIG_DIR` (and `KAGGLE_API_TOKEN` for token accounts). It unsets `KAGGLE_USERNAME` and `KAGGLE_KEY`, because those would otherwise override the selected account.

Your existing `~/.kaggle/kaggle.json` is never touched. To bring it in, run `kgs add <name> --file ~/.kaggle/kaggle.json`.

If `~/.kaggle/access_token` exists, the Kaggle CLI uses it ahead of any `kaggle.json`, so accounts saved from a `kaggle.json` end up running as the token's owner. `kgs run` and `kgs use` print a warning when this happens. Move the file into `kgs` with `kgs add <name> --token < ~/.kaggle/access_token`, then delete the original. `kgs quota` gets around the problem on its own.

Set `KGS_HOME` to store accounts somewhere else.

## Intended use

This is for machines shared by several people, or for someone who legitimately holds separate accounts (for example a personal one and an organisation one). Kaggle's terms allow one account per person, and using extra accounts to get around GPU or submission limits can get all of them banned.

## License

MIT
