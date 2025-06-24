Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1189C77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 16:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5907510E0AB;
	Tue, 24 Jun 2025 16:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZzsMh4ku";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF55B10E0AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 16:49:20 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-313756c602fso674077a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750783760; x=1751388560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yw6cWJeV8NyAQwBWVjjP2ptVR8n8Xu5CXeiObt3rmjo=;
 b=ZzsMh4ku2nyylEaHtC2RI7TTeszxw1XSNMm3U13WazkcZN5I/SQ43f8y50v5pggoO5
 mFmTEaZMxoQRICvek6uHxj//6rYbrFk2uvwB9NT27a2O91hlfGhzrhsqhwZs6dznDvbp
 h8XE9m2dL48cKuuNb3spJzUdBZP6wVFXat4u41Smbx2eY5YVNbp87u57OFaqyooGl76J
 dDp/IDu/3JZkwdnYzLXjQvcBgfdtMtVmvG8mzLOaOulkUGwW1gl58QFlV03V9kwWJB/u
 DNWDCUcI6P6bEC8l6BkkhKvr1A5kQ/ffDj2KssFHFd4GprRrB9zVHslbE1qYXTb1Y+M2
 Tz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750783760; x=1751388560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yw6cWJeV8NyAQwBWVjjP2ptVR8n8Xu5CXeiObt3rmjo=;
 b=rpF/rEhksdeBK5goqHJA396ItCbEhIyhkwEveqr/PJ/tLkvYG9YVIeJTfnFgf52Iqo
 NikONPLN7q+OVc09xO5ARRDVk0oGinfERRNuZBpSC7xPRUbaGEto2pBrcfF1UQVmc8j6
 9/kXSVXF7zH34T0w0N3aq6KfqqO493SWLHVhJAgIfETSbg7pMmBan6eS5tmgZT5izSuV
 W5Aik65ZKRvlnyazELoZTdnbhr+u6OO2p2gDljUrpEQUpvh6hKLK4Hv4TZ30x6dBywDM
 2DqK7c9K7qUMQyBug//11ZdjWO1wNgqQT4X6gQMsraPnBK3THN3puIMfX/3OXDPe5Epm
 K1Wg==
X-Gm-Message-State: AOJu0Yy08mJdZqamT73fMWFekbmY8ha2m7FDk70bvcch6SFzrdE9Mo7P
 +q26XNVPQGvAUWnu909Q8bG3kn4zrL0UM2SxrQ5/oss4MhmpYZpLxnHgGOMoj0F+V3FqgYPul4w
 6y/QX/h9Q+3Omg8uDruUVN1Pkra5htPc=
X-Gm-Gg: ASbGnctaZaaHB2UaSucj5g5/fsfXUmU7VUN+ZOAqGhTPN9cz/IVmLGw2TXeNiibiR1I
 ku3Xa0ZgkWpu0OPZdw23TY7i1JAFNizRK3qI8/Rhl34+PkVeDObdkSrr9d4FRRcKsNdxTOnEcqV
 jO7XpIwHKy+AeGSpnM84sYeZEi5sXQU8GU/DdjCnul13C2
X-Google-Smtp-Source: AGHT+IEN8PKiSuYFUkvxjDTLfr4fbKniXmHgFcjrP6vArwGg+Ak+DXaz/AW+Q4vyAEChfnLgvErN/Fw25iqNtWJfJBw=
X-Received: by 2002:a17:90b:57ec:b0:311:9c9a:58e2 with SMTP id
 98e67ed59e1d1-3159d9140e6mr8854307a91.7.1750783760250; Tue, 24 Jun 2025
 09:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
In-Reply-To: <20250624084535.1178476-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Jun 2025 12:49:08 -0400
X-Gm-Features: AX0GCFvouioTQJZDJRHn9FMnPEHl-WLEO1WyxKW4FGT4ygwVV3xq9lC7gsCyrOs
Message-ID: <CADnq5_MCDGdnaTU8Lz=SGM9y=paFyZ30Byu4wk=U6zBLH476jw@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] drm/amdgpu: validate userq input args
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian.Koenig@amd.com
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

On Tue, Jun 24, 2025 at 4:45=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> This will help on validating the userq input args, and
> rejecting for the invalid userq request at the IOCTLs
> first place.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

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
