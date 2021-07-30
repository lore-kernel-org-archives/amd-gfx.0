Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5D9C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 958EC60F12
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 02:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 958EC60F12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 582A06F393;
	Fri, 30 Jul 2021 02:17:50 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E766F393;
 Fri, 30 Jul 2021 02:17:49 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id t128so11144010oig.1;
 Thu, 29 Jul 2021 19:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qrP3xidY8Mh11P8GyD1WMtmmIqlXlinIdn0lWjm42yo=;
 b=sHq7mvXcn37j4SHeYMWk6vxoAQN9eoIw8COO88dnGtOqutD847d586ZQH5i9BRgS+c
 P/bt8FDcKFJDBLvMC5EkSk4QYaTJMTXWunos0S27BcbwIYn8XTJfkWN3shhI+NAC+Ehx
 O4NQfNVuY85DK6bgY/pBB//7966xdy3ii0LioKMHTKPdMU2BIM0Z6R/Myrr4n76/8S11
 ZfhnI+ha1XUz22MC7zxTOdaRnNje5JoF04P8Wso2lcMNgvj0+CzKqmzEyWMfYMBHd6yu
 WBtbCMTbnwjH1kUsT/bT7O0UYvaOpxCxxETBKZGpOpINjpHm028llrvzX6HJkrlfu8hD
 7YAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qrP3xidY8Mh11P8GyD1WMtmmIqlXlinIdn0lWjm42yo=;
 b=K5V/HmMueA3RJ/vEwQozPbeTjbBX+6I7tchZRtePol3Q7DfC95kx7aNthBlKHVCQ3n
 1ygbKM+8EjLMb/YWsepnJm6idqUor5TlOeIkVvM5lLMszJiWHqqluE5l38snC/kG4cpb
 DdRfMdEibqBOK6wIPG8dUyb2T1PGoV7SrsRpeOtvA2+hdFol9WQdoJ9CHw44OLvaY8tG
 50sbksXaRbPlzSnyypdVCuQI5gmblgF6IhNyDtwwLWPnBdlo6NYkpdIkqOB6ryJUCnY+
 vLjVwzEpUWVWbJZh1EBlywlKbnR8U2lg4BTxyMu/cjkYdFWMNXUAk6yxl33oyoPZdmdZ
 iquw==
X-Gm-Message-State: AOAM531tS6va9Z16i1ccoxpeVSdDNXlM7Fz9NYTxtfKxOEwlLbi4+Edi
 viMQ3GnVYeS+iAEwBywevGCx3O4c1uR6oJRtReE=
X-Google-Smtp-Source: ABdhPJxoFgVctq7V/LiC4ZvlHvmskoN91llj0GpNw2vInUp0BPFqOkc6DPjIF4AkB923tXGegLf3qkXRIECpyZlPbWE=
X-Received: by 2002:aca:53ca:: with SMTP id h193mr303215oib.5.1627611468711;
 Thu, 29 Jul 2021 19:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210729082046.1786-1-caihuoqing@baidu.com>
In-Reply-To: <20210729082046.1786-1-caihuoqing@baidu.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Jul 2021 22:17:37 -0400
Message-ID: <CADnq5_N3F=hkyZHSKd18DpoNuT_See-LKKAyw=zeSOLi8dunLQ@mail.gmail.com>
Subject: Re: [PATCH] gpu/drm/radeon: Fix typo in comments
To: Cai Huoqing <caihuoqing@baidu.com>
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
 xinhui pan <Xinhui.Pan@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Thu, Jul 29, 2021 at 4:21 AM Cai Huoqing <caihuoqing@baidu.com> wrote:
