Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2247D0E6C1
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 08:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E8810E0DE;
	Mon, 21 Oct 2024 08:12:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YXujvk88";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F31C10E0DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 08:12:46 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4316f3d3c21so11169285e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 01:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729498364; x=1730103164; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Cb82qzjsHTkTx88ttM0Q3XxLDg59w6tbpZYbH+HpqU=;
 b=YXujvk88wR+MfN28KTqTUMIrQIZbCBsQ6ku3viaC0lH7zCTJiC3R8ojmS0JTB4UdnH
 LpIZE+GlWd1aAYPbw/+jsloBkg1Jo9Cwfyer3oFzN8UIj3kKyCdSQX69OeK0bMZcOnF/
 lwm17HSKjmXwLsbxydRFDAam3xaCyQWSIZCfTS1TcJuyCuJQW5i8AmChlAMEXIxRdZrT
 ULj3s4vBnIuaMm6o6bWojEt5PKpDooXJS4GKkiDPOkYlroa+3EDAm2eCT7N3IPX878ef
 lEGp9rBswUaDaNjo5fuLHQBThFx183kOFp8LKUwkDzg4Kc70cUcbN+p09zkdFOA7iHmJ
 82xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729498364; x=1730103164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Cb82qzjsHTkTx88ttM0Q3XxLDg59w6tbpZYbH+HpqU=;
 b=cfwg4wSHOhGhT98RBtg+GFNceS3363zZ+O3NiT9+1wrkfltLLJjtnvVBNbt23IRTu0
 PoxkD+r5iDcJ+uhKK4d/kQ6lfpUF/1HqkBPsZmGNOo8NzLpGF8eUMZp96+yUtWFRzWKg
 Vf7cmuiX8ksT4iPQLqATbbjjlwjSL/WXb7vn1K6Y68Z3aE/tUMPX9F/22nY2I3CpjPW3
 55T3gFHIKNQrr+57WeO09CKsNBGX2dTnZBUWiQxb3IqTLFFtj6G1lk3IyKcZYQWYaseH
 9SbLHu4uFLpZwM5xh0VuI72J5rkB3+WcL/tls2fCOEMdj1J6+Yr+GAxqonFjNDcb4oTn
 H5bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdlciD91UubUXrzEOtlCibpUW601txOxt6PaJFPYzncRdV1uYkrBjJSRp0zDqTI8iBrG6GYDUs@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8FyQZtthh9IMQglGw4j7C98FFPhg8kz5lStxsnh4k2eBaJtVi
 pIfRHls6kNpncz9mRYh9YLR3T15xkO9/Iq65INXXj/aeYKh5vLi8
X-Google-Smtp-Source: AGHT+IGJTrfpQfyxfYDHWbBmoBXCHX1BHRo1jNeAhZ96y2hGNHKQ9pX9H/suwQzY4hp3eEHngPsblA==
X-Received: by 2002:a05:600c:4e12:b0:42c:ae30:fc4d with SMTP id
 5b1f17b1804b1-431616360afmr79959015e9.7.1729498364124; 
 Mon, 21 Oct 2024 01:12:44 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f570da9sm49244595e9.5.2024.10.21.01.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 01:12:43 -0700 (PDT)
Message-ID: <efb4b082-d518-46b6-adda-776458772e1c@gmail.com>
Date: Mon, 21 Oct 2024 10:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: fix the hang caused by the write reorder to
 fence_addr
To: Philip Yang <yangp@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20241017083457.183631-1-Victor.Zhao@amd.com>
 <1a80e1fe-ef51-4ed4-a851-21d3c9da6c7f@amd.com>
 <1f252468-10d0-00a6-3e43-52a3672733a1@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <1f252468-10d0-00a6-3e43-52a3672733a1@amd.com>
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

Am 18.10.24 um 23:59 schrieb Philip Yang:
> On 2024-10-18 14:28, Felix Kuehling wrote:
>>
>> On 2024-10-17 04:34, Victor Zhao wrote:
>>> make sure KFD_FENCE_INIT write to fence_addr before 
>>> pm_send_query_status
>>> called, to avoid qcm fence timeout caused by incorrect ordering.
>>>
>>> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h | 2 +-
>>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> index b2b16a812e73..d9264a353775 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>>> @@ -2254,6 +2254,7 @@ static int unmap_queues_cpsch(struct 
>>> device_queue_manager *dqm,
>>>           goto out;
>>>         *dqm->fence_addr = KFD_FENCE_INIT;
>>> +    mb();
>>>       pm_send_query_status(&dqm->packet_mgr, dqm->fence_gpu_addr,
>>>                   KFD_FENCE_COMPLETED);
>>>       /* should be timed out */
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>> index 09ab36f8e8c6..bddb169bb301 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
>>> @@ -260,7 +260,7 @@ struct device_queue_manager {
>>>       uint16_t        vmid_pasid[VMID_NUM];
>>>       uint64_t        pipelines_addr;
>>>       uint64_t        fence_gpu_addr;
>>> -    uint64_t        *fence_addr;
>>> +    volatile uint64_t    *fence_addr;
>>
>> [+Christian]
>>
>> Is the volatile keyword really needed here? I just saw other patches 
>> removing volatile in some places because it's not sufficient, and not 
>> needed if you use memory barriers correctly.
>
> After reading kernel memory barrier document and below link, I think 
> we need both volatile type and memory barrier, to guarantee F/W get 
> the updated fence value. This fixes an CP hang issue on SRIOV.
>
> https://stackoverflow.com/questions/75750110/volatile-vs-memory-barriers#:~:text=volatile%20will%20make%20sure%20that,not%20reorder%20writes%20or%20reads.
>

No, that isn't correct. Using volatile is considered harmful and almost 
never correct, see here 
https://docs.kernel.org/process/volatile-considered-harmful.html

Placing appropriate memory barriers must be sufficient or otherwise 
there is a rather bad platform or compiler bug lurking around.

Regards,
Christian.

> Regards,
>
> Philip
>
>>
>> Regards,
>>   Felix
>>
>>
>>>       struct kfd_mem_obj    *fence_mem;
>>>       bool            active_runlist;
>>>       int            sched_policy;

