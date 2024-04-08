Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6B5C67861
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Apr 2024 18:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61D3A10E4A8;
	Mon,  8 Apr 2024 18:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E3JNSkx6";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46EDF10E4A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Apr 2024 18:47:34 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2a484f772e2so2001800a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Apr 2024 11:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712602053; x=1713206853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FUVVyqGdRb9Z6aeYHNxueLd+IiyHZrC75WeSdU84Ao=;
 b=E3JNSkx6kOwJat2btr4pYNgGvBRGVlHJsTmzlfz+xJiS1YM2OEClEP6zoEVc1UFtNY
 30FyULi5ozqljaeao6G1Oq53ucMK6oRKVR6Me8pW0WxH7o/LRB7rIOdGh8hTUGORDdrC
 DrY4xT7gP5tOmSbHiSrAiR4kFBCPPNICwEwHN+T/Epl8BLL5E94SM3jUk3mN9AfPUF8x
 xR7k28gbFeu+HP0k1T0oABzmA2oOBqDjDgiMFfkAg+47Q9ABXkO4yhClvAfBXVOghNBX
 zXm6aA9Zua+ZOKyQIQdHwkLHm91QlBiB8Qel7IUaQqx26+d6DDmeEu3tfZkNdlU4yMY1
 c8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712602053; x=1713206853;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3FUVVyqGdRb9Z6aeYHNxueLd+IiyHZrC75WeSdU84Ao=;
 b=FDgHxNb89xOMEmMFQPQcu12nMQfRJpL3wORFgM5j8cH3ML9lGNDGGryPR2VuoQwzB9
 yjuGOX8iRPogy0s+cTAx8ADVmck5mVSc/+l9vdmuye+o+7s7yuyT/rTgB9xhtHuTf5M2
 i/qcsE0XlI7S0HzRVwEyGCyO9wGmBCbUDCKcd6iQ4edlSUud1M4NECHg0+zFUTOAjaBC
 je1jb5imKgwpnPNXkMpRLWUCRabxlew/7wxse0WPoIfBsJjulY/6lVZk9FLXesBAu3eT
 oRqOwhM+Wtclq0k+fpEjVxunK1Jk60uVwZqoMO74UGKl7VwgX2WlBhjSlg6XrJU+mqA4
 bLdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEpi4CdLyLIlgchjG+O51PR16PyWXxoXGnEcy3DDUl/2/73KsIF+ACrjLrvdPNmgPEuUJ2mpSXJIvUoys2pT2PXlAacacFPtjwFpoCKg==
X-Gm-Message-State: AOJu0YwEzgaELhLLsVa4A7OcldxNi7H78tE0BRaYrhkqJdDdogatN0wE
 hU5Qoni/G/85G8kJqI7gy3zlh9/J+FQ7TDzvipKGlJwal1jVnSCt42qQzw+Kgoe6dc9tl2SoWCo
 8stSBQyNlmHqEReDyMEJ2XyUbjFq6bLjM
X-Google-Smtp-Source: AGHT+IFXFXUex1UBxJkm4LDZTiSRV1gsOtPvK5sT3l2B9b5BChbsVp5bXqMtLLbAGFjXb1ad25M8euT4oENIqq6iSBM=
X-Received: by 2002:a17:90b:4f83:b0:2a5:37cc:cc4e with SMTP id
 qe3-20020a17090b4f8300b002a537cccc4emr2269413pjb.32.1712602053557; Mon, 08
 Apr 2024 11:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240402100552.3164095-1-Jun.Ma2@amd.com>
 <635b5592-c3fd-49f5-b9ea-402a01f70ee0@amd.com>
In-Reply-To: <635b5592-c3fd-49f5-b9ea-402a01f70ee0@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Apr 2024 14:47:21 -0400
Message-ID: <CADnq5_NYvfkpFzj1F+uEt7nMEc+gNDR192O2wqqbz3sp0KYyoA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Fix discovery initialization failure
 during pci rescan
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
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

On Tue, Apr 2, 2024 at 7:56=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> Am 02.04.24 um 12:05 schrieb Ma Jun:
> > Waiting for system ready to fix the discovery initialization
> > failure issue. This failure usually occurs when dGPU is removed
> > and then rescanned via command line.
> > It's caused by following two errors:
> > [1] vram size is 0
> > [2] wrong binary signature
> >
> > Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>
> I'm not an expert for that stuff, but using dev_is_removable() indeed
> seems to be incorrect here.
>
> Feel free to add an Acked-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>, but I would rather wait for Alex to come
> back from vacation and take a look as well.
>
> Might be that I missed something why the dev_is_removable() check is
> mandatory or something like that.

I added it originally for USB4/thunderbolt connected devices (hence
the removable check) and didn't want to add the extra latency all the
time, but I hadn't considered the rescan case.

Patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex


>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 17 ++++++-----------
> >   1 file changed, 6 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index 07c5fca06178..90735e966318 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -255,7 +255,6 @@ static int amdgpu_discovery_read_binary_from_mem(st=
ruct amdgpu_device *adev,
> >       uint64_t vram_size;
> >       u32 msg;
> >       int i, ret =3D 0;
> > -     int ip_discovery_ver =3D 0;
> >
> >       /* It can take up to a second for IFWI init to complete on some d=
GPUs,
> >        * but generally it should be in the 60-100ms range.  Normally th=
is starts
> > @@ -265,17 +264,13 @@ static int amdgpu_discovery_read_binary_from_mem(=
struct amdgpu_device *adev,
> >        * continue.
> >        */
> >
> > -     ip_discovery_ver =3D RREG32(mmIP_DISCOVERY_VERSION);
> > -     if ((dev_is_removable(&adev->pdev->dev)) ||
> > -         (ip_discovery_ver =3D=3D IP_DISCOVERY_V2) ||
> > -         (ip_discovery_ver =3D=3D IP_DISCOVERY_V4)) {
> > -             for (i =3D 0; i < 1000; i++) {
> > -                     msg =3D RREG32(mmMP0_SMN_C2PMSG_33);
> > -                     if (msg & 0x80000000)
> > -                             break;
> > -                     msleep(1);
> > -             }
> > +     for (i =3D 0; i < 1000; i++) {
> > +             msg =3D RREG32(mmMP0_SMN_C2PMSG_33);
> > +             if (msg & 0x80000000)
> > +                     break;
> > +             usleep_range(1000, 1100);
> >       }
> > +
> >       vram_size =3D (uint64_t)RREG32(mmRCC_CONFIG_MEMSIZE) << 20;
> >
> >       if (vram_size) {
>
