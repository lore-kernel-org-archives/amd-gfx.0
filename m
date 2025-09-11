Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB231CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 18:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 520BB10E12C;
	Thu, 11 Sep 2025 18:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H2m/4PIH";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABFF10E12C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 18:52:56 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-24c95f20117so2052575ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 11:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757616776; x=1758221576; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iVSL+1M13KzBxOvnjEXg9F156Km+j5tj4E+2KSg8Rr8=;
 b=H2m/4PIHw2I0gJkx9f7wc9SVTGGpAnrUFz1BUc0gJe8OfdShmmirtPG1GlXoH7pDmT
 on+ESOeIdKzn4ZfBG1kDIaUxzwSriqPnZN+2Ma6fkSgUT0NiyBQdI5Wn3PfHcIHTM/8j
 TLaFNs8W1vup5zOmWtsAp8y21SvOyaF8Tvtnh36/GiVDMJmhesST7ASJ40sfwfprbWQ1
 su4EiJDiUuTlSLrHG+RS9YRmIBhtJ9zMv5VlJsxbm2u1XzLIQhrSj9iHkcuEq9JvW9w7
 mix+simyEpBdhUQmyp40U/JE7IKdV1YXnUAFPPfkp4fdEqfcnR8w4WJh4dapuDM4IFyd
 v9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757616776; x=1758221576;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVSL+1M13KzBxOvnjEXg9F156Km+j5tj4E+2KSg8Rr8=;
 b=iegVYlVMAWopXjPxHo8WWsfRAB/7bY/0fAP0ZlnbM93YhIbXZw1YP9B2/KN6Y2HyfG
 I/+kEO5n+GCjdy/IhH/lkqv1fHnrgUJovtAq7nRsj94uEnH2dq/fLqwtkRu1QBazA8LU
 N5RwT4fkzOzhy9FcCDam3a+PqaVpkRLTK51Zq1lGjNxPDor9yB/81a1LktbYHST4D61c
 I1sJdrMW2AgGh2A4wWVHVwQdiKeZOp5hrCknPwVEHiT9GxItRBdmcwIR+unzINQWmoOs
 OBlJa/1fBtjiE+hXbzu+zsH22VUxUCXGqVooT8/B/HmoT81kVMbK8Di4zm7HJCYDoD6M
 NWcw==
X-Gm-Message-State: AOJu0Yx90LJhyJ79rtUD0yiKUZs2kyivEWujo5uDHHnKc3ZiC/PlqJuU
 A+mpBEsaN74zLYOvkxCJG9O3bwsMIpFpEyFCl5YfjzWClH5nn+mCrTVD76eychc1mr4Kcagmi1A
 emJyL2wPGlJXuwSIR6QJy/3fCT/9paEI=
X-Gm-Gg: ASbGncvjJ2mzBev+MZEjpy8pvnNaAx9nbqL2Nrt1dQy6kSJmaCLTL+5jh5wo94f+vxW
 5Ch31Y1wW3uoSS/p5u2wdCAn5RNKaRo9nXUK7xL+39MxH5HiCgbmVVauXIb2XSjno0GPHJuRXpk
 pY1r7JmJrvLMjD7Zmtn5xDvi8MU/lbLF0LGACmgIeOgD1GWRXkHt2nxzjVB/28CT1XN2Z2vr5ML
 aZJZ3k=
X-Google-Smtp-Source: AGHT+IHP4ORkwjqw7lJSQg7L0q0y8BO40ll+VXPmk7Mr02MM+Xys2oBsb+opo1mr5ulJ5QMlWVhkE/fJQALoSeKqDOU=
X-Received: by 2002:a17:902:da81:b0:252:3606:ce05 with SMTP id
 d9443c01a7336-25d2675f87fmr2470485ad.6.1757616775680; Thu, 11 Sep 2025
 11:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250910081634.3943981-1-Jesse.Zhang@amd.com>
 <20250910081634.3943981-3-Jesse.Zhang@amd.com>
