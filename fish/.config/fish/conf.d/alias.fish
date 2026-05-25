function cp --description 'alias: cp cp -i'
   command cp -i $argv;
end

function pip --description 'alias: pip=python -m pip'
    python -m pip $argv
end

function mkcd --description "alias: mkdir then cd to the lastest one"
    mkdir -pv $argv
    cd $argv
end

# function cat --description "alias: bat as cat replacement"
#     bat $argv
# end
