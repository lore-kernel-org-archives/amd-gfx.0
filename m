Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC33C982E1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 11:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45AEC10E488;
	Mon, 21 Sep 2026 11:37:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QpLiFzQl";
	dkim-atps=neutral
Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com
 [74.125.228.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C5D110E65A
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 11:37:53 +0000 (UTC)
Received: by mail-ej2-f43.google.com with SMTP id
 a640c23a62f3a-c2a7d46c5bbso33143766b.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 04:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789990672; x=1790595472; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HPnrDm8tD+/IQJqZPuwMwZRiBBcgk21hrnxfDa5EljY=;
 b=QpLiFzQlaa64CVAhBqD6OYjyu8SzPcEMz37sMEMcx22pMOupehBBs0NyE/Gj2H69ik
 2KP3c6MoaXntlPVYfolZDM0871VaBzz/IZ0I5x+nUDyX+YUCm/reh128IUa6tjb+YdGh
 SUdVvcS+Nkevj/KiA1UpJo04YW5HQf92U+4EOXGorlQoWD21KzaajREyIRXuSfF/NoAk
 cHv+TMgpxeplFULtYlsF3rUqaNkKHZhMIf3a0ehZwwPUjYi1jrHlLnoh5XcOEaCWR10v
 4Ku6kmF9PuyGNb1XfVFc1s/4o11pHd3zhtBjWVLiGzneCYqCZdhpjLFdvlTIB1Z560+p
 G4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789990672; x=1790595472;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HPnrDm8tD+/IQJqZPuwMwZRiBBcgk21hrnxfDa5EljY=;
 b=RNRSUrOOyQUM9HUibQgi3Zaqa8rBkYaai8AZ9xqgbLwNG2pyc1XZPlQwSaw6qF6R54
 37kDZDfzBICRaAWvQqVF0NrpZCU4qvfEV2bARpE+cH22b+w3z9Tb5H3zo1FGwv2r1/4w
 bLWQ2nFckeGhVOfLPjzu1BidcygIM62+SoOXEKwofQGqPKYtcVWF5HOgdnjYc024g5mS
 pCXP29pflxFilLqTTwcqD1/HKUeXQDjeNTfm8S9C6L4oXWn2XlQAvclTPW9FQNNh6nR3
 WX1zbCjT6iqB/+dhM6x4xQ1YSsBfT50CZvUeM45tMJq3t9CW1NlFaOz1cfI951oyqvu3
 k8ow==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKJindxwugH8JvCkVjCm8uOqLkQwQ3nC93AQ/4SbsmzkvD704Y2/PnwcuPzNbyuUZ1Aj6qRE/o@lists.freedesktop.org
X-Gm-Message-State: AFuF++n2r+y8vtQMCB8hA+kOKc1xp1hDPQ3DASDW/ofPTCepE3lQjpo5
 YvsqrFeefqp7d7Pc8M5dT7NStcvlByREOwVgnKpXQFHWbMk9uVyHPZBJ
X-Gm-Gg: AYBFou3X4rLqZ5PT96caq0TS/eTf07kxSS/U+o9RHWasEnnmYpPhh8e8uTEO//5LSYU
 SCxv94QQ+6syOSJ4lYRg5zWHww0hIxw+phyAEgAEgLTPzcfjkcdkhDor5tAZsfOzNm7/2YOlM5R
 1Cgm+fp+u8U6hF5d6KeohP9YAy4k5B+ObUgjezBxy9MXfBkU4uL2eHiVQkITTugf8xa/mE7Pvzq
 YmvpKfasp3EmhkgBJUstj8B5az4u+eOw0acs3ZdSpHUxjeIwkmnjIqT5rSrkhkGefVqVxysEB02
 S1lAHuhCNhao+KSRP1rZPGEOt+0TlxXvSbM93gW6UCaVMS8k+1hjaVRDZA3FwoUiHfArTsbQQdl
 /KkjDLWqQto0Js1UyX1eeoLQSYxOwlhRwl8bVMMQPzuBUGUMqqHPC4QjRI5Pnis+jvgElfszQ2M
 hsgPx8VUuT4jhmbBnQS6iwhEfbb2rzlwWLq1drJscB2YbiTkAwgpRS2WakTvjqc7k91hSSL4yw0
 gdKM7QKAVfAjTlqukb/6nMLpYFv6GZxJKBgCH7LvN7/nDM=
X-Received: by 2002:a17:907:7a8f:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c2a164421c7mr885275866b.6.1789990671632; 
 Mon, 21 Sep 2026 04:37:51 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D96A.dsl.pool.telekom.hu.
 [84.1.217.106]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a3523809fsm290712166b.5.2026.09.21.04.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 04:37:51 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
 Huang Yu <yhuang13@amd.com>
Cc: Yu Huang <Yu.Huang@amd.com>, Honglei Huang <honghuan@amd.com>,
 Ray Huang <ray.huang@amd.com>, Shen Junhua <junhshen@amd.com>,
 Lingshan Zhu <lingszhu@amd.com>, Natalie Vock <natalie.vock@gmx.de>,
 AMD-GFX <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 03/13] drm/amdgpu: allocate and fill dummy PDs/PTs
