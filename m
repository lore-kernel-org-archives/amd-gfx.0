Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A04C25B74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 22:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82D9410E88E;
	Tue, 21 May 2024 22:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xu8MZsel";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9207610E88E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 22:09:52 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-6f4ed9dc7beso221718b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716329392; x=1716934192; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c62rfTApA+UCl4sJcUFsL0233tKPYDoIYSIumL3oOZo=;
 b=Xu8MZselYbdsJSiceCPVz5WMh+2r3DUQw1AiIozfZaIdLJqviSgs15GlA/mmj/26wC
 Wd+zTNviolmZu8kf2s3b448NIYkINRh3ezdsuQOZmIxLR9LKflF5cHkSkK3RZ2OerBH6
 GTx46xx1ljJhIsMZvfastHXkh/1lLH4CI/jBxQZ2jugKFGi3MkZLriariZkq+90plcyx
 U76Ht13DY9MpGtmEDkDviXJidvq4HWx7sXTrTHZiWMeRPoFSUO0oE1SO5aBC1afAkTCb
 ejTHPNlkZ5k1MhMX8DM6OkPkMgv7r9DeKDyBDpqJ8WKkV2XogS2roFSb50R0OpYsLavp
 iRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716329392; x=1716934192;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c62rfTApA+UCl4sJcUFsL0233tKPYDoIYSIumL3oOZo=;
 b=OR2Jzpx5NCOP+FJGZAS6YAOpeg/wuftk5nrgsXZWhCXSx7druWNvr9ukJVq1LvLEmi
 G3yIylOMm1J/MFviMTKY2VkD+6t0PxSkWG1WaZy/hGRfyLIVYyPwlkjJiw/5P/1yJiIy
 c1qwuqLYqkI19MbTktQZHdFGWfBAd+hpin116ViHup0wRejEEN0h1fRQQMfzhiQ2SPsT
 4Ka6jgpr74e0p9O57AHUKPYbqI+UhkA7Psc5FXaxpwKpx0p6yVAfGX+kFTb+kzgyy1Q+
 xuAJG+2zaV7qoNprMq9hsgLM5jcolyAokibxyvh2K9TUYZGbShwi55SaKB1b3XCjiYra
 f4VA==
X-Gm-Message-State: AOJu0YyqY5O4Nr2Ifj8FPCZwftyzgsypQpwmSJd3pHAoNmK3otHe+ml1
 SxC+MYjP8MX31vlJoAgHGD/GTgkp7g9VzRTvY3kRReagDsUfgbFUfo/X1LTGIa3Dpdrbw1Wvao7
 PdcBnlCWluRrJxpU2lIa0KutLVQwCMw==
X-Google-Smtp-Source: AGHT+IGha4hEg0maX+e7ulIGuSlAObPxSo7Mq1P2WDJs+J49Sun8gYNb2m75pfJUIW5LoGTRVJoykXdRIlgexkxXf5M=
X-Received: by 2002:a05:6a00:21c3:b0:6ec:d3a6:801 with SMTP id
 d2e1a72fcca58-6f6d5716597mr380653b3a.11.1716329391862; Tue, 21 May 2024
 15:09:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240520091409.2435612-1-shane.xiao@amd.com>
 <DM4PR12MB5261F1F851D2DF6817A9D05F9DE92@DM4PR12MB5261.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5261F1F851D2DF6817A9D05F9DE92@DM4PR12MB5261.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 May 2024 18:09:39 -0400
Message-ID: <CADnq5_P_C3Mo9hx2MocRjGcKYVwX=if48T4HN97VbjNxS3pZtA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Update the impelmentation of
 AMDGPU_PTE_MTYPE_GFX12
To: "Xiao, Shane" <shane.xiao@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>, 
 "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>, "Liu,
 Aaron" <Aaron.Liu@amd.com>, "Yao, Longlong" <Longlong.Yao@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 20, 2024 at 5:37=E2=80=AFAM Xiao, Shane <shane.xiao@amd.com> wr=
ote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
>
> I have changed the macro AMDGPU_PTE_MTYPE_GFX12 to clear mtype bit before=
 setting.
> Add one parameter for this macro, and some related code needs to be chang=
ed.
>
> I'm not sure whether that's the ideal way to do it, but if it is, I'll im=
plement it for all other generations.
> If this is not ideal way, could you please give me some other advice?

Yeah, this isn't as clean as I thought it would be.  Either approach
is fine with me, although I suppose with this one, it's easier to
guarantee correctness.

Alex

