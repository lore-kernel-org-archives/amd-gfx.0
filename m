Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871EDCD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 10:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 269A410E161;
	Tue, 26 May 2026 10:13:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JCLMpYnd";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D4910E161
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 10:13:09 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-44a14580111so7761515f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779790387; x=1780395187; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TfD/HQKh7ugMin9B+T9Zo+pvi7ikWmHtkMHo512ohpo=;
 b=JCLMpYnd+GP80MiwtmsIUv61E701putQKPlxDJkS+F82LgxYs67Oly2JoTgjDHdwea
 5YnVsz19CEO21Dq7DNpAdF3Zp0z3kMKDfykJsM8rF3zZwJxGq0cA5d+6mi1kqZd4/nbp
 EzZtlfKyjTOkpXusQGqlPCVmGUM4Jk805zqxcvWOwAdZGWpPY3WeupHdnjhpksy31lEA
 zzOy3SMUwLYgVceyUcWWVwk8pf0BFKyPBFnfwKeSy+P+ip4UpvuuSQID7kaEASTxejHg
 e8geaU9SFtmSOeT2I8ZH1RJE8WLP+MJEId6YYNHNT4g82+S13ANRZVH53fCUOhb8AIEZ
 B9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779790387; x=1780395187;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TfD/HQKh7ugMin9B+T9Zo+pvi7ikWmHtkMHo512ohpo=;
 b=Em4UsAKgess/zT2VMOAAp6HpiAII1dAb6SmP9dtBsbs97beSrZ54o7urr9in97U16d
 cchpQm77uPSDRKAs//dw52KuaSsdLVhonFufkUj9gCoq0DBgL8TKW5z42TgGJnmYbHwc
 /S7mfaKb2NWGPA5bxFQ3ATz5BievQWs8wvtEVIp6NRfEm8XkfahZSW9W3AIUd3m0+eZE
 LBTt/t8J2/9Yt3GSlVNt4cNTyk2t/srPCmWx7NLm08YrhJ2+i4pQG4y5J3G4o+yRe7Di
 FShwDecrnQJc+qqY8Mm1TJ1Musg5KIedRQV7DQCb+7fbBfrYWBg/vx1O0MXfuoOJePal
 vVGA==
X-Gm-Message-State: AOJu0YzD4qAWGvljETlqPVMrfZMawNRu6MeFoWjue3kgOBt62Nir7kaR
 o/kBDaBv26SWHBUOXDRs+1e/JvUTSkc0pvSNYIDLkw3YNzFay8yoVHriGyRtwFKG
X-Gm-Gg: Acq92OGbnw+jH2g5BIjYa36XlaHxeZ/HfE55l69BYY34puSgzUxxXyb4XyuK9RPbW8f
 73/ytw2MHn20I32cE8bN8ztr2Iqg9XUBDKxHJENVU2zu+/JWmQPeKLr6ATHaJl9HaKYYBjNSvTr
 I0Tp2I9AFKXu1xj4CwORIuEj4luRqGKAP5dP5WlZgu5I5FyvoKQ0uJHvYr7VDsRL0MwUwN6/a9b
 31dQWQqrFo4D2qpsSdROf3fq2w+mRGofC0QghJuLLuxjXx03Y8Z5Ke9l5oG6Vjfg9AeZWgzJZF/
 jhOwG6bOBdfr49TYtWCQDhltvEvsjHRXFwX5UpfPYSINzq6QyKUo+nYqY+9TTqIY2QwD1yo4go8
 fhW7gaxYtxc7LM2IeOvgyqtKwHRx0nu+5wREFJ+tWX7C9DL0PUJb+wmIYp3PaZMm1jtm8QKBarg
 1g95vLHsN7ilVS2FYPUJR/0Gfilx35CW7kaq396YyfJ8undFe9ba7V7+bGh7QQYYyTB36dydfb0
 cRN0wVU0BP7Fp02YWt3Cp+dArbpdw==
X-Received: by 2002:a05:6000:400c:b0:45e:651c:47bb with SMTP id
 ffacd0b85a97d-45eb38af64bmr29953708f8f.28.1779790387153; 
 Tue, 26 May 2026 03:13:07 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cce01asm35371174f8f.11.2026.05.26.03.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 03:13:06 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 4/4] drm/amdgpu/uvd: Fix forcing MSG,
 FB BOs into VCPU segment when it isn't at 0 (v2)
