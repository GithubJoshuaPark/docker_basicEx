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

# MYSQL_DATA_DIR 디렉터리를 스크립트 이름 기반으로 생성
MYSQL_DATA_DIR="$SCRIPT_DIR/tmp/mysql_data"
echo "▶ MYSQL_DATA_DIR 디렉터리: $MYSQL_DATA_DIR"
mkdir -p "$MYSQL_DATA_DIR"

# tmp 디렉터리를 스크립트 이름 기반으로 생성
TMP_DIR="$SCRIPT_DIR/tmp/$(basename "$0" .sh)"
echo "▶ tmp 디렉터리: $TMP_DIR"ß
mkdir -p "$TMP_DIR"

# compose 파일 경로
COMPOSE_FILE="$TMP_DIR/docker-compose.yml"
echo "▶ compose 파일: $COMPOSE_FILE"

source "$SCRIPT_DIR/utils.sh"

cat <<'B'
========================================
 레슨 06) docker-compose로 하나의 구성 파일에서 app+db 자동 실행
========================================
B

echo "docker-compose로 app + db 구성하기"
echo "🧩 구성 시나리오"
echo "프로젝트 폴더 하나 안에 docker-compose.yml 만들기"
echo "그 안에 두 개 서비스 정의:"
echo "db : MySQL"
echo "app: ubuntu (테스트용, 나중에 Spring Boot로 바꿀 수 있음)"
echo "docker compose up -d 한 번으로 둘 다 실행"
echo "docker compose down 한 번으로 둘 다 종료/삭제"
f_pause

echo

cat > "$COMPOSE_FILE" <<B
version: '3'
services:
  db:
    image: mysql:5.7
    container_name: mysql
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: cdcdcd0011
      MYSQL_DATABASE: testdb
      MYSQL_USER: root
      MYSQL_PASSWORD: cdcdcd0011
    ports:
      - "3306:3306"
    volumes:
      - $MYSQL_DATA_DIR:/var/lib/mysql
  app:
    image: ubuntu:22.04
    container_name: ubuntu
    depends_on:
      - db
    command: ["sleep", "infinity"]
B

echo "▶ compose 파일 내용:"
cat "$COMPOSE_FILE"
f_pause

echo "docker compose -f $COMPOSE_FILE up -d"
docker compose -f $COMPOSE_FILE up -d
f_pause

echo "docker compose -f $COMPOSE_FILE ps"
docker compose -f $COMPOSE_FILE ps
f_pause

echo "docker compose -f $COMPOSE_FILE logs"
docker compose -f $COMPOSE_FILE logs
f_pause

echo "docker compose -f $COMPOSE_FILE down"
echo "containers and networks will be removed"
docker compose -f $COMPOSE_FILE down
f_pause

echo "========================"
echo "$(basename "$0") End"
echo "========================"
