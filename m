Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4CD1C02194
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Feb 2025 14:56:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F11610E669;
	Tue,  4 Feb 2025 14:56:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IyF084uS";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1A110E669
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Feb 2025 14:56:20 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-2f9b8ef4261so228197a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Feb 2025 06:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738680980; x=1739285780; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tmCa6V+GukLvELyynmhmm0lpam/ddoQTkXV/j3Zrvvc=;
 b=IyF084uSo/n7qvzV5P9zMELZo/gG9ykNfNJ/oALYDNsyGibCl4ZsxvMmCuOvTWqruu
 lv5oKimzb7/uvab9qqSym0YANluGAkOpcdPCtDbC6bsRTf8bFvzfgBuWdwfMG59/3rVI
 TsvNHK+UXu8I17b5S+h0fuvlCfIDZXcm0qoxyTRAW/6rxgfWMK+3UbINndiJCGvQ4NfY
 UyDKy5XDkm3pJ7sh2h2oSMAMDOt5AlTj2GmjP5S+o6ZRbPTEzRjdF92XAlJNszi1ueKz
 qhPyYrv5W0X/d0lHCkRNiYk2ENyYWVFdTPC2jRyWjh437XPz+Cb5bvfnzRD8KkCkCI3y
 lLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738680980; x=1739285780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tmCa6V+GukLvELyynmhmm0lpam/ddoQTkXV/j3Zrvvc=;
 b=BqliuLJ5TNIJAyidmT/fQL3iRnWouIWz7q1v5dkkl837Pbq1NOtdd7wWXLOwvDu7Oq
 STvKaAICkKVJSCXEtWbGtZHXxrCUUy+tWthHuxYWvKKRSkRLkNJuoLOdJ+OXmJoUsYB1
 L8NjI6HDJ8ZLbss9gxFbbRxaA0KeLPw4eMsyUEg+mUahnuxKu1tQvc3PeGF5PbEhH8L2
 YOMmbh/7qmX9Yqde4PP9H4kMnu3Fln6uBt0OJ4+TzlVluODILjBE9F4PBbWZJFMM8jjb
 /SzuG+qG6zqNceFhdxW19753nEVPDKUV4XY9lCqJSwhfsbZfpMKxJ80SxSuA2r8TeVkP
 erjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMkeel/2Shwvu8bd1c9qOJUoh+aYtXr/u7uAUdGZyAVfUoR4lJH32KjY3m6CiGUmFAcLCNaatD@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5j5PH6A489kXNPJfXZoldKpJGNyK1aCZDzl9j0K1KOkfO/I1j
 534+Ps8vORCQCI958CjwShtZ9WtdIr0W2RbY4FHQXRmPB5rnZhs+OHZHYRg1jlR8h56Kuhol71I
 X0PmZ8+6v9U35W7KrIs3NWNj12nPmHA==
X-Gm-Gg: ASbGncvhZyme+ZERVh4ncmWQa9R+0du5fmvYh8f8fbFLRWT4s5sjasCX6DbQEnRk16i
 WDDtPPYK2tQ725JaxE89FNvjXDhtSYdrKTkh8L5hHLAXx1vORD3iiZB93sYbWiTYgPUkyOXRF
X-Google-Smtp-Source: AGHT+IFlZCtqNSlBsL+qCRb96kdiFmbjw2P4ocBk3JZK75/uEOMnz7EJUFQK1TJCBSSkBwGVdcj+QKfyiHq/WZ/UcK4=
X-Received: by 2002:a17:90b:2e4f:b0:2ee:d372:91bd with SMTP id
 98e67ed59e1d1-2f845cd4c7fmr12734322a91.2.1738680979625; Tue, 04 Feb 2025
 06:56:19 -0800 (PST)
MIME-Version: 1.0
References: <20250204143113.6320-1-christian.koenig@amd.com>
 <20250204143113.6320-3-christian.koenig@amd.com>
