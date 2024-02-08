Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECA8C48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 15:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6CD210E032;
	Thu,  8 Feb 2024 15:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mxmO5pQ1";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A4110E032
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 15:55:13 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-511234430a4so4056065e87.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Feb 2024 07:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707407711; x=1708012511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Br8w8H8eiZUMV3asJy11prlsdQni3i/PsDMGcD0wuzw=;
 b=mxmO5pQ1FwYqxYYQPk0D9aTJkfr2D3p7k5TNM8zltaGzlbZRsjxcd6roWq8qklX/ZF
 9/IoziriszpRnQx+O39XmyRZILMLfQy7tVfOKXhwmGLPAi84PxVN50Bk4ZfmCDYLknHp
 k0Fzh+RFPr6suflnFlUmf2VXxUcfidIEvKxTxyS8xGf6T4di8WkNJqx6Q8zgW566teLo
 TKfOi0q8DXivr4X2FuKwYEruSQYOqNsDeCIV7fMrsU0VqXORObJnLTiL4GYyMy9ysUVO
 gYly2v19vTNEaPingqcS+OQCvPWE8U4x9V+z1EggHS88EzBOXTx91pOHrPTaYLcbxmaw
 oxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707407711; x=1708012511;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Br8w8H8eiZUMV3asJy11prlsdQni3i/PsDMGcD0wuzw=;
 b=IibIyHgJXkMrn05Bi3W1pAsArgDnq25GOX3a0o3yJeSjiERiS2zyi4K7Q2x5yWsKC9
 p5ZC0G/7FRdq333saPZMTSCeJt8c0yRdnHPTTn78ALXakcWV5z9ZmRV0JB5xlMCRLTlg
 vdo0KN0OtKQCdzuuCenn5aFRJuEFjteez248ocdQ+9iWpVIzqwKpmtXvkgw6qeSzYguq
 RMyKlcfgPndvRB8XHxa7ibZYHAwaV1FuAw+FJwD+8Ju09+NMXEdn2z79d9XwVw52xzjJ
 EdazyMxuehv9VPF7FAk4jso1v1UgPq4kH0nSTAnQB/D9AYHK3KjFwK+76JFhEt4p2jjh
 xPuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIgHpxyes7CGGOrH127bTHwm42cMiGXqcBmB7zBHFpDfTrJ5oweEp4zNMV+zxy5fAmImSoy8G5+188hNARp0Dd1ueOxszY8CYwxXFKcw==
X-Gm-Message-State: AOJu0Yz3mcBy8EPeUTu94M6YgBTz8X1Kd4oyFN3cITI6RLCLQezXLM4T
 3pU4rc4y84Hm1OvzI10vIfvwG7ZsJS0KxbXJDRVT2x4FX2gNE8kyWc2SB5I1
X-Google-Smtp-Source: AGHT+IHkylFXYHaZ2FcljcUbT1EEWgoBmb+TczzbojX9szEu3ZrIKKCfmMj8gC6BwHiRAni88a+jGw==
X-Received: by 2002:ac2:4247:0:b0:511:4177:5089 with SMTP id
 m7-20020ac24247000000b0051141775089mr6139378lfl.16.1707407710391; 
 Thu, 08 Feb 2024 07:55:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXmwrputpEcePoFAhcwd8yfUTPeRtJ22V+TJsRuwVPOD3U8YN3wKj+Tn4zTBZUzUyUWZXJWBK46MvtorPoAoawwpBVy2QW5KkqbS8MLXQ==
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g16-20020adfa490000000b0033b50ed5f98sm3229261wrb.72.2024.02.08.07.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 07:55:09 -0800 (PST)
Message-ID: <44f1432f-c574-436a-8db0-1e4a12e1f28f@gmail.com>
Date: Thu, 8 Feb 2024 16:55:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/amd: Drop unneeded functions to check if
 s3/s0ix active
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240208055256.130917-1-mario.limonciello@amd.com>
 <20240208055256.130917-3-mario.limonciello@amd.com>
 <b2d9c463-19f8-40d0-86ca-37e500634b9d@gmail.com>
 <a504e189-27cd-4766-843c-579cb36ef343@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <a504e189-27cd-4766-843c-579cb36ef343@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



