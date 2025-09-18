Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2519CAC597
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 07:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FE9E10E0EA;
	Thu, 18 Sep 2025 07:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="STPx1cxW";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B2B10E0EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 07:47:28 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3e7636aa65fso502494f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 00:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1758181647; x=1758786447;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4cVayBmlBZKlEdI8NnTv2ri+5xIKL6vbO8eWaz+McoY=;
 b=STPx1cxWJhgmudCXexXmE0qG0Jyalzzv5XcWzgfga/6oiwSM1sq0oGhLU9VCb2et3X
 SAPp1qLl5L6VAJR3AkBwkwC1IHON6JYXJQ4S3V9LFCu+UiqsZN/WWqwi/7vGD78LHfr6
 oRXYmXg9WRKuqDR5h+QzzJqKGb0n1Qk076THvZibxP1okUBnThWc3tv4Xw5LveJywtB8
 yHECRfLbA2sKknH70FFZgzTFG6H+/Boa1JuFM7rKb/knCkcBpCxYlQ439hxaxJmWEWMa
 ZD0yZzfvUiinpV/q05QlbMYxibtxKlPTyyIST1rNag5na60swTh5sXAU5BSw3y+F922M
 ECnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758181647; x=1758786447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4cVayBmlBZKlEdI8NnTv2ri+5xIKL6vbO8eWaz+McoY=;
 b=bnXjtXzDPjL+LwSV3gIr9x5vdFSSGX74XX/H/AKCum/Z8xsIhOCRhCPSOFKVzhScHG
 7ky9+4qW2isHlJUwR/bQJBhCRxnZgESS2T1FAnU5rOz78H+bBA1nDe8vmeUU/YXMpHyb
 ivoLP3Y6rz32Uc8kLDNCrZcKh1qSL31GkqsuS5LXRZe8jfoJCjjt9Xi1fsmAATUkXEvM
 JiGL5blTD8s8xwSn3YHGF7V75eSCW3K8J1t+Gy9+R8FdD+GCwf/O7/iAoEQ+t4p+oVRr
 GuAyECDRX44J6OV5FxX1bK8mOfqquQWrs1q5N4oU4v91jszzHikMsWXtpFu9Q0Pl7KD8
 V18Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEbBJ2STDuBYLnv53zfciX5JeLul4g+t8Jdm+nu1RJdDN9GyyCsNENKghgNWlZERmcMEzaz2L/@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6SPPKovGBOZV+3taUXof4sH3el/e4ncAXRiBi82J5WU31oVwI
 ZWM6L1VSL0Yw09Nlc/bVvxwYb00Lr+SjkGv4dU2r8M7RVdsCm43WLJqTwZTjYYBYhik=
X-Gm-Gg: ASbGncvkOByRvvMywm3O6TR6LxG4KBxHyLExEYA2Kmh5bMsg4/4GbOtNtLSDW8Arjpa
 xRpgWVNinlvl5Q0l+8pUzSEVEfces8y7Pb0IBT4fTckckIdbtRnk25cgVPq2MnH8QLpDIA3/Anl
 dNOsAGDlXtp3w+d9qavc8pUWHYERP7T3/NIdF6lf1onS5NV8kcs5vvrMeKf6+aFluwD0rn+691w
 eaTjHfT245jYkCI4yIhYalzIJhhuRLCsgzdtJHJmaF7bWyzPFFVifVtLn2pQnDzZ0FgzRB4NbcJ
 QD92qp/dDyZH3fmnJB7SFHyr0vujM6VlXkni12ZO7gheHMNjBYTP7/A766FPw2I/QNrwp/cNBu1
 T7ealglv+vtoWx7PaydT3+TC6oU+4BLlCvbBh5CqU3od2Ik/kkRBzAA==
X-Google-Smtp-Source: AGHT+IFkdj6l0xAO7dKcEpJBkqrgW6AZ0HoIGi2ZDQih1QAEe5O+tx4vv3dSDNlgvHNcMG2b/yo4MA==
X-Received: by 2002:a5d:5849:0:b0:3e7:48ab:7660 with SMTP id
 ffacd0b85a97d-3ecdf9e0491mr4684268f8f.27.1758181647000; 
 Thu, 18 Sep 2025 00:47:27 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f4f9f4e4sm30297965e9.13.2025.09.18.00.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Sep 2025 00:47:26 -0700 (PDT)
