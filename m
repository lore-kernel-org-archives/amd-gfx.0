Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41FBCCD1284
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 11:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79F7210F015;
	Thu, 11 Apr 2024 11:17:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H4zVwN1W";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B30910F015
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 11:17:15 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-417d14b39ebso4505325e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 04:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712834234; x=1713439034; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hCW0pIh2JiUm/YhNcagCDPDBhxejKrIv3G4om5i/KsY=;
 b=H4zVwN1Wr6fhgSHptZamOue5o/hFVyVe/BzWD1Snx8ovj0CUyr/Ix5HNZQnpcKgzuq
 j7dq3tFjXBzhhC1l9xdAiSDDQ/zdLS8fW16+VYu+LMDVM12kA0ilaNT9fOmyG+tfEAkK
 bRCsyFdB1SXaZoW+ajEuLmBkU5GDktloDDv1z3LIkXPy54Td2hBtxHCYpqe8Np1a6MYC
 gq/QAKR1Xjf4ndIyT2FfP2Bd1UYylnNgdIeegqXFw+e1EDxqGVfK8+RidO6wMf/bPy7z
 bx+SQ16oiSNVtRmjId4jZ8vUOcTalL7DuyZV5WmV7c6ksn76/TeSuOv5noe3/qilH7J7
 +MeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712834234; x=1713439034;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hCW0pIh2JiUm/YhNcagCDPDBhxejKrIv3G4om5i/KsY=;
 b=sJKCo4YBb4+zI77/0XJbEDv8nb7XgBJo9b6cJBO8zozsfsSCwD5phAd93cuIME2c0O
 x0ReKbOXsV/cPn9W/M45C8wwj08sIP+t4zmSWHBYN2MF8tPKBYP1VynbLEFDV0IiQr0e
 KHoz6KzTDP4b49f0a78nEaIlv84Jef2oiNE3tH/8knx7V4zQVPEaPGfrW/rgj5QFetV+
 rp4rrmDF5Z2Km2hIE0itJ+eCoMQxLtfmT0/D156IaKG38ItfV6J/Gh1/x8+e44aqxPfJ
 AM6pIOyisocBIomkUGCH4j6a8vVSXolQQs3/pxli5In324KL9dMn+qog3LHgV9+bOwiP
 wBPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXemA+PBWx70lAPY1cDogoDXwpFr23gURHiPA1nvRTzPPBn+3wHI75nqzYFX1snKXRD4dGigrTEC3+A4FgVv+gHQYlukpYSeG51mHOUmQ==
X-Gm-Message-State: AOJu0YyJ4BT8BuQA3bRLYOUj//ljMv58RONwvuIdu/ZLOmtFfJ59N+hR
 ZYfXo3o24WoKm0m1wz3iqv3/XsATUAavdoRtDYPJSSuQuBRSPeWKdVtq9tMK
X-Google-Smtp-Source: AGHT+IGdrmoLpQhH7HvVpw4bwUSe3kk/8Qy0Q9WONJ3vbUmLbgHHPvEuDrDQDcRRVNmvrJg90hOM4Q==
X-Received: by 2002:a05:600c:5104:b0:413:3941:d9ae with SMTP id
 o4-20020a05600c510400b004133941d9aemr4027806wms.31.1712834233506; 
 Thu, 11 Apr 2024 04:17:13 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a05600c350800b0041488978873sm5150916wmq.44.2024.04.11.04.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 04:17:12 -0700 (PDT)
Message-ID: <743be31c-0edc-4fb5-ae4f-694de64481c6@gmail.com>
Date: Thu, 11 Apr 2024 13:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Review 1/1] drm/amdgpu: Support setting recover method
To: "Stanley.Yang" <Stanley.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240411111108.3571355-1-Stanley.Yang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240411111108.3571355-1-Stanley.Yang@amd.com>
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

Am 11.04.24 um 13:11 schrieb Stanley.Yang:
> Don't modify amdgpu gpu recover get operation,
> add amdgpu gpu recover set operation to select
> reset method, only support mode1 and mode2 currently.

Well I don't think setting this from userspace is valid.

The reset method to use is determined by the hardware and environment 
(e.g. SRIOV, passthrough, whatever) and can't be chosen simply.

Regards,
Christian.

>
> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 37 +++++++++++++++++++---
>   3 files changed, 37 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9c62552bec34..c82976b2b977 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1151,6 +1151,9 @@ struct amdgpu_device {
>   	bool                            debug_largebar;
>   	bool                            debug_disable_soft_recovery;
>   	bool                            debug_use_vram_fw_buf;
> +
> +	/* Used to set gpu reset method */
> +	int                             recover_method;
>   };
>   
>   static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3204b8f6edeb..8411a793be18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3908,6 +3908,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>   	else
>   		adev->asic_type = flags & AMD_ASIC_MASK;
>   
> +	adev->recover_method = AMD_RESET_METHOD_NONE;
>   	adev->usec_timeout = AMDGPU_MAX_USEC_TIMEOUT;
>   	if (amdgpu_emu_mode == 1)
>   		adev->usec_timeout *= 10;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 10832b470448..e388a50d11d9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -965,9 +965,37 @@ static int gpu_recover_get(void *data, u64 *val)
>   	return 0;
>   }
>   
> +static int gpu_recover_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
> +	struct drm_device *dev = adev_to_drm(adev);
> +	int r;
> +
> +	/* TODO: support mode1 and mode2 currently */
> +	if (val == AMD_RESET_METHOD_MODE1 ||
> +		val == AMD_RESET_METHOD_MODE2)
> +		adev->recover_method = val;
> +	else
> +		adev->recover_method = AMD_RESET_METHOD_NONE;
> +
> +	r = pm_runtime_get_sync(dev->dev);
> +	if (r < 0) {
> +		pm_runtime_put_autosuspend(dev->dev);
> +		return 0;
> +	}
> +
> +	if (amdgpu_reset_domain_schedule(adev->reset_domain, &adev->reset_work))
> +		flush_work(&adev->reset_work);
> +
> +	pm_runtime_mark_last_busy(dev->dev);
> +	pm_runtime_put_autosuspend(dev->dev);
> +
> +	return 0;
> +}
> +
>   DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
> -DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
> -			 "%lld\n");
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get,
> +			 gpu_recover_set, "%lld\n");
>   
>   static void amdgpu_debugfs_reset_work(struct work_struct *work)
>   {
> @@ -978,9 +1006,10 @@ static void amdgpu_debugfs_reset_work(struct work_struct *work)
>   
>   	memset(&reset_context, 0, sizeof(reset_context));
>   
> -	reset_context.method = AMD_RESET_METHOD_NONE;
> +	reset_context.method = adev->recover_method;
>   	reset_context.reset_req_dev = adev;
>   	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
> +	adev->recover_method = AMD_RESET_METHOD_NONE;
>   
>   	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>   }
> @@ -999,7 +1028,7 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
>   	if (!amdgpu_sriov_vf(adev)) {
>   
>   		INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
> -		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
> +		debugfs_create_file("amdgpu_gpu_recover", 0666, root, adev,
>   				    &amdgpu_debugfs_gpu_recover_fops);
>   	}
>   #endif

