Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2F8C48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 06:54:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573AE10E161;
	Thu,  8 Feb 2024 06:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P+8mjdMv";
	dkim-atps=neutral
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com
 [209.85.167.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F77010E161
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 06:54:25 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-5116643c64eso2700167e87.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Feb 2024 22:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707375263; x=1707980063; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EnqgeTy7PrN/doXXMyNubLfmfwiC/16gIhO8H42kHvY=;
 b=P+8mjdMvSld83BbMdBh6QZmnX768TCp8wC/LV6FdSWynalblxW2EY9Sz6AaBLolzQm
 bIyG4g52Stx7nkm8kWKDGxlDLWqZ1jNjdl/n9YRqSv9OZZmV5rUt2/eud5kOFL/A+CAb
 ePL8VCCUMWw9fOMm7IesCI75Cor2aZNEKzTZUmOUzNEulNtSa2rUjBruSyZ+M6mpRLqw
 xQ3zOREyxo7KPoZ8wsD+00MrMxUacqNnJP8H+iMCbg4gqCQ8F+Bu6AtcTy69quzawDai
 KkZLBrvcMm+//JWRzMwLpN+q/GPmYSfpLTcmXZkjflTJ/2v5b0HrIHqq4Z4GrcOja36I
 UFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707375263; x=1707980063;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EnqgeTy7PrN/doXXMyNubLfmfwiC/16gIhO8H42kHvY=;
 b=E02fF/mg7G807TqGJqTLSKXNfiV1P5F6e5uMOiAEjFWS7pB97d+jgov9GXlDcU8ZsO
 EZEhCenXnOPn8PL4IY+WIBQSaSpiiSaYfu2wR1eHFHQ8D9LuOVRDIXHH7TVYlT71I+zQ
 7RUDTTGAHoE/p/UnQK581TQOqEVeWzPpLWO5vISgmE98m2IfqMxz6TEzt5j7zvwOlnIU
 O3ynZWZNpn5RG55A8iJdxgZnQ1IQldjo/WZXQHLqK8Z0+iTEFi24n+6QTWuyYJm12mye
 sl/7jaTIGjLWIuVETJFEgJzRJSF8k7dMkLTH3JwMWHJUvi6R5XAru1hwsKlt7Zoka6je
 3R2g==
X-Gm-Message-State: AOJu0YzEWTr0FHnu6UTrGzPswc6lUbBPPcq7f75r8mLfUr+WlJoPrjPd
 eDJZH7Ad94SldH/kBBtzbMSxEVRXHmMmYpT5qsgowE6UJ8ktJF0D
X-Google-Smtp-Source: AGHT+IGXtu/SZTvcZjZgZs3w3Q2uZxaTs7bNjlmby9rAQ6jaCLsTwnQBJmgNaKQJ037k0CgWUYFmuA==
X-Received: by 2002:ac2:42d5:0:b0:511:5936:c87b with SMTP id
 n21-20020ac242d5000000b005115936c87bmr5015543lfl.15.1707375263261; 
 Wed, 07 Feb 2024 22:54:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVi+T5LoNJsHYdxNFr8T1oHdZNjHtX0Vl+IHOiDV78jPMKBxEoejeW0NJs7oF99pUkEHcfJU/v6guueJeEwCktPZxNIJ0tHcFr9kTRpqw==
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 jg25-20020a05600ca01900b00410219f126bsm690971wmb.37.2024.02.07.22.54.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 22:54:22 -0800 (PST)
Message-ID: <b2d9c463-19f8-40d0-86ca-37e500634b9d@gmail.com>
Date: Thu, 8 Feb 2024 07:54:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/amd: Drop unneeded functions to check if
 s3/s0ix active
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240208055256.130917-1-mario.limonciello@amd.com>
 <20240208055256.130917-3-mario.limonciello@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240208055256.130917-3-mario.limonciello@amd.com>
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

Am 08.02.24 um 06:52 schrieb Mario Limonciello:
> amdgpu_acpi_is_s0ix_active() and amdgpu_acpi_is_s0ix_active() aren't
> needed to be checked multiple times in a suspend cycle.  Checking and
> setting up policy one time in the prepare() callback is sufficient.

Mhm, looking at amdgpu_acpi_is_s3_active() I think we should not cache 
that in a variable in the first place.

Just calling the function all the time to check the state should be 
sufficient, or do we then run into any state transition problems?

Regards,
Christian.

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v4: New patch
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 ----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  7 +++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 17 ++---------------
>   3 files changed, 5 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index f6c38a974bae..53823539eba5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1545,12 +1545,8 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
>   #endif
>   
>   #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
> -bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
> -bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
>   #else
> -static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
> -static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
>   static void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index cc21ed67a330..1d58728f8c3f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1366,8 +1366,7 @@ bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
>   	    adev->gfx.imu.funcs) /* Not need to do mode2 reset for IMU enabled APUs */
>   		return false;
>   
> -	if ((adev->flags & AMD_IS_APU) &&
> -	    amdgpu_acpi_is_s3_active(adev))
> +	if ((adev->flags & AMD_IS_APU) && adev->in_s3)
>   		return false;
>   
>   	if (amdgpu_sriov_vf(adev))
> @@ -1472,7 +1471,7 @@ void amdgpu_acpi_release(void)
>    *
>    * returns true if supported, false if not.
>    */
> -bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
> +static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>   {
>   	return !(adev->flags & AMD_IS_APU) ||
>   		(pm_suspend_target_state == PM_SUSPEND_MEM);
> @@ -1485,7 +1484,7 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>    *
>    * returns true if supported, false if not.
>    */
> -bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
> +static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>   {
>   	if (!(adev->flags & AMD_IS_APU) ||
>   	    (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 971acf01bea6..2bc4c5bb9b5a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2456,13 +2456,6 @@ static int amdgpu_pmops_prepare(struct device *dev)
>   	    pm_runtime_suspended(dev))
>   		return 1;
>   
> -	/* if we will not support s3 or s2i for the device
> -	 *  then skip suspend
> -	 */
> -	if (!amdgpu_acpi_is_s0ix_active(adev) &&
> -	    !amdgpu_acpi_is_s3_active(adev))
> -		return 1;
> -
>   	return amdgpu_device_prepare(drm_dev);
>   }
>   
> @@ -2476,10 +2469,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
>   	struct drm_device *drm_dev = dev_get_drvdata(dev);
>   	struct amdgpu_device *adev = drm_to_adev(drm_dev);
>   
> -	if (amdgpu_acpi_is_s0ix_active(adev))
> -		adev->in_s0ix = true;
> -	else if (amdgpu_acpi_is_s3_active(adev))
> -		adev->in_s3 = true;
>   	if (!adev->in_s0ix && !adev->in_s3)
>   		return 0;
>   	return amdgpu_device_suspend(drm_dev, true);
> @@ -2510,10 +2499,8 @@ static int amdgpu_pmops_resume(struct device *dev)
>   		adev->no_hw_access = true;
>   
>   	r = amdgpu_device_resume(drm_dev, true);
> -	if (amdgpu_acpi_is_s0ix_active(adev))
> -		adev->in_s0ix = false;
> -	else
> -		adev->in_s3 = false;
> +	adev->in_s0ix = adev->in_s3 = false;
> +
>   	return r;
>   }
>   

