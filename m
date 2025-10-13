Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76577CCD183
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 13:43:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1917D10E393;
	Mon, 13 Oct 2025 13:43:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bHRtw+HH";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AFDA10E380
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 13:43:14 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-26808b24a00so6351165ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 06:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760362994; x=1760967794; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kYChUgi8LjENHZMu/sI/jJPOxwtcECIht7HS9fEO/uw=;
 b=bHRtw+HH2gf0GLqKtMyCqv6+tA9usSAox4A014/OGEyiiyEjQ43n0SwqIz3WtojaV1
 qhR4KOHaYdUrWjuO/yCMFYsINfyoNobjZt1Q2bWIEjv48H8cEXTaRwp8NCH9B1yyd7UA
 QN+ZOCbhN0pYLeHMsMxq9OTA8Mtsc87c8rMboqngYRBCg5bNU8OFtXJ+0UT9TYrbACzP
 j5qZsbnGMaH7LT/AVoxgU6nLLzORYmXOrubgVqtt+E7Jz0Ingc8kx2iWTK28s/WDfgqF
 WpLM0M5roajUQJCxwXSsIvHAF3Eu7jSvOQWeN7EuBbnbLFXQvpzxGlhT8MIQDxFmGWid
 /bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760362994; x=1760967794;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYChUgi8LjENHZMu/sI/jJPOxwtcECIht7HS9fEO/uw=;
 b=ZZZaUrewUy4UFQro3vaNPcjV4KpQO48DG8dHbJrrlPmZoTRFOB/Kwq81KaMo1P8o+R
 8xa/nwFvUgrgIKAg6qlyxvOAZkv5nN6PCz/CRFWozltS2k3jZwbOGYZ9kUsO6eGs+xHH
 Sc9SOii9GdAdJN7SLwzqllupfQiyu7+0jpEbx8JBQEeuFvrT3zCM3EpepD2uEitl2u4I
 ueZ1HltKN0uOPrA6Oo352rfJLWaDP3Fia7njsjOJLWOkwAj4kRby+cspW+UzSqlEpcmK
 kTBbUnyXtDsFIPoz+QDK5QjrZjMHkqQzviBxM4bqIz+5zdf8pWozQrpWo1GCRZxUvxhe
 S9Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb9asaIL012gCigJTwlgX3kh5pmqIHyPU4Jlyzyuk4XrwQV7uk/BhELpT8xBvCNO9uSEWgVVwC@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjSJd615UfEemdUpyKQUXQEAopFDQBM2BnMW1d530Geh+Su3MR
 IKZ5z+2/LPPZfrqt8UDh80P6fZ4eTnF8lkprCGNjdDkyV2fVRo8GFy9ZLFdbETJJrHrMwUBxkmn
 IS034IV7m1535K0n+qeTxqly9Df4BUOI=
X-Gm-Gg: ASbGnct0riQvpXa69f/JxereRCSnB89zE+u9AM6YCB8zRg0ghgTxntIMJXLYajxk47M
 gZqT2GG2JKxea9IQSqZ8DZvYCnjKVQfpdWDLuFJRiYnHUGBkwbJxFVxR+0UIEgDxgOYhqPuyBv7
 OEJzlpuyPxEl2Bk8Ut063xNQxm9sfy/T+wzAvhPsMzyWentkYNicdvvKyoi6ecdcvcT5lMTWe2H
 gc+hTcPckc9Wzy2u6/A0EnzvA==
X-Google-Smtp-Source: AGHT+IFTja6DwofTPYw6RVlMAhNDPvJFYiCzISjjhQbwQof90sBrx9jT5ij9iHoHRv9gW0qHqv0wt8I4iqdEQ3amlHU=
X-Received: by 2002:a17:902:a608:b0:290:552b:1b97 with SMTP id
 d9443c01a7336-290552b2498mr38836765ad.7.1760362993805; Mon, 13 Oct 2025
 06:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20251010211510.1528572-1-alexander.deucher@amd.com>
 <20251010211510.1528572-2-alexander.deucher@amd.com>
 <DS7PR12MB6005B24D4FB1959CA75A6B3DFBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005B24D4FB1959CA75A6B3DFBEAA@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Oct 2025 09:43:02 -0400
