Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AA5C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 04:40:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF8E10E457;
	Thu,  8 Dec 2022 04:40:32 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 653C710E457;
 Thu,  8 Dec 2022 04:40:28 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1443a16b71cso590642fac.13; 
 Wed, 07 Dec 2022 20:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6g5Iyg8YmwM/2PoxgQIXgdImRDano0Ot1250cdgn/zY=;
 b=hZEMrpYJ+anp8TyD5zJrxl3S3G9vwImPPBHiOzT6co1MFcQh5fx2Tc6qG8L9LTefCu
 8tEG7LEKswCq1a7LdDUpY2Ot8b3rzFodwRjjZYdGH7j+yC1g8bvbqcyZZTW0xHc3Tqku
 l+glKKEEjYNGE4bPOBZFZKREgm3dQ4WJ2z7i/LkzjeT8OSh+KnGMhtrJVg0cIJRQkCHe
 SPXYBuEztueietMnQuCLYNXGsWBeFRchj4YCgJ4oftAH6NrMGdbVBNn9cYKWa/JEvPJX
 rCbLtnsIxa514ItVyTvWBRGTHurL+4lmssfKkBWIoWse0YbpDY1eqtrgd9Cg5CLNzWR4
 V2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6g5Iyg8YmwM/2PoxgQIXgdImRDano0Ot1250cdgn/zY=;
 b=JBvSpEQO42w+KhDbLJHBj+xjwrPVFdY06TLhB2TCBThnRNkxv8Vv1IK+Jv0Jhl+rHm
 qQSFMpcmP0FRbNZTi7LmcCBvVeDZFMz9CXcmgwMrUtE4EEq2MD68Ad+xH4E1Ht80i5dk
 DH+2ZJhvzrpXR1bVsGI/eyTQ9oTgyRc7r2k9nxQFJsXmS65mlIJlyGqD4qtjXg3482sY
 rF+pdTQzbKEoJPcbclaPpFMGqp3kOPr4pINZvPXkmbjNjaO6KdbOpB4VQOCLkfe33bSk
 OvAg6IWOl6Tz4ke0mvIryezZdcAF0+hOy9KaRWA6mzf4C9N05Wk6IdoyVLkbp6xV6Ymo
 +Pzg==
X-Gm-Message-State: ANoB5pmUrGL7I3YSPxLBHkdBLaALGUtoYU/gk3BJHk1PVJPTO/pmOh2i
 YSYol3ZwPC/mnPhBs1P8eiK8tVEpzECVD1p6v8o=
X-Google-Smtp-Source: AA0mqf4PNsaT2aFc29MSGkYgmK+7XMIp7l/EXkt4E8nGj6a06To5eAA9VJS8cqM5GI8W6P4l5cmONFVWXehY+XOXrpI=
X-Received: by 2002:a05:6870:2b05:b0:12d:58c1:33f9 with SMTP id
 ld5-20020a0568702b0500b0012d58c133f9mr43099986oab.46.1670474427606; Wed, 07
 Dec 2022 20:40:27 -0800 (PST)
MIME-Version: 1.0
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
 <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
 <CADnq5_PShNRZUwvnsTawW1OaCOjK73rdKTxxQhA=Znf2gqbJ=Q@mail.gmail.com>
 <ce75ecb5-1d07-d8a6-2722-59da84c22c10@gmail.com>
 <CADnq5_Mo_hmc7SCYJxQHc-TgdzXS7+YD-SUt9aF-Gx2AovriRw@mail.gmail.com>
 <581403d1-f5f3-72a6-5447-6deef4405d47@gmail.com>
 <CADnq5_OtFeSYKKjniNXuXUmX4WgXw1+hN-3YoRpBh-Ytjosv5g@mail.gmail.com>
 <CY5PR12MB6369519F1EABAE9A86957850C11D9@CY5PR12MB6369.namprd12.prod.outlook.com>
 <CADnq5_PR+7s=FPY71j3XqUA4C62j8zE8FRKq+Oty=nNjSN=Rzw@mail.gmail.com>
 <CY5PR12MB63699C93015F77F4C6AD5BDBC11D9@CY5PR12MB6369.namprd12.prod.outlook.com>
