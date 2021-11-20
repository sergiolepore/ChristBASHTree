FROM alpine:latest
RUN mkdir /langs
COPY langs /langs
COPY tree.sh /tree.sh
RUN apk add --update ncurses grep bash
ENV TERM=xterm-256color
CMD ["bash","/tree.sh"]
