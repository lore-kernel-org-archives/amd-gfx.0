Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51452C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 13:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4F1711B3DD;
	Mon,  6 Jun 2022 13:27:36 +0000 (UTC)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B70611B3DD
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 13:27:36 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id r206so19646188oib.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jun 2022 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pVliBXI+QwvDHUGK+ny2TXhuY0VZM8xjzbUkuwt2nEs=;
 b=NagckrtKEHiyyrQxVHx3UIZW+ZcStOOrsvsugv3QOKeemLmBn+jQ1jZI6jxQU8oVyG
 sEwsrPj7QeMS73UVo0/MClFVAKeQZ+CiPql2PWi4uIWjy7Gip7jfmn8N1vGQFwFPy2NJ
 iYXexBT3E3f9om9JVEqPSwsKITRJKS1S/q88MSuYKjAUjAcBXNf7fMVQCVdeEEFNoaPA
 jnVWraO1Lvt3jr5fNk+vO9VDhcvHk6LspO6X0rb9+DDBetUj8L5XRjgqs0ZgE+iEmidU
 YhONhAnpR9NvbRFyjX9AwceOmlsWLKJbopmIaBsd+Y6ZlHvb3yYN5KcvGSkpPiaFFFCH
 NALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pVliBXI+QwvDHUGK+ny2TXhuY0VZM8xjzbUkuwt2nEs=;
 b=fn9HhaWj/F/GZ8UCEFFzdXu0uhvijMIK9y3LWXjQjmijtKY3Ihmcq47jhGZrWyEHnj
 hIdbeBVzPxqkbQwiJfUieNOAaAhLcEjeSX5IJVJvZq01cV1NWbZmPQufWPv1O5CQ6Xly
 MloKT5wQmH0ZPCm6qZydXlt+/xvaSbIcVFARXYLPbaQqvDF4We3RjcRbDN8490c43z9e
 UoeVc3P17xHs9hHfgLxUOMBxp0nuNkUPGELMQTrjUarTZzeodAySvcOnUoQWDZSc4VXW
 KiTxms1kifigbsyZuro24QjA6hfjTXKxWK+cdduwJ4h88g8UAA4UsIiH5vqaSaw9FD1Q
 e1Xw==
X-Gm-Message-State: AOAM533GlEYE1fKKr8w6xx1i1m9SnP6vhI8lkcDDgoQ9EGGU0WHOdXme
 PetV7UO/I3ykAo8PGdcVuTe7xE2EGJ1RTGRj7j0=
X-Google-Smtp-Source: ABdhPJyo8AeYbXsewfjPbElUXkgHTnexXJl3T+/NySbFyN5A4nWeVXTx73RLVBBYX01IAzxJpBHOrSj86bth5QxkqCA=
X-Received: by 2002:a54:4f01:0:b0:32e:726c:bced with SMTP id
 e1-20020a544f01000000b0032e726cbcedmr6145484oiy.253.1654522055199; Mon, 06
 Jun 2022 06:27:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220606021400.10764-1-guchun.chen@amd.com>
In-Reply-To: <20220606021400.10764-1-guchun.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jun 2022 09:27:23 -0400
Message-ID: <CADnq5_PvbMG3fWwFQo-6vqHd92tkvPoFJE_QsTSY0AB+2AesJA@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: Ensure the DMA engine is deactivated
 during set ups"
