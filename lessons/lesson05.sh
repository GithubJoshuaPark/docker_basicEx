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
echo "▶ tmp 디렉터리: $TMP_DIR"
mkdir -p "$TMP_DIR"

# app.js 경로
APPJS="$TMP_DIR/app.js"
echo "▶ app.js 경로: $APPJS"

# Dockerfile 경로
DOCKERFILE="$TMP_DIR/Dockerfile"
echo "▶ Dockerfile 경로: $DOCKERFILE"

source "$SCRIPT_DIR/utils.sh"

cat <<'B'
========================================
 레슨 05) Dockerfile (커스텀 이미지) 직접 만들기
========================================
B

# app.js 파일 생성
cat > "$APPJS" <<'E'
// app.js
const http = require('http');

const PORT = process.env.PORT || 3000;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  res.setHeader('Content-Type', 'text/plain; charset=utf-8');
  res.end('Hello Docker! 안녕하세요, Joshua님!\n');
});

server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
E

echo "▶ app.js 파일 생성: $APPJS"
echo "▶ app.js 파일 내용:"
cat "$APPJS"
f_pause

# Dockerfile 생성
cat > "$DOCKERFILE" <<'E'
# 베이스 이미지: 가벼운 Node.js 런타임 사용
FROM node:20-alpine

# 컨테이너 안에서 작업할 디렉터리 설정
WORKDIR /usr/src/app

# 현재 폴더의 app.js를 컨테이너 내부로 복사
COPY app.js .

# (선택) 컨테이너가 사용할 포트 정보
EXPOSE 3000

# 컨테이너가 실행될 때 자동으로 시작할 명령
CMD ["node", "app.js"]
E

echo "▶ Dockerfile 생성: $DOCKERFILE"
echo "▶ Dockerfile 내용:"
cat "$DOCKERFILE"
f_pause

# Dockerfile 이용한 이미지 빌드
echo "▶ Dockerfile 이용한 이미지 빌드:"
echo "docker build -t my-node-app \$TMP_DIR"
echo "각 부분의 의미는:"
echo "  docker build : Dockerfile을 이용해 이미지를 만드는 명령"
echo "  -t my-node-app : 이미지에 이름(tag)을 붙임"
echo "     my-node-app:latest 라는 이름으로 저장됨"
echo "  . : 현재 디렉터리를 빌드 컨텍스트로 사용"
echo "     (이 안의 Dockerfile, app.js 등을 사용)"
echo "  \$TMP_DIR : 빌드 컨텍스트"

docker build -t my-node-app "$TMP_DIR"
f_pause

echo
echo "✅ docker images # 이미지 확인"
docker images
f_pause

echo "✅ Docker 컨테이너 실행 + 브라우저에서 확인 단계"
echo "docker run -d --name my-node-app -p 3000:3000 my-node-app"
echo "각 부분의 의미는:"
echo "  docker run : 이미지를 기반으로 컨테이너를 실행하는 명령"
echo "  -d : detached mode (백그라운드 실행)"
echo "  --name my-node-app : 컨테이너에 이름을 지정"
echo "  -p 3000:3000 : 포트 매핑"
echo "     3000:3000 : 호스트(컨테이너) 3000 포트를 컨테이너 3000 포트로 연결"
echo "  my-node-app : 이미지 이름"
echo
docker run -d --name my-node-app -p 3000:3000 my-node-app
f_pause

echo
echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "✅ open -a \"Google Chrome\" http://localhost:3000"
open -a "Google Chrome" http://localhost:3000
f_pause

echo "✅ Docker 컨테이너 삭제 + 이미지 삭제"
echo "docker ps -a | grep my-node-app | awk '{print\$1}' | xargs docker stop | xargs docker rm && docker images | grep my-node-app | awk '{print\$3}' | xargs docker rmi"
docker ps -a | grep my-node-app | awk '{print$1}' | xargs docker stop | xargs docker rm && docker images | grep my-node-app | awk '{print$3}' | xargs docker rmi
f_pause

echo
echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "========================"
echo "$(basename "$0") End"
echo "========================"
