Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31042EC1EBE
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 14:21:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6CB310E8E1;
	Thu,  5 Feb 2026 14:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="InisudPu";
	dkim-atps=neutral
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C5E510E8DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 14:21:08 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2b7267ff06fso85607eec.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Feb 2026 06:21:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770301268; cv=none;
 d=google.com; s=arc-20240605;
 b=Hv0lnYi/I2r0Osa9FZdLTDiWaIhBJH0WPE4G8/1gvq6jQygJBOa6YoEuHZUJEIEBHe
 xtyqLyatenfNRJ5LXsj9t9S37yG6yvc2onP2trpd2SEi7pp4lKiDWOB0ezJO0lFOGJCK
 2dtDZYG7oF2arkgkowlb0ZNbd+o7+r4yICQP6PV67MYUf5h6BAd1j4iJs5US4P+VOhsP
 AB2ulYYqHt91xzjfwfCMSy70x3Hu7x1vuTdn9TUp87OB6FsRg1pug/Tm1a6+GVSpY5w3
 MoN4lg6E0O5OkPl8c+jI2Mlm54NihSJMY92IyDPvNZQJbMT8WFQti/27GE88nhedE79/
 ZKpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=f66aKlJ5ZOAt0NrhG36U7Y42CvuFe3mBWlOMAIGlyEQ=;
 fh=Nc/5i4nn57SasrgZIrd9HJvoaw/zQ967rxMFClgIhUk=;
 b=lojHgrlUshVSC3geGgiVLhrwMuVUGN7Qo92LSLiWqMLpuk0pG1m0sIEgcaqtYu/TWa
 nHh5mTtA91CyfMkvvQN09tzxnspqjHBXyQ3BUMEZ3vwuAkYrNtd3aWyXzEKrdcwRs/AD
 umCYef6Lx0kbWNiSiBmcyTvKhktQ2pZQVb6oO3u8+pGObR62ozludHIRuYqrdyuHvgH+
 NGlE4qzhiOXve3Id1q0jXOHvlWydVZAkZ/snSIkpRnKXdq/wD4deyuzTMpOEKJEMYYsc
 p+X8xWbWRSA8D9nU2avb80gq3EWiZfIUyZZt6D1Pna7yt1riLXmeNFNPOeCT2da8RU1P
 2UCg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770301268; x=1770906068; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f66aKlJ5ZOAt0NrhG36U7Y42CvuFe3mBWlOMAIGlyEQ=;
 b=InisudPu94rQkEMkiyNI09tQyEHG3q4NOs96vLs+A59vycpTs60BZV56dZxreGirDf
 Lslrt9iFvdJWrRN/M6Nte0WO/vTihXjLYmX9WRBfZLjxhNBR2mGEaL1qs1866lEPy+GQ
 lzNiYIMDgujb6G+dyPrgcgVQY1pYYqQbGykrQXH2m+LCgsYn9mFLvkJaXqwnybH6DztJ
 ANwW1DDEwG1N7dy1hZagZygqMwhyoHGMa0/KtGZM5NMjIFlqcDwmD2hutmQc/iIwllUo
 IxDDlT4FmoMSmauzd+Mdis6ZPzBbWwXSbyucY6vA56txrkt4ErV4w68OCYl0tAlDz9LI
 YKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770301268; x=1770906068;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f66aKlJ5ZOAt0NrhG36U7Y42CvuFe3mBWlOMAIGlyEQ=;
 b=vyYCXjLyl9NZqan/lkvJU1qtUv62NyclIAUWbhb5OVoUaKnuFqim8kGWVf8qZJMQSN
 7S4h0/iPM2+heSIebDEdC/7w1A0WRgSG1TP3N506vSgG2fGrMjdVEdJRD1/7/bfmfHiF
 9I9wTQro6gIV/o5VOIFmcBt0ejXotoRmmKM7oV4Wyu1kgmF1AKikLMCoZYbRO5H/umBi
 VTYEFbPUroJvK+WMoL/3JqvmvSrsW9nf0bC8o60C2E6NkYwfznoucpiIv20UujKfOCTR
 m3u6gqSllW8hUU4jRtOpAyP/0cUszi0hwIqqHh9UrVYfCNz+OAWb/B7td+GmtRBkD/gF
 6BfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhWka5FXOu9RvYxjUogacSNiu5tEgm8Hru12TCy9ThEj/PBvJFhAvtsJYZSv1PlpbcZwRSIS4z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyqMb8oyS/Nqnz6daxeC+qygAXjGD7ai5zwXte9ScJOPxytjwm
 9ZYxawV1AOLldqLoi9p6yywSImbj7N2txaon7Sj0JZQtBkgPq+XQDvhDRuRGI22opSQKZZ3Hjkl
 kl1nYQ3G7ml9Z2TCIzVKJPHTGMui/+Rj3Nw==
X-Gm-Gg: AZuq6aJOdttMJILm4oB5HuiLjsnEQmrh2K1t7y8UCsAOBeOnIFolcvcPu+X/YmV8qx9
 cw1+BmrgQL6Z0Q1wyBwJU5Z2Nvk70EX8w9T8e5/r9RBeVO5VYTO7w8s6dsuQ0OlRLZL8Y7f1P6Z
 RDqqSurWt4jNiOZVKDjU4zciLIdDylpPX78eqz2rP3QTckCU+9vjGPwFwcjCGZzsmBPWrgo3zBS
 fMRSrpb4ab0nmfcTqsgZc6yPRrXmvfF+h6fPGdCsUoCuXSBVMZWARRjB2oijbSUrV40lgOb
X-Received: by 2002:a05:7301:3f16:b0:2ae:5b8c:324a with SMTP id
 5a478bee46e88-2b83296f948mr1507768eec.4.1770301267008; Thu, 05 Feb 2026
 06:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20260130173042.15008-1-alexander.deucher@amd.com>
 <20260130173042.15008-4-alexander.deucher@amd.com>
 <cd7be283-5d3d-4f4f-a4c7-d0cb333ae4fa@damsy.net>
In-Reply-To: <cd7be283-5d3d-4f4f-a4c7-d0cb333ae4fa@damsy.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Feb 2026 09:20:54 -0500
X-Gm-Features: AZwV_QizcqT1e6svKOAdsT4L3HK3taomPApBhu6DV9HCfo-hy3zdFk3oJgqydE8
Message-ID: <CADnq5_N2ccQ8G0_Y5cQSjnLw=PWuVLOT6AxFqVDYXrKnWcfSDQ@mail.gmail.com>
Subject: Re: [PATCH 03/12] drm/amdgpu: switch all IPs to using job for IBs
To: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com
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

