Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ECAE92FF1
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 07:22:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73C9310E214;
	Fri,  6 Oct 2023 07:22:33 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B45210E214
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 07:22:32 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40566f8a093so16306945e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Oct 2023 00:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696576950; x=1697181750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Ogt/791u0Ob3lK8u1/AaAtEtesBq52g5tKRgOIYKTU=;
 b=WonQK8w0g+XhQYbNCvQXJXt2EPEbd7W58T473BQAvTjhlSxjTrShc7TC3yTIVwlsNn
 PmeXlzXUuw8drdMyzxu0qeGFkbDBdq7N3SNW6jdfOmV1h/AV6iLjA42qvnjm7uBiUKUH
 KfXWchM0NQu9kIOszKimMiQElbrNsOYMtjDIEPWphMWlhNJXxRzUE1F/YcyLrTTZL4dj
 XYXHHRLNPnCPcEvlLt9P3+irLsHPUJ+bMZheqW0bTw0+b7xWju6FEPhYGDkN1utwCX7i
 uCVYHEAKsMVCGUjA8zzPk7X2NmuR297AIBB2bW/vKkAXJUmVsdyiYIKMF+TMpxYYUDxd
 49YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696576950; x=1697181750;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Ogt/791u0Ob3lK8u1/AaAtEtesBq52g5tKRgOIYKTU=;
 b=FnmNU6zDupzCumHW9+ut3sPl3oPFFsSAdr8XJGrXkqJtjoTOmi83OjqLweI6k/xdRg
 vg14I89yYPQw8oj5CUnjOueC+QorjI4ew2Gv4/3ldSfMhWLQbRHpI8Jq0e2f0H8o5xfs
 AAtQ/336pwPD7vnHkEVwUGyoXMi2tgm9+ydpwTtFOb5NaSsYEG9DF1ieurwXVHRj6ku8
 ThX7vnIIqE8KTvrxJ+YfXmBzYjLGQfVUWS8vsbCKi0hdsvOKBX1m+HRBz3AQVfvf6kak
 +b4ks7CI+PHPwYm+fX4bBe7lEJtNJGOByJsznlQvUsScedaW7qYRgiCyQMBYLlQekbtU
 xAbg==
X-Gm-Message-State: AOJu0YzZpHRN/K91hYvS/l/giXKRu4ZRdUZJoM/UplEjVQlXrJ30lBE0
 HjBpTGOG/zdU6XFpglrqCZQIRxjZMvQ=
X-Google-Smtp-Source: AGHT+IFqgeL1EhN71z7wncSHGPeC/Fb0PChV1q1yT2gpqfCfeCNkHeyGSx0iUCytWXA/fUvA6j0QDQ==
X-Received: by 2002:a05:600c:290:b0:405:3d41:5646 with SMTP id
 16-20020a05600c029000b004053d415646mr7463030wmk.2.1696576950004; 
 Fri, 06 Oct 2023 00:22:30 -0700 (PDT)
