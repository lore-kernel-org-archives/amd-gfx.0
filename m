Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485A0C636CD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Feb 2023 14:54:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4018C10E51A;
	Tue,  7 Feb 2023 14:54:44 +0000 (UTC)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 391E010E51A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Feb 2023 14:54:42 +0000 (UTC)
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-15f97c478a8so19220874fac.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Feb 2023 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NbakWlDwm7xjeEr07n7Q8JtkPdE3RlwlqqE9ZM1fnmg=;
 b=f13lBM1VykWJT0HOsiTACdGJ4M5KJgsRRJqHzwlJbWvSr65hV1nPxBmwiCFtR/8QaA
 nxi+aiHrK6aV7PcN3wgLLuBXwrbhq1FUmAQoasBj1w1MQr5O292sZlnMf1QG/BR2TYmK
 QzCkFX0hcqe8Tx8Hqr04P1i/U2PaTxf+cvue9P29vgI8thn/OolcOEDWi50yucaNeQrc
 zTW7ZKrfk+f7Wd8hy3Fj9UyM5E6jWpgCckqlNk2Vp4W2GGgpY9M+mrrMt7Ke7wvYQ4qg
 sYwNpK8iuZj1+4HXXQ1AU3kotNESz/iXPirquDdI9nDHZndU9xkSkpwbaokaDfPY6ph+
 i2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NbakWlDwm7xjeEr07n7Q8JtkPdE3RlwlqqE9ZM1fnmg=;
 b=3/YXaj1b9nYFk8mWzqPO0GlR1Nx6O02+RxQexbhib4P23iZMyemxMvU9MA2Dc30UZ7
 jpHNfgjlfw22MplG3Tgb8kTyMc2nRfFlX8kGK4Ygr0vQQD1rshG8XscZRHsILpCtbbM2
 oCPdPeyFNSWvmSDKfKIjw6zyEfrz+Z9x45QYiDH41GFgbnBIwv6b8GCHSStnIOQTL2wP
 6bXqsSVe60SJxfHdumbrrTTMekpg3gvjg2h/pdhVcYamn7d0bJOqigZdgFiOtz1/gjFi
 B2a9WK9g6M4U27l5LFCqGH4RHwF7zv7EJxUk0cJ2oXPamNUjlD23kUzTLbxlSin25QV2
 xYnA==
X-Gm-Message-State: AO0yUKVUUW+LVFtTZFZhqlUvKdpIdCTe0t3c6tSNaMVRPXrhaJ4fcDEX
 /+r72Pwku63MyEKDSOm4VkRRP5Tq28SUDFfDTnoEABAU
X-Google-Smtp-Source: AK7set+QOKfluCMqPNuNLtGG/hCqJxzhgwbIhV+lMHWSskcQJoLxzBr5vgF79AtyQgdBvuvEycsPYqp7WBVyKg40o0g=
X-Received: by 2002:a05:6870:891f:b0:163:8cc6:86a with SMTP id
 i31-20020a056870891f00b001638cc6086amr2726737oao.46.1675781681420; Tue, 07
 Feb 2023 06:54:41 -0800 (PST)
MIME-Version: 1.0
References: <20230203215409.2021-1-shashank.sharma@amd.com>
 <20230203215409.2021-3-shashank.sharma@amd.com>
