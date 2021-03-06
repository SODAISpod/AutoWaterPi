#!/bin/bash
# Program:
#       AutoWaterPi 初始化
# History:
# 2021/12/2	

#check interval
minute=5

#取得現在的路徑
get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     # While $SOURCE is a symlink, resolve it
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )"
          # If $SOURCE was a relative symlink (so no "/" as prefix, need to resolve it relative to the symlink base directory
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}

BASEDIR=$(get_script_dir)

mkdir -p $BASEDIR/Captured #建立Captured資料夾
(crontab -l 2>/dev/null; echo "*/15 * * * * $BASEDIR/capture.py") | crontab - #每15分拍一次照
(crontab -l 2>/dev/null; echo "*/$minute * * * * $BASEDIR/check.py") | crontab - #每X分檢查水位跟土壤濕度