In-Reply-To: <20250204143113.6320-3-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Feb 2025 09:56:06 -0500
X-Gm-Features: AWEUYZn64-vFPn7HwuLWlMdbMRM8K4ddk3AXpwucnTE9BYee2EJKqgNkXyngUMc
Message-ID: <CADnq5_PVOkVgVZHmczWO68c8Ge=oeGqpMf8z1HxKiPzSgchZ6Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] drm/amdgpu: rework gfx9 queue reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: timur.kristof@gmail.com, Alexander.Deucher@amd.com, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Feb 4, 2025 at 9:48=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Testing this feature turned out that it was a bit unstable. The
> CP_VMID_RESET register takes the VMID which all submissions from should
> be canceled.
>
> Unlike Windows Linux uses per process VMIDs instead of per engine VMIDs
> for the simple reason that we don't have enough. So resetting one VMID
> only killed the submissions of one specific process.
>
> Fortunately that turned out to be exactly what we want to have.
>
> So clear the CP_VMID_RESET register between every context switch between
> applications when we do the pipeline sync to avoid trouble if multiple
> VMIDs are used on the ring right behind each other.
>
> Use the same pipeline sync function in the reset handler and issue an IB
> test instead of a ring test after the queue reset to provide a longer
> timeout and additional fence value should there be additional work on
> the ring after the one aborted.
>
> Also drop the soft recovery since that pretty much does the same thing as
> CP_VMID_RESET, just on a lower level and with less chance of succeeding.
>
> This now survives a stress test running over night sending a broken
> submission ever 45 seconds and recovering fine from each of them.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h   |  1 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 47 ++++++++++-----------------
>  2 files changed, 19 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 8902fafbcf8d..1eee2a1bca5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -275,6 +275,7 @@ extern int amdgpu_wbrf;
>  #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS         3000
>  #define AMDGPU_MAX_USEC_TIMEOUT                        100000  /* 100 ms=
 */
>  #define AMDGPU_FENCE_JIFFIES_TIMEOUT           (HZ / 2)
> +#define AMDGPU_QUEUE_RESET_TIMEOUT             (HZ / 10)
>  #define AMDGPU_DEBUGFS_MAX_COMPONENTS          32
>  #define AMDGPUFB_CONN_LIMIT                    4
>  #define AMDGPU_BIOS_NUM_SCRATCH                        16
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index fa572b40989e..705f5a9c11a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -5607,7 +5607,17 @@ static void gfx_v9_0_ring_emit_pipeline_sync(struc=
t amdgpu_ring *ring)
>         int usepfp =3D (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX);
>         uint32_t seq =3D ring->fence_drv.sync_seq;
>         uint64_t addr =3D ring->fence_drv.gpu_addr;
> +       struct amdgpu_device *adev =3D ring->adev;
>
> +       amdgpu_ring_emit_reg_wait(ring,
> +                                 SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET=
),
> +                                 0, 0xffff);
> +       amdgpu_ring_emit_wreg(ring,
> +                             SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),
> +                             0);
> +       amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> +                              ring->fence_drv.sync_seq,
> +                              AMDGPU_FENCE_FLAG_EXEC);
>         gfx_v9_0_wait_reg_mem(ring, usepfp, 1, 0,
>                               lower_32_bits(addr), upper_32_bits(addr),
>                               seq, 0xffffffff, 4);
> @@ -5963,20 +5973,6 @@ static void gfx_v9_0_ring_emit_reg_write_reg_wait(=
struct amdgpu_ring *ring,
>                                                            ref, mask);
>  }
>
> -static void gfx_v9_0_ring_soft_recovery(struct amdgpu_ring *ring, unsign=
ed vmid)
> -{
> -       struct amdgpu_device *adev =3D ring->adev;
> -       uint32_t value =3D 0;
> -
> -       value =3D REG_SET_FIELD(value, SQ_CMD, CMD, 0x03);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, MODE, 0x01);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, CHECK_VMID, 1);
> -       value =3D REG_SET_FIELD(value, SQ_CMD, VM_ID, vmid);
> -       amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
> -       WREG32_SOC15(GC, 0, mmSQ_CMD, value);
> -       amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
> -}
> -
>  static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device *a=
dev,
>                                                  enum amdgpu_interrupt_st=
ate state)
>  {
> @@ -7252,16 +7248,12 @@ static int gfx_v9_0_reset_kgq(struct amdgpu_ring =
*ring, unsigned int vmid)
>         if (r)
>                 return r;
>
> -       if (amdgpu_ring_alloc(ring, 7 + 7 + 5))
> +       if (amdgpu_ring_alloc(ring, 7 + 7 + 5 + 7))
>                 return -ENOMEM;
> -       gfx_v9_0_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
> -                                ring->fence_drv.sync_seq, AMDGPU_FENCE_F=
LAG_EXEC);
> -       gfx_v9_0_ring_emit_reg_wait(ring,
> -                                   SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RES=
ET), 0, 0xffff);
> -       gfx_v9_0_ring_emit_wreg(ring,
> -                               SOC15_REG_OFFSET(GC, 0, mmCP_VMID_RESET),=
 0);
