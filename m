Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A5ECD1288
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 09:40:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9ADF112605;
	Wed,  3 Apr 2024 09:40:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CtXq4JAb";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 603FB112605
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 09:40:18 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-415515178ceso32832595e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Apr 2024 02:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712137216; x=1712742016; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K5f3ULQtJjYK8EJmVGGoY63z2cMpeoM9oOlFlczEqj4=;
 b=CtXq4JAbZ/gOf6wNPqD/2xOflW3R7G3KCyW70XhMRNwDWkVbhuf4Sp6NoZebfd/2ZG
 1U2bi9ZnYrnQST+CfKDJeLJTFghN1gLSl9/3JxKPKtTqr/xp2v2NeWEtpf1HZ07ApRYh
 TTaqr9kCSnrzEj/xnFOAxBribHWRQtral+FPuLxPpveMFxaLRteozuRu+TFSB7Ghf0Q4
 mlXG/sQVVpBz3C/YlWMeIvVzejN1N9dyglYf+vQ7FJESjBLmQmiHZcOh4+Du8wPhPw64
 UFW39ImdRlOb8TJu0FJxUvK0gMTYnxeIJs++yb8V4prURi2ktaspaezzAxiioBdCamDO
 06dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712137216; x=1712742016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K5f3ULQtJjYK8EJmVGGoY63z2cMpeoM9oOlFlczEqj4=;
 b=IAcHDIF70kFNxgJeatZWQRfSaFOdC/lhbl5cwOaWrQKrUrUcwUi1c44GMUeDbV8k93
 U2lwEQggbA/xagwGyRIYJ/R2IHdTl3T3QxFZADmNslxb6Da2XEhs0pMOtijH9oK91CKo
 wRvwzJRTJEugWcyxGvT6ltukYSq+If50+Tfrw388awoCgyXdWKLFvYCYRcC3HX7esqLg
 m+rwPdGEp7vZHZuENpdWQljl/A8dP2jChGFCFAUU5+NBQ4UrK322WpwxeaytHsUPwnGD
 fmgcacPzPAgODUOTjFnfzyBG6lXZ6qhwLut6VYaj6XftcMtf9j5eUXKkFKZSCbDoKCIP
 Gf6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRtS0kOLAwrhogiDUXMOfnFDCJqZHHM9LroVQ7AGNdcFLD636z71lG4JA2PGSPWFb1u8tL44DWtkB0sCC19Xu7Msn0QKl+caWwgypyiw==
X-Gm-Message-State: AOJu0YzfDK26lgFp14Slmq2LDyaX8TnwrwMiSIEO6NjvEyEFI4MRs7VC
 khbZ/xg1E0xtJZJSBo59dQQ4W7DstD6bXsvBarkvg9Y6UbxR1pKP
X-Google-Smtp-Source: AGHT+IFJNjo4DPxM2jaXQPotD/5JVE216vgrMV36Py5pIcWf/ALWotkWtNaqMveCfjbb3qDb19Sjfg==
X-Received: by 2002:a05:600c:1ca2:b0:416:1d2e:62f1 with SMTP id
 k34-20020a05600c1ca200b004161d2e62f1mr2563848wms.5.1712137216289; 
 Wed, 03 Apr 2024 02:40:16 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 r14-20020a05600c458e00b00413e79344b7sm20871150wmo.19.2024.04.03.02.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 02:40:15 -0700 (PDT)
Message-ID: <2ce227ed-43b4-4da4-a6dc-8ab56736d6bd@gmail.com>
Date: Wed, 3 Apr 2024 11:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add post reset IP callback
To: "Yu, Lang" <Lang.Yu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Sharma, Shashank" <Shashank.Sharma@amd.com>
References: <20240328044014.3278891-1-Lang.Yu@amd.com>
 <d3581afc-4bc4-4e42-a4f5-5b4be5f10ed3@gmail.com>
 <MW6PR12MB88988E7D5DB5D5E9C4ED1A45FB3D2@MW6PR12MB8898.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <MW6PR12MB88988E7D5DB5D5E9C4ED1A45FB3D2@MW6PR12MB8898.namprd12.prod.outlook.com>
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

Am 03.04.24 um 08:51 schrieb Yu, Lang:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Tuesday, April 2, 2024 9:38 PM
>> To: Yu, Lang <Lang.Yu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Sharma, Shashank
>> <Shashank.Sharma@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: add post reset IP callback
>>
>> Am 28.03.24 um 05:40 schrieb Lang Yu:
>>> There are use cases which need full GPU functionality (e.g., VM
>>> update, TLB inavildate) when doing a GPU reset.
>>>
>>> Especially, the mes/umsch self tests which help validate the hw state
>>> after hw init like ring/ib tests.
>> I noted that before but just to repeat it once more: We can't do any MES or
>> UMSCH validation while doing a GPU reset!
> Yes, we can just easily disable it if it doesn't work well.
> But it doesn't take too much effort to make it work.

