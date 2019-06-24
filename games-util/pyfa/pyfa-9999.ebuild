# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_6 )
PYTHON_REQ_USE="sqlite,threads"

inherit desktop eutils python-r1 xdg-utils

DESCRIPTION="Python Fitting Assistant - a ship fitting application for EVE Online"
HOMEPAGE="https://github.com/pyfa-org/Pyfa"

RESTRICT="mirror bindist"
LICENSE="GPL-3+ all-rights-reserved"
SLOT="0"
if [[ ${PV} = 9999 ]]; then
	EGIT_REPO_URI="https://github.com/pyfa-org/Pyfa.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/pyfa-org/Pyfa/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi
IUSE="+graph"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	>=dev-python/beautifulsoup-4.6.0[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.3[${PYTHON_USEDEP}]
	>=dev-python/logbook-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/markdown2-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/packaging-16.8[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-5.1[${PYTHON_USEDEP}]
	>=dev-python/requests-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/roman-2.0.0[${PYTHON_USEDEP}]
	>=dev-python/sqlalchemy-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/wxpython-4.0.4[webkit,${PYTHON_USEDEP}]
	graph? (
		>=dev-python/matplotlib-2.0.0[wxwidgets,${PYTHON_USEDEP}]
		dev-python/numpy[${PYTHON_USEDEP}] )
	${PYTHON_DEPS}"
BDEPEND="app-arch/zip"

PATCHES=(
	# load images from separate staticdata directory
	"${FILESDIR}/${PN}-2.9.3-staticdata.patch"
	# fix import path in the main script for systemwide installation
	"${FILESDIR}/${PN}-2.9.3-import-pyfa.patch"
	)

[[ ${PV} = 9999 ]] || S=${WORKDIR}/Pyfa-${PV}

src_prepare() {
	# get rid of CRLF line endings introduced in 1.1.10 so patches work
	edos2unix config.py pyfa.py gui/bitmap_loader.py service/settings.py

	default

	# make python recognize pyfa as a package
	touch __init__.py || die

	pyfa_make_configforced() {
		mkdir -p "${BUILD_DIR}" || die
		sed -e "s:%%SITEDIR%%:$(python_get_sitedir):" \
			-e "s:%%EPREFIX%%:${EPREFIX}:" \
			"${FILESDIR}/configforced-1.15.1.py" > "${BUILD_DIR}/configforced.py" || die
		sed -e "s:%%SITEDIR%%:$(python_get_sitedir):" \
			pyfa.py > "${BUILD_DIR}/pyfa" || die
	}
	python_foreach_impl pyfa_make_configforced
}

src_install() {
	pyfa_py_install() {
		python_moduleinto ${PN}
		python_domodule eos gui service utils config*.py __init__.py version.yml
		python_domodule "${BUILD_DIR}/configforced.py"
		python_doscript "${BUILD_DIR}/pyfa"
	}
	python_foreach_impl pyfa_py_install

	insinto /usr/share/${PN}
	doins eve.db

	einfo "Compressing images ..."
	pushd imgs > /dev/null || die
	zip -r imgs.zip * || die "zip failed"
	doins imgs.zip
	popd > /dev/null || die

	dodoc README.md
	doicon -s 32 imgs/gui/pyfa.png
	newicon -s 64 imgs/gui/pyfa64.png pyfa.png
	domenu "${FILESDIR}/${PN}.desktop"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
