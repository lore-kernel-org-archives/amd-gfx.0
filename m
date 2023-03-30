Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F5DC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 21:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F372E10E21D;
	Thu, 30 Mar 2023 21:15:36 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98EDA10E223
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 21:15:34 +0000 (UTC)
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-17ac5ee3f9cso21187809fac.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680210934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0NhEDCnfzwKwwQSVDD+KTjYYGxMKCeO7g4a7zuU+mg=;
 b=VZSepG/3JJ2QyzNmZsAWHMCz9WcgzDmtrbklr9kERDIV6WTEuVijDJMZZmLhgk3u8L
 KxHQmpOsZyRqkQonuHemU5yJAXX4kv8+N/G8Rq9iAO/BbCLa8hjXOXHIVvsQtspNNOOZ
 JgSD7MuXCWHvw3EV7KtGg0XJnbA0QaavkjrsCAobdKr3UAE4rSqdufRm2SVUseLiYsdJ
 h7nnBDogeH2f1xSP8OyeuQP3SoC2Pz+cG4qgxOKJVmsU7q6u2nV1wtXR3tsYYcgZJseZ
 gdB6jDeoEMnWMh/jNl3djc8Uuj5SglWgmiHs+7LLq4YhqiFhE9qGUJc3jbPUnDhviZ73
 fP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680210934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V0NhEDCnfzwKwwQSVDD+KTjYYGxMKCeO7g4a7zuU+mg=;
 b=Qn/ruEk8vkFAkyWU4WxnGDXrvvI1SHODVln54f5X4iY4TxbTfavv0vtJt8tLhjhiUD
 Nv3luMXvmP3H+7eP008o4pyW2ptybJDOySczNK+yyxrXiO5axvk54mrB94vaYkaIF9Ye
 cNWNhqtRu/i5I/Ci/NH8uzS3d/hkWT9fmpFy/ixaYnMb5yuKZQwn1YwfLUz0RgYnX6it
 CTH6JH0ibT2V+sO8knavci/RCEmoOUPbIZHY0a6lHsuhCHdtzENttkfsgHhSgiu7pbNi
 Ics4YXuOmejmrLMGpxrost9CTDQXaiEwCQbLbzyEM68I4OhW73oMvJ36Z3dM0PkT0pYS
 VuAg==
X-Gm-Message-State: AO0yUKVGICfkcMHQJVKvXHePJ60eXV6/+pHFvBErL3b1tMOi3u1qCXp3
 t8yRxMwsnzAvMKvcHmrxv8iUXo4cpRgF/nkOqQU=
X-Google-Smtp-Source: AKy350aoUVuocBBBUma5YbBoHKDV7wfSxIoWNIc1n7KWFwNYNXbB56ZmsDFISL7TsNdeLDebDhHqmPRU3CZxVM11zqE=
X-Received: by 2002:a05:6871:d96:b0:17e:1aaf:eb88 with SMTP id
 vi22-20020a0568710d9600b0017e1aafeb88mr7819822oab.3.1680210933840; Thu, 30
 Mar 2023 14:15:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-3-shashank.sharma@amd.com>
