Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8719C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 13:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F3110EA72;
	Thu, 29 Sep 2022 13:30:20 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F283510EA72
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 13:30:14 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id u24so1956107edb.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 06:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=Gy92z+cWNk3bDsqQbE507+PBnTDGkavVLrH18KDUv+I=;
 b=K18234oCkmh9XSNOaIFHRRVwoCtHhxdhMDp3mFjnzRJq9kihL4xmuCRuzDJqcEmptV
 b7HDNsWBsmQKb/10cNnWqQOf/MHih68zdEFUNcZGFzCiInMju3TeTFBAAjLPVpVHhNiB
 xoiwGwJ1nSnMZda8tKL/32nkRpI17p3yz2zw+71TFwZHLvHqFmaJDZQ9JjIzcYEEGfSw
 AjUplAbetieigU9F+62ji4sPgzYFE3jPsCEHL0Dx5MzcLA3zUN+nOpdsQs/sGkTl/Y8x
 4xnXUjSGAddjO7/AKcU88/MwSpEuxVeqhtYOpmaZy67tBw1uvIx61IJjQF1uWocQBCyC
 t8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=Gy92z+cWNk3bDsqQbE507+PBnTDGkavVLrH18KDUv+I=;
 b=AQF5yGxHMFBETA9hUli1SflhPdHB6aVOGhqOecfUnLCe2mUA6aPwqW96oySXIOQmuH
 aOY79N9+Z80MxIQwJ1HIUx0rDrx151rdQOBhQAmQagXg4eLDQLvMYmrIudjm1n8dEabZ
 2+V3iNs4kQyc6uPoNrxBvCvwxeIUa03yrdnzXkH79gE1Bi67XjwFrmAWvxLE7vmKYZ7n
 E0gkyvvL0i30nLkhjr9E5LldytKrP9oqjaJJWzY9iX2kqedrpRRImaA5ZEoJFo98OEVn
 kfhgqkF4SJCg2nMCmfoNlJYtkfMqNabUQ6wFNhnXL6k90LnerCcmW0z81SMsMVep7OcL
 bdLg==
X-Gm-Message-State: ACrzQf0fUJLh9/lojGuNjZBCToyXpn3ovOH4EQOkkW80vgK34zpM7hZW
 lT67Inm8NTt8JHPi1cyYWfhl24acTr4=
X-Google-Smtp-Source: AMsMyM79YrXiPOUFwL4H4ci2C0Wih0AhlJWXxYtxiyZXBy0UtGITaTdM+SkBROycT6c7e0kgf8fPzA==
X-Received: by 2002:a05:6402:3887:b0:458:289e:c9cc with SMTP id
 fd7-20020a056402388700b00458289ec9ccmr2731356edb.101.1664458213247; 
 Thu, 29 Sep 2022 06:30:13 -0700 (PDT)
Received: from [192.168.178.21] (p4fc20ebf.dip0.t-ipconnect.de.
 [79.194.14.191]) by smtp.gmail.com with ESMTPSA id
 b12-20020a50cccc000000b00456988774c8sm5497089edj.57.2022.09.29.06.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Sep 2022 06:30:12 -0700 (PDT)
Message-ID: <637b3204-ff52-7718-8623-6231d71f8b9d@gmail.com>
Date: Thu, 29 Sep 2022 15:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amdgpu: use proper DC check in
 amdgpu_display_supported_domains()
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220908143808.53981-1-alexander.deucher@amd.com>
 <CADnq5_MmTAxqdPWp864JhPWPr57Ad7YFxReJeJ=VRdbY9T0C5g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_MmTAxqdPWp864JhPWPr57Ad7YFxReJeJ=VRdbY9T0C5g@mail.gmail.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Feel free to add my acked-by, but that's really not my field of expertise.

Christian.

Am 29.09.22 um 15:15 schrieb Alex Deucher:
> Ping on this series?
>
> Alex
>
> On Thu, Sep 8, 2022 at 10:39 AM Alex Deucher <alexander.deucher@amd.com> wrote:
>> amdgpu_device_asic_has_dc_support() just checks the asic itself.
>> amdgpu_device_has_dc_support() is a runtime check which not
>> only checks the asic, but also other things in the driver
>> like whether virtual display is enabled.  We want the latter
>> here.
>>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> index c20922a5af9f..b0fa5d065d50 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
>> @@ -514,7 +514,7 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
>>           */
>>          if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
>>              amdgpu_bo_support_uswc(bo_flags) &&
>> -           amdgpu_device_asic_has_dc_support(adev->asic_type) &&
>> +           amdgpu_device_has_dc_support(adev) &&
>>              adev->mode_info.gpu_vm_support)
>>                  domain |= AMDGPU_GEM_DOMAIN_GTT;
>>   #endif
>> --
>> 2.37.2
>>

