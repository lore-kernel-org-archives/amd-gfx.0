Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2CBCA0FED
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Sep 2025 21:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E6C810E7ED;
	Tue,  9 Sep 2025 21:07:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RJBERLbv";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB4B10E7ED
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Sep 2025 21:07:12 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-24c95f20117so14805095ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Sep 2025 14:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757452032; x=1758056832; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YsJL1OhLuPgRMCV+CO71hoi94O0XgQuwNgqXIqgZ7sQ=;
 b=RJBERLbv8Qj0vOycf/ms4H6CrpeRrZikLOI8Z0KP7eH8CZVX6zLgtuNZndburbTbXM
 VeN4WZlZfym3XBIWigMd98TnVo5qQmmeXIM2+LwgoFHh0tSHGzDgUD4XMv49WwWLVVcr
 kUGEzsX3i4qyKmFZY81ZkX2HX4iv3UPSSelSxRwns5PhfwQvBkPf2WkpX7k0GrvPTsEM
 YO9cWcd3hDTnUABOOLamVqQRAA5Im9CgL+Izq6GjTN5/5Y2Ot5a64a/AoGKb9O5cCrnT
 asQ62x0oTOgb2XmLXXvybA/vxd049FFewNMR8/1FmskVpi7zhHKWZPICIpCWWjoUHGYB
 LjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757452032; x=1758056832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YsJL1OhLuPgRMCV+CO71hoi94O0XgQuwNgqXIqgZ7sQ=;
 b=Y0c/HInryva5pX2tdZfrqKjsO24mUjVI+oYzTOp1hh3ZHASGw8WoJup+JP2R05CN1J
 LLlB9T9/dJrFKN0gbc1bqQyngo0pSdORdMQf/X5R9rCk2DYL3pDE6o6IQnkYtKv0/4BT
 F8/W2HHINyLpwgc5e0cSfifxbYWsdJVUHFKZbY3iijtErO/hjR8i662AHHkiKD/RsxJy
 aZe7dBkfTVYzNwWUr9ctMk8BDxE58dlDMdI3nl/eLQf6WGtyDrjAOl1prs/LheyjKj+d
 KZAAX+5Oywg2JcTrulnfGENiEyHWi0/Th0Y4UWHJyhYUaVKLq/rZnQu0YmiH07VK19TT
 Fa+g==
X-Gm-Message-State: AOJu0Yz6+LTXxNI8o8cMvkxDtzad9oMM4uWNGsom5hx0yoCiPqOBAKdO
 IRTSij22EcUyuO8OZgDwH8WAOehSo9/8mfC5ZDIuXqaJCpOxfnoRFlEmi9XKCZeygE9JEBcCAqB
 nUlr7mUyL+mwhCo/ufS8Q6t5AraCbjzU=
X-Gm-Gg: ASbGncu1vXpAI6huorsIaPDdlIYGEqRGU/CFjSJmgXY9PiWCs9F29gtedcmx2bCpx41
 kMwlFZyiMnLBVpTvHSRe7P0rWjZvWcRqvSloKGzeHwAr5BZshooT317k0sdx/5Dq52Qzl17p8hF
 ZNrFi1bw/aQDrfrn1s9lGmgb/j1BjUfeoA0vsAOB3SWyVJ7/hMeE8RUhVUk6/GJuIcCiG2gN9aX
 JsbxcQ=
X-Google-Smtp-Source: AGHT+IGpE/MEj2Jy20XEsdZLH41ybcbWO70o+6nKMJFFkAhGDX9Wte52yhuu4NE3FqDic3wFRbxZyUxquuUaZhIL8Eo=
X-Received: by 2002:a17:902:fa4f:b0:24c:895a:c7 with SMTP id
 d9443c01a7336-25176162a36mr64708125ad.10.1757452031748; Tue, 09 Sep 2025
 14:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250905032026.3256999-1-Jesse.Zhang@amd.com>
 <20250905032026.3256999-3-Jesse.Zhang@amd.com>
