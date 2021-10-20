Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C04DC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 15:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5629460E8B
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 15:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5629460E8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64AB6E9C1;
	Wed, 20 Oct 2021 15:02:11 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A8F56E9C1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 15:02:10 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id p21so19629829wmq.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=WIn6iuID7uLZrddonsm2PTziX8HxPL4wzKY3m5G12xs=;
 b=pN6GANAiH2vsaTim8bpZg4UTUcN9PsOsih+GyZXgxDu+0LmuFvA/76k14xXMRuQJWH
 JCCzCyrCNuGkUGN8NdxnRDKW4mnyOxEBYRiQ/9vPHD2xD9haq3iAYcDWwEoLisoGD9Jk
 rfYxZHPmh37bNkuZb4GUGREkhvSziFppmxLvXDFK4Wd8xdVtZD5NzpFQs+5H/U7fZaFN
 tuT2Aikm082USB6HcalvWzsRzQhIr/uXRhaeYqNHBJ7Pt5W9XaqBLCjBbT3A8mUgMdIQ
 poSgAiHdbEGYJn88zRWyvMLWC4wPt8oqcZ/S6pVYwcRlI3AUCs35DNq8N+AQyONA5/hm
 qOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=WIn6iuID7uLZrddonsm2PTziX8HxPL4wzKY3m5G12xs=;
 b=UuN4Z92RW2yE76XGlxx61Ufq/t7je1QL5eXCyn0RWEQXA1vUnJJzRUtJTnrg065IZ6
 b+9H1g4WpBRX3cOcLofdXlga0ExceN1BTz46Lt3xfAXt7ur12kfMadXrkOO4MyiJP+A3
 tKV9bmcz1REcEERdJq9A5cCjbc2R5545YjIC2Y38SRP/ZpjTN6CGj0wYT0T8omekRKZF
 GzMaByrTarv64NbCLK4FuBkWqvBEyco56gxcoiEg6OCicfbyxetvq1yFzrHGnRxlrAii
 jysMtFBo1yfA4VFs88k++TVfrVEfVcLWnqk/zQfccBMEM6x5bqsZu+vOMgnR6LH1Nqs9
 su3g==
X-Gm-Message-State: AOAM53202pA7j9s68wLKbHfHk1Y0sIStboy1rH5o6sgZZMuIRdFBkUhC
 pk/pkxn4JfD9GKghGm4akmoyKnX7qgM=
X-Google-Smtp-Source: ABdhPJxIjPZgxNDpqPCzhP3dhDtl+nhUy636nBGZ1Dc7thltRa5B0ytfb6Ba2wQfv5cVHxt/cUODVA==
X-Received: by 2002:a05:600c:3595:: with SMTP id
 p21mr463027wmq.71.1634742128559; 
 Wed, 20 Oct 2021 08:02:08 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6048:8836:7968:5df6?
 ([2a02:908:1252:fb60:6048:8836:7968:5df6])
 by smtp.gmail.com with ESMTPSA id c17sm2245292wmk.23.2021.10.20.08.02.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Oct 2021 08:02:08 -0700 (PDT)
Subject: Re: [PATCH 3/4] drm/amdgpu: Add kernel parameter for ignoring bad
 page threshold
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>
References: <20211019175050.934527-1-kent.russell@amd.com>
 <20211019175050.934527-3-kent.russell@amd.com>
 <a826bce1-bcff-3984-0d27-30b6c4e0e045@gmail.com>
 <BYAPR12MB33194D82AFAE38A46AC4A89B85BE9@BYAPR12MB3319.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1e69fd16-8a8e-c726-250a-1d2aac3b1f0e@gmail.com>
Date: Wed, 20 Oct 2021 17:02:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <BYAPR12MB33194D82AFAE38A46AC4A89B85BE9@BYAPR12MB3319.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

> As it stands, we have at least two customers who are focused on having the threshold automatically remove the GPUs from use, to ensure data integrity. They just want warnings to know that it's getting bad (my 90% threshold patch), so that they can plan for HW replacement accordingly.

We could handle that outside of the kernel driver. E.g. in userspace for 
example.

Not loading the driver at all results in numerous problems and I think 
not able to retrieve or reset the bad pages counter is just the tip of 
the iceberg here.

To be honest I'm pretty sure that rejecting the driver to load if it 
would work is a no-go and that design is really questionable.

Christian.

