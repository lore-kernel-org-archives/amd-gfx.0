Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2D8606A324
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDCYWHZC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A73F7112520;
	Thu, 19 Nov 2026 15:04:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A802E112512
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 15:04:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8A22C60E65;
 Thu, 19 Nov 2026 15:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2D31F000C4;
 Thu, 19 Nov 2026 15:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795100678;
 bh=WHfMkJEX1gg4gGWLLbxMErU+X0WVBzGaci5xPbCftkY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=MDCYWHZCQ5rm63ki4T3Dffbk5HpqWgpUw1227tngpse7URyLcZ+119xkBiSW989Hh
 ZAjgroFM0GhJMCoWCx87EPt3fLE9krjwdPi76VEXk+3ObEQwSCb1UQOWsVqAV5vsY/
 8KYcFqbd9YDxec5IMKwjivtLiyB18a6Hr5MUdhTceFuhLHMAImZIzNwGzzQC5hVAaC
 JU7hEMOy+7O/ZPcA1Rd3aHFc577/EeW2xTxzTgxQ0xxbMY7yh/UdlGpz2fEBuDz7Ld
 FXdajY0jQwSqNo1oV15kVD6QNnyB4QEW52OJVQAbS8glRDyyHK4PAdxOXAMO/pKvVg
 utNl8Buh/JqJg==
Message-ID: <sashiko-outbox-223337@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] drm/amdgpu/vm: stop using amdgpu_bo_fence
To: "Benjamin Cheng" <benjamin.cheng@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261119144049.2057674-5-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-1-benjamin.cheng@amd.com>
 <20261119144049.2057674-5-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 15:04:37 +0000
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
- [High] drm/amdgpu/vm: unreserved fence slot usage in
  amdgpu_vm_update_range()
--

commit 62a2ba953c5e8b9b18301c84fc57052868fd3e60
Author: Benjamin Cheng <benjamin.cheng@amd.com>

drm/amdgpu/vm: stop using amdgpu_bo_fence

This commit replaces the amdgpu_bo_fence() call in amdgpu_vm_update_range()
with a direct dma_resv_add_fence() call using DMA_RESV_USAGE_BOOKKEEP.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index a0e6bb34ae0be..d4d8cb15ffd38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1215,7 +1215,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *ad=
ev, struct amdgpu_vm *vm,
>  	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
>  		struct dma_fence *tmp =3D dma_fence_get_stub();
> =20
> -		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
> +		dma_resv_add_fence(vm->root.bo->tbo.base.resv, vm->last_unlocked,
> +				   DMA_RESV_USAGE_BOOKKEEP);
>  		swap(vm->last_unlocked, tmp);
>  		dma_fence_put(tmp);
>  	}

[Severity: High]
Can this dma_resv_add_fence() call consume an unreserved fence slot and
hit BUG_ON(fobj->num_fences >=3D fobj->max_fences) when vm->root.bo already
holds a newer fence from vm->delayed?

Callers such as amdgpu_vm_lock_pd() and amdgpu_dma_buf_move_notify()
reserve only two fence slots for VM updates (one for vm->delayed and one
for the TLB flush fence), relying on vm->last_unlocked and locked SDMA
commits sharing the vm->delayed slot.  However, dma_resv_add_fence() only
replaces an unsignaled same-context slot when
dma_fence_is_later_or_same(fence, old) is true.

An unlocked update on vm->delayed can leave vm->last_unlocked with a
seqno older than the fence already in vm->root.bo->tbo.base.resv:

CPU0 (locked update)              CPU1 (SVM MMU notifier)
amdgpu_vm_update_range()
  /* checks vm->last_unlocked */
  amdgpu_vm_ptes_update()
    amdgpu_vm_pt_alloc()
      amdgpu_vm_end_critical()
                                  svm_range_unmap_from_gpu()
                                    amdgpu_vm_update_range(unlocked=3Dtrue)
                                      /* submits seqno N on vm->delayed */
                                      /* vm->last_unlocked =3D seqno N */
      amdgpu_vm_begin_critical()
  /* submits seqno N+1 on vm->delayed */
  /* adds seqno N+1 to vm->root.bo */

amdgpu_vm_update_range()
  dma_resv_add_fence(..., vm->last_unlocked, ...)
    /* seqno N < seqno N+1: allocates a new slot */
    BUG_ON(fobj->num_fences >=3D fobj->max_fences)

The same ordering can occur when an unlocked update sets
vm->last_unlocked before amdgpu_vm_update_pdes(), which submits on
vm->delayed and adds its fence to vm->root.bo without flushing
vm->last_unlocked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119144049.2057=
674-1-benjamin.cheng@amd.com?part=3D5
