Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAFDFC87FCB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Aug 2025 19:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D8D10E980;
	Fri,  8 Aug 2025 19:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ShlGjYpp";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D4D10E980
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Aug 2025 19:58:23 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-23ff92d05acso4381515ad.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Aug 2025 12:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754683103; x=1755287903; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JlkTztSTwTY91xR8YRYmn/soHcjh2hdDrlkZxKsl7cg=;
 b=ShlGjYppyNK4GpkEcLxvyunP3TgyuFkCcIw5VHtMNk2gAygJZzw1zI4Fu/oZB/Q/XL
 D26t7Rlk9SgZPzOuPvm3j5kHMldQ03rWp3vX0x6B3lAQUZwI6iuT7TX8ex2FICTJBmgJ
 AihL098PDaw7j60wk/Br26ha8U+ccq1J+q0GXnm+StqHSj2zYBPJ3BX4Jdskt+WuG+gs
 avVom71/Iu7yhejn/gHpc05SzP8w/aDOokkKUIwINRysF8DOCEGxNhaFDck6o6IfMfUf
 Jrqa/Zp3dm98KMAUiyYvl88Ei96Lt+C0pUXvvpPyKgsqBRP150WsecjwMEa29KAQ5Lpi
 g/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754683103; x=1755287903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JlkTztSTwTY91xR8YRYmn/soHcjh2hdDrlkZxKsl7cg=;
 b=w1HvxjVYGrtuN+abXAHsoYp4f9DlOrDoJSKC6H9v8fspp93CKjS11UGtvFOcVXXN1C
 1HjCHNp8Odr9uFOv7Bhy2sp1q8Ze1LOKVw1OSKHx7X3Fjiq883cmY2xDWt7HvGqMYEr1
 N1+TdF3nB+k93QGvjfXgM3hyGt9eaeQa0s/tAz7gkfdhAZJWuEcQDpOnUqKnmiKyXuyG
 b7SASfP13wA5zVDrm8AA9B1wh8W0ZA3PzhqNqQb+BvvhmF7SC73JU0wdE9rtKlpDINOj
 TTwqpnvby11pqzmY72C8ldVl40utiqNlvxejlTLK8LinVJPuM6L6iZVwObUcU1cY2zQy
 wFsQ==
X-Gm-Message-State: AOJu0YwSS4kCBsdxpO7p01RB47RynW5got/7r+AlYultGjtBVC1y4eQh
 S5/UMy8S3Dv/Cg+d0wJepYZ3rHpKJPxzT70t0iTSCXl8iY5Q88AFdVPZ/O8d+DkJI7+0+TMbr5h
 lIv2shLlFmcOF7Nqa0GmlVXzh6ypj3S2tKA==
X-Gm-Gg: ASbGnct5uklCMdhYLmIRQ77KHAMpDMQuGCGaQf6uluDqRC12C5Kia9X/trKZJjZRNO0
 /ZTgJGkc4R339vZyuhIwy9tL7B+Mg4L7QaWNvZsF2szB/Je+VExjzNhMSckJFOlCJwPAei50+xl
 6iVMcKWVndnxXk+Wb6h0Wl9maG37ifrplqFIjQayeDMCy/tB5GOcbkCLtD6+DRbX0n7SN1/Ko5F
 GY8i+c=
X-Google-Smtp-Source: AGHT+IHeDS4Ta9jD0ejbkuUwCVPijcR76eJmf1+TpjlVTq5mr5DiSH0TN2ERdnOvwuV4AyBGe1UjhA2xiYkeqhpRjz4=
X-Received: by 2002:a17:902:ea01:b0:240:764e:afab with SMTP id
 d9443c01a7336-242d38c1355mr1328925ad.6.1754683102509; Fri, 08 Aug 2025
 12:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250806022816.1050823-1-Jesse.Zhang@amd.com>
 <20250806022816.1050823-11-Jesse.Zhang@amd.com>
