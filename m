Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED55BCCD1BF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Oct 2025 20:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CA410E1EB;
	Thu, 23 Oct 2025 20:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gSefnqlW";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AC6010E1EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 20:42:02 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-290bcb326deso2791485ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Oct 2025 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761252122; x=1761856922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3yuPYKA/xUPYvkUrqGaV1EM4OWny5Z9cpCvFwYsJ/W4=;
 b=gSefnqlW/A80Ius7i1sO5I6AKXSSE3CAw51Z0KKDzvqYqzPi+/CCnn9hmBU6/gj5rW
 rAW5Dx9pDtXuqVMh1LQkPmhVAxDBKlGFp663VPLYqD2a3A6wJymFhL2jwFy6RE0VLVpD
 SJ1xnGe3o8bWzngueE5B/3bYffkjQ8ZiASch/vCnSD1ySfSA40hGIgTEjgM8JxGTiQgz
 IKvqTtguWz0agfYTo5Sg78bDGWb4ySBDqmUM3MqGNN8N+CM7hhBcSBaXSbild8ZLA0+u
 QxJ7o7J/llen0l5w7E+tO0L/Svm0zxQBvjsCWIheDOscVEzoA4Z2Qtv381AKQ324uxnp
 SwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761252122; x=1761856922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3yuPYKA/xUPYvkUrqGaV1EM4OWny5Z9cpCvFwYsJ/W4=;
 b=rfRJN5jd09J9fJdLAC1yZZfloV5Pwua3Cwlxd3YPb8xptflGx1R4PuKsbPDX9gpOdB
 wP/OOMR1kZIOGl3FN+/NqF6e8+hgcC9Nx/z9HXnaTnUeySAZZiN2E6yUZJzDSnfLdAaH
 dCZ9IXqZgLHtEWN4xn7Zsn8ase8omdIUZlBQ9lJJDaWZ3Us0W+Ct4NlNRIyWs1+PU4cI
 NV+QGimk6CnmqymUu8tgZqp1YowVVxGFkXco2O1V1jg6j49P20Jm7+aiQbbNJ0Q6LcAG
 kata5/TpVPvEXAbgh8oW90j3PyMU6paWQ65q0uLoeR8G5m/nFPaIoWbztyXKGG9Q7ZeI
 zplQ==
X-Gm-Message-State: AOJu0YyTo9m/wtRZZXI1invTXkVKGI1rhdRMIHciKnMKBHhCaJi1+2QH
 tGOwWNFDstcnngyFzld+xaZD8wtvyS3ghcy5KGDZuZGyApuvXiqpEBo9UWZ6usrlMfI4Z+Nexg2
 jPiy65zOB4JWAXJouZZ63tBAzbF4i0Gg=
X-Gm-Gg: ASbGncsbpNnqy3Zto1skvdG+MHUlGT3cVC409ikkvK3NIUhGmoSTlIyavaZXn+cy5fy
 7l59t2JalFfvYJzk8q26wRlftmjkdMm1Uztu/xWPsdA8LzK+bOQh0qTeF1ZQA8dK729GRLjMlA4
 XtL/7YjAZsJ2kGMNtJwstigQzZ4sHmNDxEP4QV10GGz+ScoTqBGyf9wdQhdip9Pff/838RBHSI1
 5cyRtMgz6bqOrprmM/8AaAJXcAQ82skpIX44I8wylnRX9TazNDLv5BkUpya
X-Google-Smtp-Source: AGHT+IGV99WHeuyfXq7mR645UMmR5Z5nxQqGuTd26oCcpYTFsSknIOwwYp/lWqAjjHWN+SK1iNii5+wEmkmDEnHsi58=
X-Received: by 2002:a17:902:f787:b0:290:aaff:344e with SMTP id
 d9443c01a7336-292d3e447f2mr85081665ad.2.1761252121676; Thu, 23 Oct 2025
 13:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <20251015010922.1983385-1-Jesse.Zhang@amd.com>
 <20251015010922.1983385-2-Jesse.Zhang@amd.com>
