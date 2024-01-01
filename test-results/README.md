# random notes


## Dependency Installation Details

### Package management
| VDI solution | Unified Server, Client installers | Separate Server, Client installers                                  | Has RPM                                                                              | Has DEB                                                                               | Has DMG                                          | Has EXE                                | Has MSI                   |
|--------------|-----------------------------------|---------------------------------------------------------------------|--------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------|--------------------------------------------------|----------------------------------------|---------------------------|
| NICE DCV     | no                                | yes                                                                 | yes, only via tar                                                                    | yes, only via tar                                                                     | yes, only via tar. client only avail in homebrew | yes, chocolatey or direct bin download | no                        |
| realvnc      | yes (RealVNC Connect)             | yes                                                                 | yes, direct bin download                                                             | yes, direct bin download                                                              | yes, direct bin download                         | yes, chocolatey or direct bin download | yes, direct bin download  |
| tigervnc     | no                                | yes                                                                 | yes, native package mgmt in many distros (Centos, AL2, Rocky) or direct bin download | yes, native package mgmt in many distros (e.g. Debian, Ubuntu) or direct bin download | yes, homebrew or direct bin download             | yes, chocolatey or direct bin download | no                        |
| turbovnc     | yes                               | no                                                                  | yes, packagecloud.io repo or direct bin download                                     | yes, packagecloud.io repo or direct bin download                                      | yes, homebrew or direct bin download             | yes, direct bin download               | no                        |
| xpra         | yes (xpra package)                | yes, but only if using https://xpra.org/dist or direct bin download | yes, some native package mgmt, or xpra.org/dist, or direct bin download              | yes, some native package mgmt, or xpra.org/dist, or direct bin download               | yes, homebrew or direct bin download             | yes, direct bin download               | yes, direct bin download  |

### Package size

#### Client
| VDI solution | RPM             | DEB              | DMG          | EXE             |
|--------------|-----------------|------------------|--------------|-----------------|
| NICE DCV     | ~18.8M - ~ ~21M | ~17.5M -> ~19.6M | ~44M - ~47M  | ~65.7M - ~68.6M |
| RealVNC      | ?               | ?                | ?            | ?               |
| TigerVNC     | ~0.3M           | ~0.3M            | ~6M          | ~6.7M           |
| TurboVNC     | ~39.7M - ~40.3M | ~38.4M - ~39.1M  | ~38 - ~39.6M | ~38.3 - ~37.9   |
| Xpra         | ~4.8M           | ~3.4M            | ~61M - ~68M  | ~138M           |

#### Server
| VDI solution | RPM                          | DEB                          | DMG                      | EXE                      |
|--------------|------------------------------|------------------------------|--------------------------|--------------------------|
| NICE DCV     | ~15.2M - ~17.7M              | ~14.2M - 15.5M               | N/A                      | ~58.7M                   |
| RealVNC      | ?                            | ?                            | ?                        | ?                        |
| TigerVNC     | ~1.3M                        | ~1.6M                        | N/A                      | N/A                      |
| TurboVNC     | packaged with client         | packaged with client         | N/A                      | N/A                      |
| Xpra         | usually packaged with client | usually packaged with client | ? packaged with client ? | ? packaged with client ? |

#### Analysis Caveats

