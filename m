Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41A4C021A0
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 19:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7209D10E97B;
	Wed, 12 Feb 2025 19:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NqVph9Xk";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AE5210E97B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 19:58:11 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2f45526dea0so34877a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 11:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739390291; x=1739995091; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NC6Oxa8gE2b2A7wsIrnpNog5pq0tpYdv14R7m6detcs=;
 b=NqVph9XkP3EsfTVg1RJC7ZbS0/z7H2j1uguhoPjTA4IPAjtd2QUASgEnELGtj+/QK1
 6RA9ZJq46hREZfbLDSgdlwbDQYqjemvmCtBc/fSYfdg4e/5+zncryV/skDgZr/pCwpGA
 fX6B9+gD8Br3etIIMTq78wloCAlE6R23fGXbWDGMGufZhnrW6GRZ8S5n0YV9qOJIrtRj
 PH05h60JvSpbQIGg5O5qZ/Nr2la6uox6qDBN7Cl7fuin/ralt0L/+1QKy5kaHN2HYQkZ
 JXf1LdGEWqFXsH6jGKemMsdgrUPmhYYZRfTejej9UhRFRjo2lABk4NPco3EDiZCErQMF
 iUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739390291; x=1739995091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NC6Oxa8gE2b2A7wsIrnpNog5pq0tpYdv14R7m6detcs=;
 b=WdaqYMlwOndPfgw1bq0OVox8B5FJotLEeZWvp37Pew0eL7xbhZfPqrYZsqcBXv+ZJw
 mz2RrIUJTkS1FlaDR3m99YI12fDoHNeA0kyXsHHDdf3ssZUI0DdtwZCVihtBqWUXgpgW
 6SnR/jnqUiAouiAThKdNi3bq0LuqGBQ9wjdRZl8rN/EX5KKdYhmUiIK8WNPbbNc+SbCC
 obFZe+sU/onLnuiWOShfTtuUXQSBYiMb5E5Hd5rDIksn1iA2s53UytJQw0bhWrZJbrC1
 jbmdfilhrGPk8fTG+vKiqUyTNt0vD4uvKdZaDNH9dPXht0fAujohWbWNcTi8shGP80JO
 sbIw==
X-Gm-Message-State: AOJu0YyQUMQi2HQTnc/NNsAKdAGgTQzzipRsO7ldcjnTKnhXuXhpPOg7
 t040E2mEpPivNYS/YBRcazDXNmpKz1ZFB1yVT0/dmdzO5uoEwsa8F/nGZV43ShcBkRiwAVG+xnk
 6YRMuj1YphMIW+YWrvM9mIO9mZa4ibw==
X-Gm-Gg: ASbGncvFryC4xkUFQuUwvBwK06ABZVkgN5v6aYXIpe6z0o9jHLSwkjaEbvwG6sc7dvB
 Y+c+j29YXEJZPFu448AaI3FhqrKywdpOk1oLUWCyhy47HbA+dFtazp2MsGdgwCRBwcRKuGv9E
X-Google-Smtp-Source: AGHT+IEFB+dQ9mWjN+fe8vQ56wlR0SuuvNiCNyDIP+uBn3Fal9Ab8zZZaH3rQumH46cyReWwDBk9k1i5oeUK67VedBo=
X-Received: by 2002:a17:90b:3b48:b0:2ee:b665:12ce with SMTP id
 98e67ed59e1d1-2fbf5bb8f30mr2736128a91.1.1739390290606; Wed, 12 Feb 2025
 11:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20250211051454.2811943-1-jesse.zhang@amd.com>
 <20250211051454.2811943-4-jesse.zhang@amd.com>
In-Reply-To: <20250211051454.2811943-4-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Feb 2025 14:57:58 -0500
X-Gm-Features: AWEUYZlgPj5RiLg-LlBzcOYQotteTB9y4Cm-0-2kHUE2UxLumPYQFOSVAzczc9c
Message-ID: <CADnq5_PLx1KTZmUs5eUmxob7Md9o+jZ5Re+f9w+FUndH7WWcAA@mail.gmail.com>
Subject: Re: [PATCH 4/4 V6] drm/amdgpu: Improve SDMA reset logic with guilty
 queue tracking
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

On Tue, Feb 11, 2025 at 9:42=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This commit introduces several improvements to the SDMA reset logic:
>
> 1. Added `cached_rptr` to the `amdgpu_ring` structure to store the read p=
ointer
>    before a reset, ensuring proper state restoration after reset.
>
> 2. Introduced `gfx_guilty` and `page_guilty` flags in the `amdgpu_sdma` s=
tructure
>    to track which queue (GFX or PAGE) caused a timeout or error.
>
> 3. Replaced the `caller` parameter with a `guilty` boolean in the reset a=
nd resume
>    functions to simplify the logic and handle resets based on the guilty =
state.
>
> 4. Added a helper function `sdma_v4_4_2_is_queue_selected` to check the
>    `SDMA*_*_CONTEXT_STATUS.SELECTED` register and determine if a queue is=
 guilty.
