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
echo "▶ MYSQL_DATA_DIR 디렉터리: $MYSQL_DATA_DIR"
mkdir -p "$MYSQL_DATA_DIR"

source "$SCRIPT_DIR/utils.sh"

cat <<'B'
========================================
 레슨 04) network 개념 배우기
========================================
B

echo "✅ Docker Networks (app ↔ db 연결)"
echo "이번 단계 목표"
echo "Docker 컨테이너끼리 서로 통신 가능하게 하는 Bridge Network 생성"
echo "MySQL 컨테이너와 App 컨테이너(테스트용)를 같은 네트워크에 넣기"
echo "컨테이너 간 통신이 되는지 직접 테스트"
echo "실무에서도 Docker Compose, Kubernetes 모두 이 원리를 그대로 사용합니다."

echo "docker network ls | grep mynet | awk '{print\$1}' | xargs docker network rm"
docker network ls | grep mynet | awk '{print$1}' | xargs docker network rm || true
f_pause

echo "Docker 사용자 정의 네트워크 생성"
echo "docker network create mynet"
docker network create mynet
f_pause

echo "docker network ls"
docker network ls
f_pause

echo "docker network inspect mynet"
docker network inspect mynet
f_pause

echo "mysql 컨테이너 실행 (mynet 네트워크에 연결)"
echo "docker run -d --name mysql --network mynet -e MYSQL_ROOT_PASSWORD=cdcdcd0011 -p 3306:3306 -v \$MYSQL_DATA_DIR:/var/lib/mysql mysql:5.7"
echo "✅ 여기서 중요한 점"
echo "--network mynet 으로 docker가 자동으로 MySQL 컨테이너에게 DNS 이름 = 컨테이너명(mysql)을 부여"
echo "따라서 app 컨테이너에서 DB에 연결할 때는"
echo "👉 jdbc:mysql://mysql:3306/testdb"
echo "이렇게 컨테이너 이름으로 접근 가능해집니다."
echo "이것이 네트워크를 쓰는 가장 큰 이유입니다."

docker run -d --name mysql --network mynet -e MYSQL_ROOT_PASSWORD=cdcdcd0011 -p 3306:3306 -v $MYSQL_DATA_DIR:/var/lib/mysql mysql:5.7
f_pause

echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "네트워크에 연결된 두 번째 컨테이너 실행 (테스트용 app)"
echo "이번에는 실제 Spring Boot를 쓰지 않고\n통신 확인용 Ubuntu 컨테이너 + mysql-client 설치 방식으로 진행합니다."
f_pause

echo "docker run -it --name ub_app_test --network mynet ubuntu:22.04 bash"
echo "# 커맨드 창에서 아래 명령 직접 해 보기"
echo "# (ubuntu 컨테이너 내부에서) mysql-client 설치"
echo "  apt update && apt install -y mysql-client"
echo "# 같은 네트워크 컨테이너끼리는 이름(mysql)으로 서로 접근"
echo "mysql -h(host server name) mysql(컨테이너 이름) -uroot -pcdcdcd0011"
echo "mysql> show databases;"
echo "mysql> use testdb;"
echo "mysql> show tables;"
echo "mysql> select * from testtable;"
echo "mysql> exit"
echo "exit"

docker run -it --name ub_app_test --network mynet ubuntu:22.04 bash
f_pause

echo "ubuntu | mysql 컨테이너 삭제 && ubuntu | mysql 이미지 삭제"
echo "docker ps -a | grep -E 'ubuntu|mysql' | awk '{print\$1}' | xargs docker stop | xargs docker rm && docker images | grep -E 'ubuntu|mysql' | awk '{print\$3}' | xargs docker rmi "
docker ps -a | grep -E 'ubuntu|mysql' | awk '{print$1}' | xargs docker stop | xargs docker rm && docker images | grep -E 'ubuntu|mysql' | awk '{print$3}' | xargs docker rmi 
f_pause

echo "docker network ls"
docker network ls
f_pause

echo "docker network rm mynet"
docker network rm mynet
f_pause

# echo "docker network prune"
# echo "docker network ls"

echo "========================"
echo "$(basename "$0") End"
echo "========================"
