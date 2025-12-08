#!/usr/bin/env bash
set -euo pipefail
echo
echo "========================"
echo "$(basename "$0") Start"
echo "========================"
echo
# ▣ [2] 실행 중인 스크립트 경로 계산
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "▶ 스크립트 디렉터리: $SCRIPT_DIR"

# tmp 디렉터리를 스크립트 이름 기반으로 생성
TMP_DIR="$SCRIPT_DIR/tmp/$(basename "$0" .sh)"
echo "▶ tmp 디렉터리: $TMP_DIR"
mkdir -p "$TMP_DIR"

# MYSQL_DATA_DIR 디렉터리를 스크립트 이름 기반으로 생성
MYSQL_DATA_DIR="$SCRIPT_DIR/tmp/mysql_data"
echo "▶ tmp 디렉터리: $MYSQL_DATA_DIR"
mkdir -p "$MYSQL_DATA_DIR"

source "$SCRIPT_DIR/utils.sh"

cat <<'B'
========================================
 레슨 03) volume 개념 배우기 (with mysql)
========================================
B

echo
echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "- ubuntu 컨테이너(있다면) 삭제 && ubuntu 이미지(있다면) 삭제"
echo "docker ps -a | grep ubuntu | awk '{print\$1}' | xargs docker stop | xargs docker rm && docker images | grep ubuntu | awk '{print\$3}' | xargs docker rmi"
docker ps -a | grep ubuntu | awk '{print$1}' | xargs docker stop | xargs docker rm && docker images | grep ubuntu | awk '{print$3}' | xargs docker rmi
f_pause

echo "1 mysql 컨테이너 실행 (volume)"
echo "docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=cdcdcd0011 -p 3306:3306 -v \$MYSQL_DATA_DIR:/var/lib/mysql mysql:5.7"
echo "# 옵션 설명 짧게 정리하면:"
echo "# -d : 백그라운드(detached) 실행"
echo "# --name mysql : 컨테이너 이름을 mysql로 지정"
echo "# -e MYSQL_ROOT_PASSWORD=cdcdcd0011 : 환경 변수 설정"
echo "# -p 3306:3306 : 호스트 3306 포트 → 컨테이너 3306 포트 연결"
echo "# -v \$MYSQL_DATA_DIR:/var/lib/mysql : 컨테이너 내부 /var/lib/mysql 폴더를 호스트의 \$MYSQL_DATA_DIR 폴더와 연결"
echo "# mysql:5.7 : 사용할 이미지 이름"

docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=cdcdcd0011 -p 3306:3306 -v $MYSQL_DATA_DIR:/var/lib/mysql mysql:5.7
f_pause

echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "2 mysql 접속 (컨테이너 내부에서 mysql 접속)"
echo "docker exec -it mysql mysql -uroot -pcdcdcd0011"
echo "# 커맨드 창에서 아래 명령 직접 해 보기"
echo "3 mysql 실습"
echo "  CREATE DATABASE testdb; # 데이터베이스 생성"
echo "  USE testdb; # 데이터베이스 선택"
echo "  CREATE TABLE testtable (id INT PRIMARY KEY, name VARCHAR(255)); # 테이블 생성"
echo "  INSERT INTO testtable (id, name) VALUES (1, 'test'); # 데이터 삽입"
echo "  SELECT * FROM testtable; # 데이터 조회"
echo "  exit; # mysql 탈출"

docker exec -it mysql mysql -uroot -pcdcdcd0011
f_pause

echo "4 mysql 컨테이너 삭제 && mysql 이미지 삭제"
echo "docker ps -a | grep mysql | awk '{print\$1}' | xargs docker stop | xargs docker rm && docker images | grep mysql | awk '{print\$3}' | xargs docker rmi"
docker ps -a | grep mysql | awk '{print$1}' | xargs docker stop | xargs docker rm && docker images | grep mysql | awk '{print$3}' | xargs docker rmi
f_pause

echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "5 docker volume ls # volume 확인 (volumn 은 그대로 남아있음)"
echo "docker volume ls"
docker volume ls
f_pause

echo "6. $MYSQL_DATA_DIR volume 이용해서 새로운 mysql 컨테이너 실행"
echo "docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=cdcdcd0011 -p 3306:3306 -v \$MYSQL_DATA_DIR:/var/lib/mysql mysql:5.7"
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=cdcdcd0011 -p 3306:3306 -v $MYSQL_DATA_DIR:/var/lib/mysql mysql:5.7
f_pause

echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "7 mysql 접속 (컨테이너 내부에서 mysql 접속)"
echo "docker exec -it mysql mysql -uroot -pcdcdcd0011"
echo "# 커맨드 창에서 아래 명령 직접 해 보기"
echo "8 mysql 실습"
echo "  show databases;"
echo "  USE testdb; # 데이터베이스 선택"
echo "  show tables;"
echo "  SELECT * FROM testtable; # 데이터 조회"
echo "  exit; # mysql 탈출"
echo " --------------------------------------------------------- "
# echo " Q: 여기서 질문, 
#           $TMP_DIR(Host Bind Mount)을 사용하지 않고 -v mysql_data: /var/lib/mysql 로 volume을 연결할 경우
#           mysql_data volume 은 어디에 위치하는가?"
# echo " A: /var/lib/docker/volumes/mysql_data/_data"
# echo "   , 하지만 이 위치는 Docker desktop(VM) 이 관리하는 위치이므로 local pc에서는 바로 접근할 수 없음"
# echo "   docker exec -it mysql bash"
# echo "   ls /var/lib/mysql"
# echo "   통해서 확인할 수 있음"
# echo "   exit"
# echo " --------------------------------------------------------- "

docker exec -it mysql mysql -uroot -pcdcdcd0011
f_pause

echo "9 mysql 컨테이너 삭제 && mysql 이미지 삭제"
echo "docker ps -a | grep mysql | awk '{print\$1}' | xargs docker stop | xargs docker rm && docker images | grep mysql | awk '{print\$3}' | xargs docker rmi"
docker ps -a | grep mysql | awk '{print$1}' | xargs docker stop | xargs docker rm && docker images | grep mysql | awk '{print$3}' | xargs docker rmi
f_pause

echo "10 docker volume ls # volume 확인"
echo "$TMP_DIR volume 은 local pc에 위치(docker vm 에서 관리하지 않음)"
echo "하지만 docker vm 내부에서 /var/lib/mysql 폴더가 $TMP_DIR 폴더와 연결되어 있음"
echo "docker volume ls"
docker volume ls
f_pause

echo "11 docker network ls # network 확인"
echo "docker network ls"
docker network ls
f_pause

echo "========================"
echo "$(basename "$0") End"
echo "========================"
