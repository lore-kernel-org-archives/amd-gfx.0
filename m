Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00755C71136
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 15:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A2F810E761;
	Tue, 17 Jun 2025 15:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kIn26j0u";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04AE710E756
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 15:05:56 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-312efc384fcso1037785a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750172755; x=1750777555; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ys3Diz/D6sf9w0PEvf6EbpFGXVJlyjiQMANeOsZj+A=;
 b=kIn26j0u3ZblYday37XCqij+7+P6DWSwUDlPmVi7UwaydWFGD+3gb0pWDYrl91K9Hk
 o45Y5ePbt2g80a2TQyCTtXt+XnyUBNH6L+m7cKXf2I/3spFGWnRX9cGZYF0y/ecOVHqR
 3uKEQZAVJ2MelVtQzbCOS2YU6FwVfJz6g8K2QzZSQPBdfVkB/b2jd4rIodZOkX+noEE6
 k2tgTFFH9IIAhR5Jze+a6f6amwGrUr+khxcWMXpjRA47UDLO31wtw4e0J5UGzK8gt8HQ
 nx/ys8YQdGhyMqasM4pF8YTvpp8s4wXZNzHnlPNVuD4R7jOhN8WnxA09IgBDBG1E89Bq
 AnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750172755; x=1750777555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ys3Diz/D6sf9w0PEvf6EbpFGXVJlyjiQMANeOsZj+A=;
 b=PzplKhyjejADgJZdJ0zZAg/QAnNWnk7yUayTIrfCqACeueOlZZbalvufjFY2rJ4Z9+
 qebDu5W89juRnms2lZlNQwlLVp9YIFoN+Cqp0ovCdcvWL+uzRHMHtwMXm6WIETk88j19
 wS0NazGztiKnBeXis4mxEFCdAa20Rn3bK5/9mjANIrJMAXNy2kHBi5pv0SOeEZnt7bom
 o4yfzWLck+T2jidBlzwn4g5aau+0yeNLuvkYDSCYuWVQQaq3q3fMHZzjafDhr3VGNPop
 c2Tf0BXvH25404uDRRGJYdjJSM1HGFGUKwzZl0zTuDXJNNpR+P5bJ5iV1P8tWzyxpAg0
 uBoQ==
X-Gm-Message-State: AOJu0YxqXIYdiVbp4xpXevy4LgtAlVWIE0kvkLLc/Fo69Y2Cw1vgmMvx
 5nDqKXkTtRG10Aw7eH9UQMi+F1D6XsBCXsstAgSDtyVjSDv+xqgv0gYe/jYqB+5N/+aSYZ8g9pO
 QTEtEMLyQSHLtCqSsr3AefouBN2/dUMg=
X-Gm-Gg: ASbGncs4u6F8zoMNczjiLcJqqkgEpRcq9Ak22vuZSbayWe7Y/mIFLE9ju19GSjYlB9H
 FaxDZXAiyMkPrEDg8IqaIz0mnuQNvCB9KR+6KpvspqNuu1SXBURW5Ke2xIgWsVtU40roqGC+eo/
 XTnfsIJBNu76w0uTgKHxQF0Fxm0Zzf2a03GtdIre77ELJ3
X-Google-Smtp-Source: AGHT+IGj2/nxw+U5x40YQUrQkd0SaCI7cupQXDs0QRpLNALBQJ28ehdNng5mkVEfyp9Ft/afTvB/O3jVMavXVT721D8=
X-Received: by 2002:a17:90b:4c05:b0:311:9c9a:58e8 with SMTP id
 98e67ed59e1d1-31425b2d004mr1944896a91.7.1750172755270; Tue, 17 Jun 2025
 08:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250617080151.1093481-1-Prike.Liang@amd.com>
In-Reply-To: <20250617080151.1093481-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Jun 2025 11:05:42 -0400
X-Gm-Features: AX0GCFvz7rmNF3rpOffOumddLl1Lwj0KHTxNKK14YF_KyjHUf6sraa2Nszqe7lw
Message-ID: <CADnq5_OUsbVkxastzjww=J35a8BiA24n6oaH-NRM2b0yarfZ5Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/11] drm/amdgpu: validate userq input args
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

On Tue, Jun 17, 2025 at 4:11=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> This will help on validating the userq input args, and
> rejecting for the invalidate userq request at the IOCTLs
> first place.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 80 +++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 14 ++--
>  2 files changed, 62 insertions(+), 32 deletions(-)
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

args->in.queue_va of 0 is also invalid.

> +                               args->in.queue_size =3D=3D 0) {
> +                       drm_file_err(filp, "invalidate userq queue va or =
size\n");
> +                       return -EINVAL;
> +               }
> +               if (!args->in.wptr_va || !args->in.rptr_va) {

AMDGPU_BO_INVALID_OFFSET is also invalid for these pointers.

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
> index d6f50b13e2ba..39decc0b00f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -208,6 +208,13 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
mgr *uq_mgr,
>         struct amdgpu_mqd_prop *userq_props;
>         int r;
>
> +       /* validate the user va at early time to avoid the time cost on b=
uilding memory resource*/
> +       if (!mqd_user->wptr_va || !mqd_user->rptr_va ||
> +                       !mqd_user->queue_va || mqd_user->queue_size =3D=
=3D 0) {
> +               DRM_ERROR("Invalid MQD parameters for userqueue\n");
> +               return -EINVAL;
> +       }

I think we can drop this as you already validate these in
amdgpu_userq_input_args_validate().

Alex

> +
>         /* Structure to initialize MQD for userqueue using generic MQD in=
it function */
>         userq_props =3D kzalloc(sizeof(struct amdgpu_mqd_prop), GFP_KERNE=
L);
>         if (!userq_props) {
> @@ -215,13 +222,6 @@ static int mes_userq_mqd_create(struct amdgpu_userq_=
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
