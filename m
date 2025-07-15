Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53717C83F21
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jul 2025 13:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA23610E5BB;
	Tue, 15 Jul 2025 13:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lV5y1zhA";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 830B310E5BB
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 13:33:22 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-31384c8ba66so1055547a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jul 2025 06:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752586402; x=1753191202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=svl98VegtAcGMPlXycpRiaib1B3eIZ6+nkGleFDjMx8=;
 b=lV5y1zhAXs0PvcYS480Q1K4EmsL90VcpVK3k8ezaTea7Esw0L8Hb64p5WXxvf9tKDy
 txY1yndTUR8jRtupQndiSk8884UVbH3TofDiepy5gqwpgPr/2gk4sGe//G8EaNdilBzs
 tpjLwAKUdfAjXYFFTfJr1+E8Hys4dNidKUyRWXUi7QMGP2gMB0k+8WlSo1JZtn4NiSAD
 PkifSmdRuk2Zx2DIQ3HnQjHRaoLpgoK/fhyN4toLH7sPARLOo5BNn3uFUIyjxjXoIGk3
 wKBCDByBhZ/la/eMMiVxtWmt7i6tQSZs/BPMjVKMJVDdplbQO9EdKxip13aQdg9g3oDn
 X12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752586402; x=1753191202;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=svl98VegtAcGMPlXycpRiaib1B3eIZ6+nkGleFDjMx8=;
 b=nxnkjXPYWiVWioO9jdPNMLAIZrYXPxhRRs5ay2w4CsmVgg7tytsSgNJXbJiK7Z9mUl
 Y7af4bXspewiIz1QAFQBA8E0+g8Ch2h9+of+Z3rVT6WdmoKIf8IsExUai5Lidx5kKWq2
 hirhOLM22smBb3evwU1uXbgqV4ffaJ/hBCIqTd0FFk7MNJkgMteBm8KTTlP4c+BecFz4
 PGe7Xd/2mzWiCRt2S9XtA9Igwy/qHRQDKQO360R6B/s/uakG0QfzdwTNB6wrTcJeI6Uz
 ffnoBd4oxfbTxr9OuucQY4/DOMjcnGrDGyPoTexqt7W3gy64GRr/S0pXiZYxnCBsiy6J
 t0ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXNH7SNwKfNEBXXZba9gXrolAbr+o1aTgwkvEql8V/zQau8xURx/LGyHeBah+ae/TXA043s9z+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygqrkUvL1v/iEj5YKZzFZXccoXJRLeOgU08ghEAWLIwbNuOtJs
 m+REXdcIRJz1vqQZGd2XTmp8MESyvCpACGBSmW14h4xbmdPsSeRb2plqUcvzvLKY3auKK8JFU6g
 5M2AkccSjhNonHzRSe05W557aet3zV5Y=
X-Gm-Gg: ASbGncsOSeXVquivx7FrdOYffCjfdffG0GPZhGDiX7Re/GcxpJ7qU3PnkjFAxN8Gb/h
 wvQ6s9gqZzD6bUTAKrFGFwlN7qDBj3CjABjuRzBglBH2u7GBlIk7vutVK0gfRRvMkrm32+p2TPg
 G0gaFCjRKkeHqUGhBn02WG9uL26Ua/pnnVAquYeb5oDa/RD2cJEjDmIeOm6keu6VWxpS1Fs+dMV
 WD7Wmv/
X-Google-Smtp-Source: AGHT+IEX9NCpl+96WdwXQ3ckNHpLe9/k81P4QDCTAFOYOdVjL9pnboOESPPxqhhWvLmjA2wBQCMmUpZrEijV81+nIss=
X-Received: by 2002:a17:90b:1348:b0:310:8d54:3209 with SMTP id
 98e67ed59e1d1-31c94c81642mr1057640a91.2.1752586401679; Tue, 15 Jul 2025
 06:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250711224024.410506-1-alexander.deucher@amd.com>
 <20250711224024.410506-2-alexander.deucher@amd.com>
 <1af4e26d-d25d-439a-a9c4-abbad9ea3d50@amd.com>
