Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAA9606A33A
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2026 20:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llJSuT5r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC98410ECB3;
	Fri, 13 Nov 2026 20:48:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A88311127D8
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2026 20:48:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5BECC40B61;
 Fri, 13 Nov 2026 20:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A431F000C4;
 Fri, 13 Nov 2026 20:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794602911;
 bh=3WtkdzJpHyy51mOw4TPv0GOhov/DcWnrHQXs9G7lcmU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=llJSuT5rMNmlN9EYccS7TvclV3lyekXr5pmkLSXyO0Huel2avDc2RtxTLOzb4CcRK
 y/sxNIoEwX5KYGvu9YyGYsEvZ9cSrjZ54Pg2TgjoZ4rJCc443pPvt3dezyRduObKJt
 75kfZp6lsa+sck63mWWzEcBiTJNw+C9z0/TRukElobtiH0MFyps7B/g2A0jy+tD1fm
 Ehot1HPZAWAEeLD5ovh0tfU63/FdGoBB37KKfgPCO8s7HXXRJInm9egAbgNnbgq1Nb
 LmjcxGQ7Na+Gy/pha0O0hFix4MV0cjaEGipY8/PdurfeRGrcjaox/zQkXNDpo8YOWP
 eI+QMIvKBttQg==
Message-ID: <sashiko-outbox-213682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: clear root PT after setting vm->is_npa =
 true
To: "Shahyan Soltani" <shahyan.soltani@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261113202944.3006069-1-shahyan.soltani@amd.com>
References: <20261113202944.3006069-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 20:48:30 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] drm/amdgpu: build failure calling static
  amdgpu_ualink_flush_tlb()
- [High] drm/amdgpu: missing dma_resv_reserve_fences() in
  amdgpu_vm_make_npa()
- [Medium] drm/amdgpu: missing error handling on amdgpu_vm_pt_clear()
  failure
- [Medium] drm/amdgpu: premature TLB flush in amdgpu_vm_make_npa()
- [Low] drm/amdgpu: missing Fixes trailer on amdgpu_vm_make_npa() bug
  fix
--

commit d44f1102f39999e9e70a8ca65fdacefed70663a9
Author: Shahyan Soltani <shahyan.soltani@amd.com>

> drm/amdgpu: clear root PT after setting vm->is_npa =3D true
>
> Previously, the root PT was never cleared after setting vm->is_npa =3D
> true within amdgpu_vm_make_npa(). This resulted in the flag
> adev->gmc.no_retry_flags to never be applied for the NPA VMs.
>
> Call amdgpu_vm_pt_clear() after vm->is_npa =3D true is set and the bo has
> been pinned/validated. This allows the root PT of the NPA VM to be
> cleared with the correct value.
>
> If the pinning or reservation of the bo failed, the vm->is_npa flag will
> no longer remain as true. This is to avoid conditionals outside of
> amdgpu_vm_make_npa() that depend on the vm->is_npa flag to determine if
> the VM is a correctly initialized NPA VM.
>
> Warn if the VM already has mappings, since clearing the root PT will
> break existing mappings. Do a heavy weight TLB flush after the root PT
> clear to avoid any stale translations being left behind from a previous
> table.
>
> Remove the redundant second setting of vm->is_npa =3D true.
>
> v2:
> - Add the WARN_ON sanity check regarding an empty VM. (Felix)
> - Change the return handling to only set vm->is_npa =3D true upon a
>   successful pin (Felix)
> - Add the heavy weight TLB flush after the root PT clear (Philip)
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>

[Severity: Low]
Since this fixes the initialization of the root page directory in
amdgpu_vm_make_npa(), should it include a Fixes tag?

  Fixes: e05a54573df7 ("drm/amdgpu: Pin page tables in NPA VMs")

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 2ba33212d5071..5c51dd6bd8d2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2818,20 +2818,27 @@ int amdgpu_vm_make_compute(struct amdgpu_device *=
adev, struct amdgpu_vm *vm)
>   */
>  int amdgpu_vm_make_npa(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>  {
> -	int r =3D amdgpu_vm_make_compute(adev, vm);
> +	int r;
> =20
> +	r =3D amdgpu_vm_make_compute(adev, vm);
>  	if (r)
>  		return r;
> -	vm->is_npa =3D true;
> +
>  	r =3D amdgpu_bo_reserve(vm->root.bo, false);
>  	if (r)
>  		return r;
>  	r =3D amdgpu_bo_pin(vm->root.bo, AMDGPU_GEM_DOMAIN_VRAM);
> +	if (!r) {
> +		/* Check if VM mappings are empty, clearing would break existing mappi=
ng */
> +		WARN_ON(!RB_EMPTY_ROOT(&vm->va.rb_root));
> +		vm->is_npa =3D true;
> +		r =3D amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(vm->root.bo), false=
);

[Severity: High]
Does amdgpu_vm_pt_clear() need a fence slot reserved on
vm->root.bo->tbo.base.resv first, as in amdgpu_vm_init()?

Earlier in amdgpu_vm_make_npa(), amdgpu_vm_make_compute() unreserves
vm->root.bo, which resets fobj->max_fences when mutex debugging is
enabled.  Because vm->root.bo is already in compatible memory,
ttm_bo_validate() inside amdgpu_bo_pin() and amdgpu_vm_pt_clear() returns
early without calling dma_resv_reserve_fences().  When page tables are
updated via sdma, amdgpu_vm_pt_clear() -> amdgpu_vm_sdma_commit() calls
dma_resv_add_fence() on vm->root.bo->tbo.base.resv and triggers a kernel
crash when fobj->num_fences >=3D fobj->max_fences.

> +		amdgpu_ualink_flush_tlb(adev, TLB_FLUSH_HEAVYWEIGHT);

[Severity: High]
Does this break the build by calling amdgpu_ualink_flush_tlb() from
amdgpu_vm.c?

amdgpu_ualink_flush_tlb() is declared and defined as static in
drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c and has no prototype in any
header, causing an implicit function declaration error when compiling
amdgpu_vm.c and an undefined reference at link time.

[Severity: Medium]
Can amdgpu_ualink_flush_tlb() also run here before the root page directory
clear has taken effect?

When vm->use_cpu_for_update is false, amdgpu_vm_pt_clear() submits an
asynchronous sdma job stored in vm->last_update, and nothing waits on
vm->last_update before flushing.  In addition, the caller
amdgpu_ualink_manager_start() only binds npa_vm.root.bo to
adev->vm_manager.npa_vmid via adev->mmhub.funcs->setup_vm_pt_regs() after
amdgpu_vm_make_npa() returns, so flushing npa_vmid inside
amdgpu_vm_make_npa() happens before the page table base register is
programmed.

> +	}
>  	amdgpu_bo_unreserve(vm->root.bo);
>  	if (r)
>  		return r;

[Severity: Medium]
If amdgpu_vm_pt_clear() fails, does this still flush the tlb and return an
error with vm->is_npa set to true and vm->root.bo left pinned?

Checking r after amdgpu_vm_pt_clear() and unpinning vm->root.bo while
resetting vm->is_npa =3D false on failure would avoid leaving the vm in a
half-initialized state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113202944.3006=
069-1-shahyan.soltani@amd.com?part=3D1
