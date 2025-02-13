# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="A simple pythonic tool for remote execution and deployment"
HOMEPAGE="https://www.fabfile.org https://pypi.org/project/Fabric/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="doc fab2"

RDEPEND="
	!fab2? ( !dev-python/fabric:0 )
	dev-python/cryptography[${PYTHON_USEDEP}]
	<dev-python/invoke-2[${PYTHON_USEDEP}]
	>=dev-python/paramiko-2.4[${PYTHON_USEDEP}]"

BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? (
		dev-python/alabaster[${PYTHON_USEDEP}]
		>=dev-python/sphinx-1.4[${PYTHON_USEDEP}]
		<dev-python/sphinx-1.7[${PYTHON_USEDEP}]
	)"

# Depends on pytest-relaxed which is broken
RESTRICT="test"

python_compile() {
	if use fab2; then
		export PACKAGE_AS_FABRIC2=1
		ln -s fabric fabric2 || die
	fi
	distutils-r1_python_compile
}

python_compile_all() {
	if use doc; then
		sphinx-build -b html -c sites/docs/ sites/docs/ sites/docs/html || die
	fi
}

python_install_all() {
	use doc && local HTML_DOCS=( sites/docs/html/. )
	distutils-r1_python_install_all
}
