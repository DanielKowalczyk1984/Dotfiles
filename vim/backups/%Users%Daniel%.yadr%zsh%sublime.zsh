Vim�UnDo� ���'1
h05��XX0~\;Q|��zw@}%�   :                                  U�`g    _�                             ����                                                                                                                                                                                                                                                                                                                                                             UfϮ    �                   �               5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             U�^j     �               +   # Sublime Text 2 Aliases       $if [[ $('uname') == 'Linux' ]]; then   /    local _sublime_linux_paths > /dev/null 2>&1       _sublime_linux_paths=(            "$HOME/bin/sublime_text"   (        "/opt/sublime_text/sublime_text"           "/usr/bin/sublime_text"   %        "/usr/local/bin/sublime_text"           "/usr/bin/subl"       )   2    for _sublime_path in $_sublime_linux_paths; do   (        if [[ -a $_sublime_path ]]; then   =            st_run() { $_sublime_path $@ >/dev/null 2>&1 &| }   B            st_run_sudo() {sudo $_sublime_path $@ >/dev/null 2>&1}   !            alias sst=st_run_sudo               alias st=st_run               break   
        fi       done       %elif  [[ "$OSTYPE" = darwin* ]]; then   0    local _sublime_darwin_paths > /dev/null 2>&1       _sublime_darwin_paths=(           "/usr/local/bin/subl"   H        "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"   M        "$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"       )       3    for _sublime_path in $_sublime_darwin_paths; do   (        if [[ -a $_sublime_path ]]; then   )            alias subl="'$_sublime_path'"               alias st=subl               break   
        fi       done   fi       alias stt='st .'5�_�                    (       ����                                                                                                                                                                                                                                                                                                                            (                    V       U�^�     �   '   +   +          done5�_�                    *       ����                                                                                                                                                                                                                                                                                                                            (                    V       U�^�     �   *   =   -    �   *   +   -    5�_�                    .       ����                                                                                                                                                                                                                                                                                                                            (                    V       U�^�     �   -   .          H        "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"5�_�                    .       ����                                                                                                                                                                                                                                                                                                                            (                    V       U�^�     �   -   .          J        "/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"5�_�                    6       ����                                                                                                                                                                                                                                                                                                                            (                    V       U�_     �   5   7   =      )            alias subl="'$_sublime_path'"5�_�      	              7       ����                                                                                                                                                                                                                                                                                                                            (                    V       U�_,     �   6   8   =                  alias st=subl5�_�      
           	   =       ����                                                                                                                                                                                                                                                                                                                            (                    V       U�_3     �   <              alias stt='st .'5�_�   	              
   =       ����                                                                                                                                                                                                                                                                                                                            (                    V       U�_5     �   <              alias stt='st .'5�_�   
                 =       ����                                                                                                                                                                                                                                                                                                                            (                    V       U�_7    �   <              alias sutt='st .'5�_�                    <        ����                                                                                                                                                                                                                                                                                                                            =          =          V       U�_H     �   <   >   =    �   <   =   =    5�_�                    =       ����                                                                                                                                                                                                                                                                                                                            >          >          V       U�_L     �   <   >   >      alias sutt='sut .'5�_�                    =       ����                                                                                                                                                                                                                                                                                                                            >          >          V       U�_N    �   <   >   >      alias stt='sut .'5�_�                    =       ����                                                                                                                                                                                                                                                                                                                                                             U�_�     �               >   # Sublime Text 2 Aliases       $if [[ $('uname') == 'Linux' ]]; then   /    local _sublime_linux_paths > /dev/null 2>&1       _sublime_linux_paths=(            "$HOME/bin/sublime_text"   (        "/opt/sublime_text/sublime_text"           "/usr/bin/sublime_text"   %        "/usr/local/bin/sublime_text"           "/usr/bin/subl"       )   2    for _sublime_path in $_sublime_linux_paths; do   (        if [[ -a $_sublime_path ]]; then   =            st_run() { $_sublime_path $@ >/dev/null 2>&1 &| }   B            st_run_sudo() {sudo $_sublime_path $@ >/dev/null 2>&1}   !            alias sst=st_run_sudo               alias st=st_run               break   
        fi       done       %elif  [[ "$OSTYPE" = darwin* ]]; then   0    local _sublime_darwin_paths > /dev/null 2>&1       _sublime_darwin_paths=(           "/usr/local/bin/subl"   H        "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"   M        "$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"       )       3    for _sublime_path in $_sublime_darwin_paths; do   (        if [[ -a $_sublime_path ]]; then   )            alias subl="'$_sublime_path'"               alias st=subl               break   
        fi       done              0    local _sublime_darwin_paths > /dev/null 2>&1       _sublime_darwin_paths=(           "/usr/local/bin/subl"   J        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"   M        "$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"       )       3    for _sublime_path in $_sublime_darwin_paths; do   (        if [[ -a $_sublime_path ]]; then   ,            alias sublime="'$_sublime_path'"               alias sut=subl               break   
        fi       done   fi       alias stt='st .'   alias sutt='sut .'5�_�                    /        ����                                                                                                                                                                                                                                                                                                                                                             U�_�     �   .   /          M        "$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"5�_�                    /       ����                                                                                                                                                                                                                                                                                                                                                             U�_�    �   .   /          O        "$HOME/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"5�_�                    /       ����                                                                                                                                                                                                                                                                                                                                                             U�_�     �               <   # Sublime Text 2 Aliases       $if [[ $('uname') == 'Linux' ]]; then   /    local _sublime_linux_paths > /dev/null 2>&1       _sublime_linux_paths=(            "$HOME/bin/sublime_text"   (        "/opt/sublime_text/sublime_text"           "/usr/bin/sublime_text"   %        "/usr/local/bin/sublime_text"           "/usr/bin/subl"       )   2    for _sublime_path in $_sublime_linux_paths; do   (        if [[ -a $_sublime_path ]]; then   =            st_run() { $_sublime_path $@ >/dev/null 2>&1 &| }   B            st_run_sudo() {sudo $_sublime_path $@ >/dev/null 2>&1}   !            alias sst=st_run_sudo               alias st=st_run               break   
        fi       done       %elif  [[ "$OSTYPE" = darwin* ]]; then   0    local _sublime_darwin_paths > /dev/null 2>&1       _sublime_darwin_paths=(           "/usr/local/bin/subl"   H        "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"   M        "$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"       )       3    for _sublime_path in $_sublime_darwin_paths; do   (        if [[ -a $_sublime_path ]]; then   )            alias subl="'$_sublime_path'"               alias st=subl               break   
        fi       done              0    local _sublime_darwin_paths > /dev/null 2>&1       _sublime_darwin_paths=(           "/usr/local/bin/subl"   J        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"       )       3    for _sublime_path in $_sublime_darwin_paths; do   (        if [[ -a $_sublime_path ]]; then   ,            alias sublime="'$_sublime_path'"               alias sut=subl               break   
        fi       done   fi       alias stt='st .'   alias sutt='sut .'5�_�                    *       ����                                                                                                                                                                                                                                                                                                                                                             U�_�     �   )   +   <          5�_�                    -       ����                                                                                                                                                                                                                                                                                                                                                             U�_�    �   ,   -                  "/usr/local/bin/subl"5�_�                    -       ����                                                                                                                                                                                                                                                                                                                                                             U�_�     �               ;   # Sublime Text 2 Aliases       $if [[ $('uname') == 'Linux' ]]; then   /    local _sublime_linux_paths > /dev/null 2>&1       _sublime_linux_paths=(            "$HOME/bin/sublime_text"   (        "/opt/sublime_text/sublime_text"           "/usr/bin/sublime_text"   %        "/usr/local/bin/sublime_text"           "/usr/bin/subl"       )   2    for _sublime_path in $_sublime_linux_paths; do   (        if [[ -a $_sublime_path ]]; then   =            st_run() { $_sublime_path $@ >/dev/null 2>&1 &| }   B            st_run_sudo() {sudo $_sublime_path $@ >/dev/null 2>&1}   !            alias sst=st_run_sudo               alias st=st_run               break   
        fi       done       %elif  [[ "$OSTYPE" = darwin* ]]; then   0    local _sublime_darwin_paths > /dev/null 2>&1       _sublime_darwin_paths=(           "/usr/local/bin/subl"   H        "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"   M        "$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"       )       3    for _sublime_path in $_sublime_darwin_paths; do   (        if [[ -a $_sublime_path ]]; then   )            alias subl="'$_sublime_path'"               alias st=subl               break   
        fi       done            echo '_sublime_darwin_paths'   0    local _sublime_darwin_paths > /dev/null 2>&1       _sublime_darwin_paths=(   J        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"       )       3    for _sublime_path in $_sublime_darwin_paths; do   (        if [[ -a $_sublime_path ]]; then   ,            alias sublime="'$_sublime_path'"               alias sut=subl               break   
        fi       done   fi       alias stt='st .'   alias sutt='sut .'5�_�                    *   	    ����                                                                                                                                                                                                                                                                                                                                                             U�_�     �   )   +   ;           echo '_sublime_darwin_paths'5�_�                    *       ����                                                                                                                                                                                                                                                                                                                                                             U�`    �   )   +   ;          echo _sublime_darwin_paths'5�_�                    *       ����                                                                                                                                                                                                                                                                                                                                                             U�`     �               ;   # Sublime Text 2 Aliases       $if [[ $('uname') == 'Linux' ]]; then   /    local _sublime_linux_paths > /dev/null 2>&1       _sublime_linux_paths=(            "$HOME/bin/sublime_text"   (        "/opt/sublime_text/sublime_text"           "/usr/bin/sublime_text"   %        "/usr/local/bin/sublime_text"           "/usr/bin/subl"       )   2    for _sublime_path in $_sublime_linux_paths; do   (        if [[ -a $_sublime_path ]]; then   =            st_run() { $_sublime_path $@ >/dev/null 2>&1 &| }   B            st_run_sudo() {sudo $_sublime_path $@ >/dev/null 2>&1}   !            alias sst=st_run_sudo               alias st=st_run               break   
        fi       done       %elif  [[ "$OSTYPE" = darwin* ]]; then   0    local _sublime_darwin_paths > /dev/null 2>&1       _sublime_darwin_paths=(           "/usr/local/bin/subl"   H        "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"   M        "$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"       )       3    for _sublime_path in $_sublime_darwin_paths; do   (        if [[ -a $_sublime_path ]]; then   )            alias subl="'$_sublime_path'"               alias st=subl               break   
        fi       done           echo _sublime_darwin_paths   0    local _sublime_darwin_paths > /dev/null 2>&1       _sublime_darwin_paths=(   J        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"       )       3    for _sublime_path in $_sublime_darwin_paths; do   (        if [[ -a $_sublime_path ]]; then   ,            alias sublime="'$_sublime_path'"               alias sut=subl               break   
        fi       done   fi       alias stt='st .'   alias sutt='sut .'5�_�                    4       ����                                                                                                                                                                                                                                                                                                                                                             U�`    �   3   5   ;                  alias sut=subl5�_�                    4       ����                                                                                                                                                                                                                                                                                                                                                             U�`b     �               ;   # Sublime Text 2 Aliases       $if [[ $('uname') == 'Linux' ]]; then   /    local _sublime_linux_paths > /dev/null 2>&1       _sublime_linux_paths=(            "$HOME/bin/sublime_text"   (        "/opt/sublime_text/sublime_text"           "/usr/bin/sublime_text"   %        "/usr/local/bin/sublime_text"           "/usr/bin/subl"       )   2    for _sublime_path in $_sublime_linux_paths; do   (        if [[ -a $_sublime_path ]]; then   =            st_run() { $_sublime_path $@ >/dev/null 2>&1 &| }   B            st_run_sudo() {sudo $_sublime_path $@ >/dev/null 2>&1}   !            alias sst=st_run_sudo               alias st=st_run               break   
        fi       done       %elif  [[ "$OSTYPE" = darwin* ]]; then   0    local _sublime_darwin_paths > /dev/null 2>&1       _sublime_darwin_paths=(           "/usr/local/bin/subl"   H        "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   J        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"   M        "$HOME/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 3.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"       )       3    for _sublime_path in $_sublime_darwin_paths; do   (        if [[ -a $_sublime_path ]]; then   )            alias subl="'$_sublime_path'"               alias st=subl               break   
        fi       done           echo _sublime_darwin_paths   0    local _sublime_darwin_paths > /dev/null 2>&1       _sublime_darwin_paths=(   J        "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"   O        "$HOME/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl"       )       3    for _sublime_path in $_sublime_darwin_paths; do   (        if [[ -a $_sublime_path ]]; then   ,            alias sublime="'$_sublime_path'"               alias sut=sublime               break   
        fi       done   fi       alias stt='st .'   alias sutt='sut .'5�_�                     *       ����                                                                                                                                                                                                                                                                                                                                                             U�`f    �   )   *              echo _sublime_darwin_paths5��