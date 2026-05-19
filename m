Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026EACD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 09:32:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8511E10E09C;
	Tue, 19 May 2026 09:32:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UKBI+UlP";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64CB110E09C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 09:32:21 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-44e1ebb3122so1911212f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 02:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779183140; x=1779787940; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GpKKBrZgijRaI1G0+Ggcn1gd9SIJS1QoV8ix8hoGioU=;
 b=UKBI+UlP5DVgZ7j/V42hDZHcoLYaoPlJhbJCmf+s/1VL+Ha2Fy2H8yJFqSHhMrXpPY
 S6+wZ7cGOrn2QMhEEpmFOLoMI4t0Wm0QG78FDlvwVZV1bx8OoXgkanr+jmJ9GKpU51+/
 Tngz3wOKdZBYC1A7OGMXcJ7B3su0xOTR93CS73EHlweUhjukxS8jZb2KrpOyVaJAEJUX
 9cSY7z6SGR+OuXtPY1CTOJF+261qySYRV6ktjhnCQ8MC/0cJLm+uClh+tS2vmgwOYAyV
 y/3wPubpwfsQEZOf1dSoweSjaENYB0YGuWDcnWtQMflL3GiB+W4VkhU/COcHAqFUDggU
 c8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779183140; x=1779787940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GpKKBrZgijRaI1G0+Ggcn1gd9SIJS1QoV8ix8hoGioU=;
 b=GrKlHIybAkk2FfaB+RgPLcBOba00O/S2R9sH4HHnocVurXSBXnIMgeiDZ1Noc8ecXa
 3XXKbPsuxK57UUm/CX6lVC+o+CMGba0/pNMA2+rIP3PaqCsWVjslenRdL1+SzxB5F4ht
 ku2jAZIGYcW+FY3CLfcnGeHT9FH1dt2YKlOTfBgt1iZTj3qgpWHwFQIpTYJGpK/MK7p3
 g0wca36M89DW6uPbVPpTJVA1YLYu05q4HttkBj+iJsx9EsBx3Czhcf6Bo+bSRWhymGAI
 2F0x8bv/XdyF3efTr+SI4bZiut/ruBldM9AQhLX6733+/tdNCFiC2LD8foPaBlNJ15bS
 eHxA==
X-Gm-Message-State: AOJu0YyezIyyoA7b1Srwi6grsFc3BP3QJAsKg0qgxX0f6YcLnuM+K5Yb
 fIlLGTzRlM4qu6YljAGLdwp+nEgpSgsH20v3CAPCF5yEfILE9N5hOyXc2rLEvA==
X-Gm-Gg: Acq92OFPBoR8LJdRKhr7Wf2HOttkjP4MeABmaTA+gBUS9McL8R/9im7YK0nDzcq2z2k
 EyNGYJ2T8OLWGHsZL0qhDUVGJgqATfC8Q3Wmh0I+17K0b84iprQSHgvodsxSF1tpeL+tgiKix6q
 +IVYTb9rzhLoFtusRz4R32YwM5/IGvzGbNBLPQGiy5VEvMmgBoI4O5ZciePVOJV/pc61l5h8Hw5
 OpPciHLh3efMLOUuh43nhE/4dKKvFGDVfK2HVGWZf1PBZdbvYhm+6pOk96KhvEMsb4IQ/qFYQbf
 CzVB8B75xqyAK5riTf9kXdNKE6YMWoLt8QZg1bO0QcSrcyPZA7PZlZWRpuBhkGX8ammKm5pd0qB
 NIKuCqoOhY4M8Gs7WqcjjxqbkK9SuM6uiOmpjJD/KNNhgXegEn9zEmiR4FT95cc22da+bydlyfJ
 XLOgC1LdrZmBQx4pkZN0/gcZ0FdsHvNFGRO+1CZXJED/drLjhaL7eF2Q9QZxGIaJ6wXU/DUw==
X-Received: by 2002:a05:6000:1ace:b0:441:1cf9:4f06 with SMTP id
 ffacd0b85a97d-45e5c595648mr29485018f8f.31.1779183139717; 
 Tue, 19 May 2026 02:32:19 -0700 (PDT)
Received: from timur-hyperion.localnet (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767d0bsm42391719f8f.3.2026.05.19.02.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 02:32:19 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, John Olender <john.olender@gmail.com>,
 Liu Leo <Leo.Liu@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 4/5] drm/amdgpu/uvd: Fix forcing BOs into UVD segment when
 it isn't at 0
Date: Tue, 19 May 2026 11:32:18 +0200
Message-ID: <2008843.7Z3S40VBb9@timur-hyperion>
In-Reply-To: <be651c7b-a9f0-4cbd-bf0a-30b2499b2ef1@amd.com>
References: <20260519082204.60811-1-timur.kristof@gmail.com>
 <20260519082204.60811-5-timur.kristof@gmail.com>
 <be651c7b-a9f0-4cbd-bf0a-30b2499b2ef1@amd.com>
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

