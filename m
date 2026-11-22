Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6935606A31A
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Nov 2026 20:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=niH7rBAT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AEE010E12B;
	Sun, 22 Nov 2026 20:42:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF76910E12B
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 Nov 2026 20:42:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E469B60141;
 Sun, 22 Nov 2026 20:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820641F000C6;
 Sun, 22 Nov 2026 20:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795380154;
 bh=KfHSW16j4ymKMUkeZmg8AqTson/HhDOyJeMqDgKTVQk=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=niH7rBAT8jyRNBs6SxfxTvzNUPJ+ShLTRXLNLD68crSQbIJA1cFw+20eHoOLqnn3l
 SJY2UlcKhMiMr1q6SIbQDT88jmwGHpmMJ0GNHtLm2WnSMUAVCjquQ7N2W+nt2zdBnR
 IyZzMAo0fDrQKvULDJchNtXOSUgyiwF8ORqn2aYMtlKPtZuUuYQEMJIcKnr5dFinzT
 jZBRjvVGJClJ+4mcR+TWQgzoatm6s/iVgdb+tPtQHPMuO/VF8iDuAJrSRR4CJVt3GN
 y/cys50bY5YfVaHt4FqSgzTnJ1SRlNHQGrN3UzLjm+HJQMghHwrd2mM2fQ8YEf638S
 INI+KbLA+GaWQ==
Message-ID: <sashiko-outbox-228334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] drm/amdkfd: Do not migrate partial THP memory at
 CPU/GPU page fault handler
To: Xiaogang.Chen <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261122202653.274580-3-xiaogang.chen@amd.com>
References: <20261122202653.274580-1-xiaogang.chen@amd.com>
 <20261122202653.274580-3-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 20:42:34 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/amdkfd: infinite CPU fault loop on split prange in
  svm_migrate_to_ram()
--

commit b149598769982ad1feb63c501a92a881118fdebd
Author: Xiaogang Chen <xiaogang.chen@amd.com>

drm/amdkfd: Do not migrate partial THP memory at CPU/GPU page fault handler

This commit adjusts the migration range size on CPU and GPU page faults so
that PMD-mapped THP folios fully covered by an svm_range are migrated at
folio order, while split ranges fall back to prange->granularity.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 5ead98a604b1e..11cda92b88783 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
[ ... ]
> @@ -1142,8 +1145,40 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fau=
lt *vmf)
>  	if (!prange->actual_loc)
>  		goto out_unlock_prange;
> =20
> -	/* Align migration range start and size to granularity size */
> -	size =3D 1UL << prange->granularity;
> +	order =3D folio_order(folio);
> +
> +	/*
> +	 * A PMD device-private fault always passes the folio head in
> +	 * vmf->page. If this prange still covers the whole folio, migrate
> +	 * at folio order so HMM can collect MIGRATE_PFN_COMPOUND.
> +	 *
> +	 * Do not want migrate partial THP device memory. If do HMM will split
> +	 * THP folio. If the compound folio has extra ref/pin the split will fa=
il,
> +	 * then skip migration, leave without page restore, then cpu keep retry.
> +	 *
> +	 * If the prange was split and no longer covers the PMD, do not call
> +	 * split_folio() here: it is not exported to modules. Walk only this
> +	 * prange and let migrate_vma_setup() split the PMD inside mm.
> +	 *
> +	 * If the fault address has PTE mapping device-private memory use
> +	 * prange->granularity to decide migration size.
> +	 */
> +	if (order && !vmf->pte) {
> +		unsigned long folio_start =3D ALIGN_DOWN(addr, 1UL << order);
> +		unsigned long folio_last =3D folio_start + (1UL << order) - 1;
> +
> +		if (prange->start > folio_start || prange->last < folio_last) {
> +			pr_debug("partial prange on device THP svms 0x%p prange [0x%lx 0x%lx]=
 folio [0x%lx 0x%lx]\n",
> +				 prange->svms, prange->start, prange->last,
> +				 folio_start, folio_last);
> +			size =3D 1UL << prange->granularity;
> +		} else {
> +			size =3D 1UL << max(prange->granularity, order);
> +		}
> +	} else {
> +		size =3D 1UL << prange->granularity;
> +	}
> +
>  	start =3D max(ALIGN_DOWN(addr, size), prange->start);
>  	last =3D min(ALIGN(addr + 1, size) - 1, prange->last);

[Severity: High]
Can a CPU fault on a PMD-mapped device-private folio enter an infinite
fault loop when prange has been split to a sub-PMD range?

On a PMD device-private fault, do_huge_pmd_device_private() holds an extra
reference on the fault folio across svm_migrate_to_ram().  When [start,
last] is clamped to a split prange smaller than the PMD,
migrate_vma_collect_huge_pmd() takes a second reference and falls back to
split_folio():

mm/migrate_device.c:migrate_vma_collect_huge_pmd() {
	...
	folio_get(folio);
	...
fallback:
	spin_unlock(ptl);
	if (!folio_test_large(folio))
		goto done;
	ret =3D split_folio(folio);
	if (fault_folio !=3D folio)
		folio_unlock(folio);
	folio_put(folio);
	if (ret)
		return migrate_vma_collect_skip(start, end, walk);
	...
}

Because two extra references are held on the folio, unmap_folio() inside
split_folio() fails the reference count check with -EAGAIN before
try_to_migrate() can split the PMD:

mm/huge_memory.c:unmap_folio() {
	...
	/* Racy check if we can split the page, before we split PMDs */
	if (folio_expected_ref_count(folio) !=3D folio_ref_count(folio) - 1)
		return -EAGAIN;
	...
}

migrate_vma_collect_huge_pmd() then skips the PMD without splitting it or
collecting any pages, and svm_migrate_to_ram() returns 0 with the
device-private PMD entry still in place, causing the CPU to fault on the
same instruction indefinitely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122202653.2745=
80-1-xiaogang.chen@amd.com?part=3D2
