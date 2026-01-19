Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E62CCF2E7
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 11:20:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEE710E29A;
	Mon, 19 Jan 2026 11:20:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i89gRt1w";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338C410E29A
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 11:20:49 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b8719aeebc8so732114666b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 03:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768821647; x=1769426447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1c2GyvC2UdsZJAiaaAeRG6luou9hiuLNFgVbTNLXipI=;
 b=i89gRt1w1ygY9Nnzc69nA7lSbxK1YqBjUrROiVsxRthI4gWME65QV6uUh4uT12TpMf
 IAM1egOxxjVjkVlQpsi1MzUhxqNWcm01lkJjdrDVv+uIkkKN+5X4yFXoW4K4Pct5fi3N
 +aGuUI31OYQuljOdDcdCHQJyLnQbFlM5kvo/tG12W6X9RXyn2BA8jMFovwZejo9gCiYE
 wKdrppbZGdErzHt3Wn0wy3xf627fMEldk/Tj7vmTRj6XQYuUsVhadHUndGwpNVnNSOlx
 HWqeFuhaE2Jb/URl8cEnm/ENgOtYeToO68PagdUxIp43RenCKeHPvlJJQ1JByeDQX0hk
 yIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768821647; x=1769426447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1c2GyvC2UdsZJAiaaAeRG6luou9hiuLNFgVbTNLXipI=;
 b=gUZsRkQTAEmItZzShpDrWskP7R2gtcfNqxVFhIfjwOtp9IWL0fg9ot+faM4LJELLJz
 n3SQ5q5s3S2rSO8DaOEemJbuCOb1S3rxTY2R9PfrFLPTJRGBpynhuKu71d/uwnCT3JJG
 18VQUowVdU6Nm8P+RBeYMa5EuuR13u4JLjvFX74s0peb1aqIoj5CmSSGmoC/D4NSAFAr
 cLncScnlBvVeO/Cq3zo+aXvykmyyfG6aDt6JQ76Yaz3CwmSIDszelkXkTx8qsoWH34ic
 NlSay6ba9zXQ28GFzzVv8VfRSzxFlPHSWuY0WI3gl+l16AC/R4gbMF/P/b4R+puTN6A4
 VilA==
X-Gm-Message-State: AOJu0YzFs7zv02GxyKU1YDDm76i9F4oa8QbveSWt6DCW8D9KDCBe6Hcw
 qgCU5KpJeW0ahp/BI9JAqG6PH0/LJ4mDF7UhZ9xXSoveMlZ/6RKsfRx8zWYyxg==
X-Gm-Gg: AY/fxX7SG09FzRYAJDkmby1NAaQ0d1v5S4ecUf4r1rImltfubLZzxStR2zpprmA9nX0
 km/RnbOxMa5jQIzco0qePiLQvSjruyeGtEr9mjqGn23R045tqh46lI/A7rZUROpHIfbJqqvQmat
 qcNTD0KOeX82pK5Vn62G7M47wsFGXEqtXxSU9kbAixOQRzIadESPLxax49WRhD8OeSWsSSJ6H3i
 CiCJF1UFwWA8Uxrnes6w97MiETDsZOVwxW5ZI+YKYj7KjWryHsMqi6BC8FIp9/WPJ5zPgz18ysl
 p9tnN4a8J8z0jXUaOgXxc8yIH32Yjod/DfaP+C16YKxj1G3FAIZ1TfKTwitgfTCjdGZtPeOPUxN
 kQbB5wQGfpNC2gLAr6yVsvI5GW0uXSW8NQYklTUTrO/w4S7HFaQUrttD1oj2SNLBz5rGL9uaUgO
 JgRlcJ2fF3CvXNPMKq3XV/WIa/X0OmBd2p94X9yvrUzRNldwd4qkrykvOtde1VwfRmtE1qHhSyJ
 VChBmpeU4Y8yolAHQv8FWaq
X-Received: by 2002:a17:906:9fc9:b0:b87:91cb:7412 with SMTP id
 a640c23a62f3a-b8792fea1f1mr974863466b.53.1768821646926; 
 Mon, 19 Jan 2026 03:20:46 -0800 (PST)
Received: from timur-hyperion.localnet
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513e6d3sm1081718366b.4.2026.01.19.03.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jan 2026 03:20:46 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Prike Liang <Prike.Liang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix validating flush_gpu_tlb_pasid()
Date: Mon, 19 Jan 2026 12:20:45 +0100
Message-ID: <4856897.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <0b3603e5-f6d1-4be8-80dc-e9aaaac48e40@amd.com>
References: <20260118125746.40221-1-timur.kristof@gmail.com>
 <0b3603e5-f6d1-4be8-80dc-e9aaaac48e40@amd.com>
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

On Monday, January 19, 2026 11:12:02=E2=80=AFAM Central European Standard T=
ime=20
Christian K=C3=B6nig wrote:
> On 1/18/26 13:57, Timur Krist=C3=B3f wrote:
> > When a function holds a lock and we return without unlocking it,
> > it deadlocks the kernel. We should always unlock before returning.
> >=20
> > This commit fixes suspend/resume on SI.
> > Tested on two Tahiti GPUs: FirePro W9000 and R9 280X.
> >=20
> > Fixes: bc2dea30038a ("drm/amdgpu: validate the flush_gpu_tlb_pasid()")
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c index
> > 0e67fa4338ff..4fa24be1bf45 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -769,7 +769,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> > amdgpu_device *adev, uint16_t pasid,>=20
> >  	struct amdgpu_ring *ring =3D &adev->gfx.kiq[inst].ring;
> >  	struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[inst];
> >  	unsigned int ndw;
> >=20
> > -	int r, cnt =3D 0;
> > +	int r =3D 0, cnt =3D 0;
>=20
> Please don't initialize return values in the declaration, that is usually
> considered bad coding style.

The initialization is necessary, otherwise the function will return an=20
uninitialized value when flush_gpu_tlb_pasid=3D=3DNULL

> >  	uint32_t seq;
> >  =09
> >  	/*
> >=20
> > @@ -782,7 +782,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> > amdgpu_device *adev, uint16_t pasid,>=20
> >  	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready) {
> >  =09
> >  		if (!adev->gmc.gmc_funcs->flush_gpu_tlb_pasid)
> >=20
> > -			return 0;
> > +			goto error_unlock_reset;
>=20
> Ah, yes good catch!
>=20
> With the change to r initialization dropped: Reviewed-by: Christian K=C3=
=B6nig
> <christian.koenig@amd.com>

If I drop it, then it will regress again because it returns an uninitialize=
d=20
value.

>=20
> Regards,
> Christian.
>=20
> >  		if (adev->gmc.flush_tlb_needs_extra_type_2)
> >  	=09
> >  			adev->gmc.gmc_funcs-
>flush_gpu_tlb_pasid(adev, pasid,
> >=20
> > @@ -797,7 +797,6 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct
> > amdgpu_device *adev, uint16_t pasid,>=20
> >  		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
> >  	=09
> >  							=20
flush_type, all_hub,
> >  							=20
inst);
> >=20
> > -		r =3D 0;
> >=20
> >  	} else {
> >  =09
> >  		/* 2 dwords flush + 8 dwords fence */
> >  		ndw =3D kiq->pmf->invalidate_tlbs_size + 8;




