# dotfiles

設定ファイルを再利用・管理する

## script_linux

linux用シンボリック作成スクリプト
dotfilesディレクトリを指定

強制的にリンクで上書きするので注意

## macのみtmuxのクリップボード関連の処理を入れている

brew instal reattach-to-user-namespace

以下のスクリプトをtmux-pbcopyという名前でパスが通ったところに置く
```
#!/bin/sh

tmux save-buffer /tmp/.tmux_to_pbcopy
cat /tmp/.tmux_to_pbcopy | pbcopy

# for message
tmux display-message "Copied."
```

## Powerline関連

```
brew install python
pip install --user powerline-status
pip install --user git+git://github.com/powerline/powerline
git clone git@github.com:powerline/fonts.git
brew install macvim --env-std --override-system-vim
```