In-Reply-To: <CY5PR12MB63699C93015F77F4C6AD5BDBC11D9@CY5PR12MB6369.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Dec 2022 23:40:16 -0500
Message-ID: <CADnq5_P0YmG0y-0NCufcx8-d6Y2CuHxf+TH2xDVY7QDhG+=C4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
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
Cc: amd-gfx <amd-gfx-bounces@lists.freedesktop.org>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 7, 2022 at 11:35 PM Zhang, Yifan <Yifan1.Zhang@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> We encountered some issues in recent APUs when tried to pin a large frame=
buffer (e.g. 64MB w/ dual 4K display), switch to display SG could resolve s=
uch issue.  Actually we received various kinds of VRAM shortage issues rece=
ntly, there is more and more pressure on APU 512MB VRAM as FWs reserve more=
 memory, buddy system in 5.19 creates more fragment and multiple 4k display=
 scenario is used  more often.. Since there is no difference b/w access VRA=
M and System memory in APUs from HW perspective, I think we can switch some=
 of framebuffers to system memory to mitigate VRAM pressure.
>
> [   52.798705] [TTM] Failed to find memory space for buffer 0x00000000833=
a4c59 eviction
> [   52.798707] [TTM]  No space for 00000000833a4c59 (16470 pages, 65880K,=
 64M)
> [   52.798788] amdgpu 0000:e2:00.0: amdgpu: 000000003dbf313e pin failed
> [   52.798790] [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed t=
o pin framebuffer with error -12

But from the patch:
-    if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
+    if ((domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) &=
&
+        ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type =3D=3D
CHIP_STONEY))) {
         domain =3D AMDGPU_GEM_DOMAIN_VRAM;
         if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOLD)
             domain =3D AMDGPU_GEM_DOMAIN_GTT;

AMDGPU_SG_THRESHOLD is only used in this one place which only applies
to CZ and ST.  There are not likely to be new CZ or ST boards any time
soon so I don't think it matters for newer APUs if we change
AMDGPU_SG_THRESHOLD.

Does the patch fix the issues you are seeing?

Alex

>
> Best Regards,
> Yifan
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, December 8, 2022 12:19 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Cc: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>; Zhang, Jesse=
(Jie) <Jesse.Zhang@amd.com>; amd-gfx <amd-gfx-bounces@lists.freedesktop.org=
>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>; amd-gfx@lis=
ts.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,=
 Christian <Christian.Koenig@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer =
failed
>
> On Wed, Dec 7, 2022 at 11:10 PM Zhang, Yifan <Yifan1.Zhang@amd.com> wrote=
:
> >
> > [AMD Official Use Only - General]
> >
> > Hi Alex,
> >
> > We need to adjust the AMDGPU_SG_THRESHOLD as well since recent APUs are=
 configured w/ 512MB VRAM. Pls check attached patch.
>
> Why do we need to increase this threshold?  The condition only applies to=
 CZ and ST, not more recent APUs.