On Thu, Feb 5, 2026 at 8:52=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric@damsy.net> wrote:
>
>
>
> Le 30/01/2026 =C3=A0 18:30, Alex Deucher a =C3=A9crit :
> > Switch to using a job structure for IBs.
> >
> > Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c  |  37 +++---
> >   drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  31 ++---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  29 ++---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   |  29 ++---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   |  29 ++---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c   |  29 ++---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  24 ++--
> >   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  25 ++--
> >   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 139 ++++++++++++----------=
-
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 138 +++++++++++-----------
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c  |  26 ++---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  29 ++---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  38 ++++---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  38 ++++---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  38 ++++---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  38 ++++---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  37 +++---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  36 +++---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  36 +++---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  36 +++---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c   |  36 +++---
> >   drivers/gpu/drm/amd/amdgpu/si_dma.c      |  29 +++--
> >   22 files changed, 500 insertions(+), 427 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vpe.c
> > index fd881388d6125..9fb1946be1ba2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> > @@ -817,7 +817,8 @@ static int vpe_ring_test_ib(struct amdgpu_ring *rin=
g, long timeout)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       const uint32_t test_pattern =3D 0xdeadbeef;
> > -     struct amdgpu_ib ib =3D {};
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       uint32_t index;
> >       uint64_t wb_addr;
> > @@ -832,23 +833,28 @@ static int vpe_ring_test_ib(struct amdgpu_ring *r=
ing, long timeout)
> >       adev->wb.wb[index] =3D 0;
> >       wb_addr =3D adev->wb.gpu_addr + (index * 4);
> >
> > -     ret =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib=
);
> > +     ret =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                    AMDGPU_IB_POOL_DIRECT, &job,
> > +                                    AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST=
);
> >       if (ret)
> >               goto err0;
> > -
> > -     ib.ptr[0] =3D VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
> > -     ib.ptr[1] =3D lower_32_bits(wb_addr);
> > -     ib.ptr[2] =3D upper_32_bits(wb_addr);
> > -     ib.ptr[3] =3D test_pattern;
> > -     ib.ptr[4] =3D VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> > -     ib.ptr[5] =3D VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> > -     ib.ptr[6] =3D VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> > -     ib.ptr[7] =3D VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> > -     ib.length_dw =3D 8;
> > -
> > -     ret =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (ret)
> > +     ib =3D &job->ibs[0];
> > +
> > +     ib->ptr[0] =3D VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0);
> > +     ib->ptr[1] =3D lower_32_bits(wb_addr);
> > +     ib->ptr[2] =3D upper_32_bits(wb_addr);
> > +     ib->ptr[3] =3D test_pattern;
> > +     ib->ptr[4] =3D VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> > +     ib->ptr[5] =3D VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> > +     ib->ptr[6] =3D VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> > +     ib->ptr[7] =3D VPE_CMD_HEADER(VPE_CMD_OPCODE_NOP, 0);
> > +     ib->length_dw =3D 8;
> > +
> > +     ret =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (ret) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
>
> This is a nice cleanup. What about going one step further and provide
> a helper like:
>
>     u32 test_dws[] =3D {
>        VPE_CMD_HEADER(VPE_CMD_OPCODE_FENCE, 0),
>        lower_32_bits(wb_addr),
>        ...
>     };
>     ret =3D amdgpu_ring_run_dwords(ring, ARRAY_SIZE(test_dws), test_dws,
> timeout);
>
> Because that's what most _ring_test_ib function do.

I can look into that as a follow up series.

Alex