In-Reply-To: <20251015010922.1983385-2-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 Oct 2025 16:41:50 -0400
X-Gm-Features: AS18NWC_JqaAGSPNqZQXjWEY8vq_BTfW1KXzpY2u8zqHgbVras3Pqd-Y4dmQrPI
Message-ID: <CADnq5_Ms3=s==qkV8MnMDhaxYSbWHnq-=MS+XEiicVWpo7kyng@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/amdgpu: Implement user queue reset
 functionality
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

On Tue, Oct 14, 2025 at 9:09=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
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
> v6: fix lock dep warning in amdgpu_userq_fence_dence_driver_process
>
> v7: add the queue types in an array and use a loop in amdgpu_userq_detect=
_and_reset_queues (Lijo)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   8 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 183 ++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |   5 +
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  13 +-
>  6 files changed, 195 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 3d71da46b471..dc695bf69092 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1314,6 +1314,7 @@ struct amdgpu_device {
>         bool                            apu_prefer_gtt;
>
>         bool                            userq_halt_for_enforce_isolation;
> +       struct work_struct              userq_reset_work;
>         struct amdgpu_uid *uid_info;
>
>         /* KFD
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 5d9fd2cabc58..b63807b7b15a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4583,6 +4583,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>         }
>
>         INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
> +       INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
>
>         adev->gfx.gfx_off_req_count =3D 1;
>         adev->gfx.gfx_off_residency =3D 0;
> @@ -5965,6 +5966,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu=
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
> @@ -6187,6 +6192,7 @@ static inline void amdgpu_device_stop_pending_reset=
s(struct amdgpu_device *adev)
>         if (!amdgpu_sriov_vf(adev))
>                 cancel_work(&adev->reset_work);
>  #endif
> +       cancel_work(&adev->userq_reset_work);
>
>         if (adev->kfd.dev)
>                 cancel_work(&adev->kfd.reset_work);
> @@ -6307,6 +6313,8 @@ static void amdgpu_device_halt_activities(struct am=
dgpu_device *adev,
>                     amdgpu_device_ip_need_full_reset(tmp_adev))
>                         amdgpu_ras_suspend(tmp_adev);
>
> +               amdgpu_userq_pre_reset(tmp_adev);
> +
>                 for (i =3D 0; i < AMDGPU_MAX_RINGS; ++i) {
>                         struct amdgpu_ring *ring =3D tmp_adev->rings[i];
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 87b962df5460..7a27c6c4bb44 100644
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
> index 1e3a1013eb71..4a7a954ee8ed 100644
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
> @@ -45,6 +47,69 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
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
> +       const int queue_types[] =3D {
> +               AMDGPU_RING_TYPE_COMPUTE,
> +               AMDGPU_RING_TYPE_GFX,
> +               AMDGPU_RING_TYPE_SDMA
> +       };
> +       const int num_queue_types =3D ARRAY_SIZE(queue_types);
> +       bool gpu_reset =3D false;
> +       int r =3D 0;
> +       int i;
> +
> +       /* Warning if current process mutex is not held */
> +       WARN_ON(!mutex_is_locked(&uq_mgr->userq_mutex));
> +
> +       if (unlikely(adev->debug_disable_gpu_ring_reset)) {
> +               dev_err(adev->dev, "userq reset disabled by debug mask\n"=
);
> +               return 0;
> +       }
> +
> +       /*
> +        * If GPU recovery feature is disabled system-wide,
> +        * skip all reset detection logic
> +        */
> +       if (!amdgpu_gpu_recovery)
> +               return 0;
> +
> +       /*
> +        * Iterate through all queue types to detect and reset problemati=
c queues
> +        * Process each queue type in the defined order
> +        */
> +       for (i =3D 0; i < num_queue_types; i++) {
> +               int ring_type =3D queue_types[i];
> +               const struct amdgpu_userq_funcs *funcs =3D adev->userq_fu=
ncs[ring_type];

For consistency with kernel queues, We may want something like:
if (!amdgpu_userq_is_reset_type_supported(ring_type,
AMDGPU_RESET_TYPE_PER_QUEUE))
    continue;


> +
> +               if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
> +                   funcs && funcs->detect_and_reset) {
> +                       r =3D funcs->detect_and_reset(adev, ring_type);
> +                       if (r) {
> +                               gpu_reset =3D true;
> +                               break;
> +                       }
> +               }
> +       }
> +
> +       if (gpu_reset)
> +               amdgpu_userq_gpu_reset(adev);
> +
> +       return r;
> +}
> +
>  static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue =
*queue,
>                                            struct amdgpu_bo_va_mapping *v=
a_map, u64 addr)
>  {
> @@ -175,17 +240,22 @@ amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr=
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
> @@ -217,16 +287,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *=
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
> @@ -243,10 +320,12 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq=
_mgr,
>                 r =3D userq_funcs->map(uq_mgr, queue);
>                 if (r) {
>                         queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +                       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>                 } else {
>                         queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
>                 }
>         }
> +
>         return r;
>  }
>
> @@ -474,10 +553,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int que=
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
> @@ -699,6 +779,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>         kfree(queue_name);
>
>         args->out.queue_id =3D qid;
> +       atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
>
>  unlock:
>         mutex_unlock(&uq_mgr->userq_mutex);
> @@ -965,6 +1046,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_m=
gr)
>         unsigned long queue_id;
>         int ret =3D 0, r;
>
> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         /* Try to unmap all the queues in this process ctx */
>         xa_for_each(&uq_mgr->userq_mgr_xa, queue_id, queue) {
>                 r =3D amdgpu_userq_preempt_helper(uq_mgr, queue);
> @@ -977,6 +1059,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_=
mgr)
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
> @@ -1004,22 +1103,19 @@ void
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
> @@ -1036,11 +1132,18 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mg=
r,
>  int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm=
_file *file_priv,
>                           struct amdgpu_device *adev)
>  {
> +       int i;
> +
>         mutex_init(&userq_mgr->userq_mutex);
>         xa_init_flags(&userq_mgr->userq_mgr_xa, XA_FLAGS_ALLOC);
>         userq_mgr->adev =3D adev;
>         userq_mgr->file =3D file_priv;
>
> +       /* Initialize all queue type counters to zero */
> +       for (i =3D 0; i < AMDGPU_RING_TYPE_MAX; i++) {
> +               atomic_set(&userq_mgr->userq_count[i], 0);

These should already be 0 since we kzalloc the structure.

> +       }
> +
>         INIT_DELAYED_WORK(&userq_mgr->resume_work, amdgpu_userq_restore_w=
orker);
>         return 0;
>  }
> @@ -1053,6 +1156,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr =
*userq_mgr)
>         cancel_delayed_work_sync(&userq_mgr->resume_work);
>
>         mutex_lock(&userq_mgr->userq_mutex);
> +       amdgpu_userq_detect_and_reset_queues(userq_mgr);
>         xa_for_each(&userq_mgr->userq_mgr_xa, queue_id, queue) {
>                 amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>                 amdgpu_userq_unmap_helper(userq_mgr, queue);
> @@ -1079,6 +1183,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev=
)
>                 uqm =3D queue->userq_mgr;
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 guard(mutex)(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_queues(uqm);
>                 if (adev->in_s0ix)
>                         r =3D amdgpu_userq_preempt_helper(uqm, queue);
>                 else
> @@ -1137,6 +1242,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(s=
truct amdgpu_device *adev,
>                 if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) ||
>                      (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPUTE)) &&
>                     (queue->xcp_id =3D=3D idx)) {
> +                       amdgpu_userq_detect_and_reset_queues(uqm);
>                         r =3D amdgpu_userq_preempt_helper(uqm, queue);
>                         if (r)
>                                 ret =3D r;
> @@ -1209,3 +1315,56 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdg=
pu_device *adev,
>
>         return 0;
>  }
> +
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
> +{
> +       const struct amdgpu_userq_funcs *userq_funcs;
> +       struct amdgpu_usermode_queue *queue;
> +       struct amdgpu_userq_mgr *uqm;
> +       unsigned long queue_id;
> +
> +       xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +               uqm =3D queue->userq_mgr;
> +               cancel_delayed_work_sync(&uqm->resume_work);
> +               if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
> +                       amdgpu_userq_wait_for_last_fence(uqm, queue);
> +                       userq_funcs =3D adev->userq_funcs[queue->queue_ty=
pe];
> +                       userq_funcs->unmap(uqm, queue);
> +                       /* just mark all queues as hung at this point.
> +                        * if unmap succeeds, we could map again
> +                        * in amdgpu_userq_post_reset() if vram is not lo=
st
> +                        */
> +                       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +                       amdgpu_userq_fence_driver_force_completion(queue)=
;
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
> +       unsigned long queue_id;
> +       int r =3D 0;
> +
> +       xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
> +               uqm =3D queue->userq_mgr;
> +               if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG && !vram_=
lost) {
> +                       userq_funcs =3D adev->userq_funcs[queue->queue_ty=
pe];
> +                       /* Re-map queue */
> +                       r =3D userq_funcs->map(uqm, queue);
> +                       if (r) {
> +                               dev_err(adev->dev, "Failed to remap queue=
 %ld\n", queue_id);
> +                               continue;
> +                       }
> +                       queue->state =3D AMDGPU_USERQ_STATE_MAPPED;
> +               }
> +       }
> +
> +       return r;
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 09da0617bfa2..c37444427a14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -106,6 +106,7 @@ struct amdgpu_userq_mgr {
>         struct amdgpu_device            *adev;
>         struct delayed_work             resume_work;
>         struct drm_file                 *file;
> +       atomic_t                        userq_count[AMDGPU_RING_TYPE_MAX]=
;
>  };
>
>  struct amdgpu_db_info {
> @@ -148,6 +149,10 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(st=
ruct amdgpu_device *adev,
>                                                   u32 idx);
>  int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device =
*adev,
>                                                    u32 idx);
> +void amdgpu_userq_reset_work(struct work_struct *work);
> +void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
> +int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
> +
>  int amdgpu_userq_input_va_validate(struct amdgpu_usermode_queue *queue,
>                                    u64 addr, u64 expected_size);
>  int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 2aeeaa954882..aab55f38d81f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c

