Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F478C77B7D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 15:10:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3BCB10E200;
	Mon, 15 May 2023 15:10:26 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9683910E200
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 15:10:23 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-19619af9a02so6202555fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 08:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684163422; x=1686755422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfsBP4UXQSOECrk2rYsi6hgfCYkdx6kK1D/6AJjc9W0=;
 b=bh2e/D6cNfITx5EywWtvC52rrbLW8fCLLjOT/0rCTI2+D27jwBHQ6oCsrmr9Ng2oti
 tIMBMcxcHSqmXK25wZ3k2ppmXCD/L/9xrYCzvfRfm2iq09BdDc9F+0ooy/W/jzHUIQJd
 qKCD2lkSdOYlFzLfdiCe2UHIho4mABuxejCZZjiXRgwSldRjNM/YBV0FZEFcG/C0T5Uz
 z+YgsoKjsabLR2Y0s56TTb16i5seqcd4iAhmH+sNwvFGp52gqEhZBwXyuZMeU09+AvjY
 T5g+rG589iveNF0a5EV2TqBfNWFO2zRyzlFwOqGhbkigASP8kX8ZfS07UbyzyUV0KP9X
 fwrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684163422; x=1686755422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfsBP4UXQSOECrk2rYsi6hgfCYkdx6kK1D/6AJjc9W0=;
 b=j2UPuXpTukXLl6LMTNsHyf9k+4jaH17qlXz8k/9owWLFvVRW4n3oq2gb6fITx0ynXL
 RwGrmBpwyuWHyiUtTZJBAiXP8Yi1JcLPsHJxsSYpbdvZltAkMugRWsMdJWLDaJdEJ8Mc
 BJl6FI2/Hd6JvGipIY0tJPbSFe6so6FLfqOSf2454O3nANrRWBLyVBng5kQA7t+INUBy
 /GKpYNtGhYwLM3jLYMr1l1FYTMIcWEP64i4ueEROTeIwbbbQew8KeVD2jy2ReGB582tn
 f8sNMVlC1KR4GLkGRzJNl2yyQ5L/1CIYZ4hyTXcYiDp7V3W4G5S/6i9LsF8EPlCLpKvK
 QqKQ==
X-Gm-Message-State: AC+VfDxAUlPyfc+p4bpuMvTR5beNUc1tAZoVEQfev7NR8W+6JFW2q0OF
 Y9lOGHlcCtyb7GVLbDjZr2muWwnhv2B157Qg1Z0=
X-Google-Smtp-Source: ACHHUZ7PEMwqijm5fMTO29j3UFMKZaa7VKtiULp3bpayXyvnxofF2xpI+etiOnI+qx+glF14Ov2XqT7xKXfh5UZSJwY=
X-Received: by 2002:a4a:271a:0:b0:546:133:3d1c with SMTP id
 l26-20020a4a271a000000b0054601333d1cmr8773098oof.3.1684163422111; Mon, 15 May
 2023 08:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230512081547.1006052-1-Jack.Xiao@amd.com>
 <CADnq5_PGQG4vu+DBUmMZwK=A-v1AgTemy1Z15=GSqep5_ymvgA@mail.gmail.com>
 <MW3PR12MB4458CDFA10A935321578EDD3EF789@MW3PR12MB4458.namprd12.prod.outlook.com>
 <CADnq5_OwHvVQxagweThnFtEL8xUnsC_hx2dfhWsgv+QLcvP9GA@mail.gmail.com>
 <MW3PR12MB4458EB9366C0DF9474593E30EF789@MW3PR12MB4458.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB4458EB9366C0DF9474593E30EF789@MW3PR12MB4458.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 May 2023 11:10:10 -0400
Message-ID: <CADnq5_Pc9yMet=PBnqdY95=PmvP47CpaU6aZ3GHq3Q+HUvf4dQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix S3 issue if MQD in VRAM
To: "Xiao, Jack" <Jack.Xiao@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 15, 2023 at 11:02=E2=80=AFAM Xiao, Jack <Jack.Xiao@amd.com> wro=
te:
>
> [AMD Official Use Only - General]
>
>
> Yes, it should work. If that, the routine would behave like *reset*. That=
 means driver would behave like to create a new queue instead of restoring =
a saved queue. I can have a try with this solution.
>

I think it should work as is.  At least suspend/resume worked when I
tested it.  The logic in gfx_v11_0_gfx_init_queue() is:

