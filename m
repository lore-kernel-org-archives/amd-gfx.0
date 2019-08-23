From: Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 1/2] mm/hmm: hmm_range_fault() NULL pointer bug
Date: Fri, 23 Aug 2019 15:17:52 -0700
Message-ID: <20190823221753.2514-2-rcampbell@nvidia.com>
References: <20190823221753.2514-1-rcampbell@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190823221753.2514-1-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Ralph Campbell <rcampbell@nvidia.com>
List-Id: amd-gfx.lists.freedesktop.org

Although hmm_range_fault() calls find_vma() to make sure that a vma exists
before calling walk_page_range(), hmm_vma_walk_hole() can still be called
with walk->vma =3D=3D NULL if the start and end address are not contained
within the vma range.

 hmm_range_fault() /* calls find_vma() but no range check */
  walk_page_range() /* calls find_vma(), sets walk->vma =3D NULL */
   __walk_page_range()
    walk_pgd_range()
     walk_p4d_range()
      walk_pud_range()
       hmm_vma_walk_hole()
        hmm_vma_walk_hole_()
         hmm_vma_do_fault()
          handle_mm_fault(vma=3D0)

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 mm/hmm.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index fc05c8fe78b4..29371485fe94 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -229,6 +229,9 @@ static int hmm_vma_do_fault(struct mm_walk *walk, unsig=
ned long addr,
 	struct vm_area_struct *vma =3D walk->vma;
 	vm_fault_t ret;
=20
+	if (!vma)
+		goto err;
+
 	if (hmm_vma_walk->flags & HMM_FAULT_ALLOW_RETRY)
 		flags |=3D FAULT_FLAG_ALLOW_RETRY;
 	if (write_fault)
@@ -239,12 +242,14 @@ static int hmm_vma_do_fault(struct mm_walk *walk, uns=
igned long addr,
 		/* Note, handle_mm_fault did up_read(&mm->mmap_sem)) */
 		return -EAGAIN;
 	}
-	if (ret & VM_FAULT_ERROR) {
-		*pfn =3D range->values[HMM_PFN_ERROR];
-		return -EFAULT;
-	}
+	if (ret & VM_FAULT_ERROR)
+		goto err;
=20
 	return -EBUSY;
+
+err:
+	*pfn =3D range->values[HMM_PFN_ERROR];
+	return -EFAULT;
 }
=20
 static int hmm_pfns_bad(unsigned long addr,
--=20
2.20.1
