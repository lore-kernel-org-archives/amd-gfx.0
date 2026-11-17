Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5F606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bum5WHa0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C816110F848;
	Tue, 17 Nov 2026 17:18:29 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EB8F10F854
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 17:18:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A0367609FF;
 Tue, 17 Nov 2026 17:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2611F000C5;
 Tue, 17 Nov 2026 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794935902;
 bh=Qz6JJBMtft81MssCgLCixTQCuxZA9HjcrS6n3UgGq6E=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=bum5WHa0x8AP6CqYWVTKVUADDyUXOV2OMJ8RNj8peB5RqmCAfZg5ZIrPESmdJzVWW
 y0sbiGDhjRDrvsnPxvQ9939FUSCtOypYB24co+s/kg0W+8juiXGDcZEu6VUhO15LjQ
 BG+unHcNKLafM2xJvCf/NIQDdNGaC0sw9jN5Oc/Wu8bFYCCphA+UUbhU6f21khUKCk
 QN80popPACcXZHC8xlfv4sEUx8eSozc3HLSdv/gG5RkWq8APyLb1XmD9BCblucpzhL
 /n9CKgvTkOfWBteIKdppdUyNVD++PCJs9XdFlTA2OFIKW51UhF99TlNVhN2vS82mjp
 2sRh2MSePqr2w==
Message-ID: <sashiko-outbox-219223@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/3] drm/amdgpu: scope AMDGPU_VM_OP_RESERVE_VMID to
 the caller's partition
To: "James Zhu" <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117165952.3558762-4-James.Zhu@amd.com>
References: <20261117165952.3558762-1-James.Zhu@amd.com>
 <20261117165952.3558762-4-James.Zhu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 17:18:21 +0000
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
- [High] drm/amdgpu: skipped wait in amdgpu_vm_fini() for partition SPM
  VMID
- [Medium] drm/amdgpu: unchecked amdgpu_xcp_get_inst_details() in
  amdgpu_vm_ioctl()
--

commit a5f43653ba23f302ebd963bef5053a4d46508cd1
Author: James Zhu <James.Zhu@amd.com>

drm/amdgpu: scope AMDGPU_VM_OP_RESERVE_VMID to the caller's partition

This commit scopes AMDGPU_VM_OP_RESERVE_VMID to the GFXHUB instances of
the caller's compute partition when fpriv->xcp_id is set.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index e1691145da903..8098fbb542c82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3021,11 +3021,21 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void =
*data, struct drm_file *filp)
> =20
>  	switch (args->in.op) {
>  	case AMDGPU_VM_OP_RESERVE_VMID: {
> +		uint32_t xcc_mask =3D adev->gfx.xcc_mask;
>  		int r;
> =20
> +		/*
> +		 * Scope the reservation to the hardware partition behind the
> +		 * caller's render node, so other partitions can hold the
> +		 * reserved VMID on their own XCCs independently.
> +		 */
> +		if (adev->xcp_mgr && fpriv->xcp_id !=3D AMDGPU_XCP_NO_PARTITION)
> +			amdgpu_xcp_get_inst_details(
> +					&adev->xcp_mgr->xcp[fpriv->xcp_id],
> +					AMDGPU_XCP_GFX, &xcc_mask);

[Severity: Medium]
Should the return value of amdgpu_xcp_get_inst_details() be checked here?

If a runtime compute partition switch reduces the number of partitions
while a DRM file opened on a higher-numbered partition remains open,
xcp[fpriv->xcp_id].valid becomes false and amdgpu_xcp_get_inst_details()
returns -EINVAL without updating xcc_mask.  The reservation then silently
falls back to adev->gfx.xcc_mask and reserves the SPM VMID across every
GFXHUB on the device.

> +
>  		/* We only have requirement to reserve vmid from gfxhub */
> -		r =3D amdgpu_vmid_alloc_spm_gfxhubs(adev, vm,
> -						  adev->gfx.xcc_mask);
> +		r =3D amdgpu_vmid_alloc_spm_gfxhubs(adev, vm, xcc_mask);

[Severity: High]
When a process on a non-zero partition (fpriv->xcp_id > 0) closes its DRM
file without calling AMDGPU_VM_OP_UNRESERVE_VMID, does amdgpu_vm_fini()
skip waiting for in-flight jobs before unbinding and freeing the reserved
SPM VMID?

For fpriv->xcp_id > 0, xcc_mask only includes that partition's XCCs, so
vm->reserved_vmid[AMDGPU_GFXHUB(0)] stays NULL.  Unlike
AMDGPU_VM_OP_UNRESERVE_VMID, amdgpu_vm_fini() only checks GFXHUB(0) before
waiting and then frees the SPM VMID on all hubs:

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

amdgpu_vmid_free_spm() then unbinds spm_vmid to address 0 and clears
id_mgr->reserved_vmid while GPU jobs on that partition are still running
under spm_vmid, causing in-flight work to page-fault and letting another
process rebind the VMID concurrently.  Checking all GFXHUBs in
adev->gfx.xcc_mask in amdgpu_vm_fini(), matching
AMDGPU_VM_OP_UNRESERVE_VMID, would avoid this regression.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117165952.3558=
762-1-James.Zhu@amd.com?part=3D3