> Thanks,
> Pierre-Eric
>
> >
> >       ret =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (ret <=3D 0) {
> > @@ -859,7 +865,6 @@ static int vpe_ring_test_ib(struct amdgpu_ring *rin=
g, long timeout)
> >       ret =3D (le32_to_cpu(adev->wb.wb[index]) =3D=3D test_pattern) ? 0=
 : -EINVAL;
> >
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/am=
d/amdgpu/cik_sdma.c
> > index 9e8715b4739da..e2ca96f5a7cfb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> > @@ -652,7 +652,8 @@ static int cik_sdma_ring_test_ring(struct amdgpu_ri=
ng *ring)
> >   static int cik_sdma_ring_test_ib(struct amdgpu_ring *ring, long timeo=
ut)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       u32 tmp =3D 0;
> > @@ -666,22 +667,27 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       tmp =3D 0xCAFEDEAD;
> >       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> > -     memset(&ib, 0, sizeof(ib));
> > -     r =3D amdgpu_ib_get(adev, NULL, 256,
> > -                                     AMDGPU_IB_POOL_DIRECT, &ib);
> > +
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST)=
;
> >       if (r)
> >               goto err0;
> > +     ib =3D &job->ibs[0];
> >
> > -     ib.ptr[0] =3D SDMA_PACKET(SDMA_OPCODE_WRITE,
> > +     ib->ptr[0] =3D SDMA_PACKET(SDMA_OPCODE_WRITE,
> >                               SDMA_WRITE_SUB_OPCODE_LINEAR, 0);
> > -     ib.ptr[1] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[2] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D 1;
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.length_dw =3D 5;
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     ib->ptr[1] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[2] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D 1;
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->length_dw =3D 5;
> > +
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -697,7 +703,6 @@ static int cik_sdma_ring_test_ib(struct amdgpu_ring=
 *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v10_0.c
> > index 1893ceeeb26c8..50954b60e49df 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -4071,15 +4071,14 @@ static int gfx_v10_0_ring_test_ring(struct amdg=
pu_ring *ring)
> >   static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned int index;
> >       uint64_t gpu_addr;
> >       uint32_t *cpu_ptr;
> >       long r;
> >
> > -     memset(&ib, 0, sizeof(ib));
> > -
> >       r =3D amdgpu_device_wb_get(adev, &index);
> >       if (r)
> >               return r;
> > @@ -4088,22 +4087,27 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu=
_ring *ring, long timeout)
> >       adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> >       cpu_ptr =3D &adev->wb.wb[index];
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
> >       if (r) {
> >               drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r=
);
> >               goto err1;
> >       }
> > +     ib =3D &job->ibs[0];
> >
> > -     ib.ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > -     ib.ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > -     ib.ptr[2] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.length_dw =3D 5;
> > +     ib->ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > +     ib->ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > +     ib->ptr[2] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->length_dw =3D 5;
> >
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err2;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -4118,7 +4122,6 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >       else
> >               r =3D -EINVAL;
> >   err2:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err1:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v11_0.c
> > index 427975b5a1d97..f7c73ca34e025 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -604,7 +604,8 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_r=
ing *ring)
> >   static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       uint64_t gpu_addr;
> > @@ -616,8 +617,6 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
> >           ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
> >               return 0;
> >
> > -     memset(&ib, 0, sizeof(ib));
> > -
> >       r =3D amdgpu_device_wb_get(adev, &index);
> >       if (r)
> >               return r;
> > @@ -626,22 +625,27 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >       adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> >       cpu_ptr =3D &adev->wb.wb[index];
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
> >       if (r) {
> >               drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r=
);
> >               goto err1;
> >       }
> > +     ib =3D &job->ibs[0];
> >
> > -     ib.ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > -     ib.ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > -     ib.ptr[2] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.length_dw =3D 5;
> > +     ib->ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > +     ib->ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > +     ib->ptr[2] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->length_dw =3D 5;
> >
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err2;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -656,7 +660,6 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
> >       else
> >               r =3D -EINVAL;
> >   err2:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err1:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_0.c
> > index 79ea1af363a53..e1eb6a3bfb899 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> > @@ -493,7 +493,8 @@ static int gfx_v12_0_ring_test_ring(struct amdgpu_r=
ing *ring)
> >   static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       uint64_t gpu_addr;
> > @@ -505,8 +506,6 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
> >           ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
> >               return 0;
> >
> > -     memset(&ib, 0, sizeof(ib));
> > -
> >       r =3D amdgpu_device_wb_get(adev, &index);
> >       if (r)
> >               return r;
> > @@ -515,22 +514,27 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >       adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> >       cpu_ptr =3D &adev->wb.wb[index];
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 16,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
> >       if (r) {
> >               drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r=
);
> >               goto err1;
> >       }
> > +     ib =3D &job->ibs[0];
> >
> > -     ib.ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > -     ib.ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > -     ib.ptr[2] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.length_dw =3D 5;
> > +     ib->ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > +     ib->ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > +     ib->ptr[2] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->length_dw =3D 5;
> >
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err2;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -545,7 +549,6 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
> >       else
> >               r =3D -EINVAL;
> >   err2:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err1:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_1.c
> > index eb9725ae1607a..cc5422a398a40 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > @@ -307,7 +307,8 @@ static int gfx_v12_1_ring_test_ring(struct amdgpu_r=
ing *ring)
> >   static int gfx_v12_1_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       uint64_t gpu_addr;
> > @@ -319,8 +320,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
> >           ring->funcs->type =3D=3D AMDGPU_RING_TYPE_KIQ)
> >               return 0;
> >
> > -     memset(&ib, 0, sizeof(ib));
> > -
> >       r =3D amdgpu_device_wb_get(adev, &index);
> >       if (r)
> >               return r;
> > @@ -329,22 +328,27 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >       adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> >       cpu_ptr =3D &adev->wb.wb[index];
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 16,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
> >       if (r) {
> >               dev_err(adev->dev, "amdgpu: failed to get ib (%ld).\n", r=
);
> >               goto err1;
> >       }
> > +     ib =3D &job->ibs[0];
> >
> > -     ib.ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > -     ib.ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > -     ib.ptr[2] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.length_dw =3D 5;
> > +     ib->ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > +     ib->ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > +     ib->ptr[2] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->length_dw =3D 5;
> >
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err2;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -359,7 +363,6 @@ static int gfx_v12_1_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
> >       else
> >               r =3D -EINVAL;
> >   err2:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err1:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v6_0.c
> > index 73223d97a87f5..2f8aa99f17480 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> > @@ -1895,24 +1895,29 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_=
ring *ring, long timeout)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct dma_fence *f =3D NULL;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       uint32_t tmp =3D 0;
> >       long r;
> >
> >       WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
> > -     memset(&ib, 0, sizeof(ib));
> > -     r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
> >       if (r)
> >               return r;
> >
> > -     ib.ptr[0] =3D PACKET3(PACKET3_SET_CONFIG_REG, 1);
> > -     ib.ptr[1] =3D mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
> > -     ib.ptr[2] =3D 0xDEADBEEF;
> > -     ib.length_dw =3D 3;
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D PACKET3(PACKET3_SET_CONFIG_REG, 1);
> > +     ib->ptr[1] =3D mmSCRATCH_REG0 - PACKET3_SET_CONFIG_REG_START;
> > +     ib->ptr[2] =3D 0xDEADBEEF;
> > +     ib->length_dw =3D 3;
> >
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto error;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -1928,7 +1933,6 @@ static int gfx_v6_0_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   error:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >       return r;
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v7_0.c
> > index 2b691452775bc..fa235b981c2e9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> > @@ -2291,25 +2291,31 @@ static void gfx_v7_ring_emit_cntxcntl(struct am=
dgpu_ring *ring, uint32_t flags)
> >   static int gfx_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeo=
ut)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       uint32_t tmp =3D 0;
> >       long r;
> >
> >       WREG32(mmSCRATCH_REG0, 0xCAFEDEAD);
> > -     memset(&ib, 0, sizeof(ib));
> > -     r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> > +
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
> >       if (r)
> >               return r;
> >
> > -     ib.ptr[0] =3D PACKET3(PACKET3_SET_UCONFIG_REG, 1);
> > -     ib.ptr[1] =3D mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
> > -     ib.ptr[2] =3D 0xDEADBEEF;
> > -     ib.length_dw =3D 3;
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D PACKET3(PACKET3_SET_UCONFIG_REG, 1);
> > +     ib->ptr[1] =3D mmSCRATCH_REG0 - PACKET3_SET_UCONFIG_REG_START;
> > +     ib->ptr[2] =3D 0xDEADBEEF;
> > +     ib->length_dw =3D 3;
> >
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto error;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -2325,7 +2331,6 @@ static int gfx_v7_0_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   error:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >       return r;
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c
> > index a6b4c8f41dc11..4736216cd0211 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -868,9 +868,9 @@ static int gfx_v8_0_ring_test_ring(struct amdgpu_ri=
ng *ring)
> >   static int gfx_v8_0_ring_test_ib(struct amdgpu_ring *ring, long timeo=
ut)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> > -
> >       unsigned int index;
> >       uint64_t gpu_addr;
> >       uint32_t tmp;
> > @@ -882,22 +882,26 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
> >
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> > -     memset(&ib, 0, sizeof(ib));
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
> >       if (r)
> >               goto err1;
> >
> > -     ib.ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > -     ib.ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > -     ib.ptr[2] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.length_dw =3D 5;
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > +     ib->ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > +     ib->ptr[2] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->length_dw =3D 5;
> >
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err2;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -914,7 +918,6 @@ static int gfx_v8_0_ring_test_ib(struct amdgpu_ring=
 *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err2:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err1:
> >       amdgpu_device_wb_free(adev, index);
> > @@ -1474,7 +1477,8 @@ static const u32 sec_ded_counter_registers[] =3D
> >   static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev=
)
> >   {
> >       struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[0];
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       int r, i;
> >       u32 tmp;
> > @@ -1505,106 +1509,108 @@ static int gfx_v8_0_do_edc_gpr_workarounds(st=
ruct amdgpu_device *adev)
> >       total_size +=3D sizeof(sgpr_init_compute_shader);
> >
> >       /* allocate an indirect buffer to put the commands in */
> > -     memset(&ib, 0, sizeof(ib));
> > -     r =3D amdgpu_ib_get(adev, NULL, total_size,
> > -                                     AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size=
,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
> >       if (r) {
> >               drm_err(adev_to_drm(adev), "failed to get ib (%d).\n", r)=
;
> >               return r;
> >       }
> > +     ib =3D &job->ibs[0];
> >
> >       /* load the compute shaders */
> >       for (i =3D 0; i < ARRAY_SIZE(vgpr_init_compute_shader); i++)
> > -             ib.ptr[i + (vgpr_offset / 4)] =3D vgpr_init_compute_shade=
r[i];
> > +             ib->ptr[i + (vgpr_offset / 4)] =3D vgpr_init_compute_shad=
er[i];
> >
> >       for (i =3D 0; i < ARRAY_SIZE(sgpr_init_compute_shader); i++)
> > -             ib.ptr[i + (sgpr_offset / 4)] =3D sgpr_init_compute_shade=
r[i];
> > +             ib->ptr[i + (sgpr_offset / 4)] =3D sgpr_init_compute_shad=
er[i];
> >
> >       /* init the ib length to 0 */
> > -     ib.length_dw =3D 0;
> > +     ib->length_dw =3D 0;
> >
> >       /* VGPR */
> >       /* write the register state for the compute dispatch */
> >       for (i =3D 0; i < ARRAY_SIZE(vgpr_init_regs); i +=3D 2) {
> > -             ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 1)=
;
> > -             ib.ptr[ib.length_dw++] =3D vgpr_init_regs[i] - PACKET3_SE=
T_SH_REG_START;
> > -             ib.ptr[ib.length_dw++] =3D vgpr_init_regs[i + 1];
> > +             ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, =
1);
> > +             ib->ptr[ib->length_dw++] =3D vgpr_init_regs[i] - PACKET3_=
SET_SH_REG_START;
> > +             ib->ptr[ib->length_dw++] =3D vgpr_init_regs[i + 1];
> >       }
> >       /* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PG=
M_HI */
> > -     gpu_addr =3D (ib.gpu_addr + (u64)vgpr_offset) >> 8;
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > -     ib.ptr[ib.length_dw++] =3D mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_=
START;
> > -     ib.ptr[ib.length_dw++] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[ib.length_dw++] =3D upper_32_bits(gpu_addr);
> > +     gpu_addr =3D (ib->gpu_addr + (u64)vgpr_offset) >> 8;
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > +     ib->ptr[ib->length_dw++] =3D mmCOMPUTE_PGM_LO - PACKET3_SET_SH_RE=
G_START;
> > +     ib->ptr[ib->length_dw++] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[ib->length_dw++] =3D upper_32_bits(gpu_addr);
> >
> >       /* write dispatch packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > -     ib.ptr[ib.length_dw++] =3D 8; /* x */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* y */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* z */
> > -     ib.ptr[ib.length_dw++] =3D
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > +     ib->ptr[ib->length_dw++] =3D 8; /* x */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* y */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* z */
> > +     ib->ptr[ib->length_dw++] =3D
> >               REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHAD=
ER_EN, 1);
> >
> >       /* write CS partial flush packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > -     ib.ptr[ib.length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > +     ib->ptr[ib->length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> >
> >       /* SGPR1 */
> >       /* write the register state for the compute dispatch */
> >       for (i =3D 0; i < ARRAY_SIZE(sgpr1_init_regs); i +=3D 2) {
> > -             ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 1)=
;
> > -             ib.ptr[ib.length_dw++] =3D sgpr1_init_regs[i] - PACKET3_S=
ET_SH_REG_START;
> > -             ib.ptr[ib.length_dw++] =3D sgpr1_init_regs[i + 1];
> > +             ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, =
1);
> > +             ib->ptr[ib->length_dw++] =3D sgpr1_init_regs[i] - PACKET3=
_SET_SH_REG_START;
> > +             ib->ptr[ib->length_dw++] =3D sgpr1_init_regs[i + 1];
> >       }
> >       /* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PG=
M_HI */
> > -     gpu_addr =3D (ib.gpu_addr + (u64)sgpr_offset) >> 8;
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > -     ib.ptr[ib.length_dw++] =3D mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_=
START;
> > -     ib.ptr[ib.length_dw++] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[ib.length_dw++] =3D upper_32_bits(gpu_addr);
> > +     gpu_addr =3D (ib->gpu_addr + (u64)sgpr_offset) >> 8;
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > +     ib->ptr[ib->length_dw++] =3D mmCOMPUTE_PGM_LO - PACKET3_SET_SH_RE=
G_START;
> > +     ib->ptr[ib->length_dw++] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[ib->length_dw++] =3D upper_32_bits(gpu_addr);
> >
> >       /* write dispatch packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > -     ib.ptr[ib.length_dw++] =3D 8; /* x */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* y */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* z */
> > -     ib.ptr[ib.length_dw++] =3D
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > +     ib->ptr[ib->length_dw++] =3D 8; /* x */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* y */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* z */
> > +     ib->ptr[ib->length_dw++] =3D
> >               REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHAD=
ER_EN, 1);
> >
> >       /* write CS partial flush packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > -     ib.ptr[ib.length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > +     ib->ptr[ib->length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> >
> >       /* SGPR2 */
> >       /* write the register state for the compute dispatch */
> >       for (i =3D 0; i < ARRAY_SIZE(sgpr2_init_regs); i +=3D 2) {
> > -             ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 1)=
;
> > -             ib.ptr[ib.length_dw++] =3D sgpr2_init_regs[i] - PACKET3_S=
ET_SH_REG_START;
> > -             ib.ptr[ib.length_dw++] =3D sgpr2_init_regs[i + 1];
> > +             ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, =
1);
> > +             ib->ptr[ib->length_dw++] =3D sgpr2_init_regs[i] - PACKET3=
_SET_SH_REG_START;
> > +             ib->ptr[ib->length_dw++] =3D sgpr2_init_regs[i + 1];
> >       }
> >       /* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PG=
M_HI */
> > -     gpu_addr =3D (ib.gpu_addr + (u64)sgpr_offset) >> 8;
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > -     ib.ptr[ib.length_dw++] =3D mmCOMPUTE_PGM_LO - PACKET3_SET_SH_REG_=
START;
> > -     ib.ptr[ib.length_dw++] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[ib.length_dw++] =3D upper_32_bits(gpu_addr);
> > +     gpu_addr =3D (ib->gpu_addr + (u64)sgpr_offset) >> 8;
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > +     ib->ptr[ib->length_dw++] =3D mmCOMPUTE_PGM_LO - PACKET3_SET_SH_RE=
G_START;
> > +     ib->ptr[ib->length_dw++] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[ib->length_dw++] =3D upper_32_bits(gpu_addr);
> >
> >       /* write dispatch packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > -     ib.ptr[ib.length_dw++] =3D 8; /* x */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* y */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* z */
> > -     ib.ptr[ib.length_dw++] =3D
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > +     ib->ptr[ib->length_dw++] =3D 8; /* x */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* y */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* z */
> > +     ib->ptr[ib->length_dw++] =3D
> >               REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHAD=
ER_EN, 1);
> >
> >       /* write CS partial flush packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > -     ib.ptr[ib.length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > +     ib->ptr[ib->length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> >
> >       /* shedule the ib on the ring */
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> >       if (r) {
> >               drm_err(adev_to_drm(adev), "ib submit failed (%d).\n", r)=
;
> > +             amdgpu_job_free(job);
> >               goto fail;
> >       }
> >
> > @@ -1629,7 +1635,6 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct=
 amdgpu_device *adev)
