Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204A5C197A0
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Nov 2023 14:26:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96EFC10E5F2;
	Thu, 16 Nov 2023 14:26:07 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E930010E5F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 14:26:04 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1efad296d42so408324fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Nov 2023 06:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700144764; x=1700749564; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m2XL1t5L1ZGV3hvLpYAk5dP5hxBAEeFEX+jUIrFxKLA=;
 b=RwRHWldNqCJ2cgKPZI4WgZavarDjSRb8gRKpPeh1cfS2wQXWBCHjx4FZ1SgTjta6qf
 yrLPYo9TzsEU22OSHLPd+OZo+EIISqgseYHPfqBxa64r8A8sW0GDgGUQcrSyw576Igq8
 xIR3bOtcAUsTa6NdtlWrwOUWcFZ26zTBONhKTl3mNIKvDLs+lSJukz8eOwhmYrvvzagB
 gQi2czqjDmyRmd9tQaqnhiyY/x99qy3bKbKFrZSnUwE7UflCmZTwt8cCJDFZC8tGX6hS
 0pCWkcEscvwH2ukBZ0DKtNsUt4ky40iC+CFm1ZCduVxKpKWe7DdCkjLHnPkVxV0rRbJ6
 i4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700144764; x=1700749564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m2XL1t5L1ZGV3hvLpYAk5dP5hxBAEeFEX+jUIrFxKLA=;
 b=ODVSTSqjjhDA6cE1fpnpo95S+iTv9FcXWz39QkJ96R+513z/BK2LLGj/LTjpPM73z1
 gF3wSREIh2tkhcnCfJZFB/QWTqVwP/V/X86MVLm5wkkFFNYccvgHdDYifpF4E5uf5l+N
 s8Ev2e8Q4grfCD3WG7E5KQyQzgFrAFA7rNC+7QYWDlQVjY3sI2tARHH8FsqGE0QOXfKQ
 NMe9fKmxVykjDTpHT04mHjmD9JLtPMCPHkSkKGc8HSriM3TtOojKwNsiogKpdQKxH4sZ
 TYXTuMnfkU5YqWfTBaIYUx81bkbcQ9qxXeow6iJ1SOpjMqZZRcnQ7WrEjTTYk3luyCc2
 eIXQ==
X-Gm-Message-State: AOJu0YzcZSxlCRltEzzk/OJ9vUvoqx4MGfYtKgIDb2qy+EhLYpivSoAi
 tQr5QvpLZ8sATJOi8O753/3KIe9pSh3RS5VEA2LRByUg
X-Google-Smtp-Source: AGHT+IFvXX+VkE1Cn5D3Lj4x+3HUz8boflMvzZMbmEXhWP8ZWGe1HXrrCnfxYKqLvjpy2PuU9bw4u8A3JImMH2dypWk=
X-Received: by 2002:a05:6870:a915:b0:1ea:7bd1:c495 with SMTP id
 eq21-20020a056870a91500b001ea7bd1c495mr19814908oab.27.1700144763971; Thu, 16
 Nov 2023 06:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20231110144701.1895397-1-alexander.deucher@amd.com>
 <59668638-00ce-4407-a0c1-47200480fe8f@amd.com>
 <CADnq5_O49zWhVhCopXFTC+9ijepy4iuV6vMbogP6+O8GWrZZOw@mail.gmail.com>
 <CY5PR12MB6369A027501FDC20699E31C7C1B0A@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB6369A027501FDC20699E31C7C1B0A@CY5PR12MB6369.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Nov 2023 09:25:52 -0500
Message-ID: <CADnq5_OpzAunvWdKqXp=kt3tVnVLH=i91feLEAq-T6KpRx_hgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Nov 16, 2023 at 4:37=E2=80=AFAM Zhang, Yifan <Yifan1.Zhang@amd.com>=
 wrote:
>
> [AMD Official Use Only - General]
>
> Ping... this patch seems still not merged.
>

Can you confirm it fixes the AGP issues you saw?

Alex

> Best Regards,
> Yifan
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Monday, November 13, 2023 2:13 AM
> To: Koenig, Christian <Christian.Koenig@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedes=
ktop.org; Zhang, Yifan <Yifan1.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zha=
ng@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix AGP addressing when GART is not at 0
>
> On Sat, Nov 11, 2023 at 2:17=E2=80=AFAM Christian K=C3=B6nig <christian.k=
oenig@amd.com> wrote:
> >
> > Am 10.11.23 um 15:47 schrieb Alex Deucher:
> > > This worked by luck if the GART aperture ended up at 0.  When we
> > > ended up moving GART on some chips, the GART aperture ended up
> > > offsetting the the AGP address since the resource->start is a GART
> > > offset, not an MC address.  Fix this by moving the AGP address setup
> > > into amdgpu_bo_gpu_offset_no_check().
> > >
> > > Reported-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > > Reported-by: Yifan Zhang <yifan1.zhang@amd.com>
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: christian.koenig@amd.com
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++++---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  4 +---
> > >   2 files changed, 8 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > index cef920a93924..1b3e97522838 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > @@ -1527,10 +1527,14 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo=
)
> > >   u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
> > >   {
> > >       struct amdgpu_device *adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> > > -     uint64_t offset;
> > > +     uint64_t offset, addr;
> > >
> > > -     offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
> > > -              amdgpu_ttm_domain_start(adev, bo->tbo.resource->mem_ty=
pe);
> > > +     addr =3D amdgpu_gmc_agp_addr(&bo->tbo);
> >
> > IIRC you must check bo->tbo.resource->mem_type before calling
> > amdgpu_gmc_agp_addr().
>
> Yes, this was fixed in v2.
>
> Alex
>
> >
> > Regards,
> > Christian.
> >
> > > +     if (addr !=3D AMDGPU_BO_INVALID_OFFSET)
> > > +             offset =3D addr;
> > > +     else
> > > +             offset =3D (bo->tbo.resource->start << PAGE_SHIFT) +
> > > +                     amdgpu_ttm_domain_start(adev,
> > > + bo->tbo.resource->mem_type);
> > >
> > >       return amdgpu_gmc_sign_extend(offset);
> > >   }
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > > index 05991c5c8ddb..ab4a762aed5b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > > @@ -959,10 +959,8 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_obje=
ct *bo)
> > >               return 0;
> > >
> > >       addr =3D amdgpu_gmc_agp_addr(bo);
> > > -     if (addr !=3D AMDGPU_BO_INVALID_OFFSET) {
> > > -             bo->resource->start =3D addr >> PAGE_SHIFT;
> > > +     if (addr !=3D AMDGPU_BO_INVALID_OFFSET)
> > >               return 0;
> > > -     }
> > >
> > >       /* allocate GART space */
> > >       placement.num_placement =3D 1;
> >
