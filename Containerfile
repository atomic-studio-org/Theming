ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-latest}"
ARG REGISTRY="registry.fedoraproject.org/fedora"
FROM ${REGISTRY}:${FEDORA_MAJOR_VERSION} AS builder
ARG SELECTED_SPEC="${SELECTED_SPEC}"

ENV SRC_ROOT=/build
VOLUME [ "/output" ]
ADD . $SRC_ROOT
WORKDIR $SRC_ROOT

RUN --mount=type=tmpfs,target=/tmp dnf install --disablerepo='*' --enablerepo='fedora,updates' --setopt install_weak_deps=0 --nodocs --assumeyes git 'dnf-command(builddep)' rpkg rpm-build && \
    dnf clean all -y

RUN --mount=type=tmpfs,target=/tmp \
    set -exuo pipefail && \
    for FILE in $(find -iname '*.spec.rpkg') ; do rpkg -v -C "${SRC_ROOT}/rpkg.conf" local --spec "${FILE}" --outdir "/output" ; done
