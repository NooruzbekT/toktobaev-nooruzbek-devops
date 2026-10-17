cd ~/devops/toktobaev_nooruzbek
docker --version
cat Dockerfile

docker build -t toktobaev-nooruzbek-devops .
docker images
docker images | grep toktobaev

docker run -d -p 5000:5000 --name toktobaev-nooruzbek-container toktobaev-nooruzbek-devops
docker ps
docker ps -a
docker logs toktobaev-nooruzbek-container
curl http://localhost:5000

docker exec toktobaev-nooruzbek-container ls /app
docker exec toktobaev-nooruzbek-container pwd
docker exec toktobaev-nooruzbek-container env | grep STUDENT

docker stop toktobaev-nooruzbek-container
docker ps -a
docker start toktobaev-nooruzbek-container
docker ps
docker rm -f toktobaev-nooruzbek-container

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

docker run --rm -e RUN_ONCE=true -e STUDENT_GROUP="TEST" toktobaev-nooruzbek-devops

cat docker-compose.yml
docker compose up -d --build
docker compose ps
docker compose logs
curl http://localhost:5000
docker compose down
