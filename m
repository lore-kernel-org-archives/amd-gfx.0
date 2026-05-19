Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4785DCD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEEC10EB85;
	Tue, 19 May 2026 08:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aO2ThyGS";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762CE10EB73
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:59:49 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso25838945e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779181188; x=1779785988; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PYt78/tqQPjL1JK5D5V4Vpt5eKk2kwzAv9g07yXF/oE=;
 b=aO2ThyGSh5BjRzE1Oaeo0Ll3RwPh3GLt7wtCNsvaktLzYQdxTzYoaSH1CMuGKAZZl8
 SLSgjh70D8xMUOBM1RqhhEFInBDlPMld7iNgeU/zaN3k1cdubSH2VRcidEMgrkD5myM1
 Qk2LsozNHeUgkfOEkOfm83bU5BwONbqZSMFWYGAnHvmCYuREsyAGpZEfbc+tf4WQ4vAu
 aE0HFoCtX6iPOAf1VAr0NPEoWOY6KvO8ruqc2fm70JGg1S2jGiPXDQgdzsdaQIrvLWzr
 3He5kfV0A1T4kDhbxWkHfLIWN3KtJWSs81UZ2nLbazxcznnyZ4nSxfnj2Hh435L4lZdB
 qF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779181188; x=1779785988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PYt78/tqQPjL1JK5D5V4Vpt5eKk2kwzAv9g07yXF/oE=;
 b=QBLNmdWlAFaHrfZJucA0g8WDVyIRseHhu5FcUk7fkVj55pq4IC6+RuYNRXlk1oJTxh
 d+Xc74J8F6Ijr2u5vcLwHiu2+9YYl4yYzmKQU4CGsezpl4NHIhef8+7K8SVe4G/gRmqr
 JEB/ZLi3yPoKOlwHXCYd7rctavo6qnpqB5EmGZ+hWF0PKnfkDsNMiW9ZrnKDDt68XxlR
 xfZKaHKEpzt+UdmPLhLgsrVA4L6yiDQQlkWE97AkFSAcbqx3hvj87oSniZZunxN2tZ30
 nXtK5LcULi7XOle6sb1vQdhhOXmy3WfZKIo5y/s0EPGQev3+iVBo/NtBjAwEkisYH2CE
 wueg==
X-Gm-Message-State: AOJu0YzeeV1z2M7xqulrKpwoZGBaw5BvFppsO23tZTWy2VFej/EwpRey
 /dAnAExbNWD+wL/nZ0vLL6/p8kBhIz96yzgEnkSF4Mm/JhGC8XHdi+j4EgoBjg==
X-Gm-Gg: Acq92OGbbLod8q1G0svLcoEPUrODz9P2/QT4W9hlJku8HRU5i97hOHmKCiAQ4XTO7uV
 jb2ylejWZuZU2Gl8akgyFOS7ghrF3aKSON+D926oFzor4eggoETIqvuEeFvtib3B1Brp7Uq5+w6
 AzK2dExNddwAmOOfgceCs2bQCyRTewPGw2W8PvdrAyfg/ah+oqFzDz5T178ox1hj5d1jk3xV2eC
 R4C34OGQbJhuwx9vL2cB6bq86YxvYmIavoWzyFfk/i1sWHVtmC8YX5J3KUJjg532oaYbE8fsMDW
 x0A4ybQSmTq4COpzdKYZiuh047Vczy0qmx6NJNsxXIvV6q5e2muA635fpeOI6ZGCU3l2GT30/aV
 8KcVjm45dpRxy+tAjhngcp+C5SiCARDZEyF9bqX2exuqcMM/zsfgXmXAz85dFfrpI0ydBxgqZZH
 X4SKz8tEiueNRZYwO+HPjNvIaGcukNmngyVJbmnlQ6B0AFJCVIyBGdS2jYPrv6kyrLNsKXZQ==
X-Received: by 2002:a05:600c:4fc9:b0:48e:706b:53e3 with SMTP id
 5b1f17b1804b1-48fe60e51eamr258591425e9.1.1779181187940; 
 Tue, 19 May 2026 01:59:47 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5e9d5d9sm364642265e9.15.2026.05.19.01.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:59:47 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, John Olender <john.olender@gmail.com>,
 Liu Leo <Leo.Liu@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: Use placements of 256M GART segments for
 SI/CIK
Date: Tue, 19 May 2026 10:59:46 +0200
Message-ID: <2219923.9o76ZdvQCi@timur-hyperion>
In-Reply-To: <69dcb4d8-1199-45f7-88dc-c77efb248542@amd.com>
References: <20260519082204.60811-1-timur.kristof@gmail.com>
 <20260519082204.60811-3-timur.kristof@gmail.com>
 <69dcb4d8-1199-45f7-88dc-c77efb248542@amd.com>
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

On Tuesday, May 19, 2026 10:54:10=E2=80=AFAM Central European Summer Time C=
hristian=20
K=C3=B6nig wrote:
> On 5/19/26 10:22, Timur Krist=C3=B3f wrote:
> > UVD 4.x and older require that BOs don't cross 256M segments.
> > We need to respect that in amdgpu_ttm_alloc_gart().
> > We can't move the BOs later because GTT->GTT moves are
> > not implemented. We also can't force all BOs to VRAM
> > because that becomes very problematic in low VRAM scenarios.
> >=20
> > This fixes UVD CS BOs crossing 256M segments
> > when they are placed in the GART.
>=20
> Clear NAK for that approach.
>=20
> This is the general TTM interface function and shouldn't have any HW
> generation dependent code in it.

