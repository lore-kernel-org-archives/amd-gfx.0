Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27009C4167B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Nov 2023 15:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCCA10E8E9;
	Thu,  2 Nov 2023 15:39:10 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B1010E8E9
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Nov 2023 15:39:08 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32dc918d454so621436f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Nov 2023 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698939547; x=1699544347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Bcqu9mcRdPrTnPxyHQ2e36LRNkiYraR4drSiZNzpvk=;
 b=WAh9ZBuZ8ZJRsupksRhT88HRk+zmGK3kM5u3VTzl68K0fQ5ivJBzLLxCXPNduA5psC
 ItKOBAIlNJNge57T1ou8Oh4WuRKWLNo3Xh4Nlo2hvD/6OUmaP+YGskPV8QflCH83w1v1
 vjAKfZzpmIBRS1X/EgiiPUj17MrjbYI5a88Anvs2ktpmB/SUn3pvXJcjeoP4LDAnu1Yb
 eQ8Rl+6CyWXubSIRgtwzbQPWxQgxXumI/F0tSeRLaapIkS4xBf4JAJ2qKsQQrQpDcKG/
 PGTadAJ4uNAnQ/U85n7Nbk6kfX+FdSJp3iaGJAJKVA8TLO9WHewgt8MofpLe6PCEIoI4
 TbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698939547; x=1699544347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Bcqu9mcRdPrTnPxyHQ2e36LRNkiYraR4drSiZNzpvk=;
 b=M+ZVI3aOBvmBTNgiPA6RTelmKPwWUsX6jPh0h906A4mmdPQozCbggdT60syP6jA2Kk
 2b7Kb1FAkT4FOWmnH/u4qf6O4zyUnDKmQhypgpFvjbwvrpsfQSXEuIIjwUe2R0sUOcZh
 hIO+6H+VTF7O5wOx/oga8zLLNrRYDye9GnvYogdtmW28FWnKFPNgSHc/QJ/tGukXLG6f
 m2FaDqj4z9Ndzzp8jRj/kREuo8h8OF4DqIZWE6G4sRPfyur/+ets9Hss1IYy/R1CyYwS
 GTVRsMW/69FytH09qjSOQk6JRcmejAvAVSD3+FTG7GBHiIUfpvc+vu5s4of8IUw7tlQ7
 IGAg==
X-Gm-Message-State: AOJu0Yxhx3XfDF00xEsw1BrPji286RZm42yJNoPk3uKzxt+gGkBpwszS
 FJjha8ThVWgNjF/qfPM3ha8=
X-Google-Smtp-Source: AGHT+IFDhV5RPNeUBHTTVsM+E4RD4VgzZXsXNSNtmEM/cGxczTxgP6hylu9zxkYyh341anBntWQbqA==
X-Received: by 2002:a05:6000:18a4:b0:32f:755c:c625 with SMTP id
 b4-20020a05600018a400b0032f755cc625mr14887642wri.11.1698939546761; 
 Thu, 02 Nov 2023 08:39:06 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g9-20020adff409000000b00318147fd2d3sm2791118wro.41.2023.11.02.08.39.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 08:39:06 -0700 (PDT)
Message-ID: <de95125a-f413-4765-b131-aeaa1296a1ec@gmail.com>
Date: Thu, 2 Nov 2023 16:39:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix the vram base start address
Content-Language: en-US
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231030122205.24805-1-Arunpravin.PaneerSelvam@amd.com>
 <f691b236-e5da-4f4e-aaf1-bd74f2f9db56@gmail.com>
 <838a8374-5499-478e-3439-3000b32bc7e4@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <838a8374-5499-478e-3439-3000b32bc7e4@amd.com>
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.11.23 um 20:13 schrieb Arunpravin Paneer Selvam:
> Hi Christian,
>
> On 10/30/2023 9:34 PM, Christian König wrote:
>>
>>
>> Am 30.10.23 um 13:22 schrieb Arunpravin Paneer Selvam:
>>> If the size returned by drm buddy allocator is higher than
>>> the required size, we take the higher size to calculate
>>> the buffer start address. This is required if we couldn't
>>> trim the buffer to the requested size. This will fix the
>>> display corruption issue on APU's which has limited VRAM
>>> size.
>>>
>>> gitlab issue link: https://gitlab.freedesktop.org/drm/amd/-/issues/2859
>>> JIRA ticket link: https://ontrack-internal.amd.com/browse/SWDEV-425461
>>>
>>> Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>
>> Acked-by: Christian König <christian.koenig@amd.com>
>>
>> IIRC that hack with the start address is actually not needed any 
>> more, but we need to double check this.
> okay, can we just remove this hack and keep the vres->base.start value 
> as the start address of the first block from the
> allocated list.

Please double check if we don't have any more cases where we compare the 
start address against the visible VRAM limit.

I think we now fixed all those cases and replaced them with calls to 
check if all segments are visible, but I'm not 100% sure.

Regards,
Christian.

>
> Thanks,
> Arun
>>
>> Christian.
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 15 +++++++++++++--
>>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> index 18f58efc9dc7..08916538a615 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> @@ -77,7 +77,16 @@ static inline bool 
>>> amdgpu_is_vram_mgr_blocks_contiguous(struct list_head *head)
>>>       return true;
>>>   }
>>>   +static inline u64 amdgpu_vram_mgr_blocks_size(struct list_head 
>>> *head)
>>> +{
>>> +    struct drm_buddy_block *block;
>>> +    u64 size = 0;
>>>   +    list_for_each_entry(block, head, link)
>>> +        size += amdgpu_vram_mgr_block_size(block);
>>> +
>>> +    return size;
>>> +}
>>>     /**
>>>    * DOC: mem_info_vram_total
>>> @@ -516,6 +525,8 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>       mutex_unlock(&mgr->lock);
>>>         vres->base.start = 0;
>>> +    size = max_t(u64, amdgpu_vram_mgr_blocks_size(&vres->blocks),
>>> +             vres->base.size);
>>>       list_for_each_entry(block, &vres->blocks, link) {
>>>           unsigned long start;
>>>   @@ -523,8 +534,8 @@ static int amdgpu_vram_mgr_new(struct 
>>> ttm_resource_manager *man,
>>>               amdgpu_vram_mgr_block_size(block);
>>>           start >>= PAGE_SHIFT;
>>>   -        if (start > PFN_UP(vres->base.size))
>>> -            start -= PFN_UP(vres->base.size);
>>> +        if (start > PFN_UP(size))
>>> +            start -= PFN_UP(size);
>>>           else
>>>               start = 0;
>>>           vres->base.start = max(vres->base.start, start);
>>
>

