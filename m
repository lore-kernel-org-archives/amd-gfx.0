Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61666C71155
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 03:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EAD010E13F;
	Tue, 17 Jun 2025 03:30:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aGxwtZ3f";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697FE10E13F
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 03:30:07 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-313290ea247so996693a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 20:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750131007; x=1750735807; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Cb7Uz3WhjX06BXHoiwzJFXAU8eFIwYayFLU20XZiqQ=;
 b=aGxwtZ3fJR1GinwEfT3e7j/ucs41QKPbJUfD/ngkciCqfOKMvE/dOyzRRykFIAXAQH
 KMORh6UlMKZlsoo691ntNR/Pg0b5uQqi4HxXRXev12KToLRKcHu+0ntGzFMPFrCEAKZ2
 V2XrUTz/1Qe+Wt1sspGJhZSaCvpbEKGrhBsECp7K9WiiIZ4pqRB9dMcmOruDjE1pTMAb
 YNyCrhWthmdGQoHPNkYS9/mpygjlwaqNbxHx9+zEBZC1wiiGwGkt/zg8M1bshtUiOQ5J
 rcbapqw+ocIrTsrZw6Ll50cJTSCcNdchTEeX/sOeGc8k29qOUnpud4aiUYVzw67hYatK
 hflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750131007; x=1750735807;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Cb7Uz3WhjX06BXHoiwzJFXAU8eFIwYayFLU20XZiqQ=;
 b=wZfdqavmEkyN3VTBZ/FuwrrHkM5n3MzJymt7ZenHaBtVs3KqQY6n6LnVc27Ep3MP8T
 0hp122hw1H3zOr385VYhwmOk70iP4wZY0ICwHKtdeKVKFy1s9mIZgVnH8BJaZab/Ps5/
 xSeizSx1HCv7nTTiw/+RqXHD4BnfYGgEmnKi+mBON6XX/NIEIjrOF4Iz7qSrUKDqUo8C
 AmjYIBu+97jo/aTQ9/0aeqPXvxq04EuDUcVkogvwmSNx6Z0hZWdlydYRV34oyVsL0GFy
 NGlW8MKobJ2qhVwGqihTsZKjrzeXA64vXmUOFa0O5LJV/kDd4VY6wRKrOcmeKmw9WqKd
 GWzA==
X-Gm-Message-State: AOJu0YybY74zZavR1Ab9LggLZWDy8oto99VDXq3eVovIHcn6Vqgyvq/O
 CtTC3F1dh29dxAd86Cg/3LV9McGeDTqywOK1mNMsIZVePS5d1huCdtJAlgwiyFFm9L3gA+x1Tur
 gkqmcNW1cp+OkH6bzLEAiyv1xh4LDR8otqLtP
X-Gm-Gg: ASbGncs+ExHAGJlau0ADHUYdXHNOhLY5K4rapCXTwcIoALANuDQElootvK9YI3CxVJb
 RtU1AiuMN79BomgPcGlhxPlfOrxAqJEtZjqo2z9Sx0Udilg2Lya67KHjLGX4tNkIDGU9yapNbek
 01z9O1/LEJNudI9lLbWK4guszkGYfuQAK9+B7Z7JSmIJ14
X-Google-Smtp-Source: AGHT+IENREb2jaK8Z3g0mvkrml5z+MM2N16OZhi0gxVYz9YxKO++J5VITWOTbZIpoMuEUs7Q6AQAaxak8CQoskafkHI=
X-Received: by 2002:a17:90b:2d0e:b0:312:db8:dbd3 with SMTP id
 98e67ed59e1d1-313f1e2903amr7011631a91.6.1750131006555; Mon, 16 Jun 2025
 20:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250616034605.2683434-1-Jesse.Zhang@amd.com>
 <20250616034605.2683434-9-Jesse.Zhang@amd.com>
In-Reply-To: <20250616034605.2683434-9-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jun 2025 23:29:54 -0400
X-Gm-Features: AX0GCFtQ-vJh6DgOXlnw3ANxqaSbMZD6RNGtRYUL174bdhzoPIGpBhz0zIyT8xk
Message-ID: <CADnq5_PbjGhiW9XJ6qcfm1VSJyATVAbVdViSXrRVqf+cp+7s9A@mail.gmail.com>
Subject: Re: [v2 9/9] drm/amdgpu: implements detect and reset
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

