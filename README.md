# toktobaev-nooruzbek-devops

Laboratory work 1 for the **DevOps** course: Linux → Git → GitHub → Docker → Jenkins.

| | |
|---|---|
| Student | Nooruzbek Toktobaev |
| Group | IT-2 2313 |
| Student ID | 38422 |

## Project structure

```
toktobaev_nooruzbek/
├── app/            # Python application (runs in Docker)
├── scripts/        # Bash scripts (system information)
├── config/         # Application configuration (app.conf)
├── docs/           # Demo command lists
├── logs/           # Runtime logs (*.log is ignored by Git)
└── backup/         # Local backups (ignored by Git)
```

## Run with Docker

```bash
docker build -t toktobaev-nooruzbek-devops .
docker run -d -p 5000:5000 --name toktobaev-nooruzbek-container toktobaev-nooruzbek-devops
curl http://localhost:5000
```

Override student data with environment variables (quotes are required for the group):

```bash
docker run -d -p 5000:5000 -e STUDENT_GROUP="IT-2 2313" --name toktobaev-nooruzbek-container toktobaev-nooruzbek-devops
```

Or with Docker Compose (reads `.env`, see `.env.example`):

```bash
docker compose up -d --build
docker compose down
```

## Jenkins pipeline

Job `Toktobaev_Nooruzbek_DevOps` (Pipeline script from SCM → `Jenkinsfile`, branch `main`).
Stages: **Checkout → Build → Test → Docker Build → Docker Run**.