> >               RREG32(sec_ded_counter_registers[i]);
> >
> >   fail:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >
> >       return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index 7e9d753f4a808..36f0300a21bfa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -1224,9 +1224,9 @@ static int gfx_v9_0_ring_test_ring(struct amdgpu_=
ring *ring)
> >   static int gfx_v9_0_ring_test_ib(struct amdgpu_ring *ring, long timeo=
ut)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> > -
> >       unsigned index;
> >       uint64_t gpu_addr;
> >       uint32_t tmp;
> > @@ -1238,22 +1238,26 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_=
ring *ring, long timeout)
> >
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> > -     memset(&ib, 0, sizeof(ib));
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
> >       if (r)
> >               goto err1;
> >
> > -     ib.ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > -     ib.ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > -     ib.ptr[2] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.length_dw =3D 5;
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > +     ib->ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > +     ib->ptr[2] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->length_dw =3D 5;
> >
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err2;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -1270,7 +1274,6 @@ static int gfx_v9_0_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err2:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err1:
> >       amdgpu_device_wb_free(adev, index);
> > @@ -4624,7 +4627,8 @@ static int gfx_v9_0_do_edc_gds_workarounds(struct=
 amdgpu_device *adev)
> >   static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev=
)
> >   {
> >       struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[0];
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       int r, i;
> >       unsigned total_size, vgpr_offset, sgpr_offset;
> > @@ -4670,9 +4674,9 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct=
 amdgpu_device *adev)
