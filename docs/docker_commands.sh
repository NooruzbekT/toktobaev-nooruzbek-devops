#!/bin/bash
# Docker demo commands for the video (Nooruzbek Toktobaev, "IT-2 2313", 38422).
# This is a cheat sheet: copy and run the commands one by one, do not run the whole file.
exit 0

cd ~/devops/toktobaev_nooruzbek
docker --version                      # Docker is installed
cat Dockerfile                        # FROM, WORKDIR, COPY, RUN, ENV, EXPOSE, CMD

# ---------- Build the image
docker build -t toktobaev-nooruzbek-devops .
docker images                         # the new image is in the list
docker images | grep toktobaev

# ---------- Run a container in the background
docker run -d -p 5000:5000 --name toktobaev-nooruzbek-container toktobaev-nooruzbek-devops
docker ps                             # running containers
docker ps -a                          # all containers, including stopped
docker logs toktobaev-nooruzbek-container
curl http://localhost:5000            # or open http://localhost:5000 in the browser

# ---------- Look inside the container
docker exec toktobaev-nooruzbek-container ls /app
docker exec toktobaev-nooruzbek-container pwd          # WORKDIR = /app
docker exec toktobaev-nooruzbek-container env | grep STUDENT

# ---------- Stop / start / remove
docker stop toktobaev-nooruzbek-container
docker ps -a                          # status Exited
docker start toktobaev-nooruzbek-container
docker ps
docker rm -f toktobaev-nooruzbek-container

# ---------- Environment variables (group has a space -> quotes!)
docker run -d -p 5000:5000 \
  -e STUDENT_NAME=Nooruzbek \
  -e STUDENT_SURNAME=Toktobaev \
  -e STUDENT_GROUP="IT-2 2313" \
  -e STUDENT_ID=38422 \
  --name toktobaev-nooruzbek-container \
  toktobaev-nooruzbek-devops
docker logs toktobaev-nooruzbek-container
docker exec toktobaev-nooruzbek-container env | grep STUDENT
docker rm -f toktobaev-nooruzbek-container

# Same image, different value -> different output
docker run --rm -e RUN_ONCE=true -e STUDENT_GROUP="TEST" toktobaev-nooruzbek-devops

# ---------- Docker Compose
cat docker-compose.yml
docker compose up -d --build
docker compose ps
docker compose logs
curl http://localhost:5000
docker compose down
docker ps -a | grep toktobaev         # container removed by compose down
