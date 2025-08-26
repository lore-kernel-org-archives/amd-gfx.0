Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F98CCA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 14:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A4A10E36F;
	Tue, 26 Aug 2025 14:49:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Au+0xqnX";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2520510E36F
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 14:49:10 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-248887257e0so407695ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 07:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756219749; x=1756824549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xtCbI7gQ9+LESNlxnnE36tnIqQ4gcM4cINmtvuXn2Hc=;
 b=Au+0xqnXOCGKr6QPA5IxETMTcHX/b07xzik90XMFl2adTuK1y71kAUyGTTFWWg4yy0
 k6vuy3b0raKATzRRP56aKh3mqXK+tEobqDDkFbm0uPhgawaofUnHTStKdWPJEY4nwZ04
 pB7t9t1onRgnPYdlokNj4+tD1KTF8QdVNPILlnqlAl0qpwMYRLYE/ztK4yVKDhiV13tl
 YgncNqhUS6e6M8hXiKfmpNPei29RK3cacU75aE6pWqSfj8nxaV6KjE6NlRpKiwPfKlzu
 whxgDgfVAJ6GaFLcbsxmEpyHACo3PlxhLDm+HU7g8TL99dY532VZI+bspgVmwadiPFe/
 B0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756219749; x=1756824549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xtCbI7gQ9+LESNlxnnE36tnIqQ4gcM4cINmtvuXn2Hc=;
 b=Pka6AEwWqIpiMj9taBtpttkM/ToZX+5AkHdg/iCw+6xuS5qTpmj5fKb86Yruzz4pCd
 kFRS4IWJZof2oednGuG+oC+qVl0EvvJFeybHmPEsBcA9p4kHPJkqTcG4gVGxfz1pnfYz
 m3uG2gR0Jhi799qgZqUu+tj0pdmb8ZOL47suTZ4Fns6/W3JXbqbnhN7TtDK+o11kxBfz
 SAtXpkhbh0bSPAytIpmkkMlzgpTMUYshLKh3yorrA3eyj6A/xP1k/A/a3lGVF6gBBcRp
 gYbbw2Iq7ZYM53HKA7vDFv4NFONEUjsIl6CKpG7vWji7xH3ZJw40sid4fWhlnPQ8Vrez
 q8pA==
X-Gm-Message-State: AOJu0Yw8Q1U8/DqoN30ohLNtabnow6rcZe6y7sLOs0OrPfFFh/a52xnZ
 +uBQE6oxrXkJaOBhTmg6WP1P0FJRyL/mgayZiQh4eWLMTLQwHYFNfRyw9Lu40JQF1gFVmLOHI+A
 3qiWCx/zLdy77U3x8AGT2soi6EahHOx5me0xl
X-Gm-Gg: ASbGncs7FhcP4Xz5XQQFSd3+cL3okxfAs7Xd+18Pq5FUsFXRwgxYRZk4XMzW8LEb1Ry
 e+xeRkLGBUeW73AaurJGOOCIKe7vPSzy7cmHFZ0S6AELptl1ijdj/k5ezIAznFWEWFsng3XQjHr
 7OJu6jnUQoD1bZSXNlsuytwwx4PFjFGSWk9RgKnz2IFxnJC0tG28ulV26lKNgp4GALZJ/LmetTV
 W7mlCs=
X-Google-Smtp-Source: AGHT+IHXP5b9ozslHxazYBJS+73ZxmYY8Wp2O+QV3EttNxHCK+Rnj+W42ZjEK2hjFN4b5jzmZQSDbrdPrt3N3ySEFe8=
X-Received: by 2002:a17:902:cecd:b0:246:a19d:c13 with SMTP id
 d9443c01a7336-246a19d1686mr73652715ad.1.1756219749350; Tue, 26 Aug 2025
 07:49:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250826014648.1711926-1-Jesse.Zhang@amd.com>
 <20250826014648.1711926-11-Jesse.Zhang@amd.com>
In-Reply-To: <20250826014648.1711926-11-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 10:48:56 -0400
X-Gm-Features: Ac12FXyqilOhq3S3jILLc_pY1vQlThlSALiODyFiuRFIt6Q4tIL8OAo73sEDUBA
Message-ID: <CADnq5_N6EyJ-sk6DUjiAF=DoujCM1Bg-Pce58w7=w3UQZ9zo2A@mail.gmail.com>
Subject: Re: [v12 11/11] drm/amdgpu: Implement user queue reset functionality
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

