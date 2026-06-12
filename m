Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC7DFCD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 06:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D06B10F2A6;
	Fri, 12 Jun 2026 06:54:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pSxIocfe";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98FBE10E953
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:54:52 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso6183525e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 23:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781247291; x=1781852091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eZTJ4uVj4hDcSLanrhU5Pt0t0xESLCC5Ll88CHT3pR0=;
 b=pSxIocfe/xwDge3zK4Je9o2kYuhvdjNWleiKeQAPe/ngy5S6TdSqDzfL5Zx5sbItzN
 H8Jx/CnLlThHfR31sF4RYbg2BlE6dGzM2iIunr3bGKdmjpjeIMp5OTkWSljMVr88sFV5
 9OVC3IM1h9B8vqjPx6lUsR5AOhdaOEnTjdW6UuOjq+Am4/V1Z5HHPc7KCoN40rpc2lVa
 jMjYdsVCNVJMVx35B/RYU/saP7o0/B57KdHhz++4uhwuEEr3xkXvuvuzF2OFqMsI/Yut
 U1i6v7BZNr0YoNbqmhAxUNqZD/SDOORvi4n/6dxC2pGpibPBSUznfmlp+2z0qYuf9Toq
 LX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781247291; x=1781852091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eZTJ4uVj4hDcSLanrhU5Pt0t0xESLCC5Ll88CHT3pR0=;
 b=jWRh1STB2egD/Wsa+0lF/w+la7s4xeglUnky0L1cbG4SHM9EB0rufGJrM/5n74rcJk
 0fDxatseslNyybaoXayJ/jW3l+Qy+x3ac1YDxjohJBvHWNCNEGL1JTKfiEpnu8OBD3cR
 s/n+20LUfLhJwXm88CqOGKjMnx9KoS4jpwyIAZR5zUEUZfj5EBsabPs/O26hzcy1RlUy
 92itnjAuYGDADv5BdCnppIeemwtoKSg4gDoCIB0RBmGOADq5yezuO+aa2L8YsUrXExeT
 9l1GRaXwkcqttPiJLmTAJiLe9QTwMIv5UIE/dGku1Dj3Zz4Xvs77gjOlR5FUueC0efCl
 RFyg==
X-Gm-Message-State: AOJu0Yzb+XfD57P3429WcZo4TKQrNT+YDGqsAxymioFwIIArpzx5Cuym
 /g41PCCRepRxscqpMSJUBzrkyreWb3wwDbqQersAg0QYJdPLEKB52l44
X-Gm-Gg: Acq92OEReiV7uE8ZUoBZtK5k/NB65BMgIF87Dc+x4DrEVXaPkD0Sp6GxI7tWhRoKqos
 8mq1lhgZWF/3F8uh8wXyOmJ248oWh4xRyYN6CEqWXmMf36j2fPy4hqQzpbn30ybIjw9asWLbpmH
 v9R7ZhBMpHsBGkJ6lN9UlOZi6U73PLLNRCfrtQKMHY5pH4PzTeMPCK+1r6pBMVeeM9/heThpe5Q
 +Ve7UW2PDUdejyi9EgW2oODqyJkes1QttISXUiEc8rWZ1n+87TFD48MI+J3vuJHRASBLAATnr1r
 HC3/e2V/MnvEs36cRfEWZ2uWl8GhBNTty1vsD0DNxl04KfvFZEb9MvHhNTr3PNr/Vu1kNOdxk30
 MS+9tted5xrJKPEUnxz1ikNTfXVmffhqLsB/KnQYFO3948XbKF4gmfgaEAl1pKIesu24j07MK+A
 QulrU+6pxx0b4A5ZK2FfDUXuw80+thJCWnbFwSCVKFbVJzww+f1VQQIBqL9Hib/gZhXwPp42bme
 wdh7N/mepxC8Lxf1mDq7EbTMsCZ7g==
X-Received: by 2002:a05:600c:4693:b0:490:d9d0:51c8 with SMTP id
 5b1f17b1804b1-490ec504d3bmr18606035e9.18.1781247291016; 
 Thu, 11 Jun 2026 23:54:51 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e592csm2873627f8f.36.2026.06.11.23.54.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 23:54:50 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 06/13] drm/amdgpu: add amdgpu_vm_update_leaves()
