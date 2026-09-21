Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755A8C982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 11:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B92210E43F;
	Mon, 21 Sep 2026 11:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U/tMFUYF";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1068710E43F
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 11:39:47 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f6c7a58so422662166b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789990785; x=1790595585; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wJ2hRn6B1eaE80cCzxzR1lrfxD9SXujb8xXhVWox7ZQ=;
 b=U/tMFUYFVR2CpteG1Am5gmxUT68a1PBSh4hY2DWSG7ITFByRvkCDe3J26RA754JXBz
 K6TC6HPfUObEOr0Sz9xovl0uRxvwyhyJP2MYge0EKh9/688zbG5TMsTEGYqyh+65+UbM
 He5fhUiMMBJOJlTLKIFyWpFYQ6nwhBSMPq143LS9m06Ha/exYtV2rW317G/hDWZS0fsI
 mMsLoV/sI0cKNIh8hw+Pv/vU7oVgLi/OVQ1t34vYSbP9BYtCEIR1A8YZpAmfPuKDNcg7
 2mxto7EpLWPm8QnbRjYzrPCMiXLUw1blEOfxaMthvbQ1PMMlBlbuUSdZUBoaoYTxErIP
 Xb8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789990785; x=1790595585;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wJ2hRn6B1eaE80cCzxzR1lrfxD9SXujb8xXhVWox7ZQ=;
 b=E8t9peQVaNe+mJUkwk1+caIqhyKX0gP34+V4UmQVOV0DFmVbvdrTCR0VjbKcWl10gc
 L5HDFeNRMpBcQGcLXqiqShY97C/L9JPKMjpHSlexAVu64KrRql46l8kvgFgWR4WsD0Xd
 +S6tq3vAKcRGqnoI1ouVngd23RgCfrQkTrdldPLWwUcvP2ZaOd3PpWCl4ZtcAr4yYrIf
 yktrbH2YTk/eb0GLHmGt6II7F/PVO5RrIA50re0r0L7pb8rfuYTh8I4zc2H5QQSPCmhF
 yXRPwzkgBaYBFsz8j1KA/gqguoDa6y0XfKjYt79OqRjzkBLTkVV7viRaRWJfHA6WUnz4
 Pt8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzn45MgCcGEdHcVVYUDf9ByuUtoHxCoAvC8mxKD0tYkqzmlAeyyQ6LgoFUNHNobSmAT/IRjm0RD@lists.freedesktop.org
X-Gm-Message-State: AFuF++nlfxDCgwSuqabOPOW3tNNQmJrhOtAKN/JxmZP9NzK/cLk1bz1G
 +NiPRMPlT/7mxsdZMzoMlDSxe6vk+JrXTCUmq5NP3FinwNUChZWW7eqwNzokL6Z/
X-Gm-Gg: AYBFou1ceV/mb09zd/cpsI47U6rN22op8LZ0xDNVZidz+JqA1bUjd64w2vvbsI05a75
 QUwWL4DjZQ0PH00nHNdv0TCPNStMH5BEEpb16yKcAbwlc34fCqUgZ62SEYq7F0GdfDONNBHl1TA
 CVc4JgP+NWkGAMhj+BB5WbzUXI0dHv0xAyuuNeH1MPTtYws6GSJe10v+2SmeOxzNdZZhgHoS0h4
 wnkY3Hiqpz77nXNWvgHOVKHrNbjsCaiNqy4rJclKGxN3lNd4XpyNOGZ1gls3sWMkFuPwyVXWTm9
 iQYAdY8q+XgxqirMDLzm+kKVw7Qgmtaeywz8pybDBqwy6rA5jLuEeZ2CIYzBPMQIiOkaNNfgm1Y
 CNVOP5lCv4WQ7zwWg8KhE1BOmBVnlzqO/I3fb8Kc6ZHcCLY6UP463W6m0DTxMcrfYLR4j1Tvy8w
 rSJpF0XPI9QbivX2Rc1daFtxggRismKUb/iN63tq91WvYxD7b4yLTLjHzg1yn5XFt8q2+Wg6yDc
 C7cYdReSldaU+lC7vlqSXzTWH2cLSSDfWtURY229elFXUI=
