From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
Date: Wed, 7 Aug 2019 17:45:53 +0000
Message-ID: <20190807174548.GJ1571@mellanox.com>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-5-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806160554.14046-5-hch@lst.de>
Content-Language: en-US
Content-ID: <1920BF82988BC542A48F1F6D6A0BA986@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>
Cc: =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 06, 2019 at 07:05:42PM +0300, Christoph Hellwig wrote:
> There is only a single place where the pgmap is passed over a function
> call, so replace it with local variables in the places where we deal
> with the pgmap.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
>  mm/hmm.c | 62 ++++++++++++++++++++++++--------------------------------
>  1 file changed, 27 insertions(+), 35 deletions(-)
>=20
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 9a908902e4cc..d66fa29b42e0 100644
> +++ b/mm/hmm.c
> @@ -278,7 +278,6 @@ EXPORT_SYMBOL(hmm_mirror_unregister);
> =20
>  struct hmm_vma_walk {
>  	struct hmm_range	*range;
> -	struct dev_pagemap	*pgmap;
>  	unsigned long		last;
>  	unsigned int		flags;
>  };
> @@ -475,6 +474,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
>  	struct hmm_range *range =3D hmm_vma_walk->range;
> +	struct dev_pagemap *pgmap =3D NULL;
>  	unsigned long pfn, npages, i;
>  	bool fault, write_fault;
>  	uint64_t cpu_flags;
> @@ -490,17 +490,14 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
>  	pfn =3D pmd_pfn(pmd) + pte_index(addr);
>  	for (i =3D 0; addr < end; addr +=3D PAGE_SIZE, i++, pfn++) {
>  		if (pmd_devmap(pmd)) {
> -			hmm_vma_walk->pgmap =3D get_dev_pagemap(pfn,
> -					      hmm_vma_walk->pgmap);
> -			if (unlikely(!hmm_vma_walk->pgmap))
> +			pgmap =3D get_dev_pagemap(pfn, pgmap);
> +			if (unlikely(!pgmap))
>  				return -EBUSY;

Unrelated to this patch, but what is the point of getting checking
that the pgmap exists for the page and then immediately releasing it?
This code has this pattern in several places.

It feels racy

>  		}
>  		pfns[i] =3D hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
>  	}
> -	if (hmm_vma_walk->pgmap) {
> -		put_dev_pagemap(hmm_vma_walk->pgmap);
> -		hmm_vma_walk->pgmap =3D NULL;

Putting the value in the hmm_vma_walk would have made some sense to me
if the pgmap was not set to NULL all over the place. Then the most
xa_loads would be eliminated, as I would expect the pgmap tends to be
mostly uniform for these use cases.

Is there some reason the pgmap ref can't be held across
faulting/sleeping? ie like below.

Anyhow, I looked over this pretty carefully and the change looks
functionally OK, I just don't know why the code is like this in the
first place.

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

diff --git a/mm/hmm.c b/mm/hmm.c
index 9a908902e4cc38..4e30128c23a505 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -497,10 +497,6 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 		}
 		pfns[i] =3D hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
 	}
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap =3D NULL;
-	}
 	hmm_vma_walk->last =3D end;
 	return 0;
 #else
@@ -604,10 +600,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, un=
signed long addr,
 	return 0;
=20
 fault:
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap =3D NULL;
-	}
 	pte_unmap(ptep);
 	/* Fault any virtual address we were asked to fault */
 	return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
@@ -690,16 +682,6 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 			return r;
 		}
 	}
-	if (hmm_vma_walk->pgmap) {
-		/*
-		 * We do put_dev_pagemap() here and not in hmm_vma_handle_pte()
-		 * so that we can leverage get_dev_pagemap() optimization which
-		 * will not re-take a reference on a pgmap if we already have
-		 * one.
-		 */
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap =3D NULL;
-	}
 	pte_unmap(ptep - 1);
=20
 	hmm_vma_walk->last =3D addr;
@@ -751,10 +733,6 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 			pfns[i] =3D hmm_device_entry_from_pfn(range, pfn) |
 				  cpu_flags;
 		}
-		if (hmm_vma_walk->pgmap) {
-			put_dev_pagemap(hmm_vma_walk->pgmap);
-			hmm_vma_walk->pgmap =3D NULL;
-		}
 		hmm_vma_walk->last =3D end;
 		return 0;
 	}
@@ -1026,6 +1004,14 @@ long hmm_range_fault(struct hmm_range *range, unsign=
ed int flags)
 			/* Keep trying while the range is valid. */
 		} while (ret =3D=3D -EBUSY && range->valid);
=20
+		/*
+		 * We do put_dev_pagemap() here so that we can leverage
+		 * get_dev_pagemap() optimization which will not re-take a
+		 * reference on a pgmap if we already have one.
+		 */
+		if (hmm_vma_walk->pgmap)
+			put_dev_pagemap(hmm_vma_walk->pgmap);
+
 		if (ret) {
 			unsigned long i;
=20