I don't see how else to solve this, since GTT->GTT moves are not implemente=
d,
so we can't move the BO to a suitable address later. We also can't move it =
to=20
VRAM.

Please suggest a better approach if you don't like this one.


>=20
> Regards,
> Christian.
>=20
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4799
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 56 ++++++++++++++++++++++---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  3 ++
> >  2 files changed, 53 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c index
> > 6c6ab4dd6ea9..a106c7e77e26 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -959,6 +959,40 @@ static int amdgpu_ttm_backend_bind(struct ttm_devi=
ce
> > *bdev,>=20
> >  	return 0;
> > =20
> >  }
> >=20
> > +/**
> > + * amdgpu_ttm_fill_gart_256M_placements() - Fill placements array with
> > 256M GART segments + *
> > + * @bo: TTM buffer objects whose placements should be filled
> > + * @placements: Pointer to an array of placements
> > + * @max_placements: Size of the placements array
> > + *
> > + * Fill the specified placements array with 256M GART segments,
> > + * starting from the highest address in order to reduce the
> > + * contention of the lowest segment.
> > + *
> > + * Returns the number of placements filled.
> > + */
> > +u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *bo,
> > +					 struct ttm_place=20
*placements,
> > +					 u32 max_placements)
> > +{
> > +	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->bdev);
> > +	u32 i;
> > +
> > +	/* Fill the placements array with 256M segments, starting from=20
highest.
> > */ +	for (i =3D 0; i < max_placements; ++i) {
> > +		if (i * SZ_256M >=3D adev->gmc.gart_size)
> > +			break;
> > +
> > +		placements[i].lpfn =3D (adev->gmc.gart_size - i *=20
SZ_256M) >> PAGE_SHIFT;
> > +		placements[i].fpfn =3D ALIGN_DOWN(placements[i].lpfn - 1,=20
SZ_256M >>
> > PAGE_SHIFT); +		placements[i].mem_type =3D TTM_PL_TT;
> > +		placements[i].flags =3D bo->resource->placement;
> > +	}
> > +
> > +	return i;
> > +}
> > +
> >=20
> >  /*
> > =20
> >   * amdgpu_ttm_alloc_gart - Make sure buffer object is accessible either
> >   * through AGP or GART aperture.
> >=20
> > @@ -973,7 +1007,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object
> > *bo)>=20
> >  	struct ttm_operation_ctx ctx =3D { false, false };
> >  	struct amdgpu_ttm_tt *gtt =3D ttm_to_amdgpu_ttm_tt(bo->ttm);
> >  	struct ttm_placement placement;
> >=20
> > -	struct ttm_place placements;
> > +	struct ttm_place placements[AMDGPU_BO_MAX_PLACEMENTS];
> >=20
> >  	struct ttm_resource *tmp;
> >  	uint64_t addr, flags;
> >  	int r;
> >=20
> > @@ -987,11 +1021,21 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_obje=
ct
> > *bo)>=20
> >  	/* allocate GART space */
> >  	placement.num_placement =3D 1;
> >=20
> > -	placement.placement =3D &placements;
> > -	placements.fpfn =3D 0;
> > -	placements.lpfn =3D adev->gmc.gart_size >> PAGE_SHIFT;
> > -	placements.mem_type =3D TTM_PL_TT;
> > -	placements.flags =3D bo->resource->placement;
> > +	placement.placement =3D &placements[0];
> > +	placements[0].fpfn =3D 0;
> > +	placements[0].lpfn =3D adev->gmc.gart_size >> PAGE_SHIFT;
> > +	placements[0].mem_type =3D TTM_PL_TT;
> > +	placements[0].flags =3D bo->resource->placement;
> > +
> > +	/*
> > +	 * UVD 4.x and older require that BOs don't cross 256M segments.
> > +	 * We need to respect that here. We can't move the BO later
> > +	 * because GTT->GTT moves are not implemented.
> > +	 */
> > +	if (bo->base.size < SZ_256M && adev->family <=3D AMDGPU_FAMILY_KV)
> > +		placement.num_placement =3D
> > +			amdgpu_ttm_fill_gart_256M_placements(bo,=20
placements,
> > +							    =20
ARRAY_SIZE(placements));
> >=20
> >  	r =3D ttm_bo_mem_space(bo, &placement, &tmp, &ctx);
> >  	if (unlikely(r))
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h index
> > 2d72fa217274..e9de628c8d2d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > @@ -202,6 +202,9 @@ int amdgpu_ttm_clear_buffer(struct
> > amdgpu_ttm_buffer_entity *entity,>=20
> >  			    u64 k_job_id);
> > =20
> >  struct amdgpu_ttm_buffer_entity *amdgpu_ttm_next_clear_entity(struct
> >  amdgpu_device *adev);>=20
> > +u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *bo,
> > +					 struct ttm_place=20
*placements,
> > +					 u32 max_placements);
> >=20
> >  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> >  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
> >  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t
> >  type);




