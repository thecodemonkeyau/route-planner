#!/bin/bash
# author: Blake Swadling

# run this script in your base projects folder to set up the environment
# for the Udacity C++ Route Planning project
# this script is for Ubuntu 22.04, it may work on other versions but has not been tested
# usage: ./udacity_setup.sh
set -e  # exit on error

# update and install deps
# tested on 22.04
sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential libcairo2-dev libgraphicsmagick1-dev libpng-dev cmake

#build and install IO2D
git clone --recurse-submodules https://github.com/cpp-io2d/P0267_RefImpl
cd P0267_RefImpl && mkdir -p debug && cd debug
cmake -S .. -D CMAKE_BUILD_TYPE=Debug && cmake --build .
make && sudo make install
cd ../..

#clone the skeleton route planner project
git clone --recurse-submodules https://github.com/udacity/CppND-Route-Planning-Project.git
cd CppND-Route-Planning-Project

# I want to work in my own repo, so switch origin to point to mine
git remote rename origin udacity
git remote add origin git@github.com:thecodemonkeyau/route-planner.git
git fetch origin/master && git rebase origin/master 

# build the sample
mkdir -p build && cd build
cmake .. && cmake --build .

# run the sample code
./OSM_A_star_search -f ../map.osm
