Name:          studio-presets-gnome
Vendor:        atomic-studio-org
Version:       {{{ studio-wallpapers_version }}}
Release:       0%{?dist}
Summary:       Atomic Studio presets for the GNOME desktop
License:       Apache-2.0
URL:           https://github.com/%{vendor}/Theming
VCS:           {{{ git_dir_vcs }}}
Source:        {{{ git_dir_pack }}}
BuildArch:     noarch
Conflicts:     studio-presets-kde

%description
Presets and Branding for Atomic Studio (GNOME edition)

%global debug_package %{nil}

%prep
{{{ git_dir_setup_macro }}}

%install
mkdir -p %{buildroot}/usr
cp -rv files/* %{buildroot}/usr

%files
/usr/*

%changelog
{{{ git_dir_changelog }}}
