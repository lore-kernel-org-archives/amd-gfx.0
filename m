From: Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 3/4] mm/hmm: allow hmm_range_fault() of mmap(PROT_NONE)
Date: Wed, 11 Sep 2019 15:28:28 -0700
Message-ID: <20190911222829.28874-4-rcampbell@nvidia.com>
References: <20190911222829.28874-1-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190911222829.28874-1-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Ralph Campbell <rcampbell@nvidia.com>
List-Id: amd-gfx.lists.freedesktop.org

Allow hmm_range_fault() to return success (0) when the range has no access
(!(vma->vm_flags & VM_READ)). The range->pfns[] array will be filled with
range->values[HMM_PFN_NONE] in this case.
This allows the caller to get a snapshot of a range without having to
lookup the vma before calling hmm_range_fault().
If the call to hmm_range_fault() is not a snapshot, the caller can still
check that pfns have the desired access permissions.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 7217912bef13..16c834e5d1c0 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -795,7 +795,9 @@ static int hmm_vma_walk_test(unsigned long start,
 	 */
 	if (!(vma->vm_flags & VM_READ)) {
 		(void) hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
-		return -EPERM;
+
+		/* Skip this vma and continue processing the next vma. */
+		return 1;
 	}
=20
 	return 0;
--=20
2.20.1
