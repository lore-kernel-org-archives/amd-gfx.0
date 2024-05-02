Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E68C4345F
	for <amd-gfx@archiver.kernel.org>; Thu,  2 May 2024 21:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB4431126BB;
	Thu,  2 May 2024 21:26:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nf3xGcbc";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260E61126BB
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 May 2024 21:26:03 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2ab1ddfded1so7292995a91.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 May 2024 14:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714685162; x=1715289962; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NOGDVy1G1G0sb8nR6sqy/MgEi/8p+/ta1EVO14awpA8=;
 b=nf3xGcbcAE8P3R9kuY4tEZl9EAd3IN5MOZxwsmrjbhETUmS1vBY434K0abgMqZZN4G
 tWfvHz567PZLNQ1TzvJfmG2R8uZ19dyWTjiSZ40FKnW5MrWVg/2z2nycShnQoRnOlJMI
 BOFSjolttUvNL29TSn0+ee3mXLohrrhlh0W9HqHQ5GwD2XrKbjCO7F4qfnOf83nBlFli
 aqk4ePJRGEDpxxGW+vxZIhMq3u7hqn6nV+5Lu4E1uCsD+/IFf9mqCGK39pbdCL2r7PfM
 /KMEvatvm4osfu8kBv7XkLdpN97vuTlC5VcwbtiPFfOS8RfInF+X0gErAhXjqWdU6JaE
 UPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714685162; x=1715289962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NOGDVy1G1G0sb8nR6sqy/MgEi/8p+/ta1EVO14awpA8=;
 b=caXoc1Hre1dUVjYNl55uXJ2RneSJycRc6bVKBV58406gKcbB8Mtn6pBUyna4QXKtUm
 UXuuLI35htK08JHGBRiQ2OlMF/1j3jEKfRoT8Qz+cEmlYEeTPs+Ng0Va4mMhnrrPF22y
 1mn3sfVarPWCcSFXuVmF/VcwARuIo+xSnWHLqEQ1V8jojwR/z5RZgRP2vJTa/QxVIldy
 1P80J8BC23IW158fNzNJV4Iv3FoDl9KB+njVT3VqNu8GB6d3zQwTTRHIkFtubl2BpsZk
 bVbw89QPf210zXlI/YkqN6Dy7EevwBIOpNyFh7Ygl6AC0bGlLYTbFXryGh75pOHq5HvN
 pGUg==
X-Gm-Message-State: AOJu0YwZbQ6Yiak7uiO0D7AIhog6EYuzCIWSWRq/FldlF9wZ5bqr6Yrx
 u3ILOP6/JDxYWPkHOM0pzoRrQVjOeFmhl9rw/tuhJVm4wK36DgZLxA+cTA7sEL+NxPWxVHzebzR
 dvaebytED5977m9ECQ6ZOuTrLtGhmkQ==
X-Google-Smtp-Source: AGHT+IHojlNbRZenqITn0MT3evm2jeHqTvBINdKyHPjO1hHxLC4DRWAnx3jjm2gfKHWbYLZsDzny2PQVOgI9B9+IFIA=
X-Received: by 2002:a17:90b:4d08:b0:2a2:ba9:ba61 with SMTP id
 mw8-20020a17090b4d0800b002a20ba9ba61mr1182734pjb.34.1714685162136; Thu, 02
 May 2024 14:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240502163152.1382-1-shashank.sharma@amd.com>
 <20240502163152.1382-4-shashank.sharma@amd.com>
In-Reply-To: <20240502163152.1382-4-shashank.sharma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 May 2024 17:25:50 -0400
Message-ID: <CADnq5_PVxJVAJ0+X=QWJYauTY8t8FOgNSgakcquq5Li-85pWGw@mail.gmail.com>
Subject: Re: [PATCH v10 03/14] drm/amdgpu: add new IOCTL for usermode queue
To: Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Arvind Yadav <arvind.yadav@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
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

