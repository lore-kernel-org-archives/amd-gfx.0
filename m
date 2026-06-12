Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C556ECD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 06:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E4A10F276;
	Fri, 12 Jun 2026 06:18:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="no5ryuCF";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F9210F276
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:18:44 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so5589445e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 23:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781245123; x=1781849923; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsK/yGNKaULZhNqCiwUNCw6nu/Z/eLg38Ix6fcoJKk4=;
 b=no5ryuCFtjppilFGW9u2XXY++pZBJTw+xaQVxGAtU94QPCiu+G/WIy7WcVa+xF26TE
 0PEsAw8hkANOmUMbdgCVaMnIFDJJlLVb+lDB0uUyxDlwEvcMY8CDUBr0KfO7d+ynwsNH
 dHJM2cJZibzvyXuQ3WBpTBq1byh9aqBEDj4aDxJvjPSymn/TEmbFnvNkfMSgMaDT8oYW
 F3q1NCCAi+pzqkLZnz5aYPXRYGOFsX+GQ6xhSqGVEfcAbYDVIVcUNbgon+YQECiwhYhy
 5nMKQH9w8y9yY9midJQQV3A0VS+GdUcP6zazD2Ap7W5PPAmLMtHuEwVXebGxgMmDsaAb
 Mb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781245123; x=1781849923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wsK/yGNKaULZhNqCiwUNCw6nu/Z/eLg38Ix6fcoJKk4=;
 b=Z351nfMFEhixUW+R25dTQnThT7jk3XT8Dlr9NzEBMh8WSwubOIuG8RzrAW190VF8zx
 9H3/cWH0HfL62Vpg7Hzam/t/RGMXqlvHQQ1V3WLk02x9dKo+NvvrhQvd/WbYF0S/fqS0
 Uc3n9njGAWIvPN585h/B6w34mOud8fD62dlrPZ/oAmlOEZAedsKE69LEh61ENNiH7ufs
 U0PmVMaG3SPxfymtuoCWLDyZo9jO2RY5wxe9/VnMrN9DUqkROeYwZBD1dJqXPLdCpVH2
 sFjN3llusgJTT+CwiJJO1FT7bVtAxiFa+H053RPMMTYQyI4v8blIcIVFG1vWtDPTl3cO
 hnyA==
X-Gm-Message-State: AOJu0YwqYwLF27p7xP0LR/PBjwkBzs/KYfReu0mQ7QhS/FYW2dJTXKnQ
 Qtg68RBdbQ1r3qDZ3CSA4gC0TeYihHARC1ydjRom12eUGFXZ9dGMAZ7H
X-Gm-Gg: Acq92OGuiFBh/hYyU/ObdOSONj29RgmHHl1Hmy3TbWJvDWPH/068WTbUyTUb3Ppbi1D
 UqK0Qp+/r3Y8LGtiZ9sgqjXVU+nJuDBeNiiRo4+uKoU2UEVCMbVLQBLbFzcavonE64CxQDs5bgv
 vHZDjcFt+4qxItMCjkki5/ycDLDAEae6S7Q11UNsUSO4vJGCrfrPMjkYbr74R879txThcHYXkMj
 0BGs1nTyKt36xv7HcUqKhV/Qf5f2NbBnf89mpslm8S7oRbutDw/yNgnSp4mBHJJHlS93SL7dqAk
 PBjjTRGZrJZCz9HMsldVkYwGjE3AdG4GMceIbZVG0q83GPmF47vcnmoeHXLs6cB+lRd/neH5CuJ
 6dkkWIfOeGrnhfR7812W9yCcj9sQ94D5TvKNRb/B9qZW5F78iLAwpbA9yOWcug6skzOFhEi4BcO
 FzVl57bVzwLwfAlEZEWmWd3zEFtxZA8cf5U2C1TaApLaHQANxyXklgnHt91boQs6XpW457cx+Fj
 vfnrgHGxCermECHvHMTd/BD1oCSWQ==
X-Received: by 2002:a05:600c:c3dc:20b0:490:adb6:793d with SMTP id
 5b1f17b1804b1-490ec4fbd85mr9645115e9.26.1781245123016; 
 Thu, 11 Jun 2026 23:18:43 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea94f5b0sm26960095e9.1.2026.06.11.23.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 23:18:42 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 03/13] drm/amdgpu: add gfp_flags to amdgpu_sa_manager
Date: Fri, 12 Jun 2026 08:18:41 +0200
Message-ID: <2787510.lGaqSPkdTl@timur-max>
In-Reply-To: <20260529114031.3714-4-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-4-christian.koenig@amd.com>
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

