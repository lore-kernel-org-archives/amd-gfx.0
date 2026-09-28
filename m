Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 553D6CA5FA3
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 19:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C026E10EB6E;
	Mon, 28 Sep 2026 19:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BDzNS4mZ";
	dkim-atps=neutral
Received: from mail-vs2-f38.google.com (mail-vs2-f38.google.com
 [74.125.227.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFB8910EB6E
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 19:03:00 +0000 (UTC)
Received: by mail-vs2-f38.google.com with SMTP id
 ada2fe7eead31-7b3acd24099so1291246137.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 12:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790622179; x=1791226979; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RGkU9imnwnrxc8O9AN5cqdplYpQclAABNwf71Rz1yqA=;
 b=BDzNS4mZjKRPQNz0b0dJOz0lFfLwwGHF1kjdb7M+Hpz+dQYWKrWbWd1UAD+UxG7Wrv
 tfUe7bXZU4wzG7tsdApfAB8LauNGaZStCP5rPp0NCcgr69hEk6D3zFUwkMuPD/JdVjNy
 xyMJNt2npAgRJt4wV6D/YIz38MDx2aC8h/ffHFML8FSAEsmWGagsTvLRbIYzGRNMW3HB
 FlJuCs+LMx6Bh4dNtSHmYd8GeYSBvxEYc67IiT0E4kZxfqNS2ZjM7tUp9SQH9wzZwhh4
 WAcrETknXSBgib7vPwNkLVzpJ5H5VrPgar752RUWX0/iluM3MO0Q+t+7smbtYKRorQvY
 6Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790622179; x=1791226979;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RGkU9imnwnrxc8O9AN5cqdplYpQclAABNwf71Rz1yqA=;
 b=guk5dDBXJM0C9chSig5ZHBOYQ6HUysIL+vYb2vInlnlJixNEbYnkmBeST2qEE1iWtp
 iGu17YLnZvh14+wBPh7pKM7eR7Hc3gcJVsh2dI9IdOR4WcRjRa9iSmJYvjg0XnXY+bRD
 m53p4b7w0B+WZkfZnoMpOk04q1bKy8c0inTEh1lrU8BiJRI/BsI/DiA+SCnxTL7MJE5j
 unQWkO4se/VoS7FeYeXiisdA8b6pQIP4jnOf6hIuq6QW1Mw783BstZTATkX3/YSuvWDG
 oAbtbpTa4eUW4oQCHPlc3GJWFNEW3SaxNReKn9TAaR9bJ4dfKk9ucRq9UTuEMFKaqCwx
 yaHQ==
X-Gm-Message-State: AFq9FYLdqVWpB2OUPrPVoZCsq23t5wdt+oiJgduG8QDPHt62rUxunccC
 wychHN4xfHJ9md/A6W/h4zxrfrM4pxszHUcTV3Vx5ybF8g7QtJGEwA/m
X-Gm-Gg: AYBFou3uls1HlhDWbWIksL7VO5+g2T6ZltjXebTUQcMxaagd+tEmnpjmZ9yJyRJXag/
 oT6mFXCCy095jkbXY282OFNc3EIoPQTZp6ZQf1dHHuKWSRgw8CsR9jEhUAjibBM0sreZ8vnG4Iv
 L2R67UP3fYQOdE7UzLSAMznZCuIwnRmqgcxhKIhGD5qNXRQQ5c1wvnhzMG0AcnspPFX9AvdUG+t
 GbQzAeeFqpsXSc9SUwgXO6CofXDpUloQPfUPJnQ881YBtuxFBVqsj7G5iKf3SgTP7nzuQXr77u2
 UT78cp8t7vTQWqxGnl+gt9KcdzEd+yvymVy+IB8hwm+EKR/2ODgkE8wyB84tg5wmq9cLVbHsRmn
 3vXA0GeXdOh6bvA6NBvAm6p6ngEK2y11Bb2+FlQUAkbU1Deja25IcXyE+jwnC+wE/EfR2xU6rff
 Hu+oSZgrdnyNg7hZ/ofZWM/fvqr6OhRfgJGOuDp1y1UVe+FS4nORDYD1dytgqdzxhCBpVGIo55C
 MJnAZagAt4XoEAP23aTlZ0DzPPcOP+W77rP1syviPSZ5VJJjp9CNsWUlRdev5FZSUrckgZQ04sa
 BZZ81GoPrw==
X-Received: by 2002:a05:6102:1621:b0:7a5:2427:ecc1 with SMTP id
 ada2fe7eead31-7af1d6c4a8amr5359880137.19.1790622179407; 
 Mon, 28 Sep 2026 12:02:59 -0700 (PDT)
Received: from timur-max.localnet
 (ipagstaticip-88fc351e-cb28-db3e-3f52-ad13c70f08da.sdsl.bell.ca.
 [142.127.77.63]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5cde664c06esm9894754e0c.16.2026.09.28.12.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 12:02:58 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, cascardo@igalia.com,
 tvrtko.ursulin@igalia.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 3/9] drm/amdgpu: allocate and fill dummy PDs/PTs
Date: Mon, 28 Sep 2026 15:02:57 -0400
Message-ID: <jk4Y4GIRRPCeG-hxXaxSXg@gmail.com>
In-Reply-To: <20260928151041.1857-3-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
 <20260928151041.1857-3-christian.koenig@amd.com>
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

On 2026. szeptember 28., h=C3=A9tf=C5=91 11:10:35 keleti =C3=A1llamokbeli n=
y=C3=A1ri id=C5=91 Christian=20
K=C3=B6nig wrote:
> Allocate some PDs/PTs which just point to the dummy page.
>=20
> Those can be used in page faults to redirect recoverable page faults
> to the dummy page.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 11 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  7 ++-
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 57 +++++++++++++++++++
>  4 files changed, 74 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 7b9494375649f..f02a99b753c=
22
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2908,8 +2908,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,
> struct amdgpu_vm *vm) *
>   * Initialize the VM manager structures
>   */
> -void amdgpu_vm_manager_init(struct amdgpu_device *adev)
> +int amdgpu_vm_manager_init(struct amdgpu_device *adev)
>  {
> +	int r;
> +
>  	/* Concurrent flushes are only possible starting with Vega10 and
>  	 * are broken on Navi10 and Navi14.
>  	 */
> @@ -2921,6 +2923,10 @@ void amdgpu_vm_manager_init(struct amdgpu_device
> *adev) spin_lock_init(&adev->vm_manager.prt_lock);
>  	atomic_set(&adev->vm_manager.num_prt_users, 0);
>=20
> +	r =3D amdgpu_vm_pt_alloc_dummies(adev);
> +	if (r)
> +		return r;
> +
>  	/* If not overridden by the user, by default, only in large BAR=20
systems
>  	 * Compute VM tables will be updated by CPU
>  	 */
> @@ -2940,6 +2946,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device
> *adev) #else
>  	adev->vm_manager.vm_update_mode =3D 0;
>  #endif
> +
> +	return 0;
>  }
>=20
>  /**
> @@ -2951,6 +2959,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device
> *adev) */
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>  {
> +	amdgpu_vm_pt_free_dummies(adev);
>  	amdgpu_vmid_mgr_fini(adev);
>  	amdgpu_pasid_mgr_cleanup();
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index 98cdd7e3475fb..c59647554b4=
16
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -411,8 +411,11 @@ struct amdgpu_vm_manager {
>  	int				=09
vm_update_mode;
>=20
>  	/* Global registration of recent page fault information */
> -	struct amdgpu_vm_fault_info	fault_info;
> +	struct amdgpu_vm_fault_info		fault_info;
>  	unsigned int				npa_vmid;
> +
> +	struct amdgpu_bo			*dummy_pd[AMDGPU_VM_PTB=20
+ 1];
> +	uint64_t			=09
dummy_dst[AMDGPU_VM_PTB + 1];
>  };
>=20
>  struct amdgpu_bo_va_mapping;
> @@ -424,7 +427,7 @@ struct amdgpu_bo_va_mapping;
>  extern const struct amdgpu_vm_update_funcs amdgpu_vm_cpu_funcs;
>  extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
>=20
> -void amdgpu_vm_manager_init(struct amdgpu_device *adev);
> +int amdgpu_vm_manager_init(struct amdgpu_device *adev);
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
>=20
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h index
> 8ebb0b033291e..3c48a3401e2a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -130,6 +130,8 @@ void amdgpu_vm_pt_free_work(struct work_struct *work);
>  void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>  			    struct amdgpu_vm_update_params *params);
>  int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm
> *vm); +int amdgpu_vm_pt_alloc_dummies(struct amdgpu_device *adev);
> +void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
>=20
>  /**
>   * amdgpu_vm_begin_critical - start the critical section of the update
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> e8f441e018839..285f17c7705b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -990,3 +990,60 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *ad=
ev,
> struct amdgpu_vm *vm)
>=20
>  	return 0;
>  }
> +
> +/* amdgpu_vm_pt_alloc_dummies - allocate dummy PDs/PTs
> + *
> + * @adev: the amdgpu device pointer
> + *
> + * Allocate some dummy PDs/PTs which can be used to redirect page faults=
 to
> the + * dummy page.
> + */
> +int amdgpu_vm_pt_alloc_dummies(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_vm_manager *vm_mgr =3D &adev->vm_manager;
> +	int r;
> +
> +	for (int level =3D AMDGPU_VM_PTB; level !=3D vm_mgr->root_level;=20
level--) {
> +		size_t size =3D  amdgpu_vm_pt_size(adev, level);
> +		uint64_t addr, flags;
> +		void *ptr;
> +
> +		r =3D amdgpu_bo_create_kernel(adev, size, 0,
> +					   =20
AMDGPU_GEM_DOMAIN_VRAM,
> +					    &vm_mgr-
>dummy_pd[level],
> +					    &vm_mgr-
>dummy_dst[level],
> +					    &ptr);
> +		if (r)
> +			return r;
> +
> +		if (level =3D=3D AMDGPU_VM_PTB) {
> +			addr =3D adev->dummy_page_addr;
> +			/*
> +			 * TODO: We want to have separate dummies for=20
reads and
> +			 * writes.
> +			 */
> +			flags =3D AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED=20
|
> +				AMDGPU_PTE_SYSTEM |=20
AMDGPU_PTE_EXECUTABLE |
> +				AMDGPU_PTE_READABLE |=20
AMDGPU_PTE_WRITEABLE;
> +		} else {
> +			amdgpu_gmc_get_pde_for_bo(vm_mgr-
>dummy_pd[level + 1],
> +						  level,=20
&addr, &flags);
> +		}

The AMDGPU_PTE_IS_PTE flag is missing for GFX12.

I think we should either set that flag for GFX12 here, or use init_pte_flag=
s.
Otherwise retry faults will regress on GFX12 after this refactor.


> +
> +		for (int i =3D 0; i < amdgpu_vm_pt_num_entries(adev,=20
level); i++)
> +			amdgpu_gmc_set_pte_pde(adev, ptr, i, addr,=20
flags);
> +	}
> +
> +	return 0;
> +}
> +
> +void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev)
> +{
> +	struct amdgpu_vm_manager *vm_mgr =3D &adev->vm_manager;
> +	void *ptr;
> +
> +	for (int level =3D AMDGPU_VM_PTB; level !=3D vm_mgr->root_level;=20
level--)
> +		amdgpu_bo_free_kernel(&vm_mgr->dummy_pd[level],
> +				      &vm_mgr->dummy_dst[level],
> +				      &ptr);
> +}




