# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="A fast JSON parser/generator for C++ with both SAX/DOM style API"
HOMEPAGE="http://rapidjson.org/"

LICENSE="MIT"
IUSE="doc examples test"
SLOT="0"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/miloyip/rapidjson.git"
	inherit git-r3
else
	SRC_URI="https://github.com/miloyip/rapidjson/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/rapidjson-${PV}"
fi

DEPEND="
	doc? ( app-doc/doxygen )
	test? (
		dev-cpp/gtest
		dev-util/valgrind
	)"
RDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DRAPIDJSON_BUILD_DOC=$(usex doc)
		-DRAPIDJSON_BUILD_EXAMPLES=$(usex examples)
		-DRAPIDJSON_BUILD_TESTS=$(usex test)
		-DRAPIDJSON_BUILD_THIRDPARTY_GTEST=OFF
	)
	cmake-utils_src_configure
}
