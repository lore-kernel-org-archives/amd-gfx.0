Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097E5C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 11:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9134610E1BA;
	Mon, 25 Apr 2022 11:03:07 +0000 (UTC)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD1A10E1BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 11:03:06 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id c12so26156578plr.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Apr 2022 04:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NN33l21UFVXrWfs3ZXBrX7OH5dD6s3xgrWsgQoR+zU4=;
 b=GMTfo9plxotTgl4GvDTESBb6fra+6iSEhlQhDhFHoaGk0LFO6yWskFggi8RFYXDBIY
 ti2jPQF0v6e6NinoNMvOrrqpMrlGmN9pyranp3yBzmKxU5k/D1FP6ZXX2Oc2jspcWEjz
 7XPqREXmEQoUfqn1P8cdN1V5sneqfGy/6VDCyw7WdByMZCLQjfOqx1ghxYcglGYvgjyb
 ByLdpbkG0DKCk6Fj9PWTErHEX2V5BQyFai5VHbzYzm4OegGLCO2cboaz1Cmnzyq96rgP
 GyftMli3Msda5dYfZuftilyi7fPwYLau0jfyUU5s0RwaPRowg+GpNBPh/1aoQGoR2KGK
 ji4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NN33l21UFVXrWfs3ZXBrX7OH5dD6s3xgrWsgQoR+zU4=;
 b=44WnUDwsDPRDEIan6p4st+r73sm43vzpn9emsZW+aDTyJemlK74KYJIzoQr+YQDzP0
 JEyL1L2gaEx/4o/0oajWV81nbWfxRcVerUYyP/OUoHB0K1hAfsjgU03vpt7HT432yJ+C
 thxajKXDqvJRAajRfI3EpXSlcHDLO4NkgWDkX20iaI9C8LdZjSrO+ZDMR0FDFmBa1TWf
 wkCUpAO5bnPu+lfmFTizZRO+FMMxfyDUj3rByEazjnFfuXM0NwH9pK5ZeR1rDD3/A8mA
 zkRiK8cHDFirbakNXHIjFeVKhCQG1KgKLGE29OqDNi88sv8msEeqPQQbhqpsSNerSL42
 wruQ==
X-Gm-Message-State: AOAM531XPnV8G4aEbiiOL2+p5nYXyN+LhMb8lnIXvF9qTTGO5jFLQo0f
 x8ntdh0j1++3bUn67xosDPWc9/ZUUYGRp9YvdYpwVsV3TdASHw==
X-Google-Smtp-Source: ABdhPJzDPArpdhJj8IbyjYLMEKPLq8LNnDtROzREGYEe9jIPpH0hLAC74AaRHLP3b6xUlttagY+bbOOWkgS0YzoCXKk=
X-Received: by 2002:a17:902:8506:b0:154:8692:a7ac with SMTP id
 bj6-20020a170902850600b001548692a7acmr17500546plb.10.1650884586258; Mon, 25
 Apr 2022 04:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAHpOOhHucS2QJSW3-jyGg8v8AMoCp2nV0h7T2rL_TQf6EHRvaA@mail.gmail.com>
 <f4b9dc03-2d2c-28f6-fe72-7bf0e6bcf203@gmail.com>
In-Reply-To: <f4b9dc03-2d2c-28f6-fe72-7bf0e6bcf203@gmail.com>
From: Haohui Mai <ricetons@gmail.com>
Date: Mon, 25 Apr 2022 19:02:55 +0800
Message-ID: <CAHpOOhHHzUD2Hw-W_9apXfc+43N1D9M3xXueaqyJh+xyfq3kiQ@mail.gmail.com>
Subject: Re: [PATCH] Fix out-of-bound access for gfx_v10_0_ring_test_ib()
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
Cc: emily.deng@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks for the prompt reviews. Here is the updated patch.

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9426e252d8aa..c15549bbe636 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3830,8 +3830,7 @@ static int gfx_v10_0_ring_test_ib(struct
amdgpu_ring *ring, long timeout)
        gpu_addr =3D adev->wb.gpu_addr + (index * 4);
        adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
        memset(&ib, 0, sizeof(ib));
-       r =3D amdgpu_ib_get(adev, NULL, 16,
-                                       AMDGPU_IB_POOL_DIRECT, &ib);
+       r =3D amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
        if (r)
                goto err1;

--
2.25.1

On Mon, Apr 25, 2022 at 6:52 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 25.04.22 um 10:56 schrieb Haohui Mai:
> > The gfx_v10_0_ring_test_ib() function uses 20 bytes instead of 16
> > bytes during the test. The patch sets the size of the allocation to be
> > 4-byte larger to match the actual usage.
> >
> > Signed-off-by: Haohui Mai <ricetons@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index 9426e252d8aa..b131235826b1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -3830,7 +3830,7 @@ static int gfx_v10_0_ring_test_ib(struct
> > amdgpu_ring *ring, long timeout)
> >          gpu_addr =3D adev->wb.gpu_addr + (index * 4);
> >          adev->wb.wb[index] =3D cpu_to_le32(0xCAFEDEAD);
> >          memset(&ib, 0, sizeof(ib));
> > -       r =3D amdgpu_ib_get(adev, NULL, 16,
> > +       r =3D amdgpu_ib_get(adev, NULL, 20,
> >                                          AMDGPU_IB_POOL_DIRECT, &ib);
>
> Good catch, but while at it please fix the coding style and move the
> "AMDGPU_IB_POOL_DIRECT, &ib);" on the same line as well.
>
> With that done, the patch is Reviewed-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>
>
> >          if (r)
> >                  goto err1;
> > --
> > 2.25.1
>
