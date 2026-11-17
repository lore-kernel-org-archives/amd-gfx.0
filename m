Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056C60A2600
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZbnbVz6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E74E89023;
	Tue, 17 Nov 2026 17:21:48 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D55D89023
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:21:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0AF4740265;
 Tue, 17 Nov 2026 17:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50D01F000C8;
 Tue, 17 Nov 2026 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794936101;
 bh=USksEgKX6RwJwfVsbSgXaR3ihZ77VLCRHVA/FrlrtM0=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=jZbnbVz6ASsvMwpoK4FiwPkvRK2z79PfDLym4hcGwalxWwVKp2ozWCm5IHqlPan9w
 eLw8xYWgRcnJp4o3CqNOMsTIScfy5ENEzynq84OZPS7gdaT2ujXFRaAEVoBistAt3w
 cRKb+o2lat+Prrmn+IvrzLzNDBsq3ixYXzSQ1UzP08uPvFypCKwCNKArzQ7b2CeMBM
 pbnsdVeZkE2MmmpDDkokRGnKKQUwMXybHGx9/0m1icKWaJ7STrFkAcWCPqpZFVU3gg
 PUXo2z/Zzce6mWMb59flk+IZ2cLzCRePMkm8vdNj23bjdgOkq1CHJJZf11fZxDQ7ZD
 YP1VhmWTmwAtA==
Message-ID: <sashiko-outbox-219228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/3] drm/amdgpu: reserve and bind the SPM VMID on
 every GFXHUB instance
To: "James Zhu" <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117165952.3558762-3-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
 <20261117165952.3558762-3-James.Zhu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:21:41 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/amdgpu: physical xcc_mask used as logical index in
  amdgpu_vm_spm_update()
- [High] drm/amdgpu: amdgpu_vm_fini() only checks GFXHUB(0) before
  waiting on jobs
- [Medium] drm/amdgpu: unlocked allocation and unsafe rollback in
  amdgpu_vmid_alloc_spm_gfxhubs()
--

commit 0df4e49e9ba90dc0c43a497872e17c100a8d4894
Author: James Zhu <James.Zhu@amd.com>

drm/amdgpu: reserve and bind the SPM VMID on every GFXHUB instance

This commit updates SPM VMID reservation, binding, and unbinding to operate
per GFXHUB instance across XCCs rather than only on AMDGPU_GFXHUB(0).

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.c
> index 9c879ac683520..41f3dba530e38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c

[ ... ]

> +int amdgpu_vmid_alloc_spm_gfxhubs(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm, uint32_t xcc_mask)
> +{
> +	int i, r;
> +
> +	for_each_inst(i, xcc_mask) {
> +		r =3D amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(i));
> +		if (r) {
> +			amdgpu_vmid_free_spm_gfxhubs(adev, vm, xcc_mask);
> +			return r;
> +		}
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
If amdgpu_vmid_alloc_spm() fails on a later hub, can rolling back with
amdgpu_vmid_free_spm_gfxhubs(adev, vm, xcc_mask) unbind an active SPM VMID
to 0 while GPU jobs are still using it?

amdgpu_vmid_alloc_spm() returns 0 when vm->reserved_vmid[vmhub] is already
set, and AMDGPU_VM_OP_RESERVE_VMID calls amdgpu_vmid_alloc_spm_gfxhubs()
before reserving vm->root.bo.  If vm already held a reservation on an
earlier hub, or a concurrent job submission grabs a newly published
vm->reserved_vmid[AMDGPU_GFXHUB(i)] before a subsequent hub fails with
-ENOENT, the rollback frees and unbinds those earlier hubs to 0 without
waiting via dma_resv_wait_timeout().

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 94b1cfe05e3e0..e1691145da903 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -589,30 +589,36 @@ uint64_t amdgpu_vm_generation(struct amdgpu_device =
*adev, struct amdgpu_vm *vm)
>   * The SPM VMID is fixed (adev->vm_manager.spm_vmid), so its page-table-=
base
>   * register must track whichever VM currently holds the reservation inst=
ead
>   * of being set per-job like a normal VMID. Bind it to @vm's real root PD
> - * address if @vm holds the reservation; otherwise do nothing, since @vm=
 is
> - * not the one that could legitimately change the current binding.
> + * address on every GFXHUB @vm holds the reservation on; hubs reserved by
> + * other VMs or not reserved at all are left alone, since @vm is not the
> + * one that could legitimately change their binding.
>   *
>   * @vm's root PD must be locked by the caller.
>   */
>  void amdgpu_vm_spm_update(struct amdgpu_device *adev, struct amdgpu_vm *=
vm)
>  {
> -	struct amdgpu_kq_vmid_mgr *id_mgr =3D
> -		&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)];
>  	uint64_t pd_addr;
> +	int i;
> =20
>  	if (!adev->vm_manager.spm_vmid || !adev->gfxhub.funcs)
>  		return;
> =20
> -	mutex_lock(&id_mgr->lock);
> -	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)] !=3D
> -	    &id_mgr->ids[adev->vm_manager.spm_vmid] || !amdgpu_vm_ready(vm)) {
> -		mutex_unlock(&id_mgr->lock);
> +	if (!amdgpu_vm_ready(vm))
>  		return;
> -	}
> =20
>  	pd_addr =3D amdgpu_gmc_pd_addr(vm->root.bo);
> -	amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0), adev->vm_manager.spm_vmid,=
 pd_addr);