Am 08.02.24 um 16:04 schrieb Mario Limonciello:
> On 2/8/2024 00:54, Christian König wrote:
>> Am 08.02.24 um 06:52 schrieb Mario Limonciello:
>>> amdgpu_acpi_is_s0ix_active() and amdgpu_acpi_is_s0ix_active() aren't
>>> needed to be checked multiple times in a suspend cycle. Checking and
>>> setting up policy one time in the prepare() callback is sufficient.
>>
>> Mhm, looking at amdgpu_acpi_is_s3_active() I think we should not 
>> cache that in a variable in the first place.
>>
>> Just calling the function all the time to check the state should be 
>> sufficient, or do we then run into any state transition problems?
>
> I think calling to check it each time is perfectly fine, it should 
> never change once the sequence starts until it's over.
>
> If the first 2 patches look OK, I'd like to get those merged so we can 
> fix the regressions.  I'll do another series that can drop the cached 
> parameters.

Feel free to add my Acked-by to the series, but for ACPI stuff I would 
wait for Alex to take a look as well.

Regards,
Christian.

>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v4: New patch
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 ----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  7 +++----
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 17 ++---------------
>>>   3 files changed, 5 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index f6c38a974bae..53823539eba5 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1545,12 +1545,8 @@ static inline int 
>>> amdgpu_acpi_smart_shift_update(struct drm_device *dev,
>>>   #endif
>>>   #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
>>> -bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>>> -bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>>>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
>>>   #else
>>> -static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device 
>>> *adev) { return false; }
>>> -static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device 
>>> *adev) { return false; }
>>>   static void amdgpu_choose_low_power_state(struct amdgpu_device 
>>> *adev) { }
>>>   #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>> index cc21ed67a330..1d58728f8c3f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>>> @@ -1366,8 +1366,7 @@ bool amdgpu_acpi_should_gpu_reset(struct 
>>> amdgpu_device *adev)
>>>           adev->gfx.imu.funcs) /* Not need to do mode2 reset for IMU 
>>> enabled APUs */
>>>           return false;
>>> -    if ((adev->flags & AMD_IS_APU) &&
>>> -        amdgpu_acpi_is_s3_active(adev))
>>> +    if ((adev->flags & AMD_IS_APU) && adev->in_s3)
>>>           return false;
>>>       if (amdgpu_sriov_vf(adev))
>>> @@ -1472,7 +1471,7 @@ void amdgpu_acpi_release(void)
>>>    *
>>>    * returns true if supported, false if not.
>>>    */
>>> -bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>>> +static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device 
>>> *adev)
>>>   {
>>>       return !(adev->flags & AMD_IS_APU) ||
>>>           (pm_suspend_target_state == PM_SUSPEND_MEM);
>>> @@ -1485,7 +1484,7 @@ bool amdgpu_acpi_is_s3_active(struct 
>>> amdgpu_device *adev)
>>>    *
>>>    * returns true if supported, false if not.
>>>    */
>>> -bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>>> +static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device 
>>> *adev)
>>>   {
>>>       if (!(adev->flags & AMD_IS_APU) ||
>>>           (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 971acf01bea6..2bc4c5bb9b5a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2456,13 +2456,6 @@ static int amdgpu_pmops_prepare(struct device 
>>> *dev)
>>>           pm_runtime_suspended(dev))
>>>           return 1;
>>> -    /* if we will not support s3 or s2i for the device
>>> -     *  then skip suspend
>>> -     */
>>> -    if (!amdgpu_acpi_is_s0ix_active(adev) &&
>>> -        !amdgpu_acpi_is_s3_active(adev))
>>> -        return 1;
>>> -
>>>       return amdgpu_device_prepare(drm_dev);
>>>   }
>>> @@ -2476,10 +2469,6 @@ static int amdgpu_pmops_suspend(struct device 
>>> *dev)
>>>       struct drm_device *drm_dev = dev_get_drvdata(dev);
>>>       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>>> -    if (amdgpu_acpi_is_s0ix_active(adev))
>>> -        adev->in_s0ix = true;
>>> -    else if (amdgpu_acpi_is_s3_active(adev))
>>> -        adev->in_s3 = true;
>>>       if (!adev->in_s0ix && !adev->in_s3)
>>>           return 0;
>>>       return amdgpu_device_suspend(drm_dev, true);
>>> @@ -2510,10 +2499,8 @@ static int amdgpu_pmops_resume(struct device 
>>> *dev)
>>>           adev->no_hw_access = true;
>>>       r = amdgpu_device_resume(drm_dev, true);
>>> -    if (amdgpu_acpi_is_s0ix_active(adev))
>>> -        adev->in_s0ix = false;
>>> -    else
>>> -        adev->in_s3 = false;
>>> +    adev->in_s0ix = adev->in_s3 = false;
>>> +
>>>       return r;
>>>   }
>>
>

