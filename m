From: Jason Gunthorpe <jgg@mellanox.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
Date: Wed, 14 Aug 2019 13:27:50 +0000
Message-ID: <20190814132746.GE13756@mellanox.com>
References: <20190806160554.14046-1-hch@lst.de>
 <20190806160554.14046-5-hch@lst.de> <20190807174548.GJ1571@mellanox.com>
 <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com>
 <20190808065933.GA29382@lst.de>
 <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
 <20190814073854.GA27249@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190814073854.GA27249@lst.de>
Content-Language: en-US
Content-ID: <EF42566A523CE142A2EFF155B9958285@eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Dan Williams <dan.j.williams@intel.com>, =?iso-8859-1?Q?J=E9r=F4me_Glisse?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Aug 14, 2019 at 09:38:54AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 13, 2019 at 06:36:33PM -0700, Dan Williams wrote:
> > Section alignment constraints somewhat save us here. The only example
> > I can think of a PMD not containing a uniform pgmap association for
> > each pte is the case when the pgmap overlaps normal dram, i.e. shares
> > the same 'struct memory_section' for a given span. Otherwise, distinct
> > pgmaps arrange to manage their own exclusive sections (and now
> > subsections as of v5.3). Otherwise the implementation could not
> > guarantee different mapping lifetimes.
> >=20
> > That said, this seems to want a better mechanism to determine "pfn is
> > ZONE_DEVICE".
>=20
> So I guess this patch is fine for now, and once you provide a better
> mechanism we can switch over to it?

What about the version I sent to just get rid of all the strange
put_dev_pagemaps while scanning? Odds are good we will work with only
a single pagemap, so it makes some sense to cache it once we find it?

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
