#!/bin/bash                                                                     
                                                                                
set -e                                                                          
REPO=$(pwd)                                                                                                                                                                                                                                                                                                                
                                                                                
# Create all (may) non-existing directories                                     
mkdir -p ~/.vim/bundle                                                          
mkdir -p ~/.repos                                                               
                                                                                
# Link all configuration files                                                  
ln -fs $REPO/calcrc                       ~/.calcrc                             
ln -fs $REPO/gdbinit                      ~/.gdbinit                            
ln -fs $REPO/inputrc                      ~/.inputrc                            
ln -fs $REPO/tigrc                        ~/.tigrc                              
ln -fs $REPO/tmux.conf                    ~/.tmux.conf                          
ln -fs $REPO/zshrc                        ~/.zshrc                              
ln -fs $REPO/vim/vimrc                    ~/.vimrc                              
ln -fs $REPO/vim/custom.vim               ~/.vim/custom.vim                     
                                                                                
# Install vim Plugins                                                           
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim  
vim -c "PluginInstall" -c "qa"                                                  
~/.vim/bundle/YouCompleteMe/install.py --clangd-completer                       
ln -fs $REPO/vim/ycm_extra_conf.py ~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py
                                                                                
# Install zsh Plugins                                                           
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git      ~/.repos/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git          ~/.repos/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-history-substring-search.git ~/.repos/zsh-history-substring-search
sed -i "s/PATH_SYNTAX=\".*\"/PATH_SYNTAX=\"\$HOME\/.repos\/zsh-syntax-highlighting\/\"/"            ~/.zshrc
sed -i "s/PATH_AUTOSUGGEST=\".*\"/PATH_AUTOSUGGEST=\"\$HOME\/.repos\/zsh-autosuggestions\/\"/"      ~/.zshrc
sed -i "s/PATH_SUBSTRING=\".*\"/PATH_SUBSTRING=\"\$HOME\/.repos\/zsh-history-substring-search\/\"/" ~/.zshrc
