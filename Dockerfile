FROM alpine:latest
COPY tree.sh /tree.sh
RUN apk add --update ncurses bash
ENV TERM=xterm-256color
CMD ["bash","/tree.sh"]
