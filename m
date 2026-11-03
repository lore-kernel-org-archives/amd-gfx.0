Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0277606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VLaAGUIC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 399C010F7FB;
	Tue,  3 Nov 2026 20:15:54 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD49010F7FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 20:15:47 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso43028855e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 12:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793736946; x=1794341746; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kfMmPLaUF6mSjwtgI+jK26EC5uWaWPJycjbS0Kh2Paw=;
 b=VLaAGUICnkbVvw1+TKBa62Rbd3UsaU+HH0V17tUWcszAixkwDOoFn+aiBVKe/gCqdD
 FIx49teXAotByIB0GPbGCf0+2zC8y86RaFrFEIkwGtdpFUGFw/rlzOJgk/sfPO3Tm39i
 hkdLIw6A4FbYr1o+ebkJQvaogCUe4SW150rZC7bc41QA51MzMathSSYD8SXYXrd+XGVS
 L83NItRAdbOYqMP9V3Acba9RxnVVSQyLtfSFO03jG5kSsrYeM4nJLWetkZwoEXOrXcIe
 +n/kitoA20z9F1ZHNxbUckgrXRbQSodf/8a2/CIND1V6lRficu/konFvSYsw87dGpePv
 J/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793736946; x=1794341746;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kfMmPLaUF6mSjwtgI+jK26EC5uWaWPJycjbS0Kh2Paw=;
 b=RUyCWkKh2vkwtTptOrjva2iGzMBoRjCXRpm5Q3v2Nub79mr90lSKT8qozumQ7GWWzP
 OkuVTckCtt+lOBAG9+aRiZn2vuAITHMz1m9THqlNeKvdn5AjOjQdvRmcOCACzliWJlsY
 UDrhBJjvGTCf9t2vQZF7oHTUzMjX47jocASJdnv2YZtl490wShHU8riTntrz/HJSsUv7
 Bzoj0o3gNTY2Qx30Li/vO8c0VmKJdCv8Vi7t+4khz6JMl63PPVnW4ArfNzqfnwT3Lnwp
 +/D5S1UxjqZzD0nRTlB2u7ioTv3w1FeaWn1QmeRUnW1OB7QlbuIEl/YvqCHuQ8m2nhS3
 GXCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2bRT86Kl8Dop1m0KZDf9OYEz6oF92ZdpBD+o5lfb1GOlGZ1B04AIw99W+RjmC6nvivNQP0n2t@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+YaUC0BjpeZVq4OiX6JxjuZp46HwSpyKSiQrCTqdB76/05oTGQ
 ZND7nWgnhNrhOiP9IlC87AsNuuc3BZc7CqKxrc1M6lTDHT+686H1kBIw
X-Gm-Gg: AYBFou3g46sYLgpYd0tbR+Bi3lHl/BkRk5JiDqY67iypiFUYlOPqB0GHXZLCdLfx31o
 3j6K5PU2Dwe3sCBvfukNX5RgC4v9lzir1+Uf/4CuxlfOAKVnF1Cwrr+KGdenZvoUpTwq6gz9tL5
 93Jn5MeyjhO0BPtcCJGTaD9zzbK2WFPmZrhCu073adci/TKOzbZ4OzJLPGfsgyC+rP1zLoAJAxj
 NGngBxIVd5WPEP0GOuO5en4KtLcwSUEI7FXHHiO30TN+7sTZHV5DBCkhLPTCTHsdAzUSoOi9w5S
 jbxbzDvUqAOQW0QqGL08jL/ezyQJw3L76Toem9wMvTRAsBN415qvZvClaXtGN8Rmrbfkr40sO9A
 JmZnAVWFUdCOy3NAb/CNo2rRdiUaaPbYwP42EfOE2SjPX4v7zbnq9dsQUx93Fk+pqIPR2D+1lny
 biVRDdaNPdOb/cSN6JpnKYPayRh10qocgodSuASvbCUXpp4YTHDJaUIYzecC+tZx9SRl6onAQv+
 6hB8hgyJRwdjfuevWoVxfG2ewfh+z7+aRcW351N2iYU/oKSO2cRzK5Lf+vVTCPNsGSO+LYyjyCa
 K4SsACoBKi72yQu97Z43SAwvsr6Gs92HD8LS6Kfnx9sW02NJgJZ8oTGCN8sruEzHkypnFhoGXKk
 FpqIJRhhp
