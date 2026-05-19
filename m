Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2930CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 09:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AAAE10E37E;
	Tue, 19 May 2026 09:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KAKeiqwt";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0982F10E37E
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 09:16:32 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so1294856f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 02:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779182190; x=1779786990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a9ZUDQXmoyvcKeSwLboM1ib6wkSlBll0X/tbIyopiYc=;
 b=KAKeiqwt8El8dRkHR87uw2aUHW5FeYKe9KVD3adrTaS4YR+pfF7ef1Km04LP6NOcO7
 HbaNixo+j/qRCyaakkXhHcEr9+VyLar4IBJlZShMIYhkB8FfL5QRYWmkRrrDs+svXcfi
 Yp3N7nlN/K+EXaHLhfQNl+vReEYk2DoL89ILB92EAeYH9fd5icKGrm0sW1ddyw/KQEhf
 MeZV4IfTSgHpSN5JlId0rXD2x2Lo4wR+Rq/Z0XPbIK9nurhwW5YLbTnq4nKESAoAbU33
 9TtdJBdT0Er/AhyQafWJlZ0JvpSUlANM5TF5ZN1A81D3TZsYeTSug+v1ndGB9XQeGx6p
 UvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779182190; x=1779786990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a9ZUDQXmoyvcKeSwLboM1ib6wkSlBll0X/tbIyopiYc=;
 b=HuZQaO9GS9mswH0wwc6dTvBJce90qY8NGYhfZYaE9W+qZC+0Sltr4oE9YNdPjeDJfk
 SlyAQ61MZGZ98PohooeHwUNIjUUdMI+RYVVE/2cvUJvpnADUB3C4DToBaeku0jOhbQHF
 crhc4N8qeYu/U0TMbKp/GxCuTFgrhwrfPlXPTm0et0sN8LjgI9PfofKMtYMh/xl30cin
 CiPXJGVYAhC0Ue5XUOOLgeXU0siAG9zn44p+X4hX7QQyRsEWD4PZlVsVchAm6FHkTi8U
 vVyp8iixohsJq3jFeaQ8NqTZuPBS9bbdiQ6GXLlrdcAQjhPe6JT9sGEadhRO2OCitBae
 EZtA==
X-Gm-Message-State: AOJu0YyPtQuerDMnR6/Ut37VX2Zvh/L9YMMC6hwf+ipw9ewVd9r5QaY2
 mFWOCe+K2dgYDYQrwEPe1brWr0wdxJTsadDS2veeEaqLYHibZfx6Obw4hYNt/Q==
X-Gm-Gg: Acq92OGnPavoicaDEjgKDDrYEYaZi6D6anVpKo4F8FXiSAp8qxF7PwXEtQOAGhdSclY
 IeaBQgNGka0tVIT7EHZTu0ENBO8g65GZGFzSjdxm3+Za3HAqwZhhHZq9fag1fRvvzdbchzYXe/u
 +RB07mA7kRSI03fVL3KfDJ8KhvWzKa9ddbgHpBcnmD+cf5eCITwKcgGSwwC8xJUlY5oW22NAlVb
 S2lyj+P9k7+4QfxxnW6EzVNQNtWQtswJpAYbvuHDYeS8v6W2bz6l/ulTjZVuPevJDUbTzRY0X2u
 vfEC2b9+ln1/CMnms0YMdnqRxa/Zr83if5AoY/EWBN8sdQh1hd5gNRJOaVYAQIeWzueyclaLZ/r
 dEeqjEZT7drSQFhY2OqJYyeu/T87gSb5IlxWjC7MSNShDfcQMmBzdZUZMp70vgJv0Pey89K38ak
 8M4fA2ujjot3+CYm1o7GsrX229fRLO1VPR+FAU8z1wxEugj0QtZ2+fQVFzBculGCkptUf+/UvR6
 zj0LMDQhJtORASB1QM=
X-Received: by 2002:a05:6000:1acf:b0:44b:c220:f8ce with SMTP id
 ffacd0b85a97d-45e5c5b3c3cmr29458480f8f.6.1779182190445; 
 Tue, 19 May 2026 02:16:30 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17ec2sm41194617f8f.24.2026.05.19.02.16.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 02:16:30 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, John Olender <john.olender@gmail.com>,
 Liu Leo <Leo.Liu@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: Use placements of 256M GART segments for
 SI/CIK
