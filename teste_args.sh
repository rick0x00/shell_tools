#!/usr/bin/env bash



echo "############## dentro de função"

function teste() {
echo "numero args $#"
echo "args com \$@: $@"
echo "args com \$*: $*"

echo ''

echo ´Usando \$* no for: $*´

for arg in "$*"; do
    echo $arg
done

echo ''

echo ´Usando \$@ no for: $@´
for arg in "$@"; do
    echo $arg
done

echo ''

echo ´Usando \$* no while: $*´
while [ -n "$1" ]; do
    echo "primero arg: $1"
    echo "segundo arg: $2"
    shift
done
}


echo "######3 pasando com \$@"
teste "$@"





echo "############## fora de função"
echo "numero args $#"
echo "args com \$@: $@"
echo "args com \$*: $*"

echo ''

echo ´Usando \$* no for: $*´

for arg in "$*"; do
    echo $arg
done

echo ''

echo ´Usando \$@ no for: $@´
for arg in "$@"; do
    echo $arg
done

echo ''

echo ´Usando \$* no while: $*´
while [ -n "$1" ]; do
    echo "primero arg: $1"
    echo "segundo arg: $2"
    shift
done