The changes to this file should be a separate bug fix patch.

Alex

> @@ -151,15 +151,20 @@ void amdgpu_userq_fence_driver_process(struct amdgp=
u_userq_fence_driver *fence_d
>  {
>         struct amdgpu_userq_fence *userq_fence, *tmp;
>         struct dma_fence *fence;
> +       unsigned long flags;
>         u64 rptr;
>         int i;
>
>         if (!fence_drv)
>                 return;
> -
> +       /*
> +        * Use interrupt-safe spinlock since this function can be called =
from:
> +        * 1. Interrupt context (IRQ handlers like gfx_v11_0_eop_irq)
> +        * 2. Process context (workqueues like eviction suspend worker)
> +        * Using regular spin_lock() in interrupt context causes lockdep =
warnings.
> +        */
> +       spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>         rptr =3D amdgpu_userq_fence_read(fence_drv);
> -
> -       spin_lock(&fence_drv->fence_list_lock);
>         list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, li=
nk) {
>                 fence =3D &userq_fence->base;
>
> @@ -174,7 +179,7 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_=
userq_fence_driver *fence_d
>                 list_del(&userq_fence->link);
>                 dma_fence_put(fence);
>         }
> -       spin_unlock(&fence_drv->fence_list_lock);
> +       spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  }
>
>  void amdgpu_userq_fence_driver_destroy(struct kref *ref)
> --
> 2.49.0
>
