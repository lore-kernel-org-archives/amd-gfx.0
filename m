Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C714606A338
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BAug6/yV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D56E10EC3D;
	Fri, 13 Nov 2026 15:20:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCC3810EC3D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:20:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2495761D34;
 Fri, 13 Nov 2026 15:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49491F000C4;
 Fri, 13 Nov 2026 15:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794583249;
 bh=ybpqBiZChcfzyNPS+M+aryKhUoiItnGjKkRxI+hXLbE=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=BAug6/yV0e8GEEr3M/cWGI2c+LmLdJGdBI4w7UkZ7PuiE9nD8/rXoHfUHblBZ8wnu
 88cZDbujaVmjrtPjyrwWlIHlUmJUZ5LeYnOy4C4ujmdN58/82o0GgjNNNKhXIuHmoW
 nhzsJ32u8Z4W8yxWFcD4LkTm6mQUJDCnjd0kNtpm5zZ3cyqFdTfeB2BFme1K1JdLMm
 KFbOljS9ByIoMjcCW82yKudQaIXUNZuzZiuNjazV73Za2B2mk3tcbnncKxGRDlrobM
 ik76IggYDNd+r2WKOo+9eFlOv+ITPJknZvnVY2RwMN13RiEAbV3xF1N+hPJR7OSWff
 tfwuPWVkCTlFw==
Message-ID: <sashiko-outbox-213076@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] drm/amdgpu: set the A+A VF SYSTEM bit in the GFX
 12.1 helpers
To: "Zhigang Luo" <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113145702.323968-4-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
 <20261113145702.323968-4-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:20:48 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/amdgpu: gmc_v12_1_get_vm_pde() sets AMDGPU_PTE_SYSTEM on
  invalid and NPA PDEs
- [Medium] drm/amdgpu: gmc_v12_1_get_vm_pte() sets AMDGPU_PTE_SYSTEM
  when PTE is invalid
--

commit 914948e43f4fe117dbe355b73ada0eb4485a66d2
Author: Zhigang Luo <Zhigang.Luo@amd.com>

drm/amdgpu: set the A+A VF SYSTEM bit in the GFX 12.1 helpers

This commit sets AMDGPU_PTE_SYSTEM in gmc_v12_1_get_vm_pde() and
gmc_v12_1_get_vm_pte() when VRAM is backed by system physical memory on
SR-IOV VFs.

> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gmc_v12_1.c
> index 57aac3a9a3b0f..1c5998fa3ad6e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
> @@ -586,6 +586,12 @@ static void gmc_v12_1_get_vm_pde(struct amdgpu_devic=
e *adev, int level,
>  		*addr =3D adev->vm_manager.vram_base_offset + *addr -
>  			adev->gmc.vram_start;
> =20
> +	/* SPM VRAM is reached at a system physical address. Set S after the
> +	 * translation above so that translation is not skipped.
> +	 */
> +	if (amdgpu_virt_vram_is_spm(adev))
> +		*flags |=3D AMDGPU_PTE_SYSTEM;
> +
>  	if (*addr & ~adev->gmc.pte_addr_mask) {
>  		dev_err(adev->dev, "Invalid PDE address: %llx\n", *addr);
>  		*addr =3D 0;

[Severity: High]
Does setting AMDGPU_PTE_SYSTEM here without checking (*flags &
AMDGPU_PTE_VALID) corrupt cleared PDEs and 2MB+ NPA leaf PDEs?

On GFX 12, gmc_v12_1_get_vm_pde() always sets AMDGPU_PTE_SNOOPED, and
(AMDGPU_PTE_SYSTEM | AMDGPU_PTE_SNOOPED) on an invalid entry is
AMDGPU_VM_NORETRY_FLAGS_GFX12.  When amdgpu_vm_pt_clear() clears a
non-PTB page directory (with AMDGPU_PTE_VALID =3D=3D 0), this turns every
cleared PDE in a normal VM into a fatal no-retry fault entry, breaking
SVM demand paging on unpopulated ranges.

For 2MB+ AMDGPU_PL_NPA mappings updated at a leaf PDE level in
amdgpu_vm_pte_update_flags(), gmc_v12_1_get_npa_flags() clears
AMDGPU_PTE_VALID and leaves AMDGPU_PTE_SYSTEM clear (VSCT =3D 0011), which
amdgpu_gmc_get_vm_pde() then overwrites with AMDGPU_PTE_SYSTEM.

> @@ -753,6 +759,10 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_devic=
e *adev,
> =20
>  	if (bo) {
>  		mem =3D bo->tbo.resource;
> +		if (amdgpu_virt_vram_is_spm(adev) &&
> +		    mem && mem->mem_type =3D=3D TTM_PL_VRAM)
> +			*flags |=3D AMDGPU_PTE_SYSTEM;
> +
>  		if (mem && mem->mem_type =3D=3D AMDGPU_PL_NPA) {
>  			dev_dbg(adev->dev,
>  				"Setting PTE for NPA BO, mem->type: %d, mem->start: %lx, mem->size: =
%u, cur_flags: %llx\n",
> @@ -761,6 +771,9 @@ static void gmc_v12_1_get_vm_pte(struct amdgpu_device=
 *adev,
>  		} else if (*flags & AMDGPU_PTE_VALID) {
>  			gmc_v12_1_get_coherence_flags(adev, bo, flags);
>  		}
> +	} else if (amdgpu_virt_vram_is_spm(adev)) {
> +		/* SVM has no BO. System memory already has S. VRAM does not. */
> +		*flags |=3D AMDGPU_PTE_SYSTEM;
>  	}
>  }

[Severity: Medium]
Should both branches check (*flags & AMDGPU_PTE_VALID) before setting
AMDGPU_PTE_SYSTEM?

When amdgpu_vm_handle_moved() calls amdgpu_vm_bo_update() with clear =3D
true after dma_resv_trylock() fails, bo->tbo.base.resv is not held and
update_flags has AMDGPU_PTE_VALID =3D=3D 0.  Checking mem->mem_type before
(*flags & AMDGPU_PTE_VALID) reads bo->tbo.resource without holding the
reservation lock and sets AMDGPU_PTE_SYSTEM on cleared PTEs.

In the else branch, amdgpu_vm_bo_update() also passes bo =3D=3D NULL with
AMDGPU_PTE_VALID =3D=3D 0 for PRT/sparse mappings (fpriv->prt_va), so
setting AMDGPU_PTE_SYSTEM unconditionally pollutes invalid non-SVM PTEs
(and forms AMDGPU_VM_NORETRY_FLAGS_GFX12 if a cleared or PRT mapping
spans a 2MB+ leaf PDE).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113145702.3239=
68-1-Zhigang.Luo@amd.com?part=3D4
