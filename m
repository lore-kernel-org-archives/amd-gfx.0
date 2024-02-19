Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D35BC48BC3
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Feb 2024 15:47:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C327110E329;
	Mon, 19 Feb 2024 15:47:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S+oR9gnM";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDDAA10E329
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 15:47:20 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4126aa42402so3474815e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Feb 2024 07:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708357639; x=1708962439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LcdIZEsWJu0XCmV8SuZ3Ud5us2cfz4lBoUaPohpFdN0=;
 b=S+oR9gnMIe1FOseLaX4SC4qgsgbblt6vU/SqLPP3utmcESeJ8BZlMwOGpISdm++v3x
 W0eMng3+mNYl+xRb+7Nj+gVuEEuKhh2Fheem8d8+AslqVuqUZNTWT6EdUvrYg5AJ7YK7
 qE7j6lE72GL8C2srxvqVR9mVy3X+gYoIQVyT0V756UR1e+5m/wTDiau6QGTIitShjEiM
 8hhuoJMsj5YlS+Gv7z6aupv4r2lM0SskKCsnEXwtMVzuFE65exp9om26m6Dm8gr56n68
 RKr9o/vsHiSlOTLmoug+1nAnYMGmW+yUSY6jLeJvxAHUv+MYtNlMSb3K9LfhoWdH5c0K
 AW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708357639; x=1708962439;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LcdIZEsWJu0XCmV8SuZ3Ud5us2cfz4lBoUaPohpFdN0=;
 b=d/2Og2kXOhBslIqVxMmf72tY7IxRea6mfsiENCaQDlxCophMQRdP19qThYsuNjt4Ws
 kKRDrtQvuZzoFQP3i6tP3WeQwevbVNtsgLCki7Y1UEheGvgFMsP6WpEtNaokM6VXtx90
 7ea6xVpzSKY5aZt3zLW4GNW797VNkxzPDrx72hLsrZsfzSF/PpK6Q7CjbRQaTa9i9b9A
 XxF+PmySdPY1UK8SytoOsNtQmxrT7N74gR9FH6HHu2NUtCJ3HGJ/8nYgE9TSxzFtZjSN
 dqFO+S2Upwmd6nETidi1+HZ98eBQDhDRtUx5K6DEg0rgqYrfRdyeWSP9BFjWsLixVm8f
 bOoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv6xUHa6+GpiQCPXen1NKRNHJOwb3MwEDYqDxVTODhPO3DBEqBeNOY4hAXGA5NSPP94Hvm9CbvUV8UGPZaOXPkiX726rGjmS5OPr1wlA==
X-Gm-Message-State: AOJu0YxC6h6674BcnZSta7xoUqlFeL6fOs4riHxMvWdhc7mrePL31N7G
 fnaRhkYXCZe0kSxy3D+XD2U63K3lASIAnc48QOVVZryYA81PkX/I
X-Google-Smtp-Source: AGHT+IH2LNjJtDoYmxvkbkuzDATkPJA0Y4OHB2h0ujbYeBBgprtSd7VrX2H7U/y3qguoaJS0U6BN2w==
X-Received: by 2002:a5d:5402:0:b0:33d:3b19:a2c3 with SMTP id
 g2-20020a5d5402000000b0033d3b19a2c3mr3604220wrv.57.1708357638708; 
 Mon, 19 Feb 2024 07:47:18 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 h15-20020adffa8f000000b0033b75d0993esm10708606wrr.74.2024.02.19.07.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 07:47:18 -0800 (PST)
