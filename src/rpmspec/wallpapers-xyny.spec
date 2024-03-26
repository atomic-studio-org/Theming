Name:          studio-wallpapers-xyny
Vendor:        atomic-studio-org
Version:       {{{ studio-wallpapers_version }}}
Release:       0%{?dist}
Summary:       Meta package for wallpapers and branding for Atomic Studio
License:       Apache-2.0
URL:           https://github.com/%{vendor}/%{name}
VCS:           {{{ git_dir_vcs }}}
Source:        {{{ git_dir_pack }}}
BuildArch:     noarch

%description
Wallpapers from Xynydev

%global debug_package %{nil}

%prep
{{{ git_dir_setup_macro }}}

%install
mkdir -p -m0755 \
    %{buildroot}%{_datadir}/backgrounds/%{NAME} \
    %{buildroot}%{_datadir}/gnome-background-properties \
    %{buildroot}%{_datadir}/wallpapers/${NAME}

mv %{buildroot}/src/wallpapers/xyny/**/assets/* %{buildroot}%{_datadir}/backgrounds/%{NAME}
mv -f %{buildroot}/src/wallpapers/xyny/**/LICENSE %{buildroot}%{_datadir}/backgrounds/%{NAME}
mv %{buildroot}/src/wallpapers/xyny/**/xml/* %{buildroot}%{_datadir}/gnome-background-properties

%files
%license %{_datadir}/backgrounds/%{NAME}
%attr(0755,root,root) %{_datadir}/backgrounds/%{NAME}/*
%attr(0755,root,root) %{_datadir}/gnome-background-properties/*.xml

%post
mkdir -p %{_datadir}/wallpapers/${NAME}
ln -sf %{_datadir}/backgrounds/%{NAME} %{_datadir}/wallpapers/%{NAME}

%changelog
%autochangelog