- The information above is for the most recently released bins at time of writing only (2023-12-29).
- RealVNC is not analyzed yet because they don't seem to list download size in an easy to grab way.
- The size does not include globally required dependencies of packages, or uncompressed artifact size, so this isn't the whole picture yet.
- Mostly relying on stats posted on "official download page" (e.g. https://www.nice-dcv.com/, or https://github.com/TurboVNC/turbovnc/releases/tag/3.1 ) or pkg.org (e.g. https://rhel.pkgs.org/9/epel-x86_64/xpra-5.0.2-2.el9.x86_64.rpm.html).
    - To make this comparison better in the future:
      - install package including deps in 1 docker layer and measure layer build/deploy stats
      - to get full picture of impact of using the dependency, measure:
  - time of download, extract, publish stages of the image build
  - layer size
  - number and/or list of transitive dependencies
- Artifact size ranges indicate the various size between architectures (e.g. amd64 vs aarch64) and supported OS (e.g. ubuntu 22.04 vs 20.04).
- If provided separately, this does not include analysis of src or doc artifacts (e.g. man pages), only binaries necessary for runtime of the client or server 




info saved for later

## laptop (780M) issues\

segfaulting on blender HIP run. not always in same place on the computation. see logs:

```
USER_ID: 1000, GROUP_ID: 1000
nss_wrapper location: /usr/lib64/libnss_wrapper.so
bash-5.1$ ./blender -noaudio --enable-autoexec -b ../bmw27_gpu.blend -o output.test -x 1 -F JPEG -f 1 -- --cycles-device HIP
bash: ./blender: No such file or directory
bash-5.1$ cd /home/user/.
./                    .bash_profile         .phoronix-test-suite/
../                   .bashrc               
.bash_logout          .cache/               
bash-5.1$ cd /home/user/.phoronix-test-suite/
core.pt2so                            openbenchmarking.org/
download-cache/                       phoronix-test-suite-dependencies.log
graph-config.json                     test-profiles/
installed-tests/                      test-results/
modules/                              test-suites/
modules-data/                         user-config.xml
bash-5.1$ cd /home/user/.phoronix-test-suite/installed-tests/pts/blender-4.0.0/
bash-5.1$ ll
bash: ll: command not found
bash-5.1$ ls
barbershop_interior_cpu.blend	classroom_gpu.blend
barbershop_interior_gpu.blend	cycles_benchmark_20160228.zip
blender				fishy_cat_cpu.blend
blender-4.0.0-linux-x64		fishy_cat_gpu.blend
blender-4.0.0-linux-x64.tar.xz	install.log
bmw27_cpu.blend			pavillon_barcelone_cpu.blend
bmw27_gpu.blend			pavillon_barcelone_gpu.blend
classroom_cpu.blend		pts-install.json
bash-5.1$ ./blender -noaudio --enable-autoexec -b ../bmw27_gpu.blend -o output.test -x 1 -F JPEG -f 1 -- --cycles-device HIP^C
bash-5.1$ cd blender-4.0.0-linux-x64
bash-5.1$ ls./blender -noaudio --enable-autoexec -b ../bmw27_gpu.blend -o output.test -x 1 -F JPEG -f 1 -- --cycles-device HIP^C
bash-5.1$ c./blender -noaudio --enable-autoexec -b ../bmw27_gpu.blend -o output.test -x 1 -F JPEG -f 1 -- --cycles-device HIP^C
bash-5.1$ ^C
bash-5.1$ ./blender -noaudio --enable-autoexec -b ../bmw27_gpu.blend -o output.test -x 1 -F JPEG -f 1 -- --cycles-device HIP
Blender 4.0.0 (hash 878f71061b8e built 2023-11-14 00:52:48)
Read blend: "/home/user/.phoronix-test-suite/installed-tests/pts/blender-4.0.0/bmw27_gpu.blend"
Warning: region type 4 missing in space type "Info" (id: 7) - removing region
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Light
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | taillight
Fra:1 Mem:52.17M (Peak 52.17M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | rearDiffuser
Fra:1 Mem:52.17M (Peak 52.17M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsLid
Fra:1 Mem:52.34M (Peak 52.34M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Platform
Fra:1 Mem:52.54M (Peak 52.54M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Cube
Fra:1 Mem:52.69M (Peak 52.69M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | brakeAssembly
Fra:1 Mem:52.79M (Peak 52.79M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsOutline
Fra:1 Mem:53.58M (Peak 53.58M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lowerIntake
Fra:1 Mem:54.93M (Peak 54.93M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | kidneyBars
Fra:1 Mem:55.19M (Peak 55.19M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | kidneyChrome
Fra:1 Mem:55.79M (Peak 55.79M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Interior
Fra:1 Mem:59.60M (Peak 59.60M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | trimming
Fra:1 Mem:60.34M (Peak 60.34M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsAngelEyes
Fra:1 Mem:60.28M (Peak 60.34M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsReflector
Fra:1 Mem:60.64M (Peak 60.64M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsInterior2
Fra:1 Mem:61.47M (Peak 61.47M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsBulb
Fra:1 Mem:61.74M (Peak 61.74M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsSeparator
Fra:1 Mem:64.14M (Peak 64.14M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsInterior
Fra:1 Mem:64.35M (Peak 64.35M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRubber
Fra:1 Mem:65.28M (Peak 65.28M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | SideMirror
Fra:1 Mem:81.13M (Peak 82.73M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRoundel
Fra:1 Mem:81.56M (Peak 82.73M) | Time:00:00.31 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRim
Fra:1 Mem:85.25M (Peak 89.81M) | Time:00:00.33 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Initializing
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.33 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading sidewall.jpg
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.33 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading plate.PNG
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.33 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading brake.jpg
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.44 | Mem:66.96M, Peak:66.96M | Scene, RenderLayer | Waiting for render to start
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.44 | Mem:66.96M, Peak:66.96M | Scene, RenderLayer | Loading render kernels (may take a few minutes the first time)
Compiling HIP kernel ...
hipcc -Wno-parentheses-equality -Wno-unused-value --hipcc-func-supp -O3 -ffast-math --amdgpu-target=gfx1103 -I /home/user/.phoronix-test-suite/installed-tests/pts/blender-4.0.0/blender-4.0.0-linux-x64/4.0/scripts/addons/cycles/source --genco /home/user/.phoronix-test-suite/installed-tests/pts/blender-4.0.0/blender-4.0.0-linux-x64/4.0/scripts/addons/cycles/source/kernel/device/hip/kernel.cpp -o "/headless/.cache/cycles/kernels/cycles_kernel_gfx1103_89D50F2501D1002475CDC2F1157F486E"
Warning: The --hipcc-func-supp option has been deprecated and will be removed in the future.
Warning: The --amdgpu-target option has been deprecated and will be removed in the future.  Use --offload-arch instead.
Kernel compilation finished in 39.84s.
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:40.46 | Mem:66.97M, Peak:66.97M | Scene, RenderLayer | Updating Scene
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:40.46 | Mem:66.97M, Peak:66.97M | Scene, RenderLayer | Updating Shaders
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:40.46 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Procedurals
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:40.46 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Background
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:40.46 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Camera
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:40.46 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Meshes Flags
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:40.46 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Objects
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:40.46 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Objects | Copying Transformations to device
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:40.46 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Objects | Applying Static Transformations
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:40.46 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Particle Systems
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:40.46 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Particle Systems | Copying Particles to device
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:40.46 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Meshes
Fra:1 Mem:127.54M (Peak 254.44M) | Time:00:40.47 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Mesh | Computing attributes
Fra:1 Mem:136.19M (Peak 254.44M) | Time:00:40.47 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Mesh | Copying Attributes to device
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:40.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Plane 33/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:40.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.016 6/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:40.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Plane.001 8/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:40.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.003 4/33 | Building BVH
Fra:1 Mem:136.49M (Peak 254.44M) | Time:00:40.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.001 14/33 | Building BVH
Fra:1 Mem:136.70M (Peak 254.44M) | Time:00:40.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Building BVH
Fra:1 Mem:136.70M (Peak 254.44M) | Time:00:40.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.012 1/33 | Building BVH
Fra:1 Mem:152.51M (Peak 254.44M) | Time:00:40.48 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.012 1/33 | Packing BVH triangles and strands
Fra:1 Mem:152.51M (Peak 254.44M) | Time:00:40.48 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.012 1/33 | Packing BVH nodes
Fra:1 Mem:152.66M (Peak 254.44M) | Time:00:40.48 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Building BVH
Fra:1 Mem:160.98M (Peak 254.44M) | Time:00:40.49 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:160.99M (Peak 254.44M) | Time:00:40.49 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:162.08M (Peak 254.44M) | Time:00:40.51 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:162.09M (Peak 254.44M) | Time:00:40.51 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:164.81M (Peak 254.44M) | Time:00:40.54 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:164.82M (Peak 254.44M) | Time:00:40.54 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:164.82M (Peak 254.44M) | Time:00:40.55 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:164.83M (Peak 254.44M) | Time:00:40.55 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:172.93M (Peak 254.44M) | Time:00:40.67 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Building BVH
Fra:1 Mem:173.50M (Peak 254.44M) | Time:00:40.68 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Building BVH
Fra:1 Mem:173.50M (Peak 254.44M) | Time:00:40.70 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Packing BVH triangles and strands
Fra:1 Mem:173.53M (Peak 254.44M) | Time:00:40.70 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Packing BVH nodes
Fra:1 Mem:173.22M (Peak 254.44M) | Time:00:40.70 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH
Fra:1 Mem:177.58M (Peak 254.44M) | Time:00:40.72 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 93%, duplicates 0%
Fra:1 Mem:176.81M (Peak 254.44M) | Time:00:40.72 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 84%, duplicates 0%
Fra:1 Mem:176.81M (Peak 254.44M) | Time:00:40.72 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 56%, duplicates 3%
Fra:1 Mem:176.81M (Peak 254.44M) | Time:00:40.72 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 90%, duplicates 24%
Fra:1 Mem:176.81M (Peak 254.44M) | Time:00:40.72 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 77%, duplicates 0%
Fra:1 Mem:176.82M (Peak 254.44M) | Time:00:40.72 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 62%, duplicates 2%
Fra:1 Mem:176.82M (Peak 254.44M) | Time:00:40.72 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 53%, duplicates 1%
Fra:1 Mem:176.85M (Peak 254.44M) | Time:00:40.73 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 4%, duplicates 0%
Fra:1 Mem:176.79M (Peak 254.44M) | Time:00:40.73 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 83%, duplicates 10%
Fra:1 Mem:176.90M (Peak 254.44M) | Time:00:40.73 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 0%, duplicates 1%
Fra:1 Mem:176.58M (Peak 254.44M) | Time:00:40.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:176.60M (Peak 254.44M) | Time:00:40.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:176.46M (Peak 254.44M) | Time:00:40.76 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:176.50M (Peak 254.44M) | Time:00:40.76 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:176.38M (Peak 254.44M) | Time:00:40.76 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:176.41M (Peak 254.44M) | Time:00:40.76 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:176.29M (Peak 254.44M) | Time:00:40.77 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:176.31M (Peak 254.44M) | Time:00:40.77 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:176.65M (Peak 254.44M) | Time:00:40.78 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:176.68M (Peak 254.44M) | Time:00:40.78 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:176.71M (Peak 254.44M) | Time:00:40.79 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:176.72M (Peak 254.44M) | Time:00:40.79 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:176.44M (Peak 254.44M) | Time:00:40.79 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:176.47M (Peak 254.44M) | Time:00:40.79 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:176.70M (Peak 254.44M) | Time:00:40.87 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:176.75M (Peak 254.44M) | Time:00:40.87 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:175.50M (Peak 254.44M) | Time:00:40.90 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:175.58M (Peak 254.44M) | Time:00:40.90 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:174.19M (Peak 254.44M) | Time:00:40.91 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:174.23M (Peak 254.44M) | Time:00:40.91 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:174.51M (Peak 254.44M) | Time:00:40.92 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Building BVH
Fra:1 Mem:174.48M (Peak 254.44M) | Time:00:40.92 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH triangles and strands
Fra:1 Mem:174.53M (Peak 254.44M) | Time:00:40.92 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH nodes
Fra:1 Mem:174.67M (Peak 254.44M) | Time:00:40.98 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Building BVH 18%, duplicates 0%
Fra:1 Mem:175.14M (Peak 254.44M) | Time:00:40.98 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Building BVH 67%, duplicates 8%
Fra:1 Mem:174.39M (Peak 254.44M) | Time:00:41.00 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.004 21/33 | Building BVH
Fra:1 Mem:175.28M (Peak 254.44M) | Time:00:41.01 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.015 22/33 | Building BVH
Fra:1 Mem:176.03M (Peak 254.44M) | Time:00:41.01 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Building BVH
Fra:1 Mem:179.54M (Peak 254.44M) | Time:00:41.01 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Building BVH
Fra:1 Mem:179.45M (Peak 254.44M) | Time:00:41.01 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Building BVH
Fra:1 Mem:179.47M (Peak 254.44M) | Time:00:41.01 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.045 26/33 | Building BVH
Fra:1 Mem:182.52M (Peak 254.44M) | Time:00:41.03 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.045 26/33 | Packing BVH triangles and strands
Fra:1 Mem:182.53M (Peak 254.44M) | Time:00:41.03 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.045 26/33 | Packing BVH nodes
Fra:1 Mem:182.63M (Peak 254.44M) | Time:00:41.03 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Building BVH
Fra:1 Mem:182.48M (Peak 254.44M) | Time:00:41.03 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Building BVH
Fra:1 Mem:182.90M (Peak 254.44M) | Time:00:41.03 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Packing BVH triangles and strands
Fra:1 Mem:182.77M (Peak 254.44M) | Time:00:41.03 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Packing BVH nodes
Fra:1 Mem:182.76M (Peak 254.44M) | Time:00:41.03 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Building BVH
Fra:1 Mem:184.60M (Peak 254.44M) | Time:00:41.05 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH triangles and strands
Fra:1 Mem:184.60M (Peak 254.44M) | Time:00:41.05 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH nodes
Fra:1 Mem:184.69M (Peak 254.44M) | Time:00:41.05 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH triangles and strands
Fra:1 Mem:184.69M (Peak 254.44M) | Time:00:41.05 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH nodes
Fra:1 Mem:185.75M (Peak 254.44M) | Time:00:41.08 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cylinder 30/33 | Building BVH
Fra:1 Mem:185.96M (Peak 254.44M) | Time:00:41.16 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cylinder 30/33 | Packing BVH triangles and strands
Fra:1 Mem:185.98M (Peak 254.44M) | Time:00:41.16 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cylinder 30/33 | Packing BVH nodes
Fra:1 Mem:186.05M (Peak 254.44M) | Time:00:41.20 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.030 31/33 | Building BVH
Fra:1 Mem:191.65M (Peak 254.44M) | Time:00:41.23 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.030 31/33 | Packing BVH triangles and strands
Fra:1 Mem:191.69M (Peak 254.44M) | Time:00:41.23 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.030 31/33 | Building BVH 30%, duplicates 1%
Fra:1 Mem:191.68M (Peak 254.44M) | Time:00:41.23 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.030 31/33 | Packing BVH nodes
Fra:1 Mem:190.69M (Peak 254.44M) | Time:00:41.23 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.030 31/33 | Packing BVH triangles and strands
Fra:1 Mem:190.76M (Peak 254.44M) | Time:00:41.23 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.030 31/33 | Packing BVH nodes
Fra:1 Mem:190.89M (Peak 254.44M) | Time:00:41.23 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH
Fra:1 Mem:191.51M (Peak 254.44M) | Time:00:41.23 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 99%, duplicates 10%
Fra:1 Mem:192.27M (Peak 254.44M) | Time:00:41.24 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:192.29M (Peak 254.44M) | Time:00:41.24 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:191.27M (Peak 254.44M) | Time:00:41.24 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:191.37M (Peak 254.44M) | Time:00:41.24 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:191.93M (Peak 254.44M) | Time:00:41.26 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 28%, duplicates 3%
Fra:1 Mem:192.24M (Peak 254.44M) | Time:00:41.26 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 60%, duplicates 14%
Fra:1 Mem:190.82M (Peak 254.44M) | Time:00:41.26 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:190.91M (Peak 254.44M) | Time:00:41.26 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:195.85M (Peak 254.44M) | Time:00:41.45 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:195.94M (Peak 254.44M) | Time:00:41.45 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:196.41M (Peak 254.44M) | Time:00:41.45 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 29%, duplicates 1%
Fra:1 Mem:195.15M (Peak 254.44M) | Time:00:41.48 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 70%, duplicates 2%
Fra:1 Mem:194.98M (Peak 254.44M) | Time:00:41.48 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 100%, duplicates 35%
Fra:1 Mem:191.28M (Peak 254.44M) | Time:00:41.51 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:191.44M (Peak 254.44M) | Time:00:41.51 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:190.30M (Peak 254.44M) | Time:00:41.55 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:190.34M (Peak 254.44M) | Time:00:41.55 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:182.81M (Peak 254.44M) | Time:00:41.65 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:183.03M (Peak 254.44M) | Time:00:41.65 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:181.38M (Peak 254.44M) | Time:00:41.70 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 100%, duplicates 2%
Fra:1 Mem:174.52M (Peak 254.44M) | Time:00:41.70 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:174.79M (Peak 254.44M) | Time:00:41.70 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:161.24M (Peak 254.44M) | Time:00:41.72 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:161.66M (Peak 254.44M) | Time:00:41.72 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:155.14M (Peak 254.44M) | Time:00:41.73 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Building
Fra:1 Mem:155.14M (Peak 254.44M) | Time:00:41.73 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Building BVH
Fra:1 Mem:155.15M (Peak 254.44M) | Time:00:41.73 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Packing BVH triangles and strands
Fra:1 Mem:155.15M (Peak 254.44M) | Time:00:41.73 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Packing BVH nodes
Fra:1 Mem:193.07M (Peak 254.44M) | Time:00:41.76 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Copying BVH to device
Fra:1 Mem:193.07M (Peak 254.44M) | Time:00:41.76 | Mem:94.61M, Peak:94.61M | Scene, RenderLayer | Updating Mesh | Computing normals
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:41.77 | Mem:94.61M, Peak:94.61M | Scene, RenderLayer | Updating Mesh | Copying Mesh to device
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:41.77 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Objects Flags
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:41.77 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Primitive Offsets
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:41.77 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Images
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:41.77 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Camera Volume
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:41.77 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Lookup Tables
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:41.77 | Mem:110.65M, Peak:110.65M | Scene, RenderLayer | Updating Lights
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:41.77 | Mem:110.65M, Peak:110.65M | Scene, RenderLayer | Updating Lights | Computing distribution
Fra:1 Mem:209.42M (Peak 254.44M) | Time:00:41.77 | Mem:111.04M, Peak:111.04M | Scene, RenderLayer | Updating Integrator
Fra:1 Mem:217.42M (Peak 254.44M) | Time:00:41.78 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Film
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:41.78 | Mem:118.96M, Peak:119.04M | Scene, RenderLayer | Updating Lookup Tables
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:41.78 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Baking
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:41.78 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Device | Writing constant memory
Fra:1 Mem:218.18M (Peak 254.44M) | Time:00:41.78 | Mem:180.54M, Peak:180.54M | Scene, RenderLayer | Sample 0/1225
Memory access fault by GPU node-1 (Agent handle: 0x7fed7011a000) on address 0x7fed4db0d000. Reason: Page not present or supervisor privilege.
Aborted (core dumped)
bash-5.1$ ./blender -noaudio --enable-autoexec -b ../bmw27_gpu.blend -o output.test -x 1 -F JPEG -f 1 -- --cycles-device HIP
Blender 4.0.0 (hash 878f71061b8e built 2023-11-14 00:52:48)
Read blend: "/home/user/.phoronix-test-suite/installed-tests/pts/blender-4.0.0/bmw27_gpu.blend"
Warning: region type 4 missing in space type "Info" (id: 7) - removing region
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Light
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | carShell
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | taillight
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Window
Fra:1 Mem:52.17M (Peak 52.17M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsLid
Fra:1 Mem:52.34M (Peak 52.34M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Platform
Fra:1 Mem:52.58M (Peak 52.58M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | LowerIntake
Fra:1 Mem:52.67M (Peak 52.67M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lowerIntake
Fra:1 Mem:53.15M (Peak 53.15M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Cube
Fra:1 Mem:53.28M (Peak 53.28M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | brakeAssembly
Fra:1 Mem:58.34M (Peak 58.34M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | kidneyChrome
Fra:1 Mem:58.61M (Peak 58.61M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | trimming
Fra:1 Mem:59.46M (Peak 59.46M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireBolts
Fra:1 Mem:59.76M (Peak 59.76M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRubber
Fra:1 Mem:60.65M (Peak 60.65M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsAngelEyes
Fra:1 Mem:60.92M (Peak 60.92M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsInterior2
Fra:1 Mem:62.56M (Peak 62.56M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsBulb
Fra:1 Mem:62.81M (Peak 62.81M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsSeparator
Fra:1 Mem:63.59M (Peak 63.59M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsInterior
Fra:1 Mem:64.39M (Peak 64.39M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | SideMirror
Fra:1 Mem:81.13M (Peak 82.73M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRoundel
Fra:1 Mem:81.56M (Peak 82.73M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRim
Fra:1 Mem:85.25M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Initializing
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading sidewall.jpg
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading plate.PNG
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading brake.jpg
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.39 | Mem:66.96M, Peak:66.96M | Scene, RenderLayer | Waiting for render to start
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.39 | Mem:66.96M, Peak:66.96M | Scene, RenderLayer | Loading render kernels (may take a few minutes the first time)
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.41 | Mem:66.97M, Peak:66.97M | Scene, RenderLayer | Updating Scene
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.41 | Mem:66.97M, Peak:66.97M | Scene, RenderLayer | Updating Shaders
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Procedurals
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Background
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Camera
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Meshes Flags
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Objects
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Objects | Copying Transformations to device
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.41 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Objects | Applying Static Transformations
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.41 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Particle Systems
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.41 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Particle Systems | Copying Particles to device
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.41 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Meshes
Fra:1 Mem:127.54M (Peak 254.44M) | Time:00:00.42 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Mesh | Computing attributes
Fra:1 Mem:136.19M (Peak 254.44M) | Time:00:00.42 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Mesh | Copying Attributes to device
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.004 2/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.010 11/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cylinder.001 9/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.002 5/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Building BVH
Fra:1 Mem:152.35M (Peak 254.44M) | Time:00:00.43 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Packing BVH triangles and strands
Fra:1 Mem:152.35M (Peak 254.44M) | Time:00:00.43 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Packing BVH nodes
Fra:1 Mem:158.85M (Peak 254.44M) | Time:00:00.43 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Packing BVH triangles and strands
Fra:1 Mem:158.85M (Peak 254.44M) | Time:00:00.43 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Packing BVH nodes
Fra:1 Mem:160.80M (Peak 254.44M) | Time:00:00.45 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Packing BVH triangles and strands
Fra:1 Mem:160.80M (Peak 254.44M) | Time:00:00.45 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Packing BVH nodes
Fra:1 Mem:163.65M (Peak 254.44M) | Time:00:00.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Packing BVH triangles and strands
Fra:1 Mem:163.65M (Peak 254.44M) | Time:00:00.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Packing BVH nodes
Fra:1 Mem:163.78M (Peak 254.44M) | Time:00:00.48 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Packing BVH triangles and strands
Fra:1 Mem:163.78M (Peak 254.44M) | Time:00:00.48 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Packing BVH nodes
Fra:1 Mem:173.99M (Peak 254.44M) | Time:00:00.52 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Building BVH
Fra:1 Mem:173.95M (Peak 254.44M) | Time:00:00.52 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:173.97M (Peak 254.44M) | Time:00:00.52 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:179.25M (Peak 254.44M) | Time:00:00.54 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Building BVH
Fra:1 Mem:175.77M (Peak 254.44M) | Time:00:00.57 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Packing BVH triangles and strands
Fra:1 Mem:175.79M (Peak 254.44M) | Time:00:00.57 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Packing BVH nodes
Fra:1 Mem:176.02M (Peak 254.44M) | Time:00:00.61 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Packing BVH triangles and strands
Fra:1 Mem:176.04M (Peak 254.44M) | Time:00:00.61 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Packing BVH nodes
Fra:1 Mem:175.69M (Peak 254.44M) | Time:00:00.63 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Building BVH
Fra:1 Mem:175.71M (Peak 254.44M) | Time:00:00.63 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH
Fra:1 Mem:177.05M (Peak 254.44M) | Time:00:00.64 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:177.10M (Peak 254.44M) | Time:00:00.64 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:176.33M (Peak 254.44M) | Time:00:00.64 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:176.35M (Peak 254.44M) | Time:00:00.64 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:176.30M (Peak 254.44M) | Time:00:00.64 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Building BVH
Fra:1 Mem:177.92M (Peak 254.44M) | Time:00:00.66 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH triangles and strands
Fra:1 Mem:177.95M (Peak 254.44M) | Time:00:00.67 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH nodes
Fra:1 Mem:177.57M (Peak 254.44M) | Time:00:00.67 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH triangles and strands
Fra:1 Mem:177.61M (Peak 254.44M) | Time:00:00.67 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH nodes
Fra:1 Mem:177.45M (Peak 254.44M) | Time:00:00.67 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Building BVH 93%, duplicates 2%
Fra:1 Mem:177.99M (Peak 254.44M) | Time:00:00.68 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Building BVH 9%, duplicates 0%
Fra:1 Mem:178.13M (Peak 254.44M) | Time:00:00.68 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Building BVH 20%, duplicates 4%
Fra:1 Mem:176.66M (Peak 254.44M) | Time:00:00.69 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH triangles and strands
Fra:1 Mem:176.71M (Peak 254.44M) | Time:00:00.69 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH nodes
Fra:1 Mem:176.25M (Peak 254.44M) | Time:00:00.70 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH triangles and strands
Fra:1 Mem:176.32M (Peak 254.44M) | Time:00:00.70 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH nodes
Fra:1 Mem:174.82M (Peak 254.44M) | Time:00:00.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH triangles and strands
Fra:1 Mem:174.83M (Peak 254.44M) | Time:00:00.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH nodes
Fra:1 Mem:174.54M (Peak 254.44M) | Time:00:00.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH triangles and strands
Fra:1 Mem:174.56M (Peak 254.44M) | Time:00:00.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH nodes
Fra:1 Mem:174.18M (Peak 254.44M) | Time:00:00.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH triangles and strands
Fra:1 Mem:174.22M (Peak 254.44M) | Time:00:00.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH nodes
Fra:1 Mem:174.10M (Peak 254.44M) | Time:00:00.76 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.004 21/33 | Building BVH
Fra:1 Mem:174.95M (Peak 254.44M) | Time:00:00.76 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.015 22/33 | Building BVH
Fra:1 Mem:175.95M (Peak 254.44M) | Time:00:00.78 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Building BVH
Fra:1 Mem:180.60M (Peak 254.44M) | Time:00:00.80 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Building BVH
Fra:1 Mem:182.34M (Peak 254.44M) | Time:00:00.81 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Packing BVH triangles and strands
Fra:1 Mem:182.96M (Peak 254.44M) | Time:00:00.81 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Packing BVH nodes
Fra:1 Mem:183.88M (Peak 254.44M) | Time:00:00.85 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Building BVH
Fra:1 Mem:184.05M (Peak 254.44M) | Time:00:00.88 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Building BVH 99%, duplicates 4%
Fra:1 Mem:183.22M (Peak 254.44M) | Time:00:00.88 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Packing BVH triangles and strands
Fra:1 Mem:183.26M (Peak 254.44M) | Time:00:00.88 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Packing BVH nodes
Fra:1 Mem:183.59M (Peak 254.44M) | Time:00:00.93 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Building BVH 26%, duplicates 1%
Fra:1 Mem:183.93M (Peak 254.44M) | Time:00:00.93 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Building BVH 88%, duplicates 10%
Fra:1 Mem:182.55M (Peak 254.44M) | Time:00:00.94 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Packing BVH triangles and strands
Fra:1 Mem:182.60M (Peak 254.44M) | Time:00:00.94 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Packing BVH nodes
Fra:1 Mem:181.83M (Peak 254.44M) | Time:00:00.95 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.045 26/33 | Building BVH
Fra:1 Mem:184.14M (Peak 254.44M) | Time:00:00.97 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.045 26/33 | Packing BVH triangles and strands
Fra:1 Mem:184.15M (Peak 254.44M) | Time:00:00.97 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.045 26/33 | Packing BVH nodes
Fra:1 Mem:183.10M (Peak 254.44M) | Time:00:00.99 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Building BVH
Fra:1 Mem:182.68M (Peak 254.44M) | Time:00:01.00 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Building BVH
Fra:1 Mem:182.80M (Peak 254.44M) | Time:00:01.00 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Packing BVH triangles and strands
Fra:1 Mem:182.80M (Peak 254.44M) | Time:00:01.00 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Packing BVH nodes
Fra:1 Mem:182.77M (Peak 254.44M) | Time:00:01.00 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Building BVH
Fra:1 Mem:182.79M (Peak 254.44M) | Time:00:01.00 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH triangles and strands
Fra:1 Mem:182.79M (Peak 254.44M) | Time:00:01.00 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH nodes
Fra:1 Mem:182.79M (Peak 254.44M) | Time:00:01.00 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cylinder 30/33 | Building BVH
Fra:1 Mem:183.49M (Peak 254.44M) | Time:00:01.01 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.030 31/33 | Building BVH
Fra:1 Mem:186.02M (Peak 254.44M) | Time:00:01.01 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.030 31/33 | Packing BVH triangles and strands
Fra:1 Mem:186.02M (Peak 254.44M) | Time:00:01.01 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.030 31/33 | Packing BVH nodes
Fra:1 Mem:186.00M (Peak 254.44M) | Time:00:01.01 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH
Fra:1 Mem:189.39M (Peak 254.44M) | Time:00:01.01 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 96%, duplicates 7%
Fra:1 Mem:190.15M (Peak 254.44M) | Time:00:01.03 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 89%, duplicates 17%
Fra:1 Mem:188.51M (Peak 254.44M) | Time:00:01.05 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:188.60M (Peak 254.44M) | Time:00:01.05 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:194.24M (Peak 254.44M) | Time:00:01.08 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:194.32M (Peak 254.44M) | Time:00:01.08 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:195.31M (Peak 254.44M) | Time:00:01.09 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:195.33M (Peak 254.44M) | Time:00:01.09 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:187.15M (Peak 254.44M) | Time:00:01.09 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:187.57M (Peak 254.44M) | Time:00:01.09 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:180.65M (Peak 254.44M) | Time:00:01.12 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:180.74M (Peak 254.44M) | Time:00:01.12 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:179.67M (Peak 254.44M) | Time:00:01.18 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 88%, duplicates 2%
Fra:1 Mem:178.70M (Peak 254.44M) | Time:00:01.22 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:178.74M (Peak 254.44M) | Time:00:01.22 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:178.43M (Peak 254.44M) | Time:00:01.26 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 70%, duplicates 1%
Fra:1 Mem:170.48M (Peak 254.44M) | Time:00:01.32 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:170.69M (Peak 254.44M) | Time:00:01.32 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:163.18M (Peak 254.44M) | Time:00:01.33 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:163.46M (Peak 254.44M) | Time:00:01.33 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:155.65M (Peak 254.44M) | Time:00:01.33 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:155.85M (Peak 254.44M) | Time:00:01.33 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:155.14M (Peak 254.44M) | Time:00:01.33 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Building
Fra:1 Mem:155.14M (Peak 254.44M) | Time:00:01.33 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Building BVH
Fra:1 Mem:155.15M (Peak 254.44M) | Time:00:01.33 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Packing BVH triangles and strands
Fra:1 Mem:155.15M (Peak 254.44M) | Time:00:01.33 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Packing BVH nodes
Fra:1 Mem:193.08M (Peak 254.44M) | Time:00:01.34 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Copying BVH to device
Fra:1 Mem:193.08M (Peak 254.44M) | Time:00:01.35 | Mem:94.61M, Peak:94.61M | Scene, RenderLayer | Updating Mesh | Computing normals
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.35 | Mem:94.61M, Peak:94.61M | Scene, RenderLayer | Updating Mesh | Copying Mesh to device
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.36 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Objects Flags
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.36 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Primitive Offsets
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.36 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Images
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.36 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Camera Volume
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.36 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Lookup Tables
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.36 | Mem:110.65M, Peak:110.65M | Scene, RenderLayer | Updating Lights
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.36 | Mem:110.65M, Peak:110.65M | Scene, RenderLayer | Updating Lights | Computing distribution
Fra:1 Mem:209.42M (Peak 254.44M) | Time:00:01.36 | Mem:111.04M, Peak:111.04M | Scene, RenderLayer | Updating Integrator
Fra:1 Mem:217.42M (Peak 254.44M) | Time:00:01.36 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Film
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:01.36 | Mem:118.96M, Peak:119.04M | Scene, RenderLayer | Updating Lookup Tables
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:01.36 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Baking
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:01.36 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Device | Writing constant memory
Fra:1 Mem:218.18M (Peak 254.44M) | Time:00:01.36 | Mem:180.54M, Peak:180.54M | Scene, RenderLayer | Sample 0/1225
Fra:1 Mem:230.05M (Peak 254.44M) | Time:00:01.47 | Remaining:02:20.20 | Mem:192.41M, Peak:192.41M | Scene, RenderLayer | Sample 1/1225
Fra:1 Mem:230.06M (Peak 254.44M) | Time:00:23.31 | Remaining:01:22.67 | Mem:192.42M, Peak:192.42M | Scene, RenderLayer | Sample 257/1225
Memory access fault by GPU node-1 (Agent handle: 0x7fbd50689000) on address 0x1df000. Reason: Page not present or supervisor privilege.
Aborted (core dumped)
bash-5.1$ ./blender -noaudio --enable-autoexec -b ../bmw27_gpu.blend -o output.test -x 1 -F JPEG -f 1 -- --cycles-device HIP
Blender 4.0.0 (hash 878f71061b8e built 2023-11-14 00:52:48)
Read blend: "/home/user/.phoronix-test-suite/installed-tests/pts/blender-4.0.0/bmw27_gpu.blend"
Warning: region type 4 missing in space type "Info" (id: 7) - removing region
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Light
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Floor
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | MStreak
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsLid
Fra:1 Mem:52.18M (Peak 52.18M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsGlass
Fra:1 Mem:52.63M (Peak 52.63M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | LowerIntake
Fra:1 Mem:52.74M (Peak 52.74M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lowerIntake
Fra:1 Mem:52.98M (Peak 52.98M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Cube
Fra:1 Mem:57.14M (Peak 57.14M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | kidneyBars
Fra:1 Mem:57.27M (Peak 57.27M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | brakeAssembly
Fra:1 Mem:59.66M (Peak 59.66M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | kidneyChrome
Fra:1 Mem:59.69M (Peak 59.69M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | trimming
Fra:1 Mem:59.72M (Peak 59.72M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsAngelEyes
Fra:1 Mem:63.02M (Peak 63.02M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsReflector
Fra:1 Mem:63.49M (Peak 63.49M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsBulb
Fra:1 Mem:64.02M (Peak 64.02M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsInterior
Fra:1 Mem:64.22M (Peak 64.22M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | SideMirror
Fra:1 Mem:64.34M (Peak 64.34M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireBolts
Fra:1 Mem:66.68M (Peak 66.68M) | Time:00:00.23 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRubber
Fra:1 Mem:81.13M (Peak 82.73M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRoundel
Fra:1 Mem:81.56M (Peak 82.73M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRim
Fra:1 Mem:85.25M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Initializing
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading sidewall.jpg
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading plate.PNG
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading brake.jpg
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.38 | Mem:66.96M, Peak:66.96M | Scene, RenderLayer | Waiting for render to start
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.38 | Mem:66.96M, Peak:66.96M | Scene, RenderLayer | Loading render kernels (may take a few minutes the first time)
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.40 | Mem:66.97M, Peak:66.97M | Scene, RenderLayer | Updating Scene
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.40 | Mem:66.97M, Peak:66.97M | Scene, RenderLayer | Updating Shaders
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.40 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Procedurals
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.40 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Background
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.40 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Camera
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.40 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Meshes Flags
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.40 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Objects
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.40 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Objects | Copying Transformations to device
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.40 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Objects | Applying Static Transformations
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.40 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Particle Systems
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.40 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Particle Systems | Copying Particles to device
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.40 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Meshes
Fra:1 Mem:127.54M (Peak 254.44M) | Time:00:00.40 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Mesh | Computing attributes
Fra:1 Mem:136.19M (Peak 254.44M) | Time:00:00.41 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Mesh | Copying Attributes to device
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Plane 33/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.016 6/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.008 13/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.013 7/33 | Building BVH
Fra:1 Mem:136.27M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.001 14/33 | Building BVH
Fra:1 Mem:136.72M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Building BVH
Fra:1 Mem:136.72M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.012 1/33 | Building BVH
Fra:1 Mem:151.82M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.012 1/33 | Packing BVH triangles and strands
Fra:1 Mem:151.82M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.012 1/33 | Packing BVH nodes
Fra:1 Mem:151.81M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Building BVH
Fra:1 Mem:159.31M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:159.31M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:161.53M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:161.53M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:164.58M (Peak 254.44M) | Time:00:00.46 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:164.58M (Peak 254.44M) | Time:00:00.46 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:173.74M (Peak 254.44M) | Time:00:00.50 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:173.75M (Peak 254.44M) | Time:00:00.50 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:173.44M (Peak 254.44M) | Time:00:00.50 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:173.47M (Peak 254.44M) | Time:00:00.50 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:173.45M (Peak 254.44M) | Time:00:00.55 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Building BVH
Fra:1 Mem:174.63M (Peak 254.44M) | Time:00:00.56 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Packing BVH triangles and strands
Fra:1 Mem:174.67M (Peak 254.44M) | Time:00:00.56 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Packing BVH nodes
Fra:1 Mem:175.04M (Peak 254.44M) | Time:00:00.57 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Packing BVH triangles and strands
Fra:1 Mem:175.07M (Peak 254.44M) | Time:00:00.57 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Packing BVH nodes
Fra:1 Mem:175.33M (Peak 254.44M) | Time:00:00.59 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Building BVH
Fra:1 Mem:175.55M (Peak 254.44M) | Time:00:00.61 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Packing BVH triangles and strands
Fra:1 Mem:175.57M (Peak 254.44M) | Time:00:00.61 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Packing BVH nodes
Fra:1 Mem:176.10M (Peak 254.44M) | Time:00:00.64 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Packing BVH triangles and strands
Fra:1 Mem:176.11M (Peak 254.44M) | Time:00:00.64 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Packing BVH nodes
Fra:1 Mem:175.41M (Peak 254.44M) | Time:00:00.66 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Packing BVH triangles and strands
Fra:1 Mem:175.42M (Peak 254.44M) | Time:00:00.66 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Packing BVH nodes
Fra:1 Mem:175.25M (Peak 254.44M) | Time:00:00.66 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH
Fra:1 Mem:175.98M (Peak 254.44M) | Time:00:00.66 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 95%, duplicates 2%
Fra:1 Mem:176.25M (Peak 254.44M) | Time:00:00.66 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 10%, duplicates 0%
Fra:1 Mem:176.66M (Peak 254.44M) | Time:00:00.66 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH 17%, duplicates 4%
Fra:1 Mem:177.03M (Peak 254.44M) | Time:00:00.68 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:177.00M (Peak 254.44M) | Time:00:00.68 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:176.81M (Peak 254.44M) | Time:00:00.68 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:176.82M (Peak 254.44M) | Time:00:00.68 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:177.03M (Peak 254.44M) | Time:00:00.69 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:177.06M (Peak 254.44M) | Time:00:00.69 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:175.60M (Peak 254.44M) | Time:00:00.69 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH triangles and strands
Fra:1 Mem:175.66M (Peak 254.44M) | Time:00:00.69 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Packing BVH nodes
Fra:1 Mem:174.64M (Peak 254.44M) | Time:00:00.73 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Building BVH
Fra:1 Mem:174.84M (Peak 254.44M) | Time:00:00.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH triangles and strands
Fra:1 Mem:174.82M (Peak 254.44M) | Time:00:00.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH nodes
Fra:1 Mem:174.22M (Peak 254.44M) | Time:00:00.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH triangles and strands
Fra:1 Mem:174.26M (Peak 254.44M) | Time:00:00.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Packing BVH nodes
Fra:1 Mem:173.77M (Peak 254.44M) | Time:00:00.74 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.004 21/33 | Building BVH
Fra:1 Mem:174.98M (Peak 254.44M) | Time:00:00.79 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.015 22/33 | Building BVH
Fra:1 Mem:177.29M (Peak 254.44M) | Time:00:00.82 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Building BVH
Fra:1 Mem:181.09M (Peak 254.44M) | Time:00:00.83 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Building BVH
Fra:1 Mem:181.00M (Peak 254.44M) | Time:00:00.83 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Building BVH
Fra:1 Mem:181.31M (Peak 254.44M) | Time:00:00.84 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Packing BVH triangles and strands
Fra:1 Mem:181.31M (Peak 254.44M) | Time:00:00.84 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Packing BVH nodes
Fra:1 Mem:181.30M (Peak 254.44M) | Time:00:00.84 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.045 26/33 | Building BVH
Fra:1 Mem:182.84M (Peak 254.44M) | Time:00:00.86 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Building BVH
Fra:1 Mem:183.00M (Peak 254.44M) | Time:00:00.87 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Building BVH
Fra:1 Mem:183.03M (Peak 254.44M) | Time:00:00.87 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Packing BVH triangles and strands
Fra:1 Mem:183.03M (Peak 254.44M) | Time:00:00.87 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Packing BVH nodes
Fra:1 Mem:183.02M (Peak 254.44M) | Time:00:00.87 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Building BVH
Fra:1 Mem:182.63M (Peak 254.44M) | Time:00:00.87 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH triangles and strands
Fra:1 Mem:182.63M (Peak 254.44M) | Time:00:00.87 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH nodes
Fra:1 Mem:182.88M (Peak 254.44M) | Time:00:00.88 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH triangles and strands
Fra:1 Mem:182.88M (Peak 254.44M) | Time:00:00.88 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH nodes
Fra:1 Mem:183.15M (Peak 254.44M) | Time:00:00.91 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Building BVH 85%, duplicates 4%
Fra:1 Mem:183.17M (Peak 254.44M) | Time:00:00.91 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Building BVH 27%, duplicates 1%
Fra:1 Mem:182.79M (Peak 254.44M) | Time:00:00.91 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cylinder 30/33 | Building BVH
Fra:1 Mem:182.85M (Peak 254.44M) | Time:00:00.92 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.030 31/33 | Building BVH
Fra:1 Mem:188.98M (Peak 254.44M) | Time:00:00.93 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH
Fra:1 Mem:188.04M (Peak 254.44M) | Time:00:00.98 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:188.46M (Peak 254.44M) | Time:00:00.98 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:190.43M (Peak 254.44M) | Time:00:00.98 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:190.44M (Peak 254.44M) | Time:00:00.99 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:189.82M (Peak 254.44M) | Time:00:00.99 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:189.88M (Peak 254.44M) | Time:00:00.99 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:181.94M (Peak 254.44M) | Time:00:01.00 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:181.96M (Peak 254.44M) | Time:00:01.00 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:181.13M (Peak 254.44M) | Time:00:01.02 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:181.22M (Peak 254.44M) | Time:00:01.02 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:180.93M (Peak 254.44M) | Time:00:01.02 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:181.01M (Peak 254.44M) | Time:00:01.02 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:183.16M (Peak 254.44M) | Time:00:01.07 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 1%, duplicates 1%
Fra:1 Mem:183.00M (Peak 254.44M) | Time:00:01.09 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:183.01M (Peak 254.44M) | Time:00:01.09 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:181.89M (Peak 254.44M) | Time:00:01.09 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:181.95M (Peak 254.44M) | Time:00:01.09 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:183.14M (Peak 254.44M) | Time:00:01.16 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 81%, duplicates 2%
Fra:1 Mem:182.44M (Peak 254.44M) | Time:00:01.17 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 50%, duplicates 1%
Fra:1 Mem:172.52M (Peak 254.44M) | Time:00:01.32 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:172.71M (Peak 254.44M) | Time:00:01.32 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:162.22M (Peak 254.44M) | Time:00:01.34 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:162.43M (Peak 254.44M) | Time:00:01.34 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:162.43M (Peak 254.44M) | Time:00:01.34 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:162.70M (Peak 254.44M) | Time:00:01.34 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:155.50M (Peak 254.44M) | Time:00:01.34 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:155.58M (Peak 254.44M) | Time:00:01.34 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:155.14M (Peak 254.44M) | Time:00:01.34 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Building
Fra:1 Mem:155.14M (Peak 254.44M) | Time:00:01.34 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Building BVH
Fra:1 Mem:155.15M (Peak 254.44M) | Time:00:01.34 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Packing BVH triangles and strands
Fra:1 Mem:155.15M (Peak 254.44M) | Time:00:01.34 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Packing BVH nodes
Fra:1 Mem:193.07M (Peak 254.44M) | Time:00:01.36 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Copying BVH to device
Fra:1 Mem:193.07M (Peak 254.44M) | Time:00:01.36 | Mem:94.61M, Peak:94.61M | Scene, RenderLayer | Updating Mesh | Computing normals
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.37 | Mem:94.61M, Peak:94.61M | Scene, RenderLayer | Updating Mesh | Copying Mesh to device
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.37 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Objects Flags
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.37 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Primitive Offsets
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.37 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Images
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.37 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Camera Volume
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.37 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Lookup Tables
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.37 | Mem:110.65M, Peak:110.65M | Scene, RenderLayer | Updating Lights
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.37 | Mem:110.65M, Peak:110.65M | Scene, RenderLayer | Updating Lights | Computing distribution
Fra:1 Mem:209.42M (Peak 254.44M) | Time:00:01.37 | Mem:111.04M, Peak:111.04M | Scene, RenderLayer | Updating Integrator
Fra:1 Mem:217.42M (Peak 254.44M) | Time:00:01.37 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Film
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:01.37 | Mem:118.96M, Peak:119.04M | Scene, RenderLayer | Updating Lookup Tables
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:01.37 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Baking
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:01.37 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Device | Writing constant memory
Fra:1 Mem:218.18M (Peak 254.44M) | Time:00:01.37 | Mem:180.54M, Peak:180.54M | Scene, RenderLayer | Sample 0/1225
Memory access fault by GPU node-1 (Agent handle: 0x7fb409f79000) on address 0x7fb1a7195000. Reason: Page not present or supervisor privilege.
Aborted (core dumped)
bash-5.1$ ./blender -noaudio --enable-autoexec -b ../bmw27_gpu.blend -o output.test -x 1 -F JPEG -f 1 -- --cycles-device HIP
Blender 4.0.0 (hash 878f71061b8e built 2023-11-14 00:52:48)
Read blend: "/home/user/.phoronix-test-suite/installed-tests/pts/blender-4.0.0/bmw27_gpu.blend"
Warning: region type 4 missing in space type "Info" (id: 7) - removing region
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Light
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | plate
Fra:1 Mem:52.09M (Peak 52.09M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | MStreak
Fra:1 Mem:52.10M (Peak 52.10M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | exhaust
Fra:1 Mem:52.17M (Peak 52.17M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsGlass
Fra:1 Mem:52.40M (Peak 52.40M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | LowerIntake
Fra:1 Mem:53.82M (Peak 53.82M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Cube
Fra:1 Mem:53.99M (Peak 53.99M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsOutline
Fra:1 Mem:58.26M (Peak 58.26M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lowerIntake
Fra:1 Mem:58.61M (Peak 58.61M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | kidneyBars
Fra:1 Mem:60.60M (Peak 60.60M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | kidneyChrome
Fra:1 Mem:61.07M (Peak 61.07M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | Interior
Fra:1 Mem:61.55M (Peak 61.55M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | trimming
Fra:1 Mem:61.49M (Peak 61.55M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsAngelEyes
Fra:1 Mem:62.55M (Peak 62.55M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsReflector
Fra:1 Mem:63.11M (Peak 63.11M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsInterior2
Fra:1 Mem:63.31M (Peak 63.31M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsBulb
Fra:1 Mem:64.14M (Peak 64.14M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireBolts
Fra:1 Mem:64.21M (Peak 64.21M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsSeparator
Fra:1 Mem:64.65M (Peak 64.65M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | lightsInterior
Fra:1 Mem:66.90M (Peak 66.90M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | SideMirror
Fra:1 Mem:68.36M (Peak 68.36M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRubber
Fra:1 Mem:81.13M (Peak 82.73M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRoundel
Fra:1 Mem:81.56M (Peak 82.73M) | Time:00:00.24 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Synchronizing object | TireRim
Fra:1 Mem:85.25M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Initializing
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading sidewall.jpg
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading plate.PNG
Fra:1 Mem:66.10M (Peak 89.81M) | Time:00:00.26 | Mem:0.00M, Peak:0.00M | Scene, RenderLayer | Updating Images | Loading brake.jpg
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.38 | Mem:66.96M, Peak:66.96M | Scene, RenderLayer | Waiting for render to start
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.38 | Mem:66.96M, Peak:66.96M | Scene, RenderLayer | Loading render kernels (may take a few minutes the first time)
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.41 | Mem:66.97M, Peak:66.97M | Scene, RenderLayer | Updating Scene
Fra:1 Mem:120.73M (Peak 254.44M) | Time:00:00.41 | Mem:66.97M, Peak:66.97M | Scene, RenderLayer | Updating Shaders
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Procedurals
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Background
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Camera
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Meshes Flags
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Objects
Fra:1 Mem:120.82M (Peak 254.44M) | Time:00:00.41 | Mem:66.98M, Peak:66.98M | Scene, RenderLayer | Updating Objects | Copying Transformations to device
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.41 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Objects | Applying Static Transformations
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.41 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Particle Systems
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.41 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Particle Systems | Copying Particles to device
Fra:1 Mem:120.84M (Peak 254.44M) | Time:00:00.41 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Meshes
Fra:1 Mem:127.54M (Peak 254.44M) | Time:00:00.41 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Mesh | Computing attributes
Fra:1 Mem:136.19M (Peak 254.44M) | Time:00:00.41 | Mem:67.00M, Peak:67.00M | Scene, RenderLayer | Updating Mesh | Copying Attributes to device
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.004 2/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.013 7/33 | Building BVH
Fra:1 Mem:136.18M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.005 15/33 | Building BVH
Fra:1 Mem:136.94M (Peak 254.44M) | Time:00:00.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.012 1/33 | Building BVH
Fra:1 Mem:152.07M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.012 1/33 | Packing BVH triangles and strands
Fra:1 Mem:152.07M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.012 1/33 | Packing BVH nodes
Fra:1 Mem:152.84M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Building BVH
Fra:1 Mem:158.91M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:158.91M (Peak 254.44M) | Time:00:00.42 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:160.66M (Peak 254.44M) | Time:00:00.43 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:160.67M (Peak 254.44M) | Time:00:00.43 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:163.72M (Peak 254.44M) | Time:00:00.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:163.73M (Peak 254.44M) | Time:00:00.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:163.59M (Peak 254.44M) | Time:00:00.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH triangles and strands
Fra:1 Mem:163.60M (Peak 254.44M) | Time:00:00.47 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.003 16/33 | Packing BVH nodes
Fra:1 Mem:174.15M (Peak 254.44M) | Time:00:00.51 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Building BVH
Fra:1 Mem:174.66M (Peak 254.44M) | Time:00:00.52 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Packing BVH triangles and strands
Fra:1 Mem:174.69M (Peak 254.44M) | Time:00:00.52 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.002 17/33 | Packing BVH nodes
Fra:1 Mem:174.54M (Peak 254.44M) | Time:00:00.52 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Building BVH
Fra:1 Mem:174.28M (Peak 254.44M) | Time:00:00.52 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Packing BVH triangles and strands
Fra:1 Mem:174.30M (Peak 254.44M) | Time:00:00.52 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.001 18/33 | Packing BVH nodes
Fra:1 Mem:174.35M (Peak 254.44M) | Time:00:00.52 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.001 19/33 | Building BVH
Fra:1 Mem:174.81M (Peak 254.44M) | Time:00:00.52 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.024 20/33 | Building BVH
Fra:1 Mem:181.29M (Peak 254.44M) | Time:00:00.52 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.004 21/33 | Building BVH
Fra:1 Mem:179.71M (Peak 254.44M) | Time:00:00.54 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.015 22/33 | Building BVH
Fra:1 Mem:181.14M (Peak 254.44M) | Time:00:00.55 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.015 22/33 | Packing BVH triangles and strands
Fra:1 Mem:181.16M (Peak 254.44M) | Time:00:00.55 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.015 22/33 | Packing BVH nodes
Fra:1 Mem:181.47M (Peak 254.44M) | Time:00:00.55 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Building BVH
Fra:1 Mem:187.93M (Peak 254.44M) | Time:00:00.61 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Packing BVH triangles and strands
Fra:1 Mem:187.98M (Peak 254.44M) | Time:00:00.61 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Packing BVH nodes
Fra:1 Mem:187.30M (Peak 254.44M) | Time:00:00.62 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Packing BVH triangles and strands
Fra:1 Mem:187.33M (Peak 254.44M) | Time:00:00.62 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Packing BVH nodes
Fra:1 Mem:187.38M (Peak 254.44M) | Time:00:00.62 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Packing BVH triangles and strands
Fra:1 Mem:187.40M (Peak 254.44M) | Time:00:00.62 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Packing BVH nodes
Fra:1 Mem:189.00M (Peak 254.44M) | Time:00:00.66 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Building BVH 35%, duplicates 0%
Fra:1 Mem:188.40M (Peak 254.44M) | Time:00:00.67 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Building BVH 10%, duplicates 0%
Fra:1 Mem:188.40M (Peak 254.44M) | Time:00:00.67 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Building BVH 13%, duplicates 2%
Fra:1 Mem:187.45M (Peak 254.44M) | Time:00:00.68 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Packing BVH triangles and strands
Fra:1 Mem:187.48M (Peak 254.44M) | Time:00:00.68 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Packing BVH nodes
Fra:1 Mem:187.68M (Peak 254.44M) | Time:00:00.68 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Building BVH 0%, duplicates 0%
Fra:1 Mem:187.33M (Peak 254.44M) | Time:00:00.70 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Packing BVH triangles and strands
Fra:1 Mem:187.37M (Peak 254.44M) | Time:00:00.70 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.018 23/33 | Packing BVH nodes
Fra:1 Mem:186.85M (Peak 254.44M) | Time:00:00.70 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Building BVH
Fra:1 Mem:187.14M (Peak 254.44M) | Time:00:00.71 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Packing BVH triangles and strands
Fra:1 Mem:187.14M (Peak 254.44M) | Time:00:00.71 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Packing BVH nodes
Fra:1 Mem:185.18M (Peak 254.44M) | Time:00:00.75 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Packing BVH triangles and strands
Fra:1 Mem:185.22M (Peak 254.44M) | Time:00:00.75 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Packing BVH nodes
Fra:1 Mem:184.71M (Peak 254.44M) | Time:00:00.77 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Building BVH 75%, duplicates 0%
Fra:1 Mem:184.45M (Peak 254.44M) | Time:00:00.77 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Building BVH 65%, duplicates 25%
Fra:1 Mem:183.16M (Peak 254.44M) | Time:00:00.78 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Packing BVH triangles and strands
Fra:1 Mem:183.22M (Peak 254.44M) | Time:00:00.78 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.022 24/33 | Packing BVH nodes
Fra:1 Mem:183.07M (Peak 254.44M) | Time:00:00.78 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Building BVH
Fra:1 Mem:183.18M (Peak 254.44M) | Time:00:00.79 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Building BVH 31%, duplicates 3%
Fra:1 Mem:182.76M (Peak 254.44M) | Time:00:00.79 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Packing BVH triangles and strands
Fra:1 Mem:182.80M (Peak 254.44M) | Time:00:00.79 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.005 25/33 | Packing BVH nodes
Fra:1 Mem:181.85M (Peak 254.44M) | Time:00:00.81 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.045 26/33 | Building BVH
Fra:1 Mem:182.48M (Peak 254.44M) | Time:00:00.81 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.045 26/33 | Building BVH 13%, duplicates 4%
Fra:1 Mem:183.54M (Peak 254.44M) | Time:00:00.82 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.045 26/33 | Packing BVH triangles and strands
Fra:1 Mem:183.59M (Peak 254.44M) | Time:00:00.82 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.045 26/33 | Packing BVH nodes
Fra:1 Mem:183.67M (Peak 254.44M) | Time:00:00.83 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Building BVH
Fra:1 Mem:184.06M (Peak 254.44M) | Time:00:00.84 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Packing BVH triangles and strands
Fra:1 Mem:184.07M (Peak 254.44M) | Time:00:00.84 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Packing BVH nodes
Fra:1 Mem:183.04M (Peak 254.44M) | Time:00:00.84 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Packing BVH triangles and strands
Fra:1 Mem:183.09M (Peak 254.44M) | Time:00:00.85 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Packing BVH nodes
Fra:1 Mem:183.11M (Peak 254.44M) | Time:00:00.89 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Packing BVH triangles and strands
Fra:1 Mem:183.19M (Peak 254.44M) | Time:00:00.89 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Packing BVH nodes
Fra:1 Mem:182.45M (Peak 254.44M) | Time:00:00.90 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Packing BVH triangles and strands
Fra:1 Mem:182.49M (Peak 254.44M) | Time:00:00.90 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube.000 27/33 | Packing BVH nodes
Fra:1 Mem:182.23M (Peak 254.44M) | Time:00:00.90 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Building BVH
Fra:1 Mem:182.23M (Peak 254.44M) | Time:00:00.90 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Packing BVH triangles and strands
Fra:1 Mem:182.23M (Peak 254.44M) | Time:00:00.90 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Packing BVH nodes
Fra:1 Mem:182.94M (Peak 254.44M) | Time:00:00.92 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Building BVH 24%, duplicates 1%
Fra:1 Mem:182.55M (Peak 254.44M) | Time:00:00.92 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Packing BVH triangles and strands
Fra:1 Mem:182.56M (Peak 254.44M) | Time:00:00.92 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Packing BVH nodes
Fra:1 Mem:182.65M (Peak 254.44M) | Time:00:00.92 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cube 28/33 | Building BVH 80%, duplicates 9%
Fra:1 Mem:180.76M (Peak 254.44M) | Time:00:00.98 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Building BVH
Fra:1 Mem:181.34M (Peak 254.44M) | Time:00:00.99 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH triangles and strands
Fra:1 Mem:181.34M (Peak 254.44M) | Time:00:00.99 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Circle.003 29/33 | Packing BVH nodes
Fra:1 Mem:181.33M (Peak 254.44M) | Time:00:00.99 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Cylinder 30/33 | Building BVH
Fra:1 Mem:182.04M (Peak 254.44M) | Time:00:01.01 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.030 31/33 | Building BVH
Fra:1 Mem:187.55M (Peak 254.44M) | Time:00:01.02 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH
Fra:1 Mem:189.66M (Peak 254.44M) | Time:00:01.04 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 82%, duplicates 7%
Fra:1 Mem:190.33M (Peak 254.44M) | Time:00:01.06 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 89%, duplicates 17%
Fra:1 Mem:190.33M (Peak 254.44M) | Time:00:01.06 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 98%, duplicates 38%
Fra:1 Mem:190.38M (Peak 254.44M) | Time:00:01.08 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:190.40M (Peak 254.44M) | Time:00:01.08 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:188.99M (Peak 254.44M) | Time:00:01.12 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:189.09M (Peak 254.44M) | Time:00:01.12 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:185.73M (Peak 254.44M) | Time:00:01.13 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:185.81M (Peak 254.44M) | Time:00:01.13 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:181.91M (Peak 254.44M) | Time:00:01.15 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:182.12M (Peak 254.44M) | Time:00:01.15 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:179.48M (Peak 254.44M) | Time:00:01.15 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:179.50M (Peak 254.44M) | Time:00:01.15 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:171.16M (Peak 254.44M) | Time:00:01.16 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:171.58M (Peak 254.44M) | Time:00:01.16 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:165.19M (Peak 254.44M) | Time:00:01.17 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 79%, duplicates 2%
Fra:1 Mem:176.07M (Peak 254.44M) | Time:00:01.26 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Building BVH 34%, duplicates 1%
Fra:1 Mem:170.86M (Peak 254.44M) | Time:00:01.29 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:171.09M (Peak 254.44M) | Time:00:01.29 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:159.56M (Peak 254.44M) | Time:00:01.40 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH triangles and strands
Fra:1 Mem:159.83M (Peak 254.44M) | Time:00:01.40 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Geometry BVH Mesh.000 32/33 | Packing BVH nodes
Fra:1 Mem:155.14M (Peak 254.44M) | Time:00:01.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Building
Fra:1 Mem:155.14M (Peak 254.44M) | Time:00:01.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Building BVH
Fra:1 Mem:155.15M (Peak 254.44M) | Time:00:01.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Packing BVH triangles and strands
Fra:1 Mem:155.15M (Peak 254.44M) | Time:00:01.41 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Packing BVH nodes
Fra:1 Mem:193.08M (Peak 254.44M) | Time:00:01.44 | Mem:75.64M, Peak:75.64M | Scene, RenderLayer | Updating Scene BVH | Copying BVH to device
Fra:1 Mem:193.08M (Peak 254.44M) | Time:00:01.44 | Mem:94.61M, Peak:94.61M | Scene, RenderLayer | Updating Mesh | Computing normals
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.45 | Mem:94.61M, Peak:94.61M | Scene, RenderLayer | Updating Mesh | Copying Mesh to device
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.46 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Objects Flags
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.46 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Primitive Offsets
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.46 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Images
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.46 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Camera Volume
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.46 | Mem:110.57M, Peak:110.57M | Scene, RenderLayer | Updating Lookup Tables
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.46 | Mem:110.65M, Peak:110.65M | Scene, RenderLayer | Updating Lights
Fra:1 Mem:209.04M (Peak 254.44M) | Time:00:01.46 | Mem:110.65M, Peak:110.65M | Scene, RenderLayer | Updating Lights | Computing distribution
Fra:1 Mem:209.42M (Peak 254.44M) | Time:00:01.46 | Mem:111.04M, Peak:111.04M | Scene, RenderLayer | Updating Integrator
Fra:1 Mem:217.42M (Peak 254.44M) | Time:00:01.46 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Film
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:01.46 | Mem:118.96M, Peak:119.04M | Scene, RenderLayer | Updating Lookup Tables
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:01.46 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Baking
Fra:1 Mem:217.43M (Peak 254.44M) | Time:00:01.46 | Mem:119.04M, Peak:119.04M | Scene, RenderLayer | Updating Device | Writing constant memory
Fra:1 Mem:218.18M (Peak 254.44M) | Time:00:01.46 | Mem:180.54M, Peak:180.54M | Scene, RenderLayer | Sample 0/1225
Fra:1 Mem:230.05M (Peak 254.44M) | Time:00:01.58 | Remaining:02:23.23 | Mem:192.41M, Peak:192.41M | Scene, RenderLayer | Sample 1/1225
Memory access fault by GPU node-1 (Agent handle: 0x7f9bb154ba00) on address (nil). Reason: Page not present or supervisor privilege.
Aborted (core dumped)
bash-5.1$ 

```


notes from rocm docs:

> Additional Options
> The performance of an application can vary depending on the assignment of GPUs and CPUs to the task. Typically, numactl is installed as part of many HPC applications to provide GPU/CPU mappings. This Docker runtime option supports memory mapping and can improve performance.
> 
> `--security-opt seccomp=unconfined`
> This option is recommended for Docker Containers running HPC applications.
> 
> `docker run --device /dev/kfd --device /dev/dri --security-opt seccomp=unconfined ...`
> 