X-Gm-Features: AS18NWD_GkNnGqYIZE0U0kKnUgqdJP2oB1nW1BLxQ9b3LfmtjCAyv2nkLLqS9fw
Message-ID: <CADnq5_Mf2kH0YvkMBFnOFRo4zGCD=3X4Kcc2mqi4i5p_6h5a3w@mail.gmail.com>
Subject: Re: [PATCH 2/7] drm/amdgpu/userq: fix SDMA and compute validation
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Oct 13, 2025 at 4:51=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Saturday, October 11, 2025 5:15 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 2/7] drm/amdgpu/userq: fix SDMA and compute validation
> >
> > The CSA and EOP buffers have different alignement requirements.
> > Hardcode them for now as a bug fix.  A proper query will be added in a =
subsequent
> > patch.
> >
> > Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address=
 and size")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > index 0370ef719a6aa..ab392de2a2388 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > @@ -254,7 +254,6 @@ static int mes_userq_mqd_create(struct
> > amdgpu_userq_mgr *uq_mgr,
> >       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_ty=
pe];
> >       struct drm_amdgpu_userq_in *mqd_user =3D args_in;
> >       struct amdgpu_mqd_prop *userq_props;
> > -     struct amdgpu_gfx_shadow_info shadow_info;
> >       int r;
> >
> >       /* Structure to initialize MQD for userqueue using generic MQD in=
it function */
> > @@ -280,8 +279,6 @@ static int mes_userq_mqd_create(struct
> > amdgpu_userq_mgr *uq_mgr,
> >       userq_props->doorbell_index =3D queue->doorbell_index;
> >       userq_props->fence_address =3D queue->fence_drv->gpu_addr;
> >
> > -     if (adev->gfx.funcs->get_gfx_shadow_info)
> > -             adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, =
true);
> >       if (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE) {
> >               struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> >
> > @@ -299,7 +296,7 @@ static int mes_userq_mqd_create(struct
> > amdgpu_userq_mgr *uq_mgr,
> >               }
> >
> >               r =3D amdgpu_userq_input_va_validate(queue, compute_mqd->=
eop_va,
> > -                                                max_t(u32, PAGE_SIZE,
> > AMDGPU_GPU_PAGE_SIZE));
> > +                                                2048);
> [Prike] How did this issue occur? If we hardcode the value here, will use=
rspace driver EOP buffer requests still be compatible?
> We may need to add a TODO comment to replace this with proper EOP-size qu=
eries in a future change.

It's just temporary to make the patch easier to backport.  It's fixed
properly later in this series.

>
> >               if (r)
> >                       goto free_mqd;
> >
> > @@ -312,6 +309,9 @@ static int mes_userq_mqd_create(struct
> > amdgpu_userq_mgr *uq_mgr,
> >               kfree(compute_mqd);
> >       } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) {
> >               struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
> > +             struct amdgpu_gfx_shadow_info shadow_info;
> > +
> > +             adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, =
true);
> [Prike]  We may need to validate the get_gfx_shadow_info() callback befor=
e using it.

It should always be implemented for user queues.  If it's not, we
don't have a way to know what the user queue metadata sizes are.

Alex

>
> >               if (mqd_user->mqd_size !=3D sizeof(*mqd_gfx_v11) || !mqd_=
user->mqd)
> > {
> >                       DRM_ERROR("Invalid GFX MQD\n");
> > @@ -335,6 +335,10 @@ static int mes_userq_mqd_create(struct
> > amdgpu_userq_mgr *uq_mgr,
> >                                                  shadow_info.shadow_siz=
e);
> >               if (r)
> >                       goto free_mqd;
> > +             r =3D amdgpu_userq_input_va_validate(queue, mqd_gfx_v11->=
csa_va,
> > +                                                shadow_info.csa_size);
> > +             if (r)
> > +                     goto free_mqd;
> >
> >               kfree(mqd_gfx_v11);
> >       } else if (queue->queue_type =3D=3D AMDGPU_HW_IP_DMA) { @@ -353,7
> > +357,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_mgr *uq_m=
gr,
> >                       goto free_mqd;
> >               }
> >               r =3D amdgpu_userq_input_va_validate(queue, mqd_sdma_v11-
> > >csa_va,
> > -                                                shadow_info.csa_size);
> > +                                                32);
> >               if (r)
> >                       goto free_mqd;
> >
> > --
> > 2.51.0
>
