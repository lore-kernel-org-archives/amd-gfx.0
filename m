From: Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH 2/4] mm/hmm: allow snapshot of the special zero page
Date: Wed, 11 Sep 2019 15:28:27 -0700
Message-ID: <20190911222829.28874-3-rcampbell@nvidia.com>
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

Allow hmm_range_fault() to return success (0) when the CPU pagetable
entry points to the special shared zero page.
The caller can then handle the zero page by possibly clearing device
private memory instead of DMAing a zero page.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 06041d4399ff..7217912bef13 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -532,7 +532,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, uns=
igned long addr,
 			return -EBUSY;
 	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
 		*pfn =3D range->values[HMM_PFN_SPECIAL];
-		return -EFAULT;
+		return is_zero_pfn(pte_pfn(pte)) ? 0 : -EFAULT;
 	}
=20
 	*pfn =3D hmm_device_entry_from_pfn(range, pte_pfn(pte)) | cpu_flags;
--=20
2.20.1