>
> v2:
>    1.replace the caller with a guilty bool.
>    If the queue is the guilty one, set the rptr and wptr  to the saved wp=
tr value,
>    else, set the rptr and wptr to the saved rptr value. (Alex)
>    2. cache the rptr before the reset. (Alex)
>
> v3: add a new ring callback, is_guilty(), which will get called to check =
if
>     the ring in amdgpu_job_timedout() is actually the guilty ring. If it'=
s not,
>     we can return goto exit(Alex)
>
> v4: cache the rptr for page ring
>
> v5: update the register addresses to correctly use the page ring register=
s
>       (regSDMA_PAGE_RB_RPTR) in page resume.
>
> v6: Keeping intermediate variables like u64 rwptr simplifies resotre rptr=
/wptr.(Lijo)
>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Suggested-by: Jiadong Zhu <Jiadong.Zhu@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 10 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 +
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 96 ++++++++++++++++++++----
>  6 files changed, 106 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 100f04475943..ce3e7a9d6688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -102,6 +102,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(s=
truct drm_sched_job *s_job)
>                 return DRM_GPU_SCHED_STAT_ENODEV;
>         }
>
> +       /* Check if the ring is actually guilty of causing the timeout.
> +        * If not, skip error handling and fence completion.
> +        */
> +       if (amdgpu_gpu_recovery && ring->funcs->is_guilty) {
> +               if (!ring->funcs->is_guilty(ring)) {
> +                       dev_err(adev->dev, "ring %s timeout, but not guil=
ty\n",
> +                               s_job->sched->name);
> +                       goto exit;
> +               }
> +       }

I'd suggest breaking this change and the amdgpu_ring.h change out into
its own patch.

>         /*
>          * Do the coredump immediately after a job timeout to get a very
>          * close dump/snapshot/representation of GPU's current error stat=
us
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.c
> index a6e28fe3f8d6..20cd21df38ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -342,6 +342,8 @@ int amdgpu_ring_init(struct amdgpu_device *adev, stru=
ct amdgpu_ring *ring,
>         ring->buf_mask =3D (ring->ring_size / 4) - 1;
>         ring->ptr_mask =3D ring->funcs->support_64bit_ptrs ?
>                 0xffffffffffffffff : ring->buf_mask;
> +       /*  Initialize cached_rptr to 0 */
> +       ring->cached_rptr =3D 0;
>
>         /* Allocate ring buffer */
>         if (ring->is_mes_queue) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ring.h
> index 04af26536f97..182aa535d395 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -237,6 +237,7 @@ struct amdgpu_ring_funcs {
>         void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
>         int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
>         void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
> +       bool (*is_guilty)(struct amdgpu_ring *ring);
>  };
>
>  struct amdgpu_ring {
> @@ -306,6 +307,8 @@ struct amdgpu_ring {
>
>         bool            is_sw_ring;
>         unsigned int    entry_index;
> +       /* store the cached rptr to restore after reset */
> +       uint64_t cached_rptr;
>
>  };
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 32eebf9d4408..6ba785798a4a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -474,6 +474,10 @@ void amdgpu_sdma_register_on_reset_callbacks(struct =
amdgpu_device *adev, struct
>         if (!funcs)
>                 return;
>
> +       /* Ensure the reset_callback_list is initialized */
> +       if (!adev->sdma.reset_callback_list.next) {
> +               INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
> +       }

I'd squash this change into the patch which adds the callback list.

>         /* Initialize the list node in the callback structure */
>         INIT_LIST_HEAD(&funcs->list);
>
> @@ -520,7 +524,7 @@ int amdgpu_sdma_reset_instance(struct amdgpu_device *=
adev, uint32_t instance_id,
>         */
>         if (!amdgpu_ring_sched_ready(gfx_ring)) {
>                 drm_sched_wqueue_stop(&gfx_ring->sched);
> -               gfx_sched_stopped =3D true;;
> +               gfx_sched_stopped =3D true;
>         }
>
>         if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ri=
ng)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index df5c9f7a4374..d84c3eccc510 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -126,6 +126,9 @@ struct amdgpu_sdma {
>         uint32_t                *ip_dump;
>         uint32_t                supported_reset;
>         struct list_head        reset_callback_list;
> +       /* track guilty state of GFX and PAGE queues */
> +       bool gfx_guilty;
> +       bool page_guilty;
>  };
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index c297b4a13680..2c66382011d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -671,11 +671,12 @@ static uint32_t sdma_v4_4_2_rb_cntl(struct amdgpu_r=
ing *ring, uint32_t rb_cntl)
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
>   * @restore: used to restore wptr when restart
> + * @guilty: boolean indicating whether this queue is the guilty one (cau=
sed the timeout/error)
>   *
>   * Set up the gfx DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned =
int i, bool restore)
> +static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned =
int i, bool restore, bool guilty)
>  {
>         struct amdgpu_ring *ring =3D &adev->sdma.instance[i].ring;
>         u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -683,6 +684,7 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_devi=
ce *adev, unsigned int i, b
>         u32 doorbell;
>         u32 doorbell_offset;
>         u64 wptr_gpu_addr;
> +       u64 rwptr;
>
>         wb_offset =3D (ring->rptr_offs * 4);
>
> @@ -708,12 +710,20 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_de=
vice *adev, unsigned int i, b
>         /* before programing wptr to a less value, need set minor_ptr_upd=
ate first */
>         WREG32_SDMA(i, regSDMA_GFX_MINOR_PTR_UPDATE, 1);
>
> +       /* For the guilty queue, set RPTR to the current wptr to skip bad=
 commands,
> +        * It is not a guilty queue, restore cache_rptr and continue exec=
ution.
> +         */
> +       if (guilty)
> +               rwptr =3D ring->wptr;
> +       else
> +               rwptr =3D ring->cached_rptr;
> +
>         /* Initialize the ring buffer's read and write pointers */
>         if (restore) {
> -               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->w=
ptr << 2));
> -               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring=
->wptr << 2));
> -               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->w=
ptr << 2));
> -               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring=
->wptr << 2));
> +               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(rwptr <=
< 2));
> +               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(rwpt=
r << 2));
> +               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(rwptr <=
< 2));
> +               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(rwpt=
r << 2));
>         } else {
>                 WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, 0);
>                 WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, 0);
> @@ -768,11 +778,12 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_de=
vice *adev, unsigned int i, b
>   * @adev: amdgpu_device pointer
>   * @i: instance to resume
>   * @restore: boolean to say restore needed or not
> + * @guilty: boolean indicating whether this queue is the guilty one (cau=
sed the timeout/error)
>   *
>   * Set up the page DMA ring buffers and enable them.
>   * Returns 0 for success, error for failure.
>   */
> -static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned=
 int i, bool restore)
