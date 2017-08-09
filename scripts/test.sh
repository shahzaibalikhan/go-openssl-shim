declare -a distros=("alpine" "jessie" "stretch" "trusty" "xenial")
declare -a builds=()

for d in "${distros[@]}"
do
   if make build DISTRO=$d
   then builds+=($d)
   else echo "couldn't build image for ${d}"
   fi
done

for b in "${builds[@]}"
do
    make run DISTRO=$b
done