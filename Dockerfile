FROM waggle/plugin-base:1.1.1-base
LABEL version="0.2.0" \
      description="Periodical/Trigger-based Image sampler"

# COPY app.py /app/
COPY app.py requirements.txt Makefile /app/
RUN pip3 install --no-cache-dir -r /app/requirements.txt

RUN apt-get update && apt-get -y install cmake

RUN make setup -f /app/Makefile && make setup -f /app/Makefile



ENTRYPOINT ["python3", "-u", "/app/app.py"]