X-Received: by 2002:a05:600c:4e14:b0:4a5:a5ca:de1d with SMTP id
 5b1f17b1804b1-4ac187a80bfmr334852565e9.30.1793736946228; 
 Tue, 03 Nov 2026 12:15:46 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa38bb4asm84440615e9.6.2026.11.03.12.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 12:15:45 -0800 (PST)
Message-ID: <7010c51113110bce484a2d232bbd90c0b40d250d.camel@gmail.com>
Subject: Re: [PATCH v3 03/15] drm/amdgpu: add an engine scope to the IP
 block soft reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Tue, 03 Nov 2026 21:15:44 +0100
In-Reply-To: <20261028085736.3808569-3-Jesse.Zhang@amd.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-3-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-10-28 at 16:56 +0800, Jesse Zhang wrote:
> Some IP blocks have engines that the hardware can reset on their own,
> eg. the graphics and compute engines of the GFX IP
> (CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET / CMP_ONLY_SOFT_RESET).
> Resetting
> only the engine of a hung ring leaves the work on the other engines
> alone, which the IP block soft reset can't do, as it resets every
> ring
> of the IP block.
>=20
> Add an optional soft_reset_engine() IP block callback, which resets
> one
> engine of the IP block, or all of them, and recovers the user queues
> on
> it, and amdgpu_device_ip_soft_reset_engine() around it. It only
> stops,
> backs up and replays the rings of that engine, and it is also
> reachable
> without a guilty kernel ring, for a hung user queue.
>=20
> For a single engine, it only takes the reset domain for read: KFD
> only
> try-locks it for read before it adds or removes queues, and would
> fail
> those calls with the write lock although the other engines aren't
> reset.
>=20
> amdgpu_device_ip_soft_reset() uses it when the IP block implements
> it,
> for the engine of the guilty ring.
>=20
> v3: replaces the separate engine reset type and helper
> =C2=A0=C2=A0=C2=A0 (Timur).
>=20
> Suggested-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c=C2=A0=C2=A0 | 116
> +++++++++++++++++++++++
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h=C2=A0=C2=A0 |=C2=A0=C2=A0 6 =
++
> =C2=A0drivers/gpu/drm/amd/include/amd_shared.h |=C2=A0 18 ++++
> =C2=A03 files changed, 140 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> index 2eea18965fd1..e95f69dd3142 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> @@ -418,6 +418,111 @@ static u32 amdgpu_ring_mask_from_ip(const enum
> amd_ip_block_type ip_type)
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +/**
> + * amdgpu_ring_mask_from_engine() - Find mask of ring types of an
> engine.
> + *
> + * @ip_type: The IP block type of the engine.
> + * @engine: The engine whose rings you are looking for.
> + */
> +static u32 amdgpu_ring_mask_from_engine(const enum amd_ip_block_type
> ip_type,
> +					const enum amd_ip_engine
> engine)
> +{
> +	switch (engine) {
> +	case AMD_IP_ENGINE_GFX:
> +		return BIT(AMDGPU_RING_TYPE_GFX);
> +
> +	case AMD_IP_ENGINE_COMPUTE:
> +		return BIT(AMDGPU_RING_TYPE_COMPUTE);
> +
> +	default:
> +		return amdgpu_ring_mask_from_ip(ip_type);
> +	}
> +}
> +
> +/**
> + * amdgpu_engine_from_ring() - Find the engine of a ring type.
> + *
> + * @ring_type: The ring type whose engine you are looking for.
> + */
> +static enum amd_ip_engine amdgpu_engine_from_ring(const enum
> amdgpu_ring_type ring_type)
> +{
> +	switch (ring_type) {
> +	case AMDGPU_RING_TYPE_GFX:
> +		return AMD_IP_ENGINE_GFX;
> +
> +	case AMDGPU_RING_TYPE_COMPUTE:
> +		return AMD_IP_ENGINE_COMPUTE;
> +
> +	default:
> +		return AMD_IP_ENGINE_ALL;
> +	}
> +}
> +
> +static const char *const amdgpu_ip_engine_names[] =3D {
> +	[AMD_IP_ENGINE_ALL] =3D "all",
> +	[AMD_IP_ENGINE_GFX] =3D "gfx",
> +	[AMD_IP_ENGINE_COMPUTE] =3D "compute",
> +};

No need to add a new enum.
This is redundant with amdgpu_ring_type.