X-Received: by 2002:a17:907:e0d2:10b0:c26:3107:71dd with SMTP id
 a640c23a62f3a-c2a2538ac4fmr448290866b.13.1789990785341; 
 Mon, 21 Sep 2026 04:39:45 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D96A.dsl.pool.telekom.hu.
 [84.1.217.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a35700b0esm292907866b.24.2026.09.21.04.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 04:39:44 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 Huang Yu <yhuang13@amd.com>
Cc: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>,
 Ray Huang <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>,
 Lingshan Zhu <lingszhu@amd.com>, Natalie Vock <natalie.vock@gmx.de>,
 AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 04/13] drm/amdgpu: add amdgpu_vm_pt_leaves()
Date: Mon, 21 Sep 2026 13:39:43 +0200
Message-ID: <YMrIvS2jT9--HXzN6611pg@gmail.com>
In-Reply-To: <20260917110158.296198-5-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
 <20260917110158.296198-5-yhuang13@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thursday, September 17, 2026 1:01:49=E2=80=AFPM Central European Summer =
Time Huang=20
Yu wrote:
> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
>=20
> Add a new function amdgpu_vm_update_leaves() to avoid memory allocation
> on page faults.
>=20
> The idea is to only update the leave PDEs/PTEs to let them point to the
> dummy page.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 55 +++++++++++-----
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 62 +++++++++++++++++++
>  3 files changed, 105 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 5675925ca656..e60143d4990c
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3013,10 +3013,12 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> *adev, u32 pasid, u32 vmid, u32 node_id, uint64_t addr,
>  			    uint64_t ts, bool write_fault)
>  {
> +	struct amdgpu_vm_update_params params;
>  	bool is_compute_context =3D false;
> -	struct drm_exec exec;
> -	uint64_t value, flags;
> +	uint64_t *values, flags;
>  	struct amdgpu_vm *vm;
> +	struct drm_exec exec;
> +	unsigned int idx;
>  	int r;
>=20
>  	drm_exec_init(&exec, 0, 1);
> @@ -3060,24 +3062,21 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> *adev, u32 pasid, }
>=20
>  	addr /=3D AMDGPU_GPU_PAGE_SIZE;
> -	flags =3D AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
> -		AMDGPU_PTE_SYSTEM;
> -
>  	if (is_compute_context) {
>  		/* Intentionally setting invalid PTE flag
>  		 * combination to force a no-retry-fault
>  		 */
>  		flags =3D AMDGPU_VM_NORETRY_FLAGS;
> -		value =3D 0;
> +		values =3D NULL;
>  	} else if (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_NEVER) {
>  		/* Redirect the access to the dummy page */
> -		value =3D adev->dummy_page_addr;
> -		flags |=3D AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
> -			AMDGPU_PTE_WRITEABLE;
> -
> +		flags =3D 0;

Why do you set the flags to zero here?

> +		values =3D adev->vm_manager.dummy_dst;
>  	} else {
>  		/* Let the hw retry silently on the PTE */
> -		value =3D 0;
> +		flags =3D AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
> +			AMDGPU_PTE_SYSTEM;
> +		values =3D NULL;
>  	}
>=20
>  	r =3D dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
> @@ -3086,12 +3085,38 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> *adev, u32 pasid, goto error_unlock;
>  	}
>=20
> -	r =3D amdgpu_vm_update_range(adev, vm, true, false, false, false,
> -				   NULL, addr, addr, flags, value,=20
0, NULL, NULL, NULL);
> -	if (r)
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		r =3D -ENODEV;
>  		goto error_unlock;
> +	}
>=20
> -	r =3D amdgpu_vm_update_pdes(adev, vm, true);
> +	amdgpu_vm_eviction_lock(vm);
> +	if (vm->evicting) {
> +		r =3D -EBUSY;
> +		goto error_dev_exit;
> +	}
> +
> +	memset(&params, 0, sizeof(params));
> +	params.adev =3D adev;
> +	params.vm =3D vm;
> +	params.immediate =3D true;
> +	params.pages_addr =3D NULL;
> +
> +	r =3D vm->update_funcs->prepare(&params, NULL,
> +				     =20
AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
> +	if (r)
> +		goto error_dev_exit;
> +
> +	amdgpu_vm_pt_leaves(&params, addr, addr, values, flags);
> +
> +	r =3D vm->update_funcs->commit(&params, &vm->last_update);


I think this shouldn't pass the last VM update.
Note that amdgpu_vm_sdma_commit() doesn't return a fence anyway when=20
params.immediate is true, so I think it's OK to just pass NULL here.



> +	if (r)
> +		goto error_dev_exit;
> +
> +	amdgpu_vm_eviction_unlock(vm);
> +
> +error_dev_exit:
> +	drm_dev_exit(idx);
>=20
>  error_unlock:
>  	drm_exec_fini(&exec);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h index
> 16cc0d5f5894..7d3c0904e1a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -121,6 +121,9 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_para=
ms
> *params, int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
> uint64_t start, uint64_t end,
>  			  uint64_t dst, uint64_t flags);
> +void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
> +			 uint64_t start, uint64_t end,
> +			 int64_t *dst, uint64_t flags);
>  void amdgpu_vm_pt_free_work(struct work_struct *work);
>  void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>  			    struct amdgpu_vm_update_params *params);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> 3a6449d60988..2f542c731447 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -936,6 +936,68 @@ int amdgpu_vm_ptes_update(struct
> amdgpu_vm_update_params *params, return 0;
>  }
>=20
> +/**
> + * amdgpu_vm_pt_leaves - update leave PDEs/PTEs

Typo: should be "leaf" instead of "leave".

> + *
> + * @params: see amdgpu_vm_update_params definition
> + * @start: start of GPU address range
> + * @end: end of GPU address range
> + * @dst: optional array with one dst addr per layer
> + * @flags: mapping flags
> + *
> + * Update the leave PDEs/PTEs in the range @start - @end without allocat=
ing
> or + * freeing page tables.
> + *
> + * Returns:
> + * 0 for success, negative error code for failure.
> + */
> +void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
> +			 uint64_t start, uint64_t end,
> +			 int64_t *dst, uint64_t flags)
> +{
> +	struct amdgpu_device *adev =3D params->adev;
> +	struct amdgpu_vm_pt_cursor cursor;
> +
> +	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
> +	while (cursor.pfn < end) {
> +		uint64_t entry_end, pe_start, val;
> +		unsigned int shift, mask;
> +		struct amdgpu_bo *pt;
> +		unsigned int nptes;
> +
> +		/* Walk to the leave entries */
> +		if (amdgpu_vm_pt_descendant(adev, &cursor))
> +			continue;
> +
> +		pt =3D cursor.parent->bo;
> +		shift =3D amdgpu_vm_pt_level_shift(adev, cursor.level -=20
1);
> +		mask =3D amdgpu_vm_pt_entries_mask(adev, cursor.level -=20
1);
> +
> +		/* Looks good so far, calculate parameters for the=20
update */
> +		pe_start =3D ((cursor.pfn >> shift) & mask) * 8;
> +
> +		entry_end =3D ((uint64_t)mask + 1) << shift;
> +		entry_end +=3D cursor.pfn & ~(entry_end - 1);
> +		entry_end =3D min(entry_end, end);
> +
> +		nptes =3D (entry_end - cursor.pfn) >> shift;
> +		/*
> +		 * This can happen when we set higher level PDEs to=20
unmap and/or
> +		 * silent to stop fault floods.
> +		 */
> +		nptes =3D max(nptes, 1u);
> +
> +		val =3D dst ? dst[cursor.level] : 0;
> +		trace_amdgpu_vm_update_ptes(params, cursor.pfn,=20
entry_end,
> +					    min(nptes, 32u),=20
val, 0, flags);
> +
> +		params->vm->update_funcs->update(params,=20
to_amdgpu_bo_vm(pt),
> +						 pe_start,=20
val, nptes, 0,
> +						 flags);
> +		amdgpu_vm_pt_next(adev, &cursor);
> +	}
> +}
> +
>  /**
>   * amdgpu_vm_pt_map_tables - have bo of root PD cpu accessible
>   * @adev: amdgpu device structure