> +       gfx_v9_0_ring_emit_pipeline_sync(ring);
> +       amdgpu_ring_commit(ring);
>
> -       return amdgpu_ring_test_ring(ring);
> +       return gfx_v9_0_ring_test_ib(ring, AMDGPU_QUEUE_RESET_TIMEOUT);
>  }
>
>  static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> @@ -7468,7 +7460,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_gfx =3D {
>         .set_wptr =3D gfx_v9_0_ring_set_wptr_gfx,
>         .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
>                 5 +  /* COND_EXEC */
> -               7 +  /* PIPELINE_SYNC */
> +               7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                 2 + /* VM_FLUSH */
> @@ -7506,7 +7498,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_gfx =3D {
>         .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> -       .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
>         .reset =3D gfx_v9_0_reset_kgq,
>         .emit_cleaner_shader =3D gfx_v9_0_ring_emit_cleaner_shader,
> @@ -7525,7 +7516,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_r=
ing_funcs_gfx =3D {
>         .set_wptr =3D amdgpu_sw_ring_set_wptr_gfx,
>         .emit_frame_size =3D /* totally 242 maximum if 16 IBs */
>                 5 +  /* COND_EXEC */
> -               7 +  /* PIPELINE_SYNC */
> +               7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                 2 + /* VM_FLUSH */
> @@ -7564,7 +7555,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_sw_r=
ing_funcs_gfx =3D {
>         .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> -       .soft_recovery =3D gfx_v9_0_ring_soft_recovery,
>         .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
>         .patch_cntl =3D gfx_v9_0_ring_patch_cntl,
>         .patch_de =3D gfx_v9_0_ring_patch_de_meta,
> @@ -7586,7 +7576,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_compute =3D {
>                 20 + /* gfx_v9_0_ring_emit_gds_switch */
>                 7 + /* gfx_v9_0_ring_emit_hdp_flush */
>                 5 + /* hdp invalidate */
> -               7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> +               7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                 8 + 8 + 8 + /* gfx_v9_0_ring_emit_fence x3 for user fence=
, vm fence */
> @@ -7608,7 +7598,6 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_compute =3D {
>         .emit_wreg =3D gfx_v9_0_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_0_ring_emit_reg_wait,
>         .emit_reg_write_reg_wait =3D gfx_v9_0_ring_emit_reg_write_reg_wai=
t,
> -       .soft_recovery =3D gfx_v9_0_ring_soft_recovery,

Probably want to keep soft_recovery for compute as compute queues
don't support vmid reset.

Alex

>         .emit_mem_sync =3D gfx_v9_0_emit_mem_sync,
>         .emit_wave_limit =3D gfx_v9_0_emit_wave_limit,
>         .reset =3D gfx_v9_0_reset_kcq,
> @@ -7629,7 +7618,7 @@ static const struct amdgpu_ring_funcs gfx_v9_0_ring=
_funcs_kiq =3D {
>                 20 + /* gfx_v9_0_ring_emit_gds_switch */
>                 7 + /* gfx_v9_0_ring_emit_hdp_flush */
>                 5 + /* hdp invalidate */
> -               7 + /* gfx_v9_0_ring_emit_pipeline_sync */
> +               7 + 7 + 5 + 7 +  /* PIPELINE_SYNC */
>                 SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
>                 SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
>                 8 + 8 + 8, /* gfx_v9_0_ring_emit_fence_kiq x3 for user fe=
nce, vm fence */
> --
> 2.34.1
>