In-Reply-To: <20250910081634.3943981-3-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 14:52:43 -0400
X-Gm-Features: Ac12FXzBBfzSYvKI_NeEIAbkVvo8La5fTCt1_FXuK3NAQmkBCZZMGEebSmVWhow
Message-ID: <CADnq5_OXw9Ps7rD5F7wOCrEeEGeCgn=jNTrbKobiJnEJP-7uCg@mail.gmail.com>
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

On Wed, Sep 10, 2025 at 4:24=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
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
> v5: Use array for user queue type counters.(Alex)
>     all of the uqm->userq_mutex need to be held when calling detect and r=
eset.  (Alex)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   8 +
>  .../drm/amd/amdgpu/amdgpu_eviction_fence.c    |   3 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 211 ++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   5 +
>  6 files changed, 212 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index c56839528843..93c255d1ddfa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1311,6 +1311,7 @@ struct amdgpu_device {
>         struct list_head                userq_mgr_list;
>         struct mutex                    userq_mutex;
>         bool                            userq_halt_for_enforce_isolation;
> +       struct work_struct              userq_reset_work;
>         struct amdgpu_uid *uid_info;
>
>         /* KFD
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index b20383021b50..f1d3c16c67cd 100644
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

I don't think you can remove these.  I would split the locking changes
out into their own patch.  It's too much to include them in this
patch.  You either need to take all the uqm locks for global events
(like system suspend/resume or detect_and_reset()) or switch
everything to a global lock (and in that case, we can drop the uqm
lock).  Rework the locking, then implement the detect_and_reset()
support.

Alex

>  }
>
>  static bool amdgpu_eviction_fence_enable_signaling(struct dma_fence *f)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 80b85547c810..cf21f36b5761 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -83,6 +83,7 @@ enum amdgpu_ring_type {
>         AMDGPU_RING_TYPE_MES,
>         AMDGPU_RING_TYPE_UMSCH_MM,
>         AMDGPU_RING_TYPE_CPER,
> +       AMDGPU_RING_TYPE_MAX,
>  };
>
>  enum amdgpu_ib_pool_type {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index b649ac0cedff..f3f1b78dfef6 100644
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
> @@ -44,6 +46,77 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
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
> +       struct amdgpu_userq_mgr *uqm, *tmp;
> +       bool gpu_reset =3D false;
> +       int r =3D 0;
> +
> +       /* warning if global mutex or current process mutex is not held *=
/
> +       WARN_ON(!mutex_is_locked(&adev->userq_mutex) || !mutex_is_locked(=
&uq_mgr->userq_mutex));
> +       /* make sure all process locks are held */
> +       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +               if (uqm !=3D uq_mgr)
> +                       mutex_lock(&uqm->userq_mutex);
> +       }
> +
> +       if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> +               dev_err(adev->dev, "userq reset disabled by debug mask\n"=
);
> +       } else if (amdgpu_gpu_recovery) {
> +               if ((atomic_read(&uq_mgr->userq_count[AMDGPU_RING_TYPE_CO=
MPUTE]) > 0) && userq_compute_funcs->detect_and_reset) {
> +                       r =3D userq_compute_funcs->detect_and_reset(adev,=
 AMDGPU_RING_TYPE_COMPUTE);
> +                       if (r) {
> +                               gpu_reset =3D true;
> +                               goto gpu_reset;
> +                       }
> +               }
> +
> +               if ((atomic_read(&uq_mgr->userq_count[AMDGPU_RING_TYPE_GF=
X]) > 0) && userq_gfx_funcs->detect_and_reset) {
> +                       r =3D userq_gfx_funcs->detect_and_reset(adev, AMD=
GPU_RING_TYPE_GFX);
> +                       if (r) {
> +                               gpu_reset =3D true;
> +                               goto gpu_reset;
> +                       }
> +               }
> +
> +               if ((atomic_read(&uq_mgr->userq_count[AMDGPU_RING_TYPE_SD=
MA]) > 0) && userq_sdma_funcs->detect_and_reset) {
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
> +       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +               if (uqm !=3D uq_mgr)
> +                       mutex_unlock(&uqm->userq_mutex);
> +       }
> +       return r;
> +}
> +
>  int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
>                                    u64 expected_size)
>  {
> @@ -83,17 +156,22 @@ amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr =
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
> @@ -125,16 +203,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *=
uq_mgr,
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
> @@ -145,16 +230,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq=
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
> @@ -362,12 +453,14 @@ amdgpu_userq_destroy(struct drm_file *filp, int que=
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
> @@ -377,10 +470,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int que=
ue_id)
>                 amdgpu_bo_unreserve(queue->db_obj.obj);
>         }
>         amdgpu_bo_unref(&queue->db_obj.obj);
> -
> +       atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
>  #if defined(CONFIG_DEBUG_FS)
>         debugfs_remove_recursive(queue->debugfs_queue);
>  #endif
> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>         /*TODO: It requires a reset for userq hw unmap error*/
>         if (unlikely(r !=3D AMDGPU_USERQ_STATE_UNMAPPED)) {
> @@ -389,6 +483,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue=
_id)
>         }
>         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>         mutex_unlock(&uq_mgr->userq_mutex);
> +       mutex_unlock(&adev->userq_mutex);
>
>         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -588,6 +683,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>         kfree(queue_name);
>
>         args->out.queue_id =3D qid;
> +       atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
>
>  unlock:
>         mutex_unlock(&uq_mgr->userq_mutex);
> @@ -849,6 +945,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mg=
r)
>         int queue_id;
>         int ret =3D 0, r;
>
> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         /* Try to unmap all the queues in this process ctx */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>                 r =3D amdgpu_userq_preempt_helper(uq_mgr, queue);
> @@ -861,6 +958,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_m=
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
> @@ -887,31 +1001,33 @@ void
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
> +               mutex_unlock(&uq_mgr->userq_mutex);
> +               mutex_unlock(&adev->userq_mutex);
>                 return;
>         }
> -
> +       mutex_unlock(&uq_mgr->userq_mutex);
> +       mutex_unlock(&adev->userq_mutex);
>         /* Schedule a resume work */
>         schedule_delayed_work(&uq_mgr->resume_work, 0);
>  }
> @@ -919,6 +1035,8 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm=
_file *file_priv,
>                           struct amdgpu_device *adev)
>  {
> +       int i;
> +
>         mutex_init(&userq_mgr->userq_mutex);
>         idr_init_base(&userq_mgr->userq_idr, 1);
>         userq_mgr->adev =3D adev;
> @@ -926,6 +1044,10 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *=
userq_mgr, struct drm_file *f
>
>         mutex_lock(&adev->userq_mutex);
>         list_add(&userq_mgr->list, &adev->userq_mgr_list);
> +       /* Initialize all queue type counters to zero */
> +       for (i =3D 0; i < AMDGPU_RING_TYPE_MAX; i++) {
> +               atomic_set(&userq_mgr->userq_count[i], 0);
> +       }
>         mutex_unlock(&adev->userq_mutex);
>
>         INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_w=
orker);
> @@ -943,6 +1065,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *=
userq_mgr)
>
>         mutex_lock(&adev->userq_mutex);
>         mutex_lock(&userq_mgr->userq_mutex);
> +       amdgpu_userq_detect_and_reset_queues(userq_mgr);
>         idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>                 amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>                 amdgpu_userq_unmap_helper(userq_mgr, queue);
> @@ -976,6 +1099,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_queues(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         r =3D amdgpu_userq_unmap_helper(uqm, queue);
>                         if (r)
> @@ -1032,13 +1156,15 @@ int amdgpu_userq_stop_sched_for_enforce_isolation=
(struct amdgpu_device *adev,
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
> @@ -1080,3 +1206,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation=
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
> index c027dd916672..4395a5c13745 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -94,6 +94,7 @@ struct amdgpu_userq_mgr {
>         struct delayed_work             resume_work;
>         struct list_head                list;
>         struct drm_file                 *file;
> +       atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX]=
;
>  };
>
>  struct amdgpu_db_info {
> @@ -137,6 +138,10 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(st=
ruct amdgpu_device *adev,
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device =
*adev,
>                                                    u32 idx);
>
> +void amdgpu_userq_reset_work(struct work_struct *work);
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
> +
>  int amdgpu_userq_input_va_validate(struct amdgpu_vm *vm, u64 addr,
>                                    u64 expected_size);
>  #endif
> --
> 2.49.0
>