> +
> +/**
> + * amdgpu_device_ip_soft_reset_engine() - Soft reset one engine of
> an IP block.
> + *
> + * @adev: amdgpu device
> + * @ip_type: The IP block type.
> + * @engine: The engine to reset, or AMD_IP_ENGINE_ALL for the whole
> IP block.
> + * @guilty_ring: The ring which is guilty of causing a reset, or
> NULL.
> + * @guilty_fence: The fence which didn't signal on @guilty_ring.
> + * @guilty_queue: The user queue which is guilty of causing a reset,
> or NULL.
> + */
> +int amdgpu_device_ip_soft_reset_engine(struct amdgpu_device *adev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_ip_block_type
> ip_type,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_ip_engine engine,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ring
> *guilty_ring,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fence
> *guilty_fence,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_usermode_queue
> *guilty_queue)

Please don't add a separate function.
This duplicates a lot of code that shouldn't be duplicated.

Instead, I suggest to just add the new functionality to
amdgpu_device_ip_soft_reset(), for example like this:

if (ip_block->version->funcs->soft_reset_engine)
  ip_block->version->funcs->soft_reset_engine(...);
else if (ip_block->version->funcs->soft_reset)
  ip_block->version->funcs->soft_reset(...);


> +{
> +	struct amdgpu_ip_block *ip_block;
> +	u32 ring_type_mask;
> +	int r;
> +
> +	ip_block =3D amdgpu_device_ip_get_ip_block(adev, ip_type);
> +	if (!ip_block || !ip_block->version->funcs-
> >soft_reset_engine)
> +		return -EOPNOTSUPP;
> +
> +	dev_err(adev->dev, "Starting %s %s engine soft reset\n",
> +		ip_block->version->funcs->name,
> amdgpu_ip_engine_names[engine]);
> +
> +	ring_type_mask =3D amdgpu_ring_mask_from_engine(ip_type,
> engine);
> +
> +	if (engine =3D=3D AMD_IP_ENGINE_ALL)
> +		amdgpu_device_lock_reset_domain(adev->reset_domain);
> +	else
> +		down_read(&adev->reset_domain->sem);
> +	amdgpu_multi_ring_reset_helper_begin(adev, ring_type_mask,
> guilty_ring,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 guilty_fence);
> +
> +	r =3D ip_block->version->funcs->soft_reset_engine(ip_block,
> engine,
> +							guilty_queue
> );
> +
> +	r =3D amdgpu_multi_ring_reset_helper_end(adev, ring_type_mask,
> guilty_ring,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guilty_fence, r);
> +	if (engine =3D=3D AMD_IP_ENGINE_ALL)
> +		amdgpu_device_unlock_reset_domain(adev-
> >reset_domain);
> +	else
> +		up_read(&adev->reset_domain->sem);
> +
> +	if (r) {
> +		dev_err(adev->dev, "Failed %s %s engine soft reset:
> %d\n",
> +			ip_block->version->funcs->name,
> +			amdgpu_ip_engine_names[engine], r);
> +		return r;
> +	}
> +
> +	dev_err(adev->dev, "Successful %s %s engine soft reset\n",
> +		ip_block->version->funcs->name,
> amdgpu_ip_engine_names[engine]);
> +	return 0;
> +}
> +
> =C2=A0/**
> =C2=A0 * amdgpu_device_ip_soft_reset() - Perform a graceful soft reset on
> an IP block.
> =C2=A0 *
> @@ -430,6 +535,9 @@ static u32 amdgpu_ring_mask_from_ip(const enum
> amd_ip_block_type ip_type)
> =C2=A0 * resets all rings that belong to the same device IP block
> =C2=A0 * and re-initializes the device IP block.
> =C2=A0 *
> + * IP blocks with engines that can be reset separately only reset
> the engine
> + * of @guilty_ring, see amdgpu_device_ip_soft_reset_engine().
> + *
> =C2=A0 * The reset is handled gracefully, meaning that we try to
> =C2=A0 * minimize collateral damage (ie. avoid rejecting non-guilty jobs)
> =C2=A0 * as well as back up and restore the contents of all rings
> @@ -441,6 +549,7 @@ int amdgpu_device_ip_soft_reset(struct
> amdgpu_ring *guilty_ring,
> =C2=A0	struct amdgpu_device *adev =3D guilty_ring->adev;
> =C2=A0	struct amdgpu_ip_block *ip_block;
> =C2=A0	enum amd_ip_block_type ip_type;
> +	enum amd_ip_engine engine;
> =C2=A0	u32 ring_type_mask;
> =C2=A0	int r;
> =C2=A0
> @@ -453,6 +562,13 @@ int amdgpu_device_ip_soft_reset(struct
> amdgpu_ring *guilty_ring,
> =C2=A0		return -EOPNOTSUPP;
> =C2=A0	}
> =C2=A0
> +	if (ip_block->version->funcs->soft_reset_engine) {
> +		engine =3D amdgpu_engine_from_ring(guilty_ring->funcs-
> >type);
> +		return amdgpu_device_ip_soft_reset_engine(adev,
> ip_type, engine,
> +							=C2=A0
> guilty_ring,
> +							=C2=A0
> guilty_fence, NULL);
> +	}
> +
> =C2=A0	if (!ip_block->version->funcs->soft_reset) {
> =C2=A0		dev_warn(adev->dev, "IP block soft reset not
> supported on %s\n",
> =C2=A0			 ip_block->version->funcs->name);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> index 5dd6273982c4..856297d1c8e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h
> @@ -160,5 +160,11 @@ bool amdgpu_device_ip_is_valid(struct
> amdgpu_device *adev,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_ip_block_type bloc=
k_type);
> =C2=A0int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
> =C2=A0				struct amdgpu_fence *guilty_fence);
> +int amdgpu_device_ip_soft_reset_engine(struct amdgpu_device *adev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_ip_block_type
> ip_type,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_ip_engine engine,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_ring
> *guilty_ring,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fence
> *guilty_fence,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_usermode_queue
> *guilty_queue);
> =C2=A0
> =C2=A0#endif /* __AMDGPU_IP_H__ */
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
> b/drivers/gpu/drm/amd/include/amd_shared.h
> index e81ce9d79009..95cdd0fc191e 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -29,6 +29,7 @@
> =C2=A0
> =C2=A0#define AMD_MAX_USEC_TIMEOUT		1000000=C2=A0 /* 1000 ms */
> =C2=A0struct amdgpu_ip_block;
> +struct amdgpu_usermode_queue;
> =C2=A0
> =C2=A0
> =C2=A0/*
> @@ -422,6 +423,18 @@ enum DC_DEBUG_MASK {
> =C2=A0
> =C2=A0enum amd_dpm_forced_level;
> =C2=A0
> +/**
> + * enum amd_ip_engine - the engines of an IP block that can be soft
> reset
> + * @AMD_IP_ENGINE_ALL: all the engines of the IP block
> + * @AMD_IP_ENGINE_GFX: the graphics engine of the GFX IP block
> + * @AMD_IP_ENGINE_COMPUTE: the compute engine of the GFX IP block
> + */
> +enum amd_ip_engine {
> +	AMD_IP_ENGINE_ALL,
> +	AMD_IP_ENGINE_GFX,
> +	AMD_IP_ENGINE_COMPUTE,
> +};
> +
> =C2=A0/**
> =C2=A0 * struct amd_ip_funcs - general hooks for managing amdgpu IP Block=
s
> =C2=A0 * @name: Name of IP block
> @@ -441,6 +454,8 @@ enum amd_dpm_forced_level;
> =C2=A0 * @complete: handles IP specific changes after resume
> =C2=A0 * @wait_for_idle: poll for idle
> =C2=A0 * @soft_reset: soft reset the IP block
> + * @soft_reset_engine: soft reset one engine of the IP block, or all
> of them,
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 and recover the user qu=
eues on it
> =C2=A0 * @set_clockgating_state: enable/disable cg for the IP block
> =C2=A0 * @set_powergating_state: enable/disable pg for the IP block
> =C2=A0 * @get_clockgating_state: get current clockgating status
> @@ -469,6 +484,9 @@ struct amd_ip_funcs {
> =C2=A0	void (*complete)(struct amdgpu_ip_block *ip_block);
> =C2=A0	int (*wait_for_idle)(struct amdgpu_ip_block *ip_block);
> =C2=A0	int (*soft_reset)(struct amdgpu_ip_block *ip_block);
> +	int (*soft_reset_engine)(struct amdgpu_ip_block *ip_block,
> +				 enum amd_ip_engine engine,
> +				 struct amdgpu_usermode_queue
> *guilty_queue);
> =C2=A0	int (*set_clockgating_state)(struct amdgpu_ip_block
> *ip_block,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_clockgating_state
> state);
> =C2=A0	int (*set_powergating_state)(struct amdgpu_ip_block
> *ip_block,
