make_fake_dir () {

pushd "$WORKSPACE"

if ! [ -d "$WORKSPACE/core" ]; then
  mkdir "$WORKSPACE/core"
fi
popd
}

make_distr () {

prj_file=$1

pushd "$WORKSPACE"
python $SDK/tools/sln2cmake/sln2cmake.py "$prj_file" ReleaseUnix_wchar
if [[ $? != "0" ]]; then
  echo ERROR: Сompilation failed!!!
  echo ==============================
  exit 1
fi
popd
}

build_distr () {

cd "$WORKSPACE"
echo ==Начало сборки== $4

export jproj=$1
export jdist=$2
export jlog=$WORKSPACE/Jinnee/build_distr_$4_nix.log
export jfile=$3

"Jinnee/jinnee-utility" libjinnee-distribution300.so /project="$jproj" /create_distributive="$jdist" /logs="$jlog"
if [[ $? != "0" ]]; then
    echo ERROR: Assembly failed $4!!!
    echo ==============================
    export iserror=YES
    return 1
fi

}

echo hello nix!
echo ---------
echo $WORKSPACE
hostname -a
echo ---------
Определим директорию запуска
string=$JOB_NAME
IFS='/' read -a array <<< "$string"
echo ${array[0]}
gl_name=${array[0]}

export BUILD_MODE=/build

cp -rf /home/sbis/mount_test-osr-source/$PLATFORM_version/present_cloud.txt "$WORKSPACE"
cd "$WORKSPACE"
export WORK_DIR=$WORKSPACE
export SBIS3_NUMBER=`cat present_cloud.txt|awk '{print $1}'`
export SBIS3_DATE=`cat present_cloud.txt|awk '{print $2}' |awk -F "_" '{print $1}'`
export SBIS3_TIME=`cat present_cloud.txt|awk '{print $2}' |awk -F "_" '{print $2}'`
export BUILD_DATE=`echo $BUILD_ID|awk -F "_" '{print $1}'`
export BUILD_year=`echo $BUILD_DATE|awk -F "-" '{print $1}'`
export BUILD_month=`echo $BUILD_DATE|awk -F "-" '{print $2}'`
export BUILD_day=`echo $BUILD_DATE|awk -F "-" '{print $3}'`
export BUILD_DATE=$BUILD_day.$BUILD_month.$BUILD_year
export BUILD_TIME=`echo $BUILD_ID|awk -F "_" '{print $2}'`
export BUILD_HOUR=`echo $BUILD_TIME|awk -F "-" '{print $1}'`
export BUILD_MINUTE=`echo $BUILD_TIME|awk -F "-" '{print $2}'`
export BUILD_SECOND=`echo $BUILD_TIME|awk -F "-" '{print $3}'`
export BUILD_TIME=$BUILD_HOUR:$BUILD_MINUTE:$BUILD_SECOND
export OTHERS_EDO=$VERSION
echo =SDK.begin =
source "$WORKSPACE/sdk/setToSDK.sh" $PLATFORM_version
echo =SDK.end=

make_distr "$WORKSPACE/sbis-webdav-server/sbis-webdav-server.sln"


rm -rf $WORKSPACE/Jinnee
if ! [ -d "$WORKSPACE/Jinnee" ]; then
  mkdir "$WORKSPACE/Jinnee"
  else echo 'nothing to do'
fi
disk_i=/home/sbis/mount_disk_i

cp -f "$SDK/tools/jinnee/jinnee.zip" "$WORKSPACE/Jinnee"
unzip -o "$WORKSPACE/Jinnee/jinnee.zip"  -d "$WORKSPACE/Jinnee"

rsync -zvr "$SDK/ws" "$WORKSPACE/Jinnee/" > "$WORKSPACE/rsync.log"
# =====printenv====
printenv
# =================

export iserror=NO
echo Начало сборки
"%WORKSPACE%\projects\sbis-webdav-server.s3distr" 
build_distr "$WORKSPACE/sbis-webdav-server.s3cld" "$WORKSPACE/projects/sbis-webdav-server_nix.s3distr" "sbis-webdav-server_nix.zip" WebDav-server
echo fix point - time
date
# ВЫХОД!!!!
if [ "$iserror" == "YES" ]; then
    echo Есть ошибки
    exit 1
fi
exit 0