if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
    ...
    // Save the original image after init at driver load time
    memcpy(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
} else {
    // restore the saved image at resume or reset time
    memcpy(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
    ...
}

Alex

> Regards,
> Jack
> ________________________________
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Monday, 15 May 2023 21:08
> To: Xiao, Jack <Jack.Xiao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deuche=
r, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix S3 issue if MQD in VRAM
>
> On Mon, May 15, 2023 at 6:40=E2=80=AFAM Xiao, Jack <Jack.Xiao@amd.com> wr=
ote:
> >
> > [AMD Official Use Only - General]
> >
> > The MQD data in VRAM would be lost after S3,  for the MQD bo is pinned =
down as kernel bo and can't be evicted to system memory.
> > AFAIK, driver should not to do allocate/free memory during S3, as there=
 are issues observed to do memory allocation during S3.
>
> We restore the contents of the MQD in gfx_v*_0_gfx_init_queue() and
> gfx_v*_0_kcq_init_queue().
>
> Alex
>
> >
> > Regards,
> > Jack
> >
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Friday, May 12, 2023 9:13 PM
> > To: Xiao, Jack <Jack.Xiao@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deuche=
r@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: fix S3 issue if MQD in VRAM
> >
> > On Fri, May 12, 2023 at 4:16=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> w=
rote:
> > >
> > > Make the preemption optimization effect only for SRIOV, for it caused
> > > failure to resume from S3.
> >
> > Can you elaborate?  We ultimately want MQDs in VRAM for performance rea=
sons even for bare metal.
> >
> > Alex
> >
> > >
> > > Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
> > > drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 7 +++++--
> > > drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 7 +++++--
> > >  3 files changed, 12 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > index a22d88a4178a..1b795b7bbf38 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > > @@ -385,7 +385,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *=
adev,
> > >         u32 domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > >
> > >         /* Only enable on gfx10 and 11 for now to avoid changing beha=
vior on older chips */
> > > -       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 0, 0))
> > > +       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 0, 0) &=
&
> > > +           amdgpu_sriov_vf(adev))
> > >                 domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
> > >
> > >         /* create MQD for KIQ */
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> > > b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> > > index 4560476c7c31..5c3d3f6c7ebd 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> > > @@ -889,6 +889,7 @@ static int mes_v10_1_mqd_sw_init(struct
> > > amdgpu_device *adev,  {
> > >         int r, mqd_size =3D sizeof(struct v10_compute_mqd);
> > >         struct amdgpu_ring *ring;
> > > +       u32 domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > >
> > >         if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
> > >                 ring =3D &adev->gfx.kiq[0].ring; @@ -900,9 +901,11 @@
> > > static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
> > >         if (ring->mqd_obj)
> > >                 return 0;
> > >
> > > +       if (amdgpu_sriov_vf(adev))
> > > +               domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
> > > +
> > >         r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> > > -                                   AMDGPU_GEM_DOMAIN_VRAM |
> > > -                                   AMDGPU_GEM_DOMAIN_GTT, &ring->mqd=
_obj,
> > > +                                   domain, &ring->mqd_obj,
> > >                                     &ring->mqd_gpu_addr, &ring->mqd_p=
tr);
> > >         if (r) {
> > >                 dev_warn(adev->dev, "failed to create ring mqd bo
> > > (%d)", r); diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > > index 3adb450eec07..79a4d2bfd94a 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > > @@ -987,6 +987,7 @@ static int mes_v11_0_mqd_sw_init(struct
> > > amdgpu_device *adev,  {
> > >         int r, mqd_size =3D sizeof(struct v11_compute_mqd);
> > >         struct amdgpu_ring *ring;
> > > +       u32 domain =3D AMDGPU_GEM_DOMAIN_GTT;
> > >
> > >         if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
> > >                 ring =3D &adev->gfx.kiq[0].ring; @@ -998,9 +999,11 @@
> > > static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
> > >         if (ring->mqd_obj)
> > >                 return 0;
> > >
> > > +       if (amdgpu_sriov_vf(adev))
> > > +               domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
> > > +
> > >         r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> > > -                                   AMDGPU_GEM_DOMAIN_VRAM |
> > > -                                   AMDGPU_GEM_DOMAIN_GTT, &ring->mqd=
_obj,
> > > +                                   domain, &ring->mqd_obj,
> > >                                     &ring->mqd_gpu_addr, &ring->mqd_p=
tr);
> > >         if (r) {
> > >                 dev_warn(adev->dev, "failed to create ring mqd bo
> > > (%d)", r);
> > > --
> > > 2.37.3
> > >