In-Reply-To: <20230329160445.1300-3-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Mar 2023 17:15:22 -0400
Message-ID: <CADnq5_OEWGcCxbcfLPvuA2rQdfw6QQDziOrOQ2SSF4y=-ocaRg@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] drm/amdgpu: add usermode queue base code
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 12:05=E2=80=AFPM Shashank Sharma
<shashank.sharma@amd.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch adds skeleton code for amdgpu usermode queue. It contains:
> - A new files with init functions of usermode queues.
> - A queue context manager in driver private data.
>
> V1: Worked on design review comments from RFC patch series:
> (https://patchwork.freedesktop.org/series/112214/)
> - Alex: Keep a list of queues, instead of single queue per process.
> - Christian: Use the queue manager instead of global ptrs,
>            Don't keep the queue structure in amdgpu_ctx
>
> V2:
>  - Reformatted code, split the big patch into two
>
> V3:
> - Integration with doorbell manager
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 10 +++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  6 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 39 +++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    | 49 +++++++++++++++++++
>  6 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 204665f20319..2d90ba618e5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -210,6 +210,8 @@ amdgpu-y +=3D \
>  # add amdkfd interfaces
>  amdgpu-y +=3D amdgpu_amdkfd.o
>
> +# add usermode queue
> +amdgpu-y +=3D amdgpu_userqueue.o
>
>  ifneq ($(CONFIG_HSA_AMD),)
>  AMDKFD_PATH :=3D ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 6b74df446694..c5f9af0e74ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -438,6 +438,14 @@ struct amdgpu_sa_manager {
>         uint32_t                align;
>  };
>
> +/* Gfx usermode queues */
> +struct amdgpu_userq_mgr {
> +       struct idr userq_idr;
> +       struct mutex userq_mutex;
> +       struct amdgpu_device *adev;
> +       const struct amdgpu_userq_funcs *userq_funcs[AMDGPU_HW_IP_NUM];

These function pointers can be per device rather than per userq_mgr.
Just hang them off of adev and then each IP can fill them in during
their init functions.

Alex

> +};
> +
>  /* sub-allocation buffer */
>  struct amdgpu_sa_bo {
>         struct list_head                olist;
> @@ -470,7 +478,6 @@ struct amdgpu_flip_work {
>         bool                            async;
>  };
>
> -
>  /*
>   * file private structure
>   */
> @@ -482,6 +489,7 @@ struct amdgpu_fpriv {
>         struct mutex            bo_list_lock;
>         struct idr              bo_list_handles;
>         struct amdgpu_ctx_mgr   ctx_mgr;
> +       struct amdgpu_userq_mgr userq_mgr;
>  };
>
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)=
;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b4f2d61ea0d5..2d6bcfd727c8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -52,6 +52,7 @@
>  #include "amdgpu_ras.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_reset.h"
> +#include "amdgpu_userqueue.h"
>
>  /*
>   * KMS wrapper.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 7aa7e52ca784..b16b8155a157 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -43,6 +43,7 @@
>  #include "amdgpu_gem.h"
>  #include "amdgpu_display.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_userqueue.h"
>
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
>  {
> @@ -1187,6 +1188,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev,=
 struct drm_file *file_priv)
>
>         amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>
> +       r =3D amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
> +       if (r)
> +               DRM_WARN("Can't setup usermode queues, only legacy worklo=
ad submission will work\n");
> +
>         file_priv->driver_priv =3D fpriv;
>         goto out_suspend;
>
> @@ -1254,6 +1259,7 @@ void amdgpu_driver_postclose_kms(struct drm_device =
*dev,
>
>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>         amdgpu_vm_fini(adev, &fpriv->vm);
> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>
>         if (pasid)
>                 amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> new file mode 100644
> index 000000000000..13e1eebc1cb6
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amd=
gpu_device *adev)
> +{
> +    mutex_init(&userq_mgr->userq_mutex);
> +    idr_init_base(&userq_mgr->userq_idr, 1);
> +    userq_mgr->adev =3D adev;
> +
> +    return 0;
> +}
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +    idr_destroy(&userq_mgr->userq_idr);
> +    mutex_destroy(&userq_mgr->userq_mutex);
> +}
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> new file mode 100644
> index 000000000000..7eeb8c9e6575
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -0,0 +1,49 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef AMDGPU_USERQUEUE_H_
> +#define AMDGPU_USERQUEUE_H_
> +
> +#include "amdgpu.h"
> +#define AMDGPU_MAX_USERQ 512
> +
> +struct amdgpu_usermode_queue {
> +       int queue_id;
> +       int queue_type;
> +       uint64_t flags;
> +       uint64_t doorbell_handle;
> +       struct amdgpu_vm *vm;
> +       struct amdgpu_userq_mgr *userq_mgr;
> +       struct amdgpu_mqd_prop userq_prop;
> +};
> +
> +struct amdgpu_userq_funcs {
> +       int (*mqd_create)(struct amdgpu_userq_mgr *, struct amdgpu_usermo=
de_queue *);
> +       void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_user=
mode_queue *);
> +};
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amd=
gpu_device *adev);
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
> +
> +#endif
> --
> 2.40.0
>