On Thu, May 2, 2024 at 1:27=E2=80=AFPM Shashank Sharma <shashank.sharma@amd=
.com> wrote:
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
> V4:
>  - Accommodate MQD union related changes in UAPI (Alex)
>  - Do not set the queue size twice (Bas)
>
> V5:
>  - Remove wrapper functions for queue indexing (Christian)
>  - Do not save the queue id/idr in queue itself (Christian)
>  - Move the idr allocation in the IP independent generic space
>   (Christian)
>
> V6:
>  - Check the validity of input IP type (Christian)
>
> V7:
>  - Move uq_func from uq_mgr to adev (Alex)
>  - Add missing free(queue) for error cases (Yifan)
>
> V9:
>  - Rebase
>
> V10: Addressed review comments from Christian, and added R-B:
>  - Do not initialize the local variable
>  - Convert DRM_ERROR to DEBUG.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Reviewed-by: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 121 ++++++++++++++++++
>  .../gpu/drm/amd/include/amdgpu_userqueue.h    |   2 +
>  3 files changed, 124 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b52442e2d04a..551e13693100 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2929,6 +2929,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D=
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
> index effc0c7c02cf..ce9b25b82e94 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
> @@ -23,6 +23,127 @@
>   */
>
>  #include "amdgpu.h"
> +#include "amdgpu_vm.h"
> +#include "amdgpu_userqueue.h"
> +
> +static struct amdgpu_usermode_queue *
> +amdgpu_userqueue_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
> +{
> +       return idr_find(&uq_mgr->userq_idr, qid);
> +}
> +
> +static int
> +amdgpu_userqueue_destroy(struct drm_file *filp, int queue_id)
> +{
> +       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *uq_funcs;
> +       struct amdgpu_usermode_queue *queue;
> +
> +       mutex_lock(&uq_mgr->userq_mutex);
> +
> +       queue =3D amdgpu_userqueue_find(uq_mgr, queue_id);
> +       if (!queue) {
> +               DRM_DEBUG_DRIVER("Invalid queue id to destroy\n");
> +               mutex_unlock(&uq_mgr->userq_mutex);
> +               return -EINVAL;
> +       }
> +
> +       uq_funcs =3D adev->userq_funcs[queue->queue_type];
> +       uq_funcs->mqd_destroy(uq_mgr, queue);
> +       idr_remove(&uq_mgr->userq_idr, queue_id);
> +       kfree(queue);
> +
> +       mutex_unlock(&uq_mgr->userq_mutex);
> +       return 0;
> +}
> +
> +static int
> +amdgpu_userqueue_create(struct drm_file *filp, union drm_amdgpu_userq *a=
rgs)
> +{
> +       struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
> +       struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *uq_funcs;
> +       struct amdgpu_usermode_queue *queue;
> +       int qid, r =3D 0;
> +
> +       /* Usermode queues are only supported for GFX/SDMA engines as of =
now */
> +       if (args->in.ip_type !=3D AMDGPU_HW_IP_GFX) {
> +               DRM_ERROR("Usermode queue doesn't support IP type %u\n", =
args->in.ip_type);
> +               return -EINVAL;
> +       }
> +
> +       mutex_lock(&uq_mgr->userq_mutex);
> +
> +       uq_funcs =3D adev->userq_funcs[args->in.ip_type];
> +       if (!uq_funcs) {
> +               DRM_ERROR("Usermode queue is not supported for this IP (%=
u)\n", args->in.ip_type);
> +               r =3D -EINVAL;
> +               goto unlock;
> +       }
> +
> +       queue =3D kzalloc(sizeof(struct amdgpu_usermode_queue), GFP_KERNE=
L);
> +       if (!queue) {
> +               DRM_ERROR("Failed to allocate memory for queue\n");
> +               r =3D -ENOMEM;
> +               goto unlock;
> +       }
> +       queue->doorbell_handle =3D args->in.doorbell_handle;
> +       queue->doorbell_index =3D args->in.doorbell_offset;
> +       queue->queue_type =3D args->in.ip_type;

Validate that ip_type is valid here.

> +       queue->flags =3D args->in.flags;

Validate that flags is 0 until we actually implement support for the flags.

> +       queue->vm =3D &fpriv->vm;
> +
> +       r =3D uq_funcs->mqd_create(uq_mgr, &args->in, queue);
> +       if (r) {
> +               DRM_ERROR("Failed to create Queue\n");
> +               kfree(queue);
> +               goto unlock;
> +       }
> +
> +       qid =3D idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_=
COUNT, GFP_KERNEL);
> +       if (qid < 0) {
> +               DRM_ERROR("Failed to allocate a queue id\n");
> +               uq_funcs->mqd_destroy(uq_mgr, queue);
> +               kfree(queue);
> +               r =3D -ENOMEM;
> +               goto unlock;
> +       }
> +       args->out.queue_id =3D qid;
> +
> +unlock:
> +       mutex_unlock(&uq_mgr->userq_mutex);
> +       return r;
> +}
> +
> +int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
> +                      struct drm_file *filp)
> +{
> +       union drm_amdgpu_userq *args =3D data;
> +       int r;
> +
> +       switch (args->in.op) {
> +       case AMDGPU_USERQ_OP_CREATE:
> +               r =3D amdgpu_userqueue_create(filp, args);
> +               if (r)
> +                       DRM_ERROR("Failed to create usermode queue\n");
> +               break;
> +
> +       case AMDGPU_USERQ_OP_FREE:
> +               r =3D amdgpu_userqueue_destroy(filp, args->in.queue_id);
> +               if (r)
> +                       DRM_ERROR("Failed to destroy usermode queue\n");
> +               break;
> +
> +       default:
> +               DRM_DEBUG_DRIVER("Invalid user queue op specified: %d\n",=
 args->in.op);
> +               return -EINVAL;
> +       }
> +
> +       return r;
> +}
>
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct amd=
gpu_device *adev)
>  {
> diff --git a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h b/drivers/gpu=
/drm/amd/include/amdgpu_userqueue.h
> index 93ebe4b61682..b739274c72e1 100644
> --- a/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> +++ b/drivers/gpu/drm/amd/include/amdgpu_userqueue.h
> @@ -54,6 +54,8 @@ struct amdgpu_userq_mgr {
>         struct amdgpu_device            *adev;
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
> 2.43.2
>