In-Reply-To: <1af4e26d-d25d-439a-a9c4-abbad9ea3d50@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Jul 2025 09:33:10 -0400
X-Gm-Features: Ac12FXxbAVY6za7oF0Yuu2AKMAsRXx2ClpeGQojg7M3RjZFu6ChiWZI8eoeL0xc
Message-ID: <CADnq5_NcU2DhddSsHq8YfL80LTMKpRgL=3FD85d9RR8ygd+r1A@mail.gmail.com>
Subject: Re: [PATCH 01/33] drm/amdgpu: clean up sdma reset functions
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, sasundar@amd.com
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 14, 2025 at 10:00=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
> Since the series has supported_reset across different ip blocks, isn't
> it better to move this to amdgpu_ip_block? Or, if this needs to be
> specific to be different type of rings within an IP block, keep a
> supported_reset flag per ring to do something like -
>
> amdgpu_ring_is_reset_supported(ring, reset_type) and call
> amdgpu_ring_reset()?

Yeah, I was thinking about that as a further cleanup once this lands.

Alex

>
> Thanks,
> Lijo
>
>
> On 7/12/2025 4:09 AM, Alex Deucher wrote:
> > Make them consistent and drop unneeded extra variables.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 14 +++++++++++---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 17 +++++++++++++----
> >  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 20 ++++++++------------
> >  drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 20 ++++++++------------
> >  4 files changed, 40 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_0.c
> > index 5a1098bdd8256..999705e7b2641 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -1428,7 +1428,8 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
> >       case IP_VERSION(5, 0, 0):
> >       case IP_VERSION(5, 0, 2):
> >       case IP_VERSION(5, 0, 5):
> > -             if (adev->sdma.instance[0].fw_version >=3D 35)
> > +             if ((adev->sdma.instance[0].fw_version >=3D 35) &&
> > +                 !amdgpu_sriov_vf(adev))
> >                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
> >               break;
> >       default:
> > @@ -1544,11 +1545,18 @@ static int sdma_v5_0_reset_queue(struct amdgpu_=
ring *ring,
> >                                struct amdgpu_fence *timedout_fence)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     u32 inst_id =3D ring->me;
> >       int r;
> >
> > +     if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (ring->me >=3D adev->sdma.num_instances) {
> > +             dev_err(adev->dev, "sdma instance not found\n");
> > +             return -EINVAL;
> > +     }
> > +
> >       amdgpu_amdkfd_suspend(adev, true);
> > -     r =3D amdgpu_sdma_reset_engine(adev, inst_id, false);
> > +     r =3D amdgpu_sdma_reset_engine(adev, ring->me, false);
> >       amdgpu_amdkfd_resume(adev, true);
> >
> >       return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index 6843c2c3d71f5..e542195972dd4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -1347,11 +1347,13 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_b=
lock *ip_block)
> >       case IP_VERSION(5, 2, 2):
> >       case IP_VERSION(5, 2, 3):
> >       case IP_VERSION(5, 2, 4):
> > -             if (adev->sdma.instance[0].fw_version >=3D 76)
> > +             if ((adev->sdma.instance[0].fw_version >=3D 76) &&
> > +                 !amdgpu_sriov_vf(adev))
> >                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
> >               break;
> >       case IP_VERSION(5, 2, 5):
> > -             if (adev->sdma.instance[0].fw_version >=3D 34)
> > +             if ((adev->sdma.instance[0].fw_version >=3D 34) &&
> > +                 !amdgpu_sriov_vf(adev))
> >                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
> >               break;
> >       default:
> > @@ -1457,11 +1459,18 @@ static int sdma_v5_2_reset_queue(struct amdgpu_=
ring *ring,
> >                                struct amdgpu_fence *timedout_fence)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     u32 inst_id =3D ring->me;
> >       int r;
> >
> > +     if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> > +             return -EOPNOTSUPP;
> > +
> > +     if (ring->me >=3D adev->sdma.num_instances) {
> > +             dev_err(adev->dev, "sdma instance not found\n");
> > +             return -EINVAL;
> > +     }
> > +
> >       amdgpu_amdkfd_suspend(adev, true);
> > -     r =3D amdgpu_sdma_reset_engine(adev, inst_id, false);
> > +     r =3D amdgpu_sdma_reset_engine(adev, ring->me, false);
> >       amdgpu_amdkfd_resume(adev, true);
> >
> >       return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v6_0.c
> > index d2effa5318176..c08e9a6cf6827 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > @@ -1355,7 +1355,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
> >       case IP_VERSION(6, 0, 0):
> >       case IP_VERSION(6, 0, 2):
> >       case IP_VERSION(6, 0, 3):
> > -             if (adev->sdma.instance[0].fw_version >=3D 21)
> > +             if ((adev->sdma.instance[0].fw_version >=3D 21) &&
> > +                 !amdgpu_sriov_vf(adev))
> >                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE=
_PER_QUEUE;
> >               break;
> >       default:
> > @@ -1575,18 +1576,13 @@ static int sdma_v6_0_reset_queue(struct amdgpu_=
ring *ring,
> >                                struct amdgpu_fence *timedout_fence)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     int i, r;
> > -
> > -     if (amdgpu_sriov_vf(adev))
> > -             return -EINVAL;
> > +     int r;
> >
> > -     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > -             if (ring =3D=3D &adev->sdma.instance[i].ring)
> > -                     break;
> > -     }
> > +     if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> > +             return -EOPNOTSUPP;
> >
> > -     if (i =3D=3D adev->sdma.num_instances) {
> > -             DRM_ERROR("sdma instance not found\n");
> > +     if (ring->me >=3D adev->sdma.num_instances) {
> > +             dev_err(adev->dev, "sdma instance not found\n");
> >               return -EINVAL;
> >       }
> >
> > @@ -1596,7 +1592,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ri=
ng *ring,
> >       if (r)
> >               return r;
> >
> > -     r =3D sdma_v6_0_gfx_resume_instance(adev, i, true);
> > +     r =3D sdma_v6_0_gfx_resume_instance(adev, ring->me, true);
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v7_0.c
> > index 99a080bad2a3d..ba1f3e3b6eb61 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > @@ -807,18 +807,13 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ri=
ng *ring,
> >                                struct amdgpu_fence *timedout_fence)
> >  {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     int i, r;
> > -
> > -     if (amdgpu_sriov_vf(adev))
> > -             return -EINVAL;
> > +     int r;
> >
> > -     for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > -             if (ring =3D=3D &adev->sdma.instance[i].ring)
> > -                     break;
> > -     }
> > +     if (!(adev->sdma.supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE))
> > +             return -EOPNOTSUPP;
> >
> > -     if (i =3D=3D adev->sdma.num_instances) {
> > -             DRM_ERROR("sdma instance not found\n");
> > +     if (ring->me >=3D adev->sdma.num_instances) {
> > +             dev_err(adev->dev, "sdma instance not found\n");
> >               return -EINVAL;
> >       }
> >
> > @@ -828,7 +823,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring=
 *ring,
> >       if (r)
> >               return r;
> >
> > -     r =3D sdma_v7_0_gfx_resume_instance(adev, i, true);
> > +     r =3D sdma_v7_0_gfx_resume_instance(adev, ring->me, true);
> >       if (r)
> >               return r;
> >       amdgpu_fence_driver_force_completion(ring);
> > @@ -1346,7 +1341,8 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
> >
> >       adev->sdma.supported_reset =3D
> >               amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].r=
ing);
> > -     adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUEUE;
> > +     if (!amdgpu_sriov_vf(adev))
> > +             adev->sdma.supported_reset |=3D AMDGPU_RESET_TYPE_PER_QUE=
UE;
> >
> >       r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
> >       if (r)
>
