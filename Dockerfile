FROM alpine:latest
COPY tree-EN.sh tree-ES.sh tree-ENV_LANG.sh /
RUN apk add --update ncurses bash
ENV TERM=xterm-256color
CMD ["bash","/tree-ENV_LANG.sh"]