In-Reply-To: <20250806022816.1050823-11-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Aug 2025 15:58:11 -0400
X-Gm-Features: Ac12FXyQisyamco6kzUBMgI0KtAUo0XpYg6y0CqWKqxd4TeYDbwGCEfy8eh_Vak
Message-ID: <CADnq5_NC1tauC-Yveggb=7AoNSg8iogkOcQOAzF0vvu=JabFfg@mail.gmail.com>
Subject: Re: [v7 11/11] drm/amdgpu: Implement user queue reset handling and
 recovery
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

On Tue, Aug 5, 2025 at 10:29=E2=80=AFPM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> This patch introduces queue reset and GPU reset support for userq.
> It adds detection and recovery logic for gfx, compute, and SDMA queues wh=
en errors occur during queue operations (e.g., map/unmap failures).
> This enhances user queue resiliency and ensures graceful recovery in case=
 of individual queue failure without immediately requiring full GPU reset.
>

I'd split this patch into two patches:
1. switch over to using preempt/restore for cases where it is
applicable.  We still need map/unmap for initial userq setup and
removal and for system suspend.
2. implement reset

Alex

> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 202 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
>  4 files changed, 201 insertions(+), 15 deletions(-)
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
> index 1496544cd1c2..edec881e6fa5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -25,8 +25,9 @@
>  #include <drm/drm_auth.h>
>  #include <drm/drm_exec.h>
>  #include <linux/pm_runtime.h>
> -
> +#include <drm/drm_drv.h>
>  #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>  #include "amdgpu_vm.h"
>  #include "amdgpu_userq.h"
>  #include "amdgpu_userq_fence.h"
> @@ -44,6 +45,88 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_d=
evice *adev)
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
> +amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
> +{
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
>                           struct amdgpu_usermode_queue *queue)
> @@ -99,15 +182,23 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *u=
q_mgr,
>         struct amdgpu_device *adev =3D uq_mgr->adev;
>         const struct amdgpu_userq_funcs *userq_funcs =3D
>                 adev->userq_funcs[queue->queue_type];
> +       bool gpu_reset =3D false;
>         int r =3D 0;
>
> -       if (queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED) {
> +       if ((queue->state =3D=3D AMDGPU_USERQ_STATE_MAPPED)  ||
> +                       (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED=
)) {
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
> @@ -118,16 +209,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq=
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
> @@ -366,6 +463,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue=
_id)
>                 amdgpu_bo_unreserve(queue->db_obj.obj);
>         }
>         amdgpu_bo_unref(&queue->db_obj.obj);
> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>         amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
>         mutex_unlock(&uq_mgr->userq_mutex);
> @@ -584,7 +682,7 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_=
mgr)
>
>         /* Resume all the queues for this process */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -               r =3D amdgpu_userq_map_helper(uq_mgr, queue);
> +               r =3D amdgpu_userqueue_restore_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
>         }
> @@ -741,7 +839,7 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mg=
r)
>
>         /* Try to unmap all the queues in this process ctx */
>         idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
> -               r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
> +               r =3D amdgpu_userqueue_preempt_helper(uq_mgr, queue);
>                 if (r)
>                         ret =3D r;
>         }
> @@ -751,6 +849,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_m=
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
> @@ -777,22 +892,19 @@ void
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
> @@ -833,6 +945,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *u=
serq_mgr)
>
>         mutex_lock(&adev->userq_mutex);
>         mutex_lock(&userq_mgr->userq_mutex);
> +       amdgpu_userq_detect_and_reset_queues(userq_mgr);
>         idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
>                 amdgpu_userq_wait_for_last_fence(userq_mgr, queue);
>                 amdgpu_userq_unmap_helper(userq_mgr, queue);
> @@ -866,6 +979,7 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 cancel_delayed_work_sync(&uqm->resume_work);
>                 mutex_lock(&uqm->userq_mutex);
> +               amdgpu_userq_detect_and_reset_queues(uqm);
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
>                         r =3D amdgpu_userq_unmap_helper(uqm, queue);
>                         if (r)
> @@ -922,6 +1036,7 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(st=
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
> @@ -970,3 +1085,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation(=
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
