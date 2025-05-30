Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D943C5B543
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 22:18:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8136F10E88C;
	Fri, 30 May 2025 22:18:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="muE/wIot";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3696A10E88C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 22:18:13 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-235248ba788so3045225ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 15:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748643493; x=1749248293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7uOzV1iFOJItkVT/qGQnK/iqzYXDKjZTN8oNVdstWA=;
 b=muE/wIotKUOdcwykmB2FoNA5KHss1L+QRBY7Lw6eefIx2ToS17aXBephNnZfA+NS+0
 1VITjnLhLr3ZoaHoyQ/75t+XRbLwU7m4wdXX0ZZq77M1MoZiL9TpY+UQxH5QEYIVk9CU
 fV1RrG/8h+IIakEukdhPFAg8qAbS8dFZsE/2xOrncpHAUyi2e+E4luSZrKg9ILxgDQ+o
 /kVslrtWVYPCuwuH8SLVcPmRciRXnjcBqoS0zLntSlLrRwbTiOXDIjs4JTcMgJzrYX2H
 w79wbINgmrnbVJxOgshBVe+DMRCEBogDvr64jgu4nMOlrHJbqrFaDVhr2w9apwwrWenl
 1/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748643493; x=1749248293;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7uOzV1iFOJItkVT/qGQnK/iqzYXDKjZTN8oNVdstWA=;
 b=JxKr1+joOWZLX6q9BxRu9+ZaZBB1WRFLSzdmnvMP7B0G3081lMzjf7USL9UQNYBStt
 EXHFoAqjR88RrUeePpOv8PfVBUtcLlmx8MyAgVY+M/WNYMSAKdbZrYWPRRrU5ZuYONxi
 7yIMLhKi/h72GxhSNnm54U4/V6SQ6iefwAJhbiG+LeOrGLoTqaZjwBf7bbwcF+3vJ4DR
 g1Don9+gvC3nvfjz6SgZRMiejZGb80nW1EZytC3tSQwHNTRhl+WYw3anJi2Gas/np4vZ
 wEY3GjH7e40afIJtCK8bdLH1AZq8UJPKNtxioe/93tJYT8Gun6e/1vcJ4CqXHvxRBh76
 LDHw==
X-Gm-Message-State: AOJu0YwOxcxI0BONGYeegW8mRVtFROIPALDuW2YxiEbEAQQQ+0CWhnnr
 hG4IQnlM/JbZBJfB1nqhmXU0nIHmcImzA5yg070NG7z/idjeBL9UahAYw/ejJxBbgE9mwQkCa0O
 ZZX3ZMLuircsdRIf/Rnk1BxVb1slfaYLpgBef
X-Gm-Gg: ASbGncufLngl6Lz7prBnYKVqxiwGjsyEDzhPbg8vFQk3RYyHFxAnG5RGgELZ8MQ/sa2
 1ttgyGHamCahWXuMSnNU8Ix8mPiNma95MYdmwlJTAlxUUgQ+MB8Xe/obL1ZOcICh2fKu4dXZktY
 ISJlZbq8PGGkvxe8saCivzP0NICXOWeBFIrA==
X-Google-Smtp-Source: AGHT+IHBZLmUT0Yi30ogut8a/5F4dPn19hRiw3HOt2jFZvY7xz2A7xkJbz1eY7OgMWDe6Kktvt0f7z/QS2Gz1DsC+6w=
X-Received: by 2002:a17:902:ecd0:b0:234:ba37:87a3 with SMTP id
 d9443c01a7336-235289cdb41mr27324465ad.3.1748643492651; Fri, 30 May 2025
 15:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
 <20250530090322.3589364-5-Jesse.Zhang@amd.com>
In-Reply-To: <20250530090322.3589364-5-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 May 2025 18:18:01 -0400
X-Gm-Features: AX0GCFsFI2VtheuCyYVhEKpnDDvd2ERwHkp6ELgJHzdQ0Hnb41ePMidAHQfyOc8
Message-ID: <CADnq5_P1cDR123tp125OCq=+b6EurouxCE3VLoReVipSuytzGA@mail.gmail.com>
Subject: Re: [PATCH 05/14] drm/amdgpu/userq: implement resets
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
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

