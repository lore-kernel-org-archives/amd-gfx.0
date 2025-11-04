Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC0DCCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 15:26:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7E8610E62A;
	Tue,  4 Nov 2025 15:26:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CxaPxK7r";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D0B10E629
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 15:26:57 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b50206773adso1152994166b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 07:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762270016; x=1762874816; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nhnFMW4lmbBpkExPQAhpa2f6+vcY2YCONaKX/nfSj8=;
 b=CxaPxK7rsCVSO1UrC6IGYt7QVFOyOij9chEE9cDSMOv3Lt1SWh4DCR4NCDj6ar24dG
 rPnHAC3CmqT02EKWGjg6r0zvyWP4FlyDJFz6Gyamf8SOUq/mU74qMtFbpuIoFhivIYph
 muwEkfsUzd8vd1QHzkKeBfFEusZybnu0Z4mSm4F35byNAMLB8v6yGt+98DEW5nRGxdl2
 1+IYVCgjES5TgTm37ktH3/PUUBfJuDwwe1HzqKGTI/GVQP9QNI1GDLt96pwcVW9doLST
 6P4pQc1FUl3FO1fTJXsVrxupWBOIF60a7swkSaegc6Yaf35BMbpM1gy8Ftv2AKLF1TOL
 IZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762270016; x=1762874816;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1nhnFMW4lmbBpkExPQAhpa2f6+vcY2YCONaKX/nfSj8=;
 b=N3s4VaKUSkkjW+q4l6wGQ8lGGhq9YBwoFQL0MG6KT73pSy+3P6wDsTKUtaBSdjKUFy
 HBbuk/Ebecp7gp5HOHnGichb8wA8aSpWzJx3RdGkrBgXOvZE8D1evmqmPnH10Zu96GXI
 1/NlV6ht+r8ABBenorSFcgHTjbKAfM5/tjcAzkScvTDtC9L8mJpF8zfUHNKCGSJ/x4Sr
 8syRM2C8bfu6GQruHu53afn4qj9y9wu0/RkQnjkcZxltn7x+mEn8tYZTuHR87D1l3bj1
 AsLvd9c9a6PsCyJXmbrYN9GZ+cpjRMjLtIBCxgllEvRk/VP+jgREfMqQc599SC9oJAbH
 95oA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqvgbX/oku2SyhgS4b0xnRlSPhsSGdEVW0V55rH6GlF/gGNDCiQd2f4YqjRgwnXfEgoC+DCsNR@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcfZEFgNMpsdcO67bHKrXbhbUQT9SuMOKShLETYjcvP8tvjJmi
 TiDDVC3dismOtp+/5wVXp5jyPO00fjUTnyCfrKChGwQkpPK1xRg6GYBf4M13uw==
X-Gm-Gg: ASbGncsoo9Xa2SXWRNmc3rnfhm67FWiGYuG7/Te9d6vKU/6eEiATLK67xzNhB2S4cFt
 gFAYPOaby6PXM9yDtak9yEF168LntrZJzYp9PQqMu9dNTDGKQvF8uIsUg3e+8VnmQut9TOz40z4
 WTzuW7DNiwZ92BFKr6tPszbnEOgyR3H9L9gK8HpUpVobcf1Z03Bsmft6yRmaAq0XIDWIqNkesgZ
 gDsZw7n4yeRwwyyfEsrTppw9yden2M8wx6FBPY2lGmBIw/M4eWaye+4nha9fNuUAP8kP00i2h5z
 8RTszsLB1O3X5/XXfSZ0D1RRNc3ZJSfyaVdRwfbx78/8eQ+40w+GItCuL6cMRT3A/kLmRQFwmVo
 dIy85t4cRBGdgk0pUEBZ27SmZUGwnVVznzPWe9TMitZMFZgEi3ubGbrXWKZmmysr85mE025lD1s
 TWKuEHHzdTOWqEuynPq6yOYMlqtTWl/2NUHQYROYZq3926kk/+K/eZA/gGs7DucSJByQijkjoHZ
 FY4RuQdCH3KCBoyn5+pXBNZq9nTv1177XhTuTI7Cw==
X-Google-Smtp-Source: AGHT+IF8hOu776a2f1hhjSTn/Rw3aCrThcmHPwq6JtEXcHqdE1S4FNjdUDILpy3XiGvt5CCkcrWjHQ==
X-Received: by 2002:a17:907:940b:b0:b6d:5fbf:8c63 with SMTP id
 a640c23a62f3a-b7216402595mr468371366b.15.1762270015488; 
 Tue, 04 Nov 2025 07:26:55 -0800 (PST)
Received: from ?IPv6:2001:4c4e:24ca:a400:8825:f46d:d14d:d33?
 (20014C4E24CAA4008825F46DD14D0D33.dsl.pool.telekom.hu.
 [2001:4c4e:24ca:a400:8825:f46d:d14d:d33])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723fa023adsm228522666b.51.2025.11.04.07.26.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 07:26:55 -0800 (PST)
Message-ID: <30d7073e8289db8a2db9d1ae15b33ca50680364c.camel@gmail.com>
Subject: Re: [PATCH 01/16] drm/amdgpu/gmc: Don't hardcode GART page count
 before GTT
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>, Christian
 =?ISO-8859-1?Q?K=F6nig?=	 <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher	 <alexander.deucher@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,  Rodrigo Siqueira
 <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Date: Tue, 04 Nov 2025 16:26:54 +0100