>
> Remove the repeated word 'the' from comments
>
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/gpu/drm/radeon/atombios.h      | 4 ++--
>  drivers/gpu/drm/radeon/r300_reg.h      | 2 +-
>  drivers/gpu/drm/radeon/radeon_device.c | 2 +-
>  drivers/gpu/drm/radeon/radeon_fence.c  | 2 +-
>  drivers/gpu/drm/radeon/radeon_vm.c     | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios.h b/drivers/gpu/drm/radeon/atombios.h
> index 4b86e8b45009..83e8b8547f9b 100644
> --- a/drivers/gpu/drm/radeon/atombios.h
> +++ b/drivers/gpu/drm/radeon/atombios.h
> @@ -2802,8 +2802,8 @@ ucMaxNBVoltageHigh:     Voltage regulator dependent PWM value. High 8 bits of  t
>  ucMinNBVoltageHigh:     Voltage regulator dependent PWM value. High 8 bits of the value for the min voltage.Set this one to 0x00 if VC without PWM or no VC at all.
>
>
> -usInterNBVoltageLow:    Voltage regulator dependent PWM value. The value makes the the voltage >=Min NB voltage but <=InterNBVoltageHigh. Set this to 0x0000 if VC without PWM or no VC at all.
> -usInterNBVoltageHigh:   Voltage regulator dependent PWM value. The value makes the the voltage >=InterNBVoltageLow but <=Max NB voltage.Set this to 0x0000 if VC without PWM or no VC at all.
> +usInterNBVoltageLow:    Voltage regulator dependent PWM value. The value makes the voltage >=Min NB voltage but <=InterNBVoltageHigh. Set this to 0x0000 if VC without PWM or no VC at all.
> +usInterNBVoltageHigh:   Voltage regulator dependent PWM value. The value makes the voltage >=InterNBVoltageLow but <=Max NB voltage.Set this to 0x0000 if VC without PWM or no VC at all.
>  */
>
>
> diff --git a/drivers/gpu/drm/radeon/r300_reg.h b/drivers/gpu/drm/radeon/r300_reg.h
> index 00c0d2ba22d3..60d5413bafa1 100644
> --- a/drivers/gpu/drm/radeon/r300_reg.h
> +++ b/drivers/gpu/drm/radeon/r300_reg.h
> @@ -353,7 +353,7 @@
>  #       define R300_PVS_CNTL_1_PROGRAM_START_SHIFT   0
>  #       define R300_PVS_CNTL_1_POS_END_SHIFT         10
>  #       define R300_PVS_CNTL_1_PROGRAM_END_SHIFT     20
> -/* Addresses are relative the the vertex program parameters area. */
> +/* Addresses are relative the vertex program parameters area. */
>  #define R300_VAP_PVS_CNTL_2                 0x22D4
>  #       define R300_PVS_CNTL_2_PARAM_OFFSET_SHIFT 0
>  #       define R300_PVS_CNTL_2_PARAM_COUNT_SHIFT  16
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index cec03238e14d..ac8c3251b616 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -406,7 +406,7 @@ void radeon_doorbell_free(struct radeon_device *rdev, u32 doorbell)
>
>  /*
>   * radeon_wb_*()
> - * Writeback is the the method by which the the GPU updates special pages
> + * Writeback is the method by which the GPU updates special pages
>   * in memory with the status of certain GPU events (fences, ring pointers,
>   * etc.).
>   */
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
> index 18f2c2e0dfb3..e9c47ec28ade 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -50,7 +50,7 @@
>   * for GPU/CPU synchronization.  When the fence is written,
>   * it is expected that all buffers associated with that fence
>   * are no longer in use by the associated ring on the GPU and
> - * that the the relevant GPU caches have been flushed.  Whether
> + * that the relevant GPU caches have been flushed.  Whether
>   * we use a scratch register or memory location depends on the asic
>   * and whether writeback is enabled.
>   */
> diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
> index 36a38adaaea9..bb53016f3138 100644
> --- a/drivers/gpu/drm/radeon/radeon_vm.c
> +++ b/drivers/gpu/drm/radeon/radeon_vm.c
> @@ -41,7 +41,7 @@
>   * (uncached system pages).
>   * Each VM has an ID associated with it and there is a page table
>   * associated with each VMID.  When execting a command buffer,
> - * the kernel tells the the ring what VMID to use for that command
> + * the kernel tells the ring what VMID to use for that command
>   * buffer.  VMIDs are allocated dynamically as commands are submitted.
>   * The userspace drivers maintain their own address space and the kernel
>   * sets up their pages tables accordingly when they submit their
> --
> 2.25.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
