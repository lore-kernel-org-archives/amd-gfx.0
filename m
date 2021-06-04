Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF27C4743C
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 19:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D532613F9
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 19:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D532613F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C52E66F8C0;
	Fri,  4 Jun 2021 19:17:07 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8DC46F8C0
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 19:17:06 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id ci15so16055124ejc.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Jun 2021 12:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yn/1Y9j6bdpLWc5Mr6axmRrFVfjkSIjnlAf4DaUP8Hw=;
 b=Domo3SLOXVWkKtmqa26/kONw6tmAcN8yc1LOJTQZ2vFJMRKrOG7MXjwJkFtroNWKR5
 A4+BtjSFiBMJ6vHN4SoOCAnBk2SAqKUjEukq9houuFjIPO2zm/10Y6Q1JGtXiDeYvHE0
 pWRybEkpVsbeeZ3af+6CeayKbdfJjnuBojAkzUPRf4JiFcizVxblEaU6E+MWAkb9srie
 3ylFEA6azWbWG8G+zYJ7tUZ84tkO9AdBBC4QkLuKhW8lQq6nOKXhXtol9deHZ2dClQfN
 y32GG9AXaXa9fsaP8qw445R5MGBpDnQTAxwpH5MiGC9KhmWTFjFCCsa5veMgktbg708n
 N5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yn/1Y9j6bdpLWc5Mr6axmRrFVfjkSIjnlAf4DaUP8Hw=;
 b=Ou5N/tFYrEeV7iA/3lRQ/EaKgAYUa6B2Bb8vpKhEtbxqLuINMDzQOGqSH86173n9pD
 hyBhrFMhftmpiN4dFG0KhIOgem7WqrC6nroVGP/ynnGL8yPCu66bHnGFS4rpx749D3v3
 E2ytgQO9Oqwh85uApkIXnaYUl41PPV/jYAC3XSjYsu4aiiTgB25qc4oen3bF36IgMIfo
 T/F3YqdLWoYx9TyPom+o3Fs8e19DpFv0JYWHxvLt5Qis7s0AA3n1I51eKfuZuxiD3dEB
 o9MDEQ5b9EUatGbHdgbhDX7Zbs/kAEseo80+ZZ7SjlEiSTrRzcFdTD2y0m+2vwyt5Awg
 XBrQ==
X-Gm-Message-State: AOAM532qnZxhpAZGbx6ZODVeOmCVriDOZe1cslf/TMHAatkpieH3kMOS
 EWWFKIxZW4THPWAqK7nT/L4xXKlm0E5BjVY48OM=
X-Google-Smtp-Source: ABdhPJzcVZaWt9vsKF+H8UM4DweITLXXaB7iZ0rxPIyK31xgMMbdVuGks+rKYapKsBIq9OIcTigVH9Gy/D5jj6cLQDM=
X-Received: by 2002:a17:906:2bd3:: with SMTP id
 n19mr5704490ejg.210.1622834225229; 
 Fri, 04 Jun 2021 12:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210604190832.1611-1-rohit.khaire@amd.com>
In-Reply-To: <20210604190832.1611-1-rohit.khaire@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Jun 2021 15:16:52 -0400
Message-ID: <CADnq5_M1U_8u7GWPc3oJdePO5nnujp9+=9UqBCx5ZfOQ_0yeSg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Modify register access in sdma_v5_2 to use
 _SOC15 macros
