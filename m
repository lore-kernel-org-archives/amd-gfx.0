Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19EBAC79F9F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 13:25:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83BCC10EB43;
	Thu, 10 Sep 2026 13:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b+sA2sGa";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E47E510EB43
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 13:25:24 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c2938116fefso320941266b.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 06:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789046723; x=1789651523; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=shOy8RdzXiGhOHGMU5jeaLAVCCXQUT//LAXwuPJ5NcE=;
 b=b+sA2sGabbYRq3t3K1/0Lpha334UN1m5XfbCtXqN3ProKtEVykpK6o1pi9QkiwgqLn
 4rLA5lfqoGbVQMQo8IveS6D2v90fsa9yVKUtPdMAWPfMbWRm7SkOk+c4VDu03xe/dO03
 5FpYDh/S8r9WeaqiEA5CceOFsksO0/5B70RFKhrCbEMardRHuEstf+Nh7I/zZC0pQd/H
 PlZJ4kF2whvZqt0OlZpz4O0DJHn6yH+DNlKMvWdBLc9uwrR+suFHeTaf0Ra/flIKdGCW
 MoRGEm9h4P1Iw9zP3Qbrt6cFqf/D9ChVwdsVwiFgoiU3nt6lmVz5jBWN7j+QN4tl19R7
 OiWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789046723; x=1789651523;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=shOy8RdzXiGhOHGMU5jeaLAVCCXQUT//LAXwuPJ5NcE=;
 b=GQ8ZfEJBHLaZpqK+32xCUb+N4yxNvoaGkZrCxyiiAggKnCuiiomC/cbTksT92jwMl0
 JDbsA8YXCereHSLCAzLE09bTImvokLCxyl9/P0oi7fJ0R5SN4wiRlpTQWZwZ4SE4EM85
 TTa9KMR8B0OobuNnrbWLdoaJLZn3n/uI5kTVyBBXTsNtuyUp6oL+4iwkYU/pEyJ6NDj3
 /2dtbAxgUdG4sJqltDKh9+4bAeX4dzu/ah9kK1BcozOdiEnxNxj2oEwxqZSfjJ7pRm05
 /JExak98RvIbIW6Eg5+VIINfdXryBwazYAFnFm7OONnCzarhkXqcnlnMglFpCmilViQG
 aX6Q==
X-Gm-Message-State: AFuF++kS95qfYSc23RGMB76UeujgXyUzVg7x4IW5gynIc6p/X1MMojJl
 LRHfgqidApVSG1btl/g9vGrbex/QHPu+WdwNOurjfv0CFm2xwIKkTwpnu/5JNA==
X-Gm-Gg: AYBFou3XWbHgnA2su0AVbon5pF7hafXu+GRlA3i2R/yh46yrzBZ2wUVwO+RIQ4FLyQa
 Wn0faP+2IjDQjZQyYE04MVG2iQXtja/aQJN6u1FSin9aUAeWYC+If4LmG0AYAqr9unbkjCXFvF0
 r/cSQi2tQ9R/qMfbvu44YrP3bvkdwbd7ckvkiQdNd1YKfuIeX1ihIWkJAYI8KMQDdRGSaYI1pCh
 W7H4zyJc0duQcfXZu/dS+6IECHtM3c9e9+p0mNZQxJjhTzH5jOhmBt+mb9LYY/qRu87RmBzcZcn
 qEf6ap8L4wGYPPugp/zpPigIC25sIerJ0elNZkk8se2EpB7Dxm0E7N2cyvymFddyuQfUoBjLE7N
 +CVzjJwHJUuN2rp4Dh52Akg6IYfo/zLtBU1T3TR8Nzlqq7xrHStdKyNrRjfvorxuXJ/Z7/0uf47
 EInDigvUNLXV+vUlTIKaUf+Ywo+YHfSp3NCR8L1raAVZcVbtSQsJ8Nr6dIuJ+V9V2oUwDg7IOc+
 msdQ8FrubM=
X-Received: by 2002:a17:907:3cc4:b0:c29:53b5:c69d with SMTP id
 a640c23a62f3a-c2953b5d78emr111296166b.28.1789046722928; 
 Thu, 10 Sep 2026 06:25:22 -0700 (PDT)
Received: from timur-max.localnet ([37.220.204.82])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d5921e2sm911979466b.46.2026.09.10.06.25.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 06:25:22 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: Re: [PATCH 1/6] drm/amdgpu: Add SDMA ring init helper
Date: Wed, 09 Sep 2026 20:27:49 +0200
Message-ID: <s5-Dk6INQlqq93576HqTlw@gmail.com>
In-Reply-To: <20260909105215.88242-2-tvrtko.ursulin@igalia.com>
References: <20260909105215.88242-1-tvrtko.ursulin@igalia.com>
 <20260909105215.88242-2-tvrtko.ursulin@igalia.com>
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

