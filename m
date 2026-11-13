Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDC606A337
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 15:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boJkVZBP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705A8112631;
	Fri, 13 Nov 2026 15:11:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8271112631
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 15:11:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5D27442AB7;
 Fri, 13 Nov 2026 15:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221ED1F000C5;
 Fri, 13 Nov 2026 15:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794582676;
 bh=+zNMZTdW63OJp9JLaAP3QhXJL+WrygMZPqK3w/RNKWQ=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=boJkVZBP7vb2DCgctqAU3wS9w3kwCD2j6HYr1WYGzFT0uxN6cfATuNfOKPAdi5R5+
 F3MN6cQ5HQZRt2/BVraHACs5+aGkEve+4Uw1hNMLVz/7ESjh4L0Ds6a45s00pj9WIq
 CqTdCDp10cygCzyYBBWYAd/Uozk43A9UJyg3Yk3qQUcfPoj3Qbz5wwOMm4RVNN8Eyr
 Fwj0ax4IYfJIb3dkTRHB7CwzTPY0ZIJoF6TXAXoXS9ILpuR0UQEf6nageHPsx9tDrI
 XGTrpYRqpcYsIn7zZgUO96fTqeUMGce5MxJ9GnUI+zzXhINgYHshUXwEdV9wlBf+Zr
 CCx1O0qRD8Wxw==
Message-ID: <sashiko-outbox-213060@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] Revert "drm/amdgpu: mark A+A VF VRAM mappings as
 system memory"
To: "Zhigang Luo" <Zhigang.Luo@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113145702.323968-1-Zhigang.Luo@amd.com>
References: <20261113145702.323968-1-Zhigang.Luo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:11:15 +0000
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
- [Low] drm/amdgpu: revert commit message cites unmerged SHA and lacks
  Fixes tag
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] drm/amdgpu: use-after-free on
  amdgpu_ualink_peer_remote_init() error [1]
--

commit 6fcaa0941d3baaab33a7b2b5dd02cf2d392bc896
Author: Zhigang Luo <Zhigang.Luo@amd.com>

> Revert "drm/amdgpu: mark A+A VF VRAM mappings as system memory"
>
> This reverts commit 521bedfc94cc.
>
> The patch sets AMDGPU_PTE_SYSTEM in amdgpu_ttm_tt_pde_flags() and
> converts the VRAM address with amdgpu_gmc_vram_mc2pa() inside
> amdgpu_gmc_get_pde_for_bo(). gmc_v12_1_get_vm_pde() already converts
> an MC address to a physical address and skips that conversion when
> the SYSTEM bit is set, so setting the bit first bypasses the
> translation.
>
> The bit belongs in the GFX 12.1 helpers, after that translation.
> PDB0 is written directly and does not go through get_vm_pde(), and
> NPA still requires PTE.S=3D0, so those two pieces come back in the
> following patch.
>
> Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>

[Severity: Low]
In the merged tree, the reverted change was committed as 010e510347f5
("drm/amdgpu: mark A+A VF VRAM mappings as system memory") rather than the
pre-signoff commit cited above.  Since this revert fixes broken PDE address
translation, should the commit message reference 010e510347f5 ("drm/amdgpu:
mark A+A VF VRAM mappings as system memory") and include:

  Fixes: 010e510347f5 ("drm/amdgpu: mark A+A VF VRAM mappings as system mem=
ory")

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ualink.c
> index d025b4183b296..9655758fa11ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
> @@ -6173,7 +6173,6 @@ static int amdgpu_ualink_peer_remote_init(struct am=
dgpu_device *adev)
>  	flags =3D amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, bo->tbo.resource);
>  	flags |=3D AMDGPU_PTE_SNOOPED | AMDGPU_PTE_PRT_GFX12 | AMDGPU_PTE_BUS_A=
TOMICS;
>  	flags &=3D ~AMDGPU_PTE_VALID;
> -	flags &=3D ~AMDGPU_PTE_SYSTEM;
>  	/* PTE.X=3D0 turn off RPC checks for RBs, wptr and doorbell NPA address=
 */
>  	flags &=3D ~AMDGPU_PTE_EXECUTABLE;

[Severity: Critical]
This problem wasn't introduced by this patch, but can a failure in
amdgpu_ualink_peer_remote_init() cause a use-after-free on
adev->ualink.remote [1]?

For each active remote peer, amdgpu_ualink_peer_remote_init() calls
amdgpu_ualink_gart_map() several times, inserting the embedded drm_mm_node
fields (mm_node_rb, mm_node_wptr and mm_node_doorbell) into
adev->mman.gtt_mgr.mm.  If a later amdgpu_ualink_gart_map() call fails,
amdgpu_ualink_peer_remote_init() breaks out and returns the error without
unmapping the earlier nodes:

drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c:amdgpu_ualink_peer_remote_init()=
 {
	...
	for_each_set_bit(dst_accel_id, remote->active_accel_bits, AMDGPU_UALINK_AC=
CEL_MAX) {
		...
		r =3D amdgpu_ualink_gart_map(adev, rb_pages, npa, &interrupt->mm_node_rb,=
 flags);
		if (r)
			break;
		...
		r =3D amdgpu_ualink_gart_map(adev, rb_pages, npa, &shootdown->mm_node_rb,=
 flags);
		if (r)
			break;
	...
}

amdgpu_ualink_sw_init() then jumps to out_sdma_entities_fini and frees
adev->ualink.remote with kfree(), leaving the freed drm_mm_node objects
linked in adev->mman.gtt_mgr.mm and corrupting the GTT allocator on later
GTT operations or driver teardown.

[1] https://sashiko.dev/#/bug/linux-104150f2-9bfd-48ac-8dd1-d6f510b9e3c1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113145702.3239=
68-1-Zhigang.Luo@amd.com?part=3D1
