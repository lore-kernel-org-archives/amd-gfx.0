Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CE4606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 18:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ec3Z0CA8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A0A210F4CC;
	Tue, 17 Nov 2026 18:47:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A4A10E646
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 18:47:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78A6D611F3;
 Tue, 17 Nov 2026 18:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FE31F000C4;
 Tue, 17 Nov 2026 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794941271;
 bh=aO6gbYG7kscdRpwCjbT/ku4J9ukmlyyZSp50QvKz778=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=ec3Z0CA8DHuydvu0HXzH73BBVSFcnGskZ/M6/bjIJ9fj/pVgCa7FRXkO1uklRd2+S
 kfmITb005o8Cmh/Uv2FY+JhxMRNgQlG6LPU3T3xuK5p9WpLOAyK0IoNHiOKqBACK+0
 cUye6tgENd/Xs9IEyJEy1gHMpxMHzCo+1GAlEh+aNR2GNp67/dIQfn5Mol9DzXIaD6
 5KzQ+TV3cQ5unz/2eKyw7JhTaW6lgudkelVeNQJZ14TOS+YoxbFFSDGEH3Q6wWVY0T
 4JvFEeHoFaMzJUna9Ytq++b7YPcz8uoZ81B2E+98CL+rGTPcE6X4Qp6XGp7WKEH36l
 03tkp22HgWQcw==
Message-ID: <sashiko-outbox-219386@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 2/3] drm/amdgpu: reserve and bind the SPM VMID on
 every GFXHUB instance
To: "James Zhu" <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117181941.3968996-3-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
 <20261117181941.3968996-1-James.Zhu@amd.com>
 <20261117181941.3968996-3-James.Zhu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 18:47:50 +0000
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
- [Medium] drm/amdgpu: missing root PD lock in
  amdgpu_vmid_alloc_spm_gfxhubs()
--

commit 4216e97db26fd6fc889673c452d2434887bc13af
Author: James Zhu <James.Zhu@amd.com>

drm/amdgpu: reserve and bind the SPM VMID on every GFXHUB instance

