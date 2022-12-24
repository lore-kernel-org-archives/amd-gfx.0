Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43C6C4332F
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Dec 2022 18:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A88C710E22D;
	Sat, 24 Dec 2022 18:20:15 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58A9910E22D
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Dec 2022 18:20:13 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 30F7AB8016A
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Dec 2022 18:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63FFC433D2
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Dec 2022 18:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671906006;
 bh=1wHMfgeo+mA4vs8PetkAMKOWF7aysjnWZVjB1mEA2Kw=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=kTQO7fmP+g68MKhDYUvhhE1ihLWfGATz2fE19xGuyHi5AodD0zsvkWYoAQ2jcuQcg
 qYxl0+8lWTXvdnXiYcweAODI+E+4M5lRuVKkKTc1+F1rIP0Iq2xKw5QwyG4MjNHzFY
 XjUJKN25sG3f1XZgUg/I4lG1kybxV+IHvNk7i+2yZVSa2CNpSHIC8vH5fKMoJFI3yX
 SpHJR4W+mXw1ZuIBuLL0lELluFkkE+4qG7STXlk0ASn57fAzO5/78sFeWWz2RINn5U
 J+jvAVFGKgyeTPwfDbCld/OPs+KhHsL5N9vP45z6tvEqw7aV1uIlc5utHQLcWs1xEr
 qfdI/5fQN8sRw==
Received: by mail-yb1-f177.google.com with SMTP id i186so8256392ybc.9
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Dec 2022 10:20:06 -0800 (PST)
X-Gm-Message-State: AFqh2ko+JmXM3bUvhoXfoYwWA1n4ThsbMh5m1ISKgcV6PCTAKrIYLyw9
 grySAXT0hODnZ+yElqnpoGrnbzEV0uQDT59TWAc=
X-Google-Smtp-Source: AMrXdXvSmVippjMlrTqYwEZNFssuYDv4ilYjms7DA5oCGY6PEalDlp3kzuv+0c+8F5xoL6W+W3DXJWdnhxBkHqCGego=
X-Received: by 2002:a25:c843:0:b0:754:e501:8b51 with SMTP id
 y64-20020a25c843000000b00754e5018b51mr1528595ybf.197.1671906005907; Sat, 24
 Dec 2022 10:20:05 -0800 (PST)