On Mon, Jun 16, 2025 at 12:11=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> before unmap, attempt to detect and reset the hang queue.
> If that fails, schedule a GPU reset.

Thinking about this more, it makes more sense to move this patch up
and implement adapter resets first.  I.e., drop the detect and reset
stuff for now and just fallback to amdgpu_userq_gpu_reset() if map or
unmap fails.  Then once we get the userq resets sorted out, we can
plumb that in as the optimal solution.

Alex

>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 128 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
>  4 files changed, 131 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 5e2f086d2c99..f1e520b81eae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1304,6 +1304,7 @@ struct amdgpu_device {
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
> index 00174437b01e..6eae2dc2080b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4432,6 +4432,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         }
>
>         INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +       INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
>
>         adev->gfx.gfx_off_req_count =3D 1;
>         adev->gfx.gfx_off_residency =3D 0;
> @@ -5828,6 +5829,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu=
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
> @@ -6050,6 +6055,7 @@ static inline void amdgpu_device_stop_pending_reset=
s(struct amdgpu_device *adev)
>         if (!amdgpu_sriov_vf(adev))
>                 cancel_work(&adev->reset_work);
>  #endif
> +       cancel_work(&adev->userq_reset_work);
>
>         if (adev->kfd.dev)
>                 cancel_work(&adev->kfd.reset_work);
> @@ -6160,6 +6166,8 @@ static int amdgpu_device_halt_activities(struct amd=
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
> index 295e7186e156..5a7c933adae7 100644
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
> @@ -44,6 +47,39 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
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
> +amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
> +{
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_gfx_funcs =3D
> +                       adev->userq_funcs[AMDGPU_RING_TYPE_GFX];
> +
> +       if (!!idr_is_empty(&uq_mgr->userq_idr))
> +               return false;
> +
> +       if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> +               dev_err(adev->dev, "userq reset disabled by debug mask\n"=
);
> +       } else if (amdgpu_gpu_recovery) {
> +               if (userq_gfx_funcs->detect_and_reset) {
> +                       if (userq_gfx_funcs->detect_and_reset(adev, AMDGP=
U_RING_TYPE_GFX)) {
> +                               amdgpu_userq_gpu_reset(adev);
> +                               return true;
> +                       }
> +               }
> +               //TODO: support compute user queue detect and reset.
> +       }
> +
> +       return false;
> +}
> +
>  static int
>  amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue)
> @@ -51,15 +87,22 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq=
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
> +                       gpu_reset =3D true;
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
> @@ -70,16 +113,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_=
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
> @@ -318,6 +367,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue=
_id)
>                 amdgpu_bo_unreserve(queue->db_obj.obj);
>         }
>         amdgpu_bo_unref(&queue->db_obj.obj);
> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>         mutex_unlock(&uq_mgr->userq_mutex);
> @@ -691,6 +741,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mg=
r)
>         int queue_id;
>         int ret =3D 0, r;
>
> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         /* Try to unmap all the queues in this process ctx */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>                 r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
> @@ -703,6 +754,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_m=
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
> @@ -729,22 +797,19 @@ void
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
> @@ -785,6 +850,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *u=
serq_mgr)
>
>         mutex_lock(&adev->userq_mutex);
>         mutex_lock(&userq_mgr->userq_mutex);
> +       amdgpu_userq_detect_and_reset_queues(userq_mgr);
>         idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>                 amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>                 amdgpu_userq_unmap_helper(userq_mgr, queue);
> @@ -818,6 +884,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_queues(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         r =3D amdgpu_userq_unmap_helper(uqm, queue);
>                         if (r)
> @@ -874,6 +941,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
uct amdgpu_device *adev,
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_queues(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) =
||
>                              (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPU=
TE)) &&
> @@ -922,3 +990,41 @@ int amdgpu_userq_start_sched_for_enforce_isolation(s=
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
> index 0335ff03f65f..649ec25f4deb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -135,4 +135,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
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
