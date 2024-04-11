Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E0ECD128A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 11:49:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41CC110EDCE;
	Thu, 11 Apr 2024 11:49:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m9DhtYh9";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A5E410EDCE
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 11:49:21 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-416c4767b07so13240695e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 04:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712836159; x=1713440959; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+TcSM3S4bSRm0z8HSx00lilx6bHbBA3HQ1sFMnHEw8=;
 b=m9DhtYh95x/pVwdbxfCzrpjflatxpisx9xVLICoYagsVTM7vEsKljpgFBuVWSJnUlO
 oUif5yjmzZ9/OTkCARAQfsH8jV0ubFn2jnAVC2H8a2s1bQzFFNZc+i8BzhM2HbQuLePL
 yW7U9wU0EzUBu+3+bpgIuhJL17IzQaMmUpvkePYNqFDL8aUaAEJ4/bdnq6MXKXghzlHT
 QndtGrzbVjhHBGTTSdpJkUay8GTzB52e5PT6XkF8J7nvTnnBFksQ3ZM/tFxzB2mdQkU5
 /1QBcMERT5ZFIN6SuknfaJNQug4dRnbv/92Oz/CUYBISKmreEAqGSq9PlHnWwBdV3R8F
 V8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712836159; x=1713440959;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m+TcSM3S4bSRm0z8HSx00lilx6bHbBA3HQ1sFMnHEw8=;
 b=EReZilmgYmW+rw2kAbwvQGx0PZ93GZgLdCbn6r3Tjr1Z9qabsjEPNVAUVH3LyibYcH
 1fozY6Pgjmf1RTU9oN4dSKZNVAciOfLgP2GfFnHYRy+LQZIggNNCrrAv99Vpuc7RAF7T
 36TpRyWeQymF8LgwmMssjIqRMEA4c9pc3BdO8E9NbN5ydKcHYT6iUxrE4Og1o99Vw23U
 Pcm3kHJ6e9l+gkI+ZehpmypK6GHstJwn3HQeSvVf+L6GtnaVrjhksfJwMMHW0wejLMX4
 G7Mlkq86cwk/kmjNQiQgZbMmwV5QKNsVF30lRXYRq1K/WYbDL9M8urlX4f0f4jPNF+qp
 oz2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUYx7AcRZQGaLWnWi/9M18/8AgtVDSy+/XpPEuDm674PpruwaAvYfoqhWa/Glb+pb0vHeY8+jn014dbhEAbxUh8DyiZmt5YvwqTB89Hw==
X-Gm-Message-State: AOJu0Yybhq4G4CxPZjEpEUx/kQ8FfVdY/KkNVQtLGtvA5wCyKr89txny
 pf41xQu5QGCYA22WA69shT/5Uny8pSPbtuYLtwE+vDNRPY12bXC0
X-Google-Smtp-Source: AGHT+IEvBPYl9ChGyOk3tYtZTd7H7WMdg3oJByVO72tD7d5Fr/iyqOhznHZKMi0m9TjQUuxSwP8r5w==
X-Received: by 2002:a05:600c:21c1:b0:416:4342:c553 with SMTP id
 x1-20020a05600c21c100b004164342c553mr4087675wmj.16.1712836159255; 
 Thu, 11 Apr 2024 04:49:19 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 bh12-20020a05600c3d0c00b00417e326ff3bsm881855wmb.36.2024.04.11.04.49.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 04:49:18 -0700 (PDT)
Message-ID: <e102c106-d47e-43ad-b57d-2c51ce1cfda3@gmail.com>
Date: Thu, 11 Apr 2024 13:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH Review 1/1] drm/amdgpu: Support setting recover method
To: "Yang, Stanley" <Stanley.Yang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20240411111108.3571355-1-Stanley.Yang@amd.com>
 <743be31c-0edc-4fb5-ae4f-694de64481c6@gmail.com>
 <PH7PR12MB79881B8A7769C065A41CD8179A052@PH7PR12MB7988.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <PH7PR12MB79881B8A7769C065A41CD8179A052@PH7PR12MB7988.namprd12.prod.outlook.com>
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

