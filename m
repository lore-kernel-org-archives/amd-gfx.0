Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFB1606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFTwiiGM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 479CE112277;
	Thu, 12 Nov 2026 17:22:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41DC9112277
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 17:22:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 26FD54187C;
 Thu, 12 Nov 2026 17:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45941F000C4;
 Thu, 12 Nov 2026 17:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794504130;
 bh=vUFPXZ7lMfNDmTxa1ApyKCDwFSzhVcH7S0SBJ3kUmAs=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=FFTwiiGMO6K5yQpLLvzYUyp8meEogwzcT7AeFWUwNrWC9MuK6mEFtwJyX8Lqd+XU5
 Kz4HvzfRUZ8w6b/GuhQUC03Jy1Jkipt6DNxjJ42gDTn2frfl2WyBeZGJ7btHzcf0Eo
 QVr3tacX/vKMCcX2ss4H9rjSQex06aVO0H0KGT5Al21bZJu1q65lGPjLVjYHjzTpQg
 cjWV2qpb0D7h6djTCGyejA0Mqjzh8ucVLpQhEg5QqvT6ulnCAEBcTLGfG6LzMQp6YB
 GOrRBb8rNfQnNYiCwPWcWAWvHLCouic7fbKOUq+bfCM9fSYWWjpTOEHlmxCSLBrien
 pLpMQI50eZlPA==
Message-ID: <sashiko-outbox-211584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/amdgpu/vm: stop using amdgpu_bo_fence
To: "Benjamin Cheng" <benjamin.cheng@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261112164408.1748006-1-benjamin.cheng@amd.com>
References: <20261014022107.2511834-1-benjamin.cheng@amd.com>
 <20261112164408.1748006-1-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 17:22:09 +0000
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
- [High] drm/amdgpu/vm: insufficient fence slots in
  amdgpu_vm_update_range() after PT alloc
--

commit feeae3416bee7b1cf2e4fcd3fbeec98eb2fba53d
Author: Benjamin Cheng <benjamin.cheng@amd.com>

drm/amdgpu/vm: stop using amdgpu_bo_fence

This commit replaces amdgpu_bo_fence() in amdgpu_vm_update_range() with
dma_resv_reserve_fences() and dma_resv_add_fence() using
DMA_RESV_USAGE_BOOKKEEP.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 2ba33212d5071..2da64e2cfda47 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1212,10 +1212,18 @@ int amdgpu_vm_update_range(struct amdgpu_device *=
adev, struct amdgpu_vm *vm,
>  	if (r)
>  		goto error_free;
> =20
> +	if (!unlocked) {
> +		/* last_unlocked + SDMA commit + TLB flush */
> +		r =3D dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 3);
> +		if (r)
> +			goto error_free;
> +	}

[Severity: High]
Can reserving the SDMA commit and TLB flush fence slots before
amdgpu_vm_ptes_update() leave vm->root.bo->tbo.base.resv with no free
slot when a new page table BO is allocated?

When amdgpu_vm_ptes_update() allocates a new PT BO via
amdgpu_vm_pt_alloc(), the new BO shares vm->root.bo->tbo.base.resv.
During validation, ttm_bo_add_pipelined_eviction_fences() adds eviction
fences to that shared dma_resv and ends with:

drivers/gpu/drm/ttm/ttm_bo.c:ttm_bo_add_pipelined_eviction_fences() {
	...
	/* TODO: this call should be removed. */
	return dma_resv_reserve_fences(bo->base.resv, 1);
}

Because dma_resv_reserve_fences() is not additive, this only guarantees a
single free slot if the eviction fences filled all but one of the existing
slots.  amdgpu_vm_pt_alloc() then immediately calls amdgpu_vm_pt_clear(),
whose SDMA commit adds a fence on vm->delayed (or vm->immediate) without
reserving a slot, consuming that last free slot.

When amdgpu_vm_update_range() later calls vm->update_funcs->commit(), that
fence is replaced in-place on the same scheduler context, but
amdgpu_vm_tlb_flush() then adds a fence on vm->tlb_fence_context with zero
free slots remaining, hitting BUG_ON(fobj->num_fences >=3D fobj->max_fences)
in dma_resv_add_fence().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112164408.1748=
006-1-benjamin.cheng@amd.com?part=3D1