On Mon, Aug 25, 2025 at 10:43=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
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
> The reset functionality works with both compute and graphics queues,
> providing better resilience against queue failures while minimizing
> disruption to unaffected queues.
>
> v2: Separate SDMA and GFX/COMPUTE queue reset handling
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 215 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
>  4 files changed, 216 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index ef3af170dda4..9db05cdc7304 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1302,6 +1302,7 @@ struct amdgpu_device {
>         struct list_head                userq_mgr_list;
>         struct mutex                    userq_mutex;
>         bool                            userq_halt_for_enforce_isolation;
> +       struct work_struct              userq_reset_work;
>  };
>
>  static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *ade=
v,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 3757634613c3..1dc88b0055dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4475,6 +4475,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         }
>
>         INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +       INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
>
>         adev->gfx.gfx_off_req_count =3D 1;
>         adev->gfx.gfx_off_residency =3D 0;
> @@ -5880,6 +5881,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu=
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
> @@ -6102,6 +6107,7 @@ static inline void amdgpu_device_stop_pending_reset=
s(struct amdgpu_device *adev)
>         if (!amdgpu_sriov_vf(adev))
>                 cancel_work(&adev->reset_work);
>  #endif
> +       cancel_work(&adev->userq_reset_work);
>
>         if (adev->kfd.dev)
>                 cancel_work(&adev->kfd.reset_work);
> @@ -6232,6 +6238,8 @@ static void amdgpu_device_halt_activities(struct am=
dgpu_device *adev,
>                       amdgpu_device_ip_need_full_reset(tmp_adev))
>                         amdgpu_ras_suspend(tmp_adev);
>
> +               amdgpu_userq_pre_reset(tmp_adev);
> +
>                 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>                         struct amdgpu_ring *ring =3D tmp_adev->rings[i];
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index decedf8057ac..996c7397a57f 100644
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
> @@ -44,6 +46,102 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_=
device *adev)
>         return userq_ip_mask;
>  }
>
> +static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
> +{
> +
> +       if (amdgpu_device_should_recover_gpu(adev)) {
> +               amdgpu_reset_domain_schedule(adev->reset_domain,
> +                                            &adev->userq_reset_work);
> +               /* Wait for the reset job to complete */
> +               flush_work(&adev->userq_reset_work);
> +       }
> +}
> +
> +static int
> +amdgpu_userq_detect_and_reset_sdma(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_sdma_funcs =3D
> +                       adev->userq_funcs[AMDGPU_RING_TYPE_SDMA];
> +       struct amdgpu_usermode_queue *userq;
> +       bool has_sdma =3D false;
> +       bool gpu_reset =3D false;
> +       int id, r =3D 0;
> +
> +       /* Detect if SDMA queues are present */
> +       idr_for_each_entry(&uq_mgr->userq_idr, userq, id) {
> +               if (userq->queue_type =3D=3D AMDGPU_RING_TYPE_SDMA) {
> +                       has_sdma =3D true;
> +                       break;
> +               }
> +       }
> +
> +       if (has_sdma && userq_sdma_funcs && userq_sdma_funcs->detect_and_=
reset) {
> +               r =3D userq_sdma_funcs->detect_and_reset(adev, AMDGPU_RIN=
G_TYPE_SDMA);
> +               if (r)
> +                       gpu_reset =3D true;
> +       }
> +
> +       if (gpu_reset)
> +               amdgpu_userq_gpu_reset(adev);
> +
> +       return r;
> +}
> +
> +static int
> +amdgpu_userq_detect_and_reset_gfx_compute(struct amdgpu_userq_mgr *uq_mg=
r)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_gfx_funcs =3D
> +                       adev->userq_funcs[AMDGPU_RING_TYPE_GFX];
> +       const struct amdgpu_userq_funcs *userq_compute_funcs =3D
> +                       adev->userq_funcs[AMDGPU_RING_TYPE_COMPUTE];
> +       struct amdgpu_usermode_queue *userq;
> +       bool has_gfx =3D false, has_compute =3D false;
> +       bool gpu_reset =3D false;
> +       int id, r =3D 0;
> +
> +       /* Detect which types of queues are present (excluding SDMA) */
> +       idr_for_each_entry(&uq_mgr->userq_idr, userq, id) {
> +               switch (userq->queue_type) {
> +               case AMDGPU_RING_TYPE_GFX:
> +                       has_gfx =3D true;
> +                       break;
> +               case AMDGPU_RING_TYPE_COMPUTE:
> +                       has_compute =3D true;
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +
> +       if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> +               dev_err(adev->dev, "userq reset disabled by debug mask\n"=
);
> +       } else if (amdgpu_gpu_recovery) {
> +               if (has_compute && userq_compute_funcs->detect_and_reset)=
 {
> +                       r =3D userq_compute_funcs->detect_and_reset(adev,=
 AMDGPU_RING_TYPE_COMPUTE);
> +                       if (r) {
> +                               gpu_reset =3D true;
> +                               goto gpu_reset;
> +                       }
> +               }
> +
> +               if (has_gfx && userq_gfx_funcs->detect_and_reset) {
> +                       r =3D userq_gfx_funcs->detect_and_reset(adev, AMD=
GPU_RING_TYPE_GFX);
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

Why split these into two functions?  I think it would be more
efficient to just have a single function
(amdgpu_userq_detect_and_reset()) that works at the device level and
checks to see what types of user queues are present and then calls
detect_and_reset() for each queue type that is present and then have
that function update the queue state of all queues that are hung.
Then just call this function in all the places we call preempt or
unmap.  E.g.,

amdgpu_userq_detect_and_reset()
idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
    /* evict, unmap, */
}

We probably also need some way to determine whether the queue reset
was successful or not because we ultimately need to decide when to do
a full adapter reset.

Alex

> +
>  static int
>  amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -56,6 +154,7 @@ amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mg=
r *uq_mgr,
>         if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
>                 r =3D userq_funcs->preempt(uq_mgr, queue);
>                 if (r) {
> +                       amdgpu_userq_detect_and_reset_gfx_compute(uq_mgr)=
;
>                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
>                 } else {
>                         queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED;
> @@ -72,17 +171,21 @@ amdgpu_userqueue_restore_helper(struct amdgpu_userq_=
mgr *uq_mgr,
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *userq_funcs =3D
>                 adev->userq_funcs[queue->queue_type];
> +       bool gpu_reset =3D false;
>         int r =3D 0;
>
>         if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED) {
>                 r =3D userq_funcs->restore(uq_mgr, queue);
>                 if (r) {
>                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +                       gpu_reset =3D true;
>                 } else {
>                         queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
>                 }
>         }
>
> +       if (gpu_reset)
> +               amdgpu_userq_gpu_reset(adev);
>         return r;
>  }
>
> @@ -98,11 +201,14 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *u=
q_mgr,
>         if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) ||
>                 (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
>                 r =3D userq_funcs->unmap(uq_mgr, queue);
> -               if (r)
> +               if (r) {
> +                       amdgpu_userq_detect_and_reset_gfx_compute(uq_mgr)=
;
>                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> -               else
> +               } else {
>                         queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
> +               }
>         }
> +
>         return r;
>  }
>
> @@ -113,16 +219,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq=
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
> @@ -361,6 +473,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue=
_id)
>                 amdgpu_bo_unreserve(queue->db_obj.obj);
>         }
>         amdgpu_bo_unref(&queue->db_obj.obj);
> +       amdgpu_userq_detect_and_reset_sdma(uq_mgr);
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>         mutex_unlock(&uq_mgr->userq_mutex);
> @@ -734,6 +847,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mg=
r)
>         int queue_id;
>         int ret =3D 0, r;
>
> +       amdgpu_userq_detect_and_reset_sdma (uq_mgr);
>         /* Try to unmap all the queues in this process ctx */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>                 r =3D amdgpu_userqueue_preempt_helper(uq_mgr, queue);
> @@ -746,6 +860,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_m=
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
> @@ -772,22 +903,19 @@ void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>                    struct amdgpu_eviction_fence *ev_fence)
>  {
> -       int ret;
>         struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
>         struct amdgpu_eviction_fence_mgr *evf_mgr =3D &fpriv->evf_mgr;
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       int ret;
>
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
> @@ -828,6 +956,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *u=
serq_mgr)
>
>         mutex_lock(&adev->userq_mutex);
>         mutex_lock(&userq_mgr->userq_mutex);
> +       amdgpu_userq_detect_and_reset_sdma(userq_mgr);
>         idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>                 amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>                 amdgpu_userq_unmap_helper(userq_mgr, queue);
> @@ -861,10 +990,13 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev=
)
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_sdma(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         r =3D amdgpu_userq_unmap_helper(uqm, queue);
> -                       if (r)
> +                       if (r) {
> +                               amdgpu_userq_detect_and_reset_gfx_compute=
(uqm);
>                                 ret =3D r;
> +                       }
>                 }
>                 mutex_unlock(&uqm->userq_mutex);
>         }
> @@ -917,13 +1049,16 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(=
struct amdgpu_device *adev,
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_sdma(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) =
||
>                              (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPU=
TE)) &&
>                             (queue->xcp_id =3D=3D idx)) {
>                                 r =3D amdgpu_userq_unmap_helper(uqm, queu=
e);
> -                               if (r)
> +                               if (r) {
> +                                       amdgpu_userq_detect_and_reset_gfx=
_compute(uqm);
>                                         ret =3D r;
> +                               }
>                         }
>                 }
>                 mutex_unlock(&uqm->userq_mutex);
> @@ -965,3 +1100,57 @@ int amdgpu_userq_start_sched_for_enforce_isolation(=
struct amdgpu_device *adev,
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
> +                               /* re-map queue */
> +                               r =3D userq_funcs->map(uqm, queue);
> +                               if (r) {
> +                                       dev_err(adev->dev, "Failed to rem=
ap queue %d\n", queue_id);
> +                                       continue;
> +                               }
> +                               queue->state =3D AMDGPU_USERQ_STATE_MAPPE=
D;
> +                       }
> +               }
> +       }
> +
> +       return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 9fa0d1a88d71..e68bb144b26f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -138,4 +138,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
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