Date: Tue, 19 May 2026 11:16:29 +0200
Message-ID: <3693368.dWV9SEqChM@timur-hyperion>
In-Reply-To: <97a4608b-133b-4c87-ab61-ea45c638693d@amd.com>
References: <20260519082204.60811-1-timur.kristof@gmail.com>
 <2219923.9o76ZdvQCi@timur-hyperion>
 <97a4608b-133b-4c87-ab61-ea45c638693d@amd.com>
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

On Tuesday, May 19, 2026 11:01:48=E2=80=AFAM Central European Summer Time C=
hristian=20
K=C3=B6nig wrote:
> On 5/19/26 10:59, Timur Krist=C3=B3f wrote:
> > On Tuesday, May 19, 2026 10:54:10=E2=80=AFAM Central European Summer Ti=
me
> > Christian
> >=20
> > K=C3=B6nig wrote:
> >> On 5/19/26 10:22, Timur Krist=C3=B3f wrote:
> >>> UVD 4.x and older require that BOs don't cross 256M segments.
> >>> We need to respect that in amdgpu_ttm_alloc_gart().
> >>> We can't move the BOs later because GTT->GTT moves are
> >>> not implemented. We also can't force all BOs to VRAM
> >>> because that becomes very problematic in low VRAM scenarios.
> >>>=20
> >>> This fixes UVD CS BOs crossing 256M segments
> >>> when they are placed in the GART.
> >>=20
> >> Clear NAK for that approach.
> >>=20
> >> This is the general TTM interface function and shouldn't have any HW
> >> generation dependent code in it.
> >=20
> > I don't see how else to solve this, since GTT->GTT moves are not
> > implemented, so we can't move the BO to a suitable address later. We al=
so
> > can't move it to VRAM.
>=20
> GTT to GTT moves should be relatively easy to implement.
>=20
> We just need to wait for the BO to be idle, unbind, move and bind again.

Implementing GTT->GTT moves sounds like a bigger task and cannot be backpor=
ted=20
as that would be a new feature not a bug fix. So I strongly prefer to solve=
=20
this problem with the tools we already have available.

Also, I would prefer to not have to move the BO at all and give it a suitab=
le=20
address from the beginning, to avoid the overhead of the move.

As far as I understand you take issue with checking adev->family in=20
amdgpu_ttm_alloc_gart(), right? So, how about one of these alternatives:

=2D add a bool argument so the caller can request 256M segments, then the c=
aller=20
can check the GPU generation
=2D add an optional argument so the caller can just pass in a placements ar=
ray

Or, if you have a different suggestion, let me know.

Thanks,
Timur

