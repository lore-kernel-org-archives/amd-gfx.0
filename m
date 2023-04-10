Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C425BC77B6E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 00:04:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5683310E1F3;
	Mon, 10 Apr 2023 00:04:45 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0E9310E1F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 00:04:43 +0000 (UTC)
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-54bfa5e698eso228494027b3.13
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Apr 2023 17:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google; t=1681085081; x=1683677081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/snaqrOyQufN7i9bGN7or2gZDsfaOIyL9LmABmkQ66Q=;
 b=Cb7rflmmbGRVOj2UywER7kczNzjd44BaMK1WVm9Oe4sqK7A7CcR32y8hWEKliEFUUS
 6b8hHVbWk1OzYK4OJyi23hV1+m029dAyTL5oX7XzlSeolvyaHgmXlfxRkDA66DOh+/Lz
 Eso4osADXXmxhYmK8mOZa/8iNVAoySsrFv8wfMaGq/c4gZGLL6SxQkAIbONRpa4WxRoD
 /FAXt192prDAM+APXPbCDcqCG7OHN3on/63abk980OWAnSOmgNdwmq9AD/A/tnWXVZi/
 YS86WcMoOWjeCMMMqsp9AdFkF7Qgy0ht4Mlr1YTWsG76oeVKQepz9uH9WauZeoO9QGsl
 rSig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681085081; x=1683677081;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/snaqrOyQufN7i9bGN7or2gZDsfaOIyL9LmABmkQ66Q=;
 b=20zPr6uWK5g09AZ40e9bVBY2jha1je8m+WVk557jaNPcn3PIsKJp76i+pY/UZsfTDt
 zTIW5SIVCIHUWYsqLJu1HVu2t04w8NW2+L/WJmCeuhhMC5c8PCC5U7NN7oR5VBmWCOxQ
 0SbpH6uIDC1k1WEjbMoZE7gkLOuIeMlGasX1f0+YkZonJrrDF/4jWO88mI19WneDMdUQ
 S9a9CIEZyrlD2dkXGuyG9RawYtTKqiTiaDquKQA5ll7pcak3QA5PvAe+wqmNa/4IhcIy
 lMkUgrgeyrhco2VCf0Mvj8NuBtpy/eRu5baRbLIUOL1e+c5prdGH8ONHG0tVZJneNs7i
 UUMg==
X-Gm-Message-State: AAQBX9esaTCC28A34wn4yOlcEewjCuRPolks7YavyEbyVu7JBopnS9VX
 +IYzKh1Wp5U4FaYirQYqHH9OSwGB4hNk3kD9JyIUFA==
X-Google-Smtp-Source: AKy350YwhtoqP8vwV6CpTr03vN/PEXAj7O6P/300RBn653Nb2vUZb6mWS5ucQVkqFcdQCl61Rw7Dg0h+kXtaprgfcUk=
X-Received: by 2002:a81:a783:0:b0:545:7143:2940 with SMTP id
 e125-20020a81a783000000b0054571432940mr5430007ywh.0.1681085081457; Sun, 09
 Apr 2023 17:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-4-shashank.sharma@amd.com>
In-Reply-To: <20230329160445.1300-4-shashank.sharma@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Mon, 10 Apr 2023 02:02:29 +0200
Message-ID: <CAP+8YyH7v0oOy5j8=9Y9f1hbLD0Nca6ZZGgo8nSup3qPiMfFLQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] drm/amdgpu: add new IOCTL for usermode queue
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

