##
## hepsw/cvmfs-base
## A container where CernVM-FS is up and running, just copied from 
##
FROM hepsw/slc-base
MAINTAINER Georg Sieber "sieber@cern.ch"

USER root
ENV USER root
ENV HOME /root
ENV VO_CMS_SW_DIR       /cvmfs/cms.cern.ch
ENV CMS_LOCAL_ROOT_BASE /cvmfs/cms.cern.ch

## make sure FUSE can be enabled
RUN if [[ ! -e /dev/fuse ]]; then mknod -m 666 /dev/fuse c 10 229; fi

# install cvmfs repos
ADD etc-yum-cernvm.repo /etc/yum.repos.d/cernvm.repo

# Install rpms
RUN yum update -y && yum -y install \
    cvmfs cvmfs-init-scripts cvmfs-auto-setup \
    cvmfs-config-default \
    freetype fuse \
    glibc-headers \
    ; \
    yum clean all

RUN mkdir -p \
    /cvmfs/cernvm-prod.cern.ch \
    /cvmfs/sft.cern.ch \

RUN mkdir -p /cvmfs/cms.cern.ch && \
    echo "cms.cern.ch /cvmfs/cms.cern.ch cvmfs defaults 0 0" >> /etc/fstab


WORKDIR /root

## add files last (as this invalids caches)
ADD etc-cvmfs-default-local /etc/cvmfs/default.local
ADD etc-cvmfs-domain-local  /etc/cvmfs/domain.d/cern.ch.local
ADD etc-cvmfs-keys          /etc/cvmfs/keys

ADD run-cvmfs.sh /etc/cvmfs/run-cvmfs.sh

# RUN chmod uga+rx \
#         /etc/cvmfs/run-cvmfs.sh \
#         ;
#
#VOLUME ["/cvmfs"]

## make the whole container seamlessly executable
CMD ["bash"]

## EOF