In-Reply-To: <20250905032026.3256999-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Sep 2025 17:07:00 -0400
X-Gm-Features: Ac12FXydLz5CsXsgaWW1eW8gW5GRTC5nGgmgC5T04d-PR1ksQn0BD336piUyzKg
Message-ID: <CADnq5_PkUxWvtx2p0WrncvJzWtpayvdo3xznikHjGOqz9CQ_TQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Implement user queue reset functionality
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
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

On Thu, Sep 4, 2025 at 11:20=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> This patch adds robust reset handling for user queues (userq) to improve
> recovery from queue failures. The key components include:
>
> 1. Queue detection and reset logic:
>    - amdgpu_userq_detect_and_reset_queues() identifies failed queues
>    - Per-IP detect_and_reset callbacks for targeted recovery
>    - Falls back to full GPU reset when needed
>
> 2. Reset infrastructure:
>    - Adds userq_reset_work workqueue for async reset handling
>    - Implements pre/post reset handlers for queue state management
>    - Integrates with existing GPU reset framework
>
> 3. Error handling improvements:
>    - Enhanced state tracking with HUNG state
>    - Automatic reset triggering on critical failures
>    - VRAM loss handling during recovery
>
> 4. Integration points:
>    - Added to device init/reset paths
>    - Called during queue destroy, suspend, and isolation events
>    - Handles both individual queue and full GPU resets
>
> The reset functionality works with both gfx/compute and sdma queues,
> providing better resilience against queue failures while minimizing
> disruption to unaffected queues.
>
> v2: add detection and reset calls when preemption/unmaped fails.
>     add a per device userq counter for each user queue type.(Alex)
> v3: make sure we hold the adev->userq_mutex when we call amdgpu_userq_det=
ect_and_reset_queues. (Alex)
>    warn if the adev->userq_mutex is not held.
> v4: make sure we have all of the uqm->userq_mutex held.
>    warn if the uqm->userq_mutex is not held.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

The locking still looks wrong.  When we call detect_and_reset(), all
of the uqm->userq_mutex need to be held as that function affects all
users queues of a particular type (gfx, compute, sdma, etc.).  It may
end up getting called for one process and detecting a hung queue for
another process.  I'm not sure if it's feasible to lock all of the uqm
mutexes for all of the cases where we end up in detect_and_reset().
That's why I think it might be easier to just switch over to the
global adev->userq_mutex for everything and get rid of the per uqm
mutex.  It will serialize all userq handling in the kernel, but that's
probably fine.  The kernel handling is not really performance
critical.