MIME-Version: 1.0
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-3-shashank.sharma@amd.com>
In-Reply-To: <20221223193655.1972-3-shashank.sharma@amd.com>
From: Oded Gabbay <ogabbay@kernel.org>
Date: Sat, 24 Dec 2022 20:19:39 +0200
X-Gmail-Original-Message-ID: <CAFCwf12zTZuQAYnxik26BaWtxJxgtB4wSuZNr7=NtU+KQetpiA@mail.gmail.com>
Message-ID: <CAFCwf12zTZuQAYnxik26BaWtxJxgtB4wSuZNr7=NtU+KQetpiA@mail.gmail.com>
Subject: Re: [RFC 2/7] drm/amdgpu: Add usermode queue for gfx work
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 23, 2022 at 9:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>
> This patch adds skeleton code for usermode queue creation. It
> typically contains:
> - A new structure to keep all the user queue data in one place.
> - An IOCTL function to create/free a usermode queue.
> - A function to generate unique index for the queue.
> - A global ptr in amdgpu_dev
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 187 ++++++++++++++++++
>  .../drm/amd/include/amdgpu_usermode_queue.h   |  50 +++++
>  5 files changed, 246 insertions(+)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>  create mode 100644 drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index 6ad39cf71bdd..e2a34ee57bfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -209,6 +209,8 @@ amdgpu-y += \
>  # add amdkfd interfaces
>  amdgpu-y += amdgpu_amdkfd.o
>
> +# add usermode queue
> +amdgpu-y += amdgpu_userqueue.o
>
>  ifneq ($(CONFIG_HSA_AMD),)
>  AMDKFD_PATH := ../amdkfd
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 8639a4f9c6e8..4b566fcfca18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -749,6 +749,11 @@ struct amdgpu_mqd {
>                         struct amdgpu_mqd_prop *p);
>  };
>
> +struct amdgpu_userq_globals {
> +       struct ida ida;
> +       struct mutex userq_mutex;
> +};
> +
>  #define AMDGPU_RESET_MAGIC_NUM 64
>  #define AMDGPU_MAX_DF_PERFMONS 4
>  #define AMDGPU_PRODUCT_NAME_LEN 64
> @@ -955,6 +960,7 @@ struct amdgpu_device {
>         bool                            enable_mes_kiq;
>         struct amdgpu_mes               mes;
>         struct amdgpu_mqd               mqds[AMDGPU_HW_IP_NUM];
> +       struct amdgpu_userq_globals     userq;
>
>         /* df */
>         struct amdgpu_df                df;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 0fa0e56daf67..f7413859b14f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -57,6 +57,7 @@ struct amdgpu_ctx {
>         unsigned long                   ras_counter_ce;
>         unsigned long                   ras_counter_ue;
>         uint32_t                        stable_pstate;
> +       struct amdgpu_usermode_queue    *userq;
>  };
>
>  struct amdgpu_ctx_mgr {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> new file mode 100644
> index 000000000000..3b6e8f75495c
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -0,0 +1,187 @@
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
> +#include "amdgpu_mes.h"
> +#include "amdgpu_usermode_queue.h"
> +#include "soc15_common.h"
> +
> +#define CHECK_ACCESS(a) (access_ok((const void __user *)a, sizeof(__u64)))
> +
> +static int
> +amdgpu_userqueue_index(struct amdgpu_device *adev)
> +{
> +    int index;
> +    struct amdgpu_userq_globals *uqg = &adev->userq;
> +
> +    index = ida_simple_get(&uqg->ida, 2, AMDGPU_MAX_USERQ, GFP_KERNEL);
> +    return index;
> +}
> +
> +static void
> +amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
> +{
> +    struct amdgpu_userq_globals *uqg = &adev->userq;
> +
> +    ida_simple_remove(&uqg->ida, queue->queue_id);
> +}
> +
> +static int
> +amdgpu_userqueue_validate_input(struct amdgpu_device *adev, struct drm_amdgpu_userq_mqd *mqd_in)
> +{
> +    if (mqd_in->queue_va == 0 || mqd_in->doorbell_handle == 0 || mqd_in->doorbell_offset == 0) {
> +        DRM_ERROR("Invalid queue object address\n");
> +        return -EINVAL;
> +    }
> +
> +    if (mqd_in->queue_size == 0 || mqd_in->rptr_va == 0 || mqd_in->wptr_va == 0) {
> +        DRM_ERROR("Invalid queue object value\n");
> +        return -EINVAL;
> +    }
> +
> +    if (mqd_in->ip_type < AMDGPU_HW_IP_GFX || mqd_in->ip_type >= AMDGPU_HW_IP_NUM) {
> +        DRM_ERROR("Invalid HW IP type 0x%x\n", mqd_in->ip_type);
> +        return -EINVAL;
> +    }
> +
> +    if (!CHECK_ACCESS(mqd_in->queue_va) || !CHECK_ACCESS(mqd_in->rptr_va) ||
> +        !CHECK_ACCESS(mqd_in->wptr_va)) {
> +            DRM_ERROR("Invalid mapping of queue ptrs, access error\n");
> +            return -EINVAL;
> +    }
> +
> +    DRM_DEBUG_DRIVER("Input parameters to create queue are valid\n");
> +    return 0;
> +}
> +
> +int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
> +                            union drm_amdgpu_userq *args)
> +{
> +    int r, pasid;
> +    struct amdgpu_usermode_queue *queue;
> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +    struct amdgpu_vm *vm = &fpriv->vm;
> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
> +    struct drm_amdgpu_userq_mqd *mqd_in = &args->in.mqd;
> +
> +    if (!ctx) {
> +        DRM_ERROR("Invalid GPU context\n");
> +        return -EINVAL;
> +    }
> +
> +    if (vm->pasid < 0) {
> +        DRM_WARN("No PASID info found\n");
> +        pasid = 0;
> +    }
> +
> +    mutex_lock(&adev->userq.userq_mutex);
> +
> +    queue = kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
> +    if (!queue) {
> +        DRM_ERROR("Failed to allocate memory for queue\n");
> +        mutex_unlock(&adev->userq.userq_mutex);
> +        return -ENOMEM;
> +    }
> +
> +    r = amdgpu_userqueue_validate_input(adev, mqd_in);
> +    if (r < 0) {
> +        DRM_ERROR("Invalid input to create queue\n");
> +        goto free_queue;
> +    }
> +
> +    queue->vm = vm;
> +    queue->pasid = pasid;
> +    queue->wptr_gpu_addr = mqd_in->wptr_va;
> +    queue->rptr_gpu_addr = mqd_in->rptr_va;
> +    queue->queue_size = mqd_in->queue_size;
> +    queue->queue_type = mqd_in->ip_type;
> +    queue->paging = false;
> +    queue->flags = mqd_in->flags;
> +    queue->queue_id = amdgpu_userqueue_index(adev);
> +
> +    ctx->userq = queue;
It looks like you have a single userq per context, and here you simply
override the userq pointer.
Maybe I've missed it, but where do you protect against a user
accidentally creating two user queues ? It will cause a memory leak as
you don't release the previous q.
I would imagine you should reject the user from creating another userq
until it frees the current userq.

Oded

> +    args->out.q_id = queue->queue_id;
> +    args->out.flags = 0;
> +    mutex_unlock(&adev->userq.userq_mutex);
> +    return 0;
> +
> +free_queue:
> +    amdgpu_userqueue_remove_index(adev, queue);
> +    mutex_unlock(&adev->userq.userq_mutex);
> +    kfree(queue);
> +    return r;
> +}
> +
> +void amdgpu_userqueue_destroy(struct amdgpu_device *adev, struct drm_file *filp,
> +                              union drm_amdgpu_userq *args)
> +{
> +    struct amdgpu_fpriv *fpriv = filp->driver_priv;
> +    struct amdgpu_ctx *ctx = amdgpu_ctx_get(fpriv, args->in.ctx_id);
> +    struct amdgpu_usermode_queue *queue = ctx->userq;
> +
> +    mutex_lock(&adev->userq.userq_mutex);
> +    amdgpu_userqueue_remove_index(adev, queue);
> +    ctx->userq = NULL;
> +    mutex_unlock(&adev->userq.userq_mutex);
> +    kfree(queue);
> +}
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> +                      struct drm_file *filp)
> +{
> +    union drm_amdgpu_userq *args = data;
> +    struct amdgpu_device *adev = drm_to_adev(dev);
> +    int r = 0;
> +
> +    switch (args->in.op) {
> +    case AMDGPU_USERQ_OP_CREATE:
> +        r = amdgpu_userqueue_create(adev, filp, args);
> +        if (r)
> +            DRM_ERROR("Failed to create usermode queue\n");
> +        break;
> +
> +    case AMDGPU_USERQ_OP_FREE:
> +        amdgpu_userqueue_destroy(adev, filp, args);
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
> +int amdgpu_userqueue_init(struct amdgpu_device *adev)
> +{
> +    struct amdgpu_userq_globals *uqg = &adev->userq;
> +
> +    mutex_init(&uqg->userq_mutex);
> +    return 0;
> +}
> +
> +void amdgpu_userqueue_fini(struct amdgpu_device *adev)
> +{
> +
> +}
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> new file mode 100644
> index 000000000000..c1fe39ffaf72
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/include/amdgpu_usermode_queue.h
> @@ -0,0 +1,50 @@
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
> +#ifndef AMDGPU_USERMODE_QUEUE_H_
> +#define AMDGPU_USERMODE_QUEUE_H_
> +
> +#define AMDGPU_MAX_USERQ 512
> +
> +struct amdgpu_usermode_queue {
> +       int             queue_id;
> +       int             queue_type;
> +       int             queue_size;
> +       int             paging;
> +       int             pasid;
> +       int             use_doorbell;
> +       int             doorbell_index;
> +
> +       uint64_t        mqd_gpu_addr;
> +       uint64_t        wptr_gpu_addr;
> +       uint64_t        rptr_gpu_addr;
> +       uint64_t        queue_gpu_addr;
> +       uint64_t        flags;
> +       void            *mqd_cpu_ptr;
> +
> +       struct amdgpu_bo        *mqd_obj;
> +       struct amdgpu_vm        *vm;
> +       struct list_head        list;
> +};
> +
> +#endif
> --
> 2.34.1
>
