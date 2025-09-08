Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24AECA1016
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 21:38:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E3EF10E5EB;
	Mon,  8 Sep 2025 21:38:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E+I7aad9";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 992F010E5EB
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 21:38:58 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-24cda620e37so10499115ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 14:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757367538; x=1757972338; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WpDODdT/JxFw/IsoGlOZjrffal7U3CZ3bw46KJCc/A0=;
 b=E+I7aad90/5JCM5lDDFppJtJ+Ifst9XPnkwqcaKlq8k59BD1JW7j+Vq3UlrutUAAcW
 Fj2/+0GoMsv8OP2264wQXfD7QCtfXfPuCftD5jukhG3YBi+poK5drxmAHihcUIq0F8km
 QusjsBJuRWq0ju312C/IUha2oB/kJTkZocuXZh45MMBPkx8i+eUQcmbrKudsnXl8HPPb
 1PbgO84IIzPV2UN/jPQKUkHKaZw+ioBHtVpXIk8mwJ949v9ZO/2UPvdTZgukS4FvaFo1
 EIllYDtpM15Bfnf2bDmga+cDwGzwADMrA1CXWEAHKMojpMLWy28zog1kJulvrTFayTm8
 mnng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757367538; x=1757972338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WpDODdT/JxFw/IsoGlOZjrffal7U3CZ3bw46KJCc/A0=;
 b=Qu7LwDKXqZPrqECY+gtQsZ3ik3/7zLCNwrgntlqM1jiITBTQw0VW58YNdoYkRxm+/S
 rJhL44j2C24aVRiWChRukfrmF0RB5gJ/5b0ZtIepRHCLoJUC9QBfpU0AXZ7ujBi9JssG
 /e47xR/UrJNbS/SIlM0oQdw+5vSnuHcWjWPvIZet1KIFHSotTCasj9Axd6KIFN6a+J+z
 AXrNLzBj/0YOAcuZschHfyfFMInTxyIpel8sFvn+KWU4n+ErbX98FCcMxCm8KDJunv9L
 w4kR8Jy8oN5EZIsdDFCMBXQDXa2+3h9GKjomfuXVsyTkK1heYm8fSK/IMm8Fl1Yo7BG6
 ET6w==
X-Gm-Message-State: AOJu0YyUeh9y6UuullsWxdCHaDASxi/h8i+c0GXiZcXqodRgsh0z8Reb
 F7vPcZlLZvrOMzrvY9LAvKQ6zaOpBJPHdzkXcdLg9arMbkGso+D3gxMdZOtlLTl0Zq4CMd2QHHz
 JKTTYJLyxS+CxLBaLk6nwVTVbvKlIO6Q=
X-Gm-Gg: ASbGncu/hO4E/OBBw5U9iXG0Qf89vLsDa4bZc53D3VQ7iSeYA+Q0fcdo89+ZE6J/hw2
 i79/PVxdZWBxWsZZvkIpK3mfIIPQQ6UNwwE4aIlDlWmRoOeX/pdvp246mggO/tvKvA+5RD2Jj4i
 FPw5KHZ0H+GFKyOC2h7AkUFDEEathZbbWt5kuxxQYUiPtNXPdSI51NNcodn0IJjASjVjXzQEJZF
 8pcRK0ipiP2xdqXTA==
X-Google-Smtp-Source: AGHT+IEW4xgHRPJptQ4jGUTssiC6jdmQVkd3Fa1IZxIWf06Bu2aEwYufh8ePZZHH4PCwHV1044F1ys2Uj8+LH/NiMPs=
X-Received: by 2002:a17:902:f54c:b0:24c:cb6b:103e with SMTP id
 d9443c01a7336-251757bb582mr62818545ad.8.1757367537940; Mon, 08 Sep 2025
 14:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Sep 2025 17:38:46 -0400
X-Gm-Features: Ac12FXzXwdV6Cdh2RgMPoU3Uac52q85J_aPuDn6VpaKvO1Ku0t8da3cu0Fvtl7o
Message-ID: <CADnq5_Mbof3bemQxU6mWKA1En_roDhVz1Wim_cLuuK42HHjPhQ@mail.gmail.com>
Subject: Re: [PATCH v10 01/14] drm/amdgpu: validate userq input args
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
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

I think you can land patches 1, 2, 7, and 12.

Alex

