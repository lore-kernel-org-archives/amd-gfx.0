Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38A0CA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 19:07:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EBA810E959;
	Mon, 28 Sep 2026 19:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ltp0uqVX";
	dkim-atps=neutral
Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com
 [74.125.227.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F49A10E959
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 19:07:19 +0000 (UTC)
Received: by mail-vs2-f37.google.com with SMTP id
 71dfb90a1353d-5cfd29f1208so536986e0c.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790622438; x=1791227238; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xZlbQFiuQV7hD1JiBkCSn85a05uY8iO0GS6mREgmS2s=;
 b=Ltp0uqVXRQb/+j3cGcpKFBnAWmXxppTtp8HjYJrBx0w/NIhk7g42fRuBIJ9jXHE+UW
 FaJRtwKSepKVCKXDDsRw6quwhxoqUWfhxo3U87lI00Qj6RprHX4ex8jMPmK24EfgfFLc
 WtFsgO+2tPrkYq1/RotVlOnkQtwzRpzHi+OlG0YURulxjKcQuiY5bd3iGaFx+87cgUak
 hjJMfyokg2770xyPbtSfcmGt4A2EXyErzkmocJ+q90GlcOcM1btjZOsUl+/HXS/NtVTn
 zUshTtqQSl70WLqdfH7f1BOvSzkVALY2USLufXDGNKZjrghTnGuOh17tZeakorJPux0L
 1L5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790622438; x=1791227238;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xZlbQFiuQV7hD1JiBkCSn85a05uY8iO0GS6mREgmS2s=;
 b=GSMQQQTAOmneF2zOmmyB9LHhxooI1pv/q6Vc0wBcDSCYTPceLAZ4Bux25/babbxsJS
 i9GvH/IrYUELWaGMXE+xUMmonN8idwUCeVYLwQQT/IhpMfRarcj9/3fEbus5RGa7EDte
 iIrrP0OdhPZQDPWkL7HIYpL10vaAoQ7A5c8K1g7/qNGYqLAFkYbqsno44zxQfqKq9skk
 KY+RMCQdkd4DGLgTszCm8XLEeU4X5oCOVvrk22UgVwGcdjylaojl8QVQVcKMIvYOrA3z
 2fcKdSw8n9R0nuU4LtGG171v7QDSac7sbCJXTZjA9cuc/S6oopFrkm+Tih0TzBbkCnPq
 qFaQ==
X-Gm-Message-State: AFq9FYIbvGdOOH0g/WvVR3rBv0RQtU5/1sXk6tx4zN5uR6bR9NLS+88k
 HYSxI2aEkD3RhUFPg2JJjWU87Odb2QZnOdUP2/5oUA+p4nduH+4GgD9w
X-Gm-Gg: AYBFou1CBa8d0tWg5JDk/outYgsuBgUosjan9NDL6yPkYB2i0pkWOFypRX1hRytL+WA
 6vo8gPhK+QZ9HVl1AUWAtaNZ3Y4rvzbREQj7a7/rpWPQMQfpGIYoW8ak4sSkWNchY4cIcESprwY
 FV9qGvXjm6yEhpxuO9Vt938hVLAnBd3KtObwY5aeRu3RcAvmj2WXTN7W6OPBupJOolFHyPidDmg
 BcTb9fGAUmIwN2tDOkHc8PCY6r3AOiIkGi0oORc3ghV1ddcB5Y6io7Z0dlGAwRxQfmxqC3z9zov
 hIx5O4vUkW+4J/iT+u4n8luNFl6Qo/OjQphcXw1Oh1goj2Lr4/RVQi/d7DOpg9ekHICRj+H7/Tl
 jVebhyi71FApkLweVNV0FPuOIfHvDvTSrowNPLFKsC6SYcvIkCg3GDPUH5yuaQW+6SNa3rW6Xi7
 RbPKUEHnEn3cnU9l1zuJrcFZarJprEJdOwyhqLsv5upSzFOWBgiGrR9C6zdKZVrj3j6u4nodUUa
 +Fg5sn3rva0+zq4Jb8ny+jpTKvlZln3/NKO4uHN+Pe7uM3y9XeEMChnoFyNgYUolWLITYfgJ+WC
 GDD1ZPUg7A==
X-Received: by 2002:a05:6102:4488:b0:7b3:4199:2dc4 with SMTP id
 ada2fe7eead31-7b34199433amr1930438137.8.1790622437762; 
 Mon, 28 Sep 2026 12:07:17 -0700 (PDT)
Received: from timur-max.localnet
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7b398ee9869sm10612553137.1.2026.09.28.12.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:07:17 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, cascardo@igalia.com,
 tvrtko.ursulin@igalia.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 4/9] drm/amdgpu: add amdgpu_vm_pt_leaves() v2