> +static void sdma_v4_4_2_page_resume(struct amdgpu_device *adev, unsigned=
 int i, bool restore, bool guilty)
>  {
>         struct amdgpu_ring *ring =3D &adev->sdma.instance[i].page;
>         u32 rb_cntl, ib_cntl, wptr_poll_cntl;
> @@ -780,6 +791,7 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_dev=
ice *adev, unsigned int i,
>         u32 doorbell;
>         u32 doorbell_offset;
>         u64 wptr_gpu_addr;
> +       u64 rwptr;
>
>         wb_offset =3D (ring->rptr_offs * 4);
>
> @@ -787,12 +799,20 @@ static void sdma_v4_4_2_page_resume(struct amdgpu_d=
evice *adev, unsigned int i,
>         rb_cntl =3D sdma_v4_4_2_rb_cntl(ring, rb_cntl);
>         WREG32_SDMA(i, regSDMA_PAGE_RB_CNTL, rb_cntl);
>
> +       /* For the guilty queue, set RPTR to the current wptr to skip bad=
 commands,
> +        * It is not a guilty queue, restore cache_rptr and continue exec=
ution.
> +         */
> +       if (guilty)
> +               rwptr =3D ring->wptr;
> +       else
> +               rwptr =3D ring->cached_rptr;
> +
>         /* Initialize the ring buffer's read and write pointers */
>         if (restore) {
> -               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR, lower_32_bits(ring->w=
ptr << 2));
> -               WREG32_SDMA(i, regSDMA_GFX_RB_RPTR_HI, upper_32_bits(ring=
->wptr << 2));
> -               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR, lower_32_bits(ring->w=
ptr << 2));
> -               WREG32_SDMA(i, regSDMA_GFX_RB_WPTR_HI, upper_32_bits(ring=
->wptr << 2));
> +               WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, lower_32_bits(rwptr =
<< 2));
> +               WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, upper_32_bits(rwp=
tr << 2));
> +               WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR, lower_32_bits(rwptr =
<< 2));
> +               WREG32_SDMA(i, regSDMA_PAGE_RB_WPTR_HI, upper_32_bits(rwp=
tr << 2));
>         } else {
>                 WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR, 0);
>                 WREG32_SDMA(i, regSDMA_PAGE_RB_RPTR_HI, 0);
> @@ -968,9 +988,9 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_devic=
e *adev,
>                 uint32_t temp;
>
>                 WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
> -               sdma_v4_4_2_gfx_resume(adev, i, restore);
> +               sdma_v4_4_2_gfx_resume(adev, i, restore, adev->sdma.gfx_g=
uilty);
>                 if (adev->sdma.has_page_queue)
> -                       sdma_v4_4_2_page_resume(adev, i, restore);
> +                       sdma_v4_4_2_page_resume(adev, i, restore, adev->s=
dma.page_guilty);
>
>                 /* set utc l1 enable flag always to 1 */
>                 temp =3D RREG32_SDMA(i, regSDMA_CNTL);
> @@ -1480,7 +1500,9 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>         r =3D amdgpu_sdma_sysfs_reset_mask_init(adev);
>         if (r)
>                 return r;
> -       INIT_LIST_HEAD(&adev->sdma.reset_callback_list);
> +       /* Initialize guilty flags for GFX and PAGE queues */
> +       adev->sdma.gfx_guilty =3D false;
> +       adev->sdma.page_guilty =3D false;
>
>         return r;
>  }
> @@ -1606,6 +1628,34 @@ static int sdma_v4_4_2_soft_reset(struct amdgpu_ip=
_block *ip_block)
>         return 0;
>  }
>
> +static bool sdma_v4_4_2_is_queue_selected(struct amdgpu_device *adev, ui=
nt32_t instance_id, bool is_page_queue)
> +{
> +       uint32_t reg_offset =3D is_page_queue ? regSDMA_PAGE_CONTEXT_STAT=
US : regSDMA_GFX_CONTEXT_STATUS;
> +       uint32_t context_status =3D RREG32(sdma_v4_4_2_get_reg_offset(ade=
v, instance_id, reg_offset));
> +
> +       /* Check if the SELECTED bit is set */
> +       return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK) =
!=3D 0;
> +}
> +
> +static bool sdma_v4_4_2_gfx_ring_is_guilty(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       uint32_t instance_id =3D ring->me;
> +
> +       return sdma_v4_4_2_is_queue_selected(adev, instance_id, false);
> +}
> +
> +static bool sdma_v4_4_2_page_ring_is_guilty(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev =3D ring->adev;
> +       uint32_t instance_id =3D ring->me;
> +
> +       if (adev->sdma.has_page_queue)
> +               return false;
> +
> +       return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
> +}

