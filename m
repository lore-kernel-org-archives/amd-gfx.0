Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419BFC4167B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Nov 2023 15:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9874B10E0F1;
	Fri, 10 Nov 2023 15:11:06 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED7D10E0F6
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 15:11:04 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40a4859b231so2752475e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 07:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699629062; x=1700233862; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UMJjRgH8BoDFj2jbT34C4rGc7vaW9Pyy2GX2ZVgi614=;
 b=QoHKJXZvnd7o34NRrhRtFtJ5lJIhr8i9PJNrSF0FyTjO9H0Y8hchACKb55ZEQsjb+b
 i2/jcyAP/tllTZK+jmOLmXvGS5yy1KeZNz7xxkPbmwEBK0J6CVaHa5Ize9jbcwSFEyFx
 GtFwL9ROL191x41EAj7ugM8ciODhqWCONy0o24UrZ6c3A/lYXd0JKB4rF4nT/7n2XNQI
 Y5GOBcbtUy24BvAFLV3hMq2QRTfLXmgg8zmTsn6w3iyo4RC1W6fAzTSY2EulBxpcH/ag
 6+ERojRlL5VLRFIV+vSB/woL+GlakpQM50UrtpDHnbKESjQQv3IQm1hcb6n/25RyFIiT
 WYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699629062; x=1700233862;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UMJjRgH8BoDFj2jbT34C4rGc7vaW9Pyy2GX2ZVgi614=;
 b=QYneVAr1wGHLMI/ovIoip9j2sA8Q41q3GEolLn7JNsncx43gO0qT9cQOsgWuEpDN1d
 LTFTON4N7z/phoC2YLstVPa2CfeqHmHmYUSD4gUbuLFCWqfrak5Ifl3/LMdpQmumrMN4
 M74HInQYJY70o8RijWBoRpbQnkpc0sPg+oyzU2t3+yjuAoWnHtJ+4/uNGBCXWDAcm0jz
 8Uv4ay8zaaov2k/7IN7nf+kXdt3wMb2mtr7Ku6RHkKsxg0i1f0bDe7cVS3ZzvGMezGgZ
 g0XKh/WbdnNsBCGxomcfCfR+7lAZ2N/p/cGjBi6VbJlW8xwoiBEeleynbuyHsrvWXOO/
 pLRQ==
X-Gm-Message-State: AOJu0Yw2XHGZHbA/QPrX8Co2cOf0o6ZrL2J5rJKV9pQadTDaYzfmCHNE
 JOjHelVLQJIUbMxHTyanJPAwfhXt7/g=
X-Google-Smtp-Source: AGHT+IFEWZiUk0IjdxzNvbcEEaKouw+tO4eDhzrGa9auOYwGuIktVwNIraWGUYUrFKL7pC49ilLYhQ==
X-Received: by 2002:a05:600c:2a18:b0:401:d947:c8a9 with SMTP id
 w24-20020a05600c2a1800b00401d947c8a9mr7201354wme.19.1699629062093; 
 Fri, 10 Nov 2023 07:11:02 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a1c6a17000000b0040648217f4fsm5324900wmc.39.2023.11.10.07.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Nov 2023 07:11:01 -0800 (PST)
Message-ID: <e25d2d15-3fe2-4284-a253-3d76e2af7ae1@gmail.com>
Date: Fri, 10 Nov 2023 16:10:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Skip execution of pending reset jobs
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231109073813.552664-1-lijo.lazar@amd.com>
 <a8e73966-e233-4ec8-9e33-9821da64e67c@gmail.com>
 <1195f786-e7ac-b93b-58c3-bf7276dc18e2@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <1195f786-e7ac-b93b-58c3-bf7276dc18e2@amd.com>
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
Cc: Alexander.Deucher@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 10.11.23 um 16:07 schrieb Lazar, Lijo:
>
>
> On 11/10/2023 8:18 PM, Christian König wrote:
>> Am 09.11.23 um 08:38 schrieb Lijo Lazar:
>>> cancel_work is not backported to all custom kernels.
>>
>> Well this is pretty clear NAK to pushing this upstream. We absolutely 
>> can't add workaround for older kernels.
>>
>> You could keep this in the backported kernel, but why should 
>> cancel_work not be available?
>>
>
> As you know there are vendor maintained kernels, and all users 
> necessarily don't upgrade to a kernel which has backport of this, as 
> that could be total disruption of their current environment.

Yeah, so what? The documented rule for upstreaming is that the code 
should be written for this kernel version and this alone!

This has clear precedence over vendors backporting the driver. No 
backporting aid whatsoever is allowed in the upstream kernel and this 
counts for all drivers in there.

We can certainly do this in the internal backporting branch, but pushing 
it to amd-staging-drm-next is a complete no-go.

Regards,
Christian.

>
> Thanks,
> Lijo
>
>> Regards,
>> Christian.
>>
>>>   Add a workaround to
>>> skip execution of already queued recovery jobs, if the device is 
>>> already
>>> reset.
>>>
>>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  |  9 +++++++++
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 16 ++++++++++++++++
>>>   3 files changed, 30 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index bebc73c6822c..c66524e2a56a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -5411,6 +5411,8 @@ static inline void 
>>> amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>>>   {
>>>       struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>> +    amdgpu_reset_domain_clear_pending(adev->reset_domain);
>>> +
>>>   #if defined(CONFIG_DEBUG_FS)
>>>       if (!amdgpu_sriov_vf(adev))
>>>           cancel_work(&adev->reset_work);
>>> @@ -5452,6 +5454,9 @@ int amdgpu_device_gpu_recover(struct 
>>> amdgpu_device *adev,
>>>       bool audio_suspended = false;
>>>       bool gpu_reset_for_dev_remove = false;
>>> +    if (amdgpu_reset_domain_in_drain_mode(adev->reset_domain))
>>> +        return 0;
>>> +
>>>       gpu_reset_for_dev_remove =
>>>               test_bit(AMDGPU_RESET_FOR_DEVICE_REMOVE, 
>>> &reset_context->flags) &&
>>>                   test_bit(AMDGPU_NEED_FULL_RESET, 
>>> &reset_context->flags);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> index 4baa300121d8..3ece7267d6ea 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>>> @@ -120,6 +120,14 @@ void amdgpu_reset_destroy_reset_domain(struct 
>>> kref *ref)
>>>       kvfree(reset_domain);
>>>   }
>>> +static void amdgpu_reset_domain_cancel_all_work(struct work_struct 
>>> *work)
>>> +{
>>> +    struct amdgpu_reset_domain *reset_domain =
>>> +        container_of(work, struct amdgpu_reset_domain, clear);
>>> +
>>> +    reset_domain->drain = false;
>>> +}
>>> +
>>>   struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum 
>>> amdgpu_reset_domain_type type,
>>>                                    char *wq_name)
>>>   {
>>> @@ -142,6 +150,7 @@ struct amdgpu_reset_domain 
>>> *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>>>       }
>>> +    INIT_WORK(&reset_domain->clear, 
>>> amdgpu_reset_domain_cancel_all_work);
>>>       atomic_set(&reset_domain->in_gpu_reset, 0);
>>>       atomic_set(&reset_domain->reset_res, 0);
>>>       init_rwsem(&reset_domain->sem);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>> index b0335a1c5e90..70059eea7e2f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>>> @@ -87,6 +87,8 @@ struct amdgpu_reset_domain {
>>>       struct rw_semaphore sem;
>>>       atomic_t in_gpu_reset;
>>>       atomic_t reset_res;
>>> +    struct work_struct clear;
>>> +    bool drain;
>>>   };
>>>   #ifdef CONFIG_DEV_COREDUMP
>>> @@ -137,6 +139,20 @@ static inline bool 
>>> amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *doma
>>>       return queue_work(domain->wq, work);
>>>   }
>>> +static inline void amdgpu_reset_domain_clear_pending(struct 
>>> amdgpu_reset_domain *domain)
>>> +{
>>> +    domain->drain = true;
>>> +    /* queue one more work to the domain queue. Till this work is 
>>> finished,
>>> +     * domain is in drain mode.
>>> +     */
>>> +    queue_work(domain->wq, &domain->clear);
>>> +}
>>> +
>>> +static inline bool amdgpu_reset_domain_in_drain_mode(struct 
>>> amdgpu_reset_domain *domain)
>>> +{
>>> +    return domain->drain;
>>> +}
>>> +
>>>   void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain 
>>> *reset_domain);
>>>   void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain 
>>> *reset_domain);
>>

