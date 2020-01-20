for i in vim/pack/my-plugins/start/*
do
    repo=$(basename $i)
    git rm $i -fr
    git submodule add https://github.com/vim-scripts/$repo $i
    sleep 5
done
