Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB11BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Mar 2022 07:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BC8110EFEB;
	Wed,  2 Mar 2022 07:46:26 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C43F10EFEB
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Mar 2022 07:46:25 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 n33-20020a05600c3ba100b003832caf7f3aso616055wms.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 23:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=aqGCHnFMp54LPE9SOd1hsLpp0/wx4mbPod0shgLELCk=;
 b=mIkYEYK63zlTjGRCxIka3GXdw1H/Py4PlIgRnnZl30FQ3kQbYkLGh5526IAgFkS96a
 +igbtOq9l4rrxGkFokXavga+pttAa1tV8yMAxh3a5AvabTATj2l7wTf7EgWRsQZ6NyD6
 ETsPRi6BGB5dZtrGBURlA/KYxBFcu3keI+HT62x5VZl5TD49/lgLtoDfgvCo3GnbV8Zl
 ysJcxq5e1ysIG9m5zrRJ/Tu9ATgi7SKOrZB2NWqd7RdeBAyj4bS5iyqaHlRFwMVI5btj
 IzykiXNquTKYzl5YRHq+lq1OepaHc3WBfT5+oRJjoJoHJKruvbdQBb5SC6NLlb11d2ob
 cw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=aqGCHnFMp54LPE9SOd1hsLpp0/wx4mbPod0shgLELCk=;
 b=2FOXQ6odccnVFb9WXU/hyENHUWfa9CrrBCY8YroRrqfB8ew55tzbA5P2hkArvct55F
 u7H9xVssbDpLxGKMyM+oHrbTM3hjBInCWjqLNu1F4U5+1qpAn13xYTPF3AICTfxFSZ49
 lwutGq2j/4rqL4HQp4k+Wo4kjXHRbFgs3WdPFT4kJy4HOF44MqHUqtpXawjAbIuq9i7r
 RhHkUs+O684vKP14OXIsHmt3jk3hLSL88ZIzshcjlHYBV07YCDHlR5R3ESVD75fNOJtb
 uHovaVyAnUpyOFCks+01aPeFRWPcMYQrSH+FiTX/eWZyCiIlZEXijiPJH6dKRnZuZKe/
 m1aA==
X-Gm-Message-State: AOAM530Ihbn+YNcmhwFseMXD+yTe/a6rJHHrscMqfkwsXPZASAmf85Ck
 PuYqY+zEKCEHoUm3ojHz4SgGaCNHL/Y=
X-Google-Smtp-Source: ABdhPJx9AcxBxBZcglm96BEsNvnH5A9vGSDYYcJ/uKb4HYecfsqHPAkT/YRGhuO4Oo1AcTE91vxOcQ==
X-Received: by 2002:a05:600c:3b26:b0:381:4360:8f83 with SMTP id
 m38-20020a05600c3b2600b0038143608f83mr15806152wms.192.1646207183839; 
 Tue, 01 Mar 2022 23:46:23 -0800 (PST)
Received: from ?IPV6:2a02:908:1252:fb60:d566:4ce9:8661:235c?
 ([2a02:908:1252:fb60:d566:4ce9:8661:235c])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a05600011cf00b001edc2966dd4sm15582020wrx.47.2022.03.01.23.46.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Mar 2022 23:46:23 -0800 (PST)
Message-ID: <54c29b0b-fe03-7c59-061c-15a87965e477@gmail.com>
Date: Wed, 2 Mar 2022 08:46:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] drm/amdgpu: convert code name to ip version for
 noretry set
Content-Language: en-US
To: Paul Menzel <pmenzel@molgen.mpg.de>, Yifan Zhang <yifan1.zhang@amd.com>
References: <20220301150121.3785743-1-yifan1.zhang@amd.com>
 <20220301150121.3785743-2-yifan1.zhang@amd.com>
 <d356df33-4f6f-e8a2-08c3-cfee6b904c37@molgen.mpg.de>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <d356df33-4f6f-e8a2-08c3-cfee6b904c37@molgen.mpg.de>
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
Cc: alexander.deucher@amd.com, Ray.Huang@amd.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.03.22 um 16:24 schrieb Paul Menzel:
> Dear Yifan,
>
>
> Thank you for your patch.
>
> Am 01.03.22 um 16:01 schrieb Yifan Zhang:
>> Use IP version rather than codename for noretry set.
>
> Why?

Why not?

>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 17 ++++++++---------
>>   1 file changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> index ab75e189bc0b..fbc22b7b6315 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>> @@ -559,14 +559,14 @@ void amdgpu_gmc_noretry_set(struct 
>> amdgpu_device *adev)
>>   {
>>       struct amdgpu_gmc *gmc = &adev->gmc;
>>   -    switch (adev->asic_type) {
>> -    case CHIP_VEGA10:
>> -    case CHIP_VEGA20:
>> -    case CHIP_ARCTURUS:
>> -    case CHIP_ALDEBARAN:
>> -    case CHIP_BEIGE_GOBY:
>> -    case CHIP_YELLOW_CARP:
>> -    case CHIP_RENOIR:
>> +    switch (adev->ip_versions[GC_HWIP][0]) {
>> +    case IP_VERSION(9, 0, 1):
>> +    case IP_VERSION(9, 4, 0):
>> +    case IP_VERSION(9, 4, 1):
>> +    case IP_VERSION(9, 4, 2):
>> +    case IP_VERSION(10, 3, 5):
>> +    case IP_VERSION(10, 3, 3):
>> +    case IP_VERSION(9, 3, 0):
>
> I think, sorting these entries might be useful.
>
> Should the names be added as comments for those not having them 
> memorized?
>
>>           /*
>>            * noretry = 0 will cause kfd page fault tests fail
>>            * for some ASICs, so set default to 1 for these ASICs.
>> @@ -576,7 +576,6 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device 
>> *adev)
>>           else
>>               gmc->noretry = amdgpu_noretry;
>>           break;
>> -    case CHIP_RAVEN:
>
> Why remove this?
>
>>       default:
>>           /* Raven currently has issues with noretry
>>            * regardless of what we decide for other
>
>
> Kind regards,
>
> Paul

