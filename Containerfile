ARG FEDORA_MAJOR_VERSION="${FEDORA_MAJOR_VERSION:-latest}"
FROM registry.fedoraproject.org/fedora:${FEDORA_MAJOR_VERSION} AS builder
ARG SELECTED_SPEC="${SELECTED_SPEC:-theming.spec}"

ENV SRC_ROOT=/build
ENV OUTPUT_ROOT=/tmp
ENV FINAL_RPM_DIR=/srv/final
ADD . $SRC_ROOT
WORKDIR $SRC_ROOT

# These git workarounds are necessary for repositories with jujutsu, since they dont work the same way as GIT does, the Copr build does not apply any of these workarounds.
RUN --mount=type=tmpfs,target=/tmp \
    set -exuo pipefail && \
    mkdir -p ${FINAL_RPM_DIR} ${OUTPUT_ROOT}/{output,specs} && \
    dnf install --disablerepo='*' --enablerepo='fedora,updates' --setopt install_weak_deps=0 --nodocs --assumeyes git 'dnf-command(builddep)' rpkg rpm-build && \
    rm -rf .git && git init && git add . && git config --global user.email "test@test.com" && git config --global user.name "test" && git remote add origin https://github.com/atomic-studio-org/Theming.git && git commit -m "fix: workaround for jujutsu and others" && \
    rpkg -v -p ${SRC_ROOT} -C ${SRC_ROOT}/rpkg.conf spec --spec "${SRC_ROOT}/$SELECTED_SPEC" --outdir "$OUTPUT_ROOT/specs" && \
    dnf builddep -y "$OUTPUT_ROOT/specs/$(basename $SELECTED_SPEC .rpkg)" && \
    cp "${SRC_ROOT}/$SELECTED_SPEC" $(basename $SELECTED_SPEC) && \
    rpkg -v local --outdir "${OUTPUT_ROOT}/output" && \
    mv $OUTPUT_ROOT/output/* $FINAL_RPM_DIR

FROM scratch AS final
ENV FINAL_RPM_DIR=/srv/final

COPY --from=builder ${FINAL_RPM_DIR}/**/* /rpms
