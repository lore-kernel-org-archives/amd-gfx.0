Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCABC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 11:22:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FD710F003;
	Wed, 15 Jul 2026 11:22:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="g/ihVTZ+";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B3E10F003
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 11:22:23 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47df6a5202bso3384369f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 04:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784114542; x=1784719342; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XFZ+F8I7D7A8am2Vk3FOJXUHbiiBh7a06my+KjroiGQ=;
 b=g/ihVTZ+5ZwNL7t1aEqU28YmzStzkJs+MrXRR3i/LKgWFgc29dA4U8tsP5UyzASMjX
 8NThc+HgRG8mf4ynT7t+TtskXGQEqG9xbbYyJOOjO18Vnp+yXFPYe/U3THN8hNmi/2vz
 DW8xELJTTlH0MMx1aYtuVkIsDdTm7JEizaaHRLJg2/euUcOyp7VFXiEOvGcDxzj5WuSX
 v+C/dC+NJxHJKOkFnEaz0u6J9NU9EHVXrDNZV6L2UoXE49befoardR39/4PKbS8n8nVb
 KaTHJrAOXwhRwRSdApj24ZoLdAhIv1yDhU/dTsqepmbYFLdaXAwmGvRrgd+eJP4EHuvS
 o6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784114542; x=1784719342;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XFZ+F8I7D7A8am2Vk3FOJXUHbiiBh7a06my+KjroiGQ=;
 b=PSKgFheCK2MJJ4QhxztRsP3zzOsfgmJA0UNBfid8B2m7rIX2CuCcLFZWOHhU/z9ZkU
 5TkBpIDFDp/KgTsJUfMoq4ovr6GQfARElC5IBXGZSEcZdc899JL8Km5ekr1cQBU2c2Qk
 lpwEBsRfNks0i9wrTnvFjogdxsbDvRKhyhFDroJOl9Q+2icyLoia0ONVjHvYWcmH7bl8
 JZTzErHM3QM3zq64P4G2ZN/34JgWgS5ZnMh2CEU/zK2fW84FoVoLD0YkejH0QVoBcOvM
 Z1H4nj26ad62c3AR/Nla/yeuu3xtDl1d2ydzT45vEcuhUEbaGR9+/p/5G9K3URoMPR5P
 4c5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGo8CJgGv5vpqzya71nWFfpQNhm8OPtc08ZL3I0AzUYIQoESFEdrKWkzDz3sSxMInLg1ngK0df@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXObASFzITRQljBXA3+Jk+rnDsMDvnMj6ZIqzx55r6oVs44kXp
 mLys5JcGDccggJDXBiQNE+wvwuHxQUo8/E1xuI3iXYQcfMsZ0XTQWymnSipel41uMPc=
X-Gm-Gg: AfdE7cmqO+tWLSmLZL3W6X8WoMFR2QNB01ChjpM/meYe0oaSoiuN2Z4jdNDcR7k5nVs
 gUqf09ohaTQdW44WzBtNs9mEcd3p+Tq/6vJWn2Ff0nNv2dOL2aYyQlzfBqfKEbtfByFfGVHEn6w
 5yhhoyLBC5PCtKVaC0Pw3QfKKL4fY1cwqRbQpzKGM1z0T+5MK3D5znbfCxGfT8fly/8m7H0a9+o
 YIlEFPOZ70BDnWA3AD7ThmHDa1YU94VAZ7vuJQxRrZ7zcgU1W/IS+TBLz6kamabIf3IbE0JPNWu
 JptIi7jCGIZgtJTPRorncLNnJOcqomOxumRMGwBe0BVbAsF1T8lN1bAoQNdfHlmW1ZB16nC7koE
 ve0shtlvidpk9ZVV/9lZpwKlQBbEKo/sXCIVOET8YOfbAXyBbJ67XfEDYBSJEo6XrzQXlbzlb/R
 vth2pTAbXnkmqb/e7izo2j7APqnxFafPlaZ2L4zU6FG2xU
