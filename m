Return-Path: <SRS0=8BU1=C7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30DCC4363D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 15:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F4F820936
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2020 15:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jwBaIWip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4F820936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F9089DCF;
	Tue, 22 Sep 2020 15:20:29 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79D389DCF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 15:20:24 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id y15so3756216wmi.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2020 08:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xfe8gsz4SU0oayDctf6CQ7abpUnQfPEBWtB3lUwlNLc=;
 b=jwBaIWip7SbyiVA0lMIPvVREy/hjkmxLKIurwR2uFhBf3tR6HGQFwPZvWrqUZkJ+2X
 LcJUNmi2DZ+OgtkxjafWHW9K35i7R0ReV/biMaxoq6LcFgvJ7ngiZOIlY1ZtmLGHCEm+
 /tuc0cH8Cxv0r7pZYX3FJJOog4PTS4qihtX77XJ6LcDjd/jlCEjwlQwgEeB68rMruZBP
 RE9DjAM7KnVdcpNRxZGqaWK5YRvMjS+BHDDXc/qNCJuKY5Xkitr+YdLcShoqMFOCIHoV
 tSDQbDHhoGp2ggZEfCe5SijLSI4Qczlfbc1qI2ObyADlJVdmqjaCIXentwvzaptjfqWA
 Vrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xfe8gsz4SU0oayDctf6CQ7abpUnQfPEBWtB3lUwlNLc=;
 b=LbDZXM97pREiHu2V97bo3+/1MboVrhuzkYHq8S2w0TX65vpsLIa1bEIFgYaQwjRO+S
 OGq6dLlzsPmUuS1lqVtUHwBtgjTPednMmaMcCJsSHfmMzIiyc5rlw3gc9AXslJVyvUR/
 7Hzyzp+2XqDH4jdkYDxNoUos1ZZeCL0/vLXeIIqU6G5o++yBnVKM/Mj+13BXK4PWnXL6
 BIqIf3+eWfRahvstO+Xki/xg/d7osj44Cq8Jze2UUH+PyQlTlPHmWGp2+1hvL71SU+63
 VghgxDFE56Ilv8wg0fc74ZI9hIN/dQ8cMSQcR/g7J+emcjA+z1ExkBRUJ4RxdzLLYO6r
 wYdw==
X-Gm-Message-State: AOAM533exERbTfOZbmQPl1EZMCINOGOduuaOoCxH/QHu1Vr0GJSLQLWU
 HUYiPGZw89ZgwBhfLP25rRy/+7uY8r84oO+ZzlYwOEip
X-Google-Smtp-Source: ABdhPJyl9snqLU75LOXAHD6Q/0uyB74WbsR/ZXqMPOaOOx593/UidFJK2plc8H0yeQNHGX8NatMJ7x/f1QSMOgG6Rho=
X-Received: by 2002:a1c:a953:: with SMTP id s80mr1583533wme.70.1600788023302; 
 Tue, 22 Sep 2020 08:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200921155442.7189-1-ryan.taylor@amd.com>
In-Reply-To: <20200921155442.7189-1-ryan.taylor@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 22 Sep 2020 11:20:12 -0400
Message-ID: <CADnq5_M0uAJYjiLnP9RZtE-d8OvBS6F6pN8CQgLtrvkiaPiAoQ@mail.gmail.com>
Subject: Re: [PATCH v3] amdgpu: Add initial kernel documentation for the
 amd_ip_block_type structure
To: Ryan Taylor <ryan.taylor@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 21, 2020 at 11:55 AM Ryan Taylor <ryan.taylor@amd.com> wrote:
>
> From: Ryan Taylor <Ryan.Taylor@amd.com>
>
> Added IP block section to amdgpu.rst.
> Added more documentation to amd_ip_funcs.
> Created documentation for amd_ip_block_type.
>
> v2: Provides a more detailed DOC section on IP blocks.
> v3: Clarifies the IP block list. Adds info on IP block enumeration.
>
> Signed-off-by: Ryan Taylor <ryan.taylor@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Looks good.  Feel free to commit it.

Thanks!

Alex

