Name:          studio-presets
Vendor:        atomic-studio-org
Version:       {{{ studio-wallpapers_version }}}
Release:       0%{?dist}
Summary:       Meta package for wallpapers and branding for Atomic Studio
License:       Apache-2.0
URL:           https://github.com/%{vendor}/%{name}
VCS:           {{{ git_dir_vcs }}}
Source:        {{{ git_dir_pack }}}
BuildArch:     noarch
Requires:      studio-wallpapers-xyny
Requires:      studio-wallpapers-xe
Requires:      studio-presets-gnome
Requires:      studio-presets-kde

%description
Manages Atomic Studio installations

%global debug_package %{nil}

%prep
{{{ git_dir_setup_macro }}}

%build

%install

%files
%license LICENSE

%changelog
%autochangelog
