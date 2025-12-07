#!/usr/bin/env bash
set -euo pipefail
echo
echo "========================"
echo "$(basename "$0") Start"
echo "========================"

# ▣ [2] 실행 중인 스크립트 경로 계산
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "▶ 스크립트 디렉터리: $SCRIPT_DIR"
# tmp 디렉터리를 스크립트 이름 기반으로 생성
TMP_DIR="$SCRIPT_DIR/tmp/$(basename "$0" .sh)"
mkdir -p "$TMP_DIR"

source "$SCRIPT_DIR/utils.sh"

cat <<'B'
========================================
 레슨 01) container 생성/중지/삭제 완전 마스터
========================================
B

echo
echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "✅ 일회성 컨테이너 실행(hello-world)"
echo "docker run hello-world"
docker run hello-world
f_pause

echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "✅ hello-world 컨테이너 삭제 && hello-world 이미지 삭제"
docker ps -a | grep hello-world | awk '{print$1}' | xargs docker rm && docker images | grep hello-world | awk '{print$1}' | xargs docker rmi
f_pause

echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "✅ 계속 살아 있는 컨테이너 실행 (nginx)"
echo "docker run -d --name web1 -p 8080:80 nginx"
echo "# 옵션 설명 짧게 정리하면:"
echo "# -d : 백그라운드(detached) 실행"
echo "# --name web1 : 컨테이너 이름을 web1으로 지정"
echo "# -p 8080:80 : 호스트 8080 포트 → 컨테이너 80 포트 연결"
echo "# nginx : 사용할 이미지 이름"

docker run -d --name web1 -p 8080:80 nginx
f_pause

echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "✅ docker stop web1"
docker stop web1
f_pause

echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "✅ docker restart web1"
docker restart web1
f_pause

echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "✅ open -a \"Google Chrome\" http://localhost:8080"
open -a "Google Chrome" http://localhost:8080
f_pause

echo "✅ nginx web1 container stop"
docker stop web1
f_pause

echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "✅ nginx 컨테이너 삭제 && nginx 이미지 삭제"
docker ps -a | grep nginx | awk '{print$1}' | xargs docker rm && docker images | grep nginx | awk '{print$1}' | xargs docker rmi
f_pause

echo "✅ docker ps -a # 어떤 컨테이너가 돌고 있는지 먼저 확인, -a: 모든 컨테이너를 보여줌"
docker ps -a
f_pause

echo "========================"
echo "$(basename "$0") End"
echo "========================"
