Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE4FC02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 19:49:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7604E10E28E;
	Wed, 12 Feb 2025 19:49:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lXCjkhfP";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAB1710E28E
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 19:49:44 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-220c895af63so164905ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 11:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739389784; x=1739994584; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skUkF9PcHjQ1RdS/KHxIPEVeLdguCMg5VVPnz7o4r4g=;
 b=lXCjkhfPluzePXeslRx1wSIdbTnGctNNswJL7qolh9wJvOuwjzMuvwx5Fx7KwDZru6
 VIHVzpMy17z9jeDoceGP+9YfDLIbXAhyK87bwyW9l8CQQdmQxuNaxQ+h643biqena318
 uQUFXgaePilBH3E38p5vFMnpnM78Derede/f7jqCeq8y/hwAYPV8ud14JvrO9Le8ulYT
 LChqjr2RgMnvJLLF0hLPVezgnDB0QMFlxG3LRbWbYuYoyG8/Po2r5ctLgMJHR69nFBPZ
 lG9ViSPW3FQ25oLNU0A0lANHUCUnpDeuuyDl4WCob5LQ7uAkpzuNSghL0rPspHNNF8j0
 mg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739389784; x=1739994584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=skUkF9PcHjQ1RdS/KHxIPEVeLdguCMg5VVPnz7o4r4g=;
 b=BPJ1wJDerzwSj/ESCye3DgjuYX1Z6CqYzICwh6wns5joNqlF3KZQ9sbt9ZxBvxC9xw
 U0B19Fnwo59F7wl8Tu+mALVv/8npSb37xkwoZN3nv55ZuO4E2XK0sZkkvrD+r0F2DPru
 2V+LSbvD/QEqPeyBL4EuuMJSj4Vb/bNNi6LhxNr00PJ5+S96e2Ts3N+jkLqHN/pYlPvX
 xNg9uMJswnVuOOrsn4h0nFvJUIwFZGErGu3MPRoc2s6r5qQVO81472yA7QYN2u2sDxIu
 9zGKCj9HaCJh+I8dNGlOHt5Ext8lA8Kc1CNmHMN+iR1QU7rHFUyTCk/08f4MLJy0N8X+
 u4Zw==
X-Gm-Message-State: AOJu0Yzi+0ciqo+S/nTh3i6gzxRAp/bMyjVZa0uH7JgS3tH35249A34Z
 /N5MvRZD3eGHxD8+yvdeAUfcbQxGkTGjxkeIS71jLTrSkpGl6KNQzh3o5uoNfjmSSFO9uiblDxx
 V6MFAoQXeW//G8WYaDoEeOglWD5gU7w==
X-Gm-Gg: ASbGncsRA5ODJ5D33mUKRb/AaMTGN7h1HH2bB4uZY8SOnkkFnSI0PLzm7HNXwhQsqnE
 gaiNvDjZI82ypIiKmQHIjeYOBfVz8qpBHNPL+kAB0A8+DRxKctkUvslOzNCrfO8W4N740xz04
X-Google-Smtp-Source: AGHT+IG0JZJhDFJ1L+avh7sPcSOdYCXhMkvG5Debx5lzZrOVHC09zSdpCBuKCIPeHf+/o0UAa1KmIITAHv9DhdnNCyA=
X-Received: by 2002:a17:902:ea02:b0:215:3862:603a with SMTP id
 d9443c01a7336-220bbb465f2mr29067135ad.10.1739389784128; Wed, 12 Feb 2025
 11:49:44 -0800 (PST)
MIME-Version: 1.0
References: <20250211051454.2811943-1-jesse.zhang@amd.com>
 <20250211051454.2811943-3-jesse.zhang@amd.com>
In-Reply-To: <20250211051454.2811943-3-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Feb 2025 14:49:32 -0500
X-Gm-Features: AWEUYZnWv-phvQOgVa7JNGi6iM3FkxtlVySYh7AtpI99YK8qnfYzpwNRsAhsTBI
Message-ID: <CADnq5_Pgfcb-qB=Jij=a-Yc+sgC+-bq6D1ugpKiLEa9YpEoOvg@mail.gmail.com>
Subject: Re: [PATCH 3/4 v6] drm/amdgpu: Add common lock and reset caller
 parameter for SDMA reset synchronization
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 felix.kuehling@amd.com, Jonathan Kim <Jonathan.Kim@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>
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

