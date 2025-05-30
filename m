Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0242AC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 21:31:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A5A410E226;
	Fri, 30 May 2025 21:31:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lASnmy94";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC52610E226
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 21:31:51 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-31271ed809dso38407a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 14:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748640711; x=1749245511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=edD1dyMdBZtLdD8GQevm7j9fV9FD4DPudy2FLg1CcFE=;
 b=lASnmy94rboAAhPrSIVyxZFlyRpdJimjlkBVvEzd+Ol5cg3m35THODOfVcRiu6F3a1
 JexeMEBWKt7QnBigfRstXBw5X78hrKwHWj9ZE/e3ot6xVxHjJdtsLYjLbaUr9vtJafEA
 CgqoQ+mSMD73foGNjb/d6PygKwC2GC6C4XIP5l8E4/h4AvR9FcvIObpdaPFnk4xKcPSl
 SqmgHbVGPssaMrR+NIMckT2u6Gg5Bd9H5gHE7vxUlOAFO/eFr/ZDKa/zhzo5QNDJNP0A
 488DKrHM64fnJiKvkku6n8CwpWMi5jKKng+LRmrkTPd4DWyg7XdP4wyxPLmVLUl9j6d1
 VIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748640711; x=1749245511;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=edD1dyMdBZtLdD8GQevm7j9fV9FD4DPudy2FLg1CcFE=;
 b=peIvselvpRTA1/yrHl2EE4h3tiFW/1M/QCBNAxJXKX4VJOLXAOsGUvLjMFZK0P61Sz
 ilbsTtWnXYAeLfiLGLRrnySgnQEYua1WfSnoZxAAS7ykW1wLKgj3DgmK+Oen9frecLRr
 jevvmiQavQiYG7wzb0wZL6aUB/1mw8dIty6sdG5HqYzQ493EEGkZjCqkAKNRspCGDc+V
 KvYRthgPjG+UbjEg77MRsA17A638+t95tTQ4uR9FBXJA9/3eIun9FMzBgP9dD1vNkG0u
 /aedOWUK2z/hHGn2oiJ6x6ziTP6MSSPfDJF+xh+G7dCt82byMpAZRpAaButvFH4z0K5S
 rK5w==
X-Gm-Message-State: AOJu0Yzo7LVUeK2yZ/Kchc1dEcz3Lkvs8mxUfWGVTUrUZkNQ5BiMTGRh
 Ab7gjcOI/O+sXhJlsCV9rojzPJ6TxXzy+MJtqUinnV5ieSXk+Wt6r0KpBHNGIOD9TnWphMtIOcq
 TQOq/8pC+RHqZtvoirm7HN5AOntVDLy9Vlg==
X-Gm-Gg: ASbGncvlC6ClVyFWXNOxqWVE/fcU/4Iwl8GWrynKci/Yrygp7oLcFqNsf09aIIbRkKR
 RgCMeCm1qCLuVXBpeQ+gbDwaDOuzNeqPwBpFHybwhqUU3XpuQ+6dB2m3J0eLYy2cyjblqvs4LaY
 BlyighuYniMyKyy5e/LwloL1mWifgIoOlTjw==
X-Google-Smtp-Source: AGHT+IEOrCYxxerkcJ79ru9+Cs4xsv8IVqiv0QX8W4TTYTubTzA3/llm2qz0F4MR2I3AjygpT7avTeyYfu27C7DdKKU=
X-Received: by 2002:a17:90a:f94d:b0:311:c939:c842 with SMTP id
 98e67ed59e1d1-3124db4c59bmr2151868a91.7.1748640711325; Fri, 30 May 2025
 14:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250530075505.882004-1-Prike.Liang@amd.com>
In-Reply-To: <20250530075505.882004-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 May 2025 17:31:39 -0400
X-Gm-Features: AX0GCFshZTBfQImLWSWHq3in9tSEsMs2tSt5Ai2wrjXVHAoU5VvHujiOyLq_pec
Message-ID: <CADnq5_OX-H2A4d0s31dJiyjAuG54yWBoiXTJ=Un0cK+ry5Kpfg@mail.gmail.com>
Subject: Re: [PATCH 1/9] drm/amdgpu: validate userq input args
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com, Lijo.Lazar@amd.com
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

On Fri, May 30, 2025 at 4:05=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> This will help on validating the userq input args, and
> rejecting for the invalidate userq request at the IOCTLs
> first place.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 80 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  7 --
>  2 files changed, 55 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 295e7186e156..f67969312c39 100644
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
> @@ -485,22 +468,44 @@ amdgpu_userq_create(struct drm_file *filp, union dr=
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
> +                               args->in.queue_size =3D=3D 0) {
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
> @@ -514,6 +519,31 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void =
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

I would keep this check here as this is MES specific at this point.

Alex

> -
>         r =3D amdgpu_userq_create_object(uq_mgr, &queue->mqd, mqd_hw_defa=
ult->mqd_size);
>         if (r) {
>                 DRM_ERROR("Failed to create MQD object for userqueue\n");
> --
> 2.34.1
>
