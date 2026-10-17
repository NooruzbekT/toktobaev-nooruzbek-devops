# Docker image for the DevOps student application
# Student: Nooruzbek Toktobaev, Group "IT-2 2313", ID 38422

# Base image: official slim Python 3.12
FROM python:3.12-slim

LABEL maintainer="Nooruzbek Toktobaev" \
      student.id="38422" \
      student.group="IT-2 2313"

# All following commands run inside /app
WORKDIR /app

# Copy the application and the student info file into the image
COPY app/app.py /app/app.py
COPY Toktobaev_Nooruzbek_info.txt /app/

# Check the code compiles and create a non-root user to run it
RUN python -m py_compile /app/app.py \
    && useradd --create-home --uid 10001 appuser \
    && chown -R appuser:appuser /app

# Default values - can be overridden with `docker run -e ...`
ENV PYTHONUNBUFFERED=1 \
    STUDENT_NAME="Nooruzbek" \
    STUDENT_SURNAME="Toktobaev" \
    STUDENT_GROUP="IT-2 2313" \
    STUDENT_ID="38422" \
    APP_PORT=5000

USER appuser

# The HTTP server listens on port 5000 (8080 is used by Jenkins)
EXPOSE 5000

CMD ["python", "app.py"]
