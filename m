Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC688C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 15 May 2023 13:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E3410E1CF;
	Mon, 15 May 2023 13:08:30 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D778A10E1CD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 13:08:27 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-38e3228d120so6704985b6e.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 May 2023 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684156107; x=1686748107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD3IVNkiuZAui0XmfM/LlEo+/DIOt4jWPj9uvPAT0f8=;
 b=Qt9aAJnfJto+HKoPYB5cnpNZREktFW8aZ9LzgCGqO/w/V5hilUVvlq4hWGmPyXyNTb
 wcUk06TvyaSxgKvrtiqPfkidHVQHu9ARaxXai2q4wetWSLumS9ZxpBwbIswdclZ1l04f
 LdycWGOQCH8zT+HREt8Lts8kJuYaQJNB76Oeilgx78nUIRKdrh0y1QSc1Ed9fzS1LpZF
 W3eQ5Gb8fY1nwzOMio2/SdL4P3gaFiWt5MfdcEvw4RgFN5rd7D0kGQkp5Lxn4ZIQCo0D
 8rLLc7/q6M6Dz/8tYOOPt7irM4UIXAUEqx3xSb2S+St4KR6SZA8+byUIAUjmRPR+WAhy
 oqIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684156107; x=1686748107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cD3IVNkiuZAui0XmfM/LlEo+/DIOt4jWPj9uvPAT0f8=;
 b=UTb8oq/j2whT24uaSzgQZJwbgcu0XVySHqWH+xp1OCd7SJMjJyIxBrwb/1fC/Io83E
 GW4tvd7Ab6eyBDdfLUvkfIYc5z8z63Psk5RBMxR6RVLv2m68pPqL4GOu5xHMx8yUKt77
 p0EjCW4csyuuidLgeVRgg+Boe5eicWDricO4pHyO/0CeU2uNAyooOwNHfdZu2cXi5953
 DAuiYzQshMGpBH2deBgfntsGjRBQY6iXd4MhIQdmQ09NB/fx5FLjKcEwnRJGMg5my65E
 6T5Ta0K/mLNWXxEtzO8cSgJxPKAC+I7tOqxkOu7SP7FfcUrZHiT1jmf4sCqHxe8+xZBD
 MnLA==
X-Gm-Message-State: AC+VfDzZ6DJmkJptIdKQ67CwYTd93CQpmLxTuSYMPdVBbuPZcLKgTtCV
 BoAJ7YrAXPJcf54HtBy3Umldc6q/TW9gGZI2B2s=
X-Google-Smtp-Source: ACHHUZ7ifD8jh6F2jj/FS7+gEAZSbALQ72TKNgMVVWNU4zHVwo1bFjZ2Muo+t1Cle5hnGf0o5AKz9fFbQOnuDJMRzOY=
X-Received: by 2002:a05:6808:10b:b0:38d:ee6e:235d with SMTP id
 b11-20020a056808010b00b0038dee6e235dmr10882832oie.22.1684156106613; Mon, 15
 May 2023 06:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230512081547.1006052-1-Jack.Xiao@amd.com>
 <CADnq5_PGQG4vu+DBUmMZwK=A-v1AgTemy1Z15=GSqep5_ymvgA@mail.gmail.com>
 <MW3PR12MB4458CDFA10A935321578EDD3EF789@MW3PR12MB4458.namprd12.prod.outlook.com>
In-Reply-To: <MW3PR12MB4458CDFA10A935321578EDD3EF789@MW3PR12MB4458.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 May 2023 09:08:15 -0400
Message-ID: <CADnq5_OwHvVQxagweThnFtEL8xUnsC_hx2dfhWsgv+QLcvP9GA@mail.gmail.com>
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

On Mon, May 15, 2023 at 6:40=E2=80=AFAM Xiao, Jack <Jack.Xiao@amd.com> wrot=
e:
>
> [AMD Official Use Only - General]
>
> The MQD data in VRAM would be lost after S3,  for the MQD bo is pinned do=
wn as kernel bo and can't be evicted to system memory.
> AFAIK, driver should not to do allocate/free memory during S3, as there a=
re issues observed to do memory allocation during S3.

