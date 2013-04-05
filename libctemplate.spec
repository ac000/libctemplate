Name:		libctemplate
Version:	1.4.0
Release:	2.otl%{?dist}
Summary:	A C HTML Template Library

Group:		System Environment/Libraries
License:	GPLv3
URL:		http://github.com/opentechlabs/libctemplate
Source0:	libctemplate-%{version}.tar
BuildRoot:	%(mktemp -ud %{_tmppath}/%{name}-%{version}-%{release}-XXXXXX)

%description
This library and the template language that it implements are inspired by the
perl HTML::Template package. The template language has HTML-like tags for
variable substitution, file inclusion, if statements, and loop statements. The
library has functions for building a list of variables and for passing the
variables to a template file for output.


%prep
%setup -q


%build
make


%install
rm -rf $RPM_BUILD_ROOT
install -Dp -m644 ctemplate.h $RPM_BUILD_ROOT/%{_includedir}/ctemplate.h
install -Dp -m0755 libctemplate.so.%{version} $RPM_BUILD_ROOT/%{_libdir}/libctemplate.so.%{version}
install -Dp -m0755 libctemplate-fcgi.so.%{version} $RPM_BUILD_ROOT/%{_libdir}/libctemplate-fcgi.so.%{version}
install -Dp -m0755 libctemplate-fcgx.so.%{version} $RPM_BUILD_ROOT/%{_libdir}/libctemplate-fcgx.so.%{version}
cd $RPM_BUILD_ROOT/%{_libdir}
ln -s libctemplate.so.%{version} libctemplate.so
ln -s libctemplate-fcgi.so.%{version} libctemplate-fcgi.so
ln -s libctemplate-fcgx.so.%{version} libctemplate-fcgx.so
cd -

%post -p /sbin/ldconfig

%clean
rm -rf $RPM_BUILD_ROOT


%files
%defattr(-,root,root,-)
%doc doc.html README README.otl COPYING
%{_libdir}/libctemplate*.*
%{_includedir}/ctemplate.h


%changelog
* Fri Apr 05 2013 Andrew Clayton <andrew@opentechlabs.co.uk> - 1.4.0-2
- Include libctemplate-fcgx

* Wed Nov 21 2012 Andrew Clayton <andrew@opentechlabs.co.uk> - 1.4.0-1
- Initial RPM of libctemplate