Received: from [10.254.108.106] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a05600c220800b003fee8793911sm3062632wml.44.2023.10.06.00.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 00:22:29 -0700 (PDT)
Message-ID: <02f56a1a-9be4-4d63-9c56-612c60af9adf@gmail.com>
Date: Fri, 6 Oct 2023 09:22:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/amd: Evict resources during PM ops prepare()
 callback
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231004171838.168215-1-mario.limonciello@amd.com>
 <20231004171838.168215-2-mario.limonciello@amd.com>
 <12e15ad4-cfa5-4ce9-89a4-f8d1718cb256@gmail.com>
 <d6768636-610f-4213-84c0-8989a4f1f5ed@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <d6768636-610f-4213-84c0-8989a4f1f5ed@amd.com>
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
Cc: Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 05.10.23 um 16:59 schrieb Mario Limonciello:
> On 10/5/2023 09:39, Christian König wrote:
>> Am 04.10.23 um 19:18 schrieb Mario Limonciello:
>>> Linux PM core has a prepare() callback run before suspend.
>>>
>>> If the system is under high memory pressure, the resources may need
>>> to be evicted into swap instead.  If the storage backing for swap
>>> is offlined during the suspend() step then such a call may fail.
>>>
>>> So duplicate this step into prepare() to move evict majority of
>>> resources while leaving all existing steps that put the GPU into a
>>> low power state in suspend().
>>>
>>> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2362
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 
>>> +++++++++++++++++++++-
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  7 +++---
>>>   3 files changed, 30 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index d23fb4b5ad95..6643d0ed6b1b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1413,6 +1413,7 @@ void amdgpu_driver_postclose_kms(struct 
>>> drm_device *dev,
>>>   void amdgpu_driver_release_kms(struct drm_device *dev);
>>>   int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
>>> +int amdgpu_device_prepare(struct drm_device *dev);
>>>   int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
>>>   int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
>>>   u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index bad2b5577e96..67acee569c08 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -4259,6 +4259,31 @@ static int 
>>> amdgpu_device_evict_resources(struct amdgpu_device *adev)
>>>   /*
>>>    * Suspend & resume.
>>>    */
>>> +/**
>>> + * amdgpu_device_prepare - prepare for device suspend
>>> + *
>>> + * @dev: drm dev pointer
>>> + *
>>> + * Prepare to put the hw in the suspend state (all asics).
>>> + * Returns 0 for success or an error on failure.
>>> + * Called at driver suspend.
>>> + */
>>> +int amdgpu_device_prepare(struct drm_device *dev)
>>> +{
>>> +    struct amdgpu_device *adev = drm_to_adev(dev);
>>> +    int r;
>>> +
>>> +    if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
>>> +        return 0;
>>> +
>>> +    /* Evict the majority of BOs before starting suspend sequence */
>>> +    r = amdgpu_device_evict_resources(adev);
>>> +    if (r)
>>> +        return r;
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   /**
>>>    * amdgpu_device_suspend - initiate device suspend
>>>    *
>>> @@ -4279,7 +4304,6 @@ int amdgpu_device_suspend(struct drm_device 
>>> *dev, bool fbcon)
>>>       adev->in_suspend = true;
>>> -    /* Evict the majority of BOs before grabbing the full access */
>>>       r = amdgpu_device_evict_resources(adev);
>>>       if (r)
>>>           return r;
>>
>> I would just completely drop this extra 
>> amdgpu_device_evict_resources() call now.
>>
>> We have a second call which is used to evacuate firmware etc... after 
>> the hw has been shut down. That one can't move, but also shouldn't 
>> allocate that much memory.
>>
>
> The problem is that amdgpu_device_suspend() is also called from 
> amdgpu_switcheroo_set_state() as well as a bunch of pmops sequences 
> that I don't expect call prepare() like poweroff().
>
> I would think we still want to evict resources at the beginning of 
> amdgpu_device_suspend() for all of those.
>
> So it's an extra call for the prepare() path but it should be harmless.

That's true, but I would rather say that we should then call 
amdgpu_device_prepare() in those call paths as well.

We might end up putting more stuff into the prepare call than just 
eviction VRAM.

Regards,
Christian.

>
>> Regards,
>> Christian.
>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index e3471293846f..175167582db0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2425,8 +2425,9 @@ static int amdgpu_pmops_prepare(struct device 
>>> *dev)
>>>       /* Return a positive number here so
>>>        * DPM_FLAG_SMART_SUSPEND works properly
>>>        */
>>> -    if (amdgpu_device_supports_boco(drm_dev))
>>> -        return pm_runtime_suspended(dev);
>>> +    if (amdgpu_device_supports_boco(drm_dev) &&
>>> +        pm_runtime_suspended(dev))
>>> +        return 1;
>>>       /* if we will not support s3 or s2i for the device
>>>        *  then skip suspend
>>> @@ -2435,7 +2436,7 @@ static int amdgpu_pmops_prepare(struct device 
>>> *dev)
>>>           !amdgpu_acpi_is_s3_active(adev))
>>>           return 1;
>>> -    return 0;
>>> +    return amdgpu_device_prepare(drm_dev);
>>>   }
>>>   static void amdgpu_pmops_complete(struct device *dev)
>>
>

