Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073CDC369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 15:32:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A7AC10E617;
	Mon, 14 Apr 2025 15:32:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HlIHlkRK";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF4D610E617
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 15:32:56 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2240d930f13so5474685ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744644776; x=1745249576; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZiCPD4Egl8NrvQbX7BtI80zebTWrYlp1GMrU7F2nOd4=;
 b=HlIHlkRKddqNz4Anbm8MIz6xaYpvmaI99nxg7NL4IvZ8sStLpkhBCrmk/SXPTReY3f
 yhG3jbi8LuftUtENuSoLIsBaaOKwwnRU5fImwbeSyaNLwJiu6LEahtug9sQeK+70OTA6
 Nbx5CI1dgDmB6Sc8OSsbuaTZeSUsOBL4KqbpwzHgEsOtq5/6xE5UQwI2ohMsor31ALe0
 rMC47V58OxAaIKK+jDTP+AFlVUtuo5x6QBqF+lge2qJc53GfAy29Ouv3e/gBH9NCjB9Y
 XUAuC6+mWHw5+N3ouOV+DjRW/VT7sekBWqY61bI9qCuXQFj7zLc/gRqIpwZlSBBf3LCL
 NuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744644776; x=1745249576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZiCPD4Egl8NrvQbX7BtI80zebTWrYlp1GMrU7F2nOd4=;
 b=cwSa171AvDW7IqfbEXhsjy3Vswm8TsBDs3eMDxEa2sL6Z/klyDkkxVQVv16lcE3nrm
 lOW4hpiTtuwHqzCJMso+rrF8Ep/xhaeSYJYIwefAM0tUm6qzwAVRdaZF3YLsJEf93T5U
 wHBhqpKdW5zzVKv0Lj1qsBeWSFYC9hNYMbwRZH8qP0Jh6qx5mfmNeHZDD7yT+bz4WOgk
 aZSNWb6uLIti2zMphciGC4lxQDGMevUWW41RK1awbJmU5mhwxUW0uWFF9lFnXStLyCik
 uXgyxUksODIThxgUgvvtW01Cjxx43Icn4EojAvaTi1oXDfbv9prnA4Orh9tqWTg0k2Xx
 x+6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm1k/zjUC1B9GtOyPAbIpxO1tDvrFnFklBPN/iTRgFeiVPJXlCEWrQ8hNEwa8y3yt8GtplLjEa@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMqHiuPZmI65W3nTAJhjiS1Sr4u3HRlxLYgJ8ziSyxbwlRulIq
 8p6mBnZZz2uc5Oc525OTYrUVSlJHwvm4DBJWorchtd3rYT7okH/TU5sC6K0jMQ2JeIaJpuf2GWV
 ntvSO7dO4qrTOGLqp4knKc9jvMfs=
X-Gm-Gg: ASbGncvJ/BkWshHmErma/FDKUaVsCMy5mgT49jPaOzzEDaOxyD1umpkuHqslg/vvqXy
 xb97ta8QcLqLg5p3PHzEfZeJc88IwgsmAOZe4A9P2rIZkuVq7x6K9HfwojUdK6gbHV2EZpGsvjm
 /GpEE/9/zscUnMjpMoKKCF4w==
X-Google-Smtp-Source: AGHT+IGapD39lvOAwIYV1djMucS0LTEcefEQNQ7p4S+PKtzZjVWNH54Ntee7C/Ksy+ii3vqLetxGeFY0OcRqZoZrA0o=
X-Received: by 2002:a17:902:d485:b0:223:49ce:67a2 with SMTP id
 d9443c01a7336-22bea4fde36mr56822945ad.9.1744644775158; Mon, 14 Apr 2025
 08:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250413160608.2198429-1-alexander.deucher@amd.com>
 <20250413160608.2198429-3-alexander.deucher@amd.com>
 <36ea9a52-9a39-484a-8100-bde07d320db2@amd.com>
In-Reply-To: <36ea9a52-9a39-484a-8100-bde07d320db2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Apr 2025 11:32:43 -0400
X-Gm-Features: ATxdqUGiTt6priUCxbQ3YKn9Qo340r8nEP67l2-pBHyfVmlPznywaMfUdUnuNwg
Message-ID: <CADnq5_N4GxmP+79H+PRSeckEy+_YRKiOf+dUaWVK56rc00Y5pQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] drm/sdma6: properly reference trap interrupts for
 userqs
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Apr 14, 2025 at 5:59=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
> Same explanation as patch 1 of the series here too. Do we want to depend
> on the disable_kq flag solely to enable/disable sdma trap.
> IIUC, we dont want to do it in case of kernel queues at all and only
> needed when using userqueue and that is taken care by using the flag
> disable_kq.

I think doing it this way makes the most sense because you are using
the presence of user queues to determine whether or not to take the
extra references.  We don't really care what the status of kernel
queues are.

Alex

>
> Regards
> Sunil Khatri
>
> On 4/13/2025 9:36 PM, Alex Deucher wrote:
> > We need to take a reference to the interrupts to make
> > sure they stay enabled even if the kernel queues have
> > disabled them.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 31 +++++++++++++++++++++++++=
-
> >   1 file changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v6_0.c
> > index 2249a1ef057bf..c3d53974e7f53 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> > @@ -1377,11 +1377,39 @@ static int sdma_v6_0_sw_fini(struct amdgpu_ip_b=
lock *ip_block)
> >       return 0;
> >   }
> >
> > +static int sdma_v6_0_set_userq_trap_interrupts(struct amdgpu_device *a=
dev,
> > +                                            bool enable)
> > +{
> > +     unsigned int irq_type;
> > +     int i, r;
> > +
> > +     if (adev->userq_funcs[AMDGPU_HW_IP_DMA]) {
> > +             for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > +                     irq_type =3D AMDGPU_SDMA_IRQ_INSTANCE0 + i;
> > +                     if (enable)
> > +                             r =3D amdgpu_irq_get(adev, &adev->sdma.tr=
ap_irq,
> > +                                                irq_type);
> > +                     else
> > +                             r =3D amdgpu_irq_put(adev, &adev->sdma.tr=
ap_irq,
> > +                                                irq_type);
> > +                     if (r)
> > +                             return r;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static int sdma_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
> >   {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> > +     int r;
> >
> > -     return sdma_v6_0_start(adev);
> > +     r =3D sdma_v6_0_start(adev);
> > +     if (r)
> > +             return r;
> > +
> > +     return sdma_v6_0_set_userq_trap_interrupts(adev, true);
> >   }
> >
> >   static int sdma_v6_0_hw_fini(struct amdgpu_ip_block *ip_block)
> > @@ -1393,6 +1421,7 @@ static int sdma_v6_0_hw_fini(struct amdgpu_ip_blo=
ck *ip_block)
> >
> >       sdma_v6_0_ctxempty_int_enable(adev, false);
> >       sdma_v6_0_enable(adev, false);
> > +     sdma_v6_0_set_userq_trap_interrupts(adev, false);
> >
> >       return 0;
> >   }