Date: Mon, 21 Sep 2026 13:37:50 +0200
Message-ID: <P8HWfzzXTSi7EfI0L9PzAA@gmail.com>
In-Reply-To: <20260917110158.296198-4-yhuang13@amd.com>
References: <20260917110158.296198-1-yhuang13@amd.com>
 <20260917110158.296198-4-yhuang13@amd.com>
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

On Thursday, September 17, 2026 1:01:48=E2=80=AFPM Central European Summer =
Time Huang=20
Yu wrote:
> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
>=20
> Allocate some PDs/PTs which just point to the dummy page.
>=20
> Those can be used in page faults to redirect recoverable page faults
> to the dummy page.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Makes good sense.

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 11 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  5 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 57 +++++++++++++++++++
>  4 files changed, 73 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c index 517490946a9c..5675925ca656
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2843,8 +2843,10 @@ void amdgpu_vm_fini(struct amdgpu_device *adev,
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
> @@ -2856,6 +2858,10 @@ void amdgpu_vm_manager_init(struct amdgpu_device
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
> @@ -2875,6 +2881,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device
> *adev) #else
>  	adev->vm_manager.vm_update_mode =3D 0;
>  #endif
> +
> +	return 0;
>  }
>=20
>  /**
> @@ -2886,6 +2894,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device
> *adev) */
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>  {
> +	amdgpu_vm_pt_free_dummies(adev);
>  	amdgpu_vmid_mgr_fini(adev);
>  	amdgpu_pasid_mgr_cleanup();
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h index ac3b8e8525c1..826406522b24
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -409,6 +409,9 @@ struct amdgpu_vm_manager {
>=20
>  	/* Global registration of recent page fault information */
>  	struct amdgpu_vm_fault_info	fault_info;
> +
> +	struct amdgpu_bo		*dummy_pd[AMDGPU_VM_PTB + 1];
> +	uint64_t			dummy_dst[AMDGPU_VM_PTB + 1];
>  };
>=20
>  struct amdgpu_bo_va_mapping;
> @@ -420,7 +423,7 @@ struct amdgpu_bo_va_mapping;
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
> 447195cc4593..16cc0d5f5894 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -125,6 +125,8 @@ void amdgpu_vm_pt_free_work(struct work_struct *work);
>  void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
>  			    struct amdgpu_vm_update_params *params);
>  int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm
> *vm); +int amdgpu_vm_pt_alloc_dummies(struct amdgpu_device *adev);
> +void amdgpu_vm_pt_free_dummies(struct amdgpu_device *adev);
>=20
>  /*
>   * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-=
=46S
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c index
> b85b70a1a428..3a6449d60988 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -963,3 +963,60 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *ad=
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




