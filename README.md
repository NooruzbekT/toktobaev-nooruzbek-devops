# toktobaev-nooruzbek-devops

Lab 1 for the DevOps course: Linux, Git, GitHub, Docker and Jenkins.

Student: Nooruzbek Toktobaev, group IT-2 2313, ID 38422

## Folders

- `app` - Python app that runs in Docker
- `scripts` - bash script with system info
- `config` - app.conf
- `docs` - commands I used in the video
- `logs` - logs (not in git)
- `backup` - local backups (not in git)
- `tests` - unit tests

## Docker

```bash
docker build -t toktobaev-nooruzbek-devops .
docker run -d -p 5000:5000 --name toktobaev-nooruzbek-container toktobaev-nooruzbek-devops
curl http://localhost:5000
```

With my data as environment variables (the group needs quotes because of the space):

```bash
docker run -d -p 5000:5000 -e STUDENT_GROUP="IT-2 2313" --name toktobaev-nooruzbek-container toktobaev-nooruzbek-devops
```

Docker Compose (copy `.env.example` to `.env` first):

```bash
docker compose up -d --build
docker compose down
```

## Jenkins

Job `Toktobaev_Nooruzbek_DevOps`, Pipeline script from SCM, branch `main`, file `Jenkinsfile`.
Stages: Checkout, Build, Test, Docker Build, Docker Run.

## Tests

```bash
python3 -m unittest discover -s tests -v
```
