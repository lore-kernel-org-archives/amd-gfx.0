Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2FA606A32D
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Nov 2026 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RLaeR/Fb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A07F10E5FA;
	Sun, 22 Nov 2026 20:51:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EE010E5FA
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2026 20:51:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C4F6C601C1;
 Sun, 22 Nov 2026 20:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645471F000C6;
 Sun, 22 Nov 2026 20:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795380683;
 bh=02MMMknXi2/dJCHQ5MsxSMUKfyusS6BOWjGv1thFtjw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=RLaeR/Fbozg9REM77ofGNsIdu6lHfbG6InIH9bNvWF2SE9bmXzVV5cV+eRaAFoKj8
 YcQBnLEurbCYGbwD3jMneSmfna03xXB/O8Xbyjk35I049agSyZHysc0AYC5+bkVzTp
 2EQkUlJgL7rrOKKlVJciD4wwEjLtRJevSpLnNKOqZ7f5Z9/tRqfOynNZAQnKdT21ZT
 Jc02IpHLnlws/ai8xB3NuVz4hyKwN5kIicUzBdhyz7fhMEMT2/SuGpH43J0xTOcsdu
 F5hQLg5yaZBIHMs5G4nIjgS4dxVpuCGcW4wGPtN3Csn/m5IoswUr6RNIbg2hqmWQk8
 uQVE9oIdKqO1A==
Message-ID: <sashiko-outbox-228336@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] drm/amdkfd: Enable HMM device-private THP
 migration in KFD SVM driver
To: Xiaogang.Chen <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261122202653.274580-4-xiaogang.chen@amd.com>
References: <20261122202653.274580-1-xiaogang.chen@amd.com>
 <20261122202653.274580-4-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 20:51:23 +0000
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] drm/amdkfd: broken out_oom cleanup and THP DMA unmap in
  svm_migrate_copy_to_ram()
- [High] drm/amdkfd: svm_migrate_vram_busy() races with compound folio
  teardown
- [Medium] drm/amdkfd: uninitialized tail VRAM offsets in
  svm_migrate_copy_to_vram()
- [Medium] drm/amdkfd: CPU PMD fault 4K fallback in
  svm_migrate_copy_to_ram() fails folio split
--

commit 0bbf4e6ec6f1a6c7fb1fece90e6a6372e1d80249
Author: Xiaogang Chen <xiaogang.chen@amd.com>

drm/amdkfd: Enable HMM device-private THP migration in KFD SVM driver

This commit enables compound THP migration for device-private SVM ranges by
setting MIGRATE_VMA_SELECT_COMPOUND when the migration window is at least
SVM_HPAGE_PMD_NR pages and handling MIGRATE_PFN_COMPOUND entries in the
RAM-to-VRAM and VRAM-to-RAM copy paths.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 11cda92b88783..aeb74d812c6c8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -340,6 +340,153 @@ static unsigned long svm_migrate_successful_pages(s=
truct migrate_vma *migrate)
>  	return mpages;
>  }
> =20
> +/*
> + * A reused svm_bo VRAM page may still be held by someone else, ex:
> + * (do_swap_page -> svm_migrate_to_ram). Migrating to VRAM re-initializes
> + * the page and resets its refcount, so the other's put_page() would
> + * free it mid-migration. Report whether any of the @nr VRAM pages start=
ing
> + * at page offset @m of @cursor is still referenced. @cursor is a copy, =
so
> + * the range may cross VRAM blocks without moving the caller's cursor.
> + *
> + * Check the folio, not the page: a tail page of a live device THP always
> + * has a zero refcount while its folio is held.
> + */
> +static bool
> +svm_migrate_vram_busy(struct amdgpu_device *adev,
> +		      struct amdgpu_res_cursor cursor, u64 m, u64 nr)
> +{
> +	while (nr) {
> +		u64 chunk =3D cursor.size >> PAGE_SHIFT;
> +		struct page *page;
> +
> +		if (m >=3D chunk) {
> +			if (cursor.remaining <=3D cursor.size)
> +				return false;
> +			amdgpu_res_next(&cursor, cursor.size);
> +			m -=3D chunk;
> +			continue;
> +		}
> +
> +		page =3D pfn_to_page(svm_migrate_addr_to_pfn(adev,
> +					cursor.start + (m << PAGE_SHIFT)));
> +		if (folio_ref_count(page_folio(page)))
> +			return true;
> +		m++;
> +		nr--;
> +	}
> +
> +	return false;
> +}

[Severity: High]
Can svm_migrate_vram_busy() return false while a previous compound device
folio on the same svm_bo is still being torn down in
svm_migrate_folio_free()?

