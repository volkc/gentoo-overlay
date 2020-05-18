# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit acct-user

DESCRIPTION="User for SOLR"
ACCT_USER_ID=
ACCT_USER_HOME=/var/lib/solr
ACCT_USER_HOME_OWNER=solr:solr
ACCT_USER_HOME_PERMS=00750
ACCT_USER_GROUPS=( solr )

acct-user_add_deps