> ---
>  Documentation/gpu/amdgpu.rst             |  9 +++
>  drivers/gpu/drm/amd/include/amd_shared.h | 87 +++++++++++++++++-------
>  2 files changed, 71 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu.rst b/Documentation/gpu/amdgpu.rst
> index 29ca5f5feb35..57047dcb8d19 100644
> --- a/Documentation/gpu/amdgpu.rst
> +++ b/Documentation/gpu/amdgpu.rst
> @@ -70,6 +70,15 @@ Interrupt Handling
>  .. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>     :internal:
>
> +IP Blocks
> +------------------
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> +   :doc: IP Blocks
> +
> +.. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> +   :identifiers: amd_ip_block_type amd_ip_funcs
> +
>  AMDGPU XGMI Support
>  ===================
>
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index e98c84ef206f..6b8a40051f41 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -47,6 +47,40 @@ enum amd_apu_flags {
>         AMD_APU_IS_RENOIR = 0x00000008UL,
>  };
>
> +/**
> +* DOC: IP Blocks
> +*
> +* GPUs are composed of IP (intellectual property) blocks. These
> +* IP blocks provide various functionalities: display, graphics,
> +* video decode, etc. The IP blocks that comprise a particular GPU
> +* are listed in the GPU's respective SoC file. amdgpu_device.c
> +* acquires the list of IP blocks for the GPU in use on initialization.
> +* It can then operate on this list to perform standard driver operations
> +* such as: init, fini, suspend, resume, etc.
> +*
> +*
> +* IP block implementations are named using the following convention:
> +* <functionality>_v<version> (E.g.: gfx_v6_0).
> +*/
> +
> +/**
> +* enum amd_ip_block_type - Used to classify IP blocks by functionality.
> +*
> +* @AMD_IP_BLOCK_TYPE_COMMON: GPU Family
> +* @AMD_IP_BLOCK_TYPE_GMC: Graphics Memory Controller
> +* @AMD_IP_BLOCK_TYPE_IH: Interrupt Handler
> +* @AMD_IP_BLOCK_TYPE_SMC: System Management Controller
> +* @AMD_IP_BLOCK_TYPE_PSP: Platform Security Processor
> +* @AMD_IP_BLOCK_TYPE_DCE: Display and Compositing Engine
> +* @AMD_IP_BLOCK_TYPE_GFX: Graphics and Compute Engine
> +* @AMD_IP_BLOCK_TYPE_SDMA: System DMA Engine
> +* @AMD_IP_BLOCK_TYPE_UVD: Unified Video Decoder
> +* @AMD_IP_BLOCK_TYPE_VCE: Video Compression Engine
> +* @AMD_IP_BLOCK_TYPE_ACP: Audio Co-Processor
> +* @AMD_IP_BLOCK_TYPE_VCN: Video Core/Codec Next
> +* @AMD_IP_BLOCK_TYPE_MES: Micro-Engine Scheduler
> +* @AMD_IP_BLOCK_TYPE_JPEG: JPEG Engine
> +*/
>  enum amd_ip_block_type {
>         AMD_IP_BLOCK_TYPE_COMMON,
>         AMD_IP_BLOCK_TYPE_GMC,
> @@ -165,56 +199,59 @@ enum DC_DEBUG_MASK {
>  };
>
>  enum amd_dpm_forced_level;
> +
>  /**
>   * struct amd_ip_funcs - general hooks for managing amdgpu IP Blocks
> + * @name: Name of IP block
> + * @early_init: sets up early driver state (pre sw_init),
> + *              does not configure hw - Optional
> + * @late_init: sets up late driver/hw state (post hw_init) - Optional
> + * @sw_init: sets up driver state, does not configure hw
> + * @sw_fini: tears down driver state, does not configure hw
> + * @hw_init: sets up the hw state
> + * @hw_fini: tears down the hw state
> + * @late_fini: final cleanup
> + * @suspend: handles IP specific hw/sw changes for suspend
> + * @resume: handles IP specific hw/sw changes for resume
> + * @is_idle: returns current IP block idle status
> + * @wait_for_idle: poll for idle
> + * @check_soft_reset: check soft reset the IP block
> + * @pre_soft_reset: pre soft reset the IP block
> + * @soft_reset: soft reset the IP block
> + * @post_soft_reset: post soft reset the IP block
> + * @set_clockgating_state: enable/disable cg for the IP block
> + * @set_powergating_state: enable/disable pg for the IP block
> + * @get_clockgating_state: get current clockgating status
> + * @enable_umd_pstate: enable UMD powerstate
> + *
> + * These hooks provide an interface for controlling the operational state
> + * of IP blocks. After acquiring a list of IP blocks for the GPU in use,
> + * the driver can make chip-wide state changes by walking this list and
> + * making calls to hooks from each IP block. This list is ordered to ensure
> + * that the driver initializes the IP blocks in a safe sequence.
>   */
>  struct amd_ip_funcs {
> -       /** @name: Name of IP block */
>         char *name;
> -       /**
> -        * @early_init:
> -        *
> -        * sets up early driver state (pre sw_init),
> -        * does not configure hw - Optional
> -        */
>         int (*early_init)(void *handle);
> -       /** @late_init: sets up late driver/hw state (post hw_init) - Optional */
>         int (*late_init)(void *handle);
> -       /** @sw_init: sets up driver state, does not configure hw */
>         int (*sw_init)(void *handle);
> -       /** @sw_fini: tears down driver state, does not configure hw */
>         int (*sw_fini)(void *handle);
> -       /** @hw_init: sets up the hw state */
>         int (*hw_init)(void *handle);
> -       /** @hw_fini: tears down the hw state */
>         int (*hw_fini)(void *handle);
> -       /** @late_fini: final cleanup */
>         void (*late_fini)(void *handle);
> -       /** @suspend: handles IP specific hw/sw changes for suspend */
>         int (*suspend)(void *handle);
> -       /** @resume: handles IP specific hw/sw changes for resume */
>         int (*resume)(void *handle);
> -       /** @is_idle: returns current IP block idle status */
>         bool (*is_idle)(void *handle);
> -       /** @wait_for_idle: poll for idle */
>         int (*wait_for_idle)(void *handle);
> -       /** @check_soft_reset: check soft reset the IP block */
>         bool (*check_soft_reset)(void *handle);
> -       /** @pre_soft_reset: pre soft reset the IP block */
>         int (*pre_soft_reset)(void *handle);
> -       /** @soft_reset: soft reset the IP block */
>         int (*soft_reset)(void *handle);
> -       /** @post_soft_reset: post soft reset the IP block */
>         int (*post_soft_reset)(void *handle);
> -       /** @set_clockgating_state: enable/disable cg for the IP block */
>         int (*set_clockgating_state)(void *handle,
>                                      enum amd_clockgating_state state);
> -       /** @set_powergating_state: enable/disable pg for the IP block */
>         int (*set_powergating_state)(void *handle,
>                                      enum amd_powergating_state state);
> -       /** @get_clockgating_state: get current clockgating status */
>         void (*get_clockgating_state)(void *handle, u32 *flags);
> -       /** @enable_umd_pstate: enable UMD powerstate */
>         int (*enable_umd_pstate)(void *handle, enum amd_dpm_forced_level *level);
>  };
>
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