Am 20.10.21 um 16:56 schrieb Russell, Kent:
> [AMD Official Use Only]
>
> I can see both sides of the argument. Having a configurable threshold means that you can determine what sort of "HW reliability" that you want. The default value is likely not going to get hit by the average user. And users that DO hit that threshold can determine if they want to ignore it, increase it, or replace the hardware, through the kernel parameter.
>
> But having that option means it's configurable based on what that customer wants. If they believe that all data is precious, setting the threshold to something like 1 bad page means that they won't ever run on a chip that ever had a bad page, thus ensuring data integrity. It seems ludicrous to me to have a value so low, but I am sure that someone out there would want to remove a GPU as soon as it has one bad page retired. And some people couldn't care any less, so they can set it to disabled or ignored or whatever they wish.
>
> As it stands, we have at least two customers who are focused on having the threshold automatically remove the GPUs from use, to ensure data integrity. They just want warnings to know that it's getting bad (my 90% threshold patch), so that they can plan for HW replacement accordingly.
>
>   Kent
>
>> -----Original Message-----
>> From: Christian König <ckoenig.leichtzumerken@gmail.com>
>> Sent: Wednesday, October 20, 2021 6:55 AM
>> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
>> Subject: Re: [PATCH 3/4] drm/amdgpu: Add kernel parameter for ignoring bad page
>> threshold
>>
>> Am 19.10.21 um 19:50 schrieb Kent Russell:
>>> When a GPU hits the bad_page_threshold, it will not be initialized by
>>> the amdgpu driver. This means that the table cannot be cleared, nor can
>>> information gathering be performed (getting serial number, BDF, etc).
>>> Add an override called ignore_bad_page_threshold that can be set to true
>>> to still initialize the GPU, even when the bad page threshold has been
>>> reached.
>> I would rather question the practice of this bad pages threshold.
>>
>> As far as I know the hardware works perfectly fine even when we have
>> more bad badles then expected, we should just warn really loudly about it.
>>
>> Christian.
>>
>>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>>> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
>>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 13 +++++++++++++
>>>    2 files changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> index d58e37fd01f4..b85b67a88a3d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>>> @@ -205,6 +205,7 @@ extern struct amdgpu_mgpu_info mgpu_info;
>>>    extern int amdgpu_ras_enable;
>>>    extern uint amdgpu_ras_mask;
>>>    extern int amdgpu_bad_page_threshold;
>>> +extern bool amdgpu_ignore_bad_page_threshold;
>>>    extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
>>>    extern int amdgpu_async_gfx_ring;
>>>    extern int amdgpu_mcbp;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 96bd63aeeddd..3e9a7b072888 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -189,6 +189,7 @@ struct amdgpu_mgpu_info mgpu_info = {
>>>    int amdgpu_ras_enable = -1;
>>>    uint amdgpu_ras_mask = 0xffffffff;
>>>    int amdgpu_bad_page_threshold = -1;
>>> +bool amdgpu_ignore_bad_page_threshold;
>>>    struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
>>>    	.timeout_fatal_disable = false,
>>>    	.period = 0x0, /* default to 0x0 (timeout disable) */
>>> @@ -880,6 +881,18 @@ module_param_named(reset_method, amdgpu_reset_method,
>> int, 0444);
>>>    MODULE_PARM_DESC(bad_page_threshold, "Bad page threshold(-1 = auto(default
>> value), 0 = disable bad page retirement)");
>>>    module_param_named(bad_page_threshold, amdgpu_bad_page_threshold, int, 0444);
>>>
>>> +/**
>>> + * DOC: ignore_bad_page_threshold (bool) Bad page threshold specifies
>>> + * the threshold value of faulty pages detected by RAS ECC. Once the
>>> + * threshold is hit, the GPU will not be initialized. Use this parameter
>>> + * to ignore the bad page threshold so that information gathering can
>>> + * still be performed. This also allows for booting the GPU to clear
>>> + * the RAS EEPROM table.
>>> + */
>>> +
>>> +MODULE_PARM_DESC(ignore_bad_page_threshold, "Ignore bad page threshold (false =
>> respect bad page threshold (default value)");
>>> +module_param_named(ignore_bad_page_threshold,
>> amdgpu_ignore_bad_page_threshold, bool, 0644);
>>> +
>>>    MODULE_PARM_DESC(num_kcq, "number of kernel compute queue user want to setup
>> (8 if set to greater than 8 or less than 0, only affect gfx 8+)");
>>>    module_param_named(num_kcq, amdgpu_num_kcq, int, 0444);
>>>