On Tue, Feb 11, 2025 at 12:22=E2=80=AFAM Jesse.zhang@amd.com
<jesse.zhang@amd.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This commit introduces a caller parameter to the amdgpu_sdma_reset_instan=
ce function to differentiate
> between reset requests originating from the KGD and KFD.
> This change ensures proper synchronization between KGD and KFD during SDM=
A resets.
>
> If the caller is KFD, the function now acquires and releases the schedule=
r lock (ring->sched.job_list_lock)
> to protect the SDMA queue during the reset.
>
> These changes prevent race conditions and ensure safe SDMA reset operatio=
ns
> when initiated by KFD, improving system stability and reliability.
>
> V2: replace the ring_lock with the existed the scheduler
>     locks for the queues (ring->sched) on the sdma engine.(Alex)
>
> v3: call drm_sched_wqueue_stop() rather than job_list_lock.
>     If a GPU ring reset was already initiated for one ring at amdgpu_job_=
timedout,
>     skip resetting that ring and call drm_sched_wqueue_stop()
>     for the other rings (Alex)
>
>    replace  the common lock (sdma_reset_lock) with DQM lock to
>    to resolve reset races between the two driver sections during KFD evic=
tion.(Jon)
>
>    Rename the caller to Reset_src and
>    Change AMDGPU_RESET_SRC_SDMA_KGD/KFD to AMDGPU_RESET_SRC_SDMA_HWS/RING=
 (Jon)
> v4: restart the wqueue if the reset was successful,
>     or fall back to a full adapter reset. (Alex)
>
>    move definition of reset source to enumeration AMDGPU_RESET_SRCS, and
>    check reset src in amdgpu_sdma_reset_instance (Jon)
>
> v5: Call amdgpu_amdkfd_suspend/resume at the start/end of reset function =
respectively under !SRC_HWS
>     conditions only (Jon)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Suggested-by: Jonathan Kim <Jonathan.Kim@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c  | 65 ++++++++++++++++++++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h  |  6 +--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c  |  8 +--
>  4 files changed, 67 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.h
> index 4d9b9701139b..5b86e12ff9fe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -43,6 +43,8 @@ enum AMDGPU_RESET_SRCS {
>         AMDGPU_RESET_SRC_MES,
>         AMDGPU_RESET_SRC_HWS,
>         AMDGPU_RESET_SRC_USER,
> +       AMDGPU_RESET_SRC_SDMA_RING,
> +       AMDGPU_RESET_SRC_SDMA_HWS,
>  };
>
>  struct amdgpu_reset_context {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 19c8be7d72e2..32eebf9d4408 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -25,6 +25,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_sdma.h"
>  #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>
>  #define AMDGPU_CSA_SDMA_SIZE 64
>  /* SDMA CSA reside in the 3rd page of CSA */
> @@ -484,6 +485,7 @@ void amdgpu_sdma_register_on_reset_callbacks(struct a=
mdgpu_device *adev, struct
>   * amdgpu_sdma_reset_instance - Reset a specific SDMA instance
>   * @adev: Pointer to the AMDGPU device
>   * @instance_id: ID of the SDMA engine instance to reset
> + * @src: The source of reset function (KGD or KFD)
>   *
>   * This function performs the following steps:
>   * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU t=
o save their state.
> @@ -492,20 +494,49 @@ void amdgpu_sdma_register_on_reset_callbacks(struct=
 amdgpu_device *adev, struct
>   *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
> -int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t inst=
ance_id)
> +int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t inst=
ance_id, int src)
>  {
>         struct sdma_on_reset_funcs *funcs;
> -       int ret;
> +       int ret =3D 0;
> +       struct amdgpu_sdma_instance *sdma_instance =3D &adev->sdma.instan=
ce[instance_id];;
> +       struct amdgpu_ring *gfx_ring =3D &sdma_instance->ring;
> +       struct amdgpu_ring *page_ring =3D &sdma_instance->page;
> +       bool gfx_sched_stopped =3D false, page_sched_stopped =3D false;
> +
> +       /* Check if the reset source is valid for SDMA ring reset */
> +       if (src !=3D AMDGPU_RESET_SRC_SDMA_RING && src !=3D AMDGPU_RESET_=
SRC_HWS)
> +               return -EINVAL;
> +
> +       /* Suspend KFD if the reset source is not SDMA_HWS.
> +        * prevent the destruction of in-flight healthy user queue packet=
s and
> +         * avoid race conditions between KFD and KGD during the reset pr=
ocess.
> +         */
> +       if (src !=3D AMDGPU_RESET_SRC_SDMA_HWS)
> +               amdgpu_amdkfd_suspend(adev, false);
> +
> +       /* Stop the scheduler's work queue for the GFX and page rings if =
they are running.
> +       * This ensures that no new tasks are submitted to the queues whil=
e
> +       * the reset is in progress.
> +       */
> +       if (!amdgpu_ring_sched_ready(gfx_ring)) {
> +               drm_sched_wqueue_stop(&gfx_ring->sched);
> +               gfx_sched_stopped =3D true;;
> +       }
> +
> +       if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ri=
ng)) {
> +               drm_sched_wqueue_stop(&page_ring->sched);
> +               page_sched_stopped =3D true;
> +       }
>
>         /* Invoke all registered pre_reset callbacks */
>         list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list)=
 {
>                 if (funcs->pre_reset) {
> -                       ret =3D funcs->pre_reset(adev, instance_id);
> +                       ret =3D funcs->pre_reset(adev, instance_id, src);
>                         if (ret) {
>                                 dev_err(adev->dev,
>                                 "beforeReset callback failed for instance=
 %u: %d\n",
>                                         instance_id, ret);
> -                               return ret;
> +                               goto exit;
>                         }
>                 }
>         }
> @@ -514,21 +545,39 @@ int amdgpu_sdma_reset_instance(struct amdgpu_device=
 *adev, uint32_t instance_id)
