# Linux installation
A very crude installation instruction for Linux. Tested on Arch linux.
I am not very knowledgeable on cmake and C++ ecosystem, so many steps are done manually. All build and install steps should be moved to cmake

## clone remotes
```bash
  git clone --branch linux-wip https://github.com/valgusk/prboom-plus-rt.git
  cd prboom-plus-rt
  git submodule update --init --recursive
```
## 

## build RayTracedGL1
```bash
  cd dependencies/RayTracedGL1
  mkdir build
  cd build
  DLSS_SDK_PATH=$(pwd)/../dependencies/DLSS/ cmake ..
  make

  cd ../../..
```

# build prboom-plus-rt
```bash
  cd prboom2
  mkdir build
  cd build
  RTGL1_SDK_PATH=$(pwd)/../../dependencies/RayTracedGL1 cmake ..
  make

  cd ../../
```

# manually install
```bash
  export PRBOOMRT_INSTALLDIR=<userspace installation directory here>
  mkdir -p $PRBOOMRT_INSTALLDIR

  cp prboom2/build/libRayTracedGL1.so $PRBOOMRT_INSTALLDIR/libRayTracedGL1.so
  cp prboom2/build/prboom-plus.wad $PRBOOMRT_INSTALLDIR/prboom-plus.wad
  cp prboom2/build/prboom-plus $PRBOOMRT_INSTALLDIR/prboom-plus

  # DLSS seems to work only if compiled on 2.3 and library copied from 2.4.0
  mkdir $PRBOOMRT_INSTALLDIR/rel
  curl -O -L --output-dir $PRBOOMRT_INSTALLDIR/rel https://github.com/NVIDIA/DLSS/raw/b3559040f968d26b2edbe37e8e3ceda4b8d1275a/lib/Linux_x86_64/rel/libnvidia-ngx-dlss.so.2.4.0

  export ORIGINAL_RELEASE=https://github.com/sultim-t/prboom-plus-rt/releases/download/v2.6.1-rt1.0.2/prboom-rt-1.0.2a.zip
  curl -o winprboom.zip -L --output-dir $PRBOOMRT_INSTALLDIR $ORIGINAL_RELEASE
  unzip $PRBOOMRT_INSTALLDIR/winprboom.zip 'ovrd/*' -d $PRBOOMRT_INSTALLDIR/
```

to run:
```bash
cd $PRBOOMRT_INSTALLDIR
./prboom-plus -iwad <userspace doom.wad path here>
```
# NOTE: 
probably because of my hacks, for DLSS to consider your true resolution, set `exclusive_fullscreen=1` in `~/.prboom-plus/prboom-plus.cfg`. Otherwise it will upscale to desktop resolution
