Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3830C47DB3
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 15:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7175711298E;
	Mon, 29 Jan 2024 15:29:56 +0000 (UTC)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com
 [209.85.160.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEE3B112998
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 15:29:54 +0000 (UTC)
Received: by mail-oa1-f52.google.com with SMTP id
 586e51a60fabf-204f50f305cso2177823fac.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706542134; x=1707146934; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4vCps91/mXe/PA6AvkvfdbW4Ny3SIzLscBJdBTmjDJI=;
 b=J1jIfHr6x1GIEQ1AcGDFaUP9xh7EtpFTkk5Ytl4ipYw9ewUlJv4VtYsrrj080mzZ8E
 Jp6FewgHotogPjh0Rz+5hH5ZgsxmM+04fud4V2BEN75vQHlGtcXFudUjmJzKzKn2AosQ
 ySWv4gQvQxC+/5a8Cjj08YwPU3x77we+D9I6wbPi4okQyS+V0zKDA2Zdv5Ui4R6N5poi
 SIJxFN2pmD76sbzr6WZhcKmVH97Q6+2kp/xWU89LdHrtLS6RiIiWfTUWIjTQZkqFPCDO
 Dc4Nt06gHJ55/lbzFvsqrr4Vp59LfcU+dwvdqS5vxwVDYuog3bO5ZvjgIF9beAaiugWL
 wbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706542134; x=1707146934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4vCps91/mXe/PA6AvkvfdbW4Ny3SIzLscBJdBTmjDJI=;
 b=ZpB8sLKjJPTWtABGRcD6O9RADEa2C8SMrGjqe55Tq+fOJ4s5TacsgRTGqeLOcJASdD
 6Ql0VbRMmhc3NVs6EyqGMPIoNA8aHgel/I5+2V8AOMaF5KPIyohYm+6gVbB7hGphAWJ6
 NRIr0/CjxeuTTpHIkEJVg8gPm/Tihjv7/K/+astbKye3CSPTfAyMP0w8YI/pDGtBLMnO
 hOvhs3jsBVmY+Skr118fjlVCXn/gbzZa/7ZN9aXpDhMpDis72CNYZncziSuizOiqPiGO
 ea9POixPqp/Y9z6aU4dxtMEFRgYryz3tqAsq3yhSXr88vIph5bSVRxMIaHJ8J9fPFFyT
 bXyg==
X-Gm-Message-State: AOJu0Yx+cKAJaRIsHT6D31XzkhW2QcBbGokQCQz6n9KLjcFjzFd2yzbP
 3bIKU/8KUX0ZuyUDu8m8zzdn9PKPAu2StSOe8x6lMOOrTMoFk28sTUdkiY77esVcL9BdRTbxLOM
 TMs7c3OU5s3qAKXgT3lmh73Vzh7I=
X-Google-Smtp-Source: AGHT+IG4QV9UIdczLlHCDA1+kTbgD+VbgJXZ8YoVamBfFl1mAs1JsV6ZlNQ8vZAG6JhMXxR3VIlLcKmAqgHxs7cWVfw=
X-Received: by 2002:a05:6870:b49f:b0:218:6cec:cf17 with SMTP id
 y31-20020a056870b49f00b002186ceccf17mr4253434oap.10.1706542134179; Mon, 29
 Jan 2024 07:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20240124065932.892944-1-Prike.Liang@amd.com>
 <CADnq5_PJyh50wpHQuU_UFYvpnnp8PsteAJ7ymazFHMWD92cyDw@mail.gmail.com>
 <DS7PR12MB6005078B67C8122627CAA45DFB7A2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CADnq5_P0NJ7Vd1LBbECxf-1X-s3BOdYb0Q4FjEQe9TptjX_j9A@mail.gmail.com>
 <CADnq5_PO-gnc72wRM+mUxtCnsmqE0ytFVbB=QkMQkEGkCQoQFg@mail.gmail.com>
 <DS7PR12MB6005C4B4C4ECE48DB61418FBFB792@DS7PR12MB6005.namprd12.prod.outlook.com>
 <DS7PR12MB6005009D906D1E0FA821F23FFB7E2@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005009D906D1E0FA821F23FFB7E2@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 29 Jan 2024 10:28:42 -0500
Message-ID: <CADnq5_OXaGU9poRfJVJbD9u0G4pJ4NepC6KRFbPXmxkrLXf+TA@mail.gmail.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Tim" <Tim.Huang@amd.com>, "Zhang, Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Sharma,
 Deepak" <Deepak.Sharma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jan 29, 2024 at 3:35=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [AMD Official Use Only - General]
>
> > Sent: Friday, January 26, 2024 9:43 AM
> > To: Alex Deucher <alexdeucher@gmail.com>
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Sharma, Deepak
> > <Deepak.Sharma@amd.com>; amd-gfx@lists.freedesktop.org
> > Subject: RE: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers f=
or
> > PM abort case
> >
> > [AMD Official Use Only - General]
> >
> > [AMD Official Use Only - General]
> >
> > > From: Alex Deucher <alexdeucher@gmail.com>
> > > Sent: Thursday, January 25, 2024 11:24 PM
> > > To: Liang, Prike <Prike.Liang@amd.com>
> > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > <Alexander.Deucher@amd.com>; Sharma, Deepak
> > <Deepak.Sharma@amd.com>
> > > Subject: Re: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC registers
> > > for PM abort case
> > >
> > > On Thu, Jan 25, 2024 at 10:22=E2=80=AFAM Alex Deucher <alexdeucher@gm=
ail.com>
> > > wrote:
> > > >
> > > > On Wed, Jan 24, 2024 at 9:39=E2=80=AFPM Liang, Prike <Prike.Liang@a=
md.com>
> > > wrote:
> > > > >
> > > > > [AMD Official Use Only - General]
> > > > >
> > > > > Hi, Alex
> > > > > > -----Original Message-----
> > > > > > From: Alex Deucher <alexdeucher@gmail.com>
> > > > > > Sent: Wednesday, January 24, 2024 11:59 PM
> > > > > > To: Liang, Prike <Prike.Liang@amd.com>
> > > > > > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > > > > > <Alexander.Deucher@amd.com>; Sharma, Deepak
> > > > > > <Deepak.Sharma@amd.com>
> > > > > > Subject: Re: [PATCH 1/2] drm/amdgpu: skip to program GFXDEC
> > > > > > registers for PM abort case
> > > > > >
> > > > > > On Wed, Jan 24, 2024 at 2:12=E2=80=AFAM Prike Liang
> > > > > > <Prike.Liang@amd.com>
> > > wrote:
> > > > > > >
> > > > > > > In the PM abort cases, the gfx power rail doesn't turn off so
> > > > > > > some GFXDEC registers/CSB can't reset to default vaule. In
> > > > > > > order to avoid unexpected problem now need skip to program
> > > > > > > GFXDEC registers and bypass issue CSB packet for PM abort cas=
e.
> > > > > > >
> > > > > > > Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
> > > > > > >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
> > > > > > >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++++
> > > > > > >  3 files changed, 6 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > > > > index c5f3859fd682..26d983eb831b 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > > > > > > @@ -1079,6 +1079,7 @@ struct amdgpu_device {
> > > > > > >         bool                            in_s3;
> > > > > > >         bool                            in_s4;
> > > > > > >         bool                            in_s0ix;
> > > > > > > +       bool                            pm_complete;
> > > > > > >
> > > > > > >         enum pp_mp1_state               mp1_state;
> > > > > > >         struct amdgpu_doorbell_index doorbell_index; diff
> > > > > > > --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > > > > index 475bd59c9ac2..a01f9b0c2f30 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > > > > > > @@ -2486,6 +2486,7 @@ static int
> > > > > > > amdgpu_pmops_suspend_noirq(struct
> > > > > > device *dev)
> > > > > > >         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> > > > > > >         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> > > > > > >
> > > > > > > +       adev->pm_complete =3D true;
> > > > > >
> > > > > > This needs to be cleared somewhere on resume.
> > > > > [Liang, Prike]  This flag is designed to indicate the amdgpu
> > > > > device
> > > suspension process status and will update the patch and clear it at
> > > the amdgpu suspension beginning point.
> > > > > >
> > > > > > >         if (amdgpu_acpi_should_gpu_reset(adev))
> > > > > > >                 return amdgpu_asic_reset(adev);
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > > > index 57808be6e3ec..3bf51f18e13c 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > > > > > > @@ -3034,6 +3034,10 @@ static int gfx_v9_0_cp_gfx_start(struc=
t
> > > > > > > amdgpu_device *adev)
> > > > > > >
> > > > > > >         gfx_v9_0_cp_gfx_enable(adev, true);
> > > > > > >
> > > > > > > +       if (adev->in_suspend && !adev->pm_complete) {
> > > > > > > +               DRM_INFO(" will skip the csb ring write\n");
> > > > > > > +               return 0;
> > > > > > > +       }
> > > > > >
> > > > > > We probably want a similar fix for other gfx generations as wel=
l.
> > > > > >
> > > > > > Alex
> > > > > >
> > > > > [Liang, Prike] IIRC, there's no issue on the Mendocino side even
> > > > > without
> > > the fix. How about keep the other gfx generations unchanged firstly
> > > and after sort out the failed case will add the quirk for each specif=
ic gfx
> > respectively?
> > > >
> > > > Mendocino only supports S0i3 so we don't touch gfx on suspend/resum=
e.
> > > > This would only happen on platforms that support S3.
> > >
> > > E.g., try an aborted suspend on Raphael or PHX2.
> > >
> > > Alex
> > >
> > [Liang, Prike]  Thanks for the reminder, but the Mendocino also was ver=
ified
> > on the system with S3 enabled from BIOS. I will double confirm if there=
 need
> > the quirk on the RPL or PHX2.
> >
> [Prike]  According to @Zhang, Jesse(Jie) and @Huang, Tim further confirm =
there's no such problem on the RPL and PHX, so we may only need apply this =
quirk on some specific gfx9 series.

Great.  Thanks!

Alex

> > > >
> > > > Alex
> > > >
> > > > >
> > > > > > >         r =3D amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(a=
dev) + 4 +
> > 3);
> > > > > > >         if (r) {
> > > > > > >                 DRM_ERROR("amdgpu: cp failed to lock ring
> > > > > > > (%d).\n", r);
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > >
