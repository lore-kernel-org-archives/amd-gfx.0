Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33E5C4450A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 11:05:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8048510E328;
	Thu, 16 Jul 2026 11:05:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="p4XxcRbL";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6B1810E328
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 11:05:50 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c15cb6f5c12so1124479966b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784199949; x=1784804749; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1YIpuHOv/MBUTDXYL9hsOT5uvF8tiPnkJS9HvLi2zC8=;
 b=p4XxcRbLQR6zqPHFXQIkbcC5J/eMETJp+nZkPTfMpLkGYzIVyzd/nF/Ngtpfl5f/wb
 ZjIFIfXHyEqD9MKI3i14xlH3OLL2YW95TOAZ/xZG/HT94dNVIurDJB8uPc4uSIS/JdHS
 /jmE78JXJ5eP2S+L928agJT6tNNkQQKfrBMVIyaBDlqM6l5oc5XiWBqXS6pq9miPEgNm
 DAdP3ajOgqqujKuNxbqwxdFwqIREIBV0ORbU9xEMBn101OKvwktJIzB23TmJb9JzRqUg
 P6skENOZC7lUWrv/61IbdmSSFJqFPcy3de7Q7gFEs3vCFokVqGBejPdOlBCpr/84wcnT
 /z6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784199949; x=1784804749;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1YIpuHOv/MBUTDXYL9hsOT5uvF8tiPnkJS9HvLi2zC8=;
 b=S6vi1JV4NBn2rALMMZxkHiIjnpH4oWgQtdMoiu0Im1cAjsYtvcoB8dg1zCW8eG9sWT
 pheTONbVEjkbFH2UNQgADVcomFLiXg6jJWz0pEJz009VZ9ysZDD4VRdUNoGOGTHdv+/S
 pPfAds+RBTAb8ReOW9H/KjJaWRJSg2lmASYVmzNddGxG6/OWyPIjhwVk0YUCw2MnAor/
 /nh0RRxSaue91kOq55SdwETQAQN+GrSonu402tWmbn3U3zTJilSLZ+SRbD/S81F5mXvj
 qd6zbwZXTtppJrDbIJzNi6QtbZ9G8MdrguohT1jK0X1PKkYR8s7rENj2LNpoA8FmIoeE
 BHyA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rop4670c4RqPNZdWOxVg5eOvVdEiV/YaQym+L0ZcWQmL9C9RgbBOfKiRvqiFIRJvOTaoX8KE2Kk@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz+tK8LOvWQ63ocHxutuPwPlWuZNGVMXQjp7OLGlXGyydfaUPdh
 +7pvopvQDM6//3jixYYlMoajI0GGR9taiz3H8vFZXSOrVaXsAJG+8hpWvfqTKWOYYOQ=
X-Gm-Gg: AfdE7ckMB34XolWegr/wtj1F3lO5f+mNdX6D7pxCOOtFUJ71Q3nFOCWD/O+evqJhc/L
 69jIsz98hCsZ++vz5vWDlKKGQ8wSLTxNFFGrp1zQno9KXku04cxn81dsSV00FIBc4vchHQ8thoT
 Z2oNmInbq0U+3jwlbOJDLH/a+ZzwU7+Y483IjML5U2Qsy45549wk3riR13vCYtu1EeEDrhlpYN+
 ezY1Fu3uA38q+2XPs02+DRnhoEM263m8ZPXoS3bk3SPKotUXLNztTYVhkWEdTP3ksEbCV+JyeAx
 PJb8aSlCd3+IAQEEY0/nVC+dIW7IUI4D1OmzTmHkMAga3l1YAOTGVPKqPWEG33BXr9OhXrN1tyr
 LFZdTgqtWY50EocOnXhkVlbK/O8T0XhCh8b1iDu9Q8bLxrq6SmpwqIyvzYLJkOorg+CuJklBKJT
 m5D1TtooJBism6qqIwuYDMgpY=
X-Received: by 2002:a17:907:3909:b0:c12:34ed:e0fe with SMTP id
 a640c23a62f3a-c16795577cdmr408380266b.60.1784199948611; 
 Thu, 16 Jul 2026 04:05:48 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1687125db5sm193653366b.12.2026.07.16.04.05.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 04:05:48 -0700 (PDT)
Message-ID: <afb43e28-45d2-4529-98af-6fc7ea071ec7@ursulin.net>
Date: Thu, 16 Jul 2026 12:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] drm/amdgpu/gfx6: Properly enable/disable priv_req
 and priv_inst interrupts
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713130709.34262-1-timur.kristof@gmail.com>
 <5733138.E0xQCEvomI@timur-max>
 <d56d2eef-0bd1-4289-b315-8ecb7f5d01eb@ursulin.net>
 <178429166.VBMTVartND@timur-max>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <178429166.VBMTVartND@timur-max>
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