A few other comments inline below.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   8 +
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   3 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 219 ++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   8 +
>  5 files changed, 223 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 17848ce65d1f..707a1fb4a061 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1310,6 +1310,7 @@ struct amdgpu_device {
>         struct list_head                userq_mgr_list;
>         struct mutex                    userq_mutex;
>         bool                            userq_halt_for_enforce_isolation;
> +       struct work_struct              userq_reset_work;
>         struct amdgpu_uid *uid_info;
>
>         /* KFD
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index bdfb80377e6a..82f01c7a06ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4534,6 +4534,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         }
>
>         INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +       INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
>
>         adev->gfx.gfx_off_req_count =3D 1;
>         adev->gfx.gfx_off_residency =3D 0;
> @@ -5951,6 +5952,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu=
_reset_context *reset_context)
>                                 if (r)
>                                         goto out;
>
> +                               r =3D amdgpu_userq_post_reset(tmp_adev, v=
ram_lost);
> +                               if (r)
> +                                       goto out;
> +
>                                 drm_client_dev_resume(adev_to_drm(tmp_ade=
v), false);
>
>                                 /*
> @@ -6173,6 +6178,7 @@ static inline void amdgpu_device_stop_pending_reset=
s(struct amdgpu_device *adev)
>         if (!amdgpu_sriov_vf(adev))
>                 cancel_work(&adev->reset_work);
>  #endif
> +       cancel_work(&adev->userq_reset_work);
>
>         if (adev->kfd.dev)
>                 cancel_work(&adev->kfd.reset_work);
> @@ -6293,6 +6299,8 @@ static void amdgpu_device_halt_activities(struct am=
dgpu_device *adev,
>                     amdgpu_device_ip_need_full_reset(tmp_adev))
>                         amdgpu_ras_suspend(tmp_adev);
>
> +               amdgpu_userq_pre_reset(tmp_adev);
> +
>                 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>                         struct amdgpu_ring *ring =3D tmp_adev->rings[i];
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> index 23d7d0b0d625..4471e4c388ad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
> @@ -107,7 +107,6 @@ amdgpu_eviction_fence_suspend_worker(struct work_stru=
ct *work)
>         struct amdgpu_userq_mgr *uq_mgr =3D &fpriv->userq_mgr;
>         struct amdgpu_eviction_fence *ev_fence;
>
> -       mutex_lock(&uq_mgr->userq_mutex);
>         spin_lock(&evf_mgr->ev_fence_lock);
>         ev_fence =3D evf_mgr->ev_fence;
>         if (ev_fence)
> @@ -118,13 +117,11 @@ amdgpu_eviction_fence_suspend_worker(struct work_st=
ruct *work)
>
>         amdgpu_userq_evict(uq_mgr, ev_fence);
>
> -       mutex_unlock(&uq_mgr->userq_mutex);
>         dma_fence_put(&ev_fence->base);
>         return;
>
>  unlock:
>         spin_unlock(&evf_mgr->ev_fence_lock);
> -       mutex_unlock(&uq_mgr->userq_mutex);
>  }
>
>  static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 7772de16f12b..566a26c05262 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -25,8 +25,10 @@
>  #include <drm/drm_auth.h>
>  #include <drm/drm_exec.h>
>  #include <linux/pm_runtime.h>
> +#include <drm/drm_drv.h>
>
>  #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
> @@ -44,6 +46,67 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
evice *adev)
>         return userq_ip_mask;
>  }
>
> +static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
> +{
> +       if (amdgpu_device_should_recover_gpu(adev)) {
> +               amdgpu_reset_domain_schedule(adev->reset_domain,
> +                                            &adev->userq_reset_work);
> +               /* Wait for the reset job to complete */
> +               flush_work(&adev->userq_reset_work);
> +       }
> +}
> +
> +static int
> +amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_gfx_funcs =3D
> +                       adev->userq_funcs[AMDGPU_RING_TYPE_GFX];
> +       const struct amdgpu_userq_funcs *userq_compute_funcs =3D
> +                       adev->userq_funcs[AMDGPU_RING_TYPE_COMPUTE];
> +       const struct amdgpu_userq_funcs *userq_sdma_funcs =3D
> +                       adev->userq_funcs[AMDGPU_RING_TYPE_SDMA];
> +       bool gpu_reset =3D false;
> +       int r =3D 0;
> +
> +       /* warning if global mutex or process mutex is not held */
> +       WARN_ON(!mutex_is_locked(&adev->userq_mutex) || !mutex_is_locked(=
&uq_mgr->userq_mutex));
> +
> +       if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> +               dev_err(adev->dev, "userq reset disabled by debug mask\n"=
);
> +       } else if (amdgpu_gpu_recovery) {
> +               if ((atomic_read(&uq_mgr->userq_compute_count) > 0) && us=
erq_compute_funcs->detect_and_reset) {
> +                       r =3D userq_compute_funcs->detect_and_reset(adev,=
 AMDGPU_RING_TYPE_COMPUTE);
> +                       if (r) {
> +                               gpu_reset =3D true;
> +                               goto gpu_reset;
> +                       }
> +               }
> +
> +               if ((atomic_read(&uq_mgr->userq_gfx_count) > 0) && userq_=
gfx_funcs->detect_and_reset) {
> +                       r =3D userq_gfx_funcs->detect_and_reset(adev, AMD=
GPU_RING_TYPE_GFX);
> +                       if (r) {
> +                               gpu_reset =3D true;
> +                               goto gpu_reset;
> +                       }
> +               }
> +
> +               if ((atomic_read(&uq_mgr->userq_sdma_count) > 0) && userq=
_sdma_funcs->detect_and_reset) {
> +                       r =3D userq_sdma_funcs->detect_and_reset(adev, AM=
DGPU_RING_TYPE_SDMA);
> +                       if (r) {
> +                               gpu_reset =3D true;
> +                               goto gpu_reset;
> +                       }
> +               }
> +       }
> +
> +gpu_reset:
> +       if (gpu_reset)
> +               amdgpu_userq_gpu_reset(adev);
> +
> +       return r;
> +}
> +
>  static int
>  amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -51,17 +114,22 @@ amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr =
*uq_mgr,
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *userq_funcs =3D
>                 adev->userq_funcs[queue->queue_type];
> +       bool found_hung_queue =3D false;
>         int r =3D 0;
>
>         if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
>                 r =3D userq_funcs->preempt(uq_mgr, queue);
>                 if (r) {
>                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +                       found_hung_queue =3D true;
>                 } else {
>                         queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED;
>                 }
>         }
>
> +       if (found_hung_queue)
> +               amdgpu_userq_detect_and_reset_queues(uq_mgr);
> +
>         return r;
>  }
>
> @@ -93,16 +161,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *u=
q_mgr,
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *userq_funcs =3D
>                 adev->userq_funcs[queue->queue_type];
> +       bool found_hung_queue =3D false;
>         int r =3D 0;
>
>         if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) ||
>                 (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
>                 r =3D userq_funcs->unmap(uq_mgr, queue);
> -               if (r)
> +               if (r) {
>                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> -               else
> +                       found_hung_queue =3D true;
> +               } else {
>                         queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
> +               }
>         }
> +
> +       if (found_hung_queue)
> +               amdgpu_userq_detect_and_reset_queues(uq_mgr);
> +
>         return r;
>  }
>
> @@ -113,16 +188,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq=
_mgr,
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *userq_funcs =3D
>                 adev->userq_funcs[queue->queue_type];
> +       bool gpu_reset =3D false;
>         int r =3D 0;
>
>         if (queue->state =3D=3D AMDGPU_USERQ_STATE_UNMAPPED) {
>                 r =3D userq_funcs->map(uq_mgr, queue);
>                 if (r) {
>                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +                       gpu_reset =3D true;
>                 } else {
>                         queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
>                 }
>         }
> +
> +       if (gpu_reset)
> +               amdgpu_userq_gpu_reset(adev);
> +
>         return r;
>  }
>
> @@ -346,12 +427,14 @@ amdgpu_userq_destroy(struct drm_file *filp, int que=
ue_id)
>         int r =3D 0;
>
>         cancel_delayed_work_sync(&uq_mgr->resume_work);
> +       mutex_lock(&adev->userq_mutex);
>         mutex_lock(&uq_mgr->userq_mutex);
>
>         queue =3D amdgpu_userq_find(uq_mgr, queue_id);
>         if (!queue) {
>                 drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue =
id to destroy\n");
>                 mutex_unlock(&uq_mgr->userq_mutex);
> +               mutex_unlock(&adev->userq_mutex);
>                 return -EINVAL;
>         }
>         amdgpu_userq_wait_for_last_fence(uq_mgr, queue);
> @@ -361,6 +444,18 @@ amdgpu_userq_destroy(struct drm_file *filp, int queu=
e_id)
>                 amdgpu_bo_unreserve(queue->db_obj.obj);
>         }
>         amdgpu_bo_unref(&queue->db_obj.obj);
> +       switch (queue->queue_type) {
> +       case AMDGPU_RING_TYPE_GFX:
> +               atomic_dec(&uq_mgr->userq_gfx_count);
> +       break;
> +       case AMDGPU_RING_TYPE_COMPUTE:
> +               atomic_dec(&uq_mgr->userq_compute_count);
> +       break;
> +       case AMDGPU_RING_TYPE_SDMA:
> +               atomic_dec(&uq_mgr->userq_sdma_count);
> +       break;
> +       }