> -	mutex_unlock(&id_mgr->lock);
> +	for_each_inst(i, adev->gfx.xcc_mask) {
> +		struct amdgpu_kq_vmid_mgr *id_mgr =3D
> +			&adev->vm_manager.id_mgr[AMDGPU_GFXHUB(i)];
> +
> +		mutex_lock(&id_mgr->lock);
> +		if (vm->reserved_vmid[AMDGPU_GFXHUB(i)] =3D=3D
> +		    &id_mgr->ids[adev->vm_manager.spm_vmid])
> +			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(i),
> +					     adev->vm_manager.spm_vmid,
> +					     pd_addr);
> +		mutex_unlock(&id_mgr->lock);
> +	}
>  }

[Severity: High]
Can iterating over adev->gfx.xcc_mask here and in amdgpu_vm_ioctl() index
adev->reg_offset[GC_HWIP] out of bounds when lower-numbered physical XCCs
are harvested?

adev->gfx.xcc_mask is a bitmask of physical XCC instances, whereas
AMDGPU_GFXHUB(i), adev->vmhub[], ring->vm_hub, and setup_vm_pt_regs_xcc()
all use contiguous logical XCC indices 0 .. NUM_XCC(adev->gfx.xcc_mask) - 1
and translate them via GET_INST(GC, i):

drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c:gfxhub_v1_2_xcc_setup_vm_pt_regs()=
 {
	for_each_inst(i, xcc_mask) {
		hub =3D &adev->vmhub[AMDGPU_GFXHUB(i)];
		WREG32_SOC15_OFFSET(GC, GET_INST(GC, i),
				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
				    hub->ctx_addr_distance * vmid,
				    lower_32_bits(page_table_base));
    ...
}

When a lower physical XCC is harvested, amdgpu_populate_ip_map() sets
adev->ip_map.dev_inst[GC_HWIP][i] to -1 for i >=3D NUM_XCC(adev->gfx.xcc_ma=
sk).
Passing a physical bit position i >=3D NUM_XCC(adev->gfx.xcc_mask) through
amdgpu_gmc_bind_vmid() causes GET_INST(GC, i) to return 0xffffffff, reading
adev->reg_offset[GC_HWIP][0xffffffff] out of bounds and flushing an
uninitialized adev->vmhub[AMDGPU_GFXHUB(i)], while skipping the logical
GFXHUBs at the harvested bit positions.  Using
GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0) avoids mixing physical and
logical XCC masks.

[ ... ]

> @@ -3027,14 +3034,19 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
>  	}
>  	case AMDGPU_VM_OP_UNRESERVE_VMID: {
>  		struct amdgpu_bo *root =3D vm->root.bo;
> +		bool reserved =3D false;
> +		int i;
> =20
>  		amdgpu_bo_reserve(root, true);
> +		for_each_inst(i, adev->gfx.xcc_mask)
> +			reserved |=3D amdgpu_vmid_uses_reserved(vm,
> +							AMDGPU_GFXHUB(i));
>  		/* Wait for the jobs which might still use the reserved VMID */
> -		if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
> +		if (reserved)
>  			dma_resv_wait_timeout(root->tbo.base.resv,
>  					      DMA_RESV_USAGE_READ, false,
>  					      MAX_SCHEDULE_TIMEOUT);
> -		amdgpu_vmid_free_spm(adev, vm, AMDGPU_GFXHUB(0));
> +		amdgpu_vmid_free_spm_gfxhubs(adev, vm, adev->gfx.xcc_mask);
>  		amdgpu_bo_unreserve(root);
>  		break;
>  	}

[Severity: High]
Should amdgpu_vm_fini() also check all GFXHUBs before waiting on
root->tbo.base.resv, matching this change in AMDGPU_VM_OP_UNRESERVE_VMID?

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:amdgpu_vm_fini() {
    ...
	/* Wait for the jobs which might still use the reserved VMID */
	if (vm->reserved_vmid[AMDGPU_GFXHUB(0)])
		dma_resv_wait_timeout(root->tbo.base.resv, DMA_RESV_USAGE_READ,
				      false, MAX_SCHEDULE_TIMEOUT);
    ...
	for (i =3D 0; i < AMDGPU_MAX_VMHUBS; i++) {
		amdgpu_vmid_free_spm(adev, vm, i);
	}
    ...
}

If a VM holds an SPM reservation on a non-zero GFXHUB while
vm->reserved_vmid[AMDGPU_GFXHUB(0)] is NULL (for example when reserved on a
subset of GFXHUBs via amdgpu_vmid_alloc_spm_gfxhubs()), closing the DRM file
skips dma_resv_wait_timeout(), frees the root PD in amdgpu_vm_pt_free_root(=
),
and unbinds the SPM VMID to 0 while jobs using that VMID are still running.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117165952.3558=
762-1-James.Zhu@amd.com?part=3D2