When a CPU fault finishes svm_migrate_to_ram() and drops its reference outs=
ide
prange->migrate_mutex, folio_put_testzero() zeroes the folio refcount before
svm_migrate_folio_free() clears the compound pages and drops the svm_bo
reference:

CPU0                                  CPU1
do_huge_pmd_device_private()
  svm_migrate_to_ram()
    ...
    mutex_unlock(&prange->migrate_mutex)
  folio_put(folio)
    folio_put_testzero(folio)
    /* refcount is now 0 */
                                      svm_migrate_to_vram()
                                        /* reuses prange->svm_bo */
                                        svm_migrate_copy_to_vram()
                                          svm_migrate_vram_busy() -> false
                                          svm_migrate_get_vram_page(..., or=
der)
                                            zone_device_folio_init()
    free_zone_device_folio()
      svm_migrate_folio_free()
        svm_migrate_clear_compound_pages()
          /* tail pages have page_count =3D=3D 0 */
          new_folio->pgmap =3D pgmap;  <-- corrupts live compound tail pages

Because svm_migrate_clear_compound_pages() only skips pages with a non-zero
page_count(page), and all tail pages of the newly initialized compound folio
have a page count of 0, the teardown loop wipes the new folio's compound
order, _nr_pages, and tail page compound_head pointers.

[ ... ]

