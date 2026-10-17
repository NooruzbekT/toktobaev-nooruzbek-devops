FROM python:3.12-slim

LABEL maintainer="Nooruzbek Toktobaev" \
      student.id="38422" \
      student.group="IT-2 2313"

WORKDIR /app

COPY app/app.py /app/app.py
COPY Toktobaev_Nooruzbek_info.txt /app/

RUN python -m py_compile /app/app.py \
    && useradd --create-home --uid 10001 appuser \
    && chown -R appuser:appuser /app

ENV PYTHONUNBUFFERED=1 \
    STUDENT_NAME="Nooruzbek" \
    STUDENT_SURNAME="Toktobaev" \
    STUDENT_GROUP="IT-2 2313" \
    STUDENT_ID="38422" \
    APP_PORT=5000

USER appuser

EXPOSE 5000

CMD ["python", "app.py"]
