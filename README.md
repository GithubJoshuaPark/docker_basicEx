# docker_basicEx

[![https://img.shields.io/badge/docker-28.1.1-blue](https://img.shields.io/badge/docker-28.1.1-blue)](https://github.com/GithubJoshuaPark/docker_basicEx.git)

✅ Docker 기초 사용법 10단계 (직접 따라 하기용)

1. Docker 버전 확인

(Docker Desktop 이 local pc에 설치되어 있어야 함)
Docker Desktop이 정상 동작하는지 확인하는 첫 단계입니다.

```bash
docker --version # 확인 포인트: Error 없이 버전 정보가 나오면 OK.
docker info

# docker info 명령어의 출력 설명
# --------------------------------------------------------------
# Docker는 Client(명령 실행) ↔ Server(엔진, daemon) 구조입니다.
# Client: 터미널에서 실행한 docker 명령
# Server: Docker Desktop 내부의 Linux 기반 Docker Engine
# Plugins: 기능 확장 모듈
# 출력도 그 구조에 맞춰 Client → Plugins → Server 순으로 나옵니다.
# --------------------------------------------------------------
```

🙌 학습순서

1️⃣ [container 생성/중지/삭제 완전 마스터](./lessons/lesson01.sh)<br>
2️⃣ [nginx, ubuntu, redis, mysql 실습](./lessons/lesson02.sh)<br>
3️⃣ [volume 개념 배우기](./lessons/lesson03.sh)<br>
4️⃣ [network 개념 배우기](./lessons/lesson04.sh)<br>
5️⃣ [Dockerfile 직접 만들기](./lessons/lesson05.sh)<br>
6️⃣ [docker-compose로 여러 서비스 구성하기](./lessons/lesson06.sh)<br>
7️⃣ [Spring Boot + MySQL Docker 통합 사용](./lessons/lesson07.sh)<br>
8️⃣ [React 앱을 Docker로 실행해서 Nginx로 배포하기](./lessons/lesson08.sh)

<br>
🙌 학습방법
손가락 근육이 기억하도록 계속 반복해서 따라해 보기 추천합니다.

<br>
🙌 lessons 폴더에 있는 lesson 파일들을 순서대로 실행해보세요.

```bash
./main.sh

==============================
 Docker 학습 메뉴
==============================
  1) (⛔) container 생성/중지/삭제 완전 마스터
  2) (✨) nginx, ubuntu, redis, mysql 실습
  3) (✅️) volume 개념 배우기
  4) (✅️) network 개념 배우기
  5) (⚙️) Dockerfile 직접 만들기
  6) (💡) docker-compose로 하나의 구성 파일에서 app+db 자동 실행
  7) (⚠️) Spring Boot + MySQL Docker 통합 실습 (Spring Boot + MySQL + Dockerfile + docker-compose)
  8) (⚠️) React 앱을 Docker로 실행해서 Nginx로 배포하기 (React + Nginx + Dockerfile + docker-compose)
------------------------------
 q | Q to exit) 종료
------------------------------
Docker 학습 메뉴에서 선택( 1 ~ 8, q to exit):

```
