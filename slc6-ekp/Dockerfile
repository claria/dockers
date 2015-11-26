##
## hepsw/cvmfs-base
## A container where CernVM-FS mount on host,
## adapted from hepsw/docks from Sebastian Binet "binet@cern.ch"
##
FROM hepsw/slc-base
MAINTAINER Matthias Schnepf "matthias.schnepf@student.kit.edu"

USER root
ENV USER root
ENV HOME /root
ENV VO_CMS_SW_DIR       /cvmfs/cms.cern.ch
ENV CMS_LOCAL_ROOT_BASE /cvmfs/cms.cern.ch


# install cvmfs repos
ADD etc-yum-cernvm.repo /etc/yum.repos.d/cernvm.repo

# install htcondor
ADD htcondor-stable-rhel6.repo /etc/yum.repos.d/htcondor-stable-rhel6.repo 
ADD RPM-GPG-KEY-HTCondor /root/RPM-GPG-KEY-HTCondor
RUN rpm --import /root/RPM-GPG-KEY-HTCondor

# Install rpms
RUN yum update -y && yum -y install \
    freetype \
    glibc-headers \
    glibc-devel \
	condor.x86_64 \
    ; \
    yum clean all

# add config files for condor
ADD ekpcondor/config.d /etc/condor/config.d
RUN mkdir -p /etc/condor/security


#RUN mkdir -p /cvmfs/cms.cern.ch && \
#    echo "cms.cern.ch /cvmfs/cms.cern.ch cvmfs defaults 0 0" >> /etc/fstab


WORKDIR /root

## add files last (as this invalids caches)

#VOLUME ["/cvmfs/cms.cern.ch"]

## make the whole container seamlessly executable
CMD ["bash"]
