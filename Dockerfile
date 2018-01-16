FROM docker.io/centos@sha256:2a61f8abd6250751c4b1dd3384a2bdd8f87e0e60d11c064b8a90e2e552fee2d7
MAINTAINER cuigk "cuigk@ehualu.com"

RUN yum install epel-release -y\
    && yum update -y\
    && yum install -y psmisc\
    && yum install -y fuse\
    && yum install -y sqlite\
    && yum install -y sqlite-devel\
    && yum install -y python34\
    && yum install -y python34-devel\
    && yum install -y python34-pip\
    && yum install -y python2-pip\
    && yum install -y gcc\
    && yum install -y git\
    && yum install -y systemd-devel\
    && yum install -y python34-llfuse\
    && yum install -y libffi-devel\
    && yum install -y curl\
    && yum clean all

COPY ["./pip.conf", "~/.pip/"]

RUN pip3 install -U pip\
    && pip3 install setuptools\
    && pip3 install pycrypto\
    && pip3 install defusedxml\
    && pip3 install requests\
    && pip3 install apsw\
    && pip3 install dugong\
    && pip3 install pytest==3.2.5\
    && pip3 install pytest-catchlog\
    && pip3 install xattr\
    && pip3 install git+https://github.com/systemd/python-systemd.git#egg=systemd\
    && rm -rf ~/.cache/pip/*\
    && rm -rf /tmp/*

ARG server

RUN curl -O ${server}/s3ql-2.23.tar\
    && tar -xvf s3ql-2.23.tar\
    && cd s3ql-2.23\
    && python3 setup.py install\
    && cd ..\
    && rm -rf s3ql-2.23.tar s3ql-2.23/

RUN pip2 install -U pip\
    && pip2 install supervisor\
    && rm -rf ~/.cache/pip/*

COPY ["./supervisord.conf", "/etc/supervisord.conf"]

CMD ["supervisord", "-c", "/etc/supervisord.conf"]