We restore the contents of the MQD in gfx_v*_0_gfx_init_queue() and
gfx_v*_0_kcq_init_queue().

Alex

>
> Regards,
> Jack
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, May 12, 2023 9:13 PM
> To: Xiao, Jack <Jack.Xiao@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@=
amd.com>
> Subject: Re: [PATCH] drm/amdgpu: fix S3 issue if MQD in VRAM
>
> On Fri, May 12, 2023 at 4:16=E2=80=AFAM Jack Xiao <Jack.Xiao@amd.com> wro=
te:
> >
> > Make the preemption optimization effect only for SRIOV, for it caused
> > failure to resume from S3.
>
> Can you elaborate?  We ultimately want MQDs in VRAM for performance reaso=
ns even for bare metal.
>
> Alex
>
> >
> > Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 3 ++-
> > drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 7 +++++--
> > drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 7 +++++--
> >  3 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > index a22d88a4178a..1b795b7bbf38 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -385,7 +385,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ad=
ev,
> >         u32 domain =3D AMDGPU_GEM_DOMAIN_GTT;
> >
> >         /* Only enable on gfx10 and 11 for now to avoid changing behavi=
or on older chips */
> > -       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 0, 0))
> > +       if (adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION(10, 0, 0) &&
> > +           amdgpu_sriov_vf(adev))
> >                 domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
> >
> >         /* create MQD for KIQ */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> > index 4560476c7c31..5c3d3f6c7ebd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> > @@ -889,6 +889,7 @@ static int mes_v10_1_mqd_sw_init(struct
> > amdgpu_device *adev,  {
> >         int r, mqd_size =3D sizeof(struct v10_compute_mqd);
> >         struct amdgpu_ring *ring;
> > +       u32 domain =3D AMDGPU_GEM_DOMAIN_GTT;
> >
> >         if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
> >                 ring =3D &adev->gfx.kiq[0].ring; @@ -900,9 +901,11 @@
> > static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
> >         if (ring->mqd_obj)
> >                 return 0;
> >
> > +       if (amdgpu_sriov_vf(adev))
> > +               domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
> > +
> >         r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> > -                                   AMDGPU_GEM_DOMAIN_VRAM |
> > -                                   AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_o=
bj,
> > +                                   domain, &ring->mqd_obj,
> >                                     &ring->mqd_gpu_addr, &ring->mqd_ptr=
);
> >         if (r) {
> >                 dev_warn(adev->dev, "failed to create ring mqd bo
> > (%d)", r); diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > index 3adb450eec07..79a4d2bfd94a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > @@ -987,6 +987,7 @@ static int mes_v11_0_mqd_sw_init(struct
> > amdgpu_device *adev,  {
> >         int r, mqd_size =3D sizeof(struct v11_compute_mqd);
> >         struct amdgpu_ring *ring;
> > +       u32 domain =3D AMDGPU_GEM_DOMAIN_GTT;
> >
> >         if (pipe =3D=3D AMDGPU_MES_KIQ_PIPE)
> >                 ring =3D &adev->gfx.kiq[0].ring; @@ -998,9 +999,11 @@
> > static int mes_v11_0_mqd_sw_init(struct amdgpu_device *adev,
> >         if (ring->mqd_obj)
> >                 return 0;
> >
> > +       if (amdgpu_sriov_vf(adev))
> > +               domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
> > +
> >         r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> > -                                   AMDGPU_GEM_DOMAIN_VRAM |
> > -                                   AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_o=
bj,
> > +                                   domain, &ring->mqd_obj,
> >                                     &ring->mqd_gpu_addr, &ring->mqd_ptr=
);
> >         if (r) {
> >                 dev_warn(adev->dev, "failed to create ring mqd bo
> > (%d)", r);
> > --
> > 2.37.3
> >
