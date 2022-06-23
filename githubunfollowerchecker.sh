#!/bin/bash
_date="$(date +%d-%m-%Y_%H:%M:%S)"

[[ ! -d $HOME/.cache/githubunfollowers ]] && mkdir -p $HOME/.cache/githubunfollowers

[[ ! -n "$1" ]] && echo "Kullanıcı adı belirtiniz." && exit 1

DIRECTORY=$HOME/.cache/githubunfollowers
USERSFILE=$(find $HOME/.cache/githubunfollowers/ -iname "*${1}*")
[[ "$(echo $USERSFILE | sed 's/ /\n/g' | wc -l)" > 4 ]] && echo $USERSFILE | sed 's/ /\n/g' | sort | head -n 1 | xargs rm

REQ="$(curl -fsSL https://api.github.com/users/$1/followers?per_page=100 | jq -r .[].login)"

if [[ ! -n "$USERSFILE" ]]; then
        echo "Bu kullanıcıya ait hiç veri bulunamadı. Yeni veriler oluşturuluyor..."
        curl -fsSL https://api.github.com/users/$1/followers?per_page=100 | jq -r .[].login >> $DIRECTORY/${1}___${_date}
        exit
elif [[ -n "$USERSFILE" ]]; then
        LASTFOLLOWERS=$(echo $USERSFILE | sed 's/ /\n/g' | sort | tail -n 1)
        UNFS="""$(cat $LASTFOLLOWERS | grep -vE "$(echo $REQ | xargs echo | sed 's/ /|/g')")"""

        if [[ """$(echo $UNFS | grep -oi "[a-zA-Z0-9]" | wc -l)""" -eq "0" ]]; then
                echo -e """Son kontrol tarihi: $(echo $LASTFOLLOWERS | awk -F "___" '{print $2}' | sed 's/_/ ~ /g; s/-/\//g')\nTakipten çıkan kişi yok."""
        else
                for a in $UNFS; do
                        echo "$a kişisi takipten çıktı. Adres: https://github.com/$a"
                done
        fi

        echo "Son durum kaydediliyor..." && curl -fsSL https://api.github.com/users/$1/followers?per_page=100 | jq -r .[].login >> $DIRECTORY/${1}___${_date}
fi
