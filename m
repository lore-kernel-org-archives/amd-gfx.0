Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F38A6CCF9EB
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Oct 2025 10:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C74610E79C;
	Wed, 29 Oct 2025 10:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aAlrLEL5";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC63110E79C
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 10:57:50 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-63bea08a326so10048427a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Oct 2025 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761735469; x=1762340269; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HH4ti5eeWsBzfdJ79a32dZ699UZUt6f8OYBzcd5lZBg=;
 b=aAlrLEL59v/rPFQoIKuByCFp47g3viHPUMeWm5lBQriVfd7luz+vqXHVObUZh2T9BA
 csWE5UWjgHb2UTQWWTXxqO9Rc3IOtFE7X7veZkwMp1hg8a0zPAiMRsSZVIVMf1xm/oPG
 P9pAq1R0LYG/YEYQB7TwK1RSm31RUVjFqrgI/WViIvdg3Km4jHv2mXRUTJD3W38fMgEr
 P2cjnBhpJTHl9CqLjk4w6LAJuK9/UxFaq9u/fPGc99Im/98QW//y88GQxD8njNPxi4GV
 4HvqwmJCSgwVjY9YJIMMm5fMFDs/R2Ad3+gQJV2eJ/N+MFnE+wE+3jN96LR1+NbuvnUl
 pLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761735469; x=1762340269;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HH4ti5eeWsBzfdJ79a32dZ699UZUt6f8OYBzcd5lZBg=;
 b=SO8DAzz2ml2Ulp/Jan921xGNBYVT+q+r1wWa362Hmr83h4RtNYcdkb709qwmq3zBtP
 G5Is68SjVqMK4Jt2/enne1s3zvWmD+D/ARisYHeBJejydyJIXXcb5VKrLuTfJ4PUWgSK
 qkDa7Diix1KVWnOQ+4w+ZDRfV9iY4LLrl7Ssow17F8IgSdSVo0enu2cCtK6IbPNjflMJ
 kWt5tnu8YtgtgGTFyhh2MBOQad1DBXVpVVvBAWjMAaLWPwwox03qcXFBP5r0ZG5MBKI2
 KlwdZWWjzSRidyk1tXqHQNQs6yEDYvCrngocQuWm8fuW+YY57aI1ySfqH7xZfJQG1o1/
 M/rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMcnoeIYrzXdqif+IeUdaf3YLt1DV5rDERw3CR5dAHA7sVcP0EkLpUiE8lmE47m26WVefs8Hev@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYMPT3KDGjbpQsyHreyoBoFP9RAY3aeYzm5JHqCLDrbX9xLDhQ
 yZWIUyCHVwS/L4fsUFVcUkSMny9cLPHgsp5gCug51D51dckH8Lrn01ad
X-Gm-Gg: ASbGncv0BEl589Prszs2vD9znO027T7DYzhdTrmqSSLVFnj1Sf63d0NlURu4lc/ZEW0
 T7iiv661G/Hd7ZzhAAEiZKT/p1jQYa6C0Sd1d2wPmH1HLtAbAFZ0vwHuvX5zCnBaeODFXvgyifk
 DbXceH/0h9c5AlkZsgC36ElThX5RjQU/T80aRVbXnLgjZCXcHGyMh3dJ0DEOkFBYXWfv+TWLF/A
 enbbAXOxiRO1qTxu0y3IH/STQE3Im/u2sea8BXln7mqIn7fUBLbaOPt03GyqAdRZymNS6JKwc5K
 kWM6ZSN7OieKSntfgH/x+nfV9MW7e5EgFzXPYRJKUKXpECpHwA4pR4fpED8gXo5J57ll62+27Tu
 S3TAPN1af6wycLuHNDFS2gzeiRrxsothb03zKb1RQBvgJguMMkWhyMyXajC/ulOqJrwz0SBMUPM
 PPpQb6bUt1YqaP4CVMmSx1Wnsq0hvHUxNqoJmYGCDUra6/rMmz8WOGKAD3YhS/QTiqlWsxBedSv
 0ZW2BWr+Ph3urJ9MLbrS4S4VogRYuSbccIfHTZqWnOE
X-Google-Smtp-Source: AGHT+IGN6lhUbsHRSXTQNvDtMo8NNwBKmCQMkItPk7Sca7K8lZH7D+Mt9/f/1VnaU2v1QldJeBWvqw==
X-Received: by 2002:a05:6402:40c3:b0:63c:359e:f431 with SMTP id
 4fb4d7f45d1cf-6404424a6e2mr1909766a12.22.1761735468874; 
 Wed, 29 Oct 2025 03:57:48 -0700 (PDT)
Received: from ?IPv6:2001:4c4e:24cb:f700:23e8:3719:bda9:8268?
 (20014C4E24CBF70023E83719BDA98268.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:23e8:3719:bda9:8268])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef95e81sm11518935a12.21.2025.10.29.03.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Oct 2025 03:57:48 -0700 (PDT)
