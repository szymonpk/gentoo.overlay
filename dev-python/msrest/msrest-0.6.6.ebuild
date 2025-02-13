# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="AutoRest swagger generator Python client runtime"
HOMEPAGE="https://pypi.org/project/msrest"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

IUSE="async"

REQUIRED_USE="async? ( !python_targets_python3_7 )"

RDEPEND=">=dev-python/certifi-2017.4.17[${PYTHON_USEDEP}]
	>=dev-python/isodate-0.6.0[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-0.5.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.18.4[${PYTHON_USEDEP}]
	async? ( >=dev-python/aiohttp-3.0[${PYTHON_USEDEP}]
		dev-python/aiodns[${PYTHON_USEDEP}] )"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
