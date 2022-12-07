Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D0CC4708E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A3C110E0FE;
	Wed,  7 Dec 2022 15:39:01 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D80810E3D0;
 Wed,  7 Dec 2022 15:38:58 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id n205so21130855oib.1;
 Wed, 07 Dec 2022 07:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGRoHyPCIWu8BZ6fqIL+1qmmgh2V2VQNDGitldS6v1Y=;
 b=SSUzWNRQN5VbYwy1yC0ie2Bkf+SKbtDc6Fblui0i/JFpZ0clL5v/opt1Ow4icTbs8J
 k85ArWtN3X26jyvob/wsud9ssRZNlAcuWhQr3gbtBGnZWvyKBg9UF0JSCWLRq5jgg3JI
 bbTpuPjIOQVaWpz1HQKF95G4383kED76hCR6JOMJhs2PiGrVbfZ8YGawA7nspgtrGaj9
 MLRBM4jAIprHHygatE525WBjWd+6t3055JUiQNonwGhpf5sK/C5tVhfcSGAVgdZqbOF6
 vxXtd9UMnGgrc6wgxdCyVx42Gf8vrbvMbdL4VbMy+vpT5xVUIFwN9muBhSukT4wVOC2M
 qXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yGRoHyPCIWu8BZ6fqIL+1qmmgh2V2VQNDGitldS6v1Y=;
 b=c4tiXAaVLmMbtFSIXNppk4bzjVMTlU118v2q+jCqt3XxctBy9zyRaPHBUkCaI2eABA
 liPwgcIRtSsqmvs4Uw19XWpfm/RaIwO84y8yDNNGghhXIV7NwXkvdZjjdp7chU4gDH13
 mBhV3oW5GWwtuls7GfSerwgJ2Ffjj0HoUs3jbHppcByTwgMW/fjdDsxRkM4XFaIMNqmO
 dP6Bsua1IbdN0abigtWKUCt/RUJzshH7jkZNE/YG26Ov7enMzXJWcEOKdjbAeLHbTiQZ
 K26xRLNvjWoW3JQwNvnMiZRw1K2OcZZNdvzYgubsxB2TmA/KfG+gnLYIqFMuKpGRSnju
 eJ0A==
X-Gm-Message-State: ANoB5pnYtaQYsLdhQK4ndHZK7asm3xGVFJ1i1pOm8FHd3jDLKNITyByC
 paGVTBzy6QxNLLnDbfDERWnZoBH70eoD1Z9vO9SNf1OL
X-Google-Smtp-Source: AA0mqf5t60BeEOacW42tOqv55gZWczIylNKPOUvXqAwxEcu165bMC3W7f7PctxLelIt+kN4LNY7gkgON28Rd+S1CXWY=
X-Received: by 2002:aca:1913:0:b0:35b:f5f7:3ed0 with SMTP id
 l19-20020aca1913000000b0035bf5f73ed0mr10922699oii.46.1670427536577; Wed, 07
 Dec 2022 07:38:56 -0800 (PST)
MIME-Version: 1.0
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
 <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
In-Reply-To: <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 7 Dec 2022 10:38:45 -0500
Message-ID: <CADnq5_PShNRZUwvnsTawW1OaCOjK73rdKTxxQhA=Znf2gqbJ=Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 amd-gfx <amd-gfx-bounces@lists.freedesktop.org>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 7, 2022 at 10:23 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> I would go a step further and just allow GTT domain on ASICs !=3D CARRIZO
> | STONEY.
>
> I can't see a good reason we should still have any limitation here, VRAM
> doesn't have any advantage any more as far as I know.

Well, if VRAM is available we want to make sure someone uses it
otherwise it's just wasted.

Alex


>
> Christian.
>
> Am 07.12.22 um 16:10 schrieb Alex Deucher:
> > Does this patch fix the problem?
> >
> > Alex
> >
> > On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) <Jesse.Zhang@amd.com> =
wrote:
> >> [AMD Official Use Only - General]
> >>
> >>
> >>      drm/amdgpu: try allowed domain when pin framebuffer failed.
> >>
> >>
> >>
> >>      [WHY&HOW]
> >>
> >>
> >>
> >>      in some scenarios, the allocate memory often failed. such as do h=
ot plug or play games.
> >>
> >>      so we can try allowed domain, if the preferred domain cannot allo=
cate memory.
> >>
> >>
> >>
> >>      Signed-off-by: jie1zhan jesse.zhang@amd.com
> >>
> >>      Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
> >>
> >>
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_object.c
> >>
> >> index 1ae0c8723348..05fcaf7f9d92 100644
> >>
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>
> >> @@ -39,6 +39,7 @@
> >>
> >> #include "amdgpu.h"
> >>
> >> #include "amdgpu_trace.h"
> >>
> >> #include "amdgpu_amdkfd.h"
> >>
> >> +#include "amdgpu_display.h"
> >>
> >>
> >>
> >> /**
> >>
> >>    * DOC: amdgpu_object
> >>
> >> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo=
, u32 domain,
> >>
> >>                          bo->placements[i].lpfn =3D lpfn;
> >>
> >>          }
> >>
> >>
> >>
> >> +       retry:
> >>
> >>          r =3D ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
> >>
> >>          if (unlikely(r)) {
> >>
> >> +               //try allowed domain when pin failed. just a workaroun=
d.
> >>
> >> +               if (unlikely(r =3D=3D -ENOMEM) && domain !=3D bo->allo=
wed_domains) {
> >>
> >> +                       amdgpu_bo_placement_from_domain(bo, bo->allowe=
d_domains);
> >>
> >> +                       goto retry;
> >>
> >> +               }
> >>
> >>                  dev_err(adev->dev, "%p pin failed\n", bo);
> >>
> >>                  goto error;
> >>
> >>          }
>
