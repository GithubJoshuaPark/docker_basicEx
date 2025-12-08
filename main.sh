#!/usr/bin/env bash
set -euo pipefail

# 실행 경로 고정
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "▶ 스크립트 디렉터리: $SCRIPT_DIR"
LESSON_DIR="$SCRIPT_DIR/lessons"

source "$SCRIPT_DIR/lessons/utils.sh"

# 메뉴 목록
titles=(
    "($(get_random_emoji)) container 생성/중지/삭제 완전 마스터"
    "($(get_random_emoji)) nginx, ubuntu, redis, mysql 실습"
    "($(get_random_emoji)) volume / network 개념 배우기"
    "($(get_random_emoji)) Dockerfile 직접 만들기"
    "($(get_random_emoji)) docker-compose로 하나의 구성 파일에서 app+db 자동 실행"
    "($(get_random_emoji)) Spring Boot + MySQL Docker 통합 실습"
    "($(get_random_emoji)) React 앱을 Docker로 실행해서 Nginx로 배포하기"
)

# 메뉴 출력
print_menu() {
  echo "=============================="
  echo " Docker 학습 메뉴"
  echo "=============================="
  for i in $(seq 1 ${#titles[@]}); do
    printf " %2d) %s\n" "$i" "${titles[$((i-1))]}"
  done
  echo "------------------------------"
  echo " q | Q to exit) 종료"
  echo "------------------------------"
}

# 루프
while true; do
  print_menu
  read -rp "Docker 학습 메뉴에서 선택( 1 ~ 7, q to exit): " sel
  case "$sel" in
    q|Q)
      echo "학습을 종료합니다. 👋"
      exit 0
      ;;
    1|2|3|4|5|6|7)
      file="$(printf "%s/lesson%02d.sh" "$LESSON_DIR" "$sel")"
      if [[ -x "$file" ]]; then
        echo
        echo "--------------------------------"
        echo "🚀 실행: $(basename "$file")"
        echo "--------------------------------"
        "$file"
      else
        echo "❌ 해당 파일이 없거나 실행 권한이 없습니다."
      fi
      echo "--------------------------------"
      read -rp "💡 엔터를 누르면 메뉴로 돌아갑니다..." _
      ;;
    *)
      echo "🚩 잘못된 선택입니다."
      ;;
  esac
done
