Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA05CD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 06:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F7210E94E;
	Fri, 12 Jun 2026 06:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IuTgBsaq";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4956A10E94E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 06:33:36 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-45ef616daf6so551530f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 23:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781246015; x=1781850815; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywWWeLTbLvKoaJeckmUhLSyhLPzuFFlFYq/oX3L6t3g=;
 b=IuTgBsaqXNOY74ubUXpLLXGSocMRWsGaeDVoR4U02Bp4OvHoTedVd/IP7amaqQiSL8
 jKAkaLyQP6wq9hvOgng/skayN2vP1yeXHl29QA+7ul16LfdqVlxnanbqGoMit5+RH1tt
 I0NdmCMEmUSCRAp4L8RXUkU8rhHhjq9LwTL5+Q6GGeGqhu9VCs9rAoVwzwwJpdsUC0RV
 ULyKhzUgQNPgC5ZPZRtmyEcDafjyhVoKI6Hg0nwR5eAOEKwBNTBCZo2cclczdVlHnp0b
 f5TgcOcbC4UMykdtztDTvcWog2Jf5xBZUsHegASckuv3jAk2JM62jFhurhhcrcEsovGN
 xwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781246015; x=1781850815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ywWWeLTbLvKoaJeckmUhLSyhLPzuFFlFYq/oX3L6t3g=;
 b=shiHrN1gJPk1oBa/f+9FTPViQ+slWfP0f7edVuaJGVF76eBGKKsSxd4BuaaKInYTUF
 iFA0XbGVCIIEwFzLNp5LXS8nmBlGY7A1rE9HQ0ARvGWN498VHLc71DSo2ZiBNs7LJ2yw
 tzxxJpDXD7M4NuuBDPhHrsrOFOpV37X4V/jG1ygGgElRbcL2sI6Hny0q37CsPniEAV9e
 059HC749dBQAMwdzeb+0ZSAQX3mQ8Set7jHcYsQLu5nK/Wy/HS0B9En1YVfNeQRRdr5x
 n79Nlev8LiB2Gf0itrCWtdGk28qcJGXsj8LDp7RVcXLRvikllwuyXnoIsJrTZEVv021H
 iAAg==
X-Gm-Message-State: AOJu0YwILbOFiSqaetvj9wthMWV2nQ3IcFBjbOycbBokAzSGfHdQlZDP
 y4zMu70UpzUEenXUxzeIpfn3o0aJmKpgBHyXguQZ1mAN6+9IxDGIyEse
X-Gm-Gg: Acq92OHf9FzfuloOTt+CWGxy/kGVPV8cyiDM7S89z7vtR8+NaUr3a6OURYU3MBnMC2F
 J7S+6xqamvncCAN5b34adqUn9AKhvb5cb5q8IijPkfWK0jfu0aajEEnM1E5POMnbcQbqYXlR4VU
 Iq/vPC0cSX66qmZX+Js8WHpHEKfRwX52aggnu5ZN3Seg3xZPYFqCxak7Gki4Mam81rS+NndRUzK
 DFQsZWvflc4dXgNGcjokNK2m7EqSqiCzRN5tDn3+Q3DQ0pua8fl9/10TE0ksDwpQx+StJV32oMT
 zYRPbEANOeZZzaVvPqKt8QzH4uNaLRYkIn3x+5y5mAVVquLECLAeEbIfL4U9yLlvc+t1OGKsoQt
 JXEthLNztymHUMhtmAs1/ue3YuaFycOitlsOfPw2Jcduq+QAkySAtm1AxpSkmwHnmp+xl2sKgOo
 FM5jX2HTmIC74vO2PYdLnV1o+CziTQO9qqNQ3YEyxk1nQzV2kVgm/J+xRjP6h6Y/gf1WcxnpHJz
 fQ/JzaYNQkUGAuxNyoTk7qTZ5Hlhg==
X-Received: by 2002:a05:6000:1252:b0:460:1301:dec6 with SMTP id
 ffacd0b85a97d-4606da7735fmr1480874f8f.10.1781246014646; 
 Thu, 11 Jun 2026 23:33:34 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2637ccsm2691635f8f.6.2026.06.11.23.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 23:33:33 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 05/13] drm/amdgpu: use correct gfp_t for job allocation
Date: Fri, 12 Jun 2026 08:33:33 +0200
Message-ID: <2005715.7Z3S40VBb9@timur-max>
In-Reply-To: <20260529114031.3714-6-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
 <20260529114031.3714-6-christian.koenig@amd.com>
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

On 2026. m=C3=A1jus 29., p=C3=A9ntek 13:24:07 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> For job allocation in GPU reset and page fault handling we must use
> GFP_ATOMIC to guarantee that we don't cycle back and depend on a
> dma_fence submission for the memory allocation.

Can you please edit the commit message to elaborate  a little more?
=46or example, please add something like this:

Add gfp_flags argument to amdgpu_job_alloc() and expose the
gfp_flags of IB pools with amdgpu_ib_pool_gfp_flags() so that
we can use different flags when allocating jobs.

(Feel free to edit the text to improve it to your tastes.)

>=20
> Co-developed by Claude Sonnet 4.