Date: Tue, 26 May 2026 12:13:05 +0200
Message-ID: <2641264.XAFRqVoOGU@timur-max>
In-Reply-To: <eed791bd-ef86-4d0a-baf4-f779ed70326a@amd.com>
References: <20260525113321.17953-1-timur.kristof@gmail.com>
 <20260525113321.17953-5-timur.kristof@gmail.com>
 <eed791bd-ef86-4d0a-baf4-f779ed70326a@amd.com>
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

On 2026. m=C3=A1jus 26., kedd 10:10:33 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 5/25/26 13:33, Timur Krist=C3=B3f wrote:
> > UVD 4.x and older can only access MSG, FEEDBACK buffers from a
> > specific 256M VRAM segment that the VCPU BO is also located in.
> > We already modify all placements of the given BO to ensure
> > the BO is placed within this segment.
> >=20
> > Previously, it always assumed that the VCPU segment is
> > the first 256M of VRAM, even though under some conditions
> > the VCPU BO could be allocated outside this segment,
> > which made UVD non-functional as the BOs were
> > not inside the same segment as the UVD VCPU BO.
> >=20
> > Solve that by using the segment where the VCPU BO actually is.
> >=20
> > This fixes an issue with UVD failing to initialize on SI/CIK
> > when resizable BAR is enabled and the VCPU BO is allocated
> > in a different segment.
> >=20
> > v2:
> > - For other BOs, keep using the same UVD segment as before.
> >=20
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3851
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 33 ++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c index
> > 1e59ca924abe..480bf88def46 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> > @@ -135,7 +135,7 @@ MODULE_FIRMWARE(FIRMWARE_VEGA12);
> >=20
> >  MODULE_FIRMWARE(FIRMWARE_VEGA20);
> > =20
> >  static void amdgpu_uvd_idle_work_handler(struct work_struct *work);
> >=20
> > -static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo);
> > +static void amdgpu_uvd_force_into_vcpu_segment(struct amdgpu_bo *abo);
> >=20
> >  static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
> > =20
> >  					   uint32_t size,
> >=20
> > @@ -158,7 +158,7 @@ static int amdgpu_uvd_create_msg_bo_helper(struct
> > amdgpu_device *adev,>=20
> >  	amdgpu_bo_kunmap(bo);
> >  	amdgpu_bo_unpin(bo);
> >  	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
> >=20
> > -	amdgpu_uvd_force_into_uvd_segment(bo);
> > +	amdgpu_uvd_force_into_vcpu_segment(bo);
> >=20
> >  	r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> >  	if (r)
> >  =09
> >  		goto err;
> >=20
> > @@ -550,6 +550,24 @@ void amdgpu_uvd_free_handles(struct amdgpu_device
> > *adev, struct drm_file *filp)>=20
> >  	}
> > =20
> >  }
> >=20
> > +static void amdgpu_uvd_force_into_vcpu_segment(struct amdgpu_bo *bo)
> > +{
> > +	struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> > +	struct amdgpu_bo *vcpu_bo =3D adev->uvd.inst[0].vcpu_bo;
> > +	struct amdgpu_res_cursor vcpu_cur;
> > +
> > +	amdgpu_res_first(vcpu_bo->tbo.resource, 0,
> > +			 amdgpu_bo_size(vcpu_bo), &vcpu_cur);
> > +
> > +	bo->placement.num_placement =3D 1;
> > +	bo->placement.placement =3D &bo->placements[0];
> > +	bo->placements[0].fpfn =3D ALIGN_DOWN(vcpu_cur.start, SZ_256M) >>
> > PAGE_SHIFT; +	bo->placements[0].lpfn =3D bo->placements[0].fpfn +=20
(SZ_256M
> > >> PAGE_SHIFT); +	bo->placements[0].mem_type =3D
> > vcpu_bo->tbo.resource->mem_type;
> > +	if (bo->placements[0].mem_type =3D=3D TTM_PL_VRAM)
> > +		bo->placements[0].flags |=3D TTM_PL_FLAG_CONTIGUOUS;
>=20
> You need to call ttm_bo_validate() here.

Can you say why?
ttm_bo_validate() is already called by both callers of this function.