>         ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
>         if (ret) {
>                 dev_err(adev->dev, "Failed to reset SDMA instance %u\n", =
instance_id);
> -               return ret;
> +               goto exit;
>         }
>
>         /* Invoke all registered post_reset callbacks */
>         list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list)=
 {
>                 if (funcs->post_reset) {
> -                       ret =3D funcs->post_reset(adev, instance_id);
> +                       ret =3D funcs->post_reset(adev, instance_id, src)=
;
>                         if (ret) {
>                                 dev_err(adev->dev,
>                                 "afterReset callback failed for instance =
%u: %d\n",
>                                         instance_id, ret);
> -                               return ret;
> +                               goto exit;
>                         }
>                 }
>         }
>
> -       return 0;
> +exit:
> +       /* Restart the scheduler's work queue for the GFX and page rings
> +        * if they were stopped by this function. This allows new tasks
> +        * to be submitted to the queues after the reset is complete.
> +        */
> +       if (ret) {
> +               if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring=
)) {
> +                       drm_sched_wqueue_start(&gfx_ring->sched);
> +               }
> +               if (page_sched_stopped && amdgpu_ring_sched_ready(page_ri=
ng)) {
> +                       drm_sched_wqueue_start(&page_ring->sched);
> +               }
> +       }
> +
> +       /* Resume KFD if the reset source is not SDMA_HWS */
> +       if (src !=3D AMDGPU_RESET_SRC_SDMA_HWS)
> +               amdgpu_amdkfd_resume(adev, false);
> +
> +       return ret;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index fbb8b04ef2cb..df5c9f7a4374 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -99,8 +99,8 @@ struct amdgpu_sdma_ras {
>  };
>
>  struct sdma_on_reset_funcs {
> -       int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id=
);
> -       int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_i=
d);
> +       int (*pre_reset)(struct amdgpu_device *adev, uint32_t instance_id=
, int src);
> +       int (*post_reset)(struct amdgpu_device *adev, uint32_t instance_i=
d, int src);
>         /* Linked list node to store this structure in a list; */
>         struct list_head list;
>  };
> @@ -166,7 +166,7 @@ struct amdgpu_buffer_funcs {
>  };
>
>  void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev,=
 struct sdma_on_reset_funcs *funcs);
> -int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t inst=
ance_id);
> +int amdgpu_sdma_reset_instance(struct amdgpu_device *adev, uint32_t inst=
ance_id, int src);
>
>  #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffe=
r_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
>  #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_f=
uncs->emit_fill_buffer((ib), (s), (d), (b))
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 3e60456b0db0..c297b4a13680 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -30,6 +30,7 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_ucode.h"
>  #include "amdgpu_trace.h"
> +#include "amdgpu_reset.h"
>
>  #include "sdma/sdma_4_4_2_offset.h"
>  #include "sdma/sdma_4_4_2_sh_mask.h"
> @@ -1480,6 +1481,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         if (r)
>                 return r;
>         INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
> +
>         return r;
>  }
>
> @@ -1608,10 +1610,10 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_=
ring *ring, unsigned int vmid)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
>         u32 id =3D GET_INST(SDMA0, ring->me);
> -       return amdgpu_sdma_reset_instance(adev, id);
> +       return amdgpu_sdma_reset_instance(adev, id, AMDGPU_RESET_SRC_SDMA=
_RING);
>  }
>
> -static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t i=
nstance_id)
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t i=
nstance_id, int src)
>  {
>         u32 inst_mask;
>         struct amdgpu_ring *ring =3D &adev->sdma.instance[instance_id].ri=
ng;
> @@ -1628,7 +1630,7 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_dev=
ice *adev, uint32_t instance_
>         return 0;
>  }
>
> -static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_=
t instance_id)
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_=
t instance_id, int src)
>  {
>         int i;
>         u32 inst_mask;
> --
> 2.25.1
>
