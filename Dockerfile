FROM ubuntu:20.04

ENV TZ Asia/Shanghai
ENV DEBIAN_FRONTEND noninteractive

RUN set -ex \
    && echo $TZ > /etc/timezone \
    && apt-get update \
    && apt-get install -y --no-install-recommends tzdata wget ca-certificates \
    && rm /etc/localtime \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && wget https://down.oray.com/hsk/linux/phddns_5_1_amd64.deb \
    && dpkg -i phddns_5_1_amd64.deb \
    && rm phddns_5_1_amd64.deb \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get autoremove -y

COPY run.sh .

CMD /run.sh
