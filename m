Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCDECA0EED
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 13:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBDEC10E5F7;
	Tue, 19 Aug 2025 13:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DQDGshDP";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 111A910E5F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 13:20:28 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2445813f6d1so8616695ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 06:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755609627; x=1756214427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikjchid44vYTTADUoQ2qxirVtDQYPdO81RV/vn6ST4k=;
 b=DQDGshDPCrZrF8VziSiRsHzegTD/3Q5IYW2cz2B2Va9nXbdhkCLZkE1ghjT+QXXSHv
 wJ/ZCbPMr/5a7ORd+4jSE+GSMs1zQGCOAfKw1lBxVTjnTDdjdH0Zwe35VfQOqEwVxu14
 mkah7YQqqb32aPT+4qp65YuSPs2zkqRHzC1wTN82J+hDzvmR1vOIk2yYgGJcfcVlWiHx
 Yhcu0B1hqpb+oo5EvRwj1Vrol2qBEglfsub0d4QtIAhnXcSh0zyvok0sNiOVSWmmkUmF
 ZKrhXdt5Ht4AhhwQtGHgJgAb4j2mXGTcrxvRqczbNW3U20qmUoOpCZEwKRzYBZPSP6Kh
 3c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755609627; x=1756214427;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ikjchid44vYTTADUoQ2qxirVtDQYPdO81RV/vn6ST4k=;
 b=DDFkuyE8hrdN1HT9lHhYCIuSeEOM2kD/Gvwq6EjO/bjpmiZ0UeeQMoTDX2cX77tJcR
 cB1YC6iOkakuIufMugUwxG//RBH49gJ6ybFlJPeNdEHo1AOZhPuSg7kQ8NSQE+pNl8um
 1bHyX/JIb8xJvRkGw53J3oEkFvQZKXuYLZ5ThJuR3snje+TYhus2oMd27qW9eiU2nwn1
 FZYoo4XlDx46pjy8XQdpufSzTROuy64dtQv9O6S3HyGdD33OqP4uXLPH+gVYRS5SR9Z4
 kobt/UCmkoYml9uNy3NEzBD8MhK4DXFvztKg+93V17TdxWkAJpesfgZhb6VrPt+niatp
 ZzoQ==
X-Gm-Message-State: AOJu0Yy9h3NY8zD9XJpyz84fVE3FAiKrDFhFhumDpvYgXfDbJHpCv7Az
 i4hV98Q1orxCw3aryMUSggJErw6ZPcWO35+iELYaG6OCnlvWycyFgR7kBNPGFWIM0GO32lb/OCy
 7nWhmM26WTqjCVOArAS/3Wxy4OVJ1SAE=
X-Gm-Gg: ASbGnctNMxeyB5ba0mx+CBM0CtKsvXDuNHj7ORNcZyN08hb5m9h+G820ftnAjAF0L8T
 /v6PVuy+nT6ru88vGKaG2JatI6ZFy2ouLevqTpZfCzrfiUq6aE5VKXNgoUyGTYAwMTeZRK6z3LX
 qdA7nNWDOqjP0KFeVn49sgz/DKQvb7vbM1ap7Da4UvSjjPiwJv09zsHq9g9+a7In2Gx01jc8d3p
 3Ezp8/O3jjaqZ3oJ2Y735CUj6gW
X-Google-Smtp-Source: AGHT+IHNoXRgio4Q2oGGB4PuWwbY9gVEasWJkelkUr8D2XgbsFqZnFCqJKufRL6ZVQwAiBx7sGW29bhGOJQEHVU3sFY=
X-Received: by 2002:a17:903:24d:b0:242:d186:5bce with SMTP id
 d9443c01a7336-245e04956b3mr16513285ad.3.1755609627377; Tue, 19 Aug 2025
 06:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
 <20250811095937.1978747-11-Jesse.Zhang@amd.com>
 <DM4PR12MB515227DAFA41BB91F87A3A0DE330A@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB515227DAFA41BB91F87A3A0DE330A@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Aug 2025 09:20:15 -0400
X-Gm-Features: Ac12FXxcJ82L9_6_xy8BAUl1o9cZEQBZxDkYAEo3dF-bBn0c8CohHI8XBMpV_vI
Message-ID: <CADnq5_PDaKD-MLiXiOJvfjNa05OoBOtCteyU61tr-H6tCnFNvA@mail.gmail.com>
Subject: Re: [v8 11/11] drm/amdgpu: Implement user queue reset functionality
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

On Mon, Aug 18, 2025 at 10:58=E2=80=AFPM Zhang, Jesse(Jie) <Jesse.Zhang@amd=
.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Ping.. on this series.

See my comments on patch 2 from last week.  Once that is fixed, I
think this series is good to go.

Alex

