Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693F9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 19:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4B336E508;
	Wed,  8 Dec 2021 19:41:01 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C51686E508
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 19:41:00 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 w6-20020a9d77c6000000b0055e804fa524so3839618otl.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 11:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hKm4aP1h59+L2r/bztBWpekQlNt3ZrMfV5JHKAo3BN0=;
 b=eiE2qBisVOkSR2/gJJAw+dzuoqADBuCrBRXnduJpT6Vm3o6ScHFohhM/6Dc9dHHhUo
 zn1/e2q5mDReqeBd/xPojZNDS9sTx3e8KkM6qtcYsK/dmnQGuO5fSTdCLJtUtsGB8RVE
 YctPWJHV0bSisICYHRtnSl2wdZmj3Cd83TRySqpD8y2ZNEsRjRP+MyfV9j4FhIwn+s0Z
 ywKbWyvSdiPK0+Q34V0hQsKZaxpJ5WNkQECZk2CrY1SvNjXWAViIAx3waYwANEtxFPWI
 ti25aDyE17A8vxDhTokQaAnD+WrK6IXklwmM6kD3W1DXEAxqhcGAW49Xp0jXF7ITEAAV
 C4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hKm4aP1h59+L2r/bztBWpekQlNt3ZrMfV5JHKAo3BN0=;
 b=LpZIsc6dBtjb5tSyWmoJpJ+wnS5LAD+NE3+VFsLpkt5jynINBxDCYOp+Lq8OzyBeEA
 Fdw/813VBTgKM/CRzsDmLRuqNjMmMKXMJVdvtb49RndjeZw/nQ6AUj6kvuLAXB3aftpB
 Dtsm7YCZ2HKlZJoqDG0k/Kg5Yk5H1sqyNQaypYecU33gAsVyusQFMhsGUqVx7yb9Uewt
 EkWSaISCZRui/XxZ29TaMKTVump+brIzachDazbkTQ1R/TnsCBDo83gHdyM2CXTi5uyQ
 i1KAws47k8rI9sALWRYzFhBNAtM1chIf07Ws6DzKo4hxiiqfPWso7kDLR0kkOQn6iYF4
 am7Q==
X-Gm-Message-State: AOAM533Vb8R5bSMOtC6J+hpaKofwpYyMJ8iAycw730UIDJL1kc/Ozwpd
 by5dF3VH4DGxqWF5TY6mHx+vgfQRAYwUho4QdAXyXbRp
X-Google-Smtp-Source: ABdhPJxznm7AAoHDdc+Ly20L5zUMbRgd1W6thArn7rBUfWW/3KPuJJYywjHMMhbbzSxowEaIQYN0b3hGS/4+dxbTAM8=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr1347694oto.357.1638992459990; 
 Wed, 08 Dec 2021 11:40:59 -0800 (PST)
MIME-Version: 1.0
References: <20211208012529.372478-1-isabbasso@riseup.net>
 <20211208012529.372478-3-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-3-isabbasso@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 14:40:49 -0500