On 2026. szeptember 9., szerda 12:52:10 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> Consolidate one part of the SDMA ring initialization with a new
> amdgpu_sdma_ring_init() helper.
>=20
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 19 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +++
>  drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  7 +------
>  drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  7 +------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 13 ++-----------
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 19 ++++++-------------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  7 +------
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  6 +-----
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  8 ++------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  7 +------
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   | 13 +++++--------
>  11 files changed, 42 insertions(+), 67 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c index fbac732f3e01..cca8b3a98f=
6a
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -37,6 +37,25 @@
>   * GPU SDMA IP block helpers function.
>   */
>=20
> +int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring
> *ring, +			  const char *prefix, unsigned int index)

Instead of "index", I suggest "instance_id" to make it clear what it is.
Additionally please add an xcc_id argument because some SDMA versions seem =
to=20
need that too.

> +{
> +	int r;
> +
> +	ring->ring_obj =3D NULL;

Maybe also consider moving here the following lines:
ring->me =3D instance_id;
ring->use_doorbell =3D ... // based on SDMA IP version
ring->no_user_submission =3D adev->sdma.no_user_submission;

> +
> +	if (prefix)
> +		sprintf(ring->name, "sdma%u", index);

Seems like this wouldn't name the page queues correctly.
Suggestion:

sprintf(ring->name, "%s%u.%u", prefix ?: "sdma", xcc_id, instance_id);


> +
> +	r =3D amdgpu_ring_init(adev, ring, 1024, &adev->sdma.trap_irq,
> +			     AMDGPU_SDMA_IRQ_INSTANCE0 + index,
> +			     AMDGPU_RING_PRIO_DEFAULT, NULL);
> +	if (r)
> +		return r;
> +
> +	return 0;
> +}
> +
>  struct amdgpu_sdma_instance *amdgpu_sdma_get_instance_from_ring(struct
> amdgpu_ring *ring) {
>  	struct amdgpu_device *adev =3D ring->adev;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h index 671cfbb67b7a..2f1edef97c=
2f
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -158,6 +158,9 @@ struct amdgpu_buffer_funcs {
>  				 uint32_t byte_count);
>  };
>=20
> +int amdgpu_sdma_ring_init(struct amdgpu_device *adev, struct amdgpu_ring
> *ring, +			  const char *prefix, unsigned int index);
> +
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t
> instance_id, bool caller_handles_kernel_queues);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c index 657ef6c93c61..fb2047d8e25a
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -865,13 +865,8 @@ static int sdma_v2_4_sw_init(struct amdgpu_ip_block
> *ip_block)
>=20
>  	for (i =3D 0; i < adev->sdma.num_instances; i++) {
>  		ring =3D &adev->sdma.instance[i].ring;
> -		ring->ring_obj =3D NULL;
>  		ring->use_doorbell =3D false;
> -		sprintf(ring->name, "sdma%d", i);
> -		r =3D amdgpu_ring_init(adev, ring, 1024, &adev-
>sdma.trap_irq,
> -				     (i =3D=3D 0) ?=20
AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1,
> -				     AMDGPU_RING_PRIO_DEFAULT,=20
NULL);
> +		r =3D amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c index 9478dd034aff..656f66527999
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -1146,7 +1146,6 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>=20
>  	for (i =3D 0; i < adev->sdma.num_instances; i++) {
>  		ring =3D &adev->sdma.instance[i].ring;
> -		ring->ring_obj =3D NULL;
>  		if (!amdgpu_sriov_vf(adev)) {
>  			ring->use_doorbell =3D true;
>  			ring->doorbell_index =3D adev-
>doorbell_index.sdma_engine[i];
> @@ -1154,11 +1153,7 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block
> *ip_block) ring->use_pollmem =3D true;
>  		}
>=20
> -		sprintf(ring->name, "sdma%d", i);
> -		r =3D amdgpu_ring_init(adev, ring, 1024, &adev-
>sdma.trap_irq,
> -				     (i =3D=3D 0) ?=20
AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1,
> -				     AMDGPU_RING_PRIO_DEFAULT,=20
NULL);
> +		r =3D amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c index 9d7d919a5aa1..e135dfb1c3e2
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1858,7 +1858,6 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>=20
>  	for (i =3D 0; i < adev->sdma.num_instances; i++) {
>  		ring =3D &adev->sdma.instance[i].ring;
> -		ring->ring_obj =3D NULL;
>  		ring->use_doorbell =3D true;
>=20
>  		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n",=20
i,
> @@ -1878,16 +1877,12 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_blo=
ck
> *ip_block) else
>  			ring->vm_hub =3D AMDGPU_MMHUB0(0);
>=20
> -		sprintf(ring->name, "sdma%d", i);
> -		r =3D amdgpu_ring_init(adev, ring, 1024, &adev-
>sdma.trap_irq,
> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +=20
i,
> -				     AMDGPU_RING_PRIO_DEFAULT,=20
NULL);
> +		r =3D amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>  		if (r)
>  			return r;
>=20
>  		if (adev->sdma.has_page_queue) {
>  			ring =3D &adev->sdma.instance[i].page;
> -			ring->ring_obj =3D NULL;
>  			ring->use_doorbell =3D true;
>=20
>  			/* paging queue use same doorbell index/
routing as gfx queue
> @@ -1915,11 +1910,7 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block
> *ip_block) else
>  				ring->vm_hub =3D AMDGPU_MMHUB0(0);
>=20
> -			sprintf(ring->name, "page%d", i);
> -			r =3D amdgpu_ring_init(adev, ring, 1024,
> -					     &adev-
>sdma.trap_irq,
> -					    =20
AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> -					    =20
AMDGPU_RING_PRIO_DEFAULT, NULL);
> +			r =3D amdgpu_sdma_ring_init(adev, ring, "page",=20
i);
>  			if (r)
>  				return r;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c index 461f8b220a3e..2e46e63a6d=
bf
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -1484,7 +1484,6 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_blo=
ck
> *ip_block) adev->sdma.instance[i].funcs =3D &sdma_v4_4_2_sdma_funcs;
>=20
>  		ring =3D &adev->sdma.instance[i].ring;
> -		ring->ring_obj =3D NULL;
>  		ring->use_doorbell =3D true;
>  		aid_id =3D adev->sdma.instance[i].aid_id;
>=20
> @@ -1495,18 +1494,15 @@ static int sdma_v4_4_2_sw_init(struct
> amdgpu_ip_block *ip_block) ring->doorbell_index =3D
> adev->doorbell_index.sdma_engine[i] << 1; ring->vm_hub =3D
> AMDGPU_MMHUB0(aid_id);
>  		ring->no_user_submission =3D adev-
>sdma.no_user_submission;
> +		r =3D amdgpu_sdma_ring_init(adev, ring, NULL, i);
> +		if (r)
> +			return r;
>=20
>  		sprintf(ring->name, "sdma%d.%d", aid_id,
>  				i % adev->sdma.num_inst_per_aid);
> -		r =3D amdgpu_ring_init(adev, ring, 1024, &adev-
>sdma.trap_irq,
> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +=20
i,
> -				     AMDGPU_RING_PRIO_DEFAULT,=20
NULL);
> -		if (r)
> -			return r;
>=20
>  		if (adev->sdma.has_page_queue) {
>  			ring =3D &adev->sdma.instance[i].page;
> -			ring->ring_obj =3D NULL;
>  			ring->use_doorbell =3D true;
>=20
>  			/* doorbell index of page queue is assigned=20
right after
> @@ -1515,15 +1511,12 @@ static int sdma_v4_4_2_sw_init(struct
> amdgpu_ip_block *ip_block) ring->doorbell_index =3D
>  				(adev-
>doorbell_index.sdma_engine[i] + 1) << 1;
>  			ring->vm_hub =3D AMDGPU_MMHUB0(aid_id);
> +			r =3D amdgpu_sdma_ring_init(adev, ring, NULL,=20
i);
> +			if (r)
> +				return r;
>=20
>  			sprintf(ring->name, "page%d.%d", aid_id,
>  					i % adev-
>sdma.num_inst_per_aid);
> -			r =3D amdgpu_ring_init(adev, ring, 1024,
> -					     &adev-
>sdma.trap_irq,
> -					    =20
AMDGPU_SDMA_IRQ_INSTANCE0 + i,
> -					    =20
AMDGPU_RING_PRIO_DEFAULT, NULL);
> -			if (r)
> -				return r;
>  		}
>  	}
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c index 97fee70dc2f6..a0614fa9ffa6
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -1411,7 +1411,6 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block
> *ip_block) mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
>  		adev->sdma.instance[i].funcs =3D &sdma_v5_0_sdma_funcs;
>  		ring =3D &adev->sdma.instance[i].ring;
> -		ring->ring_obj =3D NULL;
>  		ring->use_doorbell =3D true;
>=20
>  		DRM_DEBUG("SDMA %d use_doorbell being set to: [%s]\n",=20
i,
> @@ -1422,11 +1421,7 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>  			: (adev->doorbell_index.sdma_engine[1] <<=20
1); // get DWORD offset
>=20
>  		ring->vm_hub =3D AMDGPU_GFXHUB(0);
> -		sprintf(ring->name, "sdma%d", i);
> -		r =3D amdgpu_ring_init(adev, ring, 1024, &adev-
>sdma.trap_irq,
> -				     (i =3D=3D 0) ?=20
AMDGPU_SDMA_IRQ_INSTANCE0 :
> -				     AMDGPU_SDMA_IRQ_INSTANCE1,
> -				     AMDGPU_RING_PRIO_DEFAULT,=20
NULL);
> +		r =3D amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c index 35cdf6c149f8..5b3dafc194d7
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -1331,7 +1331,6 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block
> *ip_block) mutex_init(&adev->sdma.instance[i].engine_reset_mutex);
>  		adev->sdma.instance[i].funcs =3D &sdma_v5_2_sdma_funcs;
>  		ring =3D &adev->sdma.instance[i].ring;
> -		ring->ring_obj =3D NULL;
>  		ring->use_doorbell =3D true;
>  		ring->me =3D i;
>=20
> @@ -1342,10 +1341,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block
> *ip_block) (adev->doorbell_index.sdma_engine[i] << 1); //get DWORD offset
>=20
>  		ring->vm_hub =3D AMDGPU_GFXHUB(0);
> -		sprintf(ring->name, "sdma%d", i);
> -		r =3D amdgpu_ring_init(adev, ring, 1024, &adev-
>sdma.trap_irq,
> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +=20
i,
> -				     AMDGPU_RING_PRIO_DEFAULT,=20
NULL);
> +		r =3D amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c index 303fd7d1b7c8..845e622d3c1a
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -1335,7 +1335,6 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>=20
>  	for (i =3D 0; i < adev->sdma.num_instances; i++) {
>  		ring =3D &adev->sdma.instance[i].ring;
> -		ring->ring_obj =3D NULL;
>  		ring->use_doorbell =3D true;
>  		ring->me =3D i;
>  		ring->no_user_submission =3D adev-
>sdma.no_user_submission;
> @@ -1347,11 +1346,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block
> *ip_block) (adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
>=20
>  		ring->vm_hub =3D AMDGPU_GFXHUB(0);
> -		sprintf(ring->name, "sdma%d", i);
> -		r =3D amdgpu_ring_init(adev, ring, 1024,
> -				     &adev->sdma.trap_irq,
> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +=20
i,
> -				     AMDGPU_RING_PRIO_DEFAULT,=20
NULL);
> +
> +		r =3D amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c index d5552f206e4d..ea460a19b89d
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> @@ -1319,7 +1319,6 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>=20
>  	for (i =3D 0; i < adev->sdma.num_instances; i++) {
>  		ring =3D &adev->sdma.instance[i].ring;
> -		ring->ring_obj =3D NULL;
>  		ring->use_doorbell =3D true;
>  		ring->me =3D i;
>  		ring->no_user_submission =3D adev-
>sdma.no_user_submission;
> @@ -1331,11 +1330,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block
> *ip_block) (adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
>=20
>  		ring->vm_hub =3D AMDGPU_GFXHUB(0);
> -		sprintf(ring->name, "sdma%d", i);
> -		r =3D amdgpu_ring_init(adev, ring, 1024,
> -				     &adev->sdma.trap_irq,
> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +=20
i,
> -				     AMDGPU_RING_PRIO_DEFAULT,=20
NULL);
> +		r =3D amdgpu_sdma_ring_init(adev, ring, "sdma", i);
>  		if (r)
>  			return r;
>  	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c index 0f30eb503c2a..1704d406c34a
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -1305,7 +1305,6 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_block
> *ip_block)
>=20
>  	for (i =3D 0; i < adev->sdma.num_instances; i++) {
>  		ring =3D &adev->sdma.instance[i].ring;
> -		ring->ring_obj =3D NULL;
>  		ring->use_doorbell =3D true;
>  		ring->me =3D i;
>  		ring->no_user_submission =3D adev-
>sdma.no_user_submission;
> @@ -1323,14 +1322,12 @@ static int sdma_v7_1_sw_init(struct amdgpu_ip_blo=
ck
> *ip_block) (adev->doorbell_index.sdma_engine[i] << 1); // get DWORD offset
>=20
>  		ring->vm_hub =3D AMDGPU_GFXHUB(xcc_id);
> +		r =3D amdgpu_sdma_ring_init(adev, ring, NULL, i);
> +		if (r)
> +			return r;
> +
>  		sprintf(ring->name, "sdma%d.%d", xcc_id,
> -				GET_INST(SDMA0, i) % adev-
>sdma.num_inst_per_xcc);
> -		r =3D amdgpu_ring_init(adev, ring, 1024,
> -				     &adev->sdma.trap_irq,
> -				     AMDGPU_SDMA_IRQ_INSTANCE0 +=20
i,
> -				     AMDGPU_RING_PRIO_DEFAULT,=20
NULL);
> -		if (r)
> -			return r;
> +			GET_INST(SDMA0, i) % adev-
>sdma.num_inst_per_xcc);
>  	}
>=20
>  	adev->sdma.supported_reset =3D



