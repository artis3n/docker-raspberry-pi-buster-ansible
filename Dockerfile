FROM balenalib/raspberry-pi2:buster
LABEL maintainer="Artis3n"

ARG pip_packages="ansible"
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /

# Install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       sudo systemd systemd-sysv \
       build-essential wget libffi-dev libssl-dev \
       python-pip python-dev python-setuptools python-wheel \
       python3 python3-pip python3-setuptools python3-wheel python3-dev \
    && rm -rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get autoremove \
    && apt-get clean

# Install Ansible via pip.
RUN pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir $pip_packages

COPY initctl_faker .
RUN chmod +x initctl_faker && rm -fr /sbin/initctl && ln -s /initctl_faker /sbin/initctl

# Install Ansible inventory file
#
# Make sure systemd doesn't start agettys on tty[1-6]
RUN mkdir -p /etc/ansible \
    && printf "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts \
    && rm -f /lib/systemd/system/multi-user.target.wants/getty.target

VOLUME ["/sys/fs/cgroup"]
CMD ["/lib/systemd/systemd"]
