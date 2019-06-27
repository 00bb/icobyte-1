#/bin/bash

# This file is modified from https://github.com/getlantern/systray/blob/master/example/icon/make_icon.sh

if [ -z "$GOPATH" ]; then
    echo GOPATH environment variable not set
    exit
fi

if [ ! -e "$GOPATH/bin/2goarray" ]; then
    echo "Installing 2goarray..."
    go get github.com/cratonica/2goarray
    if [ $? -ne 0 ]; then
        echo Failure executing go get github.com/cratonica/2goarray
        exit
    fi
fi

filenames=$(ls icofile/*.ico)
for file in ${filenames};do
    filetmp="${file#icofile\/}"
    name="${filetmp%.ico}"
    uname=Reddit
    # 生成
    OUTPUT="${name}.go"
    echo Generating $OUTPUT
    echo "// package icobyte" > $OUTPUT
    cat $file | $GOPATH/bin/2goarray $uname icobyte >> $OUTPUT
    if [ $? -ne 0 ]; then
        echo Failure generating $OUTPUT
        exit
    fi
done
echo Finished