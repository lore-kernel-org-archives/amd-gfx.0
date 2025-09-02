Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AA4CA1007
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 21:39:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B59E10E840;
	Tue,  2 Sep 2025 21:39:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J41XYudN";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5061010E840
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 21:39:17 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-248f2da72edso12035815ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756849157; x=1757453957; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41yvSP3zALkYkEuydVrXUNUdvTv5i26VRu139ssUbRU=;
 b=J41XYudN2nZ0/2jsEeFlhokmfNWZq8K1tfGlqNM0GWUL46y47Bnv/i2HJ9EQRo5ziy
 gFQ4xAy4QkYO0joTUzDR9bSe9+QM/DF16BKsQBJ3RMb3jLLS5Up/96oSROnw02Ug1mZJ
 Rp1d55YEMrVev578Msuhd8SyWtx2brJC4+fJxqQrw0wA2kc1EhZcm7+Fqcv5s5uGStQ/
 3nM9PAA5xf+1XjyVRE/xyobFnc8lJ+UWQynFCjhV605OLggaOoOqmbJlSgdOB+gIe71z
 jyE4RKH+TK6hwbIceGW+z1DZfqiyeUGHiWSHBtdyVPOKgNpEEsjiNaKvxTT5PUegu339
 QspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756849157; x=1757453957;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=41yvSP3zALkYkEuydVrXUNUdvTv5i26VRu139ssUbRU=;
 b=oOKLMeD5D+5yz4PwEYLsfaKvHfChT4LXsNR5ImpIlV83PSYM04HVf8oQLcOBrls7/B
 1SwYOjfmyZKsNngU+kjBnrFmChwYN9iP1DcOtzi6MlYSD3Dvix0tXq/HB4YlQ0Mw1cTB
 Yi5EIAIFAHLDe4JsJhXLQV5zPvKXrYVTtoq9teJSgRYA0PTL6Xg3ZYCStFvrendVqfcD
 C+rFuPQhBlNOgR/fDsfGTn57XL6/WRQoEJMs+5n/ZssBwc+u5e3eWa8usW/d9Nyc8FRB
 OW5oHKMdmqavkQF6z6DAAv/5QqkH6I6GcaVpbEWOChv8kzACyHDHuCD21WwoxPjYNwsE
 VTTg==
X-Gm-Message-State: AOJu0YyyfzKULtWqp49256wlS8LBJk5K/2MDk8cRggCivgNpaJibTsk/
 xUgJfm/r8xX8pZfLLawzFEzL14KnYAoh6I0dR9KtG3ur1BuXa1Pmcjz0cq7fpgHR8Uc4ZvXk5DO
 362obBxHj3PD3XpesJvzmJEWf5zvtdF4FMa7l
X-Gm-Gg: ASbGncsdZHiKcZDe+LFFsTgthE753c+lnOTqhSAWRC58Xm/TWdT3K7mEToYf/hnJRvI
 iiq/egvmHEmABi/js4i7Xwial1Xjh4CDWfeOReYF12KkhHLpVbf5xxfs4Myz6wF8klwKG4/iDEI
 DAMSmXsp69qo5QCSzA0wMOhi7lw4/6h46XN7NTcYCdzKqHjQPDwe3gP3jbvhbTNXmCP9ttU7+cI
 4WU09TOWzQhY1NCow==
X-Google-Smtp-Source: AGHT+IF03QmFRIx9+Yl0oyehiZPD/L0mTF7SmmV3tUmGfDD8KM4cqOtu7wzt+MdS8kB2AxgLXVbx4hP2RMxxmtSySRI=
X-Received: by 2002:a17:902:d2cb:b0:248:dd61:46e8 with SMTP id
 d9443c01a7336-2491ecddd8bmr114643125ad.5.1756849156612; Tue, 02 Sep 2025
 14:39:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250902080712.2515811-1-Jesse.Zhang@amd.com>
 <20250902080712.2515811-11-Jesse.Zhang@amd.com>
In-Reply-To: <20250902080712.2515811-11-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Sep 2025 17:39:04 -0400
X-Gm-Features: Ac12FXxsRfcupxoWsMubp-9UWi3LVoRd5n19EtQeUdhU_-aMUY6wtYOG3jl1Ip8
Message-ID: <CADnq5_MpYB2vZUBJEoXd3kL9EuH6PjX+Ey=bon0daXbptkwQ2g@mail.gmail.com>
Subject: Re: [v13 11/11] drm/amdgpu: Implement user queue reset functionality
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

On Tue, Sep 2, 2025 at 4:08=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
ote:
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
> v2: add detection and reset calls when preemption/unmaped fails.
>     add a per device userq counter for each user queue type.(Alex)
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 203 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   8 +
>  4 files changed, 209 insertions(+), 11 deletions(-)
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
> index 54851ba8756a..87672b33102e 100644
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
> @@ -44,6 +46,64 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
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

We need to make sure we hold the adev->userq_mutex as well as the per
process user queue mutexes when we call this function because the
detect_and_reset() functions can mess with queues from any process.
We may want to get rid of the per process userq mutex and just use the
global one for all of these cases.

Alex

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
> @@ -51,17 +111,22 @@ amdgpu_userq_preempt_helper(struct amdgpu_userq_mgr =
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
> @@ -93,16 +158,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *u=
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
> @@ -113,16 +185,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq=
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
> @@ -361,6 +439,18 @@ amdgpu_userq_destroy(struct drm_file *filp, int queu=
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
> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>         mutex_unlock(&uq_mgr->userq_mutex);
> @@ -520,6 +610,19 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>
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
>
>  unlock:
>         mutex_unlock(&uq_mgr->userq_mutex);
> @@ -734,6 +837,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mg=
r)
>         int queue_id;
>         int ret =3D 0, r;
>
> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         /* Try to unmap all the queues in this process ctx */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
>                 r =3D amdgpu_userq_preempt_helper(uq_mgr, queue);
> @@ -746,6 +850,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_m=
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
> @@ -772,22 +893,19 @@ void
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
> @@ -811,6 +929,9 @@ int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *us=
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
> @@ -828,6 +949,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *u=
serq_mgr)
>
>         mutex_lock(&adev->userq_mutex);
>         mutex_lock(&userq_mgr->userq_mutex);
> +       amdgpu_userq_detect_and_reset_queues(userq_mgr);
>         idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>                 amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>                 amdgpu_userq_unmap_helper(userq_mgr, queue);
> @@ -861,6 +983,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_queues(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         r =3D amdgpu_userq_unmap_helper(uqm, queue);
>                         if (r)
> @@ -917,6 +1040,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(st=
ruct amdgpu_device *adev,
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_queues(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         if (((queue->queue_type =3D=3D AMDGPU_HW_IP_GFX) =
||
>                              (queue->queue_type =3D=3D AMDGPU_HW_IP_COMPU=
TE)) &&
> @@ -965,3 +1089,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation(=
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
> index 9fa0d1a88d71..ff9aa41c4ff8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -93,6 +93,9 @@ struct amdgpu_userq_mgr {
>         struct delayed_work             resume_work;
>         struct list_head                list;
>         struct drm_file                 *file;
> +       atomic_t                        userq_gfx_count;
> +       atomic_t                        userq_compute_count;
> +       atomic_t                        userq_sdma_count;
>  };
>
>  struct amdgpu_db_info {
> @@ -138,4 +141,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(str=
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
