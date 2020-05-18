# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-utils-2

MY_PN="solr"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="The open source enterprise search platform from the Apache Lucene project."
HOMEPAGE="https://lucene.apache.org/solr/"
SRC_URI="mirror://apache/lucene/${MY_PN}/${PV}/${MY_PN}-${PV}.tgz"

# x86 not supported due to xml-xmlbeans not having x86 arch
KEYWORDS="~amd64"
SLOT="0"
LICENSE="Apache-2.0"
IUSE="contrib doc examples"

DEPEND=""
RDEPEND=">=virtual/jre-1.7
	examples? ( dev-db/hsqldb:0 )
	acct-user/netdata"

S=${WORKDIR}/${MY_P}

src_install() {
	local randpw=$(echo ${RANDOM}|md5sum|cut -c 1-15)
	newinitd "${FILESDIR}/solr.initd" ${MY_PN}-bin
	newconfd "${FILESDIR}/solr.confd" ${MY_PN}-bin
	sed -i "s/solrrocks/${randpw}/g" "${D}/etc/init.d/${MY_PN}-bin" "${D}/etc/conf.d/${MY_PN}-bin"

	# remove files that are not needed on linux
	find \( -name "*.bat" -o -name "*.cmd" \) -delete

	# /etc/solr
	insinto /etc/${MY_PN}/server
	doins -r server/etc/*
	insinto /etc/${MY_PN}
	doins -r server/{contexts,resources}

	# /opt/solr
	insinto /opt/${MY_PN}
	doins -r dist
	dodoc *.txt

	if use contrib ; then
		doins -r contrib
	fi

	if use examples ; then
		doins -r example
	fi

	# /opt/solr/bin
	exeinto /opt/${MY_PN}/bin
	doexe bin/*
	dosym /opt/${MY_PN}/bin/solr /usr/bin/solr

	# /var/log/solr
	dodir /var/log/${MY_PN}
	fperms 750 /var/log/${MY_PN}
	fowners solr:solr /var/log/${MY_PN}

	# /opt/solr/server
	insinto /opt/${MY_PN}/server
	doins -r server/{README.txt,start.jar,lib,modules,scripts,solr-webapp}
	dosym /etc/${MY_PN}/server /opt/${MY_PN}/server/etc
	dosym /etc/${MY_PN}/contexts /opt/${MY_PN}/server/contexts
	dosym /etc/${MY_PN}/resources /opt/${MY_PN}/server/resources
	dosym /var/log/${MY_PN} /opt/${MY_PN}/server/logs

	# /opt/solr/contrib
	insinto /opt/${MY_PN}/contrib
	doins -r contrib/*

	# /var/lib/solr
	insinto /var/lib/${MY_PN}
	doins -r server/solr/*
	fperms 750 /var/lib/${MY_PN}
	fowners solr:solr /var/lib/${MY_PN}

	if use doc ; then
		java-pkg_dojavadoc docs
	fi
}
