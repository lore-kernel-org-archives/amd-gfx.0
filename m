Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB835C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 08:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A5FB10E8FA;
	Wed,  9 Mar 2022 08:02:30 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B1410E8FA
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 08:02:29 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id bi12so3131933ejb.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Mar 2022 00:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=8YHP9aVgmjhsduE5yTYVjYH/B0W1tSrMlgDO+6NcNr0=;
 b=bVhwfid0yPUmR7waErTh8OGroQv65xLDC3eld0OKd3SbzbMqcL+neUxoZr2dmuowGb
 IYz3ME0yOIuhBGPjwwL62lzsfUIf9v28VKeBK+yEwlaHtW1+UX683CUWWF0z7aFwh6Yy
 4/rFenqGm0g7fVIfVLI2r57WC51nKfSNK64GXxmmh+hf97Nc7wE/tlauJ3J371k8K7kK
 nvadGJzJFkenliD/kasn8fP1YKVtw8IZROyzu0Nc7qcYbeo0z26Qd/OzpuxjlnH84Kam
 O5LQm5FPie+RTgw6dZc4PaXtFW1Gxld9v35fnPnXP96vinSEinm7NTK/txqORk09+4zI
 9lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8YHP9aVgmjhsduE5yTYVjYH/B0W1tSrMlgDO+6NcNr0=;
 b=HAk8dYPYKHRbt+NWJfktWoFzAeuwNwaVrtT0E74LI7TnyPkF1DCCV19QGeyUCMoYJV
 rKvM1gnK3rLU6hH8qKmIy8JuN4YzNjHsoL1uH6a9YolUiRW52PLTtjYYWy6RKM08to8U
 Ws+3lWdzSle440pIiPGN/cb27ZGyyXb+c6Td1pPpu1gCwMOvRpr8NcIqfSdxjUR/ktao
 FxuyQHxUYMJC38YAHUAWIDfHSqFwWTuLSB1vBh67hbx5paQQXxBGZkurZr/MU2NtMyZj
 A7ZKwbaRZYvmEa+VA/rNkbxEWWs5ohQEjNb6o2S/j8lJ1JuoZ7IH2tnK+s+uA2cKme25
 rwTw==
X-Gm-Message-State: AOAM533xN5j38M6jeZTGdyA2iNcNOv/+iE5B2vudRtOojqFCDLglkX6k
 BZC1YVGq59gfxqE9zxwhPTg=
X-Google-Smtp-Source: ABdhPJyOQPDDVjFL5R12oiQydELFp0pw0b7Bw8xaFaMuZHXB8EIPyjPAcZs5N7NQH1fqXRePm9N+gw==
X-Received: by 2002:a17:907:7248:b0:6da:8410:c3c8 with SMTP id
 ds8-20020a170907724800b006da8410c3c8mr16960623ejc.200.1646812947357; 
 Wed, 09 Mar 2022 00:02:27 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:97ec:d1db:f85a:1e04?
 ([2a02:908:1252:fb60:97ec:d1db:f85a:1e04])
 by smtp.gmail.com with ESMTPSA id
 kw5-20020a170907770500b006db075e5358sm408297ejc.66.2022.03.09.00.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Mar 2022 00:02:26 -0800 (PST)
Message-ID: <55d87ab6-dcdc-da85-72ff-5c5e9532b09f@gmail.com>
Date: Wed, 9 Mar 2022 09:02:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm: Add GPU reset sysfs event
Content-Language: en-US
To: "Somalapuram, Amaranath" <asomalap@amd.com>,
 "Sharma, Shashank" <shashank.sharma@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220307162631.2496286-1-contactshashanksharma@gmail.com>
 <bd1ab442-86f7-ba41-31a8-0e896c6606d2@gmail.com>
 <958e65ad-3e86-36b5-5da2-7bb38431c343@amd.com>
 <f3d57b6a-1035-ee92-82b2-a4601e5b72b0@amd.com>
 <9c0ede9f-d1a1-f154-82fa-27f624664229@amd.com>
 <05e0a27c-999c-cdbd-631a-93a78e76bdc2@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <05e0a27c-999c-cdbd-631a-93a78e76bdc2@amd.com>
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
Cc: Alexandar Deucher <alexander.deucher@amd.com>,
 amaranath.somalapuram@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.03.22 um 16:37 schrieb Somalapuram, Amaranath:
>
> On 3/8/2022 5:26 PM, Sharma, Shashank wrote:
>>
>>
>> On 3/8/2022 11:32 AM, Christian König wrote:
>>> Am 08.03.22 um 10:31 schrieb Sharma, Shashank:
>>>>
>>>>
>>>> On 3/8/2022 8:06 AM, Christian König wrote:
>>>>> Am 07.03.22 um 17:26 schrieb Shashank Sharma:
>>>>>> From: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>
>>>>>> This patch adds a new sysfs event, which will indicate
>>>>>> the userland about a GPU reset, and can also provide
>>>>>> some information like:
>>>>>> - which PID was involved in the GPU reset
>>>>>> - what was the GPU status (using flags)
>>>>>>
>>>>>> This patch also introduces the first flag of the flags
>>>>>> bitmap, which can be appended as and when required.
>>>>>
>>>>> Make sure to CC the dri-devel mailing list when reviewing this.
>>>> Got it,
>>>>
>>>> I was also curious if we want to move the reset_ctx structure 
>>>> itself to DRM layer, like
>>>> drm_reset_event_ctx {
>>>>     u32 pid;
>>>>     u32 flags;
>>>>     char process_name[64];
>>>> };
>>>
>>> I was entertaining that thought as well.
>>>
>>> But if we do this I would go even a step further and also move the 
>>> reset work item into the DRM layer as well.
>>>
>>> You might also look like into migrating the exiting i915 code which 
>>> uses udev to signal GPU resets to this function as well.
>>>
> Hi Christian,
>
> Can we access adev in common drm (even if we can access adev it will 
> not be common code)