On Wed, Mar 29, 2023 at 6:05=E2=80=AFPM Shashank Sharma <shashank.sharma@am=
d.com> wrote:
>
> From: Shashank Sharma <contactshashanksharma@gmail.com>
>
> This patch adds:
> - A new IOCTL function to create and destroy
> - A new structure to keep all the user queue data in one place.
> - A function to generate unique index for the queue.
>
> V1: Worked on review comments from RFC patch series:
>   - Alex: Keep a list of queues, instead of single queue per process.
>   - Christian: Use the queue manager instead of global ptrs,
>            Don't keep the queue structure in amdgpu_ctx
>
> V2: Worked on review comments:
>  - Christian:
>    - Formatting of text
>    - There is no need for queuing of userqueues, with idr in place
>  - Alex:
>    - Remove use_doorbell, its unnecessary
>    - Reuse amdgpu_mqd_props for saving mqd fields
>
>  - Code formatting and re-arrangement
>
> V3:
>  - Integration with doorbell manager
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 113 ++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>  3 files changed, 116 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 2d6bcfd727c8..229976a2d0e7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2749,6 +2749,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D=
 {
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_VA, amdgpu_gem_va_ioctl, DRM_AUTH|DR=
M_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_OP, amdgpu_gem_op_ioctl, DRM_AUTH|DR=
M_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_USERPTR, amdgpu_gem_userptr_ioctl, D=
RM_AUTH|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_USERQ, amdgpu_userq_ioctl, DRM_AUTH|DRM_=
RENDER_ALLOW),
>  };
>
>  static const struct drm_driver amdgpu_kms_driver =3D {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_userqueue.c
> index 13e1eebc1cb6..353f57c5a772 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -22,6 +22,119 @@
>   */
>
>  #include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_userqueue.h"
> +
> +static inline int
> +amdgpu_userqueue_index(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_us=
ermode_queue *queue)
> +{
> +    return idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ, GFP=
_KERNEL);
> +}
> +
> +static inline void
> +amdgpu_userqueue_free_index(struct amdgpu_userq_mgr *uq_mgr, int queue_i=
d)
> +{
> +    idr_remove(&uq_mgr->userq_idr, queue_id);
> +}
> +
> +static struct amdgpu_usermode_queue *
> +amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
> +{
> +    return idr_find(&uq_mgr->userq_idr, qid);
> +}
> +
> +static int amdgpu_userqueue_create(struct drm_file *filp, union drm_amdg=
pu_userq *args)
> +{
> +    struct amdgpu_usermode_queue *queue;
> +    struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +    struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +    struct drm_amdgpu_userq_mqd *mqd_in =3D &args->in.mqd;
> +    int r;
> +
> +    /* Do we have support userqueues for this IP ? */
> +    if (!uq_mgr->userq_funcs[mqd_in->ip_type]) {
> +        DRM_ERROR("GFX User queues not supported for this IP: %d\n", mqd=
_in->ip_type);
> +        return -EINVAL;
> +    }
> +
> +    queue =3D kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNEL);
> +    if (!queue) {
> +        DRM_ERROR("Failed to allocate memory for queue\n");
> +        return -ENOMEM;
> +    }
> +
> +    mutex_lock(&uq_mgr->userq_mutex);
> +    queue->userq_prop.wptr_gpu_addr =3D mqd_in->wptr_va;
> +    queue->userq_prop.rptr_gpu_addr =3D mqd_in->rptr_va;
> +    queue->userq_prop.queue_size =3D mqd_in->queue_size;
> +    queue->userq_prop.hqd_base_gpu_addr =3D mqd_in->queue_va;
> +    queue->userq_prop.queue_size =3D mqd_in->queue_size;

This sets queue_size twice.

> +
> +    queue->doorbell_handle =3D mqd_in->doorbell_handle;
> +    queue->queue_type =3D mqd_in->ip_type;
> +    queue->flags =3D mqd_in->flags;
> +    queue->vm =3D &fpriv->vm;
> +    queue->queue_id =3D amdgpu_userqueue_index(uq_mgr, queue);
> +    if (queue->queue_id < 0) {
> +        DRM_ERROR("Failed to allocate a queue id\n");
> +        r =3D queue->queue_id;
> +        goto free_queue;
> +    }
> +
> +    args->out.queue_id =3D queue->queue_id;
> +    args->out.flags =3D 0;
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    return 0;
> +
> +free_queue:
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    kfree(queue);
> +    return r;
> +}
> +
> +static void amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id=
)
> +{
> +    struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +    struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +    struct amdgpu_usermode_queue *queue;
> +
> +    queue =3D amdgpu_userqueue_find(uq_mgr, queue_id);
> +    if (!queue) {
> +        DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
> +        return;
> +    }
> +
> +    mutex_lock(&uq_mgr->userq_mutex);
> +    amdgpu_userqueue_free_index(uq_mgr, queue->queue_id);
> +    mutex_unlock(&uq_mgr->userq_mutex);
> +    kfree(queue);
> +}
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> +                      struct drm_file *filp)
> +{
> +    union drm_amdgpu_userq *args =3D data;
> +    int r =3D 0;
> +
> +    switch (args->in.op) {
> +    case AMDGPU_USERQ_OP_CREATE:
> +        r =3D amdgpu_userqueue_create(filp, args);
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
>
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amd=
gpu_device *adev)
>  {
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index 7eeb8c9e6575..7625a862b1fc 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -42,6 +42,8 @@ struct amdgpu_userq_funcs {
>         void (*mqd_destroy)(struct amdgpu_userq_mgr *, struct amdgpu_user=
mode_queue *);
>  };
>
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data, struct drm_fi=
le *filp);
> +
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amd=
gpu_device *adev);
>
>  void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
> --
> 2.40.0
>