In-Reply-To: <20230203215409.2021-3-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 7 Feb 2023 09:54:29 -0500
Message-ID: <CADnq5_PrwDps_LzfyBREk5=JvGfvu11NkePydnPOGjSC6kjmag@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/amdgpu: add usermode queues
To: Shashank Sharma <shashank.sharma@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 3, 2023 at 4:54 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch adds skeleton code for usermode queue creation. It
> typically contains:
> - A new structure to keep all the user queue data in one place.
> - An IOCTL function to create/free a usermode queue.
> - A function to generate unique index for the queue.
> - A queue context manager in driver private data.
>
> V1: Worked on design review comments from RFC patch series:
> (https://patchwork.freedesktop.org/series/112214/)
>
> - Alex: Keep a list of queues, instead of single queue per process.
> - Christian: Use the queue manager instead of global ptrs,
>            Don't keep the queue structure in amdgpu_ctx
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 155 ++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |  64 ++++++++
>  6 files changed, 230 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_userqueue.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 798d0e9a60b7..764801cc8203 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -210,6 +210,8 @@ amdgpu-y += \
>  # add amdkfd interfaces
>  amdgpu-y += amdgpu_amdkfd.o
>
> +# add usermode queue
> +amdgpu-y += amdgpu_userqueue.o
>
>  ifneq ($(CONFIG_HSA_AMD),)
>  AMDKFD_PATH := ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 6b74df446694..0625d6bdadf4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -109,6 +109,7 @@
>  #include "amdgpu_fdinfo.h"
>  #include "amdgpu_mca.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_userqueue.h"
>
>  #define MAX_GPU_INSTANCE               16
>
> @@ -482,6 +483,7 @@ struct amdgpu_fpriv {
>         struct mutex            bo_list_lock;
>         struct idr              bo_list_handles;
>         struct amdgpu_ctx_mgr   ctx_mgr;
> +       struct amdgpu_userq_mgr userq_mgr;
>  };
>
>  int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index b4f2d61ea0d5..229976a2d0e7 100644
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
> @@ -2748,6 +2749,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>
>  static const struct drm_driver amdgpu_kms_driver = {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 7aa7e52ca784..52e61e339a88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1187,6 +1187,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
>
>         amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
>
> +       r = amdgpu_userq_mgr_init(&fpriv->userq_mgr, adev);
> +       if (r)
> +               DRM_WARN("Can't setup usermode queues, only legacy workload submission will work\n");
> +
>         file_priv->driver_priv = fpriv;
>         goto out_suspend;
>
> @@ -1254,6 +1258,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
>
>         amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
>         amdgpu_vm_fini(adev, &fpriv->vm);
> +       amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
>
>         if (pasid)
>                 amdgpu_pasid_free_delayed(pd->tbo.base.resv, pasid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> new file mode 100644
> index 000000000000..d5bc7fe81750
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -0,0 +1,155 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +
> +static inline int
> +amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_queue *queue)
> +{
> +    return idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ, GFP_KERNEL);
> +}
> +
> +static inline void
> +amdgpu_userqueue_free_index(struct amdgpu_userq_mgr *uq_mgr, int queue_id)
> +{
> +    idr_remove(&uq_mgr->userq_idr, queue_id);
> +}
> +
> +static struct amdgpu_usermode_queue
> +*amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
> +{
> +    return idr_find(&uq_mgr->userq_idr, qid);
> +}
> +
> +static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *args)
> +{
> +    int r, pasid;
> +    struct amdgpu_usermode_queue *queue;
> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +    struct amdgpu_vm *vm = &fpriv->vm;
> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
> +
> +    pasid = vm->pasid;
> +    if (vm->pasid < 0) {
> +        DRM_WARN("No PASID info found\n");
> +        pasid = 0;
> +    }
> +
> +    mutex_lock(&uq_mgr->userq_mutex);
> +
> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
> +    if (!queue) {
> +        DRM_ERROR("Failed to allocate memory for queue\n");
> +        mutex_unlock(&uq_mgr->userq_mutex);
> +        return -ENOMEM;
> +    }
> +
> +    queue->vm = vm;
> +    queue->pasid = pasid;
> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
> +    queue->queue_size = mqd_in->queue_size;
> +    queue->queue_type = mqd_in->ip_type;
> +    queue->queue_gpu_addr = mqd_in->queue_va;
> +    queue->flags = mqd_in->flags;
> +    queue->use_doorbell = true;

I think we can drop use_doorbell.  All user queues require a doorbell.

Alex

> +    queue->queue_id = amdgpu_userqueue_index(uq_mgr, queue);
> +    if (queue->queue_id < 0) {
> +        DRM_ERROR("Failed to allocate a queue id\n");
> +        r = queue->queue_id;
> +        goto free_queue;
> +    }
> +
> +    list_add_tail(&queue->userq_node, &uq_mgr->userq_list);
> +    args->out.q_id = queue->queue_id;
> +    args->out.flags = 0;
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    return 0;
> +
> +free_queue:
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    kfree(queue);
> +    return r;
> +}
> +
> +static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
> +{
> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +    struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
> +    struct amdgpu_usermode_queue *queue;
> +
> +    queue = amdgpu_userqueue_find(uq_mgr, queue_id);
> +    if (!queue) {
> +        DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
> +        return;
> +    }
> +
> +    mutex_lock(&uq_mgr->userq_mutex);
> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> +    list_del(&queue->userq_node);
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    kfree(queue);
> +}
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> +                      struct drm_file *filp)
> +{
> +    union drm_amdgpu_userq *args = data;
> +    int r = 0;
> +
> +    switch (args->in.op) {
> +    case AMDGPU_USERQ_OP_CREATE:
> +        r = amdgpu_userqueue_create(filp, args);
> +        if (r)
> +            DRM_ERROR("Failed to create usermode queue\n");
> +        break;
> +
> +    case AMDGPU_USERQ_OP_FREE:
> +        amdgpu_userqueue_destroy(filp, args->in.queue_id);
> +        break;
> +
> +    default:
> +        DRM_ERROR("Invalid user queue op specified: %d\n", args->in.op);
> +        return -EINVAL;
> +    }
> +
> +    return r;
> +}
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev)
> +{
> +    mutex_init(&userq_mgr->userq_mutex);
> +    idr_init_base(&userq_mgr->userq_idr, 1);
> +    INIT_LIST_HEAD(&userq_mgr->userq_list);
> +    userq_mgr->adev = adev;
> +
> +    return 0;
> +}
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
> +{
> +    idr_destroy(&userq_mgr->userq_idr);
> +    mutex_destroy(&userq_mgr->userq_mutex);
> +}
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> new file mode 100644
> index 000000000000..9557588fe34f
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -0,0 +1,64 @@
> +/*
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef AMDGPU_USERQUEUE_H_
> +#define AMDGPU_USERQUEUE_H_
> +
> +#define AMDGPU_MAX_USERQ 512
> +
> +struct amdgpu_userq_mgr {
> +       struct idr userq_idr;
> +       struct mutex userq_mutex;
> +       struct list_head userq_list;
> +       struct amdgpu_device *adev;
> +};
> +
> +struct amdgpu_usermode_queue {
> +       int             queue_id;
> +       int             queue_type;
> +       int             queue_size;
> +       int             pasid;
> +       int             doorbell_index;
> +       int             use_doorbell;
> +
> +       uint64_t        wptr_gpu_addr;
> +       uint64_t        rptr_gpu_addr;
> +       uint64_t        queue_gpu_addr;
> +       uint64_t        flags;
> +
> +       uint64_t        mqd_gpu_addr;
> +       void            *mqd_cpu_ptr;
> +
> +       struct amdgpu_bo        *mqd_obj;
> +       struct amdgpu_vm        *vm;
> +       struct amdgpu_userq_mgr *userq_mgr;
> +       struct list_head        userq_node;
> +};
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> +
> +int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amdgpu_device *adev);
> +
> +void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
> +
> +#endif
> --
> 2.34.1
>
