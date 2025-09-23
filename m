Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AF1CAC5AC
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Sep 2025 23:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CA7C10E5DA;
	Tue, 23 Sep 2025 23:00:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="brVqfx/4";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F80910E5DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 23:00:49 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-330b0bb4507so3916719a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Sep 2025 16:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758668449; x=1759273249; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1U7cilwNnTGIqt3DPs8LqOvMua7qXh5lV9ta4jiN5NE=;
 b=brVqfx/4gyuYO5fKI5zo/bzhUwlczWKwr/F3lgV3F5R4hQCLX18laFx6G8Ho3EFlIf
 aLuJxWxEDtz3sltRrAaohCiK2HcqIJN7lxrEt+PJa9fC6m/11dZk5IH4lM0jW1E8vFM1
 +83jgZgANs8aSKMidN1Ff2y4+mDlHWv8l64mwCH0fvYtapvJVZx1OF7NBMOYR2DOJF/8
 kFAF7IU7ncJWSva0XUPCOOqsFEfO230Nbgfu/qc/Vm32xywanJhbKRT932VOSskBZIgc
 9/uvI2r8mtZV5fHITAvrte6ue/rd6pTra2YD4/3VLcFyXEjl175C2B4/8nnERCQcjC0w
 sgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758668449; x=1759273249;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1U7cilwNnTGIqt3DPs8LqOvMua7qXh5lV9ta4jiN5NE=;
 b=URKeTco4cvytEgzdcjlX5v/4DdOrAYwEgIvFXwqQdR1eYZp6MLqaf7NC+KPkfalXiQ
 RyRB4364swKNkH/2hx+J3ds1H59VpRZD+hckMzk6sCqcTpx/RvzBvUHaf9xLuWDA4Gi2
 ZuGVvBKGd7cHa1DJxTGwtrH3VqLMdBCfKuhAi4y0HXKMyHS76DNOjiZxqZqDGDtTCTMo
 9/dHrxF37ZquCQF4DnhBiS1BzKPxRNZHBfD9WXXRD47VVUZDXDwAANKvuPVthQMwt//K
 +G3TVcJBTElVBVam7S+WCmTDXeeRXQS6gaVwMIaTWb17P/3uBtAKhw0cLCDBdGp9C9AR
 ME5w==
X-Gm-Message-State: AOJu0YwsmVzBvk2AhaiRwfMwdd01TzUrzwjzBGW8XUp4CY0eq2qDvTIQ
 pe4OXmpdstSM/GGFDWuds+AXof8tUDW3esIOquj74qZ7cLPYWd8vxsQO/faVQw==
X-Gm-Gg: ASbGncsM1TbxFi3NTk/mBg7uNNderpfI1efMzmeTc6o4uvcoN1A4PVDD9yA8IkmdeZ4
 X5DQ06ti9hE0P9mXCf7PPWwk1l066NLyHWW2wZXbQurOmUujAHWviOmIU+4+2itEqE45oUw8hHY
 gGQARDngl2qHQciNUZKa47uB1EbEtKN8w6r9LhvZ28+1CpmW5XwvUITkWCBjkQd087zosRpH87q
 12c1xmPxtmIQeKjunBjmQZ1wIcJ9jnGbYTrLxDG/70cy2mBLBXaJT2MbMGi0wPvfZNkdxWMAWac
 j9yExC6+NpYLBaOJFUvE69yfuDoNIvEU5fz6kBYdKWI/yb3xwNuGW9FzzhX84DqqQfcmHG/7luJ
 1nrcE8TjzskHBw5GUpbj0pfKUcyIxRIkNeRSVQ2xaKV0Fjk9wwnUn35EdIsN+pNPmcURqnWlCYy
 eXsw==
X-Google-Smtp-Source: AGHT+IElL/Dh2gVLNywr38cMA6fcZImTRoybXuM5YWXRcKqKGdrQXvqCXXRGx+jVsj1Bv07e5TA2vA==
X-Received: by 2002:a17:90b:4b82:b0:330:604a:1009 with SMTP id
 98e67ed59e1d1-332a95c82d3mr3922823a91.23.1758668448719; 
 Tue, 23 Sep 2025 16:00:48 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24d0:6700:2d63:3626:f382:b5d2?
 ([2001:4c4e:24d0:6700:2d63:3626:f382:b5d2])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77f1f2a1bdasm10035559b3a.3.2025.09.23.16.00.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 16:00:47 -0700 (PDT)
Message-ID: <1bf9dea32c916538866be9eccb424a28ed1f077d.camel@gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: block CE CS if not explicitely allowed
 by module option
