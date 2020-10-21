Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7D6C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 18:37:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A47D0208C3
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 18:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQXuKx23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A47D0208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA0216EE77;
	Wed, 21 Oct 2020 18:37:15 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E7C6EE77;
 Wed, 21 Oct 2020 18:37:14 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id d3so3655214wma.4;
 Wed, 21 Oct 2020 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pDlQHi/rfDtXDyn1RgoMtt0ZMFpl/xYYH/AJUVM3sNs=;
 b=NQXuKx23uhrXtGYhinLl7CAk6uKb5YX216ppDJt7laEC6FVnHh7y7Y2/en4ejsZLCz
 yzTP7vWAcJGmQFp4wOXyCaXz1X0wXmW+8WHrEZBWty7kTDTDT7K5R7VVNcG5IAD0noQC
 Df6yjM7yZT86O4/+Ku3e7sfQZBEIQmT5JZDCEfE0Ty8Gr8xOclq97y7ItEaxEvPDfAWm
 LJ/s6+QUiOWbcnFysBKgIqJopO89nzs48oAfMk6x2rd0UPFQO9PnrTkSJNnbA9Ewq9BB
 95vIUQZMGFLAKOhNArqX7K1eEJxrnjSW+dROnu18MOhNgMd9VltQ+WsbxJiNsRmzjRrF
 WOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pDlQHi/rfDtXDyn1RgoMtt0ZMFpl/xYYH/AJUVM3sNs=;
 b=n5vBZrN8ylV7POoVo32a9edKI4BgHA50kY6f5IFXJ8gLZ3Y40Hbf+qasuC7P4ZnkDa
 RCuHI6imFGUv2dEJnUgrp9nUb9e1mW5hOFT47XgKV8e/7mkeKeAOwSDUn/71JV3i6UNM
 uRDkptx5UORU/FseiAocDyMxJaBiyEWMSz6rhQD7re3CR6Lno4ZXwXZfN5Ilg0Tnd1+J
 djg9LuAJZS4XEX+fViiX/+rLg13K0ARzIDY7g6FRw/ZICcsA8WEPTdOpeSraEhfUFwoL
 EZU3ETPl2m2dUQKnYR/fzfl+XuhZ9JYwXE/uL9TDfVtFINMANqE108wBgOf6QRhMlFTy
 g/Cg==
X-Gm-Message-State: AOAM5337TKqoCzw+xwSkO9iEGEhnC/N46tLomfaMyll/KDFh+D7156iv
 YPTFvhm3LDj3kXXb2nqlapOJnFdN6cmDYdAAjFY=
X-Google-Smtp-Source: ABdhPJxzPuccmmb5vOFOTXSOSHTm+pFwQKaC34ofxdHpoEAi7LVjOYcnPl1ZN6D2s+A73DVP0fKoUCnSSPjfLybZdzA=
X-Received: by 2002:a1c:4b05:: with SMTP id y5mr5019720wma.56.1603305432951;
 Wed, 21 Oct 2020 11:37:12 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603282193.git.mchehab+huawei@kernel.org>
 <8245658e2c6fb724e2ffbe6ead43b75bbdf8818d.1603282193.git.mchehab+huawei@kernel.org>