Message-ID: <98eae052-f616-487b-a462-ae9eb15361eb@gmail.com>
Date: Mon, 19 Feb 2024 16:47:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: add new accessors for GPU reset-affected
 critcal sections
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240216151322.473527-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240216151322.473527-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 16.02.24 um 16:13 schrieb Alex Deucher:
> Provide helper functions for code which needs to be mutually
> exclusive with GPU resets.  While we are here, move
> amdgpu_in_reset in amdgpu_reset.c since that is the more
> logical location for it and add documentation.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 -
>   .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |  1 +
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 --
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     | 86 +++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |  6 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  1 +
>   drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  1 +
>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  1 +
>   drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        |  1 +
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  1 +
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  1 +
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
>   .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  1 +
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
>   .../drm/amd/pm/powerplay/inc/amd_powerplay.h  |  1 +
>   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 +
>   .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 +
>   .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 +
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  1 +
>   33 files changed, 121 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9246bca0a008..0e365cadcc3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1602,8 +1602,6 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
>          return adev->gmc.tmz_enabled;
>   }
>   
> -int amdgpu_in_reset(struct amdgpu_device *adev);
> -
>   extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>   extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
>   extern const struct attribute_group amdgpu_flash_attr_group;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 69810b3f1c63..78bec0b6c502 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -22,6 +22,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_amdkfd_gfx_v10.h"
> +#include "amdgpu_reset.h"
>   #include "gc/gc_10_1_0_offset.h"
>   #include "gc/gc_10_1_0_sh_mask.h"
>   #include "athub/athub_2_0_0_offset.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> index ca4a6b82817f..717a6d10b01c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
> @@ -22,6 +22,7 @@
>   
>   #include "amdgpu.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_reset.h"
>   #include "cikd.h"
>   #include "cik_sdma.h"
>   #include "gfx_v7_0.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> index 0f3e2944edd7..d08e9c308835 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
> @@ -22,6 +22,7 @@
>   
>   #include "amdgpu.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_reset.h"
>   #include "gfx_v8_0.h"
>   #include "gca/gfx_8_0_sh_mask.h"
>   #include "gca/gfx_8_0_d.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 5a35a8ca8922..b0ff1065491e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -21,6 +21,7 @@
>    */
>   #include "amdgpu.h"
>   #include "amdgpu_amdkfd.h"
> +#include "amdgpu_reset.h"
>   #include "gc/gc_9_0_offset.h"
>   #include "gc/gc_9_0_sh_mask.h"
>   #include "vega10_enum.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index e2ae9ba147ba..0eed6bb213b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -27,6 +27,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_sched.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>   #include <linux/nospec.h>
>   
>   #define to_amdgpu_ctx_entity(e)	\
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1ef892bea488..ab0e0f416584 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -6283,11 +6283,6 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
>   	amdgpu_asic_invalidate_hdp(adev, ring);
>   }
>   
> -int amdgpu_in_reset(struct amdgpu_device *adev)
> -{
> -	return atomic_read(&adev->reset_domain->in_gpu_reset);
> -}
> -
>   /**
>    * amdgpu_device_halt() - bring hardware to some kind of halt state
>    *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index e114694d1131..9a6e7f401f9d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -28,6 +28,7 @@
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_rlc.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_xcp.h"
>   #include "amdgpu_xgmi.h"
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index 3c2b1413058b..f3092a86d3a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -41,6 +41,7 @@
>   #include "psp_v14_0.h"
>   
>   #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_securedisplay.h"
>   #include "amdgpu_atomfirmware.h"
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index 4baa300121d8..d1421bdb7f48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -162,6 +162,92 @@ void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain)
>   	up_write(&reset_domain->sem);
>   }
>   
> +/**
> + * amdgpu_in_reset() - check if we are in a GPU reset
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * Check if we are in a GPU reset.  This function should only
> + * be used by functions that are part of the GPU reset sequence
> + * and recovery.  If functions want to be mutually exclusive
> + * with GPU resets they should enclose the relevant code in
> + * amdgpu_reset_domain_access_read_start() and
> + * amdgpu_reset_domain_access_read_end() or
> + * amdgpu_reset_domain_access_write_start() and
> + * amdgpu_reset_domain_access_write_end().
> + *
> + */
> +int amdgpu_in_reset(struct amdgpu_device *adev)
> +{
> +	return atomic_read(&adev->reset_domain->in_gpu_reset);
> +}
> +
> +/**
> + * amdgpu_reset_domain_access_read_start - call before accessing stuff that
> + *                                         might be affected by a GPU reset
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * This function should be called before read access to anything that would
> + * be affected by a GPU reset. It must be paired with
> + * amdgpu_reset_domain_access_read_end().
> + *
> + * Returns any errors for taking the reset semaphore for reading.
> + */
> +int amdgpu_reset_domain_access_read_start(struct amdgpu_device *adev)
> +{
> +	return down_read_killable(&adev->reset_domain->sem);
> +}
> +
> +/**
> + * amdgpu_reset_domain_access_read_end - call after accessing stuff that
> + *                                       might be affected by a GPU reset
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * This function should be called after read access to anything that would
> + * be affected by a GPU reset.  It must be paired with
> + * amdgpu_reset_domain_access_read_start().
> + *
> + */
> +void amdgpu_reset_domain_access_read_end(struct amdgpu_device *adev)
> +{
> +	up_read(&adev->reset_domain->sem);
> +}