>
> -----Original Message-----
> From: Jesse.Zhang <Jesse.Zhang@amd.com>
> Sent: Monday, August 11, 2025 5:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Ch=
ristian.Koenig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; Zh=
ang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [v8 11/11] drm/amdgpu: Implement user queue reset functionality
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch adds robust reset handling for user queues (userq) to improve =
recovery from queue failures. The key components include:
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
> The reset functionality works with both compute and graphics queues, prov=
iding better resilience against queue failures while minimizing disruption =
to unaffected queues.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 199 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
>  4 files changed, 202 insertions(+), 11 deletions(-)
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
v, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_device.c
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
> index decedf8057ac..028de887df26 100644
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
> @@ -44,6 +46,88 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
evice *adev)
>         return userq_ip_mask;
>  }
>
> +static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev) {
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
> +amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr) {
> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       const struct amdgpu_userq_funcs *userq_gfx_funcs =3D
> +                       adev->userq_funcs[AMDGPU_RING_TYPE_GFX];
> +       const struct amdgpu_userq_funcs *userq_compute_funcs =3D
> +                       adev->userq_funcs[AMDGPU_RING_TYPE_COMPUTE];
> +       const struct amdgpu_userq_funcs *userq_sdma_funcs =3D
> +                       adev->userq_funcs[AMDGPU_RING_TYPE_SDMA];
> +
> +       bool has_gfx =3D false, has_compute =3D false, has_sdma =3D false=
;
> +       struct amdgpu_usermode_queue *userq;
> +       bool gpu_reset =3D false;
> +       int id, r =3D 0;
> +
> +       if (idr_is_empty(&uq_mgr->userq_idr))
> +               return false;
> +
> +       /* Detect which types of queues are present */
> +       idr_for_each_entry(&uq_mgr->userq_idr, userq, id) {
> +               switch (userq->queue_type) {
> +               case AMDGPU_RING_TYPE_GFX:
> +                       has_gfx =3D true;
> +                       break;
> +               case AMDGPU_RING_TYPE_COMPUTE:
> +                       has_compute =3D true;
> +                       break;
> +               case AMDGPU_RING_TYPE_SDMA:
> +                       has_sdma =3D true;
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
> +
> +               if (has_sdma && userq_sdma_funcs && userq_sdma_funcs->det=
ect_and_reset) {
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
>  amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
>                           struct amdgpu_usermode_queue *queue) @@ -56,6 +=
140,7 @@ amdgpu_userqueue_preempt_helper(struct amdgpu_userq_mgr *uq_mgr,
>         if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
>                 r =3D userq_funcs->preempt(uq_mgr, queue);
>                 if (r) {
> +                       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
>                 } else {
>                         queue->state =3D AMDGPU_USERQ_STATE_PREEMPTED; @@=
 -72,17 +157,21 @@ amdgpu_userqueue_restore_helper(struct amdgpu_userq_mgr =
*uq_mgr,
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
> @@ -93,16 +182,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *u=
q_mgr,
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *userq_funcs =3D
>                 adev->userq_funcs[queue->queue_type];
> +       bool gpu_reset =3D false;
>         int r =3D 0;
>
>         if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) ||
>                 (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)) {
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
> @@ -113,16 +209,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq=
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
> @@ -361,6 +463,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue=
_id)
>                 amdgpu_bo_unreserve(queue->db_obj.obj);
>         }
>         amdgpu_bo_unref(&queue->db_obj.obj);
> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>         mutex_unlock(&uq_mgr->userq_mutex);
> @@ -746,6 +849,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_m=
gr)
>         return ret;
>  }
>
> +void amdgpu_userq_reset_work(struct work_struct *work) {
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
> +       amdgpu_device_gpu_recover(adev, NULL, &reset_context); }
> +
>  static int
>  amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)  { @@ -772=
,22 +892,19 @@ void  amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
>                    struct amdgpu_eviction_fence *ev_fence)  {
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
ng for
> +work\n");
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
>         amdgpu_eviction_fence_signal(evf_mgr, ev_fence); @@ -828,6 +945,7=
 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
>
>         mutex_lock(&adev->userq_mutex);
>         mutex_lock(&userq_mgr->userq_mutex);
> +       amdgpu_userq_detect_and_reset_queues(userq_mgr);
>         idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>                 amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>                 amdgpu_userq_unmap_helper(userq_mgr, queue); @@ -861,6 +9=
79,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_queues(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         r =3D amdgpu_userq_unmap_helper(uqm, queue);
>                         if (r)
> @@ -917,6 +1036,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(st=
ruct amdgpu_device *adev,
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_queues(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) =
||
>                              (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPU=
TE)) && @@ -965,3 +1085,60 @@ int amdgpu_userq_start_sched_for_enforce_isol=
ation(struct amdgpu_device *adev,
>         mutex_unlock(&adev->userq_mutex);
>         return ret;
>  }
> +
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev) {
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
> index 9fa0d1a88d71..e68bb144b26f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -138,4 +138,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
uct amdgpu_device *adev,  int amdgpu_userq_start_sched_for_enforce_isolatio=
n(struct amdgpu_device *adev,
>                                                    u32 idx);
>
> +void amdgpu_userq_reset_work(struct work_struct *work);
> +
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev); int
> +amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
> +
>  #endif
> --
> 2.49.0
>