To: Guchun Chen <guchun.chen@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Haohui Mai <ricetons@gmail.com>, Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Hawking Zhang <hawking.zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jun 5, 2022 at 10:14 PM Guchun Chen <guchun.chen@amd.com> wrote:
>
> This reverts commit da38a66ac46e334f198afcd1b4d4554b4ddca0df.
>
> This causes regression in GPU reset related test.
>
> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
> Cc: ricetons@gmail.com
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 109 ++++++++++---------------
>  1 file changed, 45 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 06b2635b142a..83c6ccaaa9e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -469,6 +469,7 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
>         }
>  }
>
> +
>  /**
>   * sdma_v5_2_gfx_stop - stop the gfx async dma engines
>   *
> @@ -514,21 +515,17 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
>  }
>
>  /**
> - * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
> - * context switch for an instance
> + * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
>   *
>   * @adev: amdgpu_device pointer
> - * @instance_idx: the index of the SDMA instance
> + * @enable: enable/disable the DMA MEs context switch.
>   *
> - * Unhalt the async dma engines context switch.
> + * Halt or unhalt the async dma engines context switch.
>   */
> -static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
> +static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>  {
>         u32 f32_cntl, phase_quantum = 0;
> -
> -       if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
> -               return;
> -       }
> +       int i;
>
>         if (amdgpu_sdma_phase_quantum) {
>                 unsigned value = amdgpu_sdma_phase_quantum;
> @@ -552,68 +549,50 @@ static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev,
>                 phase_quantum =
>                         value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
>                         unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
> -
> -               WREG32_SOC15_IP(GC,
> -                       sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
> -                       phase_quantum);
> -               WREG32_SOC15_IP(GC,
> -                       sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
> -                   phase_quantum);
> -               WREG32_SOC15_IP(GC,
> -                       sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
> -                   phase_quantum);
>         }
>
> -       if (!amdgpu_sriov_vf(adev)) {
> -               f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
> -               f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> -                               AUTO_CTXSW_ENABLE, 1);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
> +       for (i = 0; i < adev->sdma.num_instances; i++) {
> +               if (enable && amdgpu_sdma_phase_quantum) {
> +                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> +                              phase_quantum);
> +                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> +                              phase_quantum);
> +                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> +                              phase_quantum);
> +               }
> +
> +               if (!amdgpu_sriov_vf(adev)) {
> +                       f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> +                       f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> +                                       AUTO_CTXSW_ENABLE, enable ? 1 : 0);
> +                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> +               }
>         }
> +
>  }
>
>  /**
> - * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
> + * sdma_v5_2_enable - stop the async dma engines
>   *
>   * @adev: amdgpu_device pointer
> + * @enable: enable/disable the DMA MEs.
>   *
> - * Halt the async dma engines context switch.
> + * Halt or unhalt the async dma engines.
>   */
> -static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
> +static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
>  {
>         u32 f32_cntl;
>         int i;
>
> -       if (amdgpu_sriov_vf(adev))
> -               return;
> -
> -       for (i = 0; i < adev->sdma.num_instances; i++) {
> -               f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> -               f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
> -                               AUTO_CTXSW_ENABLE, 0);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> +       if (!enable) {
> +               sdma_v5_2_gfx_stop(adev);
> +               sdma_v5_2_rlc_stop(adev);
>         }
> -}
> -
> -/**
> - * sdma_v5_2_halt - stop the async dma engines
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Halt the async dma engines.
> - */
> -static void sdma_v5_2_halt(struct amdgpu_device *adev)
> -{
> -       int i;
> -       u32 f32_cntl;
> -
> -       sdma_v5_2_gfx_stop(adev);
> -       sdma_v5_2_rlc_stop(adev);
>
>         if (!amdgpu_sriov_vf(adev)) {
>                 for (i = 0; i < adev->sdma.num_instances; i++) {
>                         f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
> -                       f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
> +                       f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
>                         WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
>                 }
>         }
> @@ -625,9 +604,6 @@ static void sdma_v5_2_halt(struct amdgpu_device *adev)
>   * @adev: amdgpu_device pointer
>   *
>   * Set up the gfx DMA ring buffers and enable them.
> - * It assumes that the dma engine is stopped for each instance.
> - * The function enables the engine and preemptions sequentially for each instance.
> - *
>   * Returns 0 for success, error for failure.
>   */
>  static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
> @@ -769,7 +745,10 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>
>                 ring->sched.ready = true;
>
> -               sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
> +               if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
> +                       sdma_v5_2_ctx_switch_enable(adev, true);
> +                       sdma_v5_2_enable(adev, true);
> +               }
>
>                 r = amdgpu_ring_test_ring(ring);
>                 if (r) {
> @@ -813,7 +792,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
>         int i, j;
>
>         /* halt the MEs */
> -       sdma_v5_2_halt(adev);
> +       sdma_v5_2_enable(adev, false);
>
>         for (i = 0; i < adev->sdma.num_instances; i++) {
>                 if (!adev->sdma.instance[i].fw)
> @@ -885,8 +864,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>         int r = 0;
>
>         if (amdgpu_sriov_vf(adev)) {
> -               sdma_v5_2_ctx_switch_disable_all(adev);
> -               sdma_v5_2_halt(adev);
> +               sdma_v5_2_ctx_switch_enable(adev, false);
> +               sdma_v5_2_enable(adev, false);
>
>                 /* set RB registers */
>                 r = sdma_v5_2_gfx_resume(adev);
> @@ -910,10 +889,12 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
>                 amdgpu_gfx_off_ctrl(adev, false);
>
>         sdma_v5_2_soft_reset(adev);
> +       /* unhalt the MEs */
> +       sdma_v5_2_enable(adev, true);
> +       /* enable sdma ring preemption */
> +       sdma_v5_2_ctx_switch_enable(adev, true);
>
> -       /* Soft reset supposes to disable the dma engine and preemption.
> -        * Now start the gfx rings and rlc compute queues.
> -        */
> +       /* start the gfx rings and rlc compute queues */
>         r = sdma_v5_2_gfx_resume(adev);
>         if (adev->in_s0ix)
>                 amdgpu_gfx_off_ctrl(adev, true);
> @@ -1447,8 +1428,8 @@ static int sdma_v5_2_hw_fini(void *handle)
>         if (amdgpu_sriov_vf(adev))
>                 return 0;
>
> -       sdma_v5_2_ctx_switch_disable_all(adev);
> -       sdma_v5_2_halt(adev);
> +       sdma_v5_2_ctx_switch_enable(adev, false);
> +       sdma_v5_2_enable(adev, false);
>
>         return 0;
>  }
> --
> 2.17.1
>