Date: Mon, 28 Sep 2026 15:07:15 -0400
Message-ID: <0LalfKr0TrmjCRha1xVOMw@gmail.com>
In-Reply-To: <20260928151041.1857-4-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-4-christian.koenig@amd.com>
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

On 2026. szeptember 28., h=C3=A9tf=C5=91 11:10:36 keleti =C3=A1llamokbeli n=
y=C3=A1ri id=C5=91 Christian=20
K=C3=B6nig wrote:
> Add a new function amdgpu_vm_update_leaves() to avoid memory allocation
> on page faults.
>=20
> The idea is to only update the leave PDEs/PTEs to let them point to the
> dummy page.
>=20
> v2: fix of by one, rework the function to work correctly on PTB as well.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 54 ++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  5 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 74 +++++++++++++++++++
>  4 files changed, 119 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index f02a99b753c22..d6358cbfcc9=
b1
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3078,10 +3078,12 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> *adev, u32 pasid, u32 vmid, u32 node_id, uint64_t addr,
>  			    uint64_t ts, bool write_fault)
>  {
> +	struct amdgpu_vm_update_params params;
>  	bool is_compute_context =3D false;
> -	struct drm_exec exec;
> -	uint64_t value, flags;
> +	uint64_t *dst, flags[AMDGPU_VM_MAX_LEVEL];
>  	struct amdgpu_vm *vm;
> +	struct drm_exec exec;
> +	unsigned int idx;
>  	int r;
>=20
>  	drm_exec_init(&exec, 0, 1);
> @@ -3125,24 +3127,24 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> *adev, u32 pasid, }
>=20
>  	addr /=3D AMDGPU_GPU_PAGE_SIZE;
> -	flags =3D adev->gmc.init_pte_flags |
> -		AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
> -		AMDGPU_PTE_SYSTEM;
> -
>  	if (is_compute_context) {
>  		/* Intentionally setting invalid PTE flag
>  		 * combination to force a no-retry-fault
>  		 */
> -		flags =3D AMDGPU_VM_NORETRY_FLAGS;
> -		value =3D 0;
> +		for (int i =3D 0; i < AMDGPU_VM_MAX_LEVEL; ++i)
> +			flags[i] =3D AMDGPU_VM_NORETRY_FLAGS;
> +		dst =3D NULL;
>  	} else if (amdgpu_vm_fault_stop =3D=3D AMDGPU_VM_FAULT_STOP_NEVER) {
>  		/* Redirect the access to the dummy page */
> -		value =3D adev->dummy_page_addr;
> -		flags |=3D AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
> -			 AMDGPU_PTE_WRITEABLE;
> +		for (int i =3D 0; i < AMDGPU_VM_MAX_LEVEL; ++i)
> +			flags[i] =3D 0;
> +		dst =3D adev->vm_manager.dummy_dst;
>  	} else {
>  		/* Let the hw retry silently on the PTE */
> -		value =3D 0;
> +		for (int i =3D 0; i < AMDGPU_VM_MAX_LEVEL; ++i)
> +			flags[i] =3D AMDGPU_PTE_VALID |=20
AMDGPU_PTE_SNOOPED |
> +				AMDGPU_PTE_SYSTEM;
> +		dst =3D NULL;
>  	}
>=20
>  	r =3D dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
> @@ -3151,12 +3153,32 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
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
> +
> +	memset(&params, 0, sizeof(params));
> +	params.adev =3D adev;
> +	params.vm =3D vm;
> +	params.immediate =3D true;
> +
> +	r =3D amdgpu_vm_begin_critical(&params);
> +	if (r)
> +		goto error_end_critical;
> +
> +	r =3D vm->update_funcs->prepare(&params, NULL,
> +				     =20
AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
> +	if (r)
> +		goto error_end_critical;
>=20
> -	r =3D amdgpu_vm_update_pdes(adev, vm, true);
> +	amdgpu_vm_pt_leaves(&params, addr, addr + 1, dst, flags);
> +
> +	r =3D vm->update_funcs->commit(&params, &vm->last_update);

We shouldn't overwrite vm->last_update here.
You can just pass NULL here for now.

> +
> +error_end_critical:
> +	amdgpu_vm_end_critical(&params);
> +	drm_dev_exit(idx);
>=20
>  error_unlock:
>  	drm_exec_fini(&exec);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index c59647554b416..ec5cd38fe4e=
34
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -195,7 +195,10 @@ enum amdgpu_vm_level {
>  	AMDGPU_VM_PDB2,
>  	AMDGPU_VM_PDB1,
>  	AMDGPU_VM_PDB0,
> -	AMDGPU_VM_PTB
> +	AMDGPU_VM_PTB,
> +
> +	/* Not HW level, but for array sizing */
> +	AMDGPU_VM_MAX_LEVEL

Instead of AMDGPU_VM_MAX_LEVEL this should be called AMDGPU_VM_NUM_LEVELS

>  };
>=20
>  /* base structure for tracking BO usage in a VM */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h index
> 3c48a3401e2a4..dafdb3a001b8e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -126,6 +126,9 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_para=
ms
> *params, int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
> uint64_t start, uint64_t end,
>  			  uint64_t dst, uint64_t flags);
> +void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
> +			 uint64_t start, uint64_t end,
> +			 int64_t *dst, uint64_t *flags);
>  void amdgpu_vm_pt_free_work(struct work_struct *work);
>  void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>  			    struct amdgpu_vm_update_params *params);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> 285f17c7705b4..27003b03b5fdb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -963,6 +963,80 @@ int amdgpu_vm_ptes_update(struct
> amdgpu_vm_update_params *params, return 0;
>  }
>=20
> +/**
> + * amdgpu_vm_pt_leaves - update leaf PDEs/PTEs
> + *
> + * @params: see amdgpu_vm_update_params definition
> + * @start: start of GPU address range
> + * @end: end of GPU address range
> + * @dst: optional array with one dst addr per layer
> + * @flags: array of mapping flags per layer
> + *
> + * Update the leaf PDEs/PTEs in the range @start - @end without allocati=
ng
> or + * freeing page tables.
> + *
> + * Returns:
> + * 0 for success, negative error code for failure.
> + */
> +void amdgpu_vm_pt_leaves(struct amdgpu_vm_update_params *params,
> +			 uint64_t start, uint64_t end,
> +			 int64_t *dst, uint64_t *flags)
> +{
> +	struct amdgpu_device *adev =3D params->adev;
> +	struct amdgpu_vm_pt_cursor cursor;
> +
> +	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
> +	while (cursor.pfn < end) {
> +		unsigned int level, shift, mask, nptes;
> +		uint64_t pe_start, entry_start, entry_end, d, f;
> +		struct amdgpu_bo *pt;
> +
> +		/* Walk to the leave entries */
> +		if (amdgpu_vm_pt_descendant(adev, &cursor))
> +			continue;
> +
> +		if (cursor.entry->bo) {
> +			level =3D cursor.level;
> +			pt =3D cursor.entry->bo;
> +		} else {
> +			level =3D cursor.level - 1;
> +			pt =3D cursor.parent->bo;
> +		}
> +
> +		shift =3D amdgpu_vm_pt_level_shift(adev, level);
> +		mask =3D amdgpu_vm_pt_entries_mask(adev, level);
> +
> +		/* Looks good so far, calculate parameters for the=20
update */
> +		pe_start =3D ((cursor.pfn >> shift) & mask) * 8;
> +
> +		entry_start =3D cursor.pfn;
> +		if (cursor.entry->bo) {
> +			entry_end =3D ((uint64_t)mask + 1) << shift;
> +			entry_end +=3D cursor.pfn & ~(entry_end - 1);
> +			entry_end =3D min(entry_end, end);
> +
> +			nptes =3D (entry_end - cursor.pfn) >> shift;
> +			amdgpu_vm_pt_next(adev, &cursor);
> +		} else {
> +			nptes =3D 0;
> +			entry_end =3D cursor.pfn;
> +			do {
> +				nptes +=3D 1;
> +				entry_end +=3D 1 << shift;
> +				amdgpu_vm_pt_next(adev, &cursor);
> +			} while (cursor.parent && cursor.parent->bo=20
=3D=3D pt &&
> +				 cursor.pfn < end && !
cursor.entry->bo);
> +		}
> +
> +		d =3D dst ? dst[level] : 0;
> +		f =3D flags[level];
> +		trace_amdgpu_vm_update_ptes(params, entry_start,=20
entry_end,
> +					    min(nptes, 32u), d,=20
0, f);
> +		params->vm->update_funcs->update(params,=20
to_amdgpu_bo_vm(pt),
> +						 pe_start,=20
d, nptes, 0, f);
> +	}
> +}
> +
>  /**
>   * amdgpu_vm_pt_map_tables - have bo of root PD cpu accessible
>   * @adev: amdgpu device structure




