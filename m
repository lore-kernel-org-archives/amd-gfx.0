Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB589C47258
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 15:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B4D10F911;
	Thu, 25 Jan 2024 15:25:09 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E6B10F911
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 15:25:08 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-21481a3de56so1722667fac.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 07:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706196248; x=1706801048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epf43hFwuI9y4ljhK7MIApBfTymGAqfGbAJTH6TXrUo=;
 b=kGu4tIDTKbKvUWnFBmFGpanFidVX8RS7Pumunr4j16NtbmNDZyXG3ul5d6m0hikUzJ
 nT+JwFQaKlPUY0EsjCqB7gPdArwa0b+kzO7nQtCYJXFsU3vmIBoDNbIGiYxqulxEekcC
 TvHGBlyruGVtP5hgJ6jfSnBxL59Lusnl2JQMolx54Prd0p4Mu17fh+CG4JNigVfdof0f
 pUcGoQPjOc5WKQAm5629BDQtvmRsDVhu6oX7tL5vH/vm88L/2m5xm7iA6APQwsv9DdWF
 yYLi5t9VfZbo3Hn8bGyo5zkuin0zb2F0ZVXZitv10QQ44gBhZ73L9fFP4aiVpb4nQE1E
 kFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706196248; x=1706801048;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=epf43hFwuI9y4ljhK7MIApBfTymGAqfGbAJTH6TXrUo=;
 b=VfF6CkMrbkeo7nv6tpxCf4wJdvoFWZMe9/6KaLFhRl0mbTN4Qi8kX04BkQkPPGICMT
 PwevczpvbTKfdQubWMKIB4Tl3IrQZmJrLMBg/suOFVaiZNfN2BzT2umkOuynE3NQL2SK
 TsOem+uUcl0mFO+JGCazymim703Tl1a/AfAI+WMM4OGOWUMzh7JWNZ+G2YyvPn8ViuN5
 fPv1lebcuSC88ZaTpJC4MexD2BkrZr0YUZTvQaNgjH1m3Rhei0fMqX/FED4ibocaT8zQ
 O3IGC9h7gkwyiQPZA/eb9btqwqNGbtsH0NV4DVllJ7FTZkoY1c61PQYN+NVHPerRcKSU
 GyIg==
X-Gm-Message-State: AOJu0Yyv6uMFMLAYAE6XhtUqRjmFO4mNjqmF4e3Wtt0+UXI5aGPmgSAe
 P2Z4XFHsa1zJOotDNUF8OSvTTK8m9F2lChxFo+Rzbyh3y6AqoW1btCfYiuQXdl22LkVKGmTziih
 OgUHSsB0Lk4DcXlh0pbL4cgtQNEdKc0as
X-Google-Smtp-Source: AGHT+IF8blwj9rwCGqNpBUrTFBwxt4SpqWudpB2kT88zWu/IQSVELj+Q9TesTHcwZD5kvzutZ+EfY8U5j0pGPzkdEqc=
X-Received: by 2002:a05:6871:5d3:b0:210:e14a:7a9c with SMTP id
 v19-20020a05687105d300b00210e14a7a9cmr986143oan.58.1706196248047; Thu, 25 Jan
 2024 07:24:08 -0800 (PST)
MIME-Version: 1.0
References: <20240124065932.892944-1-Prike.Liang@amd.com>
 <CADnq5_PJyh50wpHQuU_UFYvpnnp8PsteAJ7ymazFHMWD92cyDw@mail.gmail.com>
 <DS7PR12MB6005078B67C8122627CAA45DFB7A2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_P0NJ7Vd1LBbECxf-1X-s3BOdYb0Q4FjEQe9TptjX_j9A@mail.gmail.com>
In-Reply-To: <CADnq5_P0NJ7Vd1LBbECxf-1X-s3BOdYb0Q4FjEQe9TptjX_j9A@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 25 Jan 2024 10:23:56 -0500
Message-ID: <CADnq5_PO-gnc72wRM+mUxtCnsmqE0ytFVbB=QkMQkEGkCQoQFg@mail.gmail.com>
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

On Thu, Jan 25, 2024 at 10:22=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Wed, Jan 24, 2024 at 9:39=E2=80=AFPM Liang, Prike <Prike.Liang@amd.com=
> wrote:
> >
> > [AMD Official Use Only - General]
> >
> > Hi, Alex
> > > -----Original Message-----
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: Wednesday, January 24, 2024 11:59 PM
> > > To: Liang, Prike <Prike.Liang@amd.com>
> > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Sharma, Deepak
> > > <Deepak.Sharma@amd.com>
> > > Subject: Re: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers=
 for
> > > PM abort case
> > >
> > > On Wed, Jan 24, 2024 at 2:12=E2=80=AFAM Prike Liang <Prike.Liang@amd.=
com> wrote:
> > > >
> > > > In the PM abort cases, the gfx power rail doesn't turn off so some
> > > > GFXDEC registers/CSB can't reset to default vaule. In order to avoi=
d
> > > > unexpected problem now need skip to program GFXDEC registers and
> > > > bypass issue CSB packet for PM abort case.
> > > >
> > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > ---
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
> > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
> > > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++++
> > > >  3 files changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > index c5f3859fd682..26d983eb831b 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > @@ -1079,6 +1079,7 @@ struct amdgpu_device {
> > > >         bool                            in_s3;
> > > >         bool                            in_s4;
> > > >         bool                            in_s0ix;
> > > > +       bool                            pm_complete;
> > > >
> > > >         enum pp_mp1_state               mp1_state;
> > > >         struct amdgpu_doorbell_index doorbell_index; diff --git
> > > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > index 475bd59c9ac2..a01f9b0c2f30 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > @@ -2486,6 +2486,7 @@ static int amdgpu_pmops_suspend_noirq(struct
> > > device *dev)
> > > >         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> > > >         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> > > >
> > > > +       adev->pm_complete =3D true;
> > >
> > > This needs to be cleared somewhere on resume.
> > [Liang, Prike]  This flag is designed to indicate the amdgpu device sus=
pension process status and will update the patch and clear it at the amdgpu=
 suspension beginning point.
> > >
> > > >         if (amdgpu_acpi_should_gpu_reset(adev))
> > > >                 return amdgpu_asic_reset(adev);
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > index 57808be6e3ec..3bf51f18e13c 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > @@ -3034,6 +3034,10 @@ static int gfx_v9_0_cp_gfx_start(struct
> > > > amdgpu_device *adev)
> > > >
> > > >         gfx_v9_0_cp_gfx_enable(adev, true);
> > > >
> > > > +       if (adev->in_suspend && !adev->pm_complete) {
> > > > +               DRM_INFO(" will skip the csb ring write\n");
> > > > +               return 0;
> > > > +       }
> > >
> > > We probably want a similar fix for other gfx generations as well.
> > >
> > > Alex
> > >
> > [Liang, Prike] IIRC, there's no issue on the Mendocino side even withou=
t the fix. How about keep the other gfx generations unchanged firstly and a=
fter sort out the failed case will add the quirk for each specific gfx resp=
ectively?
>
> Mendocino only supports S0i3 so we don't touch gfx on suspend/resume.
> This would only happen on platforms that support S3.

E.g., try an aborted suspend on Raphael or PHX2.

Alex

>
> Alex
>
> >
> > > >         r =3D amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) +=
 4 + 3);
> > > >         if (r) {
> > > >                 DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n",
> > > > r);
> > > > --
> > > > 2.34.1
> > > >
