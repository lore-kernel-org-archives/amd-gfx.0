Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D21C3601E
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 02:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C77510EAA1;
	Fri, 11 Apr 2025 02:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E+XH5lS1";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D72FE10EAA1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 02:58:23 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7393eab4a75so123815b3a.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 19:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744340300; x=1744945100; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiRT4MaH2xIeU8pnl9iUGVrAyqoFCq6QfiiRMUZhZuk=;
 b=E+XH5lS1HGYCINf6jNjoRCXVJJW5s4OHdUtEF2pQ30xK44ZE8bbEb45Ox2I9cc0Qvp
 Yuadi5xp1C8XKBRF4h7dwcKiCLQsWunjbxj5MiuvPZt+QFV7sf162cURAykbWMiRgY69
 Zxwuz8H4CR9iiQEcgljg+OVDjvXrpnwBAjGoTZ24t9q3ZlVbtJ8PTbWn3fcMPnvM3KAk
 Z7qsx/j1mTnTUpO0JCQuFAdHdqKbmDqOZrn2W/dePRMNy2br/1A8Y5p7iP/yGOs8e3ec
 pY5xW3Yesv5J1X6EhG3eK9/oP/762ZA5fldyD9v8kWnH8jUagF21N2JDEcjRyXtV8Akg
 dCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744340300; x=1744945100;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yiRT4MaH2xIeU8pnl9iUGVrAyqoFCq6QfiiRMUZhZuk=;
 b=iNOnUfOrCZlJLFuWbA6o2TYXYCxmecgTMBMXNPw9YoVTnMsx2+SJUYSJl4lPVmKF0w
 XSoQ1uASyUj5TvnxX4BGsml7dfziiyzYulBrQExMw/x+XD2sStJqS+toNsKGbdHL0vRZ
 XjbV56bvipJI9Sx7S1oeNgYiKdnyVmos8Y7jw50kDrqTVXcEf5kXq7A23TSF9BC7xamn
 3gngT3ONT5CeL/XviTLko2sSc+AD+sKYIs6gGt8IPjAV9b62dxDowDEo4c0/e3x0haLr
 BzqTN2dMknFtqpGSaExTsNANSm6rdEiK0sBkSbfo127IbTLkXf2SA12r7VM/nNSn4GzH
 eS8A==
X-Gm-Message-State: AOJu0YyPe1OpGjpnOwBKSbxF+resjzohrzsyPh4/nPE5eurcHiJZUZO4
 cQs8/ahDQYmWZEClfXmE4Ly7PY/JYTIcfWXRkjHX6FMIJxEKtlKV7ZsEn4oG84vKJQ2LmF4L+3c
 gJXua9FirnhX754JOGF5U+N9AkXWgBwx7
X-Gm-Gg: ASbGncs5RATh5v6i0kgj4ynoCAq+ZgtQiuqifb5ND2NKc/BD1jTuOf85beUnNXFxLTO
 A7TU/9eYXHoU0BcXDDsRBq7Awpc79x7SQwur17SMemzdiGiFX5MSXk2QUMJHEZ4kV8maGrT5L4u
 N0fpf9iRPdKgn8e7ElhVjnyA==
X-Google-Smtp-Source: AGHT+IEEtQBB40XXlT2M7h+8m3BocoQOBi5UyqmLXU6KrKweXgStutkkD/KeumMPm3AZLQKSc9RjbxZUlw4PayvML7Y=
X-Received: by 2002:a05:6a21:8cc2:b0:1f1:3f0:8b32 with SMTP id
 adf61e73a8af0-2017999c59amr666854637.10.1744340300188; Thu, 10 Apr 2025
 19:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20250408083633.2300420-1-jesse.zhang@amd.com>
