# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure CLI Telemetry Package"
HOMEPAGE="https://pypi.org/project/azure-cli-telemetry"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-python/portalocker-1.2.1[${PYTHON_USEDEP}]
	>=dev-python/applicationinsights-0.11.1[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# The proper __init__.py is provided by net-misc/azure-cli
	rm "${ED}${PYTHON_SITEDIR}/azure/__init__.py" || die
	# The proper __init__.py is provided by dev-python/azure-cli-nspkg
	rm "${ED}${PYTHON_SITEDIR}/azure/cli/__init__.py" || die

	# Why here and not with other azure-cli-* ebuild ?
	rm -r "${ED}${PYTHON_SITEDIR}/azure/__pycache__" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/__pycache__" || die
}
