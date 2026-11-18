Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C1A60A3810
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 15:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VjceZJ1Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED2A910FDCD;
	Wed, 18 Nov 2026 15:25:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F23910FDCE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:25:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6E781461AB;
 Wed, 18 Nov 2026 15:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1B91F000D2;
 Wed, 18 Nov 2026 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795015516;
 bh=sOFf6vPZ+llw2dMYPwC/HT8mh15hkJsgMN3xH8fjwhs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=VjceZJ1ZEZcTGc59dwmoKiiGtOZf/TJFhk1cvxhbIunhJWFdZHk7VdeRCbW+5LJIg
 Fr1DNl4rFNHsRK4etqgP96SsG1Vv5Zeuhi5CC5sXFI74N+QFZskOYyhX6vKaCQOtWF
 h2FkR2GrUGZHhfsGCgj5dBceT1Gi5ezpJZoSEYItRnpTGrM5DceRXKNqRpgFtK/k4/
 purFDN24c7CiMlNDjUPZoeDcBRzvgWmsYR6RDaQsbmU2wzl4BUADH1Z0U/zM6DGHSb
 HOtvm2EYNX4E8rQ5iDbzVZdbftQ0BZuhZzLh15/8KfV1mlRqjwS6GSF4L8Zi5n/5Ai
 usk5R19IY4GLw==
Message-ID: <sashiko-outbox-221316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/amdkfd: Swap order of svm_range_dma_unmap_dev
 and migrate_vma_finalize
To: Xiaogang.Chen <xiaogang.chen@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261118151045.134908-2-xiaogang.chen@amd.com>
References: <20261118151045.134908-1-xiaogang.chen@amd.com>
 <20261118151045.134908-2-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:25:15 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/amdkfd: missing Fixes: trailers for DMA unmap ordering bug
  fix
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] drm/amdkfd: unhandled SDMA fence error in
  svm_migrate_copy_done() [1]
--

commit ccdfb551849cc8856e631a5865cff36ff2c4ceb7
Author: Xiaogang Chen <xiaogang.chen@amd.com>

> drm/amdkfd: Swap order of svm_range_dma_unmap_dev and migrate_vma_finalize
>
> svm_migrate_vma_to_vram() on success: migrate_vma_finalize() releases the=
 old
> system-RAM source pages. Only after that they are DMA-unmapped.
>
> svm_migrate_vma_to_ram() for slots that failed to migrate: finalize frees=
 the
> newly allocated dpages, and the unmap comes afterwards.
>
> Every mapping uses DMA_BIDIRECTIONAL. With swiotlb, that kind of unmap co=
pies
> the bounce buffer back into the original page, and by then the page may b=
elong
> to someone else. With an IOMMU, the IOVA stays valid for a short window a=
fter
> the page is freed. During the window GPU may write into the pages that may
> belong to someone else.
>
> So, swap svm_range_dma_unmap_dev and migrate_vma_finalize at both migrati=
on
> direction to make dma unmap happen before sys ram pages got released.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>

[Severity: Low]
Should this bug fix include Fixes: tags for the commits that introduced
the unmap ordering in both migration directions?

  Fixes: 0b0e518d61af ("drm/amdkfd: HMM migrate ram to vram")
  Fixes: 48ff079b28d8 ("drm/amdkfd: HMM migrate vram to ram")

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_migrate.c
> index 481091ae30947..b1e457851a5df 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -504,14 +504,13 @@ svm_migrate_vma_to_vram(struct kfd_node *node, stru=
ct svm_range *prange,
>  	migrate_vma_pages(&migrate);
> =20
>  	svm_migrate_copy_done(adev, mfence);
> +	svm_range_dma_unmap_dev(adev->dev, scratch, 0, npages);
>  	migrate_vma_finalize(&migrate);

[Severity: Critical]
This problem wasn't introduced by this patch, but can
svm_migrate_vma_to_vram() and svm_migrate_vma_to_ram() commit uninitialized
destination pages when the SDMA copy job fails [1]?

drivers/gpu/drm/amd/amdkfd/kfd_migrate.c:svm_migrate_copy_done() {
	if (mfence) {
		r =3D dma_fence_wait(mfence, false);
		dma_fence_put(mfence);
		pr_debug("sdma copy memory fence done\n");
	}
}

dma_fence_wait() returns 0 whenever the fence signals, even if the SDMA job
aborted with mfence->error set (for example during a GPU reset), and
neither svm_migrate_copy_done() nor its callers inspect the fence error or
return value before migrate_vma_finalize() installs the new page table
entries, exposing stale or uninitialized memory to userspace.

[1] https://sashiko.dev/#/bug/linux-bdb6e388-a490-42f9-a491-9e9b540c6920

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118151045.1349=
08-1-xiaogang.chen@amd.com?part=3D2
