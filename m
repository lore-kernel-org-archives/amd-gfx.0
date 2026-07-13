Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D20C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 20:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7196210E66F;
	Mon, 13 Jul 2026 20:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rjF3ueUi";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D999510E66F
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 20:41:51 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cc827a68fbso10065035ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:41:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783975311; cv=none;
 d=google.com; s=arc-20260327;
 b=hTrURiB3SFNfOpGEBWSAQHcvdAecLDoJS2ZDrRK7gLIQKa1v5NxDAZUFzCmtOanT1k
 wO2/IajlLqoPkGxRxhyDeA+yv/iQ6b5yrHDE+IWf+29U02tBEgdJlTdHg4wPXpl/robe
 yi854P9kzbUOIdhlVMk299kxR5+4JnhVZPM5wveXWgf2BsJaf/4xYkhQbfjv0NnTbNuj
 3ssShUtXnV2DwQU3NyglQJV75dGve2gJMPbLUv6qVcnlEei+NMMjQ915R2ZJjOAHSL2G
 j+92cZlnMPNUWD4jwbQ81OveKaYRpFh/V2MnNND4I+afqz73Kp2EfDps4TKVCVaVd4xg
 ngHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X/2Oz+vY6Y9GLyLwn1tm7UFnVaE3q7fwrCmDwsJ9BHs=;
 fh=B7D8GAEew+UQwSkeDeHaXAlufCJk2JBHakIvmBDw7hU=;
 b=mSq74a2yTW/D/6m0+HH9k/iot7Ka5Ld+5TGxu8uMlXko7G5JGutQLWeVcAIF8lm6pK
 7NI/HG2MarCHSAmh9Rt44A5zuHj038T1TYPzhLZ5X9neV8S8oiAa3Cvd4VagKleXu4SH
 xOLe2PfNr9zbUwBw5XC0Q1KSH6ZV2U6PpwZ0tyccRac3q+jN5Yh58XJU1jMO00ACSow/
 d/DR5pJfYuQYqBH0m1Buvf+1XlPPi1Axu06n9WUwXUuoGHV1+jnVu/nUhg0eQWa+NgHk
 XKynl0CAkGuZCRlpqN062zIy+G+Q+C6rwXCdDzs+uzRAecmg1e4zcIdfQDJ2gtO86mpZ
 FESQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783975311; x=1784580111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X/2Oz+vY6Y9GLyLwn1tm7UFnVaE3q7fwrCmDwsJ9BHs=;
 b=rjF3ueUiUXinPWItK44xNcHj+LwAxJNZjYNF5HGG+kU+a0Lce6PEgnZNRlBtStq08Z
 g3NBvVLmI6my7JgITyYiEepNkuLPxWaH08hmcXVchsIMw859zkxfnrkb8r7tne/l7akH
 iBZZfY+lCBfiNQc5MigaCr1eSHXpbXfd5/kwra5p2AwlDAuuwpUZRs4W85Ulh1T4TTl5
 Il9Ij+sLICWoPcFbHvSjBYNh+tV1mGKGOnSTWkAmRgrvFMO4p66vdbllpdSyCKVhjU8d
 OUCU5u8hnQtWj5pZ/J1tRY0nCmlqamgLxu/Kq/AIClsl2UJVlJvVr4py3u4QJxF+KH3s
 WvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783975311; x=1784580111;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X/2Oz+vY6Y9GLyLwn1tm7UFnVaE3q7fwrCmDwsJ9BHs=;
 b=TmcGZnXaChobIAk0w3SNJxjyzV/WI7YlZyEX9Ke9HrhPNsTE7bgzLHsuT/pIzv+3F/
 JVU7tilISZdHSJuZbO1WqSvCzr7W5W/iTKUs3W+JKVulZwBzBgbJ00TuZ4CvnqT0WWME
 YBdCzU9OZZdjH70tNKV5XnB4i2PXObvZEp+rd158VLc6ralBAkQal6KVS3IWqOabHjzw
 psHKnndDIQ8do/8af9kNhZBY2TYayEDWvDhGKJkMmEQqeRw95ZGSvyBMpv0sCBOuI7UT
 pr1oWvWk+kn/9E1z1x3FyUNj29tpCwEQFkWyD04E1Wj3JdqDQ03akViQ+Y/6iNqzSC5u
 Q/NQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/O3pGUuMG2FYi11n4ymg0DTSbMMODqSjweQQ33uMmvexsH081wsqAQzZMbKTLYHOmvTLGUf6q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwoclGMbaRfokPqL8dOafBt49GcI/RKO3VoPWSUq+lZqKRzan+g
 Qv9nwVvDx8LoFxQtPnEs3Nl+lUhTyKCG0HEbityQfzbe5Woud3spIjEgv52c+lwA6DNcsyABXYF
 ST2fhaXD1Jnp10krsFQSryHbumjKfF2h4T12L
