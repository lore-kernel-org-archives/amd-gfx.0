Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8010ACD8CA8
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 06:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1472D10E285;
	Fri, 12 Jun 2026 06:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TbvAMga2";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35A1010E0A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:21:29 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so3774945e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 23:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781245288; x=1781850088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LZEThEh8ZXdTSiy2sTPL+e6HLtuBJR9I4odkFfxGSrk=;
 b=TbvAMga2BYVZPseLxe19grXRZmoZaB4q5ZLYa/UNGgGMXv+oNHNpA2qlEKtfsoMCwl
 hMT5onZhjrLaKfTyq5baiQntabzGHgfoWW3+edPTIIDFMa3f/YpZOH8MutM4uc10mzXa
 x1h/5FwJDBbUVm6l1a8fJFNstPhxPiKerWK+4ELePgY6eCWOxwCgt8FupvTZn83qa2VW
 fwLuBe4unXXF8nr1D0yRl3QKvhtjXHE3TgYD/JjEfW+ifytGGlypZvw9tXECHdnxSgmC
 RHMuiHlzw/ET4pJUWZFdVP9/QvEphYrBCinyf+kM1jsFoD+CToVjd8zP4P7HNAruQSQT
 FmiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781245288; x=1781850088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LZEThEh8ZXdTSiy2sTPL+e6HLtuBJR9I4odkFfxGSrk=;
 b=RJviZl/zAjZzzKs94/U3Agw5ANDuYtoph/VA0+mRiDfcySiXkUvy/jFdM6MMPGaxGf
 3XuptVS2CIQT6tGwjQnTBoHC+CiF9xqT5wdjuiJJeCqRRd8pzbwrrDVwunxO1wVaTaQI
 9RGkVjPj7R6eAuPQE9OtT9SCUQKjZ0iFaDu/q8c60K4abPTjNJtfHgj3HcX5vfKOhIou
 z4ufdnpr5j+6nt93fAchYxoewhMgNSsUOWIMYoJZzZYS38x/x+mc1fekPupCdaoGZD2h
 03CcCQkLS4vjEELejsp3mgxy+3X3luzOUkCbBQwfBifgqZKTPX3MpFUpWEMzcRhO1l/m
 QyrA==
X-Gm-Message-State: AOJu0YxjNWpIb/m1oQzoR+DY+H0QhEKL5+UOtNNTOAeaWw7m6mGuCsfH
 fKUkQLCVpcreEZRgWJmrtPngxc7vu8+V833sqBfOMvNXWtEOMDac1Lln
X-Gm-Gg: Acq92OEQfyqYbQdZFBaGqH7dQaD/Ky36y8KDcWA7orxyhNOjVzBq0IwMnWPMSj9xU3j
 7q+h4lvCwsI4c++/ZN0riVLmbHRMRVPGtEusyXgDKa5sGDEr4ywlpch7AiKiW8a5kJg0VvI/THL
 arIJtr55Zs4bR7oQ7/8bmU/5MJ+3sWwGQJ1OUe66hSLsk5nxyGFKPWzrSuVzTyUQE5QEth5UGQw
 D7fssNY92KpgQMn8vVQAQiwtCXIebbpWwlDvemhMiiiMmC8c5ofZo/9iaLEkTEwBPwkm/1wLO5C
 1gaTGX2Exo/XF6IozZ+E+TqI4MdMUvffPLVTMsA497e+6Nzl/Ofnxs3LKeBOfy/yjGP4Mxk3Mj3
 LtLEbr9ooAk6JYPYEmJMwMr+ZR4QVL5Lh+UKFYsB30aGqxxpwPNDkWpIpGNjaB9LXu8Y9f0n6Vu
 G6aWHOMkcQxNymdsH+9k7/s5/8MEn+YWvcsMAf0t3QD+nb+/5VMmYwrXJmrR5yRW3L3Kk6GSmmb
 EXjrHedi1lxkjI+Q5iNr1Tg/gOwwSK0reMnidkH