On 2026. m=C3=A1jus 29., p=C3=A9ntek 13:24:05 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> Make sure that we use the emmergency reserves for unrecoverable page
> faults and GPU resets.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 23 ++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 18 ++++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h |  3 ++-
>  3 files changed, 34 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c index 334f95f8f339..60e4c3985029
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -356,16 +356,33 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
>  		[AMDGPU_IB_POOL_IMMEDIATE] =3D SZ_128K,
>  		[AMDGPU_IB_POOL_DIRECT] =3D SZ_512K
>  	};
> +	const gfp_t gfp_flags[AMDGPU_IB_POOL_MAX] =3D {
> +		/*
> +		 * For normal page table updates and recoverable page=20
faults,
> +		 * further restricted by the VM eviction lock to not=20
wait for
> +		 * memory reclaim.
> +		 */
> +		[AMDGPU_IB_POOL_DELAYED] =3D GFP_KERNEL,
> +		/*
> +		 * For redirecting unrecoverable page faults to the=20
dummy page
> +		 * or set the PRT bits. dma_fence submissions might=20
depend on
> +		 * that so we need the emmergency resewrves.
> +		 */
> +		[AMDGPU_IB_POOL_IMMEDIATE] =3D GFP_ATOMIC,

I know that "retry faults" and "recoverable faults" are different, but both=
 of=20
these faults can be mitigated, so using the term "unrecoverable" here feels=
=20
somewhat confusing to me.

Can you please clarify the comment above as well as the commit message that=
=20
this is referring to retry faults?

> +		/*
> +		 * For IB tests during GPU resets. Only very small and=20
temporary
> +		 * allocation to make allow dma_fences to signal.
> +		 */
> +		[AMDGPU_IB_POOL_DIRECT] =3D GFP_ATOMIC

Just a small grammatical nitpick but "make" is not necessary in this commen=
t.

> +	};
>  	int r, i;
>=20
>  	if (adev->ib_pool_ready)
>  		return 0;
>=20
> -

Looks like this is just removing the spurious newline from the previous=20
commit.

With that fixed and the comments + commit message clarified:
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>  	for (i =3D 0; i < AMDGPU_IB_POOL_MAX; i++) {
>  		r =3D amdgpu_sa_bo_manager_init(adev, &adev->ib_pools[i],
> -					      sizes[i], 256,
> -					     =20
AMDGPU_GEM_DOMAIN_GTT);
> +					      sizes[i],=20
gfp_flags[i]);
>  		if (r)
>  			goto error;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c index 39070b2a4c04..74124f80601e
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> @@ -46,11 +46,13 @@
>=20
>  int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
>  			      struct amdgpu_sa_manager *sa_manager,
> -			      unsigned int size, u32 suballoc_align,=20
u32 domain)
> +			      unsigned int size, gfp_t gfp_flags)
>  {
>  	int r;
>=20
> -	r =3D amdgpu_bo_create_kernel(adev, size, AMDGPU_GPU_PAGE_SIZE,=20
domain,
> +	sa_manager->gfp_flags =3D gfp_flags;
> +	r =3D amdgpu_bo_create_kernel(adev, size, AMDGPU_GPU_PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_GTT,
>  				    &sa_manager->bo, &sa_manager-
>gpu_addr,
>  				    &sa_manager->cpu_ptr);
>  	if (r) {
> @@ -59,7 +61,8 @@ int amdgpu_sa_bo_manager_init(struct amdgpu_device *ade=
v,
>  	}
>=20
>  	memset(sa_manager->cpu_ptr, 0, size);
> -	drm_suballoc_manager_init(&sa_manager->base, size,=20
suballoc_align);
> +	drm_suballoc_manager_init(&sa_manager->base, size, 256);
> +
>  	return r;
>  }
>=20
> @@ -73,7 +76,8 @@ void amdgpu_sa_bo_manager_fini(struct amdgpu_device *ad=
ev,
>=20
>  	drm_suballoc_manager_fini(&sa_manager->base);
>=20
> -	amdgpu_bo_free_kernel(&sa_manager->bo, &sa_manager->gpu_addr,
> &sa_manager->cpu_ptr); +	amdgpu_bo_free_kernel(&sa_manager->bo,
> &sa_manager->gpu_addr,
> +			      &sa_manager->cpu_ptr);
>  }
>=20
>  int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
> @@ -81,7 +85,8 @@ int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manag=
er,
> unsigned int size)
>  {
>  	struct drm_suballoc *sa =3D drm_suballoc_new(&sa_manager->base,=20
size,
> -						  =20
GFP_KERNEL, false, 0);
> +						  =20
sa_manager->gfp_flags,
> +						   false,=20
0);
>=20
>  	if (IS_ERR(sa)) {
>  		*sa_bo =3D NULL;
> @@ -110,6 +115,7 @@ void amdgpu_sa_bo_dump_debug_info(struct
> amdgpu_sa_manager *sa_manager, {
>  	struct drm_printer p =3D drm_seq_file_printer(m);
>=20
> -	drm_suballoc_dump_debug_info(&sa_manager->base, &p, sa_manager-
>gpu_addr);
> +	drm_suballoc_dump_debug_info(&sa_manager->base, &p,
> +				     sa_manager->gpu_addr);
>  }
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h index 8c85c80fc119..1d1c89348709
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
> @@ -35,6 +35,7 @@ struct amdgpu_sa_manager {
>  	struct amdgpu_bo		*bo;
>  	uint64_t			gpu_addr;
>  	void				*cpu_ptr;
> +	gfp_t				gfp_flags;
>  };
>=20
>  static inline struct amdgpu_sa_manager *
> @@ -57,7 +58,7 @@ static inline void *amdgpu_sa_bo_cpu_addr(struct
> drm_suballoc *sa_bo)
>=20
>  int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
>  			      struct amdgpu_sa_manager *sa_manager,
> -			      unsigned size, u32 align, u32 domain);
> +			      unsigned size, gfp_t gfp_flags);
>  void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
>  			       struct amdgpu_sa_manager=20
*sa_manager);
>  int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,




