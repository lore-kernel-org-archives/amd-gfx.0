From: Jason Gunthorpe <jgg@mellanox.com>
Subject: [GIT PULL] Please pull hmm changes
Date: Tue, 30 Jul 2019 11:58:37 +0000
Message-ID: <20190730115831.GA15720@ziepe.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Locking fix for nouveau's use of HMM

This small series was posted by Christoph before the merge window, but didn't
make it in time for the PR. It fixes various locking errors in the nouveau
driver's use of the hmm_range_* functions.

The diffstat is a bit big as Christoph did a comprehensive job to move the
obsolete API from the core header and into the driver before fixing its flow,
but the risk of regression from this code motion is low.

I don't intend to often send -rc patches for hmm, but this is entangled with
other changes already, so it is simpler to keep it on the hmm git branch.

Thanks,
Jason

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git tags/for-linus-hmm

for you to fetch changes up to de4ee728465f7c0c29241550e083139b2ce9159c:

  nouveau: unlock mmap_sem on all errors from nouveau_range_fault (2019-07-25 16:14:40 -0300)

----------------------------------------------------------------
HMM patches for 5.3-rc

Fix the locking around nouveau's use of the hmm_range_* APIs. It works
correctly in the success case, but many of the the edge cases have missing
unlocks or double unlocks.

----------------------------------------------------------------
Christoph Hellwig (4):
      mm/hmm: always return EBUSY for invalid ranges in hmm_range_{fault,snapshot}
      mm/hmm: move hmm_vma_range_done and hmm_vma_fault to nouveau
      nouveau: remove the block parameter to nouveau_range_fault
      nouveau: unlock mmap_sem on all errors from nouveau_range_fault

 Documentation/vm/hmm.rst              |  2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c | 47 ++++++++++++++++++++++++++++--
 include/linux/hmm.h                   | 54 -----------------------------------
 mm/hmm.c                              | 10 +++----
 4 files changed, 49 insertions(+), 64 deletions(-)

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfB7FMLh+8QxL+6i3OG33FX4gmxoFAl1AMOIACgkQOG33FX4g
mxoQ2g//RnLjfumNrH3tMwS8UkYgAoWVh6NGyQ7EjUPT2fvHlfo3dMqzUNK9h+wN
k2MKDTSZbFVhJQ5scU9KbhzGBXih4+DLnW1bpN1k/6nfZ6EXxRJakmcEz+LE53Pn
ylcuBXU9SLf733j+uwy42BQhkL7/Ykk+vt/aToWEyuTIXsR7zkTPVd7XH4JcHKi6
Lsf+zGtBCsIsh27T7uyyyOI52XwcY8Zm6LvfIKdOLczPRB8SzQ3yyMHjG42L7/ui
VGDvoU+4pMGQmBg2anE49/xsxDrGWeVYgkcsQcw2PhlthXw3VwmWBj83chLU9+qt
Vc1jofLj4Srgv+mXgFjmu0j1yJ84qoJaBb1YPzxDWoJGHpXyhLWKc7U55lvvotDD
EJCOV6nE+VMGo/Zu96O+LI4IW05afPxJstNj3XQg72lF4WaRGOS8q3OhmGqntaNh
ajQNYrcUDODmwepiOpDPf28K2cybwdINqrNKFw2e9eybnBxE4VEoF5vjUIlQmYoj
BNZAORxOyrnNHr8w3q46pK5OPinjXhNnKXJFrcqldZKKonhRCTIb+vu22CLD0QCC
DjmflIaGbHx8Q8yB+9B5pFt3j/a9lMzYgfN61Kh1qCOAiDWDXBjJ/c/mA6++iwgL
08F+Xltp9NoE46VUbpij+5xq6eaXrHWb7v8QyRZJt04KHziebmM=
=6E82
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
