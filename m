Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FDFC05027
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Feb 2023 09:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86FF410E1C3;
	Fri, 17 Feb 2023 09:37:56 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FAB610EF3E
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 09:37:55 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id 12so415446wmk.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Feb 2023 01:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xO4Xo5R65MkOcJXYXDaPweXd6lZm3tqY9FikZJYvqP8=;
 b=aVWmc6eHKrah4+0ECucfNLfZf55JnmS0UT5CRkaNmyrHwL/KFHtfrSFkIE3z2n8RGv
 qTZH5v1xAhHSbqL3xEPQC9hh5HRtrjQhGhO4b/8R4qoiRJ2B1rE/pR+7LuvHSIa9TYYs
 bVhpyvwhGxqZu6GnGpiQlJu8vBi9Zskf5lbsOg6ObdMmBdMFl2h0wgdomCL1asVva2/S
 Eia0K7QRdisKxs08Uyi4/HNomDnwC3Rsi6jC4ni01kpiyodYkbJ/+lVQyWZuqam6krrF
 uLnGTUWHocJiGDOPWVJkt28EYboe0TEHkIsAFJDgjFftrrJWdAu2idMtTyMSG16UTDr4
 LefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xO4Xo5R65MkOcJXYXDaPweXd6lZm3tqY9FikZJYvqP8=;
 b=6v2liYbFsAqkITwX9DNKWjT3dm4MI0AaLQA4J1zYVOGC1fWpmVNpqcIc1qgiJ/c8Gn
 rAmQacTCnSt+lwRnNCzPmC/xnBv9/DJL2UdGtMja95rnUdqnLY4iGKO9WEvHKIT/CHSv
 qA3/d+BFSeowFV1zXJJBWmHsm7o+u6pu3rImpkCIatT01ixxqVpqTq9j1R8z73dd839Q
 juWpZotMF0xBnh3JbQ34vs1OfKxDEUm8EweNbJqFPcXW1YZ8RusQuTRSHpVv1tKudnX9
 IaUpvES1xglc+13+HIyqOsNIxLQeoFdbxi3KMM7FHMxdHi/0r0+38uvd+yOW1LLjlMKg
 pFHA==
X-Gm-Message-State: AO0yUKWFj1GV4GV57qYkI0urMzQd6gSMILNNv3Dg9xjQUDpS1H//GyDr
 4BRRj3RluAgiIOnsnvLdpFmUPLw72xMXNA==
X-Google-Smtp-Source: AK7set/y9LucwaNt1ZnRJUT1PZd4fIN+/VqJLUGn66L4yLoQMAblhIhWilX42iNjCwNnViABeUvgMg==
X-Received: by 2002:a05:600c:34c2:b0:3db:8de:6993 with SMTP id
 d2-20020a05600c34c200b003db08de6993mr4464381wmq.4.1676626673717; 
 Fri, 17 Feb 2023 01:37:53 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:18f0:5eac:9f10:52b1?
 ([2a02:908:1256:79a0:18f0:5eac:9f10:52b1])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a1c4c06000000b003dd9232f036sm680249wmf.23.2023.02.17.01.37.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Feb 2023 01:37:53 -0800 (PST)
Message-ID: <4138e36d-16a3-0165-5ec9-1fb840287093@gmail.com>
Date: Fri, 17 Feb 2023 10:37:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using drm
 buddy
Content-Language: en-US
To: "Xiao, Shane" <shane.xiao@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <20230214111851.2525197-1-shane.xiao@amd.com>
 <ca40db72-6c04-e3cd-38f9-3254f37c850a@amd.com>
 <DM4PR12MB526136D00F81419EEFCE47579DA29@DM4PR12MB5261.namprd12.prod.outlook.com>
 <0a5fd1ae-45b0-96bb-5160-a34b57fc6a2a@amd.com>
 <DM4PR12MB52616659C39CB1242A4AD8B89DA39@DM4PR12MB5261.namprd12.prod.outlook.com>
 <62ca76cc-a553-21c2-9538-03cefb7b02ac@gmail.com>
 <46fd3add-e02e-9a88-f672-3ef09da1aced@amd.com>
 <DM4PR12MB5261B9EFFEFB88A558B7E3C39DA09@DM4PR12MB5261.namprd12.prod.outlook.com>
 <ee42c89e-746b-a142-173f-c4d4ba847859@amd.com>
 <c57f334a-e056-f124-768c-8c1cb15b0617@amd.com>
 <DM4PR12MB52610E32EC8A75320FBC95849DA19@DM4PR12MB5261.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM4PR12MB52610E32EC8A75320FBC95849DA19@DM4PR12MB5261.namprd12.prod.outlook.com>
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.02.23 um 04:11 schrieb Xiao, Shane:
>
>> -----Original Message-----
>> From: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
>> Sent: Thursday, February 16, 2023 3:24 PM
>> To: Koenig, Christian <Christian.Koenig@amd.com>; Xiao, Shane
>> <shane.xiao@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>;
>> Christian König <ckoenig.leichtzumerken@gmail.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using
>> drm buddy
>>
>> This patch seems to pass the rocm memory stress test case.
>> Reviewed-by: Arunpravin Paneer Selvam
>> <Arunpravin.PaneerSelvam@amd.com>
> Hi Christian,
>
> Do you think we should upstream this patch?

