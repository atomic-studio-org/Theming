Name:          studio-presets-plasma
Vendor:        atomic-studio-org
Version:       0.9.0+{{{ git_ref }}}
Release:       0%{?dist}
Summary:       Atomic Studio presets for the Plasma desktop
License:       Apache-2.0
URL:           https://github.com/%{vendor}/Theming
VCS:           {{{ git_dir_vcs }}}
Source:        {{{ git_dir_pack }}}
BuildArch:     noarch

%description
Presets and Branding for Atomic Studio (Plasma edition)
Contains a custom Catppuccin-based theme for Plasma 6
Check out their amazing work on https://github.com/catppuccin/kde !

%global debug_package %{nil}

%prep
{{{ git_dir_setup_macro }}}

%install
mkdir -p %{buildroot}%{_exec_prefix} %{buildroot}%{_sysconfdir}
cp -rv files/etc/* %{buildroot}%{_sysconfdir}
cp -rv files/usr/* %{buildroot}%{_exec_prefix}

%files
%{_exec_prefix}/lib/sddm/sddm.conf.d/*
%{_datadir}/color-schemes/*.colors
%{_datadir}/plasma/look-and-feel/com.github.AtomicStudio.theme
%{_datadir}/plasma/avatars/*.png
%{_datadir}/aurorae/themes/AtomicStudio
%{_sysconfdir}/xdg/*

%changelog
{{{ git_dir_changelog }}}