In-Reply-To: <237b5110-bf9b-452a-ab51-51ca67f7589d@damsy.net>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
 <20251103222333.37817-2-timur.kristof@gmail.com>
 <9b4daf2b-d97d-4b3d-bd7b-3b136a4e304c@amd.com>
 <237b5110-bf9b-452a-ab51-51ca67f7589d@damsy.net>
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

On Tue, 2025-11-04 at 16:08 +0100, Pierre-Eric Pelloux-Prayer wrote:
>=20
>=20
> Le 04/11/2025 =C3=A0 14:23, Christian K=C3=B6nig a =C3=A9crit=C2=A0:
> >=20
> >=20
> > On 11/3/25 23:23, Timur Krist=C3=B3f wrote:
> > > GART contains some pages in its address space that come before
> > > the GTT and are used for BO copies.
> > >=20
> > > Instead of hardcoding the size of the GART space before GTT,
> > > make it a field in the amdgpu_gmc struct. This allows us to map
> > > more things in GART before GTT.
> > >=20
> > > Split this into a separate patch to make it easier to bisect,
> > > in case there are any errors in the future.
> > >=20
> > > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > ---
> > > =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c=C2=A0=C2=A0=C2=A0=C2=
=A0 | 2 ++
> > > =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h=C2=A0=C2=A0=C2=A0=C2=
=A0 | 1 +
> > > =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 2 +-
> > > =C2=A0 3 files changed, 4 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > index 97b562a79ea8..bf31bd022d6d 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > > @@ -325,6 +325,8 @@ void amdgpu_gmc_gart_location(struct
> > > amdgpu_device *adev, struct amdgpu_gmc *mc,
> > > =C2=A0=C2=A0		break;
> > > =C2=A0=C2=A0	}
> > > =C2=A0=20
> > > +	mc->num_gart_pages_before_gtt =3D
> > > +		AMDGPU_GTT_MAX_TRANSFER_SIZE *
> > > AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> > > =C2=A0=C2=A0	mc->gart_start &=3D ~(four_gb - 1);
> > > =C2=A0=C2=A0	mc->gart_end =3D mc->gart_start + mc->gart_size - 1;
> > > =C2=A0=C2=A0	dev_info(adev->dev, "GART: %lluM 0x%016llX -
> > > 0x%016llX\n",
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > > index 55097ca10738..568eed3eb557 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > > @@ -266,6 +266,7 @@ struct amdgpu_gmc {
> > > =C2=A0=C2=A0	u64			fb_end;
> > > =C2=A0=C2=A0	unsigned		vram_width;
> > > =C2=A0=C2=A0	u64			real_vram_size;
> > > +	u32			num_gart_pages_before_gtt;
> > > =C2=A0=C2=A0	int			vram_mtrr;
> > > =C2=A0=C2=A0	u64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc_ma=
sk;
> > > =C2=A0=C2=A0	const struct firmware=C2=A0=C2=A0 *fw;	/* MC firmware */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > > index 0760e70402ec..4c2563a70c2b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> > > @@ -283,7 +283,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device
> > > *adev, uint64_t gtt_size)
> > > =C2=A0=20
> > > =C2=A0=C2=A0	ttm_resource_manager_init(man, &adev->mman.bdev,
> > > gtt_size);
> > > =C2=A0=20
> > > -	start =3D AMDGPU_GTT_MAX_TRANSFER_SIZE *
> > > AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> > > +	start =3D adev->gmc.num_gart_pages_before_gtt;
> >=20
> > I would prefer that we have a single function which returns the
> > number of GART pages we need before the dynamic GTT mapping.
> >=20
> > But let me see how Pierre-Eric solved this first.
> >=20
>=20
> The only conflicting change with my series is that I changed this:
>=20
> -	start =3D AMDGPU_GTT_MAX_TRANSFER_SIZE *
> AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
> +	start =3D AMDGPU_GTT_MAX_TRANSFER_SIZE * reserved_windows;
>=20
> So to account for Timur's change, I would only need to adapt this
> part:
>=20
> +	mc->num_gart_pages_before_gtt =3D
> +		AMDGPU_GTT_MAX_TRANSFER_SIZE * reserved_windows;
>=20

Hi Christian & Pierre-Eric,

I assume this conversation is about the following series:
drm/amdgpu: use all SDMA instances for TTM clears and moves

My question is, which series do we want to land first? I would really
like VCE1 to get into Linux 6.19, but otherwise I'm OK with either of
these two options:

1. If Pierre-Eric's series lands sooner: I'm happy to rebase my work
and use Pierre-Eric's solution.
2. If my series lands first: I'm happy to contribute a patch to Pierre-
Eric's series to adapt my workaround to his solution, if that helps.

Please let me know how you guys prefer to proceed.

Thanks & best regards,
Timur

> >=20
> > > =C2=A0=C2=A0	size =3D (adev->gmc.gart_size >> PAGE_SHIFT) - start;
> > > =C2=A0=C2=A0	drm_mm_init(&mgr->mm, start, size);
> > > =C2=A0=C2=A0	spin_lock_init(&mgr->lock);