In-Reply-To: <8245658e2c6fb724e2ffbe6ead43b75bbdf8818d.1603282193.git.mchehab+huawei@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2020 14:37:00 -0400
Message-ID: <CADnq5_Mm3ZZbE-Wh-VyjWjGUG7HMOawS=fLhoeSmOM03JGVTOQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] drm: amdgpu: kernel-doc: update some adev
 parameters
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 Jonathan Corbet <corbet@lwn.net>, David Airlie <airlied@linux.ie>,
 Bernard Zhao <bernard@vivo.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Colton Lewis <colton.w.lewis@protonmail.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dennis Li <Dennis.Li@amd.com>, Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Wed, Oct 21, 2020 at 8:17 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Running "make htmldocs: produce lots of warnings on those files:
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'p_size' description in 'amdgpu_vram_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:211: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_fini'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'p_size' description in 'amdgpu_vram_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:211: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_fini'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'p_size' description in 'amdgpu_vram_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:211: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_fini'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:177: warning: Excess function parameter 'p_size' description in 'amdgpu_vram_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c:211: warning: Excess function parameter 'man' description in 'amdgpu_vram_mgr_fini'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:90: warning: Excess function parameter 'man' description in 'amdgpu_gtt_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:90: warning: Excess function parameter 'p_size' description in 'amdgpu_gtt_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:134: warning: Excess function parameter 'man' description in 'amdgpu_gtt_mgr_fini'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:90: warning: Excess function parameter 'man' description in 'amdgpu_gtt_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:90: warning: Excess function parameter 'p_size' description in 'amdgpu_gtt_mgr_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c:134: warning: Excess function parameter 'man' description in 'amdgpu_gtt_mgr_fini'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:675: warning: Excess function parameter 'dev' description in 'amdgpu_device_asic_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:675: warning: Excess function parameter 'dev' description in 'amdgpu_device_asic_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:675: warning: Excess function parameter 'dev' description in 'amdgpu_device_asic_init'
>         ./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:675: warning: Excess function parameter 'dev' description in 'amdgpu_device_asic_init'
>
> They're related to the repacement of some parameters by adev,
> and due to a few renamed parameters.
>
> While here, uniform the name of the parameter for it to be
> the same on all functions using a pointer to struct amdgpu_device.
>
> Update the kernel-doc documentation accordingly.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 28 ++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c  |  6 ++---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c |  7 +++--
>  3 files changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e8b41756c9f9..f8785bdec79c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -705,7 +705,7 @@ void amdgpu_device_indirect_wreg64(struct amdgpu_device *adev,
>  /**
>   * amdgpu_invalid_rreg - dummy reg read function
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   * @reg: offset of register
>   *
>   * Dummy register read function.  Used for register blocks
> @@ -722,7 +722,7 @@ static uint32_t amdgpu_invalid_rreg(struct amdgpu_device *adev, uint32_t reg)
>  /**
>   * amdgpu_invalid_wreg - dummy reg write function
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   * @reg: offset of register
>   * @v: value to write to the register
>   *
> @@ -739,7 +739,7 @@ static void amdgpu_invalid_wreg(struct amdgpu_device *adev, uint32_t reg, uint32
>  /**
>   * amdgpu_invalid_rreg64 - dummy 64 bit reg read function
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   * @reg: offset of register
>   *
>   * Dummy register read function.  Used for register blocks
> @@ -756,7 +756,7 @@ static uint64_t amdgpu_invalid_rreg64(struct amdgpu_device *adev, uint32_t reg)
>  /**
>   * amdgpu_invalid_wreg64 - dummy reg write function
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   * @reg: offset of register
>   * @v: value to write to the register
>   *
> @@ -773,7 +773,7 @@ static void amdgpu_invalid_wreg64(struct amdgpu_device *adev, uint32_t reg, uint
>  /**
>   * amdgpu_block_invalid_rreg - dummy reg read function
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   * @block: offset of instance
>   * @reg: offset of register
>   *
> @@ -793,7 +793,7 @@ static uint32_t amdgpu_block_invalid_rreg(struct amdgpu_device *adev,
>  /**
>   * amdgpu_block_invalid_wreg - dummy reg write function
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   * @block: offset of instance
>   * @reg: offset of register
>   * @v: value to write to the register
> @@ -813,7 +813,7 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_device *adev,
>  /**
>   * amdgpu_device_asic_init - Wrapper for atom asic_init
>   *
> - * @dev: drm_device pointer
> + * @adev: amdgpu_device pointer
>   *
>   * Does any asic specific work and then calls atom asic init.
>   */
> @@ -827,7 +827,7 @@ static int amdgpu_device_asic_init(struct amdgpu_device *adev)
>  /**
>   * amdgpu_device_vram_scratch_init - allocate the VRAM scratch page
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   *
>   * Allocates a scratch page of VRAM for use by various things in the
>   * driver.
> @@ -844,7 +844,7 @@ static int amdgpu_device_vram_scratch_init(struct amdgpu_device *adev)
>  /**
>   * amdgpu_device_vram_scratch_fini - Free the VRAM scratch page
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   *
>   * Frees the VRAM scratch page.
>   */
> @@ -3011,7 +3011,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>  /**
>   * amdgpu_device_has_dc_support - check if dc is supported
>   *
> - * @adev: amdgpu_device_pointer
> + * @adev: amdgpu_device pointer
>   *
>   * Returns true for supported, false for not supported
>   */
> @@ -4045,7 +4045,7 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
>  /**
>   * amdgpu_device_reset_sriov - reset ASIC for SR-IOV vf
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   * @from_hypervisor: request from hypervisor
>   *
>   * do VF FLR and reinitialize Asic
> @@ -4100,7 +4100,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  /**
>   * amdgpu_device_has_job_running - check if there is any job in mirror list
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   *
>   * check if there is any job in mirror list
>   */
> @@ -4128,7 +4128,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>  /**
>   * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   *
>   * Check amdgpu_gpu_recovery and SRIOV status to see if we should try to recover
>   * a hung GPU.
> @@ -4477,7 +4477,7 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
>  /**
>   * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>   *
> - * @adev: amdgpu device pointer
> + * @adev: amdgpu_device pointer
>   * @job: which job trigger hang
>   *
>   * Attempt to reset the GPU if it has hung (all asics).
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index f203e4a6a3f2..731f3aa2e6ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -81,8 +81,8 @@ static const struct ttm_resource_manager_func amdgpu_gtt_mgr_func;
>  /**
>   * amdgpu_gtt_mgr_init - init GTT manager and DRM MM
>   *
> - * @man: TTM memory type manager
> - * @p_size: maximum size of GTT
> + * @adev: amdgpu_device pointer
> + * @gtt_size: maximum size of GTT
>   *
>   * Allocate and initialize the GTT manager.
>   */
> @@ -123,7 +123,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
>  /**
>   * amdgpu_gtt_mgr_fini - free and destroy GTT manager
>   *
> - * @man: TTM memory type manager
> + * @adev: amdgpu_device pointer
>   *
>   * Destroy and free the GTT manager, returns -EBUSY if ranges are still
>   * allocated inside it.
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 01c1171afbe0..0c6b7c5ecfec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -168,8 +168,7 @@ static const struct ttm_resource_manager_func amdgpu_vram_mgr_func;
>  /**
>   * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
>   *
> - * @man: TTM memory type manager
> - * @p_size: maximum size of VRAM
> + * @adev: amdgpu_device pointer
>   *
>   * Allocate and initialize the VRAM manager.
>   */
> @@ -199,7 +198,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
>  /**
>   * amdgpu_vram_mgr_fini - free and destroy VRAM manager
>   *
> - * @man: TTM memory type manager
> + * @adev: amdgpu_device pointer
>   *
>   * Destroy and free the VRAM manager, returns -EBUSY if ranges are still
>   * allocated inside it.
> @@ -229,7 +228,7 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
>  /**
>   * amdgpu_vram_mgr_vis_size - Calculate visible node size
>   *
> - * @adev: amdgpu device structure
> + * @adev: amdgpu_device pointer
>   * @node: MM node structure
>   *
>   * Calculate how many bytes of the MM node are inside visible VRAM
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
