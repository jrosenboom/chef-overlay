# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

RUBY_FAKEGEM_EXTRADOC="API.txt History.txt README.md examples/* benchmarks.*"

USE_RUBY="ruby19 ruby20"

inherit ruby-fakegem

DESCRIPTION="Git Library for Ruby"
HOMEPAGE="http://rubyforge.org/projects/grit http://github.com/mojombo/grit"
SRC_URI="https://github.com/mojombo/grit/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc"

RDEPEND="dev-vcs/git"
DEPEND="test? ( dev-vcs/git )"

ruby_add_bdepend "doc? ( virtual/ruby-rdoc )
	test? ( dev-ruby/posix-spawn
	    dev-ruby/mime-types
		dev-ruby/diff-lcs )"
ruby_add_rdepend "dev-ruby/posix-spawn
	dev-ruby/mime-types
	dev-ruby/diff-lcs"

all_ruby_unpack() {
	unpack ${A}

	# Tests require the grit directory to look like a git repo.
	if [[ -e ${P}.git ]]; then
		# Expand RUBY_S in a manner similar to
		# _ruby_invoke_environment().
		mv ${P}.git $(eval ls -d ${RUBY_S} 2>/dev/null)/.git || die "Inserting .git/ for tests"
	fi
}