maybe cleaner to do something like:
atomic_dec(&uq_mgr->userq_count[queue->queue_type]);

> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>
>  #if defined(CONFIG_DEBUG_FS)
>         debugfs_remove_recursive(queue->debugfs_queue);
> @@ -368,6 +463,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue=
_id)
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>         mutex_unlock(&uq_mgr->userq_mutex);
> +       mutex_unlock(&adev->userq_mutex);
>
>         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -576,6 +672,19 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>         kfree(queue_name);
>
>         args->out.queue_id =3D qid;
> +       switch (queue->queue_type) {
> +       case AMDGPU_RING_TYPE_GFX:
> +               atomic_inc(&uq_mgr->userq_gfx_count);
> +       break;
> +       case AMDGPU_RING_TYPE_COMPUTE:
> +               atomic_inc(&uq_mgr->userq_compute_count);
> +       break;
> +       case AMDGPU_RING_TYPE_SDMA:
> +               atomic_inc(&uq_mgr->userq_sdma_count);
> +       break;
> +       default:
> +       break;
> +       }

Same comment as above:
atomic_inc(&uq_mgr->userq_count[queue->queue_type]);

>
>  unlock:
>         mutex_unlock(&uq_mgr->userq_mutex);
> @@ -789,6 +898,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mg=
r)
>         int queue_id;
>         int ret =3D 0, r;
>
> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);

