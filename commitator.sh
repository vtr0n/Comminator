#!/bin/bash

echo "Enter your repository link"
read repo

# clean directory
rm -rf dir

# initialize git
mkdir dir && cd dir
git init

N=365
date=$(date +%s)

echo "Generating fake contributions"
for i in $(seq $N -1 0)
    do
        rand=$(((RANDOM % 3) + 1))
        for j in $(seq 1 $rand)
            do
                filename="${i}_${j}"

                let "new_date = $date - ($i * 60*60*24)"

                touch $filename
                git add $filename
                git commit --date="$new_date" -m "$filename" >/dev/null 2>>../error.log

            done
    done

git remote add origin $repo
git push origin master