From: timur.kristof@gmail.com
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 alexander.deucher@amd.com, Marek.Olsak@amd.com
Cc: amd-gfx@lists.freedesktop.org
Date: Wed, 24 Sep 2025 01:00:38 +0200
In-Reply-To: <20250923131025.3268-2-christian.koenig@amd.com>
References: <20250923131025.3268-1-christian.koenig@amd.com>
 <20250923131025.3268-2-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
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

On Tue, 2025-09-23 at 15:10 +0200, Christian K=C3=B6nig wrote:
> The Constant Engine found on gfx6-gfx10 HW has been a notorious
> source of
> problems.
>=20
> RADV never used it in the first place, radeonsi only used it for a
> few
> releases around 2017 for gfx6-gfx9 before dropping support for it as
> well.
>=20
> While investigating another problem I just recently found that
> submitting
> to the CE seems to be completely broken on gfx9 for quite a while.
>=20
> Since nobody complained about that problem it most likely means that
> nobody is using any of the affected radeonsi versions on current
> Linux
> kernels any more.
>=20
> So to potentially phase out the support for the CE and eliminate
> another
> source of problems block submitting CE IBs unless it is enabled again
> using a debug flag.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Hi Christian,

Would you be open to receiving a patch to stop emitting the CE related
workarounds when the CE is not enabled?

Alternatively, could we stop emitting them altogether now that the CE
is disabled by default?

Also, should the new debug flag be documented?

Thanks & best regards,
Timur


> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu.h=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 | 6 ++++++
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 +++++++-
> =C2=A03 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2a0df4cabb99..6f5b4a0e0a34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1290,6 +1290,7 @@ struct amdgpu_device {
> =C2=A0	bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> debug_disable_gpu_ring_reset;
> =C2=A0	bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 debug_vm_userptr;
> =C2=A0	bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 debug_disable_ce_logs;
> +	bool=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 debug_enable_ce_cs;
> =C2=A0
> =C2=A0	/* Protection for the following isolation structure */
> =C2=A0	struct mutex=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enforce_isolat=
ion_mutex;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 744e6ff69814..322890e2c899 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -364,6 +364,12 @@ static int amdgpu_cs_p2_ib(struct
> amdgpu_cs_parser *p,
> =C2=A0	if (p->uf_bo && ring->funcs->no_user_fence)
> =C2=A0		return -EINVAL;
> =C2=A0
> +	if (!p->adev->debug_enable_ce_cs &&
> +	=C2=A0=C2=A0=C2=A0 chunk_ib->flags & AMDGPU_IB_FLAG_CE) {
> +		dev_err_ratelimited(p->adev->dev, "CE CS is blocked,
> use debug=3D0x400 to override\n");
> +		return -EINVAL;
> +	}
> +
> =C2=A0	if (chunk_ib->ip_type =3D=3D AMDGPU_HW_IP_GFX &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
> =C2=A0		if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index ece251cbe8c3..3b3fc734c0f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -144,7 +144,8 @@ enum AMDGPU_DEBUG_MASK {
> =C2=A0	AMDGPU_DEBUG_DISABLE_GPU_RING_RESET =3D BIT(6),
> =C2=A0	AMDGPU_DEBUG_SMU_POOL =3D BIT(7),
> =C2=A0	AMDGPU_DEBUG_VM_USERPTR =3D BIT(8),
> -	AMDGPU_DEBUG_DISABLE_RAS_CE_LOG =3D BIT(9)
> +	AMDGPU_DEBUG_DISABLE_RAS_CE_LOG =3D BIT(9),
> +	AMDGPU_DEBUG_ENABLE_CE_CS =3D BIT(10)
> =C2=A0};
> =C2=A0
> =C2=A0unsigned int amdgpu_vram_limit =3D UINT_MAX;
> @@ -2289,6 +2290,11 @@ static void amdgpu_init_debug_options(struct
> amdgpu_device *adev)
> =C2=A0		pr_info("debug: disable kernel logs of correctable
> errors\n");
> =C2=A0		adev->debug_disable_ce_logs =3D true;
> =C2=A0	}
> +
> +	if (amdgpu_debug_mask & AMDGPU_DEBUG_ENABLE_CE_CS) {
> +		pr_info("debug: allowing command submission to CE
> engine\n");
> +		adev->debug_enable_ce_cs =3D true;
> +	}
> =C2=A0}
> =C2=A0
> =C2=A0static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev,
> unsigned long flags)