No, that is a completely false assumption. This is a fundamental problem.

Neither the MES test nor the UMSCH test will ever work correctly under a 
GPU reset.

> It can expose issues as soon as possible and is useful for debugging purpose.
>
>> The ring and IB tests use some pre-allocated memory we put aside for the
>> task during driver load and so can execute during GPU reset as well.
> If user space can create a VM and allocate memory during GPU reset,
> it makes no sense to prevent kernel space from doing that.

Yes it does. The GPU reset must re-start the hardware as soon as 
possible because memory management might wait on it.

You can create a VM and allocate memory, but this must be independent of 
the GPU reset.

And when you do this it is not valuable any more since we can't say that 
the GPU reset hasn't worked later on.

>
>> But for the MES/UMSCH we need a full blown environment with VM and
>> submission infrastructure and setting that up isn't possible here.
> At least for UMSCH test, it only uses VM mapping functionality
> (if we can create a VM with cpu update mode, that's enough),
> it doesn't use other submission functionality.
> It is actually a compute context.

Nope, that doesn't even remotely work correctly.

Regards,
Christian.

>
>
> Regards,
> Lang
>
>> Adding Shashank as well, but I think we should probably just completely
>> remove those from the kernel.
>>
>> Regards,
>> Christian.
>>
>>> Add a post reset IP callback to handle such use cases which will be
>>> executed after GPU reset succeeds.
>>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24
>> ++++++++++++++++++++++
>>>    drivers/gpu/drm/amd/include/amd_shared.h   |  3 +++
>>>    2 files changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 12dc71a6b5db..feeab9397aab 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5556,6 +5556,27 @@ static int amdgpu_device_health_check(struct
>> list_head *device_list_handle)
>>>       return ret;
>>>    }
>>>
>>> +static int amdgpu_device_ip_post_reset(struct amdgpu_device *adev) {
>>> +    uint32_t i;
>>> +    int r;
>>> +
>>> +    for (i = 0; i < adev->num_ip_blocks; i++) {
>>> +            if (!adev->ip_blocks[i].status.valid ||
>>> +                !adev->ip_blocks[i].version->funcs->post_reset)
>>> +                    continue;
>>> +
>>> +            r = adev->ip_blocks[i].version->funcs->post_reset(adev);
>>> +            if (r) {
>>> +                    DRM_ERROR("post reset of IP block <%s>
>> failed %d\n",
>>> +                              adev->ip_blocks[i].version->funcs->name, r);
>>> +                    return r;
>>> +            }
>>> +    }
>>> +
>>> +    return r;
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>>>     *
>>> @@ -5805,6 +5826,9 @@ int amdgpu_device_gpu_recover(struct
>> amdgpu_device *adev,
>>>               amdgpu_put_xgmi_hive(hive);
>>>       }
>>>
>>> +    if (!r && !job_signaled)
>>> +            r = amdgpu_device_ip_post_reset(adev);
>>> +
>>>       if (r)
>>>               dev_info(adev->dev, "GPU reset end with ret = %d\n", r);
>>>
>>> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h
>>> b/drivers/gpu/drm/amd/include/amd_shared.h
>>> index b0a6256e89f4..33ce30a8e3ab 100644
>>> --- a/drivers/gpu/drm/amd/include/amd_shared.h
>>> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
>>> @@ -287,6 +287,7 @@ enum amd_dpm_forced_level;
>>>     * @pre_soft_reset: pre soft reset the IP block
>>>     * @soft_reset: soft reset the IP block
>>>     * @post_soft_reset: post soft reset the IP block
>>> + * @post_reset: handles IP specific post reset stuff(e.g., self test)
>>>     * @set_clockgating_state: enable/disable cg for the IP block
>>>     * @set_powergating_state: enable/disable pg for the IP block
>>>     * @get_clockgating_state: get current clockgating status @@ -316,11
>>> +317,13 @@ struct amd_ip_funcs {
>>>       int (*pre_soft_reset)(void *handle);
>>>       int (*soft_reset)(void *handle);
>>>       int (*post_soft_reset)(void *handle);
>>> +    int (*post_reset)(void *handle);
>>>       int (*set_clockgating_state)(void *handle,
>>>                                    enum amd_clockgating_state state);
>>>       int (*set_powergating_state)(void *handle,
>>>                                    enum amd_powergating_state state);
>>>       void (*get_clockgating_state)(void *handle, u64 *flags);
>>> +
>>>    };
>>>
>>>

