FROM alpine:latest
COPY tree-EN.sh /tree-EN.sh
RUN apk add --update ncurses bash
ENV TERM=xterm-256color
CMD ["bash","/tree-EN.sh"]
