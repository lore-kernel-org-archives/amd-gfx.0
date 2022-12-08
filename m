Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F492C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 04:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9137188C11;
	Thu,  8 Dec 2022 04:19:14 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B988288C11;
 Thu,  8 Dec 2022 04:19:09 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 t19-20020a9d7753000000b0066d77a3d474so225779otl.10; 
 Wed, 07 Dec 2022 20:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lefKWbpJdOt9FY9MkAnJ7ZElgDXl2IDLX1F4fCYXcfY=;
 b=GzHs/dlF9UT9oMAdLKX6GO3y5/aJqAJqi9Ix7btJoSRRhUCwQ9JikkQIeVyXoAIotf
 8FHou+hzWhZJXqwg8x24mZEnubYTGdWuRAh/+BGSgNfWKAWwey1NLWs2XTwM/RJSKPXW
 +1Hc5F5rml0sMzz0XXuQ1PpczFHfhS8PbTdVbOH/HTaPZqL/OrW32SWJnhD66t1RXgMN
 L/S2h6TsTtsQfaplhzAqFKJWZZ6tLsYqbwGniI/LpVCvwFi3kSH6YR3boKa4dQllSnyB
 5e2iaT4epldl4QIQg1k7Ed2bVCmado+WDWiiVzOwrNiRVhp8tRcCUbjiUeT9lOqytgiZ
 ugbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lefKWbpJdOt9FY9MkAnJ7ZElgDXl2IDLX1F4fCYXcfY=;
 b=hThZrj1KcDGA13a87KE3U6jFh3G7HWmXEPVmosW4QBkTyNdddTCRvFJ3iFbnA5dAQ1
 Gv2k+7Y4g5GbVbPg3Vsqr/qhwoOrZ731byutWzj1Tq0WW8+ec/3l9bKWTCed6/qjjo55
 3nueuwPNBjlJMRJ2Cvplo6f+oCxybYgUqndtEWrEa9Y/+/ow8S0l2Q81qenKtmNK83/P
 nOiS3G/doFUe2T/J44Nm4nONaAINo1ibKAPVh/z4tLOwld14x7QmOvaLPFIkzOmEdJPh
 dYiyrbD9lcb7dVkdVY99VDNjwjfV4CrhLVBPkFul+OLl3S7hI35wmyPuCg29C25HKeh9
 zQRQ==
X-Gm-Message-State: ANoB5pk23hCMzpYfa9ePBwHfGnyPjKK3a8G4hFsXxvDnW/42vlgF4g/N
 bNI6k2Wa18lRS0L5UON+Ey14g/1TJIrhy7zrUR0=
X-Google-Smtp-Source: AA0mqf6DOG4uvt/t5k9Ab+TzSmeFw7taZvXaore3wj6z3rMQOQKfvhyk7+WgoXNmkcijUxL6bGBPfetE8KqvOExbUjk=
X-Received: by 2002:a05:6830:1b62:b0:66c:7982:2d45 with SMTP id
 d2-20020a0568301b6200b0066c79822d45mr36596982ote.123.1670473148998; Wed, 07
 Dec 2022 20:19:08 -0800 (PST)
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
In-Reply-To: <CY5PR12MB6369519F1EABAE9A86957850C11D9@CY5PR12MB6369.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Dec 2022 23:18:57 -0500
Message-ID: <CADnq5_PR+7s=FPY71j3XqUA4C62j8zE8FRKq+Oty=nNjSN=Rzw@mail.gmail.com>
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

On Wed, Dec 7, 2022 at 11:10 PM Zhang, Yifan <Yifan1.Zhang@amd.com> wrote:
>
> [AMD Official Use Only - General]
>
> Hi Alex,
>
> We need to adjust the AMDGPU_SG_THRESHOLD as well since recent APUs are c=
onfigured w/ 512MB VRAM. Pls check attached patch.

Why do we need to increase this threshold?  The condition only applies
to CZ and ST, not more recent APUs.

Alex