> @@ -363,69 +510,251 @@ svm_migrate_copy_to_vram(struct kfd_node *node, st=
ruct svm_range *prange,
> =20
>  	amdgpu_res_first(prange->ttm_res, ttm_res_offset,
>  			 npages << PAGE_SHIFT, &cursor);

[ ... ]

> +		if (thp_dst) {
> +			dst[i] =3D cursor.start + (m << PAGE_SHIFT);
> +			svm_migrate_get_vram_page(prange, cur_dst_pfn,
> +						  SVM_HPAGE_PMD_ORDER);
> +
> +			migrate->dst[i] =3D migrate_pfn(cur_dst_pfn) |
> +					  MIGRATE_PFN_COMPOUND;
> +
> +			for (l =3D 1; l < k; l++)
> +				migrate->dst[i + l] =3D 0;
> +
> +			mpages++;

[ ... ]

> +				/* get dma address for following SVM_HPAGE_PMD_NR-1 pages
> +				 * since src pages are continuous their dma addresses
> +				 * are continuous too.
> +				 */
> +				for (l =3D 1; l < k; l++)
> +					src[i + l] =3D src[i] + l*PAGE_SIZE;
> +
> +				/* migrate the SVM_HPAGE_PMD_NR pages above */
> +				r =3D svm_migrate_copy_memory_gart(
> +						adev, src + i,
> +						dst + i, SVM_HPAGE_PMD_NR,
> +						FROM_RAM_TO_VRAM,
> +						mfence);

[Severity: Medium]
Does the thp_dst path leave dst[i + 1 .. i + k - 1] as 0 before calling
svm_migrate_copy_memory_gart()?

svm_migrate_copy_memory_gart() splits transfers larger than GTT_MAX_PAGES
(4 MiB) and advances vram +=3D size on each chunk, dereferencing *vram for =
the
destination VRAM offset.  On architectures supported by CONFIG_HSA_AMD where
HPAGE_PMD_SIZE exceeds 4 MiB (such as arm64, ppc64, or loongarch with larger
base page sizes), every chunk after the first 4 MiB reads *vram =3D=3D 0 an=
d DMA
copies the remainder of the THP to VRAM offset 0.

[ ... ]

> @@ -762,7 +1155,58 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev,=
 struct svm_range *prange,

[ ... ]

> +			/*
> +			 * No THP destination (allocation failed or THP is
> +			 * disabled for the VMA): migrate the whole folio as
> +			 * SVM_HPAGE_PMD_NR 4K pages so migrate_vma_pages() finds
> +			 * a page in every slot after it splits the source.
> +			 */
> +			if (!dpage) {
> +				r =3D svm_migrate_compound_to_4k_ram(adev, migrate,
> +								   mfence, dst,
> +								   src, i, addr);
> +				if (r)
> +					goto out_oom;
> +				continue;
> +			}
> +		} else {
> +			k =3D 1;
> +			dpage =3D svm_migrate_get_sys_page(migrate->vma, addr, 0);
> +		}
> +
>  		if (!dpage) {
>  			pr_debug("failed get page svms 0x%p [0x%lx 0x%lx]\n",
>  				 prange->svms, prange->start, prange->last);
> @@ -770,7 +1214,7 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, =
struct svm_range *prange,
>  			goto out_oom;
>  		}
> =20
> -		dst[i] =3D dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_BIDIRECTIONAL);
> +		dst[i] =3D dma_map_page(dev, dpage, 0, PAGE_SIZE*k, DMA_BIDIRECTIONAL);
>  		r =3D dma_mapping_error(dev, dst[i]);
>  		if (r) {
>  			dev_err(adev->dev, "%s: fail %d dma_map_page\n", __func__, r);
> @@ -778,13 +1222,40 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev=
, struct svm_range *prange,
>  			goto out_oom;
>  		}
> =20
> -		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
> -				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
> -
>  		migrate->dst[i] =3D migrate_pfn(page_to_pfn(dpage));
> -
>  		dpage =3D NULL;
> -		j++;
> +
> +		if (k > 1) {
> +			migrate->dst[i] |=3D MIGRATE_PFN_COMPOUND;
> +
> +			for (l =3D 1; l < k; l++) {
> +
> +				src[i + l] =3D src[i] + l*PAGE_SIZE;
> +				dst[i + l] =3D dst[i] + l*PAGE_SIZE;
> +				migrate->dst[i + l] =3D 0;
> +			}
> +
> +			/* migrate the SVM_HPAGE_PMD_NR pages above
> +			 * the migration is for 2MB THP
> +			 */
> +			r =3D svm_migrate_copy_memory_gart(
> +						adev, dst + i,
> +						src + i, SVM_HPAGE_PMD_NR,
> +						FROM_VRAM_TO_RAM,
> +						mfence);
> +
> +			/* mark head page dma mapping as THP, tail pages dma addr
> +			 * are set to 0 for following dma_unmap
> +			 */
> +			dst[i] |=3D SVM_RANGE_DMA_THP;
> +			for (l =3D 1; l < k; l++)
> +				dst[i + l] =3D 0;
> +
> +			if (r)
> +				goto out_oom;

[Severity: High]
As reported by Philip Yang on v3 [1], does jumping to out_oom here or from =
the
svm_migrate_compound_to_4k_ram() fallback leave migrate->dst[i .. i + k - 1]
populated?

In both paths dpage is already NULL and i has not been advanced yet, so the
while (i--) cleanup loop in out_oom only visits indices 0 .. i - 1:

drivers/gpu/drm/amd/amdkfd/kfd_migrate.c:svm_migrate_copy_to_ram() {
    ...
		/* release previous allocated sys pages and unmap dma address */
		while (i--) {

			if (dst[i]) {
				dma_unmap_page(dev, dst[i], PAGE_SIZE,
					       DMA_BIDIRECTIONAL);
				dst[i] =3D 0;
			}
    ...
}

Because svm_migrate_vma_to_ram() still calls migrate_vma_pages() and
migrate_vma_finalize() after svm_migrate_copy_to_ram() fails, any pages left
in migrate->dst[i .. i + SVM_HPAGE_PMD_NR - 1] are installed into the proce=
ss
page tables without valid copied contents.  In addition, if an earlier
iteration mapped a 2MB THP and set SVM_RANGE_DMA_THP on dst[idx], the out_o=
om
loop passes the untagged address with SVM_RANGE_DMA_THP still set and size
PAGE_SIZE (instead of PAGE_SIZE * SVM_HPAGE_PMD_NR) to dma_unmap_page().

[ ... ]

> @@ -866,6 +1340,10 @@ svm_migrate_vma_to_ram(struct kfd_node *node, struc=
t svm_range *prange,
>  	else
>  		migrate.flags =3D MIGRATE_VMA_SELECT_DEVICE_PRIVATE;
> =20
> +	if (SVM_THP_ENABLED && is_private_device &&
> +	    ((end - start) >> PAGE_SHIFT) >=3D SVM_HPAGE_PMD_NR)
> +		migrate.flags =3D migrate.flags | MIGRATE_VMA_SELECT_COMPOUND;

[Severity: Medium]
When a CPU huge-PMD fault (do_huge_pmd_device_private() ->
svm_migrate_to_ram()) sets migrate.fault_page and falls back to 4K system
pages in svm_migrate_compound_to_4k_ram(), won't migrate_vma_pages() always
fail to split the compound source folio?

do_huge_pmd_device_private() holds an extra reference on the faulting folio,
and migrate_vma_collect_huge_pmd() takes another reference when collecting =
it
with MIGRATE_PFN_COMPOUND.  When migrate->dst[i] is populated with 4K pages
instead of MIGRATE_PFN_COMPOUND, migrate_vma_split_unmapped_folio() calls
folio_split_unmapped(), which requires folio_ref_count(folio) =3D=3D 1 and =
fails
with -EAGAIN, discarding all 512 allocated and SDMA-copied 4K pages.

[1] https://lore.kernel.org/r/ecc35307-3332-4bee-bdd9-db66948caac9@amd.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122202653.2745=
80-1-xiaogang.chen@amd.com?part=3D3
