Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD729C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 08:47:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A9110F99D;
	Tue, 16 Apr 2024 08:47:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PGKm1zMQ";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32DD610FDCC
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 08:47:12 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-41884e96fe0so6057735e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713257230; x=1713862030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=btQgHTUQaXcEWeUisSXy9HmPah3noSGkuNpBrngBHUM=;
 b=PGKm1zMQrN9WVz6zTdgeNmlLzgxIZ8Qek9KsbeUGnkwYsTsvpsqRtdecoMxUkUKGdu
 TlWQKXzBaj0KSNBe7WVlLXmReVt8OiJWuchc4J62dY04LNf0lPewyaWxuoFRtCsYCvw7
 JGqq+CZS/tuEGs74wTFK3LUoZdRqfhkhuk3Qhg3Gqxhoo40WFr47HOp4VYfNlYWL6L+A
 OCH/758USTHN/HTyXUeDb0xn9lps2Q7D2nHs2tgPLIJgzIQ8+Q8eY/dghMmp9r32pLGT
 gl06EWFak9ESWKP0mYDYAxCahn1TlPMv7rIFlN3D6zPzpsZWX/9+XtupeBxFPrVtjoUV
 upSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713257230; x=1713862030;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=btQgHTUQaXcEWeUisSXy9HmPah3noSGkuNpBrngBHUM=;
 b=jeFh/4X7JEh3Ueqe3uH+BlbZA3pbMtV+DPzUJJfNbusSlX2KsnwNxL4RMhaCw+vWh+
 egmGAEydqeD1CY9MWaPnYufFBBjNSyFmxj3Nh9Wp1wNlgukX50jXHedphx9M0iB59w/1
 Xe842BglwN0p1t6lV5TFF9s3ybJX6XGxHicUiDxW8GQaKbXYJY9k6SQS/PwvfaOfmzMt
 orwTX/60InRimfLsbBeNTAbTrl88NGc7IhEQWyDlHgGFx3IVU1JWkGZueGmRQht+VFNV
 n5qr3vFUIIKWisv1AEGGdXjEh74LsQIwzunNz9TlhgPCNKKXgq6ET/3ye3yZyYRDABPX
 uytw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6kj6e2BzmUdZnD7RZW6S8GvHilpwcTvSM2kisHrsx7sSN1jX6a7wgP/wm9dHI6zoTNcQa96cabF6ykCjqNtlD9JovdwkMYY1mqAfJaA==
X-Gm-Message-State: AOJu0Yy//y1WsT879d9y8zPpwwFWXx3OjJJfUs6f9fhc3rv0JipJ6bIK
 nx8K1tC98QPMj/3dczencvqjVX36b1t/WVSbxbqwQ6x2GMaSQGMb
X-Google-Smtp-Source: AGHT+IFMF6H7ss9oDJhacTpEJhINiKXzPyokM325sZqepGMhhIYMPCIZUUh0NItk6qgg/83+4sxm/w==
X-Received: by 2002:a05:600c:198b:b0:418:6b23:c02 with SMTP id
 t11-20020a05600c198b00b004186b230c02mr3234631wmq.16.1713257230140; 
 Tue, 16 Apr 2024 01:47:10 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 s19-20020adfe013000000b00346bb778e8bsm14091979wrh.5.2024.04.16.01.47.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 01:47:09 -0700 (PDT)
Message-ID: <16e6f425-ebd8-48f9-b6eb-700e3a69ca41@gmail.com>
Date: Tue, 16 Apr 2024 10:47:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: Fix incorrect return value
To: "Chai, Thomas" <YiPeng.Chai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Zhou1, Tao"
 <Tao.Zhou1@amd.com>, "Li, Candice" <Candice.Li@amd.com>,
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>
References: <20240412085546.1459735-1-YiPeng.Chai@amd.com>
 <3110de1a-9379-4058-8a65-5d50b04fba92@gmail.com>
 <CH2PR12MB4215DEA1C70A9B18DCD376FCFC092@CH2PR12MB4215.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CH2PR12MB4215DEA1C70A9B18DCD376FCFC092@CH2PR12MB4215.namprd12.prod.outlook.com>
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

Well multiple things to consider here.

This is clearly not called from the interrupt, otherwise locking a mutex 
would be illegal. So question is who is calling this? And can the 
function be called from different threads at the same time?

As far as I can see you don't take that into account in the patch.

When there is some kind of single threaded worker handling the RAS 
errors instead then I strongly suggest to solve this issue in the worker.