Arun already gave his rb for this, I only see one option for further 
improvements and that is to avoid the "% pages_per_block".

I think pages_per_block is a power of two (but you need to double check 
this), so you can use something like "& (pages_per_block - 1)" instead 
which should have less overhead.

But that's only a minimal optimization. Either way feel free to push 
this to amd-staging-drm-next with Arun's rb added.

Regards,
Christian.

>
> Best Regards,
> Shane
>
>
>> On 2/16/2023 12:39 PM, Christian König wrote:
>>> Am 16.02.23 um 07:48 schrieb Xiao, Shane:
>>>>> -----Original Message-----
>>>>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>>>>> Sent: Thursday, February 16, 2023 6:19 AM
>>>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>; Xiao, Shane
>>>>> <shane.xiao@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>;
>>>>> Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
>>>>> Cc: amd-gfx@lists.freedesktop.org
>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when
>>>>> using drm buddy
>>>>>
>>>>>
>>>>> Am 2023-02-15 um 05:44 schrieb Christian König:
>>>>>> Am 15.02.23 um 03:51 schrieb Xiao, Shane:
>>>>>>> For public review
>>>>>>>> -----Original Message-----
>>>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>>> Sent: Wednesday, February 15, 2023 3:02 AM
>>>>>>>> To: Xiao, Shane <shane.xiao@amd.com>; Paneer Selvam,
>> Arunpravin
>>>>>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation
>>>>>>>> when using drm buddy
>>>>>>>>
>>>>>>>> Am 14.02.23 um 15:53 schrieb Xiao, Shane:
>>>>>>>>>> -----Original Message-----
>>>>>>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>>>>>>> Sent: Tuesday, February 14, 2023 8:41 PM
>>>>>>>>>> To: Xiao, Shane <shane.xiao@amd.com>; brahma_sw_dev
>>>>>>>>>> <brahma_sw_dev@amd.com>
>>>>>>>>>> Cc: Paneer Selvam, Arunpravin
>>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>>>>>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation
>>>>> when
>>>>>>>>>> using drm buddy
>>>>>>>>>>
>>>>>>>>>> Am 14.02.23 um 12:18 schrieb Shane Xiao:
>>>>>>>>>>> Since the VRAM manager changed from drm mm to drm buddy.
>> It's
>>>>> not
>>>>>>>>>>> necessary to allocate 2MB aligned VRAM for more than 2MB
>>>>>>>>>>> unaligned size, and then do trim. This method improves the
>>>>>>>>>>> allocation efficiency and reduces memory fragmentation.
>>>>>>>>>> Well that is a trade off.
>>>>>>>>>>
>>>>>>>>>> Allocating the BO as one contiguous chunk and then trimming is
>>>>>>>>>> beneficial because if we then later need it contiguous we don't
>>>>>>>>>> need to re-allocate and copy. This can be needed to display
>>>>>>>>>> something for
>>>>>>>> example.
>>>>>>> Hi Christian,
>>>>>>>
>>>>>>> This case means that you allocate BO that is unnecessary to be
>>>>>>> continuous at first time, and latter the BO should be continuous.
>>>>>>> I'm not familiar with display. Could you give me a few more
>>>>>>> specific examples ?
>>>>>> On most generations DCE/DCN hardware needs the buffer contiguous
>> to
>>>>> be
>>>>>> able to scanout from it.
>>>>>>
>>>>>> Only newer APUs can use S/G to scanout from system memory pages.
>>>>>>
>>>>>>>>> Yes, I agree that one contiguous chunk may get beneficial
>>>>>>>>> sometimes.
>>>>>>>>> But as far as I know, you cannot guarantee that
>>>>> amdgpu_vram_mgr_new
>>>>>>>> can get one contiguous chunk  if you don't set
>>>>>>>> TTM_PL_FLAG_CONTIGUOUS flags.
>>>>>>>>> For example, if you want to allocate 4M+4K BO, it will allocate
>>>>>>>>> one 4M block
>>>>>>>> + one 2M block which is unnecessary to be continuous, then 2M
>>>>>>>> + block
>>>>>>>> will be
>>>>>>>> trimmed.
>>>>>>>>
>>>>>>>> Oh, that's indeed not something which should happen. Sounds more
>>>>>>>> like a bug fix then.
>>>>>>> Yes, I think this case should not be happened.
>>>>>>> Actually, I'm not sure that why the allocated BO should be aligned
>>>>>>> with pages_per_block, which is set to 2MB by default.
>>>>>>> Does this help improve performance when allocating 2M or above BO?
>>>>>>>    From my point of view, the TLB may be one of reason of this. But
>>>>>>> I'm not sure about this.
>>>>>> Yes, we try to use allocations which are as contiguous as much as
>>>>>> possible for better TLB usage.
>>>>>>
>>>>>> Especially for some compute use cases this can make a >20%
>>>>>> performance difference.
>>>>> We actually found that >2MB virtual address alignment was hurting
>>>>> performance due to cache line aliasing. So we can't take advantage
>>>>> of  >2MB pages in our page tables.
>>>>>
>>>>> Regards,
>>>>>      Felix
>>>> Yes, if we want to take advantage of 2M TLB usage, we should keep
>>>> virtual address aligned.
>>>>
>>>> As you have mentioned that cache line aliasing issue, I'm confused
>>>> about this.
>>>> If 2MB aligned VA get the right PA from TLB or page table and the
>>>> cache line addressing mode is not changed, the cache line aliasing
>>>> issue should not happen here.
>>>> Is there something wrong with my understanding? Or maybe there are
>>>> some backgrounds that I didn't know.
>>> The problem is with virtual address alignments > 2MiB (or whatever the
>>> big cache line size is).
>>>
>>> Let's assume an example where you have a lot of buffer each 66MiB in
>>> size. When you align those to 2MiB in the virtual address space you
>>> end up with
>>>
>>> 64MiB..2MiB..62MiB..4MiB..60MiB... etc...
>>>
>>> In your address space. In this configuration each 2MiB cache line is
>>> equally used.
>>>
>>> But if you align the buffers to say the next power of two (128MiB) you
>>> end up like this:
>>>
>>> 64MiB..2MiB..62MiB hole..64MiB..2MiB..62MiB hole... etc....
>>>
>>> In this case the first 2MiB cache line of each buffer is used twice as
>>> much as all the other cache lines. This can hurt performance very badly.
>>>
>>> Regards,
>>> Christian.
>>>
>>>> Best Regards,
>>>> Shane
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> Best Regards,
>>>>>>> Shane
>>>>>>>
>>>>>>>>>> On the other hand I completely agree allocating big and then
>>>>>>>>>> trimming creates more fragmentation than necessary.
>>>>>>>>>>
>>>>>>>>>> Do you have some test case which can show the difference?
>>>>>>>>> I have use rocrtst to show the difference.
>>>>>>>>> The attachment is shown that after applying this patch, the
>>>>>>>>> order <
>>>>>>>>> 9 total
>>>>>>>> vram size decrease from 99MB to 43MB.
>>>>>>>>> And the latter has more higher order block memory.
>>>>>>>> Arun can you take a look? That problem here sounds important.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>>>> BTW: No need to discuss that on the internal mailing list,
>>>>>>>>>> please use the public one instead.
>>>>>>>>>>
>>>>>>>>> I will send it to public. Thank you for your remind.
>>>>>>>>>
>>>>>>>>> Best Regards,
>>>>>>>>> Shane
>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Christian.
>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>>>>>>>>>> ---
>>>>>>>>>>>       drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>>>>>>>>       1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>>>> index 75c80c557b6e..3fea58f9427c 100644
>>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>>>>>> @@ -453,7 +453,7 @@ static int amdgpu_vram_mgr_new(struct
>>>>>>>>>> ttm_resource_manager *man,
>>>>>>>>>>>               /* Limit maximum size to 2GiB due to SG table
>>>>>>>>>>> limitations */
>>>>>>>>>>>               size = min(remaining_size, 2ULL << 30);
>>>>>>>>>>>
>>>>>>>>>>> -        if (size >= (u64)pages_per_block << PAGE_SHIFT)
>>>>>>>>>>> +        if (!(size % ((u64)pages_per_block << PAGE_SHIFT)))
>>>>>>>>>>>                   min_block_size = (u64)pages_per_block <<
>>>>>>>>>> PAGE_SHIFT;
>>>>>>>>>>>               cur_size = size;