This tag seems inconsistent with the kernel guidelines and also inconsisten=
t=20
with commits from other AMD engineers. Can you please change this to use the
Assisted-by tag? Also in the other commits in this series.

Link to the guidelines:
https://docs.kernel.org/process/coding-assistants.html

Otherwise, the code looks fine.

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c     | 11 +++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  9 +++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.h    |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   |  2 ++
>  6 files changed, 22 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c index
> 44751d71b741..c425f960361c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -696,7 +696,8 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *ade=
v,
>  		goto err;
>  	}
>=20
> -	ret =3D amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, 0, &job);
> +	ret =3D amdgpu_job_alloc(adev, NULL, NULL, NULL, 1, 0, GFP_KERNEL,
> +			       &job);
>  	if (ret)
>  		goto err;
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c index fdf01d824d66..3ed2cb9dfa38
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -275,7 +275,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>  	for (i =3D 0; i < p->gang_size; ++i) {
>  		ret =3D amdgpu_job_alloc(p->adev, vm, p->entities[i], vm,
>  				       num_ibs[i], p->filp-
>client_id,
> -				       &p->jobs[i]);
> +				       GFP_KERNEL, &p->jobs[i]);
>  		if (ret)
>  			goto free_all_kdata;
>  		switch (p->adev->enforce_isolation[fpriv->xcp_id]) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c index 60e4c3985029..83a802cf5837
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -416,6 +416,17 @@ void amdgpu_ib_pool_fini(struct amdgpu_device *adev)
>  	adev->ib_pool_ready =3D false;
>  }
>=20
> +/**
> + * amdgpu_ib_pool_gfp_flags - Returns the gfp flags to use for each pool
> + * @adev: amdgpu device pointer
> + * @type: the IB pool type
> + */
> +gfp_t amdgpu_ib_pool_gfp_flags(struct amdgpu_device *adev,
> +			       enum amdgpu_ib_pool_type type)
> +{
> +	return adev->ib_pools[type].gfp_flags;
> +}
> +
>  /**
>   * amdgpu_ib_ring_tests - test IBs on the rings
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c index 71c1ba735a6b..b4b424d84479
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -188,7 +188,7 @@ static enum drm_gpu_sched_stat
> amdgpu_job_timedout(struct drm_sched_job *s_job) int
> amdgpu_job_alloc(struct amdgpu_device *adev, struct amdgpu_vm *vm, struct
> drm_sched_entity *entity, void *owner,
>  		     unsigned int num_ibs, u64 drm_client_id,
> -		     struct amdgpu_job **job)
> +		     gfp_t gfp_flags, struct amdgpu_job **job)
>  {
>  	struct amdgpu_fence *af;
>  	int r;
> @@ -196,18 +196,18 @@ int amdgpu_job_alloc(struct amdgpu_device *adev,
> struct amdgpu_vm *vm, if (num_ibs =3D=3D 0)
>  		return -EINVAL;
>=20
> -	*job =3D kzalloc(struct_size(*job, ibs, num_ibs), GFP_KERNEL);
> +	*job =3D kzalloc(struct_size(*job, ibs, num_ibs), gfp_flags);
>  	if (!*job)
>  		return -ENOMEM;
>=20
> -	af =3D kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	af =3D kzalloc(sizeof(struct amdgpu_fence), gfp_flags);
>  	if (!af) {
>  		r =3D -ENOMEM;
>  		goto err_job;
>  	}
>  	(*job)->hw_fence =3D af;
>=20
> -	af =3D kzalloc(sizeof(struct amdgpu_fence), GFP_KERNEL);
> +	af =3D kzalloc(sizeof(struct amdgpu_fence), gfp_flags);
>  	if (!af) {
>  		r =3D -ENOMEM;
>  		goto err_fence;
> @@ -246,6 +246,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *ad=
ev,
> int r;
>=20
>  	r =3D amdgpu_job_alloc(adev, NULL, entity, owner, 1, k_job_id,
> +			     amdgpu_ib_pool_gfp_flags(adev,=20
pool_type),
>  			     job);
>  	if (r)
>  		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h index 6b7cf594714c..44fe40f9e8df
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -113,7 +113,7 @@ static inline struct amdgpu_ring *amdgpu_job_ring(str=
uct
> amdgpu_job *job) int amdgpu_job_alloc(struct amdgpu_device *adev, struct
> amdgpu_vm *vm, struct drm_sched_entity *entity, void *owner,
>  		     unsigned int num_ibs, u64 drm_client_id,
> -		     struct amdgpu_job **job);
> +		     gfp_t gfp_flags, struct amdgpu_job **job);
>  int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
>  			     struct drm_sched_entity *entity, void=20
*owner,
>  			     size_t size, enum amdgpu_ib_pool_type=20
pool_type,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h index 1a063a0a4280..4bf9734acc=
18
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -582,6 +582,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring,
> unsigned num_ibs, struct dma_fence **f);
>  int amdgpu_ib_pool_init(struct amdgpu_device *adev);
>  void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
> +gfp_t amdgpu_ib_pool_gfp_flags(struct amdgpu_device *adev,
> +			       enum amdgpu_ib_pool_type type);
>  int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
>  bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring);
>  void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,




