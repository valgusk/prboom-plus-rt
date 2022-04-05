cd build

RTGL1_SDK_PATH=/home/pew/dev/prboom-plus-rt/deps/RayTracedGL1 cmake ..
make

cp ../../deps/RayTracedGL1/build/libRayTracedGL1.so .

DOOMWADPATH=$(pwd)/ ./prboom-plus -iwad $(pwd)/DOOM.WAD