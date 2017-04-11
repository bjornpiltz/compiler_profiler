BUILD_DIR=$(PWD)
cd $BUILD_DIR

PROFILING_LOG=$BUILD_DIR/profiler.csv
TIME_CMD=gtime
ACTUAL_COMPILER=/usr/bin/clang++
echo $BUILD_DIR

git clone --depth 1 -b develop https://github.com/openMVG/openMVG.git
git submodule update -i

mkdir build
cd build
cmake ../openMVG/src/ -DCMAKE_CXX_COMPILER=/opt/local/bin/time-g++ -DBUILD_EXAMPLES=ON -DBUILD_TESTING=ON -DOpenMVG_BUILD_TESTS=ON
rm ../profiler.csv
time make -j6