X-Received: by 2002:a05:600c:1d03:b0:490:ec86:ad4e with SMTP id
 5b1f17b1804b1-490ec86bf8fmr12319635e9.31.1781245287620; 
 Thu, 11 Jun 2026 23:21:27 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea843d63sm39051865e9.12.2026.06.11.23.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 23:21:27 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 04/13] drm/amdgpu: move job parameter to the end in
 amdgpu_job_alloc() and *_with_ib()
Date: Fri, 12 Jun 2026 08:21:25 +0200
Message-ID: <3692193.dWV9SEqChM@timur-max>
In-Reply-To: <20260529114031.3714-5-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-5-christian.koenig@amd.com>
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

On 2026. m=C3=A1jus 29., p=C3=A9ntek 13:24:06 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> Move the job output parameter to be the last parameter in the
> amdgpu_job_alloc() and amdgpu_job_alloc_with_ib() function signature. This
> aligns with the common kernel coding convention where output parameters
> typically come last.
>=20
> Co-developed by Claude Sonnet 4.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Looks good. Nice cleanup.

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 10 +++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  8 ++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c    |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 11 ++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c     |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     |  8 +++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     | 12 ++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  2 +-
>  drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c       | 10 ++++++----
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c       | 10 ++++++----
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    |  4 ++--
>  15 files changed, 57 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c index
> 0017d502d169..44751d71b741 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -696,7 +696,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *ade=
v,
>  		goto err;
>  	}
>=20
> -	ret =3D amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, &job, 0);
> +	ret =3D amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, 0, &job);
>  	if (ret)
>  		goto err;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c index 10d8dcc3a972..fdf01d824d66
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -274,8 +274,8 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>=20
>  	for (i =3D 0; i < p->gang_size; ++i) {
>  		ret =3D amdgpu_job_alloc(p->adev, vm, p->entities[i], vm,
> -				       num_ibs[i], &p->jobs[i],
> -				       p->filp->client_id);
> +				       num_ibs[i], p->filp-
>client_id,
> +				       &p->jobs[i]);
>  		if (ret)
>  			goto free_all_kdata;
>  		switch (p->adev->enforce_isolation[fpriv->xcp_id]) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c index 515cc4a2aeb4..54450ac49834
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1669,8 +1669,9 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct
> amdgpu_ring *ring) owner =3D (void *)(unsigned
> long)atomic_inc_return(&counter);
>=20
>  	r =3D amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
> -				     64, 0, &job,
> -				    =20
AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
> +				     64, 0,
> +				    =20
AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER,
> +				     &job);
>  	if (r)
>  		goto err;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index 13bec8461cde..181d69770c40
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -761,7 +761,8 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device
> *adev, uint32_t vmid, r =3D amdgpu_job_alloc_with_ib(ring->adev,
> &adev->mman.default_entity.base, AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     16 * 4,=20
AMDGPU_IB_POOL_IMMEDIATE,
> -				     &job,=20
AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB);
> +				    =20
AMDGPU_KERNEL_JOB_ID_FLUSH_GPU_TLB,
> +				     &job);
>  	if (r)
>  		goto error_alloc;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c index 55172c2dcc35..71c1ba735a6b
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -187,8 +187,8 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job)
>=20
>  int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		     struct drm_sched_entity *entity, void *owner,
> -		     unsigned int num_ibs, struct amdgpu_job **job,
> -		     u64 drm_client_id)
> +		     unsigned int num_ibs, u64 drm_client_id,
> +		     struct amdgpu_job **job)
>  {
>  	struct amdgpu_fence *af;
>  	int r;
> @@ -241,12 +241,12 @@ int amdgpu_job_alloc(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, int amdgpu_job_alloc_with_ib(struct amdgpu_device
> *adev,
>  			     struct drm_sched_entity *entity, void=20
*owner,
>  			     size_t size, enum amdgpu_ib_pool_type=20
pool_type,
> -			     struct amdgpu_job **job, u64 k_job_id)
> +			     u64 k_job_id, struct amdgpu_job **job)
>  {
>  	int r;
>=20
> -	r =3D amdgpu_job_alloc(adev, NULL, entity, owner, 1, job,
> -			     k_job_id);
> +	r =3D amdgpu_job_alloc(adev, NULL, entity, owner, 1, k_job_id,
> +			     job);
>  	if (r)
>  		return r;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h index 56a88e14a044..6b7cf594714c
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -112,13 +112,13 @@ static inline struct amdgpu_ring
> *amdgpu_job_ring(struct amdgpu_job *job)
>=20
>  int amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		     struct drm_sched_entity *entity, void *owner,
> -		     unsigned int num_ibs, struct amdgpu_job **job,
> -		     u64 drm_client_id);
> +		     unsigned int num_ibs, u64 drm_client_id,
> +		     struct amdgpu_job **job);
>  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>  			     struct drm_sched_entity *entity, void=20
*owner,
>  			     size_t size, enum amdgpu_ib_pool_type=20
pool_type,
> -			     struct amdgpu_job **job,
> -			     u64 k_job_id);
> +			     u64 k_job_id,
> +			     struct amdgpu_job **job);
>  void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo
> *gds, struct amdgpu_bo *gws, struct amdgpu_bo *oa);
>  void amdgpu_job_free_resources(struct amdgpu_job *job);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c index 63ee6ba6a931..988ad86971=
a8
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
> @@ -196,8 +196,9 @@ static int amdgpu_jpeg_dec_set_reg(struct amdgpu_ring
> *ring, uint32_t handle, int i, r;
>=20
>  	r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw *=20
4,
> -				     AMDGPU_IB_POOL_DIRECT, &job,
> -				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				     AMDGPU_IB_POOL_DIRECT,
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		return r;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c index 6c6ab4dd6ea9..cf78d7020494
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -243,8 +243,9 @@ static int amdgpu_ttm_map_buffer(struct
> amdgpu_ttm_buffer_entity *entity, r =3D amdgpu_job_alloc_with_ib(adev,
> &entity->base,
>  				    =20
AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     num_dw * 4 + num_bytes,
> -				     AMDGPU_IB_POOL_DELAYED,=20
&job,
> -				    =20
AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER);
> +				     AMDGPU_IB_POOL_DELAYED,
> +				    =20
AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER,
> +				     &job);
>  	if (r)
>  		return r;
>=20
> @@ -1573,8 +1574,8 @@ static int amdgpu_ttm_access_memory_sdma(struct
> ttm_buffer_object *bo, r =3D amdgpu_job_alloc_with_ib(adev,
> &adev->mman.default_entity.base, AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     num_dw * 4,=20
AMDGPU_IB_POOL_DELAYED,
> -				     &job,
> -				    =20
AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA);
> +				    =20
AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA,
> +				     &job);
>  	if (r)
>  		goto out;
>=20
> @@ -2428,7 +2429,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_dev=
ice
> *adev, int r;
>  	r =3D amdgpu_job_alloc_with_ib(adev, &entity->base,
>  				    =20
AMDGPU_FENCE_OWNER_UNDEFINED,
> -				     num_dw * 4, pool, job,=20
k_job_id);
> +				     num_dw * 4, pool, k_job_id,=20
job);
>  	if (r)
>  		return r;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c index 3a3bc0d370fa..7df839634098
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -1137,8 +1137,9 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring
> *ring, struct amdgpu_bo *bo, r =3D amdgpu_job_alloc_with_ib(ring->adev,
> &adev->uvd.entity,
>  				    =20
AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     64, direct ?=20
AMDGPU_IB_POOL_DIRECT :
> -				     AMDGPU_IB_POOL_DELAYED,=20
&job,
> -				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				     AMDGPU_IB_POOL_DELAYED,
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		return r;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c index efdebd9c0a1f..344a703d03be
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -473,7 +473,8 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ri=
ng
> *ring, uint32_t handle, r =3D amdgpu_job_alloc_with_ib(ring->adev,
> &ring->adev->vce.entity, AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     ib_size_dw * 4,=20
AMDGPU_IB_POOL_DIRECT,
> -				     &job,=20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		return r;
>=20
> @@ -564,8 +565,9 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_r=
ing
> *ring, uint32_t handle, AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     ib_size_dw * 4,
>  				     direct ?=20
AMDGPU_IB_POOL_DIRECT :
> -				     AMDGPU_IB_POOL_DELAYED,=20
&job,
> -				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				     AMDGPU_IB_POOL_DELAYED,
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		return r;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c index 616967519869..6b15415f989c
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -631,7 +631,8 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring
> *ring,
>=20
>  	r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>  				     64, AMDGPU_IB_POOL_DIRECT,
> -				     &job,=20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		goto err;
>=20
> @@ -811,7 +812,8 @@ static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_r=
ing
> *ring,
>=20
>  	r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>  				     ib_size_dw * 4,=20
AMDGPU_IB_POOL_DIRECT,
> -				     &job,=20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		goto err;
>=20
> @@ -941,7 +943,8 @@ static int amdgpu_vcn_enc_get_create_msg(struct
> amdgpu_ring *ring, uint32_t hand
>=20
>  	r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>  				     ib_size_dw * 4,=20
AMDGPU_IB_POOL_DIRECT,
> -				     &job,=20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		return r;
>=20
> @@ -1008,7 +1011,8 @@ static int amdgpu_vcn_enc_get_destroy_msg(struct
> amdgpu_ring *ring, uint32_t han
>=20
>  	r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL,
>  				     ib_size_dw * 4,=20
AMDGPU_IB_POOL_DIRECT,
> -				     &job,=20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		return r;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c index
> 2eb64df6daa9..50cc0779c340 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -56,7 +56,7 @@ static int amdgpu_vm_sdma_alloc_job(struct
> amdgpu_vm_update_params *p, ndw =3D min(ndw, AMDGPU_VM_SDMA_MAX_NUM_DW);
>=20
>  	r =3D amdgpu_job_alloc_with_ib(p->adev, entity,=20
AMDGPU_FENCE_OWNER_VM,
> -				     ndw * 4, pool, &p->job,=20
k_job_id);
> +				     ndw * 4, pool, k_job_id, &p-
>job);
>  	if (r)
>  		return r;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c index ecd7ead7a60b..16137829fe84
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -217,8 +217,9 @@ static int uvd_v6_0_enc_get_create_msg(struct
> amdgpu_ring *ring, uint32_t handle int i, r;
>=20
>  	r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw *=20
4,
> -				     AMDGPU_IB_POOL_DIRECT, &job,
> -				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				     AMDGPU_IB_POOL_DIRECT,
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		return r;
>=20
> @@ -282,8 +283,9 @@ static int uvd_v6_0_enc_get_destroy_msg(struct
> amdgpu_ring *ring, int i, r;
>=20
>  	r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw *=20
4,
> -				     AMDGPU_IB_POOL_DIRECT, &job,
> -				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				     AMDGPU_IB_POOL_DIRECT,
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		return r;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c index df2c83348315..46222fc30be6
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -225,8 +225,9 @@ static int uvd_v7_0_enc_get_create_msg(struct
> amdgpu_ring *ring, u32 handle, int i, r;
>=20
>  	r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw *=20
4,
> -				     AMDGPU_IB_POOL_DIRECT, &job,
> -				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				     AMDGPU_IB_POOL_DIRECT,
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		return r;
>=20
> @@ -289,8 +290,9 @@ static int uvd_v7_0_enc_get_destroy_msg(struct
> amdgpu_ring *ring, u32 handle, int i, r;
>=20
>  	r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, ib_size_dw *=20
4,
> -				     AMDGPU_IB_POOL_DIRECT, &job,
> -				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST);
> +				     AMDGPU_IB_POOL_DIRECT,
> +				    =20
AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
> +				     &job);
>  	if (r)
>  		return r;
>=20
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c index 28dc6886c1ff..51ad46c25c=
5a
> 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -68,8 +68,8 @@ svm_migrate_gart_map(struct amdgpu_ring *ring,
>  				    =20
AMDGPU_FENCE_OWNER_UNDEFINED,
>  				     num_dw * 4 + num_bytes,
>  				     AMDGPU_IB_POOL_DELAYED,
> -				     &job,
> -				    =20
AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP);
> +				    =20
AMDGPU_KERNEL_JOB_ID_KFD_GART_MAP,
> +				     &job);
>  	if (r)
>  		return r;