Could also split this and the is_guilty callbacks out into a separate patch=
.

Alex


> +
>  static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigned in=
t vmid)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -1616,11 +1666,29 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_=
ring *ring, unsigned int vmid)
>  static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t i=
nstance_id, int src)
>  {
>         u32 inst_mask;
> +       uint64_t rptr;
>         struct amdgpu_ring *ring =3D &adev->sdma.instance[instance_id].ri=
ng;
>
>         if (amdgpu_sriov_vf(adev))
>                 return -EINVAL;
>
> +       /* Check if this queue is the guilty one */
> +       adev->sdma.gfx_guilty =3D sdma_v4_4_2_is_queue_selected(adev, ins=
tance_id, false);
> +       if (adev->sdma.has_page_queue)
> +               adev->sdma.page_guilty =3D sdma_v4_4_2_is_queue_selected(=
adev, instance_id, true);
> +
> +       /* Cache the rptr before reset, after the reset,
> +       * all of the registers will be reset to 0
> +       */
> +       rptr =3D amdgpu_ring_get_rptr(ring);
> +       ring->cached_rptr =3D rptr;
> +       /* Cache the rptr for the page queue if it exists */
> +       if (adev->sdma.has_page_queue) {
> +               struct amdgpu_ring *page_ring =3D &adev->sdma.instance[in=
stance_id].page;
> +               rptr =3D amdgpu_ring_get_rptr(page_ring);
> +               page_ring->cached_rptr =3D rptr;
> +       }
> +
>         /* stop queue */
>         inst_mask =3D 1 << ring->me;
>         sdma_v4_4_2_inst_gfx_stop(adev, inst_mask);
> @@ -2055,6 +2123,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_r=
ing_funcs =3D {
>         .emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
>         .reset =3D sdma_v4_4_2_reset_queue,
> +       .is_guilty =3D sdma_v4_4_2_gfx_ring_is_guilty,
>  };
>
>  static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs =3D {
> @@ -2086,6 +2155,7 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_p=
age_ring_funcs =3D {
>         .emit_wreg =3D sdma_v4_4_2_ring_emit_wreg,
>         .emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wait_=
helper,
> +       .is_guilty =3D sdma_v4_4_2_page_ring_is_guilty,
>  };
>
>  static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)
> --
> 2.25.1
>