No, that won't work.

>
> move work function to drm need to be protected(i.e reset_domain->sem), 
> adding something like reset_sem to drm_device?

Hui what? Why do you think the work function needs any protection? That 
doesn't make much sense.

Regards,
Christian.

>
> Regards,
>
> S.Amarnath
>
>>> Regards,
>>> Christian.
>>
>> That seems like a good idea, let me quickly dive into i915 and check 
>> this out.
>>
>> Shashank
>>>
>>>>
>>>> and then:
>>>> void drm_sysfs_reset_event(struct drm_device *dev, 
>>>> drm_reset_event_ctx *ctx);
>>>>
>>>>>
>>>>>>
>>>>>> Cc: Alexandar Deucher <alexander.deucher@amd.com>
>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/drm_sysfs.c | 24 ++++++++++++++++++++++++
>>>>>>   include/drm/drm_sysfs.h     |  3 +++
>>>>>>   2 files changed, 27 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/drm_sysfs.c 
>>>>>> b/drivers/gpu/drm/drm_sysfs.c
>>>>>> index 430e00b16eec..52a015161431 100644
>>>>>> --- a/drivers/gpu/drm/drm_sysfs.c
>>>>>> +++ b/drivers/gpu/drm/drm_sysfs.c
>>>>>> @@ -409,6 +409,30 @@ void drm_sysfs_hotplug_event(struct 
>>>>>> drm_device *dev)
>>>>>>   }
>>>>>>   EXPORT_SYMBOL(drm_sysfs_hotplug_event);
>>>>>> +/**
>>>>>> + * drm_sysfs_reset_event - generate a DRM uevent to indicate GPU 
>>>>>> reset
>>>>>> + * @dev: DRM device
>>>>>> + * @pid: The process ID involve with the reset
>>>>>> + * @flags: Any other information about the GPU status
>>>>>> + *
>>>>>> + * Send a uevent for the DRM device specified by @dev. This 
>>>>>> indicates
>>>>>> + * user that a GPU reset has occurred, so that the interested 
>>>>>> client
>>>>>> + * can take any recovery or profiling measure, when required.
>>>>>> + */
>>>>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>>>> uint32_t flags)
>>>>>
>>>>> The PID is usually only 32bit, but even better would be to use pid_t.
>>>>>
>>>>>> +{
>>>>>> +    unsigned char pid_str[21], flags_str[15];
>>>>>> +    unsigned char reset_str[] = "RESET=1";
>>>>>> +    char *envp[] = { reset_str, pid_str, flags_str, NULL };
>>>>>> +
>>>>>> +    DRM_DEBUG("generating reset event\n");
>>>>>> +
>>>>>> +    snprintf(pid_str, ARRAY_SIZE(pid_str), "PID=%lu", pid);
>>>>>> +    snprintf(flags_str, ARRAY_SIZE(flags_str), "FLAGS=%u", flags);
>>>>>> + kobject_uevent_env(&dev->primary->kdev->kobj, KOBJ_CHANGE, envp);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL(drm_sysfs_reset_event);
>>>>>> +
>>>>>>   /**
>>>>>>    * drm_sysfs_connector_hotplug_event - generate a DRM uevent 
>>>>>> for any connector
>>>>>>    * change
>>>>>> diff --git a/include/drm/drm_sysfs.h b/include/drm/drm_sysfs.h
>>>>>> index 6273cac44e47..63f00fe8054c 100644
>>>>>> --- a/include/drm/drm_sysfs.h
>>>>>> +++ b/include/drm/drm_sysfs.h
>>>>>> @@ -2,6 +2,8 @@
>>>>>>   #ifndef _DRM_SYSFS_H_
>>>>>>   #define _DRM_SYSFS_H_
>>>>>> +#define DRM_GPU_RESET_FLAG_VRAM_VALID (1 << 0)
>>>>>
>>>>> Probably better to define that the other way around, e.g. 
>>>>> DRM_GPU_RESET_FLAG_VRAM_LOST.
>>>>>
>>>>> Apart from that looks good to me.
>>>>>
>>>> Got it, noted.
>>>> - Shashank
>>>>
>>>>> Christian.
>>>>>
>>>>>> +
>>>>>>   struct drm_device;
>>>>>>   struct device;
>>>>>>   struct drm_connector;
>>>>>> @@ -11,6 +13,7 @@ int drm_class_device_register(struct device *dev);
>>>>>>   void drm_class_device_unregister(struct device *dev);
>>>>>>   void drm_sysfs_hotplug_event(struct drm_device *dev);
>>>>>> +void drm_sysfs_reset_event(struct drm_device *dev, uint64_t pid, 
>>>>>> uint32_t reset_flags);
>>>>>>   void drm_sysfs_connector_hotplug_event(struct drm_connector 
>>>>>> *connector);
>>>>>>   void drm_sysfs_connector_status_event(struct drm_connector 
>>>>>> *connector,
>>>>>>                         struct drm_property *property);
>>>>>
>>>