Message-ID: <15262eb50762bf09a6b85ed4d955f29ef98e8722.camel@gmail.com>
Subject: Re: [PATCH 04/14] drm/amdgpu/gart: Add helper to bind VRAM BO
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Alexandre Demers <alexandre.f.demers@gmail.com>, Rodrigo Siqueira
 <siqueira@igalia.com>
Date: Wed, 29 Oct 2025 11:57:47 +0100
In-Reply-To: <4685c497-7e29-4245-9960-db572bdb83f9@amd.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
 <20251028220628.8371-5-timur.kristof@gmail.com>
 <4685c497-7e29-4245-9960-db572bdb83f9@amd.com>
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

On Wed, 2025-10-29 at 11:16 +0100, Christian K=C3=B6nig wrote:
>=20
>=20
> On 10/28/25 23:06, Timur Krist=C3=B3f wrote:
> > Binds a BO that is allocated in VRAM to the GART page table.
> >=20
> > Useful when a kernel BO is located in VRAM but
> > needs to be accessed from the GART address space,
> > for example to give a kernel BO a 32-bit address
> > when GART is placed in LOW address space.
> >=20
> > Co-developed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 41
> > ++++++++++++++++++++++++
> > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h |=C2=A0 2 ++
> > =C2=A02 files changed, 43 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > index 83f3b94ed975..19b5e72a6a26 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> > @@ -390,6 +390,47 @@ void amdgpu_gart_bind(struct amdgpu_device
> > *adev, uint64_t offset,
> > =C2=A0	amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
> > adev->gart.ptr);
> > =C2=A0}
> > =C2=A0
> > +/**
> > + * amdgpu_gart_bind - bind VRAM BO into the GART page table
>=20
> That should be the function name or otherwise you get automated
> warnings.

That's a copy paste mistake on my part. Thanks for catching that.

>=20
> > + *
> > + * @adev: amdgpu_device pointer
> > + * @offset: offset into the GPU's gart aperture
> > + * @bo: the BO whose pages should be mapped
> > + * @flags: page table entry flags
> > + *
> > + * Binds a BO that is allocated in VRAM to the GART page table
> > + * (all ASICs).
> > + * Useful when a kernel BO is located in VRAM but
> > + * needs to be accessed from the GART address space,
> > + * for example to give a kernel BO a 32-bit address
> > + * when GART is placed in LOW address space.
> > + */
> > +void amdgpu_gart_bind_vram_bo(struct amdgpu_device *adev, uint64_t
> > offset,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_bo *bo, uint64_t flags)
>=20
> Please not the BO but just the VRAM pa.

Sure, will do

>=20
> > +{
> > +	u64 pa, bo_size;
> > +	u32 num_pages, start_page, i, idx;
> > +
> > +	if (!adev->gart.ptr)
> > +		return;
> > +
> > +	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> > +		return;
> > +
> > +	pa =3D amdgpu_gmc_vram_pa(adev, bo);
> > +	bo_size =3D amdgpu_bo_size(bo);
> > +	num_pages =3D ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) /
> > AMDGPU_GPU_PAGE_SIZE;
> > +	start_page =3D offset / AMDGPU_GPU_PAGE_SIZE;
> > +
> > +	for (i =3D 0; i < num_pages; ++i) {
> > +		amdgpu_gmc_set_pte_pde(adev, adev->gart.ptr,
> > +			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE
> > * i, flags);
> > +	}
> > +
>=20
> Ideally amdgpu_gart_map() should be able to take both dma_addr array
> or VRAM pa (or have two map functions).
>=20
> This way we could cleanup the code in amdgpu_ttm_map_buffer as well.

Alright, I'll rework this new function so that it can be reused also by
amdgpu_ttm_map_buffer, does that sound alright to you?

>=20
>=20
> > +	amdgpu_gart_invalidate_tlb(adev);
>=20
> IIRC we moved that out of amdgpu_gart_bind(), probably best to do so
> here as well.

Sure, will do

>=20
> Regards,
> Christian.
>=20
> > +	drm_dev_exit(idx);
> > +}
> > +
> > =C2=A0/**
> > =C2=A0 * amdgpu_gart_invalidate_tlb - invalidate gart TLB
> > =C2=A0 *
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> > index 7cc980bf4725..756548d0b520 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
> > @@ -64,5 +64,7 @@ void amdgpu_gart_map(struct amdgpu_device *adev,
> > uint64_t offset,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 void *dst);
> > =C2=A0void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset=
,
> > =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int pages, dma_addr_t *dma_addr,=
 uint64_t
> > flags);
> > +void amdgpu_gart_bind_vram_bo(struct amdgpu_device *adev, uint64_t
> > offset,
> > +		=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_bo *bo, uint64_t flags);
> > =C2=A0void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
> > =C2=A0#endif
