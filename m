Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56489606A31A
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Nov 2026 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mEuTOLlE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E463210E299;
	Sun, 22 Nov 2026 20:50:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8201810E299
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2026 20:50:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 28AA242D5F;
 Sun, 22 Nov 2026 20:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47951F000C6;
 Sun, 22 Nov 2026 20:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795380599;
 bh=8blHTRKgMYCAQ8TrliQAnuvkfz38ugV252d6TAIT7x8=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=mEuTOLlE8SnyQh+lWJCWbgOXrEuKHvCDYcHguO+qq0ZkJS4XCLaCQr48XdwlboDcu
 2u6pSvGk8Au3EDva5yeUlyi80e0Z6AxrawUd8N8hvT5xz1SqNkDTOFQjdc6wzuJXhg
 VchgFXFpgeYtW1xYTL2B6A6GKTf9qpVcB0AilqLoxl/+D3HENG47nMVUn4aBaQ/8nl
 IvYnpEXMBpsjQJIp4AwctgW9SZ2vUaNpqEIlyZ1zbFKWacIPOV+cAVU+4+gswJfE+G
 xZgFeffGaqZTQLb0tg2w2xqmzpx6f6TyGhmrK33+B6mQqUeZHaOtoQL1DXJKeX9Dqz
 MH+qh5Qxfi04w==
Message-ID: <sashiko-outbox-228335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] drm/amdkfd: Add awareness of THP of device and
 system RAM in kfd svm driver
To: Xiaogang.Chen <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261122202653.274580-2-xiaogang.chen@amd.com>
References: <20261122202653.274580-1-xiaogang.chen@amd.com>
 <20261122202653.274580-2-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 20:49:59 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/amdkfd: race and tail refcount bug in
  svm_migrate_clear_compound_pages()
- [Medium] drm/amdkfd: svm_migrate_get_vram_page() calls page_pgmap() on
  stale tail page
- [Medium] drm/amdkfd: VRAM eviction thrashing and defeated fallback in
  svm_range_vram_node_new()
--

commit 19748270f4f63cf5e57c0c13c312409968fa180c
Author: Xiaogang Chen <xiaogang.chen@amd.com>

drm/amdkfd: Add awareness of THP of device and system RAM in kfd svm driver

This commit extends KFD SVM migration and buffer allocation helpers to
support PMD-sized compound folios for device-private VRAM and system RAM.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 1eb92ac6eb058..5ead98a604b1e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -218,17 +218,45 @@ svm_migrate_addr_to_pfn(struct amdgpu_device *adev,=
 unsigned long addr)
>  	return (addr + adev->kfd.pgmap.range.start) >> PAGE_SHIFT;
>  }
> =20
> +/*
> + * TTM can reuse a 2MB VRAM block that was previously a device THP.
> + * Reset unused pages so the next 4K init does not see leftover head/tai=
l.
> + */
> +static void svm_migrate_clear_compound_pages(struct page *page, unsigned=
 int nr,
> +					      struct dev_pagemap *pgmap)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < nr; i++, page++) {
> +		struct folio *new_folio =3D (struct folio *)page;
> +
> +		if (page_count(page))
> +			continue;
> +
> +		page->flags.f &=3D ~0xffUL;
> +#ifdef NR_PAGES_IN_LARGE_FOLIO
> +		((struct folio *)(page - 1))->_nr_pages =3D 0;
> +#endif
> +		new_folio->mapping =3D NULL;
> +		new_folio->pgmap =3D pgmap;
> +		new_folio->share =3D 0;
> +		page->zone_device_data =3D NULL;
> +	}
> +}

[Severity: High]
Can svm_migrate_clear_compound_pages() skip clearing tail pages or corrupt
newly reallocated VRAM pages?

During a CPU fault on a device-private folio, do_huge_pmd_device_private()
and do_swap_page() hold an extra folio reference across
pgmap->ops->migrate_to_ram() and drop it via folio_put() after
svm_migrate_to_ram() has already released prange->migrate_mutex.  Because
folio_put_testzero() decrements the folio refcount to 0 before calling
free_zone_device_folio() -> svm_migrate_folio_free(), a concurrent
migration reusing the same svm_bo can reallocate those VRAM pages while
svm_migrate_clear_compound_pages() is running:

CPU0                                  CPU1
do_huge_pmd_device_private()
  folio_get(folio)
  svm_migrate_to_ram()
    ...
    mutex_unlock(&prange->migrate_mutex)
  folio_put(folio)
    folio_put_testzero(folio)
                                      svm_migrate_ram_to_vram()
                                        svm_migrate_copy_to_vram()
                                          page_ref_count(page) =3D=3D 0
                                          svm_migrate_get_vram_page()
                                            zone_device_folio_init()
    free_zone_device_folio()
      svm_migrate_folio_free()
        svm_migrate_clear_compound_pages()
          page_count(page) =3D=3D 0
          page->flags.f &=3D ~0xffUL
          page->zone_device_data =3D NULL  <-- clobbers reallocated folio

Even without the TOCTOU race between page_count(page) and
set_page_count(page, 1) inside zone_device_page_init(), page_count(page)
calls folio_ref_count(page_folio(page)) before new_folio->pgmap =3D pgmap
clears compound_head on tail pages.  If page[0] has already been
reallocated as a 4K page (setting page[0]._refcount =3D 1), page_folio() on
each remaining tail page (i =3D 1 .. nr - 1) follows the leftover
compound_head back to page[0], sees page_count() =3D=3D 1, and skips cleari=
ng
all 511 unused tail pages.

