Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3840C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 13:39:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F9CC10E600;
	Fri,  5 Jan 2024 13:39:55 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC5510E5FB
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 13:39:54 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40d2e56f3a6so3251125e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jan 2024 05:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704461992; x=1705066792; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rjnzLFjqdDvtiFgTEx7litURemLOsyCYAhz3ZoGhFlA=;
 b=Xk3nHmXNOWi1zPlZYUwpjxD3RnlT0nzu+wTnsLKK1WR5ZlD7tbbSRc1dnp02I7iW/L
 GefGswhqFnXXlW6+DrtHJ2ukETfPNR7POC+nDwz41T/Qiunix1YY7v5GQNdbOKY4eZnq
 XGUFjPpGW/PkoRVZb3IwRa8EFJHJ3/c/6gTasIt4xiJcHchZdNB1fxzEpaLJOuISqiYt
 lCLb70EJymGnpZpu4WARpho7KyQ6D9lvox54QAaYprkTa8cQl42iMRs/hodWnuhBN9/v
 Z7vHCz/FLmsfp3O8HjP0LyuV72BcPzHvrYDMGmSj9hkGdAMTWV/Fo7EStDYnAw1u2ug/
 aWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704461992; x=1705066792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rjnzLFjqdDvtiFgTEx7litURemLOsyCYAhz3ZoGhFlA=;
 b=gCUTOYDEsXfimDcP1cZleWszGmMJx5KjSdM8feDnDcgGkfpvEywtJNrfxtVaZc6Gik
 1bdyNPDbU21/l3noyEyOGFdiVslNNQcvCmvDsa2NQLJkycwQSGyRStuBvB4Tg1H4nt+n
 xkrvV7MglyzfFiCp9XTmv3EGNIwKfFEhh5PwYRpsc+uBOJKWl6WvC62etZAutPatw5S2
 ZYjaPFEAk7jiGIhyff28iK72VfRnQ12FwjL2UJvg78Tys9DByJMyQR0wTnNzxotL6Qa8
 s1Ddo0U6KhSkYk6s8Ns7UYMpMonk/FoUcNjoVTNVbJTZ591a373kLnN8bKir96RS4IVF
 GbIg==
X-Gm-Message-State: AOJu0YwZcqR8mCYRlgRhVj/V37ALalz0GI8wk73LOTRsKBIRZy8wKYXi
 DVc1AL5QSM8d+07FycPC5d29+DMXcys=
X-Google-Smtp-Source: AGHT+IHjv9L/74J/u8X/1OLFh1bHhuaa6wcZELzXQArF0vjmLFF5MJJ42hhey9eAmkmLWQwPXrh7Og==
X-Received: by 2002:a05:600c:c89:b0:40d:8ed9:ce8c with SMTP id
 fj9-20020a05600c0c8900b0040d8ed9ce8cmr1180721wmb.120.1704461992398; 
 Fri, 05 Jan 2024 05:39:52 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a056000108500b003366a9cb0d1sm1414841wrw.92.2024.01.05.05.39.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 05:39:52 -0800 (PST)
Message-ID: <3d92db26-dc1b-48d7-84e1-2e509742f174@gmail.com>
Date: Fri, 5 Jan 2024 14:39:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Check resize bar register when system uses
 large bar
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20231219055802.304678-1-Jun.Ma2@amd.com>
 <5c64d777-510d-4440-b1b6-aaccd7bb71a0@gmail.com>
 <8fd5d4dc-e781-475e-b90f-b43001ab224b@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <8fd5d4dc-e781-475e-b90f-b43001ab224b@amd.com>
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
Cc: Alexander.Deucher@amd.com, mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.12.23 um 02:58 schrieb Ma, Jun:
> Hi Christian,
>
>
> On 12/20/2023 10:10 PM, Christian König wrote:
>> Am 19.12.23 um 06:58 schrieb Ma Jun:
>>> Print a warnning message if the system can't access
>>> the resize bar register when using large bar.
>> Well pretty clear NAK, we have embedded use cases where this would
>> trigger an incorrect warning.
>>
>> What should that be good for in the first place?
>>
> Some customer platforms do not enable mmconfig for various reasons, such as
> bios bug, and therefore cannot access the GPU extend configuration
> space through mmio.
>
> Therefore, when the system enters the d3cold state and resumes,
> the amdgpu driver fails to resume because the extend configuration
> space registers of GPU can't be restored. At this point, Usually we
> only see some failure dmesg log printed by amdgpu driver, it is
> difficult to find the root cause.
>
> So I thought it would be helpful to print some warning messages at
> the beginning to identify problems quickly.

Interesting bug, but we can't do this here. We have a couple of devices 
where the REBAR cap isn't enabled for some reason (or not correctly 
enabled).

In this case this would print a warning even when there isn't anything 
wrong.

What we could potentially do is to check for the MSI extension, that 
should always be there if I'm not completely mistaken.

But how does this hardware platform even works without the extended mmio 
space? I mean we can't even enable/disable MSI in that configuration if 
I'm not completely mistaken.

Regards,
Christian.

>
> Regards,
> Ma Jun
>
>> Regards,
>> Christian.
>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> index 4b694696930e..e7aedb4bd66e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>> @@ -1417,6 +1417,12 @@ void amdgpu_device_wb_free(struct amdgpu_device *adev, u32 wb)
>>>    		__clear_bit(wb, adev->wb.used);
>>>    }
>>>    
>>> +static inline void amdgpu_find_rb_register(struct amdgpu_device *adev)
>>> +{
>>> +	if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_REBAR))
>>> +		DRM_WARN("System can't access the resize bar register,please check!!\n");
>>> +}
>>> +
>>>    /**
>>>     * amdgpu_device_resize_fb_bar - try to resize FB BAR
>>>     *
>>> @@ -1444,8 +1450,10 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
>>>    
>>>    	/* skip if the bios has already enabled large BAR */
>>>    	if (adev->gmc.real_vram_size &&
>>> -	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size))
>>> +	    (pci_resource_len(adev->pdev, 0) >= adev->gmc.real_vram_size)) {
>>> +		amdgpu_find_rb_register(adev);
>>>    		return 0;
>>> +	}
>>>    
>>>    	/* Check if the root BUS has 64bit memory resources */
>>>    	root = adev->pdev->bus;