Well that looks really good. I'm just wondering if we could improve the 
naming of amdgpu_reset_domain_access_read_start/end() a bit.

Like maybe amdgpu_reset_domain_concurrent_access_begin/end() and 
amdgpu_reset_domain_exclusive_access_begin/end().

And at least for _start (or _begin) I think we should add a __must_check 
annotation to get a compiler warning if you ignore the result.

Regards,
Christian.

> +
> +/**
> + * amdgpu_reset_domain_access_write_start - call before accessing stuff that
> + *                                          might be affected by a GPU reset
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * This function should be called before write access to anything that would
> + * be affected by a GPU reset. It must be paired with
> + * amdgpu_reset_domain_access_write_end().
> + *
> + * Returns any errors for taking the reset semaphore for reading.
> + */
> +int amdgpu_reset_domain_access_write_start(struct amdgpu_device *adev)
> +{
> +	return down_write_killable(&adev->reset_domain->sem);
> +}
> +
> +/**
> + * amdgpu_reset_domain_access_write_end - call after accessing stuff that
> + *                                        might be affected by a GPU reset
> + *
> + * @adev: amdgpu_device pointer
> + *
> + * This function should be called after write access to anything that would
> + * be affected by a GPU reset.  It must be paired with
> + * amdgpu_reset_domain_access_write_start().
> + *
> + */
> +void amdgpu_reset_domain_access_write_end(struct amdgpu_device *adev)
> +{
> +	up_write(&adev->reset_domain->sem);
> +}
> +
>   #ifndef CONFIG_DEV_COREDUMP
>   void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
>   		     struct amdgpu_reset_context *reset_context)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 19899f6b9b2b..b0385cc35a80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -140,6 +140,12 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
>   
>   void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
>   
> +int amdgpu_in_reset(struct amdgpu_device *adev);
> +int amdgpu_reset_domain_access_read_start(struct amdgpu_device *adev);
> +void amdgpu_reset_domain_access_read_end(struct amdgpu_device *adev);
> +int amdgpu_reset_domain_access_write_start(struct amdgpu_device *adev);
> +void amdgpu_reset_domain_access_write_end(struct amdgpu_device *adev);
> +
>   void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
>   		     struct amdgpu_reset_context *reset_context);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 75c9fd2c6c2a..8a878c0fcaa4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -56,6 +56,7 @@
>   #include "amdgpu_amdkfd.h"
>   #include "amdgpu_sdma.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_hmm.h"
>   #include "amdgpu_atomfirmware.h"
>   #include "amdgpu_res_cursor.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index 0867fd9e15ba..8945f9347ae3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -26,6 +26,7 @@
>   #include <linux/module.h>
>   
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_ucode.h"
>   
>   static void amdgpu_ucode_print_common_hdr(const struct common_firmware_header *hdr)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> index 6ff7d3fb2008..4a43505b53f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -32,6 +32,7 @@
>   
>   #include "amdgpu.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>   #include "vi.h"
>   #include "soc15.h"
>   #include "nv.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> index d6f808acfb17..114bf1178f0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> +++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
> @@ -25,6 +25,7 @@
>   
>   #include "soc15_common.h"
>   #include "amdgpu_reg_state.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_xcp.h"
>   #include "gfx_v9_4_3.h"
>   #include "gfxhub_v1_2.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index b02d63328f1c..d6caac49dac6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -29,6 +29,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_psp.h"
> +#include "amdgpu_reset.h"
>   #include "nv.h"
>   #include "nvd.h"
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 2fb1342d5bd9..de8291121a2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -28,6 +28,7 @@
>   #include "amdgpu.h"
>   #include "amdgpu_gfx.h"
>   #include "amdgpu_psp.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_smu.h"
>   #include "amdgpu_atomfirmware.h"
>   #include "imu_v11_0.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index ea174b76ee70..ce6e86a6f000 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -29,6 +29,7 @@
>   
>   #include "amdgpu.h"
>   #include "amdgpu_gfx.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_ring.h"
>   #include "vi.h"
>   #include "vi_structs.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 169d45268ef6..a590bff32f1c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -33,6 +33,7 @@
>   #include "soc15d.h"
>   #include "amdgpu_atomfirmware.h"
>   #include "amdgpu_pm.h"
> +#include "amdgpu_reset.h"
>   
>   #include "gc/gc_9_0_offset.h"
>   #include "gc/gc_9_0_sh_mask.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> index 065b2bd5f5a6..dc2a60242a0b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -30,6 +30,7 @@
>   
>   #include "gfx_v9_4_2.h"
>   #include "amdgpu_ras.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_gfx.h"
>   
>   #define SE_ID_MAX 8
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> index aace4594a603..75c1a744dee4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -24,6 +24,7 @@
>   
>   #include "amdgpu.h"
>   #include "amdgpu_gfx.h"
> +#include "amdgpu_reset.h"
>   #include "soc15.h"
>   #include "soc15d.h"
>   #include "soc15_common.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> index 6c68135cac9f..b9dae3edb26b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> @@ -26,6 +26,7 @@
>   #include <drm/drm_cache.h>
>   
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_atomfirmware.h"
>   #include "gmc_v11_0.h"
>   #include "umc_v8_10.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> index 1e5ad1e08d2a..b066da5e0d25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
> @@ -24,6 +24,7 @@
>   #include <linux/firmware.h>
>   #include <linux/module.h>
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   #include "soc15_common.h"
>   #include "nv.h"
>   #include "gc/gc_10_1_0_offset.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 26d71a22395d..0f59a7556d0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -24,6 +24,7 @@
>   #include <linux/firmware.h>
>   #include <linux/module.h>
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   #include "soc15_common.h"
>   #include "soc21.h"
>   #include "gc/gc_11_0_0_offset.h"
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> index fec5a3d1c4bc..c79e3d4e1270 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> @@ -27,6 +27,7 @@
>   #include <linux/pci.h>
>   
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_xcp.h"
>   #include "amdgpu_ucode.h"
>   #include "amdgpu_trace.h"
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index b9ac3d2f8029..41c43d9e604d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -48,6 +48,7 @@
>   #include "vid.h"
>   #include "amdgpu.h"
>   #include "amdgpu_display.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_ucode.h"
>   #include "atom.h"
>   #include "amdgpu_dm.h"
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index e23a0a276e33..116726c2ec1b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -28,6 +28,7 @@
>   
>   #include "dc.h"
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_dm_psr.h"
>   #include "amdgpu_dm_replay.h"
>   #include "amdgpu_dm_crtc.h"
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 087d57850304..8d7d6a507d3a 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -27,6 +27,7 @@
>   #include "amdgpu_drv.h"
>   #include "amdgpu_pm.h"
>   #include "amdgpu_dpm.h"
> +#include "amdgpu_reset.h"
>   #include "atom.h"
>   #include <linux/pci.h>
>   #include <linux/hwmon.h>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h b/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
> index fe3665965416..8fb624a03bde 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
> @@ -31,5 +31,6 @@
>   #include "dm_pp_interface.h"
>   #include "kgd_pp_interface.h"
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   
>   #endif /* _AMD_POWERPLAY_H_ */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index eedb9a4f7e2d..b2fb822156c3 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -28,6 +28,7 @@
>   #include <linux/reboot.h>
>   
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_smu.h"
>   #include "smu_internal.h"
>   #include "atom.h"
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 4cd43bbec910..d534ad6710ab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -26,6 +26,7 @@
>   #include <linux/firmware.h>
>   #include "amdgpu.h"
>   #include "amdgpu_dpm.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_smu.h"
>   #include "atomfirmware.h"
>   #include "amdgpu_atomfirmware.h"
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index f1440869d1ce..b6ef8925922c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -26,6 +26,7 @@
>   #include <linux/firmware.h>
>   #include "amdgpu.h"
>   #include "amdgpu_dpm.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_smu.h"
>   #include "atomfirmware.h"
>   #include "amdgpu_atomfirmware.h"
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 29c102fe650d..bc58b8e67819 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -25,6 +25,7 @@
>   
>   #include <linux/firmware.h>
>   #include "amdgpu.h"
> +#include "amdgpu_reset.h"
>   #include "amdgpu_smu.h"
>   #include "atomfirmware.h"
>   #include "amdgpu_atomfirmware.h"

