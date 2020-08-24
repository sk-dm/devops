FROM alpine
EXPOSE 80
RUN apk update && apk add --no-cache wget python3 && mkdir /var/wwwdata && cd /var/wwwdata/ && wget -rqkl 1 -nd -A "html" "https://www.chiark.greenend.org.uk/~sgtatham/bugs.html" && ln -s bugs.html index.html && apk del wget
WORKDIR /var/wwwdata
ENTRYPOINT ["python3", "-m", "http.server", "80"]
