Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E61606A32D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hHrJ2ePX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE99411263C;
	Fri, 13 Nov 2026 15:14:24 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF5CB11263C
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:14:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD9C460610;
 Fri, 13 Nov 2026 15:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6791F1F000C4;
 Fri, 13 Nov 2026 15:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794582857;
 bh=QtKD8w2lEhW3E53xGQlzNjoKaUroxmcxwcLtGmXEJqo=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=hHrJ2ePXJWwx8CoIxKvvUt2mq+A5QN9IH+ztew0GxI3J6NarHIzaqNUc3yglSB5Dq
 evhUAUmeCv6qq9z1dAt+yACixn2fePGQ6O8CEKasNPLteN0HX0tqOy6zjNRPizdwNm
 l/g9cz3/LKjzG5xUW+2f8xrWSaLyMYW5S3HggJ68qlaZKQLWUzSqtq8TD4Dav95oLv
 VSLy9OOG0IcWcsIFPCMxvszI2x2iL8Bu3XK7CDKYX+76nPRe+4soY7h8ztMa0DUIEp
 TixxEsYoCHhAcfI1N2aJir9SClF7X5i5eHZEnnL1B3arnrt9v0bncGJgq7/KyyaGvy
 M/AA3RVyKiwyg==
Message-ID: <sashiko-outbox-213068@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] drm/amdgpu: fill the A+A VF PDB0 through get_vm_pde
To: "Zhigang Luo" <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113145702.323968-5-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
 <20261113145702.323968-5-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:14:17 +0000
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
- [High] drm/amdgpu: amdgpu_gmc_init_pdb0() corrupts GFX9 PDB0 via
  get_vm_pde()
--

commit 94fec17ddae148fbc91f8d2688eb078363097ddd
Author: Zhigang Luo <Zhigang.Luo@amd.com>

drm/amdgpu: fill the A+A VF PDB0 through get_vm_pde

This commit routes the VRAM PDE_PTE entries and the GART PTB PDE0 entry in
amdgpu_gmc_init_pdb0() through amdgpu_gmc_get_vm_pde().

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gmc.c
> index 659e89e5e78f1..04cf02dd22acb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -1272,7 +1272,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *ade=
v)
>  	u64 vram_size =3D adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num=
_physical_nodes;
>  	u64 pde0_page_size =3D (1ULL<<adev->gmc.vmid0_page_table_block_size)<<2=
1;
>  	u64 vram_addr, vram_end;
> -	u64 gart_ptb_gpu_pa =3D amdgpu_gmc_vram_pa(adev, adev->gart.bo);
> +	u64 pde_addr, pde_flags;
>  	int idx;
> =20
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -1290,10 +1290,16 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *a=
dev)
>  	vram_end =3D vram_addr + vram_size;
> =20
>  	/* The first n PDE0 entries are used as PTE,
> -	 * pointing to vram
> +	 * pointing to vram. PDE_PTE already holds a physical address, so
> +	 * get_vm_pde() skips translation and sets S for SPM.
>  	 */
> -	for (i =3D 0; vram_addr < vram_end; i++, vram_addr +=3D pde0_page_size)
> -		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_addr, flags);
> +	for (i =3D 0; vram_addr < vram_end; i++, vram_addr +=3D pde0_page_size)=
 {
> +		pde_addr =3D vram_addr;
> +		pde_flags =3D flags;
> +		amdgpu_gmc_get_vm_pde(adev, AMDGPU_VM_PDB0, &pde_addr, &pde_flags);
> +		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, pde_addr,
> +				       pde_flags);
> +	}
> =20
>  	/* The n+1'th PDE0 entry points to a huge
>  	 * PTB who has more than 512 entries each
> @@ -1301,8 +1307,12 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *ad=
ev)
>  	 */
>  	flags =3D AMDGPU_PTE_VALID;
>  	flags |=3D AMDGPU_PTE_SNOOPED | AMDGPU_PDE_BFS_FLAG(adev, 0);
> -	/* Requires gart_ptb_gpu_pa to be 4K aligned */
> -	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, fl=
ags);
> +	/* MC address. get_vm_pde() translates it once and sets S for SPM.
> +	 * Requires the GART PT to be 4K aligned.
> +	 */
> +	pde_addr =3D amdgpu_bo_gpu_offset(adev->gart.bo);
> +	amdgpu_gmc_get_vm_pde(adev, AMDGPU_VM_PDB0, &pde_addr, &flags);
> +	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, pde_addr, flags);

[Severity: High]
Does passing AMDGPU_VM_PDB0 to amdgpu_gmc_get_vm_pde() corrupt the VMID0
PDB0 table on GFX9 devices?

amdgpu_gmc_init_pdb0() is also called from gmc_v9_0_gart_enable() on GFX9
ASICs with PDB0 enabled (such as Aldebaran and Aqua Vanjaram), where
adev->gmc.translate_further is true for 4-level user VMs:

drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:gmc_v9_0_get_vm_pde() {
	...
	if (!adev->gmc.translate_further)
		return;

	if (level =3D=3D AMDGPU_VM_PDB1) {
		...
	} else if (level =3D=3D AMDGPU_VM_PDB0) {
		if (*flags & AMDGPU_PDE_PTE) {
			*flags &=3D ~AMDGPU_PDE_PTE;
			if (!(*flags & AMDGPU_PTE_VALID))
				*addr |=3D 1 << PAGE_SHIFT;
		} else {
			*flags |=3D AMDGPU_PTE_TF;
		}
	}
}

Unlike VM_CONTEXT1..15, VM_CONTEXT0_CNTL.PAGE_TABLE_DEPTH is programmed to
vmid0_page_table_depth (1) without subtracting 1 for translate_further.
Clearing AMDGPU_PDE_PTE on the VRAM entries causes the hardware walker to
treat each VRAM physical address as a child PTB pointer instead of a leaf
PTE, and setting AMDGPU_PTE_TF on the GART entry sets a PTE-only bit in a
depth-1 PDE0 entry, breaking system-domain VRAM and GART translation on
GFX9.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113145702.3239=
68-1-Zhigang.Luo@amd.com?part=3D5
