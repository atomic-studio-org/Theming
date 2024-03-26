# Atomic Studio Theming

[![Build APK package](https://github.com/atomic-studio-org/cli/actions/workflows/apk-package.yml/badge.svg)](https://github.com/atomic-studio-org/cli/actions/workflows/apk-package.yml)
[![Publish every Git push to main to FlakeHub](https://github.com/atomic-studio-org/cli/actions/workflows/flakehub-push.yml/badge.svg)](https://github.com/atomic-studio-org/cli/actions/workflows/flakehub-push.yml)
[![Copr RPM build status](https://copr.fedorainfracloud.org/coprs/tulilirockz/studio-cli/package/studio-cli/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/tulilirockz/studio-cli/package/studio-cli/)

This project is meant for adding branding and theming to Atomic Studio as an RPM COPR, although we provide APK and Nix packages.

We currently provide these packages:

- studio-wallpapers
- studio-presets-kde
- studio-presets-gnome

## Contributing

All the branding for Atomic Studio was made by [@xynydev](https://github.com/xynydev), the logos and everything like that are on [their on repository](https://github.com/atomic-studio-org/Branding), but please, feel free to include here some of your arts as wallpapers! This repo is purely for discovery of artists and their sources! Make sure to include a watermark for your wallpapers through the `nix run github:atomic-studio-org#watermark-images` script provided in this repo or just write those onto the images directly.