>
> Best Regards,
> Shane
>
>
> > -----Original Message-----
> > From: Xiao, Shane <shane.xiao@amd.com>
> > Sent: Monday, May 20, 2024 5:14 PM
> > To: amd-gfx@lists.freedesktop.org; alexdeucher@gmail.com; Kuehling, Fel=
ix
> > <Felix.Kuehling@amd.com>; Somasekharan, Sreekant
> > <Sreekant.Somasekharan@amd.com>
> > Cc: Liu, Aaron <Aaron.Liu@amd.com>; Xiao, Shane <shane.xiao@amd.com>;
> > Yao, Longlong <Longlong.Yao@amd.com>
> > Subject: [PATCH] drm/amdgpu: Update the impelmentation of
> > AMDGPU_PTE_MTYPE_GFX12
> >
> > This patch changes the implementation of AMDGPU_PTE_MTYPE_GFX12,
> > clear the bits before setting the new one.
> > This fixed the potential issue that GFX12 setting memory to NC.
> >
> > v2: Clear mtype field before setting the new one (Alex)
> >
> > Signed-off-by: longlyao <Longlong.Yao@amd.com>
> > Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  7 +++++--
> > drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 23 +++++++++++------------
> >  2 files changed, 16 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > index bc71b44387b2..99b246e82ed6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -116,8 +116,11 @@ struct amdgpu_mem_stats;
> >  #define AMDGPU_PTE_PRT_FLAG(adev)    \
> >       ((amdgpu_ip_version((adev), GC_HWIP, 0) >=3D IP_VERSION(12, 0, 0)=
) ?
> > AMDGPU_PTE_PRT_GFX12 : AMDGPU_PTE_PRT)
> >
> > -#define AMDGPU_PTE_MTYPE_GFX12(a)    ((uint64_t)(a) << 54)
> > -#define AMDGPU_PTE_MTYPE_GFX12_MASK
> >       AMDGPU_PTE_MTYPE_GFX12(3ULL)
> > +#define AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype)  ((uint64_t)(mytype)
> > << 54)
> > +#define AMDGPU_PTE_MTYPE_GFX12_MASK
> >       AMDGPU_PTE_MTYPE_GFX12_SHIFT(3ULL)
> > +#define AMDGPU_PTE_MTYPE_GFX12(flags, mtype) \
> > +     ((flags) & ((~AMDGPU_PTE_MTYPE_GFX12_MASK)) |   \
> > +       AMDGPU_PTE_MTYPE_GFX12_SHIFT(mtype))
> >
> >  #define AMDGPU_PTE_IS_PTE            (1ULL << 63)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > index e2c6ec3cc4f3..f2d331d0181f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > @@ -461,17 +461,17 @@ static uint64_t gmc_v12_0_map_mtype(struct
> > amdgpu_device *adev, uint32_t flags)  {
> >       switch (flags) {
> >       case AMDGPU_VM_MTYPE_DEFAULT:
> > -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> > +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
> >       case AMDGPU_VM_MTYPE_NC:
> > -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> > +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
> >       case AMDGPU_VM_MTYPE_WC:
> > -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_WC);
> > +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_WC);
> >       case AMDGPU_VM_MTYPE_CC:
> > -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_CC);
> > +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_CC);
> >       case AMDGPU_VM_MTYPE_UC:
> > -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
> > +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_UC);
> >       default:
> > -             return AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> > +             return AMDGPU_PTE_MTYPE_GFX12(0ULL,MTYPE_NC);
> >       }
> >  }
> >
> > @@ -509,8 +509,8 @@ static void gmc_v12_0_get_vm_pte(struct
> > amdgpu_device *adev,
> >       *flags &=3D ~AMDGPU_PTE_EXECUTABLE;
> >       *flags |=3D mapping->flags & AMDGPU_PTE_EXECUTABLE;
> >
> > -     *flags &=3D ~AMDGPU_PTE_MTYPE_GFX12_MASK;
> > -     *flags |=3D (mapping->flags & AMDGPU_PTE_MTYPE_GFX12_MASK);
> > +     *flags =3D AMDGPU_PTE_MTYPE_GFX12(*flags, (mapping->flags &
> >       \
> > +                      AMDGPU_PTE_MTYPE_GFX12_MASK) >>
> > AMDGPU_PTE_MTYPE_GFX12_SHIFT);
>
> This is not correct. I will correct this change in next version.
>
> >
> >       if (mapping->flags & AMDGPU_PTE_PRT_GFX12) {
> >               *flags |=3D AMDGPU_PTE_PRT_GFX12;
> > @@ -524,8 +524,7 @@ static void gmc_v12_0_get_vm_pte(struct
> > amdgpu_device *adev,
> >
> >       if (bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
> >                              AMDGPU_GEM_CREATE_UNCACHED))
> > -             *flags =3D (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
> > -                      AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC);
> > +             *flags =3D AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_UC);
> >
> >       bo_adev =3D amdgpu_ttm_adev(bo->tbo.bdev);
> >       coherent =3D bo->flags & AMDGPU_GEM_CREATE_COHERENT; @@ -
> > 534,7 +533,7 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_device
> > *adev,
> >
> >       /* WA for HW bug */
> >       if (is_system || ((bo_adev !=3D adev) && coherent))
> > -             *flags |=3D AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> > +             *flags =3D AMDGPU_PTE_MTYPE_GFX12(*flags, MTYPE_NC);
> >
> >  }
> >
> > @@ -707,7 +706,7 @@ static int gmc_v12_0_gart_init(struct amdgpu_device
> > *adev)
> >               return r;
> >
> >       adev->gart.table_size =3D adev->gart.num_gpu_pages * 8;
> > -     adev->gart.gart_pte_flags =3D
> > AMDGPU_PTE_MTYPE_GFX12(MTYPE_UC) |
> > +     adev->gart.gart_pte_flags =3D AMDGPU_PTE_MTYPE_GFX12(0ULL,
> > MTYPE_UC) |
> >                                   AMDGPU_PTE_EXECUTABLE |
> >                                   AMDGPU_PTE_IS_PTE;
> >
> > --
> > 2.25.1
>
