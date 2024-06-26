Name:          studio-wallpapers-xyny
Vendor:        atomic-studio-org
Version:       1.0.0+{{{ git_ref }}}
Release:       1%{?dist}
Summary:       Collections of wallpapers made by Xyny
License:       CC-BY-SA-4.0
URL:           https://github.com/%{vendor}/%{name}
VCS:           {{{ git_dir_vcs }}}
Source:        {{{ git_dir_pack }}}
BuildArch:     noarch

%description
Wallpapers for Atomic Studio made by @xynydev.

%global debug_package %{nil}
%global ARTIST xyny

%prep
{{{ git_dir_setup_macro }}}

%install
shopt -s globstar
mkdir -p -m0755 \
    %{buildroot}%{_datadir}/backgrounds/%{VENDOR}/%{ARTIST} \
    %{buildroot}%{_datadir}/gnome-background-properties \
    %{buildroot}%{_datadir}/wallpapers/${NAME}

mv -f **/assets/* %{buildroot}%{_datadir}/backgrounds/%{VENDOR}/%{ARTIST}
mv -f LICENSE %{buildroot}%{_datadir}/backgrounds/%{VENDOR}/%{ARTIST}
mv -f **/xml/* %{buildroot}%{_datadir}/gnome-background-properties

%files
%license %{_datadir}/backgrounds/%{VENDOR}/%{ARTIST}/LICENSE
%attr(0755,root,root) %{_datadir}/backgrounds/%{VENDOR}/%{ARTIST}/*
%attr(0755,root,root) %{_datadir}/gnome-background-properties/*.xml

%post
mkdir -p %{_datadir}/wallpapers/%{VENDOR}/%{ARTIST}
ln -sf %{_datadir}/backgrounds/%{VENDOR}/%{ARTIST} %{_datadir}/wallpapers/%{VENDOR}/%{ARTIST}

%changelog
%autochangelog