>
> Alex
>
> >
> > Best Regards,
> > Yifan
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, December 8, 2022 12:21 AM
> > To: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> > Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Yifan
> > <Yifan1.Zhang@amd.com>; amd-gfx
> > <amd-gfx-bounces@lists.freedesktop.org>; Paneer Selvam, Arunpravin
> > <Arunpravin.PaneerSelvam@amd.com>; amd-gfx@lists.freedesktop.org;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin
> > framebuffer failed
> >
> > On Wed, Dec 7, 2022 at 11:10 AM Christian K=C3=B6nig <ckoenig.leichtzum=
erken@gmail.com> wrote:
> > >
> > >
> > >
> > > Am 07.12.22 um 17:08 schrieb Alex Deucher:
> > > > On Wed, Dec 7, 2022 at 10:52 AM Christian K=C3=B6nig
> > > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > > >> Am 07.12.22 um 16:38 schrieb Alex Deucher:
> > > >>> On Wed, Dec 7, 2022 at 10:23 AM Christian K=C3=B6nig
> > > >>> <ckoenig.leichtzumerken@gmail.com> wrote:
> > > >>>> I would go a step further and just allow GTT domain on ASICs !=
=3D
> > > >>>> CARRIZO
> > > >>>> | STONEY.
> > > >>>>
> > > >>>> I can't see a good reason we should still have any limitation
> > > >>>> here, VRAM doesn't have any advantage any more as far as I know.
> > > >>> Well, if VRAM is available we want to make sure someone uses it
> > > >>> otherwise it's just wasted.
> > > >> Well it still gets used when it's free. So now problem at all here=
.
> > > >>
> > > >> We should just not force anything into VRAM or GTT any more if
> > > >> it's technically not necessary.
> > > > So just this?
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > index 919bbea2e3ac..8e8f07fa7a93 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > > @@ -1506,7 +1506,7 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdg=
pu_bo *bo)
> > > >   uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *ade=
v,
> > > >                                              uint32_t domain)
> > > >   {
> > > > -       if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMA=
IN_GTT)) {
> > >
> > > We still need to keep this check to avoid trying to adjust VRAM only
> > > allocations (the cursor still needs this IIRC).
> > >
> > > Apart from that I think that should work.
> >
> > Attached.  Thanks,
> >
> > Alex
> >
> > >
> > > Christian.
> > >
> > > > +       if ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_ty=
pe
> > > > + =3D=3D
> > > > CHIP_STONEY)) {
> > > >                  domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> > > >                  if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESH=
OLD)
> > > >                          domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > > >
> > > >
> > > >
> > > >> Christian.
> > > >>
> > > >>> Alex
> > > >>>
> > > >>>
> > > >>>> Christian.
> > > >>>>
> > > >>>> Am 07.12.22 um 16:10 schrieb Alex Deucher:
> > > >>>>> Does this patch fix the problem?
> > > >>>>>
> > > >>>>> Alex
> > > >>>>>
> > > >>>>> On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) <Jesse.Zhang@a=
md.com> wrote:
> > > >>>>>> [AMD Official Use Only - General]
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>        drm/amdgpu: try allowed domain when pin framebuffer fai=
led.
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>        [WHY&HOW]
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>        in some scenarios, the allocate memory often failed. su=
ch as do hot plug or play games.
> > > >>>>>>
> > > >>>>>>        so we can try allowed domain, if the preferred domain c=
annot allocate memory.
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>        Signed-off-by: jie1zhan jesse.zhang@amd.com
> > > >>>>>>
> > > >>>>>>        Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>
> > > >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > >>>>>>
> > > >>>>>> index 1ae0c8723348..05fcaf7f9d92 100644
> > > >>>>>>
> > > >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > >>>>>>
> > > >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > >>>>>>
> > > >>>>>> @@ -39,6 +39,7 @@
> > > >>>>>>
> > > >>>>>> #include "amdgpu.h"
> > > >>>>>>
> > > >>>>>> #include "amdgpu_trace.h"
> > > >>>>>>
> > > >>>>>> #include "amdgpu_amdkfd.h"
> > > >>>>>>
> > > >>>>>> +#include "amdgpu_display.h"
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>
> > > >>>>>> /**
> > > >>>>>>
> > > >>>>>>      * DOC: amdgpu_object
> > > >>>>>>
> > > >>>>>> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct
> > > >>>>>> amdgpu_bo *bo, u32 domain,
> > > >>>>>>
> > > >>>>>>                            bo->placements[i].lpfn =3D lpfn;
> > > >>>>>>
> > > >>>>>>            }
> > > >>>>>>
> > > >>>>>>
> > > >>>>>>
> > > >>>>>> +       retry:
> > > >>>>>>
> > > >>>>>>            r =3D ttm_bo_validate(&bo->tbo, &bo->placement,
> > > >>>>>> &ctx);
> > > >>>>>>
> > > >>>>>>            if (unlikely(r)) {
> > > >>>>>>
> > > >>>>>> +               //try allowed domain when pin failed. just a w=
orkaround.
> > > >>>>>>
> > > >>>>>> +               if (unlikely(r =3D=3D -ENOMEM) && domain !=3D
> > > >>>>>> + bo->allowed_domains) {
> > > >>>>>>
> > > >>>>>> +                       amdgpu_bo_placement_from_domain(bo,
> > > >>>>>> + bo->allowed_domains);
> > > >>>>>>
> > > >>>>>> +                       goto retry;
> > > >>>>>>
> > > >>>>>> +               }
> > > >>>>>>
> > > >>>>>>                    dev_err(adev->dev, "%p pin failed\n", bo);
> > > >>>>>>
> > > >>>>>>                    goto error;
> > > >>>>>>
> > > >>>>>>            }
> > >