In-Reply-To: <20250408083633.2300420-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Apr 2025 22:58:08 -0400
X-Gm-Features: ATxdqUG-Rwq88L1BMP_Pto9Ahr7jyznyLVoySnaGK3dwggMVo8mh6KQVth89rdc
Message-ID: <CADnq5_MCxQOx2UCGJY0GfEi+i+NfvwGMinxjfxbGfSWVKnDxpg@mail.gmail.com>
Subject: Re: [v4 1/7] drm/amd/amdgpu: Simplify SDMA reset mechanism by
 removing dynamic callbacks
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, jonathan.kim@amd.com,
 jiadong.zhu@amd.com
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

On Tue, Apr 8, 2025 at 4:47=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@amd=
.com> wrote:
>
> Since KFD no longer registers its own callbacks for SDMA resets, and only=
 KGD uses the reset mechanism,
> we can simplify the SDMA reset flow by directly calling the ring's `stop_=
queue` and `start_queue` functions.
> This patch removes the dynamic callback mechanism and prepares for its ev=
entual deprecation.
>
> 1. **Remove Dynamic Callbacks**:
>    - The `pre_reset` and `post_reset` callback invocations in `amdgpu_sdm=
a_reset_engine` are removed.
>    - Instead, the ring's `stop_queue` and `start_queue` functions are cal=
led directly during the reset process.
>
> 2. **Prepare for Deprecation of Dynamic Mechanism**:
>    - By removing the callback invocations, this patch prepares the codeba=
se for the eventual removal of the dynamic callback registration mechanism.
>
> v2: Update stop_queue/start_queue function paramters to use ring pointer =
instead of device/instance(Christian)
> v3: The general coding style is to declare variables like "i" or "r" last=
. E.g. longest lines first and short lasts. (Chritian)
> v4: move stop_queue/start_queue to struct amdgpu_sdma_instance and rename=
 them. (Alex)
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

These patches look good, but I would rework the ordering a bit.  I'd
suggest splitting them up like so:
1. Add the new sdma function pointers (stop_kernel_queue,
start_kernel_queue, soft_reset) for amdgpu_sdma.h
2. Register the new sdma function pointers (stop_kernel_queue,
start_kernel_queue, soft_reset) for each sdma IP version that needs
them
3. Switch amdgpu_sdma_reset_engine() to use the new sdma function pointers
4. optimize queue reset and stop logic patches
5. implement soft reset directly for sdma 5 patches
6. remove old sdma reset callback mechanism

Alex


Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 54 ++++++------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  7 ++-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 22 ++++++----
>  3 files changed, 34 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 0a9893fee828..541b349e0310 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -558,20 +558,14 @@ void amdgpu_sdma_register_on_reset_callbacks(struct=
 amdgpu_device *adev, struct
>   * @adev: Pointer to the AMDGPU device
>   * @instance_id: ID of the SDMA engine instance to reset
>   *
> - * This function performs the following steps:
> - * 1. Calls all registered pre_reset callbacks to allow KFD and AMDGPU t=
o save their state.
> - * 2. Resets the specified SDMA engine instance.
> - * 3. Calls all registered post_reset callbacks to allow KFD and AMDGPU =
to restore their state.
> - *
>   * Returns: 0 on success, or a negative error code on failure.
>   */
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id)
>  {
> -       struct sdma_on_reset_funcs *funcs;
>         int ret =3D 0;
>         struct amdgpu_sdma_instance *sdma_instance =3D &adev->sdma.instan=
ce[instance_id];
> -       struct amdgpu_ring *gfx_ring =3D &sdma_instance->ring;
> -       struct amdgpu_ring *page_ring =3D &sdma_instance->page;
> +       struct amdgpu_ring *sdma_gfx_ring =3D &sdma_instance->ring;
> +       struct amdgpu_ring *sdma_page_ring =3D &sdma_instance->page;
>         bool gfx_sched_stopped =3D false, page_sched_stopped =3D false;
>
>         mutex_lock(&sdma_instance->engine_reset_mutex);
> @@ -579,28 +573,18 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *=
adev, uint32_t instance_id)
>         * This ensures that no new tasks are submitted to the queues whil=
e
>         * the reset is in progress.
>         */
> -       if (!amdgpu_ring_sched_ready(gfx_ring)) {
> -               drm_sched_wqueue_stop(&gfx_ring->sched);
> +       if (!amdgpu_ring_sched_ready(sdma_gfx_ring)) {
> +               drm_sched_wqueue_stop(&sdma_gfx_ring->sched);
>                 gfx_sched_stopped =3D true;
>         }
>
> -       if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(page_ri=
ng)) {
> -               drm_sched_wqueue_stop(&page_ring->sched);
> +       if (adev->sdma.has_page_queue && !amdgpu_ring_sched_ready(sdma_pa=
ge_ring)) {
> +               drm_sched_wqueue_stop(&sdma_page_ring->sched);
>                 page_sched_stopped =3D true;
>         }
>
> -       /* Invoke all registered pre_reset callbacks */
> -       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list)=
 {
> -               if (funcs->pre_reset) {
> -                       ret =3D funcs->pre_reset(adev, instance_id);
> -                       if (ret) {
> -                               dev_err(adev->dev,
> -                               "beforeReset callback failed for instance=
 %u: %d\n",
> -                                       instance_id, ret);
> -                               goto exit;
> -                       }
> -               }
> -       }
> +       if (sdma_instance->funcs->stop_kernel_queue)
> +               sdma_instance->funcs->stop_kernel_queue(sdma_gfx_ring);
>
>         /* Perform the SDMA reset for the specified instance */
>         ret =3D amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
> @@ -609,18 +593,8 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *a=
dev, uint32_t instance_id)
>                 goto exit;
>         }
>
> -       /* Invoke all registered post_reset callbacks */
> -       list_for_each_entry(funcs, &adev->sdma.reset_callback_list, list)=
 {
> -               if (funcs->post_reset) {
> -                       ret =3D funcs->post_reset(adev, instance_id);
> -                       if (ret) {
> -                               dev_err(adev->dev,
> -                               "afterReset callback failed for instance =
%u: %d\n",
> -                                       instance_id, ret);
> -                               goto exit;
> -                       }
> -               }
> -       }
> +       if (sdma_instance->funcs->start_kernel_queue)
> +               sdma_instance->funcs->start_kernel_queue(sdma_gfx_ring);
>
>  exit:
>         /* Restart the scheduler's work queue for the GFX and page rings
> @@ -628,11 +602,11 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *=
adev, uint32_t instance_id)
>          * to be submitted to the queues after the reset is complete.
>          */
>         if (!ret) {
> -               if (gfx_sched_stopped && amdgpu_ring_sched_ready(gfx_ring=
)) {
> -                       drm_sched_wqueue_start(&gfx_ring->sched);
> +               if (gfx_sched_stopped && amdgpu_ring_sched_ready(sdma_gfx=
_ring)) {
> +                       drm_sched_wqueue_start(&sdma_gfx_ring->sched);
>                 }
> -               if (page_sched_stopped && amdgpu_ring_sched_ready(page_ri=
ng)) {
> -                       drm_sched_wqueue_start(&page_ring->sched);
> +               if (page_sched_stopped && amdgpu_ring_sched_ready(sdma_pa=
ge_ring)) {
> +                       drm_sched_wqueue_start(&sdma_page_ring->sched);
>                 }
>         }
>         mutex_unlock(&sdma_instance->engine_reset_mutex);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index 47d56fd0589f..620fd7663526 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -50,6 +50,11 @@ enum amdgpu_sdma_irq {
>
>  #define NUM_SDMA(x) hweight32(x)
>
> +struct amdgpu_sdma_funcs {
> +       int (*stop_kernel_queue)(struct amdgpu_ring *ring);
> +       int (*start_kernel_queue)(struct amdgpu_ring *ring);
> +};
> +
>  struct amdgpu_sdma_instance {
>         /* SDMA firmware */
>         const struct firmware   *fw;
> @@ -68,7 +73,7 @@ struct amdgpu_sdma_instance {
>         /* track guilty state of GFX and PAGE queues */
>         bool                    gfx_guilty;
>         bool                    page_guilty;
> -
> +       const struct amdgpu_sdma_funcs   *funcs;
>  };
>
>  enum amdgpu_sdma_ras_memory_id {
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v4_4_2.c
> index 688a720bbbbd..c663c63485f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -108,6 +108,8 @@ static void sdma_v4_4_2_set_irq_funcs(struct amdgpu_d=
evice *adev);
>  static void sdma_v4_4_2_set_ras_funcs(struct amdgpu_device *adev);
>  static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *ade=
v);
>  static void sdma_v4_4_2_update_reset_mask(struct amdgpu_device *adev);
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring);
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring);
>
>  static u32 sdma_v4_4_2_get_reg_offset(struct amdgpu_device *adev,
>                 u32 instance, u32 offset)
> @@ -1333,6 +1335,11 @@ static bool sdma_v4_4_2_fw_support_paging_queue(st=
ruct amdgpu_device *adev)
>         }
>  }
>
> +static const struct amdgpu_sdma_funcs sdma_v4_4_2_sdma_funcs =3D {
> +       .stop_kernel_queue =3D &sdma_v4_4_2_stop_queue,
> +       .start_kernel_queue =3D &sdma_v4_4_2_restore_queue,
> +};
> +
>  static int sdma_v4_4_2_early_init(struct amdgpu_ip_block *ip_block)
>  {
>         struct amdgpu_device *adev =3D ip_block->adev;
> @@ -1352,7 +1359,6 @@ static int sdma_v4_4_2_early_init(struct amdgpu_ip_=
block *ip_block)
>         sdma_v4_4_2_set_irq_funcs(adev);
>         sdma_v4_4_2_set_ras_funcs(adev);
>         sdma_v4_4_2_set_engine_reset_funcs(adev);
> -
>         return 0;
>  }
>
> @@ -1447,6 +1453,7 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_blo=
ck *ip_block)
>                 /* Initialize guilty flags for GFX and PAGE queues */
>                 adev->sdma.instance[i].gfx_guilty =3D false;
>                 adev->sdma.instance[i].page_guilty =3D false;
> +               adev->sdma.instance[i].funcs =3D &sdma_v4_4_2_sdma_funcs;
>
>                 ring =3D &adev->sdma.instance[i].ring;
>                 ring->ring_obj =3D NULL;
> @@ -1678,11 +1685,12 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_=
ring *ring, unsigned int vmid)
>         return r;
>  }
>
> -static int sdma_v4_4_2_stop_queue(struct amdgpu_device *adev, uint32_t i=
nstance_id)
> +static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
>  {
> +       struct amdgpu_device *adev =3D ring->adev;
> +       u32 instance_id =3D GET_INST(SDMA0, ring->me);
>         u32 inst_mask;
>         uint64_t rptr;
> -       struct amdgpu_ring *ring =3D &adev->sdma.instance[instance_id].ri=
ng;
>
>         if (amdgpu_sriov_vf(adev))
>                 return -EINVAL;
> @@ -1715,11 +1723,11 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_d=
evice *adev, uint32_t instance_
>         return 0;
>  }
>
> -static int sdma_v4_4_2_restore_queue(struct amdgpu_device *adev, uint32_=
t instance_id)
> +static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
>  {
> -       int i;
> +       struct amdgpu_device *adev =3D ring->adev;
>         u32 inst_mask;
> -       struct amdgpu_ring *ring =3D &adev->sdma.instance[instance_id].ri=
ng;
> +       int i;
>
>         inst_mask =3D 1 << ring->me;
>         udelay(50);
> @@ -1740,8 +1748,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_=
device *adev, uint32_t instan
>  }
>
>  static struct sdma_on_reset_funcs sdma_v4_4_2_engine_reset_funcs =3D {
> -       .pre_reset =3D sdma_v4_4_2_stop_queue,
> -       .post_reset =3D sdma_v4_4_2_restore_queue,
>  };
>
>  static void sdma_v4_4_2_set_engine_reset_funcs(struct amdgpu_device *ade=
v)
> --
> 2.25.1
>