As far as I can see hacking around a broken caller by inserting 
amdgpu_vram_mgr_query_page_status() inside 
amdgpu_vram_mgr_reserve_range() is an absolutely no-go. That is really 
bad coding style.

What could be is that the VRAM manager needs to be able to provide 
atomic uniqueness for the reserved addresses, e.g. that 
amdgpu_vram_mgr_reserve_range() can be called multiple times with same 
address from multiple threads, but then we would need a different data 
structure than a linked list which is protected by a mutex.

Regards,
Christian.

Am 15.04.24 um 06:04 schrieb Chai, Thomas:
> [AMD Official Use Only - General]
>
> Hi Christian:
>     If an ecc error occurs at an address, HW will generate an interrupt to SW to retire all pages located in the same physical row as the error address based on the physical characteristics of the memory device.
>     Therefore, if other pages located on the same physical row as the error address also occur ecc errors later, HW will also generate multiple interrupts to SW to retire these same pages again, so that amdgpu_vram_mgr_reserve_range will be called multiple times to reserve the same pages.
>
>      I think it's more appropriate to do the status check inside the function. If the function entry is not checked, people who are not familiar with this part of the code can easily make mistakes when calling the function.
>
>
> -----------------
> Best Regards,
> Thomas
>
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Friday, April 12, 2024 5:24 PM
> To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>
> Subject: Re: [PATCH V2] drm/amdgpu: Fix incorrect return value
>
> Am 12.04.24 um 10:55 schrieb YiPeng Chai:
>> [Why]
>>     After calling amdgpu_vram_mgr_reserve_range multiple times with the
>> same address, calling amdgpu_vram_mgr_query_page_status will always
>> return -EBUSY.
>>     From the second call to amdgpu_vram_mgr_reserve_range, the same
>> address will be added to the reservations_pending list again and is
>> never moved to the reserved_pages list because the address had been
>> reserved.
> Well just to make it clear that approach is a NAK until my concerns are solved.
>
> Regards,
> Christian.
>
>> [How]
>>     First add the address status check before calling
>> amdgpu_vram_mgr_do_reserve, if the address is already reserved, do
>> nothing; If the address is already in the reservations_pending list,
>> directly reserve memory; only add new nodes for the addresses that are
>> not in the reserved_pages list and reservations_pending list.
>>
>> V2:
>>    Avoid repeated locking/unlocking.
>>
>> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 25 +++++++++++++-------
>>    1 file changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 1e36c428d254..a636d3f650b1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -317,7 +317,6 @@ static void amdgpu_vram_mgr_do_reserve(struct
>> ttm_resource_manager *man)
>>
>>                dev_dbg(adev->dev, "Reservation 0x%llx - %lld, Succeeded\n",
>>                        rsv->start, rsv->size);
>> -
>>                vis_usage = amdgpu_vram_mgr_vis_size(adev, block);
>>                atomic64_add(vis_usage, &mgr->vis_usage);
>>                spin_lock(&man->bdev->lru_lock);
>> @@ -340,19 +339,27 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
>>                                  uint64_t start, uint64_t size)
>>    {
>>        struct amdgpu_vram_reservation *rsv;
>> +     int ret = 0;
>>
>> -     rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
>> -     if (!rsv)
>> -             return -ENOMEM;
>> +     ret = amdgpu_vram_mgr_query_page_status(mgr, start);
>> +     if (!ret)
>> +             return 0;
>>
>> -     INIT_LIST_HEAD(&rsv->allocated);
>> -     INIT_LIST_HEAD(&rsv->blocks);
>> +     if (ret == -ENOENT) {
>> +             rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
>> +             if (!rsv)
>> +                     return -ENOMEM;
>>
>> -     rsv->start = start;
>> -     rsv->size = size;
>> +             INIT_LIST_HEAD(&rsv->allocated);
>> +             INIT_LIST_HEAD(&rsv->blocks);
>> +
>> +             rsv->start = start;
>> +             rsv->size = size;
>> +     }
>>
>>        mutex_lock(&mgr->lock);
>> -     list_add_tail(&rsv->blocks, &mgr->reservations_pending);
>> +     if (ret == -ENOENT)
>> +             list_add_tail(&rsv->blocks, &mgr->reservations_pending);
>>        amdgpu_vram_mgr_do_reserve(&mgr->manager);
>>        mutex_unlock(&mgr->lock);
>>