Should this come after the preemption or before?


>         /* Try to unmap all the queues in this process ctx */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>                 r =3D amdgpu_userq_preempt_helper(uq_mgr, queue);
> @@ -801,6 +911,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_m=
gr)
>         return ret;
>  }
>
> +void amdgpu_userq_reset_work(struct work_struct *work)
> +{
> +       struct amdgpu_device *adev =3D container_of(work, struct amdgpu_d=
evice,
> +                                                 userq_reset_work);
> +       struct amdgpu_reset_context reset_context;
> +
> +       memset(&reset_context, 0, sizeof(reset_context));
> +
> +       reset_context.method =3D AMD_RESET_METHOD_NONE;
> +       reset_context.reset_req_dev =3D adev;
> +       reset_context.src =3D AMDGPU_RESET_SRC_USERQ;
> +       set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> +       /*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
> +
> +       amdgpu_device_gpu_recover(adev, NULL, &reset_context);
> +}
> +
>  static int
>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
>  {
> @@ -827,31 +954,33 @@ void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>                    struct amdgpu_eviction_fence *ev_fence)
>  {
> -       int ret;
>         struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
>         struct amdgpu_eviction_fence_mgr *evf_mgr =3D &fpriv->evf_mgr;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       int ret;
>
> +       mutex_lock(&adev->userq_mutex);
> +       mutex_lock(&uq_mgr->userq_mutex);
>         /* Wait for any pending userqueue fence work to finish */
>         ret =3D amdgpu_userq_wait_for_signal(uq_mgr);
> -       if (ret) {
> -               drm_file_err(uq_mgr->file, "Not evicting userqueue, timeo=
ut waiting for work\n");
> -               return;
> -       }
> +       if (ret)
> +               dev_err(adev->dev, "Not evicting userqueue, timeout waiti=
ng for work\n");
>
>         ret =3D amdgpu_userq_evict_all(uq_mgr);
> -       if (ret) {
> -               drm_file_err(uq_mgr->file, "Failed to evict userqueue\n")=
;
> -               return;
> -       }
> +       if (ret)
> +               dev_err(adev->dev, "Failed to evict userqueue\n");
>
>         /* Signal current eviction fence */
>         amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
>
>         if (evf_mgr->fd_closing) {
>                 cancel_delayed_work_sync(&uq_mgr->resume_work);
> +               mutex_unlock(&adev->userq_mutex);
> +               mutex_unlock(&uq_mgr->userq_mutex);
>                 return;
>         }
> -
> +       mutex_unlock(&adev->userq_mutex);
> +       mutex_unlock(&uq_mgr->userq_mutex);
>         /* Schedule a resume work */
>         schedule_delayed_work(&uq_mgr->resume_work, 0);
>  }
> @@ -866,6 +995,9 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *us=
erq_mgr, struct drm_file *f
>
>         mutex_lock(&adev->userq_mutex);
>         list_add(&userq_mgr->list, &adev->userq_mgr_list);
> +       atomic_set(&userq_mgr->userq_gfx_count, 0);
> +       atomic_set(&userq_mgr->userq_compute_count, 0);
> +       atomic_set(&userq_mgr->userq_sdma_count, 0);
>         mutex_unlock(&adev->userq_mutex);
>
>         INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_w=
orker);
> @@ -883,6 +1015,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *=
userq_mgr)
>
>         mutex_lock(&adev->userq_mutex);
>         mutex_lock(&userq_mgr->userq_mutex);
> +       amdgpu_userq_detect_and_reset_queues(userq_mgr);
>         idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>                 amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>                 amdgpu_userq_unmap_helper(userq_mgr, queue);
> @@ -916,6 +1049,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_queues(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         r =3D amdgpu_userq_unmap_helper(uqm, queue);
>                         if (r)
> @@ -972,13 +1106,15 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(=
struct amdgpu_device *adev,
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_queues(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) =
||
>                              (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPU=
TE)) &&
>                             (queue->xcp_id =3D=3D idx)) {
>                                 r =3D amdgpu_userq_preempt_helper(uqm, qu=
eue);
> -                               if (r)
> +                               if (r) {
>                                         ret =3D r;
> +                               }
>                         }
>                 }
>                 mutex_unlock(&uqm->userq_mutex);
> @@ -1020,3 +1156,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation=
(struct amdgpu_device *adev,
>         mutex_unlock(&adev->userq_mutex);
>         return ret;
>  }
> +
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
> +{
> +       const struct amdgpu_userq_funcs *userq_funcs;
> +       struct amdgpu_usermode_queue *queue;
> +       struct amdgpu_userq_mgr *uqm, *tmp;
> +       int queue_id;
> +
> +       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +               cancel_delayed_work_sync(&uqm->resume_work);
> +               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +                       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED=
) {
> +                               amdgpu_userq_wait_for_last_fence(uqm, que=
ue);
> +                               userq_funcs =3D adev->userq_funcs[queue->=
queue_type];
> +                               userq_funcs->unmap(uqm, queue);
> +                               /* just mark all queues as hung at this p=
oint.
> +                                * if unmap succeeds, we could map again
> +                                * in amdgpu_userq_post_reset() if vram i=
s not lost
> +                                */
> +                               queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +                               amdgpu_userq_fence_driver_force_completio=
n(queue);
> +                       }
> +               }
> +       }
> +}
> +
> +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
> +{
> +       /* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
> +        * at this point, we should be able to map it again
> +        * and continue if vram is not lost.
> +        */
> +       struct amdgpu_userq_mgr *uqm;
> +       struct amdgpu_usermode_queue *queue;
> +       const struct amdgpu_userq_funcs *userq_funcs;
> +       int queue_id, r =3D 0;
> +
> +       list_for_each_entry(uqm, &adev->userq_mgr_list, list) {
> +               idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +                       if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG &=
& !vram_lost) {
> +                               userq_funcs =3D adev->userq_funcs[queue->=
queue_type];
> +
> +                               r =3D userq_funcs->map(uqm, queue);  // R=
e-map queue
> +                               if (r) {
> +                                       dev_err(adev->dev, "Failed to rem=
ap queue %d\n", queue_id);
> +                                       continue;
> +                               }
> +                               queue->state =3D AMDGPU_USERQ_STATE_MAPPE=
D;
> +                       }
> +               }
> +
> +               /* Restart resume work after reset */
> +               //queue_delayed_work(system_wq, &uqm->resume_work, msecs_=
to_jiffies(100));
> +       }
> +
> +       return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 1bd84f4cce78..391c510b025b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -94,6 +94,9 @@ struct amdgpu_userq_mgr {
>         struct delayed_work             resume_work;
>         struct list_head                list;
>         struct drm_file                 *file;
> +       atomic_t                        userq_gfx_count;
> +       atomic_t                        userq_compute_count;
> +       atomic_t                        userq_sdma_count;
>  };
>
>  struct amdgpu_db_info {
> @@ -139,4 +142,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
uct amdgpu_device *adev,
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device =
*adev,
>                                                    u32 idx);
>
> +void amdgpu_userq_reset_work(struct work_struct *work);
> +
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
> +
>  #endif
> --
> 2.49.0
>
