Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C3EC77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 13:27:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5169510E5CD;
	Fri, 28 Apr 2023 13:27:11 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC2E010E3C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 13:27:08 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-38e692c0930so5379397b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 06:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682688427; x=1685280427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZpnhYWyxwVilh+TGxovERMhh3gORck3joVLw1mNuz44=;
 b=AAHF3sIi+t9x2an0khyhtqWizcqdYmiPnmNO7OSztgq81C6Az/vs6Hb+2lT6cwoHcF
 jn8cpxpuuMg093qLceWqTyspDaTotxq71zQ+0EO6+sI+4S6N0jdaAG3WTgypOWEraSrT
 rYCbUbCBpCZzeru2ytXKSynuLsan5Zr/GHXz/ZcOeTZvN66NL0cTyBEp8lP0MXMB+xRP
 axwAnWhTs/813B2yO08UN7bbMxSnlpv7DgO7/sZZKhXNP2L/zLj3GOPSPjrDhl0JIkGy
 l9K90F8Awcg8z2CJXrLd5FRjK5/YC2j6DXmn9YKziHs6d3pAFZ8Ls+eO73hI9JpCcNpq
 OLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682688427; x=1685280427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZpnhYWyxwVilh+TGxovERMhh3gORck3joVLw1mNuz44=;
 b=bIgc8O2D4ROsrT9v+q0Pb3B5Ojths5bm/0JF52/YSKyDWUb6oJZchNpE9LqVD0aN1A
 sjRXQivkBVdeVblO5keI8jY1xCMSDKTet4ej5OnzfNYKh/UnNugpROS+R5cYrcaVrjs5
 P6i4P11G2V6kpLZElDry+ehZ4h80tocivNssCZlxJM0QFYDdh+xdG8efKwDyQpgaQ25N
 VLX0omM9dSZpmrSEQRhmWeqwv/e6HtfTTyvO2G72QTfLc+JnEBqi2m7rq1b11f5aplQR
 0H7stdyZytUIj0lcyF7grFSw2yzBO19x1EK32NM8/4l2mtqm0+JtWOR9IlXK5rLF2dPD
 33kg==
X-Gm-Message-State: AC+VfDy+w17NlnvDv9pCxp+u9FY06lEuy7ORdbS4Q0BrZ9rxruNhm9uA
 A221LkzUTzQakgExG7Ds3k/XXIcr1JMM/CATW42nZnCa
X-Google-Smtp-Source: ACHHUZ4itO6IHjXYZmWhD3tbddHmsW0dYNgG64XIa3dQ8ewHCdSQ79tvJgSL61nXeihnZVI1Ub2LQ7P5Xj3QznZRSd8=
X-Received: by 2002:aca:d08:0:b0:38e:f608:19b8 with SMTP id
 8-20020aca0d08000000b0038ef60819b8mr2513624oin.12.1682688427579; Fri, 28 Apr
 2023 06:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230427152709.7612-1-alexander.deucher@amd.com>
 <20230427152709.7612-12-alexander.deucher@amd.com>
 <ad808403-99ac-85e7-769d-d24eb835ab19@gmail.com>
In-Reply-To: <ad808403-99ac-85e7-769d-d24eb835ab19@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Apr 2023 09:26:56 -0400
Message-ID: <CADnq5_PG-zF+7qDOtcdOtti2hFNZgO7n6wazyEe70PwtJeBC2w@mail.gmail.com>
Subject: Re: [PATCH 12/12] drm/amdgpu: put MQDs in VRAM
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 28, 2023 at 5:03=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 27.04.23 um 17:27 schrieb Alex Deucher:
> > Reduces preemption latency.
> >
> > v2: move MES MQDs into VRAM as well (YuBiao)
> > v3: enable on gfx10, 11 only (Alex)
>
> The why we do that not for gfx9 is missing.

We could do it for gfx8-11.  That said, gfx8 and 9 are working fine
and there's no reasons to change them at this point.  Less chance for
regressions.  I'll update the commit message.

>
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++++
> >   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 1 +
> >   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 1 +
> >   3 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 0560568b3925..92c5f0ce8bbb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -382,6 +382,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ad=
ev,
> >       int r, i;
> >       struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[xcc_id];
> >       struct amdgpu_ring *ring =3D &kiq->ring;
> > +     u32 domain_vram =3D adev->ip_versions[GC_HWIP][0] >=3D IP_VERSION=
(10, 0, 0) ?
> > +             AMDGPU_GEM_DOMAIN_VRAM : 0;
>
> Maybe cleaner to do something like:
>
>      domain =3D AMDGPU_GEM_DOMAIN_GTT;
>      if (...)
>          domain |=3D AMDGPU_GEM_DOMAIN_VRAM;
>

I can fix that up.

Thanks,

Alex

> Christian.
>
> >
> >       /* create MQD for KIQ */
> >       if (!adev->enable_mes_kiq && !ring->mqd_obj) {
> > @@ -413,6 +415,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ad=
ev,
> >                       ring =3D &adev->gfx.gfx_ring[i];
> >                       if (!ring->mqd_obj) {
> >                               r =3D amdgpu_bo_create_kernel(adev, mqd_s=
ize, PAGE_SIZE,
> > +                                                         domain_vram |
> >                                                           AMDGPU_GEM_DO=
MAIN_GTT, &ring->mqd_obj,
> >                                                           &ring->mqd_gp=
u_addr, &ring->mqd_ptr);
> >                               if (r) {
> > @@ -434,6 +437,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *ad=
ev,
> >               ring =3D &adev->gfx.compute_ring[i + xcc_id * adev->gfx.n=
um_compute_rings];
> >               if (!ring->mqd_obj) {
> >                       r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAG=
E_SIZE,
> > +                                                 domain_vram |
> >                                                   AMDGPU_GEM_DOMAIN_GTT=
, &ring->mqd_obj,
> >                                                   &ring->mqd_gpu_addr, =
&ring->mqd_ptr);
> >                       if (r) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/a=
md/amdgpu/mes_v10_1.c
> > index 0599f8a6813e..4560476c7c31 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> > @@ -901,6 +901,7 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_devi=
ce *adev,
> >               return 0;
> >
> >       r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> > +                                 AMDGPU_GEM_DOMAIN_VRAM |
> >                                   AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj=
,
> >                                   &ring->mqd_gpu_addr, &ring->mqd_ptr);
> >       if (r) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/mes_v11_0.c
> > index e853bcb892fc..3adb450eec07 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > @@ -999,6 +999,7 @@ static int mes_v11_0_mqd_sw_init(struct amdgpu_devi=
ce *adev,
> >               return 0;
> >
> >       r =3D amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
> > +                                 AMDGPU_GEM_DOMAIN_VRAM |
> >                                   AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj=
,
> >                                   &ring->mqd_gpu_addr, &ring->mqd_ptr);
> >       if (r) {
>
