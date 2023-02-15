Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC5EC636D4
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Feb 2023 10:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD9810EA95;
	Wed, 15 Feb 2023 10:44:10 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B152010EA95
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 10:44:07 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id lf10so15232779ejc.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Feb 2023 02:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1y6bxHp5/mqDfH+dT/xv9I0mBRHx1AaaniegqoUUvqA=;
 b=hgwTgld42RJHXoPinT2D3yiz7kgAnYMt93erRIQn4hNFLv8VBt/CRDTT/OzToqSGdX
 h/6dCGa0PWftLJcONPAAj5Lxorvuh0u26YH0YM22oXhOFzSe48eR0f9jTrBdmBODNsWO
 edm0ynAf70vGuzUaBw3Ym/ZnawENrBg9Y7FT6XwFo/GU+bMlWjMV6TvrriVsVaQtbxNr
 k7JVGByv7YLrrwmGk6iIAh7n4DnI+rMBf297tI/gDydUD7HZ6DkfYPHY8XV1pmObxbrB
 bH2SXzYKDraloYMEhpKgV0QWJjSKhUOepXhP4T4f+q96Pirv7YQ/qf/7P1SehecahQ3a
 MOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1y6bxHp5/mqDfH+dT/xv9I0mBRHx1AaaniegqoUUvqA=;
 b=274ST2Qd2B08tzh04FE6pXCYe35UhZbZdDhkuojbhvEIWwBbukvRkbBwPMeYqXrDtR
 +9x8LAuLJJYZLBTGuC03cNqndZKR+65IKg5GPskEhdDj7YZrlR0zpUlZ0N8Q0E68Bpr2
 YHfejReclFhkXY7nMa6C3wzTXmEXD/n7K8hrr2NxNI/9zREJNyM8fYBdyHIOWd8/9sjw
 ej7942M6di296yEFvYQjztvCzGDI+WlHi08u2yAltHFnHIHesaFjjV6Xcx5BWbaYF5ja
 usTuZkUNUMRnlqZVbutmZV/17zzGoEjZu04UcS+oBnDBnUE2Lj2tv/eYV6j8PnhD8Zz9
 ky8w==
X-Gm-Message-State: AO0yUKVWiC/5lpuEHYdzPMneC8HTpaUhcnq9OpLOwlZ4bfQljYEh/MyT
 gfzGPLmdVdgGz5BoEmSVqY7jJ1lAM255/A==
X-Google-Smtp-Source: AK7set88pkXAw+wx/g5v6rUa0LwNNVdWolWqt0oI2eF/nIUqSxIQzmKG/3AXPcDF0hpLI8OghKiTQg==
X-Received: by 2002:a17:906:edb9:b0:8b1:304e:58a7 with SMTP id
 sa25-20020a170906edb900b008b1304e58a7mr2175037ejb.56.1676457846208; 
 Wed, 15 Feb 2023 02:44:06 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:b2c6:be33:f616:fc78?
 ([2a02:908:1256:79a0:b2c6:be33:f616:fc78])
 by smtp.gmail.com with ESMTPSA id
 e19-20020a170906749300b0088f8abd3214sm9631406ejl.92.2023.02.15.02.44.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Feb 2023 02:44:05 -0800 (PST)
Message-ID: <62ca76cc-a553-21c2-9538-03cefb7b02ac@gmail.com>
Date: Wed, 15 Feb 2023 11:44:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using drm
 buddy
Content-Language: en-US
To: "Xiao, Shane" <shane.xiao@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
References: <20230214111851.2525197-1-shane.xiao@amd.com>
 <ca40db72-6c04-e3cd-38f9-3254f37c850a@amd.com>
 <DM4PR12MB526136D00F81419EEFCE47579DA29@DM4PR12MB5261.namprd12.prod.outlook.com>
 <0a5fd1ae-45b0-96bb-5160-a34b57fc6a2a@amd.com>
 <DM4PR12MB52616659C39CB1242A4AD8B89DA39@DM4PR12MB5261.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <DM4PR12MB52616659C39CB1242A4AD8B89DA39@DM4PR12MB5261.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Am 15.02.23 um 03:51 schrieb Xiao, Shane:
> For public review
>> -----Original Message-----
>> From: Koenig, Christian <Christian.Koenig@amd.com>
>> Sent: Wednesday, February 15, 2023 3:02 AM
>> To: Xiao, Shane <shane.xiao@amd.com>; Paneer Selvam, Arunpravin
>> <Arunpravin.PaneerSelvam@amd.com>
>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when using
>> drm buddy
>>
>> Am 14.02.23 um 15:53 schrieb Xiao, Shane:
>>>> -----Original Message-----
>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>> Sent: Tuesday, February 14, 2023 8:41 PM
>>>> To: Xiao, Shane <shane.xiao@amd.com>; brahma_sw_dev
>>>> <brahma_sw_dev@amd.com>
>>>> Cc: Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>
>>>> Subject: Re: [PATCH 1/2] drm/amdgpu: optimize VRAM allocation when
>>>> using drm buddy
>>>>
>>>> Am 14.02.23 um 12:18 schrieb Shane Xiao:
>>>>> Since the VRAM manager changed from drm mm to drm buddy. It's not
>>>>> necessary to allocate 2MB aligned VRAM for more than 2MB unaligned
>>>>> size, and then do trim. This method improves the allocation
>>>>> efficiency and reduces memory fragmentation.
>>>> Well that is a trade off.
>>>>
>>>> Allocating the BO as one contiguous chunk and then trimming is
>>>> beneficial because if we then later need it contiguous we don't need
>>>> to re-allocate and copy. This can be needed to display something for
>> example.
> Hi Christian,
>
> This case means that you allocate BO that is unnecessary to be continuous at first time,
> and latter the BO should be continuous. I'm not familiar with display. Could you give me
> a few more specific examples ?

On most generations DCE/DCN hardware needs the buffer contiguous to be 
able to scanout from it.

Only newer APUs can use S/G to scanout from system memory pages.

>>> Yes, I agree that one contiguous chunk may get beneficial sometimes.
>>> But as far as I know, you cannot guarantee that amdgpu_vram_mgr_new
>> can get one contiguous chunk  if you don't set TTM_PL_FLAG_CONTIGUOUS
>> flags.
>>> For example, if you want to allocate 4M+4K BO, it will allocate one 4M block
>> + one 2M block which is unnecessary to be continuous, then 2M block will be
>> trimmed.
>>
>> Oh, that's indeed not something which should happen. Sounds more like a
>> bug fix then.
> Yes, I think this case should not be happened.
> Actually, I'm not sure that why the allocated BO should be aligned with pages_per_block, which is set to 2MB by default.
> Does this help improve performance when allocating 2M or above BO?
>  From my point of view, the TLB may be one of reason of this. But I'm not sure about this.

Yes, we try to use allocations which are as contiguous as much as 
possible for better TLB usage.

Especially for some compute use cases this can make a >20% performance 
difference.

Regards,
Christian.

>
> Best Regards,
> Shane
>
>>>> On the other hand I completely agree allocating big and then trimming
>>>> creates more fragmentation than necessary.
>>>>
>>>> Do you have some test case which can show the difference?
>>> I have use rocrtst to show the difference.
>>> The attachment is shown that after applying this patch, the order < 9 total
>> vram size decrease from 99MB to 43MB.
>>> And the latter has more higher order block memory.
>> Arun can you take a look? That problem here sounds important.
>>
>> Thanks,
>> Christian.
>>
>>>> BTW: No need to discuss that on the internal mailing list, please use
>>>> the public one instead.
>>>>
>>> I will send it to public. Thank you for your remind.
>>>
>>> Best Regards,
>>> Shane
>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> index 75c80c557b6e..3fea58f9427c 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> @@ -453,7 +453,7 @@ static int amdgpu_vram_mgr_new(struct
>>>> ttm_resource_manager *man,
>>>>>     		/* Limit maximum size to 2GiB due to SG table limitations */
>>>>>     		size = min(remaining_size, 2ULL << 30);
>>>>>
>>>>> -		if (size >= (u64)pages_per_block << PAGE_SHIFT)
>>>>> +		if (!(size % ((u64)pages_per_block << PAGE_SHIFT)))
>>>>>     			min_block_size = (u64)pages_per_block <<
>>>> PAGE_SHIFT;
>>>>>     		cur_size = size;

