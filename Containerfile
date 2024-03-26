ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-latest}"
FROM registry.fedoraproject.org/fedora:${FEDORA_MAJOR_VERSION} AS builder
ARG SELECTED_SPEC="${SELECTED_SPEC}"

VOLUME [ "/output" ]
ENV SRC_ROOT=/build
ADD . $SRC_ROOT
WORKDIR $SRC_ROOT

RUN --mount=type=tmpfs,target=/tmp dnf install --disablerepo='*' --enablerepo='fedora,updates' --setopt install_weak_deps=0 --nodocs --assumeyes git 'dnf-command(builddep)' rpkg rpm-build tree && \
    dnf clean all -y


# These git workarounds are necessary for repositories with jujutsu, since they dont work the same way as GIT does, the Copr build does not apply any of these workarounds.
# RUN rm -rf .git && git init && git add . && git config --global user.email "test@test.com" && git config --global user.name "test" && git remote add origin https://github.com/atomic-studio-org/Theming.git && git commit -m "fix: workaround for jujutsu and others"

RUN --mount=type=tmpfs,target=/tmp \
    set -exuo pipefail && \
    for FILE in $(find -iname '*.spec.rpkg') ; do rpkg -v -C "${SRC_ROOT}/rpkg.conf" local --spec "${FILE}" --outdir "/output" ; done
