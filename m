Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8445CC4450A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2026 18:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D99F10E0CB;
	Tue, 14 Jul 2026 18:23:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="lOc5/B7T";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40F0B10E0CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 18:23:33 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47c6e9a694bso2557302f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1784053411; x=1784658211; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bBSD9uHwJLoRKqtz0CfGkMkxl4EemhuYhgGbFlGEOJc=;
 b=lOc5/B7T8dX5Y1mwTHzr6MgKGxCrj/N7x6uJkoZE1GBgrOH64VVR2uoE/01HfrxsGU
 +H8WOtHniwHs9gAY9DfcrvTmFHGfMqcbNQ9uXJwI0000lZ0fzYB/jn/2K3Yyaa9osnCx
 Hqe7LcGVqlLyop5xcK/GXQWFlIJLJbTQiEbxG+5yq7ASBs8GOaNAql8mBAf5gpArI19D
 fTByyE200OfM6FO+wb7hOzIw3Y2a0+2nle63JRzQ/LsdES62Z6lXlX3JkhshBeLE4aKf
 aa7cJQua9oL5HccsnQq0YXatcXIhhjXo3s/N5yBCN8IiQMDNkpbRaL950OV6MGkUt9pb
 Z8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784053411; x=1784658211;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bBSD9uHwJLoRKqtz0CfGkMkxl4EemhuYhgGbFlGEOJc=;
 b=afaR7VH9SwRxXuADPGq/LqJKBOPuE58AsFIKNigvSCJZqxns53VLAM8kl/IU/jlCe+
 ypIlbWbaCX+Z970oKczcPH5J7ErxMKhEsowPoURwHEVMVTviAmVlWmM9WP4eoKTPBTAN
 4RXEA0jS5+krecfb92zVRVZBmUIDP+9x0SEATN2cTLQAdVBqukW2GKA0E/XflZYDYNos
 6Bhd2ujNsIpO2shOZOl6bdAXoddz9EBUwEU3ZFbtGtjLbgosv1Nk0l44MrjDkE6PYi3z
 umt0K7x3xSfMkObybGy+RnNYdymygZhKwEwSdoSusNDD2BFUa+hejxAm3X1/O2Of1U9H
 qmnA==
X-Gm-Message-State: AOJu0Yx/hjmGwasfD/Heo3xC78jPVP6vNUxRLgWshVbnQBoxsrL4FLMw
 tFEsyZg9DWIe2CtrQJvdqVMFsrtFtQB6Zap6v2gdK+pVd2pyBshzEttVuwh4f80Bq8s=
X-Gm-Gg: AfdE7clr4i+tOUjNgx/o9MD2/zq6YcRdKV8UOLYY9RNbXUX8Pcv6zLdBnHfh2cT+M5U
 pVhHA4xrXwWnkNTucWE3XJmibV1oAWRfjhMDZM+Ppk9MbfptrlSjCMRMMjObSHu6EVGJRLccgEa
 YMpuil0on+HKZdkBdWATFhrxBE6qBMFZAMWnjdh7iScA/S+Yt7yR4q/zGH28uQnAREUjy/DeWM2
 Rtn2hRIwJLRnvNSC/z5kpP2OlBzLLWOJbaDv1vAqAlhrDZI9MX2XQwig9PNVyQOCi9fQ+ktv0AA
 d8WApVCaiqw1dEbpgDnD/cm5YlNBW/3sdq7Gthq0DVRDOpatkjJ5odRmwjkQExKYR1SWDEc5QW4
 +1TU6+NoYx+oM2ym9L/xLuz0klutDMFVyBxyyFRT7pq1SxGPICsfHgenzqVFO1n1BZVfWEIzo+l
 tYmzh+SLf1LUKaAXqeHjlCcv9NBIeCdl8opw==
X-Received: by 2002:a05:600c:6592:b0:493:bc4a:fb55 with SMTP id
 5b1f17b1804b1-493f883d859mr137312245e9.38.1784053411129; 
 Tue, 14 Jul 2026 11:23:31 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2e8f07sm84294765e9.7.2026.07.14.11.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 11:23:30 -0700 (PDT)
Message-ID: <d3f7e6ea-6e21-458e-87bd-cbdf218d4124@ursulin.net>
Date: Tue, 14 Jul 2026 19:23:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] drm/amdgpu/gfx7: Make amdgpu_gfx_mqd_sw_init() usable
 on GFX7
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <CADnq5_MWaSxpnMBRYsk-vqhKPvZB_ohq4yCZsu_iYMG+M2dmiA@mail.gmail.com>
 <061761c8-cdd1-47d2-abcb-718711c49cef@ursulin.net>
 <OYDF_volTbuQ8b1_pht54A@gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <OYDF_volTbuQ8b1_pht54A@gmail.com>
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


On 14/07/2026 16:39, Timur Kristóf wrote:
> On Tuesday, July 14, 2026 5:19:57 PM Central European Summer Time Tvrtko
> Ursulin wrote:
>> On 14/07/2026 16:05, Alex Deucher wrote:
>>> On Tue, Jul 14, 2026 at 10:59 AM Tvrtko Ursulin <tursulin@ursulin.net>
> wrote:
>>>> On 13/07/2026 13:58, Timur Kristóf wrote:
>>>>> We don't use KIQ on GFX7 but otherwise MQD works the
>>>>> same way as GFX8 and newer.
>>>>>
>>>>> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
>>>>> ---
>>>>>
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 2 +-
>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c index
>>>>> 96c9d4f00b27..0f142c156afa 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
>>>>> @@ -420,7 +420,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device
>>>>> *adev,
>>>>>
>>>>>     #endif
>>>>>     
>>>>>         /* create MQD for KIQ */
>>>>>
>>>>> -     if (!adev->enable_mes_kiq && !ring->mqd_obj) {
>>>>> +     if (adev->asic_type >= CHIP_TOPAZ && !adev->enable_mes_kiq &&
>>>>> !ring->mqd_obj) {>>
>>>> CHIP_TOPAZ is gfx7? Hm if it is then the branch would already run there.
>>>> So the change is limiting the branch to a subset of platforms, while the
>>>> patch title made me think it is enabling something on gfx7. Perhaps
>>>> somehow indirectly or what am I not understanding?
>>>
>>> TOPAZ is gfx8.
> 
> We currently don't use KIQ on GFX7 so the patch changes the code to allocate
> the BO only on GFX8 and newer. Topaz is the first GFX8 chip in the enum, so
> that's why the code checks >= TOPAZ here.
> 
>> Ah now I get it, thank you! Could maybe adev->gfx[0].kiq.something or be
>> used to make it a bit self-documenting?
> 
> Technically, GFX7 supports the KIQ, amdgpu just doesn't use it. So, I fear
> that adding a field would mislead the reader into thinking that the HW support
> is missing when it really is just the kernel doesn't use it.
> 
> How would you feel about just updating the comment above the changed line?
> Maybe like this?
> 
> /* create MQD for KIQ - only on GFX8+ GPUs where we use the KIQ */
> 
> I think that would make it self-explanatory.

Your call if you think that adds value or not much. I was simply 
wondering if there is some sort of a "central" source of knowledge, like 
a function or variable under gfx or adev, which is colloquially used as 
"do we use kiq". If there isn't that's fine. The patch LGTM.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> 
>>
>>>>>                 /* originaly the KIQ MQD is put in GTT domain, but for
>>>>>                 SRIOV VRAM domain is a must>>>
>>>>>                  * otherwise hypervisor trigger SAVE_VF fail after driver
>>>>>                  unloaded which mean MQD * deallocated and gart_unbind,
>>>>>                  to strict diverage we decide to use VRAM domain for
> 
> 
> 
> 