To: Rohit Khaire <rohit.khaire@amd.com>
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
Cc: Davis Ming <Davis.Ming@amd.com>, Horace Chen <Horace.Chen@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Emily Deng <Emily.Deng@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 4, 2021 at 3:08 PM Rohit Khaire <rohit.khaire@amd.com> wrote:
>
> In SRIOV environment, KMD should access SDMA registers
> with RLCG if GC indirect access flag enabled.
>
> Using _SOC15 read/write macros ensures that they go
> through RLC when the flag is enabled.
>
> Signed-off-by: Rohit Khaire <rohit.khaire@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 70 +++++++++++++-------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 98059bce692f..62bc8bd7f9f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -495,12 +495,12 @@ static void sdma_v5_2_gfx_stop(struct amdgpu_device *adev)
>                 amdgpu_ttm_set_buffer_funcs_status(adev, false);
>
>         for (i = 0; i < adev->sdma.num_instances; i++) {
> -               rb_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
> +               rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
>                 rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
> -               ib_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
> +               ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
>                 ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
>         }
>  }
>
> @@ -558,11 +558,11 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
>                 f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
>                                 AUTO_CTXSW_ENABLE, enable ? 1 : 0);
>                 if (enable && amdgpu_sdma_phase_quantum) {
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
> +                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
>                                phase_quantum);
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
> +                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
>                                phase_quantum);
> -                       WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
> +                       WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
>                                phase_quantum);
>                 }
>                 WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
> @@ -620,62 +620,62 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>                 ring = &adev->sdma.instance[i].ring;
>                 wb_offset = (ring->rptr_offs * 4);
>
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
>
>                 /* Set ring buffer size in dwords */
>                 rb_bufsz = order_base_2(ring->ring_size / 4);
> -               rb_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
> +               rb_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL));
>                 rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
>  #ifdef __BIG_ENDIAN
>                 rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
>                 rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
>                                         RPTR_WRITEBACK_SWAP_ENABLE, 1);
>  #endif
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
>
>                 /* Initialize the ring buffer's read and write pointers */
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR), 0);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_HI), 0);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), 0);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), 0);
>
>                 /* setup the wptr shadow polling */
>                 wptr_gpu_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO),
>                        lower_32_bits(wptr_gpu_addr));
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI),
>                        upper_32_bits(wptr_gpu_addr));
> -               wptr_poll_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i,
> +               wptr_poll_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i,
>                                                          mmSDMA0_GFX_RB_WPTR_POLL_CNTL));
>                 wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
>                                                SDMA0_GFX_RB_WPTR_POLL_CNTL,
>                                                F32_POLL_ENABLE, 1);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_POLL_CNTL),
>                        wptr_poll_cntl);
>
>                 /* set the wb address whether it's enabled or not */
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_HI),
>                        upper_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFF);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_RPTR_ADDR_LO),
>                        lower_32_bits(adev->wb.gpu_addr + wb_offset) & 0xFFFFFFFC);
>
>                 rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
>
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE), ring->gpu_addr >> 8);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_BASE_HI), ring->gpu_addr >> 40);
>
>                 ring->wptr = 0;
>
>                 /* before programing wptr to a less value, need set minor_ptr_update first */
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 1);
>
>                 if (!amdgpu_sriov_vf(adev)) { /* only bare-metal use register write for wptr */
>                         WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR), lower_32_bits(ring->wptr) << 2);
>                         WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_WPTR_HI), upper_32_bits(ring->wptr) << 2);
>                 }
>
> -               doorbell = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
> -               doorbell_offset = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
> +               doorbell = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL));
> +               doorbell_offset = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET));
>
>                 if (ring->use_doorbell) {
>                         doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
> @@ -684,8 +684,8 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>                 } else {
>                         doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
>                 }
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL), doorbell);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_DOORBELL_OFFSET), doorbell_offset);
>
>                 adev->nbio.funcs->sdma_doorbell_range(adev, i, ring->use_doorbell,
>                                                       ring->doorbell_index,
> @@ -695,7 +695,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>                         sdma_v5_2_ring_set_wptr(ring);
>
>                 /* set minor_ptr_update to 0 after wptr programed */
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_MINOR_PTR_UPDATE), 0);
>
>                 /* set utc l1 enable flag always to 1 */
>                 temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
> @@ -706,19 +706,19 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>                 WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), temp);
>
>                 /* Set up RESP_MODE to non-copy addresses */
> -               temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
> +               temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL));
>                 temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, RESP_MODE, 3);
>                 temp = REG_SET_FIELD(temp, SDMA0_UTCL1_CNTL, REDO_DELAY, 9);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_CNTL), temp);
>
>                 /* program default cache read and write policy */
> -               temp = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
> +               temp = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE));
>                 /* clean read policy and write policy bits */
>                 temp &= 0xFF0FFF;
>                 temp |= ((CACHE_READ_POLICY_L2__DEFAULT << 12) |
>                          (CACHE_WRITE_POLICY_L2__DEFAULT << 14) |
>                          SDMA0_UTCL1_PAGE__LLC_NOALLOC_MASK);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_UTCL1_PAGE), temp);
>
>                 if (!amdgpu_sriov_vf(adev)) {
>                         /* unhalt engine */
> @@ -729,15 +729,15 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
>
>                 /* enable DMA RB */
>                 rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_RB_CNTL), rb_cntl);
>
> -               ib_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
> +               ib_cntl = RREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL));
>                 ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
>  #ifdef __BIG_ENDIAN
>                 ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
>  #endif
>                 /* enable DMA IBs */
> -               WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
> +               WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_GFX_IB_CNTL), ib_cntl);
>
>                 ring->sched.ready = true;
>
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
