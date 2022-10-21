Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FDDC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 14:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41B9310E0E0;
	Fri, 21 Oct 2022 14:18:38 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97C1B10E0F3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 14:18:29 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 f4-20020a9d0384000000b0066208c73094so1927537otf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 07:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1YTt6kdbNsgzYt1j68haXjPSPV3JmbgQ+Y/w5VWQlw=;
 b=WHoSVzqlPg2lPPsVxLwe36yaJkemab2unH7s5FOpdVYK4HqzqizdfZK7LAxQOE4Dg9
 RbAKnKp5lkIyXM6swSJ8Dl33kfHVzaaIKZ1RuETL0xySYbMBzF9b0FjTkN9d4mwgR6ao
 tmASkNsjqQezUoklzfXCejS5DSp8U/GseZhG+Fxjys0yyQX6d0AF6BiKwHpeBjoyjSux
 tS8P+1SRZAi+C94uR7OBkRePuvXV4sdCZ8NPMrCOrI91lP27WH1gxmU/nVNrgQmXCRsN
 hFCowLV604JZkRrMoZVVemeXb9+xgjw2h27ntgyqf81l19DNnd99gfh+oxNcbyyNkRxj
 fHuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u1YTt6kdbNsgzYt1j68haXjPSPV3JmbgQ+Y/w5VWQlw=;
 b=egLpdBiiOSy+IZ7YtJ7x9GXXYJfsKgVrPo0gSj7/1aFjXUFgqDUWhhUqEpZAJKOm2l
 sQKpN45BrSpVDtMas8xSRR1Mh9MyBs7NAnin6q7m7HR6+jFXMKhtqH4PVgRpk58qfirs
 tjf+zR0O2WqDkMBFHnpBgrPutu94f3A00Y5Vzp11BDhcOkaUbxme1Ap+RBGdHqxMzqEB
 fgG/UpLSruUG7QtVy8wic5+yaj9uhpeCoS4QUzsjyCt14xtSbYNVJkNjnZ6MdgEDsVt2
 YojCbkIYF8EaK9dBdBIDedxpHppZ4DlJ2urC2W3d7ddqIdg9x14alPgGT/bIkXWpc5W3
 wjUg==
X-Gm-Message-State: ACrzQf178ZyjfmjEGI1V1n9Yymq8qpI0/v6U6eRI0fCOKG8ZgMSIIfda
 NeubkF2VJuKDwwTeeH5ZybRo06UGpiUj023yLr0=
X-Google-Smtp-Source: AMsMyM4YTMEFcsvWPyXUfSfnSqRX1viXI1oB8PjxFkccW8KYSvz0VJDYe2uyKWZCYb166NN4Z6Lu9J5ZrHdMV3fs93c=
X-Received: by 2002:a9d:6645:0:b0:661:b778:41b8 with SMTP id
 q5-20020a9d6645000000b00661b77841b8mr10125448otm.233.1666361908839; Fri, 21
 Oct 2022 07:18:28 -0700 (PDT)
MIME-Version: 1.0
References: <20221021022956.2775675-1-Prike.Liang@amd.com>
 <CADnq5_Of6R-BtZ5dz-e=nPsgNG4g4VqzsbnYznqfi7AKc1DXrw@mail.gmail.com>
 <DS7PR12MB60050448182F4713F3D7908AFB2D9@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60050448182F4713F3D7908AFB2D9@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Oct 2022 10:18:16 -0400
Message-ID: <CADnq5_PPzQZP9rjPjKycvBjcw7Lcd5DM+d9stQoO3G84=-xcEA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disallow gfxoff until GC IP blocks complete
 s2idle resume
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 21, 2022 at 10:10 AM Liang, Prike <Prike.Liang@amd.com> wrote:
>
> [Public]
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, October 21, 2022 9:39 PM
> To: Liang, Prike <Prike.Liang@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@=
amd.com>; Huang, Ray <Ray.Huang@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: disallow gfxoff until GC IP blocks compl=
ete s2idle resume
>
> On Thu, Oct 20, 2022 at 10:30 PM Prike Liang <Prike.Liang@amd.com> wrote:
> >
> > In the S2idle suspend/resume phase the gfxoff is keeping functional so
> > some IP blocks will be likely to reinitialize at gfxoff entry and that
> > will result in failing to program GC registers.Therefore, let disallow
> > gfxoff until AMDGPU IPs reinitialized completely.
> >
> > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++++
> > drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c  | 5 +++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index e0445e8cc342..1624ed15fbc4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4185,6 +4185,10 @@ int amdgpu_device_resume(struct drm_device *dev,=
 bool fbcon)
> >         /* Make sure IB tests flushed */
> >         flush_delayed_work(&adev->delayed_init_work);
> >
> > +       if (adev->in_s0ix) {
> > +               amdgpu_gfx_off_ctrl(adev, true);
> > +               DRM_DEBUG("will enable gfxoff for the mission mode\n");
> > +       }
> >         if (fbcon)
> >
> > drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper,
> > false);
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > index 4fe75dd2b329..3948dc5b1d6a 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1664,6 +1664,11 @@ static int smu_resume(void *handle)
> >
> >         dev_info(adev->dev, "SMU is resumed successfully!\n");
> >
> > +       if (adev->in_s0ix) {
> > +               amdgpu_gfx_off_ctrl(adev, false);
> > +               dev_dbg(adev->dev, "will disable gfxoff for re-initiali=
zing other blocks\n");
> > +       }
> > +
>
> I think it would be better to put this in amdgpu_device.c so it's clear w=
here its match is.  Also for raven based boards this will get missed becaus=
e they still use the powerplay power code.
>
> Alex
>
> [Prike] I miss this amdgpu_gfx_off_ctrl() is a generic upper layer functi=
on but that should also work on Rave series, since on the Rave series will =
use another message PPSMC_MSG_GpuChangeState exit gfxoff. But it makes sens=
e unify the operation of exiting gfxoff at an upper layer in amdgpu_device.=
c and I will update it at patch v2.
>

Ok.  If you can move it into amdgpu_device.c that would be great, but
if not, either way, please add comments to these functions noting
where their match is and why this is necessary.

Thanks!

Alex

> Thanks,
> Prike
> >         return 0;
> >  }
> >
> > --
> > 2.25.1
> >