Message-ID: <CADnq5_Nwm2WNojr6UvtgviR4+eVsyYKY8ro5xiGWtqcZfHFS3g@mail.gmail.com>
Subject: Re: [PATCH 02/10] drm/amd: fix improper docstring syntax
To: Isabella Basso <isabbasso@riseup.net>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, ~lkcamp/patches@lists.sr.ht,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Tue, Dec 7, 2021 at 10:17 PM Isabella Basso <isabbasso@riseup.net> wrote:
>
> This fixes various warnings relating to erroneous docstring syntax, of
> which some are listed below:
>
>  warning: Function parameter or member 'adev' not described in
>  'amdgpu_atomfirmware_ras_rom_addr'
>  ...
>  warning: expecting prototype for amdgpu_atpx_validate_functions().
>  Prototype was for amdgpu_atpx_validate() instead
>  ...
>  warning: Excess function parameter 'mem' description in 'amdgpu_preempt_mgr_new'
>  ...
>  warning: Cannot understand  * @kfd_get_cu_occupancy - Collect number of
>  waves in-flight on this device
>  ...
>  warning: This comment starts with '/**', but isn't a kernel-doc
>  comment. Refer Documentation/doc-guide/kernel-doc.rst
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c        | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c        | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c              | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c                 | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c                 | 2 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c         | 4 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c                 | 6 +++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c                 | 1 -
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c                  | 2 --
>  drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c                  | 2 --
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c                | 4 ++--
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c                | 5 ++---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c                    | 7 +++++++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 4 ++++
>  drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 2 +-
>  15 files changed, 29 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> index 97178b307ed6..4d4ddf026faf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atomfirmware.c
> @@ -470,8 +470,8 @@ bool amdgpu_atomfirmware_dynamic_boot_config_supported(struct amdgpu_device *ade
>
>  /**
>   * amdgpu_atomfirmware_ras_rom_addr -- Get the RAS EEPROM addr from VBIOS
> - * adev: amdgpu_device pointer
> - * i2c_address: pointer to u8; if not NULL, will contain
> + * @adev: amdgpu_device pointer
> + * @i2c_address: pointer to u8; if not NULL, will contain
>   *    the RAS EEPROM address if the function returns true
>   *
>   * Return true if VBIOS supports RAS EEPROM address reporting,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index 7abe9500c0c6..c2be6ad62308 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -165,7 +165,7 @@ static void amdgpu_atpx_parse_functions(struct amdgpu_atpx_functions *f, u32 mas
>  }
>
>  /**
> - * amdgpu_atpx_validate_functions - validate ATPX functions
> + * amdgpu_atpx_validate - validate ATPX functions
>   *
>   * @atpx: amdgpu atpx struct
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3c5afa45173c..5bc32c1745b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -331,7 +331,7 @@ void amdgpu_device_mm_access(struct amdgpu_device *adev, loff_t pos,
>  }
>
>  /**
> - * amdgpu_device_vram_access - access vram by vram aperature
> + * amdgpu_device_aper_access - access vram by vram aperature
>   *
>   * @adev: amdgpu_device pointer
>   * @pos: offset of the buffer in vram
> @@ -3800,7 +3800,7 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
>  }
>
>  /**
> - * amdgpu_device_fini - tear down the driver
> + * amdgpu_device_fini_hw - tear down the driver
>   *
>   * @adev: amdgpu_device pointer
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> index e031f0cf93a2..9415da8b92eb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -383,7 +383,7 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>  }
>
>  /**
> - * amdgpu_irq_fini - shut down interrupt handling
> + * amdgpu_irq_fini_sw - shut down interrupt handling
>   *
>   * @adev: amdgpu device pointer
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> index 4eaec446b49d..0bb2466d539a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> @@ -69,6 +69,7 @@ static void amdgpu_pll_reduce_ratio(unsigned *nom, unsigned *den,
>  /**
>   * amdgpu_pll_get_fb_ref_div - feedback and ref divider calculation
>   *
> + * @adev: amdgpu_device pointer
>   * @nom: nominator
>   * @den: denominator
>   * @post_div: post divider
> @@ -106,6 +107,7 @@ static void amdgpu_pll_get_fb_ref_div(struct amdgpu_device *adev, unsigned int n
>  /**
>   * amdgpu_pll_compute - compute PLL paramaters
>   *
> + * @adev: amdgpu_device pointer
>   * @pll: information about the PLL
>   * @freq: requested frequency
>   * @dot_clock_p: resulting pixel clock
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> index d02c8637f909..786afe4f58f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
> @@ -59,7 +59,7 @@ static DEVICE_ATTR_RO(mem_info_preempt_used);
>   * @man: TTM memory type manager
>   * @tbo: TTM BO we need this range for
>   * @place: placement flags and restrictions
> - * @mem: the resulting mem object
> + * @res: TTM memory object
>   *
>   * Dummy, just count the space used without allocating resources or any limit.
>   */
> @@ -85,7 +85,7 @@ static int amdgpu_preempt_mgr_new(struct ttm_resource_manager *man,
>   * amdgpu_preempt_mgr_del - free ranges
>   *
>   * @man: TTM memory type manager
> - * @mem: TTM memory object
> + * @res: TTM memory object
>   *
>   * Free the allocated GTT again.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index a95d200adff9..00f94f6b5287 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1161,9 +1161,9 @@ int amdgpu_ras_error_inject(struct amdgpu_device *adev,
>
>  /**
>   * amdgpu_ras_query_error_count -- Get error counts of all IPs
> - * adev: pointer to AMD GPU device
> - * ce_count: pointer to an integer to be set to the count of correctible errors.
> - * ue_count: pointer to an integer to be set to the count of uncorrectible
> + * @adev: pointer to AMD GPU device
> + * @ce_count: pointer to an integer to be set to the count of correctible errors.
> + * @ue_count: pointer to an integer to be set to the count of uncorrectible
>   * errors.
>   *
>   * If set, @ce_count or @ue_count, count and return the corresponding
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> index 688bef1649b5..344f711ad144 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -434,7 +434,6 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
>   *
>   * @ring: ring we should submit the msg to
>   * @handle: VCE session handle to use
> - * @bo: amdgpu object for which we query the offset
>   * @fence: optional fence to return
>   *
>   * Open up a stream for HW test
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> index 853d1511b889..81e033549dda 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> @@ -481,8 +481,6 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
>   * sdma_v5_0_ring_emit_mem_sync - flush the IB by graphics cache rinse
>   *
>   * @ring: amdgpu ring pointer
> - * @job: job to retrieve vmid from
> - * @ib: IB object to schedule
>   *
>   * flush the IB by graphics cache rinse.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> index 4d4d1aa51b8a..4f546f632223 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> @@ -368,8 +368,6 @@ static void sdma_v5_2_ring_emit_ib(struct amdgpu_ring *ring,
>   * sdma_v5_2_ring_emit_mem_sync - flush the IB by graphics cache rinse
>   *
>   * @ring: amdgpu ring pointer
> - * @job: job to retrieve vmid from
> - * @ib: IB object to schedule
>   *
>   * flush the IB by graphics cache rinse.
>   */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index d59b73f69260..9731151b67d6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -108,8 +108,8 @@ svm_migrate_gart_map(struct amdgpu_ring *ring, uint64_t npages,
>   * svm_migrate_copy_memory_gart - sdma copy data between ram and vram
>   *
>   * @adev: amdgpu device the sdma ring running
> - * @src: source page address array
> - * @dst: destination page address array
> + * @sys: system DMA pointer to be copied
> + * @vram: vram destination DMA pointer
>   * @npages: number of pages to copy
>   * @direction: enum MIGRATION_COPY_DIR
>   * @mfence: output, sdma fence to signal after sdma is done
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 9158f9754a24..f1930ff2c74a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -251,14 +251,13 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
>  }
>
>  /**
> - * @kfd_get_cu_occupancy - Collect number of waves in-flight on this device
> + * kfd_get_cu_occupancy - Collect number of waves in-flight on this device
>   * by current process. Translates acquired wave count into number of compute units
>   * that are occupied.
>   *
> - * @atr: Handle of attribute that allows reporting of wave count. The attribute
> + * @attr: Handle of attribute that allows reporting of wave count. The attribute
>   * handle encapsulates GPU device it is associated with, thereby allowing collection
>   * of waves in flight, etc
> - *
>   * @buffer: Handle of user provided buffer updated with wave count
>   *
>   * Return: Number of bytes written to user buffer or an error value
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f2db49c7a8fd..82cb45e30197 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1650,6 +1650,10 @@ static void svm_range_restore_work(struct work_struct *work)
>
>  /**
>   * svm_range_evict - evict svm range
> + * @prange: svm range structure
> + * @mm: current process mm_struct
> + * @start: starting process queue number
> + * @last: last process queue number
>   *
>   * Stop all queues of the process to ensure GPU doesn't access the memory, then
>   * return to let CPU evict the buffer and proceed CPU pagetable update.
> @@ -2161,6 +2165,9 @@ svm_range_unmap_from_cpu(struct mm_struct *mm, struct svm_range *prange,
>
>  /**
>   * svm_range_cpu_invalidate_pagetables - interval notifier callback
> + * @mni: mmu_interval_notifier struct
> + * @range: mmu_notifier_range struct
> + * @cur_seq: value to pass to mmu_interval_set_seq()
>   *
>   * If event is MMU_NOTIFY_UNMAP, this is from CPU unmap range, otherwise, it
>   * is from migration, or CPU page invalidation callback.
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index a022e5bb30a5..a71177305bcd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -285,8 +285,12 @@ static int __set_input_tf(struct dc_transfer_func *func,
>  }
>
>  /**
> + * amdgpu_dm_verify_lut_sizes
> + * @crtc_state: the DRM CRTC state
> + *
>   * Verifies that the Degamma and Gamma LUTs attached to the |crtc_state| are of
>   * the expected size.
> + *
>   * Returns 0 on success.
>   */
>  int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 048ca1673863..76f3bcfee82d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -94,7 +94,7 @@ static void smu_cmn_read_arg(struct smu_context *smu,
>
>  /**
>   * __smu_cmn_poll_stat -- poll for a status from the SMU
> - * smu: a pointer to SMU context
> + * @smu: a pointer to SMU context
>   *
>   * Returns the status of the SMU, which could be,
>   *    0, the SMU is busy with your command;
> --
> 2.34.1
>