On Tuesday, May 19, 2026 11:06:51=E2=80=AFAM Central European Summer Time C=
hristian=20
K=C3=B6nig wrote:
> On 5/19/26 10:22, Timur Krist=C3=B3f wrote:
> > UVD 4.x and older can only access FB and MSG buffers from a
> > specific 256M VRAM segment that the VCPU BO is also located in.
> > We already modify all placements of the given BO to ensure
> > the BO is placed within this segment.
> >=20
> > Previously, amdgpu_uvd_force_into_uvd_segment() always assumed
> > that the UVD segment is the first 256M of VRAM, even though
> > under some conditions the VCPU BO could be allocated outside
> > this segment, which made UVD non-functional as the BOs were
> > not inside the same segment as the UVD VCPU BO.
> >=20
> > Solve that by using the segment where the VCPU BO actually is.
> >=20
> > This fixes an issue with UVD failing to initialize on SI/CIK
> > when resizable BAR is enabled and the VCPU BO is allocated
> > in a different segment.
> >=20
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3851
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 36 +++++++++++++++----------
> >  1 file changed, 22 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c index
> > 1e59ca924abe..993957927782 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > @@ -550,16 +550,29 @@ void amdgpu_uvd_free_handles(struct amdgpu_device
> > *adev, struct drm_file *filp)>=20
> >  	}
> > =20
> >  }
> >=20
> > +/**
> > + * amdgpu_uvd_force_into_uvd_segment() - Forces placement of a BO into
> > the UVD segment + *
> > + * @abo: buffer object whose placement is forced
> > + *
> > + * UVD 4.x and older can only access FB and MSG buffers from a specific
> > 256M VRAM segment + * that the VCPU BO is also located in. Force the BO
> > into that segment. + */
> >=20
> >  static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo)
> >  {
> >=20
> > -	int i;
> > +	struct amdgpu_device *adev =3D amdgpu_ttm_adev(abo->tbo.bdev);
> > +	struct amdgpu_bo *vcpu_bo =3D adev->uvd.inst[0].vcpu_bo;
> > +	struct amdgpu_res_cursor vcpu_cur;
> >=20
> > -	for (i =3D 0; i < abo->placement.num_placement; ++i) {
> > -		abo->placements[i].fpfn =3D 0 >> PAGE_SHIFT;
> > -		abo->placements[i].lpfn =3D (256 * 1024 * 1024) >>=20
PAGE_SHIFT;
> > -		if (abo->placements[i].mem_type =3D=3D TTM_PL_VRAM)
> > -			abo->placements[i].flags |=3D=20
TTM_PL_FLAG_CONTIGUOUS;
> > -	}
> > +	amdgpu_res_first(vcpu_bo->tbo.resource, 0, amdgpu_bo_size(vcpu_bo),
> > &vcpu_cur); +
> > +	abo->placement.num_placement =3D 1;
> > +	abo->placements[0].fpfn =3D ALIGN_DOWN(vcpu_cur.start, SZ_256M) >>
> > PAGE_SHIFT; +	abo->placements[0].lpfn =3D abo->placements[0].fpfn +
> > (SZ_256M >> PAGE_SHIFT); +	abo->placements[0].mem_type =3D
> > adev->uvd.inst[0].vcpu_bo->tbo.resource->mem_type;
> This should clearly be applied to all placements, it's just that VRAM sho=
uld
> use the vcpu segment and GTT the first one.

Previously, the function was trying to do two things at once:

=2D Forcing some BOs into the UVD segment, as the name of the function sugg=
ests,=20
but it was buggy because it assumed the UVD segment is always segment 0
=2D Forcing GTT placements for other BOs, which is not what its name sugges=
ts,=20
and was actually wrong and not working.

With this patch, the function is now only responsible for forcing MSG/FB BO=
s=20
into the UVD segment, and is no longer responsible for doing anything with =
the=20
other BOs, which was incorrect anyway.

This is also beneficial because it reduces contention for the UVD segment f=
or=20
the BOs that don't actually need to be located in that segment.

=46or non-MSG/FB BOs, this function should no longer be called.
When those BOs are located in GTT, patch 2 should already make sure they ar=
e=20
placed correctly. When they are in VRAM, patch 5 will make sure to correct=
=20
their placement if it was wrong.

> > +
> > +	if (abo->placements[0].mem_type =3D=3D TTM_PL_VRAM)
> > +		abo->placements[0].flags |=3D TTM_PL_FLAG_CONTIGUOUS;
> >=20
> >  }
> > =20
> >  static u64 amdgpu_uvd_get_addr_from_ctx(struct amdgpu_uvd_cs_ctx *ctx)
> >=20
> > @@ -600,13 +613,8 @@ static int amdgpu_uvd_cs_pass1(struct
> > amdgpu_uvd_cs_ctx *ctx)>=20
> >  	if (!ctx->parser->adev->uvd.address_64_bit) {
> >  =09
> >  		/* check if it's a message or feedback command */
> >  		cmd =3D amdgpu_ib_get_value(ctx->ib, ctx->idx) >> 1;
> >=20
> > -		if (cmd =3D=3D 0x0 || cmd =3D=3D 0x3) {
> > -			/* yes, force it into VRAM */
> > -			uint32_t domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> > -
> > -			amdgpu_bo_placement_from_domain(bo, domain);
> > -		}
> > -		amdgpu_uvd_force_into_uvd_segment(bo);
> > +		if (cmd =3D=3D 0x0 || cmd =3D=3D 0x3)
> > +			amdgpu_uvd_force_into_uvd_segment(bo);
>=20
> The existing code was already correct. We just messed up the GTT handling=
 by
> not having the correct check in the manager and not supporting GTT->GTT
> moves.

See above for an explanation of why I changed this part.

>=20
> Regards,
> Christian.
>=20
> >  		r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &tctx);
> >  =09
> >  	}




