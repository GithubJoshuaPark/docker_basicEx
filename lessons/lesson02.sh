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
mkdir -p "$TMP_DIR"

source "$SCRIPT_DIR/utils.sh"

cat <<'B'
========================================
 레슨 02) ubuntu, redis, mysql 실습
========================================
B

echo
echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "========================"
echo "✅ ubuntu 실습"
echo "========================"
echo "1 ubuntu 이미지 pull"
echo "docker pull ubuntu:22.04"
docker pull ubuntu:22.04
f_pause

echo "- ubuntu 컨테이너 삭제 && ubuntu 이미지 삭제"
echo "docker ps -a | grep ubuntu | awk '{print\$1}' | xargs docker stop | xargs docker rm && docker images | grep ubuntu | awk '{print\$3}' | xargs docker rmi"
docker ps -a | grep ubuntu | awk '{print$1}' | xargs docker stop | xargs docker rm && docker images | grep ubuntu | awk '{print$3}' | xargs docker rmi
f_pause

echo "2 ubuntu 컨테이너 실행"
echo "docker run -d --name ubuntu ubuntu:22.04 sleep infinity"
echo "# 옵션 설명 짧게 정리하면:"
echo "# -d : 백그라운드(detached) 실행"
echo "# --name ubuntu : 컨테이너 이름을 ubuntu로 지정"
echo "# ubuntu:22.04 : 사용할 이미지 이름"
echo "# sleep infinity : 컨테이너가 계속 실행되도록 sleep infinity"

docker run -d --name ubuntu ubuntu:22.04 sleep infinity
f_pause

echo "3 docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "4 ubuntu 내부로 들어가기"
echo "docker exec -it ubuntu /bin/bash # ubuntu 컨테이너 내부로 들어가기"
echo "# 커맨드 창에서 아래 명령 직접 해 보기"
echo "5 ubuntu 내부에서 실습"
echo "5.1 패키지 업데이트"
echo "  apt-get update"
echo "5.2 curl 설치"
echo "  apt-get install -y curl"
echo "5.3 파일 생성"
echo "  echo 'hello world' > /tmp/hello.txt"
echo "5.4 파일 확인"
echo "  ls /tmp"
echo "5.5 컨테이너 탈출 & 상태 확인"
echo "  exit"

docker exec -it ubuntu /bin/bash
f_pause

echo "6 docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "7 ubuntu 컨테이너 삭제 && ubuntu 이미지 삭제"
echo "docker ps -a | grep ubuntu | awk '{print\$1}' | xargs docker stop | xargs docker rm && docker images | grep ubuntu | awk '{print\$3}' | xargs docker rmi"
docker ps -a | grep ubuntu | awk '{print$1}' | xargs docker stop | xargs docker rm && docker images | grep ubuntu | awk '{print$3}' | xargs docker rmi
f_pause

echo "8 docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "========================"
echo "✅ redis 실습"
echo "========================"
echo "1 redis 이미지 pull"
echo "docker pull redis:alpine"
docker pull redis:alpine
f_pause

echo "2 redis 컨테이너 실행"
echo "docker run -d --name redis -p 6379:6379 redis:alpine"
echo "# 옵션 설명 짧게 정리하면:"
echo "# -d : 백그라운드(detached) 실행"
echo "# --name redis : 컨테이너 이름을 redis로 지정"
echo "# -p 6379:6379 : 호스트 6379 포트 → 컨테이너 6379 포트 연결"
echo "# redis:alpine : 사용할 이미지 이름"
docker run -d --name redis -p 6379:6379 redis:alpine
f_pause

echo "3 docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "4 redis cli 접속"
echo "docker exec -it redis redis-cli"
echo "# 커맨드 창에서 아래 명령 직접 해 보기"
echo "5 redis 실습"
echo "  SET name 'Joshua' # 데이터 넣기"
echo "  GET name # 데이터 가져오기"
echo "  KEYS * # 모든 키 조회"
echo "  DEL name # 데이터 삭제"
echo "  exit # redis cli 탈출"

docker exec -it redis redis-cli
f_pause

echo "6 docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "12 redis 컨테이너 삭제 && redis 이미지 삭제"
echo "docker ps -a | grep redis | awk '{print\$1}' | xargs docker stop | xargs docker rm && docker images | grep redis | awk '{print\$3}' | xargs docker rmi"
docker ps -a | grep redis | awk '{print$1}' | xargs docker stop | xargs docker rm && docker images | grep redis | awk '{print$3}' | xargs docker rmi
f_pause

echo "13 docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "========================"
echo "🔥 mysql 실습"
echo "========================"
echo "🔥 목표"
echo "MySQL DB 서버 실행"
echo "root 비밀번호 설정"
echo "MySQL 접속 실습"
echo "데이터베이스·테이블 생성"
echo "========================"

echo "1 mysql 이미지 pull"
echo "docker pull mysql:5.7"
docker pull mysql:5.7
f_pause

echo "2 mysql 컨테이너 실행"
echo "docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=cdcdcd0011 -p 3306:3306 mysql:5.7"
echo "# 옵션 설명 짧게 정리하면:"
echo "# -d : 백그라운드(detached) 실행"
echo "# --name mysql : 컨테이너 이름을 mysql로 지정"
echo "# -e MYSQL_ROOT_PASSWORD=cdcdcd0011 : 환경 변수 설정"
echo "# -p 3306:3306 : 호스트 3306 포트 → 컨테이너 3306 포트 연결"
echo "# mysql:5.7 : 사용할 이미지 이름"
docker run -d --name mysql -e MYSQL_ROOT_PASSWORD=cdcdcd0011 -p 3306:3306 mysql:5.7
f_pause

echo "3 docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "4. mysql 접속 (컨테이너 내부에서 mysql 접속)"
echo "docker exec -it mysql mysql -uroot -pcdcdcd0011"
echo "# 커맨드 창에서 아래 명령 직접 해 보기"
echo "5 mysql 실습"
echo "  show databases;"
echo "  create database testdb;"
echo "  use testdb;"
echo "  create table users (id int auto_increment primary key, name varchar(50));"
echo "  insert into users (name) values ('Joshua');"
echo "  select * from users;"
echo "  exit;"

docker exec -it mysql mysql -uroot -pcdcdcd0011
f_pause

echo "6 docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "7 mysql 컨테이너 삭제 && mysql 이미지 삭제"
echo "docker ps -a | grep mysql | awk '{print\$1}' | xargs docker stop | xargs docker rm && docker images | grep mysql | awk '{print\$3}' | xargs docker rmi"
docker ps -a | grep mysql | awk '{print$1}' | xargs docker stop | xargs docker rm && docker images | grep mysql | awk '{print$3}' | xargs docker rmi
f_pause

echo "8 docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a    
f_pause

echo "========================"
echo "$(basename "$0") End"
echo "========================"
