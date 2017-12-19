FROM fedora:latest
COPY tree-EN.sh /tree-EN.sh
ENV TERM=xterm-256color
CMD ["/tree-EN.sh"]