On Fri, May 30, 2025 at 5:04=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> If map or unmap fails, or a user fence times out, attempt to reset the qu=
eue.  If that fails, schedule a GPU reset.
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 123 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
>  4 files changed, 128 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index a5ccd0ada16a..7365558f47a1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1303,6 +1303,7 @@ struct amdgpu_device {
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
> index 72e41781afb0..2c90a7d256e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4426,6 +4426,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         }
>
>         INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +       INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
>
>         adev->gfx.gfx_off_req_count =3D 1;
>         adev->gfx.gfx_off_residency =3D 0;
> @@ -5768,6 +5769,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu=
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
> @@ -5990,6 +5995,7 @@ static inline void amdgpu_device_stop_pending_reset=
s(struct amdgpu_device *adev)
>         if (!amdgpu_sriov_vf(adev))
>                 cancel_work(&adev->reset_work);
>  #endif
> +       cancel_work(&adev->userq_reset_work);
>
>         if (adev->kfd.dev)
>                 cancel_work(&adev->kfd.reset_work);
> @@ -6100,6 +6106,8 @@ static int amdgpu_device_halt_activities(struct amd=
gpu_device *adev,
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
> index 295e7186e156..d4f807256383 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -26,7 +26,10 @@
>  #include <drm/drm_exec.h>
>  #include <linux/pm_runtime.h>
>
> +#include <drm/drm_drv.h>
> +
>  #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
> @@ -44,6 +47,44 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
evice *adev)
>         return userq_ip_mask;
>  }
>
> +static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
> +{
> +
> +       if (amdgpu_device_should_recover_gpu(adev))
> +               amdgpu_reset_domain_schedule(adev->reset_domain,
> +                                            &adev->userq_reset_work);
> +}
> +
> +static bool
> +amdgpu_userq_queue_reset_helper(struct amdgpu_userq_mgr *uq_mgr,
> +                               struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_funcs =3D
> +               adev->userq_funcs[queue->queue_type];
> +       bool gpu_reset =3D false;
> +       int r;
> +
> +       if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> +               dev_err(adev->dev, "userq reset disabled by debug mask\n"=
);
> +       } else if (amdgpu_gpu_recovery && userq_funcs->reset) {
> +               r =3D userq_funcs->reset(uq_mgr, queue);
> +               if (r) {
> +                       dev_err(adev->dev, "userq reset failed\n");
> +                       gpu_reset =3D true;
> +               } else {
> +                       dev_err(adev->dev, "userq reset succeeded\n");
> +                       atomic_inc(&adev->gpu_reset_counter);
> +                       amdgpu_userq_fence_driver_force_completion(queue)=
;
> +                       drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE=
_RECOVERY_NONE);
> +               }
> +       } else if (amdgpu_gpu_recovery && !userq_funcs->reset) {
> +               gpu_reset =3D true;
> +       }
> +
> +       return gpu_reset;
> +}

After our discussions with the MES team, I think we should approach
this slightly differently.  I see two options:

1. Use the existing userq reset callback but rather than trying to use
the reset single queue API, use the detect and reset API instead.
2. Add a new higher level callback (e.g., mes vs. umsch, etc.) for
detect and reset and update the queue status for all hung queues.
Then call that new callback in all the places amdgpu_userq.c where we
call amdgpu_userq_unmap_helper().  E.g.,

    /* detect all the queues that are hung, reset, and update their
status to hung */
    amdgpu_userq_detect_and_reset_queues()
    idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
                /* only unmap the queues that are not already marked as hun=
g */
                r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
               ...
    }

The second option has the advantage of only needing to call the MES
API once rather than per queue.

Alex

> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -51,15 +92,22 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq=
_mgr,
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *userq_funcs =3D
>                 adev->userq_funcs[queue->queue_type];
> +       bool gpu_reset =3D false;
>         int r =3D 0;
>
>         if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
>                 r =3D userq_funcs->unmap(uq_mgr, queue);
> -               if (r)
> +               if (r) {
>                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> -               else
> +                       gpu_reset =3D amdgpu_userq_queue_reset_helper(uq_=
mgr, queue);
> +               } else {
>                         queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
> +               }
>         }
> +
> +       if (gpu_reset)
> +               amdgpu_userq_gpu_reset(adev);
> +
>         return r;
>  }
>
> @@ -70,16 +118,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_=
mgr,
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
> +                       gpu_reset =3D amdgpu_userq_queue_reset_helper(uq_=
mgr, queue);
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
> @@ -703,6 +757,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_m=
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
> @@ -729,22 +800,18 @@ void
>  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>                    struct amdgpu_eviction_fence *ev_fence)
>  {
> -       int ret;
>         struct amdgpu_fpriv *fpriv =3D uq_mgr_to_fpriv(uq_mgr);
>         struct amdgpu_eviction_fence_mgr *evf_mgr =3D &fpriv->evf_mgr;
> +       int ret;
>
>         /* Wait for any pending userqueue fence work to finish */
>         ret =3D amdgpu_userq_wait_for_signal(uq_mgr);
> -       if (ret) {
> +       if (ret)
>                 drm_file_err(uq_mgr->file, "Not evicting userqueue, timeo=
ut waiting for work\n");
> -               return;
> -       }
>
>         ret =3D amdgpu_userq_evict_all(uq_mgr);
> -       if (ret) {
> +       if (ret)
>                 drm_file_err(uq_mgr->file, "Failed to evict userqueue\n")=
;
> -               return;
> -       }
>
>         /* Signal current eviction fence */
>         amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
> @@ -922,3 +989,41 @@ int amdgpu_userq_start_sched_for_enforce_isolation(s=
truct amdgpu_device *adev,
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
> +       mutex_lock(&adev->userq_mutex);
> +       list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
> +               cancel_delayed_work_sync(&uqm->resume_work);
> +               mutex_lock(&uqm->userq_mutex);
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
> +               mutex_unlock(&uqm->userq_mutex);
> +       }
> +       mutex_unlock(&adev->userq_mutex);
> +}
> +
> +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
> +{
> +       /* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
> +        * at this point, we should be able to map it again
> +        * and continue if vram is not lost.
> +        */
> +       return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 3cc0ad8919f4..9d62befcdb24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -134,4 +134,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
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