This commit reserves, binds, and unbinds the SPM VMID on every GFXHUB
instance rather than only on AMDGPU_GFXHUB(0).

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.c
> index 9c879ac683520..a4403e5cc3443 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -651,12 +651,78 @@ void amdgpu_vmid_free_spm(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm,
>  		id_mgr->reserved_vmid =3D false;
> =20
>  		if (adev->vm_manager.spm_vmid && adev->gfxhub.funcs)
> -			amdgpu_gmc_bind_vmid(adev, AMDGPU_GFXHUB(0),
> +			amdgpu_gmc_bind_vmid(adev, vmhub,
>  					     adev->vm_manager.spm_vmid, 0);
>  	}
>  	mutex_unlock(&id_mgr->lock);
>  }
> =20
> +/*
> + * amdgpu_vmid_alloc_spm_gfxhubs - reserve the SPM VMID on a set of GFXH=
UBs
> + * @adev: amdgpu device structure
> + * @vm: the VM to reserve the ID for
> + * @xcc_mask: XCC instances on whose GFXHUBs to reserve
> + *
> + * Reserve the SPM VMID on the GFXHUB of every XCC in @xcc_mask, so that
> + * the reservation covers every hub the VM's jobs can run on.
> + *
> + * Returns: 0 for success, the first per-hub error otherwise. On an error
> + * only the hubs this call reserved are released again, after waiting for
> + * the jobs which might have grabbed the reserved VMID in the meantime;
> + * hubs @vm already held before the call stay reserved.
> + */
> +int amdgpu_vmid_alloc_spm_gfxhubs(struct amdgpu_device *adev,
> +				  struct amdgpu_vm *vm, uint32_t xcc_mask)
> +{
> +	uint32_t allocated =3D 0;
> +	int i, r;
> +
> +	for_each_inst(i, xcc_mask) {
> +		bool held =3D amdgpu_vmid_uses_reserved(vm, AMDGPU_GFXHUB(i));
> +
> +		r =3D amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(i));
> +		if (r)
> +			goto error_free;
> +		if (!held)
> +			allocated |=3D BIT(i);
> +	}
> +
> +	return 0;
> +
> +error_free:
> +	/*
> +	 * A job may already have grabbed a freshly reserved VMID, give it
> +	 * the wait amdgpu_vmid_free_spm() demands before the rollback
> +	 * unbinds the VMID again.
> +	 */
> +	if (allocated) {
> +		dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
> +				      DMA_RESV_USAGE_READ, false,
> +				      MAX_SCHEDULE_TIMEOUT);
> +		amdgpu_vmid_free_spm_gfxhubs(adev, vm, allocated);
> +	}
> +	return r;
> +}
[ ... ]
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 94b1cfe05e3e0..f64020162a4bf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
[ ... ]
> @@ -3015,10 +3028,12 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
> =20
>  	switch (args->in.op) {
>  	case AMDGPU_VM_OP_RESERVE_VMID: {
> +		/* logical XCCs, the GFXHUB index space; xcc_mask is physical */
> +		uint32_t gfxhub_mask =3D GENMASK(NUM_XCC(adev->gfx.xcc_mask) - 1, 0);
>  		int r;
> =20
>  		/* We only have requirement to reserve vmid from gfxhub */
> -		r =3D amdgpu_vmid_alloc_spm(adev, vm, AMDGPU_GFXHUB(0));
> +		r =3D amdgpu_vmid_alloc_spm_gfxhubs(adev, vm, gfxhub_mask);
>  		if (!r && !amdgpu_bo_reserve(vm->root.bo, true)) {
>  			amdgpu_vm_spm_update(adev, vm);
>  			amdgpu_bo_unreserve(vm->root.bo);
>  		}
>  		return r;
>  	}

[Severity: Medium]
Can the error rollback in amdgpu_vmid_alloc_spm_gfxhubs() unbind a newly
reserved SPM VMID while a concurrent CS job is still using it?

Unlike AMDGPU_VM_OP_UNRESERVE_VMID, AMDGPU_VM_OP_RESERVE_VMID calls
amdgpu_vmid_alloc_spm_gfxhubs() without holding the vm->root.bo
reservation lock:

CPU0                              CPU1
amdgpu_vm_ioctl(RESERVE_VMID)
  amdgpu_vmid_alloc_spm_gfxhubs()
    amdgpu_vmid_alloc_spm(hub 0)
      vm->reserved_vmid[hub 0] =3D id
    amdgpu_vmid_alloc_spm(hub 1)
      -> -ENOENT
    dma_resv_wait_timeout(root)
                                  amdgpu_cs_ioctl()
                                    /* reserves root, adds fence */
                                  amdgpu_job_prepare_job()
                                    amdgpu_vmid_grab()
                                      /* grabs reserved VMID on hub 0 */
    amdgpu_vmid_free_spm(hub 0)
      amdgpu_gmc_bind_vmid(..., 0)  <-- unbinds VMID under active job

Because vm->root.bo is not reserved across the wait and free, a command
submission on the same VM can attach a new fence and grab the reserved
VMID on hub 0 after dma_resv_wait_timeout() returns and right before
amdgpu_vmid_free_spm() unbinds its page-table-base register to 0, causing
GPU page faults for the in-flight job.

Running without vm->root.bo reserved also leaves held =3D
amdgpu_vmid_uses_reserved() unsynchronized: amdgpu_vmid_alloc_spm()
returns 0 when vm->reserved_vmid[vmhub] is already set, so two concurrent
AMDGPU_VM_OP_RESERVE_VMID calls on the same VM can both observe held =3D=3D
false on hub 0 and set allocated |=3D BIT(0), causing a failure on a later
hub in one thread to free the reservation held by the other.  Similarly,
concurrent RESERVE_VMID and UNRESERVE_VMID calls can interleave across
hubs, and if amdgpu_bo_reserve(vm->root.bo, true) fails after
amdgpu_vmid_alloc_spm_gfxhubs() succeeds, amdgpu_vm_spm_update() is
skipped while returning 0.

Reserving vm->root.bo in AMDGPU_VM_OP_RESERVE_VMID before calling
amdgpu_vmid_alloc_spm_gfxhubs() and holding it across
amdgpu_vm_spm_update() (matching AMDGPU_VM_OP_UNRESERVE_VMID) would
serialize per-VM reservation state and prevent new CS jobs during rollback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117181941.3968=
996-1-James.Zhu@amd.com?part=3D2
