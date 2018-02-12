FROM fedora
#LABEL name="base"

ARG SAMBA_USERNAME=
ARG SAMBA_PASSWORD=

RUN dnf -y groupinstall "Minimal Install"
RUN dnf -y install python python-dnf unzip curl tar
RUN curl -L -o /tmp/google-cloud-sdk.tar.gz https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-102.0.0-linux-x86_64.tar.gz
RUN tar xzf /tmp/google-cloud-sdk.tar.gz -C /opt/ 
#&& ln -s /opt/google-cloud-sdk* /opt/google-cloud-sdk

# NFS
#RUN echo '/mnt/gcs-store 192.168.0.0(rw,fsid=0,no_subtree_check,sync,insecure,no_root_squash)' > /etc/exports
# SMB
RUN dnf -y install samba
COPY smb.conf /etc/samba/smb.conf
RUN useradd -g users -s /bin/bash -m ${SAMBA_USERNAME}
RUN echo -e "${SAMBA_PASSWORD}\n${SAMBA_PASSWORD}" | smbpasswd -a -s ${SAMBA_USERNAME}


COPY google-gcsfuse.repo /etc/yum.repos.d/google-gcsfuse.repo
RUN dnf -y install gcsfuse
COPY start.sh /opt/start.sh
RUN chmod 755 /opt/start.sh

# not necessary for templates
#ENTRYPOINT /opt/start.sh
#ENTRYPOINT /bin/bash