Am 11.04.24 um 13:30 schrieb Yang, Stanley:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Thursday, April 11, 2024 7:17 PM
>> To: Yang, Stanley <Stanley.Yang@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH Review 1/1] drm/amdgpu: Support setting recover method
>>
>> Am 11.04.24 um 13:11 schrieb Stanley.Yang:
>>> Don't modify amdgpu gpu recover get operation, add amdgpu gpu recover
>>> set operation to select reset method, only support mode1 and mode2
>>> currently.
>> Well I don't think setting this from userspace is valid.
>>
>> The reset method to use is determined by the hardware and environment (e.g.
>> SRIOV, passthrough, whatever) and can't be chosen simply.
> [Stanley]: Agree, the setting is invalid for some devices not supported setting method and devices still reset with default method,
> but it's valid for those devices supported setting reset method, user can conduct combination testing like mode1 test then mode2 test without
> re-modprobe driver.

Well and the user could also shoot himself into the foot.

I really don't think that this is a valuable functionality.

Regards,
Christian.

>
> Regards,
> Stanley
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 37
>> +++++++++++++++++++---
>>>    3 files changed, 37 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index 9c62552bec34..c82976b2b977 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -1151,6 +1151,9 @@ struct amdgpu_device {
>>>      bool                            debug_largebar;
>>>      bool                            debug_disable_soft_recovery;
>>>      bool                            debug_use_vram_fw_buf;
>>> +
>>> +   /* Used to set gpu reset method */
>>> +   int                             recover_method;
>>>    };
>>>
>>>    static inline uint32_t amdgpu_ip_version(const struct amdgpu_device
>>> *adev, diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 3204b8f6edeb..8411a793be18 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -3908,6 +3908,7 @@ int amdgpu_device_init(struct amdgpu_device
>> *adev,
>>>      else
>>>              adev->asic_type = flags & AMD_ASIC_MASK;
>>>
>>> +   adev->recover_method = AMD_RESET_METHOD_NONE;
>>>      adev->usec_timeout = AMDGPU_MAX_USEC_TIMEOUT;
>>>      if (amdgpu_emu_mode == 1)
>>>              adev->usec_timeout *= 10;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index 10832b470448..e388a50d11d9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -965,9 +965,37 @@ static int gpu_recover_get(void *data, u64 *val)
>>>      return 0;
>>>    }
>>>
>>> +static int gpu_recover_set(void *data, u64 val) {
>>> +   struct amdgpu_device *adev = (struct amdgpu_device *)data;
>>> +   struct drm_device *dev = adev_to_drm(adev);
>>> +   int r;
>>> +
>>> +   /* TODO: support mode1 and mode2 currently */
>>> +   if (val == AMD_RESET_METHOD_MODE1 ||
>>> +           val == AMD_RESET_METHOD_MODE2)
>>> +           adev->recover_method = val;
>>> +   else
>>> +           adev->recover_method = AMD_RESET_METHOD_NONE;
>>> +
>>> +   r = pm_runtime_get_sync(dev->dev);
>>> +   if (r < 0) {
>>> +           pm_runtime_put_autosuspend(dev->dev);
>>> +           return 0;
>>> +   }
>>> +
>>> +   if (amdgpu_reset_domain_schedule(adev->reset_domain, &adev-
>>> reset_work))
>>> +           flush_work(&adev->reset_work);
>>> +
>>> +   pm_runtime_mark_last_busy(dev->dev);
>>> +   pm_runtime_put_autosuspend(dev->dev);
>>> +
>>> +   return 0;
>>> +}
>>> +
>>>    DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
>>> -DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops,
>> gpu_recover_get, NULL,
>>> -                    "%lld\n");
>>> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops,
>> gpu_recover_get,
>>> +                    gpu_recover_set, "%lld\n");
>>>
>>>    static void amdgpu_debugfs_reset_work(struct work_struct *work)
>>>    {
>>> @@ -978,9 +1006,10 @@ static void amdgpu_debugfs_reset_work(struct
>>> work_struct *work)
>>>
>>>      memset(&reset_context, 0, sizeof(reset_context));
>>>
>>> -   reset_context.method = AMD_RESET_METHOD_NONE;
>>> +   reset_context.method = adev->recover_method;
>>>      reset_context.reset_req_dev = adev;
>>>      set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>>> +   adev->recover_method = AMD_RESET_METHOD_NONE;
>>>
>>>      amdgpu_device_gpu_recover(adev, NULL, &reset_context);
>>>    }
>>> @@ -999,7 +1028,7 @@ void amdgpu_debugfs_fence_init(struct
>> amdgpu_device *adev)
>>>      if (!amdgpu_sriov_vf(adev)) {
>>>
>>>              INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
>>> -           debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
>>> +           debugfs_create_file("amdgpu_gpu_recover", 0666, root, adev,
>>>                                  &amdgpu_debugfs_gpu_recover_fops);
>>>      }
>>>    #endif

