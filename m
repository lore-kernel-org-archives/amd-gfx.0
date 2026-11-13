Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01C606A881
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZErGBoH3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AAC11125AE;
	Fri, 13 Nov 2026 14:06:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E651125AE
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 14:06:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AE74C62755;
 Fri, 13 Nov 2026 14:06:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E7E71F000C8;
 Fri, 13 Nov 2026 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794578761;
 bh=iixsIzRsYYVwD9xTNllbpvRh2tWcUUZn6CM4H7YTmPg=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ZErGBoH3JEtnXViKKnA7GV3BTA6vkweXdP0x6ktS+Cm4Rqu9Gq8kAG/BxFSgTixZs
 jW/hVhne334LIW3sFUG6YvJ8xnI+QZMsxIKc0sey/4/lt9pZJML0NTRcTvl1uHodPL
 Opro0ws3NW72lyDw+I07i/DaHC86UOWUVOJNwDL/a023gIoMOn3WDEj8PinUUnKU94
 b87xm44tOYT30bNtLKeM7QqaexD2bzr+FuU7GaW21vkZIVObSafwbMKKeQV/+zbNHp
 P9mTz4dv1Z7+zB/y/Yf4Q4lNKVXbD4Uwinu1/Ch9F6mia8MrfYSs2V3gRUxtbYzZfG
 BGe23u3vfPM+g==
Message-ID: <sashiko-outbox-212957@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: clear root PT after setting vm->is_npa = true
To: "Shahyan Soltani" <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113134017.2781893-1-shahyan.soltani@amd.com>
References: <20261113134017.2781893-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 14:06:00 +0000
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
- [High] drm/amdgpu: missing dma_resv_reserve_fences() in
  amdgpu_vm_make_npa()
- [Low] drm/amdgpu: missing Fixes trailer on amdgpu_vm_make_npa() bug
  fix
--

commit 39cb24e53c83e097f97bd6822aa71f40ca923e2b
Author: Shahyan Soltani <shahyan.soltani@amd.com>

> drm/amdgpu: clear root PT after setting vm->is_npa =3D true
>
> Previously, the root pt was never cleared after setting vm->is_npa =3D
> true within amdgpu_vm_make_npa(). This resulted in the flag
> adev->gmc.no_retry_flags to never be applied for the NPA VMs.
>
> Call amdgpu_vm_pt_clear() after vm->is_npa =3D true is set and the bo has
> been pinned/validated. This allows the root PT of the NPA VM to be cleared
> with the correct value.
>
> Remove the redundant second setting of vm->is_npa =3D true.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

[Severity: Low]
This fixes a bug in amdgpu_vm_make_npa(). Should the commit message include:

  Fixes: e05a54573df7 ("drm/amdgpu: Pin page tables in NPA VMs")

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 2ba33212d5071..eb5d243ab463a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2827,11 +2827,12 @@ int amdgpu_vm_make_npa(struct amdgpu_device *adev=
, struct amdgpu_vm *vm)
>  	if (r)
>  		return r;
>  	r =3D amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	if (!r)
> +		r =3D amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false=
);

[Severity: High]
Does calling amdgpu_vm_pt_clear() here without first calling
dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1) trigger a BUG_ON() in
dma_resv_add_fence()?

Because vm->root.bo is already in compatible VRAM from amdgpu_vm_init(),
ttm_bo_validate() inside amdgpu_bo_pin() and amdgpu_vm_pt_clear() returns
early without reserving a fence slot. When SDMA updates are used,
amdgpu_vm_pt_clear() -> amdgpu_vm_sdma_commit() calls
dma_resv_add_fence(p->vm->root.bo->tbo.base.resv, f, DMA_RESV_USAGE_BOOKKEE=
P),
hitting BUG_ON(fobj->num_fences >=3D fobj->max_fences).

amdgpu_vm_init() avoids this by reserving a fence slot beforehand:

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:amdgpu_vm_init() {
	...
	r =3D dma_resv_reserve_fences(root_bo->tbo.base.resv, 1);
	if (r)
		goto error_free_root;

	r =3D amdgpu_vm_pt_clear(adev, vm, root, false);
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113134017.2781=
893-1-shahyan.soltani@amd.com?part=3D1
