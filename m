Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397660A260A
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 15:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EHlHJVbD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 458E710E807;
	Wed, 18 Nov 2026 15:22:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D352E10E807
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:22:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3E51413B2;
 Wed, 18 Nov 2026 15:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D721F000C5;
 Wed, 18 Nov 2026 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795015350;
 bh=h/+O5kTqtiXC3bzycasPBdDZnFlAHlDtxErkxoX4Jog=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=EHlHJVbDegLet8QAuloiVJ5U3d8Wg/2WnS4hkcD+LnoyOaPArck5H9Mc2bj3r1EGI
 CIvsd3MCa1g8wxw1MwnYvdvxeLZAtwPWhXrGOvZJiy+0TTyKp01MYrVIish+96cgDc
 cnGgbm42STYtMPGf561Xbx5ZDjxNB6oENfMU15U6KrsVI5ZDuAi7/lhY1ZsPkdIu9E
 Am9vsU4nom7+811soisZ4rNUPmRgo7LibUnD+DnE1MTqOwg/vWpjElTULxpeVc9t1A
 bqf208e9pg2BLIaopOg4p17c2WBEM1rOFqzocd4XsUygd/nmNx/CncpvjnYBP7fvrX
 Q2dEn4TfBMAGA==
Message-ID: <sashiko-outbox-221313@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/amdkfd: Fix a race issue at
 svm_migrate_copy_to_ram() error path
To: Xiaogang.Chen <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118151045.134908-1-xiaogang.chen@amd.com>
References: <20261118151045.134908-1-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:22:27 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] drm/amdkfd: redundant DMA unmap in svm_migrate_copy_to_ram()
  error path
- [Low] drm/amdkfd: missing Fixes trailer on svm_migrate_copy_to_ram()
  fix
--

commit 04e6170d8b5365de5f3b17fda44a17daca9153e9
Author: Xiaogang Chen <xiaogang.chen@amd.com>

> drm/amdkfd: Fix a race issue at svm_migrate_copy_to_ram() error path
>
> The destination pages were freed while SDMA copies queued earlier
> could still be writing into them, and while they were still DMA
> mapped. The mappings were only removed later by the caller's
> svm_range_dma_unmap_dev().
>
> With swiotlb, the BIDIRECTIONAL unmap copies the bounce buffer back into
> a page that may already be reused.
>
> With an IOMM, the GPU still has a valid bus address that points at a page
> now maybe owned by another user. Any SDMA write still in flight, corrupts
> that page.
>
> So, wait on the fence first, then dma unmap before release buffer.
>
> svm_range_dma_unmap_dev() sets each entry to 0 after unmapping it,
> so the caller's later svm_range_dma_unmap_dev call skips them.
>
> Not drop the fence there. *mfence still belongs to the caller. Later
> svm_migrate_copy_done() puts it and second wait there returns immediately.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

[Severity: Low]
Should this bug fix include Fixes tags for the commits that introduced and
updated the error cleanup path in svm_migrate_copy_to_ram()?

  Fixes: 48ff079b28d8 ("drm/amdkfd: HMM migrate vram to ram")
  Fixes: 960c4a8069bf ("drm/amdkfd: Fix error path at svm_migrate_copy_to_r=
am")

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 1eb92ac6eb058..481091ae30947 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -726,6 +726,18 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, =
struct svm_range *prange,
>  			put_page(dpage);
>  		}
> =20
> +		/*
> +		 * Copies queued before the failure may still be writing into
> +		 * the destination pages. Wait for the last SDMA fence (copies
> +		 * on the entity complete in order), then remove the device DMA
> +		 * mappings, before the pages go back to the allocator. The
> +		 * caller's svm_migrate_copy_done() still puts the fence, and
> +		 * its svm_range_dma_unmap_dev() skips the entries zeroed here.
> +		 */
> +		if (*mfence)
> +			dma_fence_wait(*mfence, false);
> +		svm_range_dma_unmap_dev(dev, dst, 0, npages);
> +
>  		/* release previous allocated sys pages and unmap dma address */
>  		while (i--) {

[Severity: Low]
This isn't a bug, but commit 960c4a8069bf ("drm/amdkfd: Fix error path at
svm_migrate_copy_to_ram") already added dma_unmap_page() and zeroed dst[i]
inside the while (i--) loop right below this:

drivers/gpu/drm/amd/amdkfd/kfd_migrate.c:svm_migrate_copy_to_ram() {
	...
		while (i--) {

			if (dst[i]) {
				dma_unmap_page(dev, dst[i], PAGE_SIZE,
					       DMA_BIDIRECTIONAL);
				dst[i] =3D 0;
			}
	...
}

Because dst is zero-initialized and dst[i] is cleared on dma_map_page()
failure before jumping to out_oom, only entries below i hold mappings.
Calling svm_range_dma_unmap_dev(dev, dst, 0, npages) beforehand unmaps and
zeroes all of dst[], leaving the dma_unmap_page() block in the while (i--)
loop dead code, and the commit message's statement that mappings were only
removed later by the caller's svm_range_dma_unmap_dev() no longer matches
the code.

Wait on *mfence before the while (i--) loop and either drop the new
svm_range_dma_unmap_dev() call or remove the duplicate dma_unmap_page()
block inside the loop.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118151045.1349=
08-1-xiaogang.chen@amd.com?part=3D1
