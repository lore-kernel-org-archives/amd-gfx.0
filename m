Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EBFC47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 15:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C53310F90F;
	Thu, 25 Jan 2024 15:23:26 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AC3E10F90F
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 15:23:25 +0000 (UTC)
Received: by mail-oi1-f175.google.com with SMTP id
 5614622812f47-3bda4ee62f3so4047650b6e.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 07:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706196145; x=1706800945; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PfBTTb9hPKW+fxJLCunC2waUEPie8LHypblMB5s4S0=;
 b=fjjiq2n0zMmn18R/1gR5MkjUtmEbDr3PLxyll24EKTGQoFK5ARWblV6f3KtOonB5G+
 zpy6gwWhTiA5NRP8ENd7/ujJB492agl1eokkQIDAy02o+T5OMWALRj3254vRRCLzyiSC
 EWPkZbjAmqEmuJG1s4wdky9oGtChQ8yl0XNpxD30LTa+6hOh7Ui9hw9lp6NI5XMAquUY
 c9UC/iVxhzute5bvfEz4ur21uDMbAovWkiCy7/BtfSv9aGhVRnYnLU26D2fqTGDwhegG
 qHcwPng1XYZHTfDjeWCYSips7OsTI50Z6yNGfgYgVmGnpBoUKoFGXMUvvlC9+hkIhJZP
 1o0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706196145; x=1706800945;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4PfBTTb9hPKW+fxJLCunC2waUEPie8LHypblMB5s4S0=;
 b=wv6TPl5K19HIr1b/kZjTc8yz6Y/4iXvo8HHjkj1G7r3vPQvLbHo61wslETy3waCafA
 6Yw5rkH7wcR5za/jFd6bNYVI/gB277rsr6ZwjCSJmLpMJOCnvkrPOk+z5cqKgBrJToX4
 UpsN57l36M+rCyWon9iaVccSMMgsL/zPytdq6CUOVgCmXgvui/0+7nGR/8R1vE5OBSW6
 vf04+u4lAp39fuj8KJ6ogkjfpXraE3wCVxOWwwP0p5ddBJD88LfHAfgzpUe2McNAlz1/
 sVoY0Z0yp9BCdQngeDR2hU1erDtRk7bfwDUDIpW1F4IOc7STt5C1KY6AkcPWX5P0WNvl
 togg==
X-Gm-Message-State: AOJu0Yzz/Vsea/KGvELc38TYEcPP8gebii2lTwx6bm76xCGZhnQ34pa+
 8ps94Fu0jc++Q/IheioK2fm71dsJbEijrb4rfP9G/Jfn64Oy9UzCf6xFz/Wg7oLH0YZGW2MCZtP
 KzV9gjBk1YjURs1P2J1V/TX9uvEfJVNkW
X-Google-Smtp-Source: AGHT+IFDJay98oiCurvl8ZH0HNZrYHSaA2ahFIt34N2dh5tSzl2+GnX+ckk3lK+T7XgCk0wtDhOM9NPTSQsAdcQQ5/I=
X-Received: by 2002:a05:6870:d186:b0:214:2ea2:cd39 with SMTP id
 a6-20020a056870d18600b002142ea2cd39mr952919oac.102.1706196144794; Thu, 25 Jan
 2024 07:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20240124065932.892944-1-Prike.Liang@amd.com>
 <CADnq5_PJyh50wpHQuU_UFYvpnnp8PsteAJ7ymazFHMWD92cyDw@mail.gmail.com>
 <DS7PR12MB6005078B67C8122627CAA45DFB7A2@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005078B67C8122627CAA45DFB7A2@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jan 2024 10:22:13 -0500
Message-ID: <CADnq5_P0NJ7Vd1LBbECxf-1X-s3BOdYb0Q4FjEQe9TptjX_j9A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers for PM
 abort case
To: "Liang, Prike" <Prike.Liang@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Sharma,
 Deepak" <Deepak.Sharma@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 24, 2024 at 9:39=E2=80=AFPM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [AMD Official Use Only - General]
>
> Hi, Alex
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, January 24, 2024 11:59 PM
> > To: Liang, Prike <Prike.Liang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Sharma, Deepak
> > <Deepak.Sharma@amd.com>
> > Subject: Re: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers f=
or
> > PM abort case
> >
> > On Wed, Jan 24, 2024 at 2:12=E2=80=AFAM Prike Liang <Prike.Liang@amd.co=
m> wrote:
> > >
> > > In the PM abort cases, the gfx power rail doesn't turn off so some
> > > GFXDEC registers/CSB can't reset to default vaule. In order to avoid
> > > unexpected problem now need skip to program GFXDEC registers and
> > > bypass issue CSB packet for PM abort case.
> > >
> > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
> > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++++
> > >  3 files changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > index c5f3859fd682..26d983eb831b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > @@ -1079,6 +1079,7 @@ struct amdgpu_device {
> > >         bool                            in_s3;
> > >         bool                            in_s4;
> > >         bool                            in_s0ix;
> > > +       bool                            pm_complete;
> > >
> > >         enum pp_mp1_state               mp1_state;
> > >         struct amdgpu_doorbell_index doorbell_index; diff --git
> > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > index 475bd59c9ac2..a01f9b0c2f30 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > @@ -2486,6 +2486,7 @@ static int amdgpu_pmops_suspend_noirq(struct
> > device *dev)
> > >         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> > >         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> > >
> > > +       adev->pm_complete =3D true;
> >
> > This needs to be cleared somewhere on resume.
> [Liang, Prike]  This flag is designed to indicate the amdgpu device suspe=
nsion process status and will update the patch and clear it at the amdgpu s=
uspension beginning point.
> >
> > >         if (amdgpu_acpi_should_gpu_reset(adev))
> > >                 return amdgpu_asic_reset(adev);
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > index 57808be6e3ec..3bf51f18e13c 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > @@ -3034,6 +3034,10 @@ static int gfx_v9_0_cp_gfx_start(struct
> > > amdgpu_device *adev)
> > >
> > >         gfx_v9_0_cp_gfx_enable(adev, true);
> > >
> > > +       if (adev->in_suspend && !adev->pm_complete) {
> > > +               DRM_INFO(" will skip the csb ring write\n");
> > > +               return 0;
> > > +       }
> >
> > We probably want a similar fix for other gfx generations as well.
> >
> > Alex
> >
> [Liang, Prike] IIRC, there's no issue on the Mendocino side even without =
the fix. How about keep the other gfx generations unchanged firstly and aft=
er sort out the failed case will add the quirk for each specific gfx respec=
tively?

Mendocino only supports S0i3 so we don't touch gfx on suspend/resume.
This would only happen on platforms that support S3.

Alex

>
> > >         r =3D amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4=
 + 3);
> > >         if (r) {
> > >                 DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n",
> > > r);
> > > --
> > > 2.34.1
> > >