In addition, in svm_migrate_copy_to_vram(), page_ref_count() reads
page->_refcount directly, which is 0 on tail pages even before the head
folio's final reference is put.  Reinitializing tail page 1 as a 4K page
wipes folio_order() and folio->_nr_pages on the still-live compound folio
before folio_put() runs, so free_zone_device_folio() leaks 512 pgmap->ref
references and hangs memunmap_pages() on device teardown.

>  static void
> -svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn)
> +svm_migrate_get_vram_page(struct svm_range *prange, unsigned long pfn,
> +			   int order)
>  {
> -	struct page *page;
> +	struct page *page =3D pfn_to_page(pfn);
> =20
> -	page =3D pfn_to_page(pfn);
> -	svm_range_bo_ref(prange->svm_bo);
> +	/* Init this pfn, not page_folio() =E2=80=94 that follows a leftover ta=
il to the old head. */
> +	zone_device_folio_init((struct folio *)page, page_pgmap(page), order);

[Severity: Medium]
Does page_pgmap(page) still call page_folio(page) on a leftover tail page
here?

include/linux/mmzone.h:page_pgmap() {
	VM_WARN_ON_ONCE_PAGE(!memdesc_is_zone_device(&page->flags), page);
	return page_folio(page)->pgmap;
}

Because page_pgmap(page) runs before zone_device_folio_init() clears any
stale compound_head on page, it still follows a leftover tail pointer to
the old head page.  If that old head page has since become a tail page of
another compound folio, its pgmap union slot holds an odd compound_head
value, passing a corrupted pgmap pointer into zone_device_page_init() and
percpu_ref_tryget_many().  Passing &prange->svm_bo->node->adev->kfd.pgmap
directly avoids reading page_pgmap(page) before the page is initialized.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index a571fda5c713a..fc739af454edf 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
[ ... ]
> @@ -579,10 +588,20 @@ svm_range_vram_node_new(struct kfd_node *node, stru=
ct svm_range *prange,
>  	}
> =20
>  	memset(&bp, 0, sizeof(bp));
> +	/*
> +	 * Keep bp.size equal to the prange size so it matches the
> +	 * amdgpu_amdkfd_reserve_mem_limit() reservation made by the caller.
> +	 * A 2MB byte_align makes the VRAM manager allocate 2MB-aligned 2MB
> +	 * buddy blocks and trim only the last one to the requested size, so
> +	 * every full 2MB chunk can still back a device THP.
> +	 */
>  	bp.size =3D prange->npages * PAGE_SIZE;
> +	if (SVM_THP_ENABLED && prange->npages >=3D SVM_HPAGE_PMD_NR)
> +		bp.byte_align =3D SVM_HPAGE_PMD_SIZE;
> +	else
> +		bp.byte_align =3D PAGE_SIZE;
>  	bp.bo_ptr_size =3D sizeof(struct svm_range_bo);
>  	bp.destroy =3D svm_range_bo_destroy;
> -	bp.byte_align =3D PAGE_SIZE;
>  	bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
>  	bp.flags =3D AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
>  	bp.flags |=3D clear ? AMDGPU_GEM_CREATE_VRAM_CLEARED : 0;
> @@ -594,9 +613,16 @@ svm_range_vram_node_new(struct kfd_node *node, struc=
t svm_range *prange,
> =20
>  	r =3D amdgpu_bo_create(node->adev, &bp, &bo);
>  	if (r) {
> -		pr_debug("failed %d to create bo\n", r);
> -		mmput(mm);
> -		goto create_bo_failed;
> +		if (bp.byte_align =3D=3D SVM_HPAGE_PMD_SIZE) {
> +			/* fall back PAGE_SIZE granularity */
> +			bp.byte_align =3D PAGE_SIZE;
> +			r =3D amdgpu_bo_create(node->adev, &bp, &bo);
> +		}
> +		if (r) {
> +			pr_debug("failed %d to create bo\n", r);
> +			mmput(mm);
> +			goto create_bo_failed;
> +		}
>  	}

[Severity: Medium]
Does the first amdgpu_bo_create() call trigger TTM VRAM LRU eviction when
2MB blocks are fragmented, and is the PAGE_SIZE fallback a no-op when
bp.size is a multiple of 2MB?

When bp.byte_align is SVM_HPAGE_PMD_SIZE, amdgpu_vram_mgr_new() sets
min_block_size =3D 2MB and gpu_buddy_alloc_blocks() rounds the allocation up
to a 2MB multiple before trimming the last block.  If VRAM has enough 4K
pages but no 2MB-contiguous blocks, ttm_bo_validate() does not return to
the fallback immediately; its second pass calls ttm_bo_evict_alloc() and
evicts other live VRAM BOs trying to coalesce 2MB blocks.

Furthermore, when bp.size is an exact multiple of 2MB, resetting
bp.byte_align =3D PAGE_SIZE in the fallback still leaves min_block_size at
2MB (pages_per_block defaults to HPAGE_PMD_NR):

drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:amdgpu_vram_mgr_new() {
    ...
		if (tbo->page_alignment)
			min_block_size =3D (u64)tbo->page_alignment << PAGE_SHIFT;
		else if ((size >=3D (u64)pages_per_block << PAGE_SHIFT) &&
			 !(size & (((u64)pages_per_block << PAGE_SHIFT) - 1)))
			min_block_size =3D (u64)pages_per_block << PAGE_SHIFT;
		else
			min_block_size =3D PAGE_SIZE;
    ...
}

Because tbo->page_alignment is 1 when bp.byte_align is PAGE_SIZE, wait -
actually when tbo->page_alignment is 0 or when size is a 2MB multiple, the
fallback does not relax the 2MB requirement or repeats the eviction scan.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122202653.2745=
80-1-xiaogang.chen@amd.com?part=3D1