Date: Fri, 12 Jun 2026 08:54:49 +0200
Message-ID: <2299736.hkbZ0PkbqX@timur-max>
In-Reply-To: <20260529114031.3714-7-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-7-christian.koenig@amd.com>
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

On 2026. m=C3=A1jus 29., p=C3=A9ntek 13:24:08 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> Add a new function amdgpu_vm_update_leaves() to avoid memory allocation
> on page faults.
>=20
> The idea is to only update the leave PTEs to insert a dummy PRT PTE.

We should only use PRT PTEs on GPUs that do not have the SMEM PRT bug,
in other words only GFX9 for now.

As-is, this basically regresses all the work that I did for retry faults.

Due to the SMEM PRT bug, using PRT PTEs is unacceptable because it would im=
ply=20
that we can only mitigate VM faults that come from VMEM instructions. That=
=20
creates unnecessary inconsistency (inability to mitigate some VM faults) an=
d=20
poor user experience (GPU hangs).

>=20
> TODO: HW older than GMC v9 needs a different solution.

Can you elaborate what different solution is needed?
As far as I know, GMC v6-v7-v8 do not use and do not need to call the=20
amdgpu_vm_handle_fault() function, they can just mitigate page faults on th=
eir=20
own.

>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 40 ++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 71 ++++++++++++++++++++++-
>  3 files changed, 103 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index e5588346a03f..94632a660b79
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2984,10 +2984,12 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> *adev, u32 pasid, u32 vmid, u32 node_id, uint64_t addr,
>  			    uint64_t ts, bool write_fault)
>  {
> -	bool is_compute_context =3D false;
> +	struct amdgpu_vm_update_params params;
> +	bool is_compute_context;
>  	struct amdgpu_bo *root;
>  	uint64_t value, flags;
>  	struct amdgpu_vm *vm;
> +	unsigned int idx;
>  	int r;
>=20
>  	vm =3D amdgpu_vm_lock_by_pasid(adev, &root, pasid);
> @@ -3029,24 +3031,46 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device
> *adev, u32 pasid, value =3D adev->dummy_page_addr;
>  		flags |=3D AMDGPU_PTE_EXECUTABLE | AMDGPU_PTE_READABLE |
>  			AMDGPU_PTE_WRITEABLE;
> -
> +		/* On +gfx9 we can use the PRT functionality instead */
> +		if (!adev->gmc.gmc_funcs->set_prt) {
> +			flags &=3D ~AMDGPU_PTE_VALID;
> +			flags |=3D AMDGPU_PTE_PRT;
> +		}

As noted above, PRT should only be used on GFX9 (and potentially, future=20
products where the SMEM PRT bug is fixed).

Also, checking the set_prt is not necessary here as this function only make=
s=20
sense on GFX9 and newer.

Maybe we could help the confusion by documenting both amdgpu_vm_handle_faul=
t()=20
and amdgpu_gmc_handle_retry_fault() that they are only applicable to GFX9 a=
nd=20
newer that support recoverable faults or retry faults. (In a separate commi=
t=20
from this one, though.)

>  	} else {
>  		/* Let the hw retry silently on the PTE */
>  		value =3D 0;
>  	}
>=20
> +	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
> +		r =3D -ENODEV;
> +		goto error_unlock;
> +	}
> +
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
>  	r =3D dma_resv_reserve_fences(root->tbo.base.resv, 1);
>  	if (r) {
>  		pr_debug("failed %d to reserve fence slot\n", r);
> -		goto error_unlock;
> +		goto error_eviction_lock;
>  	}
>=20
> -	r =3D amdgpu_vm_update_range(adev, vm, true, false, false, false,
> -				   NULL, addr, addr, flags, value,=20
0, NULL, NULL, NULL);
> -	if (r)
> -		goto error_unlock;
> +	amdgpu_vm_update_leaves(&params, addr, addr, value, flags);
>=20
> -	r =3D amdgpu_vm_update_pdes(adev, vm, true);
> +error_eviction_lock:
> +	amdgpu_vm_eviction_unlock(vm);
> +
> +error_dev_exit:
> +	drm_dev_exit(idx);
>=20
>  error_unlock:
>  	amdgpu_bo_unreserve(root);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index cc096c005e34..04b32accfa3f
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -613,6 +613,9 @@ int amdgpu_vm_pde_update(struct amdgpu_vm_update_para=
ms
> *params, int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
> uint64_t start, uint64_t end,
>  			  uint64_t dst, uint64_t flags);
> +void amdgpu_vm_update_leaves(struct amdgpu_vm_update_params *params,
> +			     uint64_t start, uint64_t end,
> +			     int64_t dst, uint64_t flags);
>  void amdgpu_vm_pt_free_work(struct work_struct *work);
>  void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>  			    struct amdgpu_vm_update_params *params);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> e43a60d09808..9766b6b9aecc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -790,6 +790,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_par=
ams
> *params, uint64_t dst, uint64_t flags)
>  {
>  	struct amdgpu_device *adev =3D params->adev;
> +	struct amdgpu_vm *vm =3D params->vm;
> +	pid_t tgid =3D vm->task_info ? vm->task_info->tgid : 0;

These spurious changes in amdgpu_vm_ptes_update() look unrelated the rest o=
f=20
the commit, so I think they should either be split off into a separate comm=
it=20
or explained in the commit message why they are necessary here.

>  	struct amdgpu_vm_pt_cursor cursor;
>  	uint64_t frag_start =3D start, frag_end;
>  	unsigned int frag;
> @@ -881,7 +883,6 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_par=
ams
> *params, entry_end =3D min(entry_end, end);
>=20
>  		do {
> -			struct amdgpu_vm *vm =3D params->vm;
>  			uint64_t upd_end =3D min(entry_end, frag_end);
>  			unsigned int nptes =3D (upd_end - frag_start)=20
>> shift;
>  			uint64_t upd_flags =3D flags |=20
AMDGPU_PTE_FRAG(frag);
> @@ -893,8 +894,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_par=
ams
> *params,
>=20
>  			trace_amdgpu_vm_update_ptes(params,=20
frag_start, upd_end,
>  						   =20
min(nptes, 32u), dst, incr,
> -						   =20
upd_flags,
> -						    vm-
>task_info ? vm->task_info->tgid : 0,
> +						   =20
upd_flags, tgid,
>  						    vm-
>immediate.fence_context);
>  			amdgpu_vm_pte_update_flags(params,=20
to_amdgpu_bo_vm(pt),
>  						  =20
cursor.level, pe_start, dst,
> @@ -938,6 +938,71 @@ int amdgpu_vm_ptes_update(struct
> amdgpu_vm_update_params *params, return 0;
>  }
>=20
> +/**
> + * amdgpu_vm_update_leaves - update leave PDEs/PTEs
> + *
> + * @params: see amdgpu_vm_update_params definition
> + * @start: start of GPU address range
> + * @end: end of GPU address range
> + * @dst: destination address to insert into the leave PDEs/PTEs
> + * @flags: mapping flags
> + *
> + * Update the leave PDEs/PTEs in the range @start - @end without allocat=
ing
> or + * freeing page tables.
> + *
> + * Returns:
> + * 0 for success, negative error code for failure.
> + */
> +void amdgpu_vm_update_leaves(struct amdgpu_vm_update_params *params,
> +			     uint64_t start, uint64_t end,
> +			     int64_t dst, uint64_t flags)
> +{
> +	struct amdgpu_device *adev =3D params->adev;
> +	struct amdgpu_vm *vm =3D params->vm;
> +	pid_t tgid =3D vm->task_info ? vm->task_info->tgid : 0;
> +	struct amdgpu_vm_pt_cursor cursor;
> +
> +	amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
> +	while (cursor.pfn < end) {
> +		unsigned int shift, mask;
> +		uint64_t entry_end, pe_start;
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
> +		trace_amdgpu_vm_update_ptes(params, cursor.pfn,=20
entry_end,
> +					    min(nptes, 32u),=20
dst, 0, flags,
> +					    tgid,
> +					    vm-
>immediate.fence_context);
> +		amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
> +					   cursor.level - 1,=20
pe_start, dst,
> +					   nptes, 0, flags);
> +
> +		amdgpu_vm_pt_next(adev, &cursor);
> +	}
> +}
> +
>  /**
>   * amdgpu_vm_pt_map_tables - have bo of root PD cpu accessible
>   * @adev: amdgpu device structure