On 15/07/2026 20:23, Timur Kristóf wrote:
> On 2026. július 15., szerda 13:22:21 közép-európai nyári idő Tvrtko Ursulin
> wrote:
>> On 15/07/2026 11:53, Timur Kristóf wrote:
>>> On 2026. július 15., szerda 12:19:40 közép-európai nyári idő Tvrtko
>>> Ursulin
>>>
>>> wrote:
>>>> On 13/07/2026 14:07, Timur Kristóf wrote:
>>>>> These were used without ever calling get()/put() on them.
>>>>
>>>>> Implement it like on GFX7-8:
>>>> Used as in how? Are they even enabled without this change and if not
>>>> then does this patch fixes something other than being prep work for soft
>>>> reset?
>>>
>>> If you open gfx_v6_0.c and search for priv_reg or priv_inst, you can see
>>> that the interrupts are used in the same manner as gfx7 and newer, but
>>> without get() and put().
>>
>> Yes, they are used in code. Are they used in reality was my question. :)
> 
> Looking at the code I think the original intention was to wire up these
> interrupts. I think the hardware actually supports these interrupts and the
> author of the code simply forgot to call get() and put().
> 
> If you are not convinced, maybe Alex or Christian can confirm whether the
> interrupt actually exists on this HW generation. If it turns out it doesn't
> exist then we should just delete this code.
> 
>> I ask because it appears that without amdgpu_irq_get() they may not even
>> get enabled so never received. Yes or no? Consequences if yes?
> 
> Yes, that sounds correct. The consequence is that the interrupt will now be
> enabled and the HW will tell us about some illegal register access and some
> illegal instructions when it happens.

Right, AFAIU assuming the CP hangs, instead of waiting for the TDR 
timeout with this patch it will be instant via drm_sched_fault() called 
from either irq handler. Or if CP does not hang but somehow ends up 
going over it with corruption with this patch it will insta GPU hang.

In any case I think it is needed to have a definitive answer whether the 
interrupts were not enabled until now, and if so, also exercise the 
until now unused code paths just to make sure it all works as expected. 
Presumably there are test cases which trigger both conditions?

Then I would suggest putting this info in the commit message. That is, 
instead of saying "These were used without ever calling get()/put() on 
them." expand with the full story so the whole situation is clear both 
before and after the patch.

Assuming interrupts were not enabled until now, that the unused irq 
handlers work as expected, and with the improved commit message:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Unless you don't have the hardware to test it and there are no existing 
test cases to verify it?

Regards,

Tvrtko

> To give you additional context: for the purpose of diagnosing issues related
> to GPU hangs and recovery, all additional information helps. If the CP has
> interrupts to tell us about some error cases, we should absolutely use that.
> 
> Side note: from the register definitions it looks like the HW actually supports
> other interrupts which would be interesting to enable in the future.
> In this patch I just wanted to fix up the two that were already in the code.
> 
>>
>>>>> * Call amdgpu_irq_get() from gfx_v6_0_late_init()
>>>>> * Call amdgpu_irq_put() from gfx_v6_0_hw_fini()
>>>>>
>>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>> ---
>>>>>
>>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 19 +++++++++++++++++++
>>>>>     1 file changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c index 5b570a4b5c01..1c7cd265fbca
>>>>> 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>>>> @@ -3131,6 +3131,22 @@ static int gfx_v6_0_early_init(struct
>>>>> amdgpu_ip_block *ip_block)>
>>>>>
>>>>>     	return 0;
>>>>>     
>>>>>     }
>>>>>
>>>>> +static int gfx_v6_0_late_init(struct amdgpu_ip_block *ip_block)
>>>>> +{
>>>>> +	struct amdgpu_device *adev = ip_block->adev;
>>>>> +	int r;
>>>>> +
>>>>> +	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
>>>>> +	if (r)
>>>>> +		return r;
>>>>> +
>>>>> +	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
>>>>> +	if (r)
>>>>> +		return r;
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +
>>>>>
>>>>>     static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
>>>>>     {
>>>>>     
>>>>>     	struct amdgpu_ring *ring;
>>>>>
>>>>> @@ -3243,6 +3259,8 @@ static int gfx_v6_0_hw_fini(struct amdgpu_ip_block
>>>>> *ip_block)>
>>>>>
>>>>>     {
>>>>>     
>>>>>     	struct amdgpu_device *adev = ip_block->adev;
>>>>>
>>>>> +	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
>>>>> +	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
>>>>>
>>>>>     	gfx_v6_0_cp_enable(adev, false);
>>>>>     	adev->gfx.rlc.funcs->stop(adev);
>>>>>     	gfx_v6_0_fini_pg(adev);
>>>>>
>>>>> @@ -3532,6 +3550,7 @@ static void gfx_v6_0_emit_mem_sync(struct
>>>>> amdgpu_ring *ring)>
>>>>>
>>>>>     static const struct amd_ip_funcs gfx_v6_0_ip_funcs = {
>>>>>     
>>>>>     	.name = "gfx_v6_0",
>>>>>     	.early_init = gfx_v6_0_early_init,
>>>>>
>>>>> +	.late_init = gfx_v6_0_late_init,
>>>>>
>>>>>     	.sw_init = gfx_v6_0_sw_init,
>>>>>     	.sw_fini = gfx_v6_0_sw_fini,
>>>>>     	.hw_init = gfx_v6_0_hw_init,
> 
> 
> 
> 