> >>=20
> >>> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4799
> >>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>> ---
> >>>=20
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 56 ++++++++++++++++++++++-=
=2D-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  3 ++
> >>>  2 files changed, 53 insertions(+), 6 deletions(-)
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c index
> >>> 6c6ab4dd6ea9..a106c7e77e26 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> @@ -959,6 +959,40 @@ static int amdgpu_ttm_backend_bind(struct
> >>> ttm_device
> >>> *bdev,>
> >>>=20
> >>>  	return 0;
> >>> =20
> >>>  }
> >>>=20
> >>> +/**
> >>> + * amdgpu_ttm_fill_gart_256M_placements() - Fill placements array wi=
th
> >>> 256M GART segments + *
> >>> + * @bo: TTM buffer objects whose placements should be filled
> >>> + * @placements: Pointer to an array of placements
> >>> + * @max_placements: Size of the placements array
> >>> + *
> >>> + * Fill the specified placements array with 256M GART segments,
> >>> + * starting from the highest address in order to reduce the
> >>> + * contention of the lowest segment.
> >>> + *
> >>> + * Returns the number of placements filled.
> >>> + */
> >>> +u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *b=
o,
> >>> +					 struct ttm_place
> >=20
> > *placements,
> >=20
> >>> +					 u32 max_placements)
> >>> +{
> >>> +	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->bdev);
> >>> +	u32 i;
> >>> +
> >>> +	/* Fill the placements array with 256M segments, starting from
> >=20
> > highest.
> >=20
> >>> */ +	for (i =3D 0; i < max_placements; ++i) {
> >>> +		if (i * SZ_256M >=3D adev->gmc.gart_size)
> >>> +			break;
> >>> +
> >>> +		placements[i].lpfn =3D (adev->gmc.gart_size - i *
> >=20
> > SZ_256M) >> PAGE_SHIFT;
> >=20
> >>> +		placements[i].fpfn =3D ALIGN_DOWN(placements[i].lpfn - 1,
> >=20
> > SZ_256M >>
> >=20
> >>> PAGE_SHIFT); +		placements[i].mem_type =3D TTM_PL_TT;
> >>> +		placements[i].flags =3D bo->resource->placement;
> >>> +	}
> >>> +
> >>> +	return i;
> >>> +}
> >>> +
> >>>=20
> >>>  /*
> >>> =20
> >>>   * amdgpu_ttm_alloc_gart - Make sure buffer object is accessible eit=
her
> >>>   * through AGP or GART aperture.
> >>>=20
> >>> @@ -973,7 +1007,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_obje=
ct
> >>> *bo)>
> >>>=20
> >>>  	struct ttm_operation_ctx ctx =3D { false, false };
> >>>  	struct amdgpu_ttm_tt *gtt =3D ttm_to_amdgpu_ttm_tt(bo->ttm);
> >>>  	struct ttm_placement placement;
> >>>=20
> >>> -	struct ttm_place placements;
> >>> +	struct ttm_place placements[AMDGPU_BO_MAX_PLACEMENTS];
> >>>=20
> >>>  	struct ttm_resource *tmp;
> >>>  	uint64_t addr, flags;
> >>>  	int r;
> >>>=20
> >>> @@ -987,11 +1021,21 @@ int amdgpu_ttm_alloc_gart(struct
> >>> ttm_buffer_object
> >>> *bo)>
> >>>=20
> >>>  	/* allocate GART space */
> >>>  	placement.num_placement =3D 1;
> >>>=20
> >>> -	placement.placement =3D &placements;
> >>> -	placements.fpfn =3D 0;
> >>> -	placements.lpfn =3D adev->gmc.gart_size >> PAGE_SHIFT;
> >>> -	placements.mem_type =3D TTM_PL_TT;
> >>> -	placements.flags =3D bo->resource->placement;
> >>> +	placement.placement =3D &placements[0];
> >>> +	placements[0].fpfn =3D 0;
> >>> +	placements[0].lpfn =3D adev->gmc.gart_size >> PAGE_SHIFT;
> >>> +	placements[0].mem_type =3D TTM_PL_TT;
> >>> +	placements[0].flags =3D bo->resource->placement;
> >>> +
> >>> +	/*
> >>> +	 * UVD 4.x and older require that BOs don't cross 256M segments.
> >>> +	 * We need to respect that here. We can't move the BO later
> >>> +	 * because GTT->GTT moves are not implemented.
> >>> +	 */
> >>> +	if (bo->base.size < SZ_256M && adev->family <=3D AMDGPU_FAMILY_KV)
> >>> +		placement.num_placement =3D
> >>> +			amdgpu_ttm_fill_gart_256M_placements(bo,
> >=20
> > placements,
> >=20
> >>> +
> >=20
> > ARRAY_SIZE(placements));
> >=20
> >>>  	r =3D ttm_bo_mem_space(bo, &placement, &tmp, &ctx);
> >>>  	if (unlikely(r))
> >>>=20
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h index
> >>> 2d72fa217274..e9de628c8d2d 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> >>> @@ -202,6 +202,9 @@ int amdgpu_ttm_clear_buffer(struct
> >>> amdgpu_ttm_buffer_entity *entity,>
> >>>=20
> >>>  			    u64 k_job_id);
> >>> =20
> >>>  struct amdgpu_ttm_buffer_entity *amdgpu_ttm_next_clear_entity(struct
> >>>  amdgpu_device *adev);>
> >>>=20
> >>> +u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *b=
o,
> >>> +					 struct ttm_place
> >=20
> > *placements,
> >=20
> >>> +					 u32 max_placements);
> >>>=20
> >>>  int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> >>>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
> >>>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t
> >>>  type);