>
> Best Regards,
> Yifan
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, December 8, 2022 12:21 AM
> To: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Yifan <Yifan1.Zhang@a=
md.com>; amd-gfx <amd-gfx-bounces@lists.freedesktop.org>; Paneer Selvam, Ar=
unpravin <Arunpravin.PaneerSelvam@amd.com>; amd-gfx@lists.freedesktop.org; =
Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christia=
n.Koenig@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer =
failed
>
> On Wed, Dec 7, 2022 at 11:10 AM Christian K=C3=B6nig <ckoenig.leichtzumer=
ken@gmail.com> wrote:
> >
> >
> >
> > Am 07.12.22 um 17:08 schrieb Alex Deucher:
> > > On Wed, Dec 7, 2022 at 10:52 AM Christian K=C3=B6nig
> > > <ckoenig.leichtzumerken@gmail.com> wrote:
> > >> Am 07.12.22 um 16:38 schrieb Alex Deucher:
> > >>> On Wed, Dec 7, 2022 at 10:23 AM Christian K=C3=B6nig
> > >>> <ckoenig.leichtzumerken@gmail.com> wrote:
> > >>>> I would go a step further and just allow GTT domain on ASICs !=3D
> > >>>> CARRIZO
> > >>>> | STONEY.
> > >>>>
> > >>>> I can't see a good reason we should still have any limitation
> > >>>> here, VRAM doesn't have any advantage any more as far as I know.
> > >>> Well, if VRAM is available we want to make sure someone uses it
> > >>> otherwise it's just wasted.
> > >> Well it still gets used when it's free. So now problem at all here.
> > >>
> > >> We should just not force anything into VRAM or GTT any more if it's
> > >> technically not necessary.
> > > So just this?
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > index 919bbea2e3ac..8e8f07fa7a93 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > > @@ -1506,7 +1506,7 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu=
_bo *bo)
> > >   uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
> > >                                              uint32_t domain)
> > >   {
> > > -       if (domain =3D=3D (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN=
_GTT)) {
> >
> > We still need to keep this check to avoid trying to adjust VRAM only
> > allocations (the cursor still needs this IIRC).
> >
> > Apart from that I think that should work.
>
> Attached.  Thanks,
>
> Alex
>
> >
> > Christian.
> >
> > > +       if ((adev->asic_type =3D=3D CHIP_CARRIZO) || (adev->asic_type=
 =3D=3D
> > > CHIP_STONEY)) {
> > >                  domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> > >                  if (adev->gmc.real_vram_size <=3D AMDGPU_SG_THRESHOL=
D)
> > >                          domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > >
> > >
> > >
> > >> Christian.
> > >>
> > >>> Alex
> > >>>
> > >>>
> > >>>> Christian.
> > >>>>
> > >>>> Am 07.12.22 um 16:10 schrieb Alex Deucher:
> > >>>>> Does this patch fix the problem?
> > >>>>>
> > >>>>> Alex
> > >>>>>
> > >>>>> On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) <Jesse.Zhang@amd=
.com> wrote:
> > >>>>>> [AMD Official Use Only - General]
> > >>>>>>
> > >>>>>>
> > >>>>>>        drm/amdgpu: try allowed domain when pin framebuffer faile=
d.
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>        [WHY&HOW]
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>        in some scenarios, the allocate memory often failed. such=
 as do hot plug or play games.
> > >>>>>>
> > >>>>>>        so we can try allowed domain, if the preferred domain can=
not allocate memory.
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>>        Signed-off-by: jie1zhan jesse.zhang@amd.com
> > >>>>>>
> > >>>>>>        Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > >>>>>>
> > >>>>>> index 1ae0c8723348..05fcaf7f9d92 100644
> > >>>>>>
> > >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > >>>>>>
> > >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > >>>>>>
> > >>>>>> @@ -39,6 +39,7 @@
> > >>>>>>
> > >>>>>> #include "amdgpu.h"
> > >>>>>>
> > >>>>>> #include "amdgpu_trace.h"
> > >>>>>>
> > >>>>>> #include "amdgpu_amdkfd.h"
> > >>>>>>
> > >>>>>> +#include "amdgpu_display.h"
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> /**
> > >>>>>>
> > >>>>>>      * DOC: amdgpu_object
> > >>>>>>
> > >>>>>> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct
> > >>>>>> amdgpu_bo *bo, u32 domain,
> > >>>>>>
> > >>>>>>                            bo->placements[i].lpfn =3D lpfn;
> > >>>>>>
> > >>>>>>            }
> > >>>>>>
> > >>>>>>
> > >>>>>>
> > >>>>>> +       retry:
> > >>>>>>
> > >>>>>>            r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx)=
;
> > >>>>>>
> > >>>>>>            if (unlikely(r)) {
> > >>>>>>
> > >>>>>> +               //try allowed domain when pin failed. just a wor=
karound.
> > >>>>>>
> > >>>>>> +               if (unlikely(r =3D=3D -ENOMEM) && domain !=3D
> > >>>>>> + bo->allowed_domains) {
> > >>>>>>
> > >>>>>> +                       amdgpu_bo_placement_from_domain(bo,
> > >>>>>> + bo->allowed_domains);
> > >>>>>>
> > >>>>>> +                       goto retry;
> > >>>>>>
> > >>>>>> +               }
> > >>>>>>
> > >>>>>>                    dev_err(adev->dev, "%p pin failed\n", bo);
> > >>>>>>
> > >>>>>>                    goto error;
> > >>>>>>
> > >>>>>>            }
> >