X-Received: by 2002:a5d:5f47:0:b0:474:57f0:49f8 with SMTP id
 ffacd0b85a97d-47f4fca67b2mr2391678f8f.4.1784114542302; 
 Wed, 15 Jul 2026 04:22:22 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635a935sm15464256f8f.11.2026.07.15.04.22.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 04:22:21 -0700 (PDT)
Message-ID: <d56d2eef-0bd1-4289-b315-8ecb7f5d01eb@ursulin.net>
Date: Wed, 15 Jul 2026 12:22:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/amdgpu/gfx6: Properly enable/disable priv_req
 and priv_inst interrupts
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713130709.34262-1-timur.kristof@gmail.com>
 <20260713130709.34262-8-timur.kristof@gmail.com>
 <12b8dbe8-579d-4b90-a3af-ec604710299c@ursulin.net>
 <5733138.E0xQCEvomI@timur-max>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <5733138.E0xQCEvomI@timur-max>
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


On 15/07/2026 11:53, Timur Kristóf wrote:
> On 2026. július 15., szerda 12:19:40 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> On 13/07/2026 14:07, Timur Kristóf wrote:
>>> These were used without ever calling get()/put() on them.
>>
>>> Implement it like on GFX7-8:
>> Used as in how? Are they even enabled without this change and if not
>> then does this patch fixes something other than being prep work for soft
>> reset?
> 
> If you open gfx_v6_0.c and search for priv_reg or priv_inst, you can see that
> the interrupts are used in the same manner as gfx7 and newer, but without
> get() and put().

Yes, they are used in code. Are they used in reality was my question. :) 
I ask because it appears that without amdgpu_irq_get() they may not even 
get enabled so never received. Yes or no? Consequences if yes?

Regards,

Tvrtko

>>
>>> * Call amdgpu_irq_get() from gfx_v6_0_late_init()
>>> * Call amdgpu_irq_put() from gfx_v6_0_hw_fini()
>>>
>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>> ---
>>>
>>>    drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 19 +++++++++++++++++++
>>>    1 file changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c index 5b570a4b5c01..1c7cd265fbca
>>> 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>> @@ -3131,6 +3131,22 @@ static int gfx_v6_0_early_init(struct
>>> amdgpu_ip_block *ip_block)>
>>>    	return 0;
>>>    
>>>    }
>>>
>>> +static int gfx_v6_0_late_init(struct amdgpu_ip_block *ip_block)
>>> +{
>>> +	struct amdgpu_device *adev = ip_block->adev;
>>> +	int r;
>>> +
>>> +	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
>>> +	if (r)
>>> +		return r;
>>> +
>>> +	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
>>> +	if (r)
>>> +		return r;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>
>>>    static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>    {
>>>    
>>>    	struct amdgpu_ring *ring;
>>>
>>> @@ -3243,6 +3259,8 @@ static int gfx_v6_0_hw_fini(struct amdgpu_ip_block
>>> *ip_block)>
>>>    {
>>>    
>>>    	struct amdgpu_device *adev = ip_block->adev;
>>>
>>> +	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>>> +	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>>>
>>>    	gfx_v6_0_cp_enable(adev, false);
>>>    	adev->gfx.rlc.funcs->stop(adev);
>>>    	gfx_v6_0_fini_pg(adev);
>>>
>>> @@ -3532,6 +3550,7 @@ static void gfx_v6_0_emit_mem_sync(struct
>>> amdgpu_ring *ring)>
>>>    static const struct amd_ip_funcs gfx_v6_0_ip_funcs = {
>>>    
>>>    	.name = "gfx_v6_0",
>>>    	.early_init = gfx_v6_0_early_init,
>>>
>>> +	.late_init = gfx_v6_0_late_init,
>>>
>>>    	.sw_init = gfx_v6_0_sw_init,
>>>    	.sw_fini = gfx_v6_0_sw_fini,
>>>    	.hw_init = gfx_v6_0_hw_init,
> 
> 
> 
> 