On Mon, Sep 8, 2025 at 4:59=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> wr=
ote:
>
> This will help on validating the userq input args, and
> rejecting for the invalid userq request at the IOCTLs
> first place.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 81 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 --
>  2 files changed, 56 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 295e7186e156..7f9dfeae4322 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -359,27 +359,10 @@ amdgpu_userq_create(struct drm_file *filp, union dr=
m_amdgpu_userq *args)
>                 (args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORIT=
Y_MASK) >>
>                 AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
>
> -       /* Usermode queues are only supported for GFX IP as of now */
> -       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX &&
> -           args->in.ip_type !=3D AMDGPU_HW_IP_DMA &&
> -           args->in.ip_type !=3D AMDGPU_HW_IP_COMPUTE) {
> -               drm_file_err(uq_mgr->file, "Usermode queue doesn't suppor=
t IP type %u\n",
> -                            args->in.ip_type);
> -               return -EINVAL;
> -       }
> -
>         r =3D amdgpu_userq_priority_permit(filp, priority);
>         if (r)
>                 return r;
>
> -       if ((args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE) &&
> -           (args->in.ip_type !=3D AMDGPU_HW_IP_GFX) &&
> -           (args->in.ip_type !=3D AMDGPU_HW_IP_COMPUTE) &&
> -           !amdgpu_is_tmz(adev)) {
> -               drm_file_err(uq_mgr->file, "Secure only supported on GFX/=
Compute queues\n");
> -               return -EINVAL;
> -       }
> -
>         r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>         if (r < 0) {
>                 drm_file_err(uq_mgr->file, "pm_runtime_get_sync() failed =
for userqueue create\n");
> @@ -485,22 +468,45 @@ amdgpu_userq_create(struct drm_file *filp, union dr=
m_amdgpu_userq *args)
>         return r;
>  }
>
> -int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> -                      struct drm_file *filp)
> +static int amdgpu_userq_input_args_validate(struct drm_device *dev,
> +                                       union drm_amdgpu_userq *args,
> +                                       struct drm_file *filp)
>  {
> -       union drm_amdgpu_userq *args =3D data;
> -       int r;
> +       struct amdgpu_device *adev =3D drm_to_adev(dev);
>
>         switch (args->in.op) {
>         case AMDGPU_USERQ_OP_CREATE:
>                 if (args->in.flags & ~(AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PR=
IORITY_MASK |
>                                        AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SE=
CURE))
>                         return -EINVAL;
> -               r =3D amdgpu_userq_create(filp, args);
> -               if (r)
> -                       drm_file_err(filp, "Failed to create usermode que=
ue\n");
> -               break;
> +               /* Usermode queues are only supported for GFX IP as of no=
w */
> +               if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX &&
> +                   args->in.ip_type !=3D AMDGPU_HW_IP_DMA &&
> +                   args->in.ip_type !=3D AMDGPU_HW_IP_COMPUTE) {
> +                       drm_file_err(filp, "Usermode queue doesn't suppor=
t IP type %u\n",
> +                                    args->in.ip_type);
> +                       return -EINVAL;
> +               }
> +
> +               if ((args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SEC=
URE) &&
> +                   (args->in.ip_type !=3D AMDGPU_HW_IP_GFX) &&
> +                   (args->in.ip_type !=3D AMDGPU_HW_IP_COMPUTE) &&
> +                   !amdgpu_is_tmz(adev)) {
> +                       drm_file_err(filp, "Secure only supported on GFX/=
Compute queues\n");
> +                       return -EINVAL;
> +               }
>
> +               if (args->in.queue_va =3D=3D AMDGPU_BO_INVALID_OFFSET ||
> +                   args->in.queue_va =3D=3D 0 ||
> +                   args->in.queue_size =3D=3D 0) {
> +                       drm_file_err(filp, "invalidate userq queue va or =
size\n");
> +                       return -EINVAL;
> +               }
> +               if (!args->in.wptr_va || !args->in.rptr_va) {
> +                       drm_file_err(filp, "invalidate userq queue rptr o=
r wptr\n");
> +                       return -EINVAL;
> +               }
> +               break;
>         case AMDGPU_USERQ_OP_FREE:
>                 if (args->in.ip_type ||
>                     args->in.doorbell_handle ||
> @@ -514,6 +520,31 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void =
*data,
>                     args->in.mqd ||
>                     args->in.mqd_size)
>                         return -EINVAL;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> +                      struct drm_file *filp)
> +{
> +       union drm_amdgpu_userq *args =3D data;
> +       int r;
> +
> +       if (amdgpu_userq_input_args_validate(dev, args, filp) < 0)
> +               return -EINVAL;
> +
> +       switch (args->in.op) {
> +       case AMDGPU_USERQ_OP_CREATE:
> +               r =3D amdgpu_userq_create(filp, args);
> +               if (r)
> +                       drm_file_err(filp, "Failed to create usermode que=
ue\n");
> +               break;
> +
> +       case AMDGPU_USERQ_OP_FREE:
>                 r =3D amdgpu_userq_destroy(filp, args->in.queue_id);
>                 if (r)
>                         drm_file_err(filp, "Failed to destroy usermode qu=
eue\n");
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index d6f50b13e2ba..1457fb49a794 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -215,13 +215,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>                 return -ENOMEM;
>         }
>
> -       if (!mqd_user->wptr_va || !mqd_user->rptr_va ||
> -           !mqd_user->queue_va || mqd_user->queue_size =3D=3D 0) {
> -               DRM_ERROR("Invalid MQD parameters for userqueue\n");
> -               r =3D -EINVAL;
> -               goto free_props;
> -       }
> -
>         r =3D amdgpu_userq_create_object(uq_mgr, &queue->mqd, mqd_hw_defa=
ult->mqd_size);
>         if (r) {
>                 DRM_ERROR("Failed to create MQD object for userqueue\n");
> --
> 2.34.1
>
