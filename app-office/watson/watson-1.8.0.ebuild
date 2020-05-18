# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

MY_PN=td-${PN}
MY_P=${MY_PN}-${PV}
DESCRIPTION="A wonderful CLI to track your time"
HOMEPAGE="https://github.com/TailorDev/Watson"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
		dev-python/click
		dev-python/requests
		<dev-python/arrow-0.15.6"
BDEPEND=""

S=${WORKDIR}/${MY_P}

DOCS=(
	README.rst
	CHANGELOG.md
)
