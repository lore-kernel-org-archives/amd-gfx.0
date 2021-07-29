Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625E2C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 12:50:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBB46018A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 12:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BBB46018A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D82C96ED9F;
	Thu, 29 Jul 2021 12:50:16 +0000 (UTC)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C146ED9F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 12:50:16 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id h14so6776139wrx.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=jYugegQ5Pki4GjzEjQM3U69GAdmEPXfkHYXR120UkDI=;
 b=Vvy49wT9K1CxBEduw/rkqClo7Migzzph4j0Ttj2Wgn1evRk5vverCyg/b7tTEnSe68
 ylS0AFoIkfatTZmVARlHezTamFbGnjYdpBZ0yqXWoTPMfE337PaQ8JJJJf7EQFxMzn5S
 Jw3CLnDNw9vOqydbHUf3FDxAq8ZS4t4y4klM8xY+Yq1eJ+3NMP/UpkfvSXLM6BY2Jh4P
 ll4io4aqWT2AT+V5/V4lXN/32jR5JEQrMjnOYSWfebVHMtuQJ1NjabVnoo2o+Pw5o6Jw
 cw5KhJEGZy4YnFMNASGVTN6+PT2/z6TEV81BFfZ/cUosh0iDxKGAgmGpylr0ZKI7zIt9
 1qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=jYugegQ5Pki4GjzEjQM3U69GAdmEPXfkHYXR120UkDI=;
 b=uRk1zMLpXsej9ybBweCS54zY+BjIzEKimN2ZqkBzzyRS14+UaDTU834Xat+Fr50Rj1
 JmVYzy0/bxjN5qH0G5wfmL6qHTlfSSYbF9tapwPw4cap/u71tIslP2Hj+olZ2xkU+las
 d7/VdUIir+gzy52ArL0rGfk7tpgYox1EihpQbXec8eSHLQ1O/67dUu2JnaTJLT820/ui
 HwjR5440fPofB/g6VxgJSSdIYoXUusXWt9riJbFminrQwLJC9TMRIrAca7Lz+sTJklxl
 Z/DFVVvvOmxo7aIWkbiHQselk5Iouih7bFgWRIWQkM6QnFqr37HzRXntRXxIIdRYRlCr
 rcdA==
X-Gm-Message-State: AOAM531CnzVLOFJzeAnZQuZt3U+i+SkRclBfOxpw37XX42rif0U0DlW9
 K/1WqmrWeGWtIh8EKB5neCk=
X-Google-Smtp-Source: ABdhPJyg7ggSDhLDB/ofhZO7GAqc442xgJoK0qFyacMcB//YhJqyB7YA+Hvrf2m1rzHdbC7TsEhB2A==
X-Received: by 2002:a5d:45c5:: with SMTP id b5mr4723650wrs.32.1627563014654;
 Thu, 29 Jul 2021 05:50:14 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3e62:c902:d5a3:6f28?
 ([2a02:908:1252:fb60:3e62:c902:d5a3:6f28])
 by smtp.gmail.com with ESMTPSA id m14sm3289719wrs.56.2021.07.29.05.50.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jul 2021 05:50:14 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3
 test
To: "Chen, Guchun" <Guchun.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Gao, Likun" <Likun.Gao@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210729104945.25312-1-guchun.chen@amd.com>
 <f862776c-a329-19f6-34bb-68f5ff5f6b50@amd.com>
 <DM5PR12MB2469251ADA20439E8A116209F1EB9@DM5PR12MB2469.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <37859d3a-dbb7-88f7-e932-0086eb0ca95f@gmail.com>
Date: Thu, 29 Jul 2021 14:50:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB2469251ADA20439E8A116209F1EB9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Guchun,

see below.

Am 29.07.21 um 14:39 schrieb Chen, Guchun:
> [Public]
>
> Hi Christian,
>
> Thanks for your feedback.
>
> Originally, drm_sched_fini is part of amdgpu_fence_driver_hw_fini, I did not move it.

Yeah, not saying that this is your fault, you should just clean that up 
more thoughtfully.

> Former patch " cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence " has dropped amdgpu_fence_driver_suspend, and called amdgpu_fence_driver_hw_fini instead in function amdgpu_device_suspend. I checked the code difference between  amdgpu_fence_driver_hw_fini and amdgpu_device_suspend, they are almost the same except drm_sched_fini part, so I think we can leave it as it is, while skipping the execution of drm_sched_fini in suspend/resume case.

And exactly that's a bad idea and the reason why I already said during 
the review of patch "cd87a6dcf6af drm/amdgpu: adjust fence driver enable 
sequence" that the callers of those functions need to be adjusted instead.

1. If not already done please rename the functions as Hawking suggested 
as well, they should be amdgpu_fence_driver_hw_(init|fini) and 
amdgpu_fence_driver_sw_(init|fini).

2. Remove drm_sched_fini() from amdgpu_fence_driver_hw_fini() and add 
that to sw_fini instead.

3. Adjust the callers so that we have the same functionality as before. 
E.g. by calling both hw_fini and sw_fini at the same time.

Regards,
Christian.

>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Thursday, July 29, 2021 7:11 PM
> To: Chen, Guchun <Guchun.Chen@amd.com>; amd-gfx@lists.freedesktop.org; Gao, Likun <Likun.Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: avoid over-handle of fence driver fini in s3 test
>
> Am 29.07.21 um 12:49 schrieb Guchun Chen:
>> In amdgpu_fence_driver_hw_fini, no need to call drm_sched_fini to stop
>> scheduler in s3 test, otherwise, fence errors will occur after resume.
>> So introduce a new parameter to distingiush the case in this API.
> NAK, the problem is rather that drm_sched_fini() is part of the sw shutdown and should never be called during hw_fini.
>
> Christian.
>
>> Fixes: cd87a6dcf6af drm/amdgpu: adjust fence driver enable sequence
>> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 8 +++++---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h   | 2 +-
>>    3 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index b1d2dc39e8be..aaff8ebbb7dc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -3844,7 +3844,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>>    		else
>>    			drm_atomic_helper_shutdown(adev_to_drm(adev));
>>    	}
>> -	amdgpu_fence_driver_hw_fini(adev);
>> +	amdgpu_fence_driver_hw_fini(adev, false);
>>    
>>    	if (adev->pm_sysfs_en)
>>    		amdgpu_pm_sysfs_fini(adev);
>> @@ -3941,7 +3941,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>>    	/* evict vram memory */
>>    	amdgpu_bo_evict_vram(adev);
>>    
>> -	amdgpu_fence_driver_hw_fini(adev);
>> +	amdgpu_fence_driver_hw_fini(adev, adev->in_suspend);
>>    
>>    	amdgpu_device_ip_suspend_phase2(adev);
>>    	/* evict remaining vram memory
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> index 49c5c7331c53..7e6a73c2919d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>> @@ -515,14 +515,15 @@ int amdgpu_fence_driver_init(struct amdgpu_device *adev)
>>    }
>>    
>>    /**
>> - * amdgpu_fence_driver_fini - tear down the fence driver
>> + * amdgpu_fence_driver_hw_fini - tear down the fence driver
>>     * for all possible rings.
>>     *
>>     * @adev: amdgpu device pointer
>> + * @in_reset: indicator to distingiush device removal case or s3 case
>>     *
>>     * Tear down the fence driver for all possible rings (all asics).
>>     */
>> -void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev)
>> +void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev, bool
>> +in_reset)
>>    {
>>    	int i, r;
>>    
>> @@ -531,8 +532,9 @@ void amdgpu_fence_driver_hw_fini(struct
>> amdgpu_device *adev)
>>    
>>    		if (!ring || !ring->fence_drv.initialized)
>>    			continue;
>> -		if (!ring->no_scheduler)
>> +		if (!ring->no_scheduler && !in_reset)
>>    			drm_sched_fini(&ring->sched);
>> +
>>    		/* You can't wait for HW to signal if it's gone */
>>    		if (!drm_dev_is_unplugged(&adev->ddev))
>>    			r = amdgpu_fence_wait_empty(ring); diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> index 27adffa7658d..42cbecfc26a3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> @@ -115,7 +115,7 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring,
>>    int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>>    				   struct amdgpu_irq_src *irq_src,
>>    				   unsigned irq_type);
>> -void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>> +void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev, bool
>> +in_reset);
>>    void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
>>    void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>>    int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence
>> **fence,
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