> >       total_size +=3D sizeof(sgpr_init_compute_shader);
> >
> >       /* allocate an indirect buffer to put the commands in */
> > -     memset(&ib, 0, sizeof(ib));
> > -     r =3D amdgpu_ib_get(adev, NULL, total_size,
> > -                                     AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size=
,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
> >       if (r) {
> >               drm_err(adev_to_drm(adev), "failed to get ib (%d).\n", r)=
;
> >               return r;
> > @@ -4680,102 +4684,103 @@ static int gfx_v9_0_do_edc_gpr_workarounds(st=
ruct amdgpu_device *adev)
> >
> >       /* load the compute shaders */
> >       for (i =3D 0; i < vgpr_init_shader_size/sizeof(u32); i++)
> > -             ib.ptr[i + (vgpr_offset / 4)] =3D vgpr_init_shader_ptr[i]=
;
> > +             ib->ptr[i + (vgpr_offset / 4)] =3D vgpr_init_shader_ptr[i=
];
> >
> >       for (i =3D 0; i < ARRAY_SIZE(sgpr_init_compute_shader); i++)
> > -             ib.ptr[i + (sgpr_offset / 4)] =3D sgpr_init_compute_shade=
r[i];
> > +             ib->ptr[i + (sgpr_offset / 4)] =3D sgpr_init_compute_shad=
er[i];
> >
> >       /* init the ib length to 0 */
> > -     ib.length_dw =3D 0;
> > +     ib->length_dw =3D 0;
> >
> >       /* VGPR */
> >       /* write the register state for the compute dispatch */
> >       for (i =3D 0; i < gpr_reg_size; i++) {
> > -             ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 1)=
;
> > -             ib.ptr[ib.length_dw++] =3D SOC15_REG_ENTRY_OFFSET(vgpr_in=
it_regs_ptr[i])
> > +             ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, =
1);
> > +             ib->ptr[ib->length_dw++] =3D SOC15_REG_ENTRY_OFFSET(vgpr_=
init_regs_ptr[i])
> >                                                               - PACKET3=
_SET_SH_REG_START;
> > -             ib.ptr[ib.length_dw++] =3D vgpr_init_regs_ptr[i].reg_valu=
e;
> > +             ib->ptr[ib->length_dw++] =3D vgpr_init_regs_ptr[i].reg_va=
lue;
> >       }
> >       /* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PG=
M_HI */
> > -     gpu_addr =3D (ib.gpu_addr + (u64)vgpr_offset) >> 8;
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > -     ib.ptr[ib.length_dw++] =3D SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_=
LO)
> > +     gpu_addr =3D (ib->gpu_addr + (u64)vgpr_offset) >> 8;
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > +     ib->ptr[ib->length_dw++] =3D SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PG=
M_LO)
> >                                                       - PACKET3_SET_SH_=
REG_START;
> > -     ib.ptr[ib.length_dw++] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[ib.length_dw++] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[ib->length_dw++] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[ib->length_dw++] =3D upper_32_bits(gpu_addr);
> >
> >       /* write dispatch packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > -     ib.ptr[ib.length_dw++] =3D compute_dim_x * 2; /* x */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* y */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* z */
> > -     ib.ptr[ib.length_dw++] =3D
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > +     ib->ptr[ib->length_dw++] =3D compute_dim_x * 2; /* x */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* y */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* z */
> > +     ib->ptr[ib->length_dw++] =3D
> >               REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHAD=
ER_EN, 1);
> >
> >       /* write CS partial flush packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > -     ib.ptr[ib.length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > +     ib->ptr[ib->length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> >
> >       /* SGPR1 */
> >       /* write the register state for the compute dispatch */
> >       for (i =3D 0; i < gpr_reg_size; i++) {
> > -             ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 1)=
;
> > -             ib.ptr[ib.length_dw++] =3D SOC15_REG_ENTRY_OFFSET(sgpr1_i=
nit_regs[i])
> > +             ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, =
1);
> > +             ib->ptr[ib->length_dw++] =3D SOC15_REG_ENTRY_OFFSET(sgpr1=
_init_regs[i])
> >                                                               - PACKET3=
_SET_SH_REG_START;
> > -             ib.ptr[ib.length_dw++] =3D sgpr1_init_regs[i].reg_value;
> > +             ib->ptr[ib->length_dw++] =3D sgpr1_init_regs[i].reg_value=
;
> >       }
> >       /* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PG=
M_HI */
> > -     gpu_addr =3D (ib.gpu_addr + (u64)sgpr_offset) >> 8;
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > -     ib.ptr[ib.length_dw++] =3D SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_=
LO)
> > +     gpu_addr =3D (ib->gpu_addr + (u64)sgpr_offset) >> 8;
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > +     ib->ptr[ib->length_dw++] =3D SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PG=
M_LO)
> >                                                       - PACKET3_SET_SH_=
REG_START;
> > -     ib.ptr[ib.length_dw++] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[ib.length_dw++] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[ib->length_dw++] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[ib->length_dw++] =3D upper_32_bits(gpu_addr);
> >
> >       /* write dispatch packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > -     ib.ptr[ib.length_dw++] =3D compute_dim_x / 2 * sgpr_work_group_si=
ze; /* x */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* y */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* z */
> > -     ib.ptr[ib.length_dw++] =3D
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > +     ib->ptr[ib->length_dw++] =3D compute_dim_x / 2 * sgpr_work_group_=
size; /* x */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* y */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* z */
> > +     ib->ptr[ib->length_dw++] =3D
> >               REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHAD=
ER_EN, 1);
> >
> >       /* write CS partial flush packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > -     ib.ptr[ib.length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > +     ib->ptr[ib->length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> >
> >       /* SGPR2 */
> >       /* write the register state for the compute dispatch */
> >       for (i =3D 0; i < gpr_reg_size; i++) {
> > -             ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 1)=
;
> > -             ib.ptr[ib.length_dw++] =3D SOC15_REG_ENTRY_OFFSET(sgpr2_i=
nit_regs[i])
> > +             ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, =
1);
> > +             ib->ptr[ib->length_dw++] =3D SOC15_REG_ENTRY_OFFSET(sgpr2=
_init_regs[i])
> >                                                               - PACKET3=
_SET_SH_REG_START;
> > -             ib.ptr[ib.length_dw++] =3D sgpr2_init_regs[i].reg_value;
> > +             ib->ptr[ib->length_dw++] =3D sgpr2_init_regs[i].reg_value=
;
> >       }
> >       /* write the shader start address: mmCOMPUTE_PGM_LO, mmCOMPUTE_PG=
M_HI */
> > -     gpu_addr =3D (ib.gpu_addr + (u64)sgpr_offset) >> 8;
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > -     ib.ptr[ib.length_dw++] =3D SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PGM_=
LO)
> > +     gpu_addr =3D (ib->gpu_addr + (u64)sgpr_offset) >> 8;
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_SET_SH_REG, 2);
> > +     ib->ptr[ib->length_dw++] =3D SOC15_REG_OFFSET(GC, 0, mmCOMPUTE_PG=
M_LO)
> >                                                       - PACKET3_SET_SH_=
REG_START;
> > -     ib.ptr[ib.length_dw++] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[ib.length_dw++] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[ib->length_dw++] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[ib->length_dw++] =3D upper_32_bits(gpu_addr);
> >
> >       /* write dispatch packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > -     ib.ptr[ib.length_dw++] =3D compute_dim_x / 2 * sgpr_work_group_si=
ze; /* x */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* y */
> > -     ib.ptr[ib.length_dw++] =3D 1; /* z */
> > -     ib.ptr[ib.length_dw++] =3D
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_DISPATCH_DIRECT, 3);
> > +     ib->ptr[ib->length_dw++] =3D compute_dim_x / 2 * sgpr_work_group_=
size; /* x */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* y */
> > +     ib->ptr[ib->length_dw++] =3D 1; /* z */
> > +     ib->ptr[ib->length_dw++] =3D
> >               REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHAD=
ER_EN, 1);
> >
> >       /* write CS partial flush packet */
> > -     ib.ptr[ib.length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > -     ib.ptr[ib.length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> > +     ib->ptr[ib->length_dw++] =3D PACKET3(PACKET3_EVENT_WRITE, 0);
> > +     ib->ptr[ib->length_dw++] =3D EVENT_TYPE(7) | EVENT_INDEX(4);
> >
> >       /* shedule the ib on the ring */
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> >       if (r) {
> >               drm_err(adev_to_drm(adev), "ib schedule failed (%d).\n", =
r);
> > +             amdgpu_job_free(job);
> >               goto fail;
> >       }
> >
> > @@ -4787,7 +4792,6 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct=
 amdgpu_device *adev)
> >       }
> >
> >   fail:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >
> >       return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_4_2.c
> > index 8058ea91ecafd..424b05b84ea74 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> > @@ -345,12 +345,13 @@ const struct soc15_reg_entry sgpr64_init_regs_ald=
ebaran[] =3D {
> >
> >   static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
> >                                struct amdgpu_ring *ring,
> > -                              struct amdgpu_ib *ib,
> >                                const u32 *shader_ptr, u32 shader_size,
> >                                const struct soc15_reg_entry *init_regs,=
 u32 regs_size,
> >                                u32 compute_dim_x, u64 wb_gpu_addr, u32 =
pattern,
> >                                struct dma_fence **fence_ptr)
> >   {
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       int r, i;
> >       uint32_t total_size, shader_offset;
> >       u64 gpu_addr;
> > @@ -360,10 +361,9 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_dev=
ice *adev,
> >       shader_offset =3D total_size;
> >       total_size +=3D ALIGN(shader_size, 256);
> >
> > -     /* allocate an indirect buffer to put the commands in */
> > -     memset(ib, 0, sizeof(*ib));
> > -     r =3D amdgpu_ib_get(adev, NULL, total_size,
> > -                                     AMDGPU_IB_POOL_DIRECT, ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, total_size=
,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_RUN_SHADER);
> >       if (r) {
> >               dev_err(adev->dev, "failed to get ib (%d).\n", r);
> >               return r;
> > @@ -408,11 +408,11 @@ static int gfx_v9_4_2_run_shader(struct amdgpu_de=
vice *adev,
> >       ib->ptr[ib->length_dw++] =3D
> >               REG_SET_FIELD(0, COMPUTE_DISPATCH_INITIATOR, COMPUTE_SHAD=
ER_EN, 1);
> >
> > -     /* shedule the ib on the ring */
> > -     r =3D amdgpu_ib_schedule(ring, 1, ib, NULL, fence_ptr);
> > +     /* schedule the ib on the ring */
> > +     r =3D amdgpu_job_submit_direct(job, ring, fence_ptr);
> >       if (r) {
> >               dev_err(adev->dev, "ib submit failed (%d).\n", r);
> > -             amdgpu_ib_free(ib, NULL);
> > +             amdgpu_job_free(job);
> >       }
> >       return r;
> >   }
> > @@ -493,7 +493,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_d=
evice *adev)
> >       int wb_size =3D adev->gfx.config.max_shader_engines *
> >                        CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
> >       struct amdgpu_ib wb_ib;
> > -     struct amdgpu_ib disp_ibs[3];
> >       struct dma_fence *fences[3];
> >       u32 pattern[3] =3D { 0x1, 0x5, 0xa };
> >
> > @@ -514,7 +513,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_d=
evice *adev)
> >
> >       r =3D gfx_v9_4_2_run_shader(adev,
> >                       &adev->gfx.compute_ring[0],
> > -                     &disp_ibs[0],
> >                       sgpr112_init_compute_shader_aldebaran,
> >                       sizeof(sgpr112_init_compute_shader_aldebaran),
> >                       sgpr112_init_regs_aldebaran,
> > @@ -539,7 +537,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_d=
evice *adev)
> >
> >       r =3D gfx_v9_4_2_run_shader(adev,
> >                       &adev->gfx.compute_ring[1],
> > -                     &disp_ibs[1],
> >                       sgpr96_init_compute_shader_aldebaran,
> >                       sizeof(sgpr96_init_compute_shader_aldebaran),
> >                       sgpr96_init_regs_aldebaran,
> > @@ -579,7 +576,6 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu_d=
evice *adev)
> >       memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
> >       r =3D gfx_v9_4_2_run_shader(adev,
> >                       &adev->gfx.compute_ring[0],
> > -                     &disp_ibs[2],
> >                       sgpr64_init_compute_shader_aldebaran,
> >                       sizeof(sgpr64_init_compute_shader_aldebaran),
> >                       sgpr64_init_regs_aldebaran,
> > @@ -611,13 +607,10 @@ static int gfx_v9_4_2_do_sgprs_init(struct amdgpu=
_device *adev)
> >       }
> >
> >   disp2_failed:
> > -     amdgpu_ib_free(&disp_ibs[2], NULL);
> >       dma_fence_put(fences[2]);
> >   disp1_failed:
> > -     amdgpu_ib_free(&disp_ibs[1], NULL);
> >       dma_fence_put(fences[1]);
> >   disp0_failed:
> > -     amdgpu_ib_free(&disp_ibs[0], NULL);
> >       dma_fence_put(fences[0]);
> >   pro_end:
> >       amdgpu_ib_free(&wb_ib, NULL);
> > @@ -637,7 +630,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_d=
evice *adev)
> >       int wb_size =3D adev->gfx.config.max_shader_engines *
> >                        CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
> >       struct amdgpu_ib wb_ib;
> > -     struct amdgpu_ib disp_ib;
> >       struct dma_fence *fence;
> >       u32 pattern =3D 0xa;
> >
> > @@ -657,7 +649,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_d=
evice *adev)
> >
> >       r =3D gfx_v9_4_2_run_shader(adev,
> >                       &adev->gfx.compute_ring[0],
> > -                     &disp_ib,
> >                       vgpr_init_compute_shader_aldebaran,
> >                       sizeof(vgpr_init_compute_shader_aldebaran),
> >                       vgpr_init_regs_aldebaran,
> > @@ -687,7 +678,6 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_d=
evice *adev)
> >       }
> >
> >   disp_failed:
> > -     amdgpu_ib_free(&disp_ib, NULL);
> >       dma_fence_put(fence);
> >   pro_end:
> >       amdgpu_ib_free(&wb_ib, NULL);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_4_3.c
> > index ad4d442e7345e..d78b2c2ae13a3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> > @@ -451,9 +451,9 @@ static int gfx_v9_4_3_ring_test_ring(struct amdgpu_=
ring *ring)
> >   static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ring *ring, long tim=
eout)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> > -
> >       unsigned index;
> >       uint64_t gpu_addr;
> >       uint32_t tmp;
> > @@ -465,22 +465,26 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_=
ring *ring, long timeout)
> >
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> > -     memset(&ib, 0, sizeof(ib));
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 20,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST);
> >       if (r)
> >               goto err1;
> >
> > -     ib.ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > -     ib.ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > -     ib.ptr[2] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.length_dw =3D 5;
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D PACKET3(PACKET3_WRITE_DATA, 3);
> > +     ib->ptr[1] =3D WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
> > +     ib->ptr[2] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->length_dw =3D 5;
> >
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err2;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -497,7 +501,6 @@ static int gfx_v9_4_3_ring_test_ib(struct amdgpu_ri=
ng *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err2:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err1:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v2_4.c
> > index 92ce580647cdc..46263d50cc9ef 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> > @@ -584,7 +584,8 @@ static int sdma_v2_4_ring_test_ring(struct amdgpu_r=
ing *ring)
> >   static int sdma_v2_4_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       u32 tmp =3D 0;
> > @@ -598,26 +599,30 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       tmp =3D 0xCAFEDEAD;
> >       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> > -     memset(&ib, 0, sizeof(ib));
> > -     r =3D amdgpu_ib_get(adev, NULL, 256,
> > -                                     AMDGPU_IB_POOL_DIRECT, &ib);
> > +
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST)=
;
> >       if (r)
> >               goto err0;
> >
> > -     ib.ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> >               SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> > -     ib.ptr[1] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[2] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.ptr[5] =3D SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[6] =3D SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[7] =3D SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> > -     ib.length_dw =3D 8;
> > -
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     ib->ptr[1] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[2] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->ptr[5] =3D SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[6] =3D SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[7] =3D SDMA_PKT_HEADER_OP(SDMA_OP_NOP);
> > +     ib->length_dw =3D 8;
> > +
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -633,7 +638,6 @@ static int sdma_v2_4_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v3_0.c
> > index 1c076bd1cf73e..f9f05768072ad 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> > @@ -858,7 +858,8 @@ static int sdma_v3_0_ring_test_ring(struct amdgpu_r=
ing *ring)
> >   static int sdma_v3_0_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       u32 tmp =3D 0;
> > @@ -872,26 +873,30 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       tmp =3D 0xCAFEDEAD;
> >       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> > -     memset(&ib, 0, sizeof(ib));
> > -     r =3D amdgpu_ib_get(adev, NULL, 256,
> > -                                     AMDGPU_IB_POOL_DIRECT, &ib);
> > +
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST)=
;
> >       if (r)
> >               goto err0;
> >
> > -     ib.ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> >               SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> > -     ib.ptr[1] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[2] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.length_dw =3D 8;
> > -
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     ib->ptr[1] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[2] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(1);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->length_dw =3D 8;
> > +
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -906,7 +911,6 @@ static int sdma_v3_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
> >       else
> >               r =3D -EINVAL;
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_0.c
> > index f38004e6064e5..56d2832ccba2d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> > @@ -1516,7 +1516,8 @@ static int sdma_v4_0_ring_test_ring(struct amdgpu=
_ring *ring)
> >   static int sdma_v4_0_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       long r;
> > @@ -1530,26 +1531,30 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu=
_ring *ring, long timeout)
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       tmp =3D 0xCAFEDEAD;
> >       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> > -     memset(&ib, 0, sizeof(ib));
> > -     r =3D amdgpu_ib_get(adev, NULL, 256,
> > -                                     AMDGPU_IB_POOL_DIRECT, &ib);
> > +
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST)=
;
> >       if (r)
> >               goto err0;
> >
> > -     ib.ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> >               SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> > -     ib.ptr[1] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[2] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.length_dw =3D 8;
> > -
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     ib->ptr[1] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[2] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->length_dw =3D 8;
> > +
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -1565,7 +1570,6 @@ static int sdma_v4_0_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v4_4_2.c
> > index a1443990d5c60..dd8d6a572710d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > @@ -1112,7 +1112,8 @@ static int sdma_v4_4_2_ring_test_ring(struct amdg=
pu_ring *ring)
> >   static int sdma_v4_4_2_ring_test_ib(struct amdgpu_ring *ring, long ti=
meout)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       long r;
> > @@ -1126,26 +1127,30 @@ static int sdma_v4_4_2_ring_test_ib(struct amdg=
pu_ring *ring, long timeout)
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       tmp =3D 0xCAFEDEAD;
> >       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> > -     memset(&ib, 0, sizeof(ib));
> > -     r =3D amdgpu_ib_get(adev, NULL, 256,
> > -                                     AMDGPU_IB_POOL_DIRECT, &ib);
> > +
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST)=
;
> >       if (r)
> >               goto err0;
> >
> > -     ib.ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> >               SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> > -     ib.ptr[1] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[2] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.length_dw =3D 8;
> > -
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     ib->ptr[1] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[2] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->length_dw =3D 8;
> > +
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -1161,7 +1166,6 @@ static int sdma_v4_4_2_ring_test_ib(struct amdgpu=
_ring *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_0.c
> > index e77e079fe8339..edb1e4d3f9292 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -1074,7 +1074,8 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu=
_ring *ring)
> >   static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       long r;
> > @@ -1082,7 +1083,6 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >       u64 gpu_addr;
> >
> >       tmp =3D 0xCAFEDEAD;
> > -     memset(&ib, 0, sizeof(ib));
> >
> >       r =3D amdgpu_device_wb_get(adev, &index);
> >       if (r) {
> > @@ -1093,27 +1093,31 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu=
_ring *ring, long timeout)
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 256,
> > -                       AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST)=
;
> >       if (r) {
> >               drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r=
);
> >               goto err0;
> >       }
> >
> > -     ib.ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> >               SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> > -     ib.ptr[1] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[2] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.length_dw =3D 8;
> > -
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     ib->ptr[1] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[2] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->length_dw =3D 8;
> > +
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -1133,7 +1137,6 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_2.c
> > index 50b51965c211e..a57fe976cccaf 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> > @@ -974,7 +974,8 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_r=
ing *ring)
> >   static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       long r;
> > @@ -982,7 +983,6 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
> >       u64 gpu_addr;
> >
> >       tmp =3D 0xCAFEDEAD;
> > -     memset(&ib, 0, sizeof(ib));
> >
> >       r =3D amdgpu_device_wb_get(adev, &index);
> >       if (r) {
> > @@ -993,26 +993,31 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST)=
;
> >       if (r) {
> >               drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r=
);
> >               goto err0;
> >       }
> >
> > -     ib.ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D SDMA_PKT_HEADER_OP(SDMA_OP_WRITE) |
> >               SDMA_PKT_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEAR);
> > -     ib.ptr[1] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[2] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.length_dw =3D 8;
> > -
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     ib->ptr[1] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[2] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->length_dw =3D 8;
> > +
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -1032,7 +1037,6 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v6_0.c
> > index eec659194718d..210ea6ba6212f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > @@ -981,7 +981,8 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_r=
ing *ring)
> >   static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       long r;
> > @@ -989,7 +990,6 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
> >       u64 gpu_addr;
> >
> >       tmp =3D 0xCAFEDEAD;
> > -     memset(&ib, 0, sizeof(ib));
> >
> >       r =3D amdgpu_device_wb_get(adev, &index);
> >       if (r) {
> > @@ -1000,26 +1000,31 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu=
_ring *ring, long timeout)
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST)=
;
> >       if (r) {
> >               drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r=
);
> >               goto err0;
> >       }
> >
> > -     ib.ptr[0] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> >               SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEA=
R);
> > -     ib.ptr[1] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[2] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.length_dw =3D 8;
> > -
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     ib->ptr[1] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[2] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->length_dw =3D 8;
> > +
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -1039,7 +1044,6 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v7_0.c
> > index 8d16ef257bcb9..3b4417d19212e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> > @@ -997,7 +997,8 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_r=
ing *ring)
> >   static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       long r;
> > @@ -1005,7 +1006,6 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >       u64 gpu_addr;
> >
> >       tmp =3D 0xCAFEDEAD;
> > -     memset(&ib, 0, sizeof(ib));
> >
> >       r =3D amdgpu_device_wb_get(adev, &index);
> >       if (r) {
> > @@ -1016,26 +1016,31 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu=
_ring *ring, long timeout)
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST)=
;
> >       if (r) {
> >               drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r=
);
> >               goto err0;
> >       }
> >
> > -     ib.ptr[0] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> >               SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEA=
R);
> > -     ib.ptr[1] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[2] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.length_dw =3D 8;
> > -
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     ib->ptr[1] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[2] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->length_dw =3D 8;
> > +
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -1055,7 +1060,6 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v7_1.c
> > index 0824cba48f2e7..d8167ce18dbd8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> > @@ -987,7 +987,8 @@ static int sdma_v7_1_ring_test_ring(struct amdgpu_r=
ing *ring)
> >   static int sdma_v7_1_ring_test_ib(struct amdgpu_ring *ring, long time=
out)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       long r;
> > @@ -995,7 +996,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_rin=
g *ring, long timeout)
> >       u64 gpu_addr;
> >
> >       tmp =3D 0xCAFEDEAD;
> > -     memset(&ib, 0, sizeof(ib));
> >
> >       r =3D amdgpu_device_wb_get(adev, &index);
> >       if (r) {
> > @@ -1006,26 +1006,31 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu=
_ring *ring, long timeout)
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> >
> > -     r =3D amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST)=
;
> >       if (r) {
> >               DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
> >               goto err0;
> >       }
> >
> > -     ib.ptr[0] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_WRITE) |
> >               SDMA_PKT_COPY_LINEAR_HEADER_SUB_OP(SDMA_SUBOP_WRITE_LINEA=
R);
> > -     ib.ptr[1] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[2] =3D upper_32_bits(gpu_addr);
> > -     ib.ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > -     ib.ptr[4] =3D 0xDEADBEEF;
> > -     ib.ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > -     ib.length_dw =3D 8;
> > -
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     ib->ptr[1] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[2] =3D upper_32_bits(gpu_addr);
> > +     ib->ptr[3] =3D SDMA_PKT_WRITE_UNTILED_DW_3_COUNT(0);
> > +     ib->ptr[4] =3D 0xDEADBEEF;
> > +     ib->ptr[5] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[6] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->ptr[7] =3D SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP);
> > +     ib->length_dw =3D 8;
> > +
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -1045,7 +1050,6 @@ static int sdma_v7_1_ring_test_ib(struct amdgpu_r=
ing *ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/=
amdgpu/si_dma.c
> > index 74fcaa340d9b1..b67bd343f795f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> > @@ -259,7 +259,8 @@ static int si_dma_ring_test_ring(struct amdgpu_ring=
 *ring)
> >   static int si_dma_ring_test_ib(struct amdgpu_ring *ring, long timeout=
)
> >   {
> >       struct amdgpu_device *adev =3D ring->adev;
> > -     struct amdgpu_ib ib;
> > +     struct amdgpu_job *job;
> > +     struct amdgpu_ib *ib;
> >       struct dma_fence *f =3D NULL;
> >       unsigned index;
> >       u32 tmp =3D 0;
> > @@ -273,20 +274,25 @@ static int si_dma_ring_test_ib(struct amdgpu_ring=
 *ring, long timeout)
> >       gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >       tmp =3D 0xCAFEDEAD;
> >       adev->wb.wb[index] =3D cpu_to_le32(tmp);
> > -     memset(&ib, 0, sizeof(ib));
> > -     r =3D amdgpu_ib_get(adev, NULL, 256,
> > -                                     AMDGPU_IB_POOL_DIRECT, &ib);
> > +
> > +     r =3D amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 256,
> > +                                  AMDGPU_IB_POOL_DIRECT, &job,
> > +                                  AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST)=
;
> >       if (r)
> >               goto err0;
> >
> > -     ib.ptr[0] =3D DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, 1);
> > -     ib.ptr[1] =3D lower_32_bits(gpu_addr);
> > -     ib.ptr[2] =3D upper_32_bits(gpu_addr) & 0xff;
> > -     ib.ptr[3] =3D 0xDEADBEEF;
> > -     ib.length_dw =3D 4;
> > -     r =3D amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
> > -     if (r)
> > +     ib =3D &job->ibs[0];
> > +     ib->ptr[0] =3D DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 0, 1);
> > +     ib->ptr[1] =3D lower_32_bits(gpu_addr);
> > +     ib->ptr[2] =3D upper_32_bits(gpu_addr) & 0xff;
> > +     ib->ptr[3] =3D 0xDEADBEEF;
> > +     ib->length_dw =3D 4;
> > +
> > +     r =3D amdgpu_job_submit_direct(job, ring, &f);
> > +     if (r) {
> > +             amdgpu_job_free(job);
> >               goto err1;
> > +     }
> >
> >       r =3D dma_fence_wait_timeout(f, false, timeout);
> >       if (r =3D=3D 0) {
> > @@ -302,7 +308,6 @@ static int si_dma_ring_test_ib(struct amdgpu_ring *=
ring, long timeout)
> >               r =3D -EINVAL;
> >
> >   err1:
> > -     amdgpu_ib_free(&ib, NULL);
> >       dma_fence_put(f);
> >   err0:
> >       amdgpu_device_wb_free(adev, index);