X-Gm-Gg: AfdE7cl1Fz7X3mVPd0RWjcGtLb0Gnn7055nF08mqsKAInVBAW6XNA1atfABz/8tw3pp
 2EDhjHISeBJNiTAkB1zUr4HB+5wUgbi45Ls6PXxcseTKD1xv2hiNBx1wF/pGCfK5n8FpRmLVuaR
 u7ApmjIsHPaAKY0EtLA9htxO+yhEna9uFH7x+TbACABdLO56+M23QzsiKjAUyYGcR+GEpKNm95R
 dEc7wIqmexYJHdBuPbIO+alZL/3PQ6H76yCIpP5eqaJY0oVZjpAhoXBeg7uQ5zt0m6f3U6Xs1WE
 BM4z1TSu8zYLai5Q+d5+pL1BhTSmhNHqOd1IhH1jDwLiRhFalni+185gDEE=
X-Received: by 2002:a17:902:c40f:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2ce9e59ee7cmr91979405ad.2.1783975311310; Mon, 13 Jul 2026
 13:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260713162722.3349626-1-srinivasan.shanmugam@amd.com>
 <20260713162722.3349626-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260713162722.3349626-3-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 16:41:39 -0400
X-Gm-Features: AVVi8CfBMA97lHIoTublE6_d5RerLDh0Y2W5EROXcYTbxZ-6b4ZuQALWLnXjrl4
Message-ID: <CADnq5_MfY5i=QJFTfNs9g7iHnpofvd4K7Rt_orbws6z6E5Pfnw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/amdgpu: Signal QUEUE_RESET EVENTFD
 notifications
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Jul 13, 2026 at 12:34=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Signal QUEUE_RESET EVENTFD subscriptions when hung user queues are
> detected.
>
> MES reports the doorbell indices of hung queues. Use the existing
> doorbell-to-queue mapping to find the affected queue and notify matching
> EVENTFD subscribers.
>
> Move the queue reset handling into amdgpu_userq.c so the queue lookup
> and queue handling are performed in one place. This avoids scanning all
> queues to find a matching doorbell.
>
> EVENTFD remains notification-only.
>
> v2: (per Christian)
>  - Use the doorbell xarray to look up affected queues instead of scanning
>    all queues.
>  - Move queue reset handling into amdgpu_userq.c.
>  - Consolidate queue state updates, EVENTFD signaling, and fence
>    completion in a single helper.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 33 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |  3 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 73 ++++++++++++++--------
>  3 files changed, 83 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index ab3ef3a9f655..5bf231d7a630 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -242,7 +242,40 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_de=
vice *adev, u32 doorbell)
>         xa_unlock_irqrestore(xa, flags);
>  }
>
> +/**
> + * amdgpu_userq_handle_hung_queue - handle a successfully reset hung que=
ue
> + * @adev: AMDGPU device
> + * @queue: affected user queue
> + *
> + * Mark the queue as hung, notify matching QUEUE_RESET EVENTFD
> + * subscribers, force-complete its fences, and send the DRM wedged event=
.
> + *
> + * Return:
> + * true when the queue was handled, false for an invalid queue.
> + */
> +bool
> +amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
> +                              struct amdgpu_usermode_queue *queue)
> +{
> +       struct amdgpu_eventfd_mgr *eventfd_mgr;
>
> +       if (!queue)
> +               return false;
> +
> +       queue->state =3D AMDGPU_USERQ_STATE_HUNG;
> +
> +       eventfd_mgr =3D amdgpu_userq_eventfd_mgr(queue->userq_mgr);
> +       amdgpu_eventfd_signal(eventfd_mgr,
> +                             DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
> +                             queue);
> +
> +       amdgpu_userq_fence_driver_force_completion(queue);
> +
> +       drm_dev_wedged_event(adev_to_drm(adev),
> +                            DRM_WEDGE_RECOVERY_NONE, NULL);
> +
> +       return true;
> +}
>
>  int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>                                    struct amdgpu_usermode_queue *queue,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index b69621311b80..187bfd66eb13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -180,7 +180,8 @@ void amdgpu_userq_pre_reset(struct amdgpu_device *ade=
v);
>  int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
>  void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *q=
ueue);
>  void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 door=
bell);
> -
> +bool amdgpu_userq_handle_hung_queue(struct amdgpu_device *adev,
> +                                   struct amdgpu_usermode_queue *queue);
>  /*
>   * CP packs the per-process doorbell_id of the queue in
>   * CTXID0[9:0] on priv-fault (same encoding KFD uses via
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 3fad95199e0c..4b546613c024 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -26,6 +26,7 @@
>  #include "amdgpu_gfx.h"
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_userq_internal.h"
>  #include "amdgpu_cwsr.h"
>
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
> @@ -238,34 +239,56 @@ int mes_userq_reset_queue(struct amdgpu_device *ade=
v,

mes_userq_reset_queue() is only called for collateral damage on
compute queues.  You also need to handle this in
amdgpu_userq_hang_detect_work() for the original guilty queue.  I
think we also need this patch:
https://patchwork.freedesktop.org/patch/739898/?series=3D170347&rev=3D1

Alex

>                           unsigned int queue,
>                           unsigned int db)
>  {
> +       struct xarray *xa =3D &adev->userq_doorbell_xa;
>         struct amdgpu_usermode_queue *uq;
>         bool use_mmio =3D adev->gfx.mec.use_mmio_for_reset;
> -       unsigned long uq_id;
> -       int r;
> +       unsigned long flags;
> +       int r =3D 0;
>
> -       xa_for_each(&adev->userq_doorbell_xa, uq_id, uq) {
> -               if (uq->queue_type =3D=3D queue_type) {
> -                       if (uq =3D=3D guilty_uq)
> -                               continue;
> -                       if (uq->doorbell_index =3D=3D db) {
> -                               uq->state =3D AMDGPU_USERQ_STATE_HUNG;
> -                               if (use_mmio)
> -                                       r =3D amdgpu_mes_reset_queue_mmio=
(adev, queue_type, 0, 1, pipe, queue, 0);
> -                               else
> -                                       r =3D amdgpu_mes_reset_user_queue=
(adev, queue_type, db, 0);
> -                               if (r)
> -                                       return r;
> -                               r =3D mes_userq_unmap(uq);
> -                               if (r)
> -                                       return r;
> -                               atomic_inc(&adev->gpu_reset_counter);
> -                               amdgpu_userq_fence_driver_force_completio=
n(uq);
> -                               drm_dev_wedged_event(adev_to_drm(adev), D=
RM_WEDGE_RECOVERY_NONE, NULL);
> -                               break;
> -                       }
> -               }
> -       }
> -       return 0;
> +       /*
> +        * Resolve the doorbell directly to the affected queue instead of
> +        * scanning all user queues.
> +        */
> +       xa_lock_irqsave(xa, flags);
> +
> +       uq =3D xa_load(xa, db);
> +       if (uq)
> +               kref_get(&uq->refcount);
> +
> +       xa_unlock_irqrestore(xa, flags);
> +
> +       if (!uq)
> +               return 0;
> +
> +       /*
> +        * The guilty queue is handled separately by the caller.
> +        */
> +       if (uq =3D=3D guilty_uq)
> +               goto out_put_queue;
> +
> +       if (uq->queue_type !=3D queue_type)
> +               goto out_put_queue;
> +
> +       if (use_mmio)
> +               r =3D amdgpu_mes_reset_queue_mmio(adev, queue_type,
> +                                               0, 1, pipe, queue, 0);
> +       else
> +               r =3D amdgpu_mes_reset_user_queue(adev, queue_type, db, 0=
);
> +
> +       if (r)
> +               goto out_put_queue;
> +
> +       r =3D mes_userq_unmap(uq);
> +       if (r)
> +               goto out_put_queue;
> +
> +       if (amdgpu_userq_handle_hung_queue(adev, uq))
> +               atomic_inc(&adev->gpu_reset_counter);
> +
> +out_put_queue:
> +       amdgpu_userq_put(uq);
> +
> +       return r;
>  }
>
>  static int mes_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
> --
> 2.34.1
>