Message-ID: <31124176-c73b-426d-bb35-793161b44a68@ursulin.net>
Date: Thu, 18 Sep 2025 08:47:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix pipelining jobs with timeline syncobj
 dependencies
To: David Rosca <david.rosca@amd.com>, amd-gfx@lists.freedesktop.org
References: <20250917095939.41615-2-david.rosca@amd.com>
 <c1f6d69f-7f71-4d6d-b475-fe22f5316ca3@ursulin.net>
 <74ed415e-2938-4b3c-ab68-4b074d35e4ba@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <74ed415e-2938-4b3c-ab68-4b074d35e4ba@amd.com>
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


On 17/09/2025 11:54, David Rosca wrote:
> Hi,
> 
> On 17. 09. 25 12:15, Tvrtko Ursulin wrote:
>>
>> Hi,
>>
>> On 17/09/2025 10:59, David Rosca wrote:
>>> drm_syncobj_find_fence returns fence chain for timeline syncobjs.
>>> Scheduler expects normal fences as job dependencies to be able to
>>> determine whether the fences come from the same entity or sched
>>> and skip waiting on them.
>>> With fence chain as job dependency, the fence will always be
>>> waited on forcing CPU round-trip before starting the job.
>>
>> Interesting! I was sending patches to fix this differently last year 
>> or so, by making the scheduler use dma_fence_array for tracking 
>> dependencies and relying on dma_fence_unwrap_merge to unwrap, coalesce 
>> contexts and only keep the latest fence for each. But I did not have a 
>> good story to show for which use cases it helped. So I am curious if 
>> you could share which scenario you found gets an improvement from your 
>> patch?
> 
> The scenario I am trying to fix is very simple to reproduce with Vulkan 
> when using timeline semaphore to sync submissions on the same queue (eg. 
> each submit waiting on value signaled by previous submit). I have 
> noticed this issue with FFmpeg Vulkan video code, but it will happen 
> with any Vulkan app using this pattern.

Still out of curiosity, is the performance loss from the CPU round-trip 
something you are able to measure?

Btw your patch is I think fine, so:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

But you will probably need Christian to ack it.

Regards,

Tvrtko

>>> Signed-off-by: David Rosca <david.rosca@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 10 ++++++++--
>>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/ 
>>> drm/amd/amdgpu/amdgpu_cs.c
>>> index 2e93d570153c..779c11227a53 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>>> @@ -29,6 +29,7 @@
>>>   #include <linux/pagemap.h>
>>>   #include <linux/sync_file.h>
>>>   #include <linux/dma-buf.h>
>>> +#include <linux/dma-fence-unwrap.h>
>>>     #include <drm/amdgpu_drm.h>
>>>   #include <drm/drm_syncobj.h>
>>> @@ -450,7 +451,8 @@ static int amdgpu_syncobj_lookup_and_add(struct 
>>> amdgpu_cs_parser *p,
>>>                        uint32_t handle, u64 point,
>>>                        u64 flags)
>>>   {
>>> -    struct dma_fence *fence;
>>> +    struct dma_fence *fence, *f;
>>> +    struct dma_fence_unwrap iter;
>>>       int r;
>>>         r = drm_syncobj_find_fence(p->filp, handle, point, flags, 
>>> &fence);
>>> @@ -460,7 +462,11 @@ static int amdgpu_syncobj_lookup_and_add(struct 
>>> amdgpu_cs_parser *p,
>>>           return r;
>>>       }
>>>   -    r = amdgpu_sync_fence(&p->sync, fence, GFP_KERNEL);
>>> +    dma_fence_unwrap_for_each(f, &iter, fence) {
>>> +        if (!r)
>>> +            r = amdgpu_sync_fence(&p->sync, f, GFP_KERNEL);
>>> +    }
>>> +
>>>       dma_fence_put(fence);
>>>       return r;
>>>   }
>>

