# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools Storage Command Module"
HOMEPAGE="https://pypi.org/project/azure-cli-storage"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/azure-multiapi-storage-0.2.3[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-storage-3.3.0[${PYTHON_USEDEP}]
	dev-python/azure-cli-core[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# __init__.py are provided by net-misc/azure-cli
	rm "${ED}${PYTHON_SITEDIR}/azure/__init__.py" || die
	rm "${ED}${PYTHON_SITEDIR}/azure/cli/__init__.py" || die
	rm "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/__init__.py" || die

	# Avoid portage file collisions
	rm -r "${ED}${PYTHON_SITEDIR}/azure/__pycache__" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/__pycache__" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/__pycache__" || die
}
