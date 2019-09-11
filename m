From: Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 0/4] HMM tests and minor fixes
Date: Wed, 11 Sep 2019 15:28:25 -0700
Message-ID: <20190911222829.28874-1-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Ralph Campbell <rcampbell@nvidia.com>
List-Id: amd-gfx.lists.freedesktop.org

These changes are based on Jason's latest hmm branch.
Patch 1 was previously posted here [1] but was dropped from the orginal
series. Hopefully, the tests will reduce concerns about edge conditions.
I'm sure more tests could be usefully added but I thought this was a good
starting point.

[1] https://lore.kernel.org/linux-mm/20190726005650.2566-6-rcampbell@nvidia=
.com/

Ralph Campbell (4):
  mm/hmm: make full use of walk_page_range()
  mm/hmm: allow snapshot of the special zero page
  mm/hmm: allow hmm_range_fault() of mmap(PROT_NONE)
  mm/hmm/test: add self tests for HMM

 MAINTAINERS                            |    3 +
 drivers/char/Kconfig                   |   11 +
 drivers/char/Makefile                  |    1 +
 drivers/char/hmm_dmirror.c             | 1504 ++++++++++++++++++++++++
 include/Kbuild                         |    1 +
 include/uapi/linux/hmm_dmirror.h       |   74 ++
 mm/hmm.c                               |  117 +-
 tools/testing/selftests/vm/.gitignore  |    1 +
 tools/testing/selftests/vm/Makefile    |    3 +
 tools/testing/selftests/vm/config      |    3 +
 tools/testing/selftests/vm/hmm-tests.c | 1304 ++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests |   16 +
 tools/testing/selftests/vm/test_hmm.sh |  105 ++
 13 files changed, 3079 insertions(+), 64 deletions(-)
 create mode 100644 drivers/char/hmm_dmirror.c
 create mode 100644 include/uapi/linux/hmm_dmirror.h
 create mode 100644 tools/testing/selftests/vm/hmm-tests.c
 create mode 100755 tools/testing/selftests/vm/test_hmm.sh

--=20
2.20.1
