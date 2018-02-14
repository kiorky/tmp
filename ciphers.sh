for cipher in $(ssh -Q cipher) ; do
    for i in 1 2 3 ; do
        echo
        echo "Cipher: $cipher (try $i)"         
        if dd if=/dev/zero bs=1M count=128 2>/tmp/dd.txt \
        | pv \
        | time -p ssh -c "$cipher" -F .vagrant/cops-sshconfig-corpusops* vagrant 'cat > /dev/null';then
            grep -v records /tmp/dd.txt
            break
        fi
    done
done
