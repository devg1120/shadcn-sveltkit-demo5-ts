
#find . -type f | xargs -0 sed -i -e "s/registry\/new-york/components/g"

find . -type f  | xargs sed -i 's/registry\/new-york/components/g'
find . -type f  | xargs sed -i 's/registry\/default/components/g'

