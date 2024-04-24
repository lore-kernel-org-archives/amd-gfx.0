Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A4FC4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Apr 2024 06:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2309F11382D;
	Wed, 24 Apr 2024 06:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jJ7jNJCd";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBD0711382F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Apr 2024 06:19:11 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-41b08c56254so1659885e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 23:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713939550; x=1714544350; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PU9TMnJFeP6pB4+XrK7lse3R518Pslpm9P4Zvy20Z60=;
 b=jJ7jNJCdk70rsyvodXVdDqNj1MiFPq/1NXITGOKsYBXcbLcm7Qr61ShDJIpTgP5Zv1
 KrsOC3ZjiBTj0m49ZA6xkSgniQOX649ROEDK6LDA6f5TpueRWLiKPcfydbQ/vjdUy9Oe
 lCTxOjCUF+/PZwr7177VYEFPTHsBFdpjfhW5zDPJBHBJP/equp+b9WMDK25tBU/jcFG2
 cU2bMwRsfrx9eu7fJtP7fFdMY3mEV+VvjLgJllChQYjZEM+7hsICQM6k+KqLzmAfktMr
 JhMxl3APhIW74Yma17EwJpCH8axdQoCLikU4D90i2yc7smoCEUuPzcWiknimcQwn2c8M
 PK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713939550; x=1714544350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PU9TMnJFeP6pB4+XrK7lse3R518Pslpm9P4Zvy20Z60=;
 b=a21Q6PvnoHTs2A+K6jjmsGAxgR2bvgWCipL375nor2rAAZYfy2w5chr8shuSqakoc2
 NgHgZw2KOhc5foe8JGibhC4AUlSiOxAy/Ul/1klf70O2rvO2NgrTKcLkzpzp/d+i6Wu8
 8kz9PS5FwWzfDBtA4K3s/5M0OoJeLXtARcl+vchBBkwZ9bJOVV8PvCjS60xXS50+WwtQ
 wHRROl1rHSrkQSYDEQhlt3KZzRmhIvMB/4p4WJa6DXzuors8vzgRe8tkS9hwDcIGFvko
 Bel6FpYjQ61lghihfAf5+wJ8aOVcR+MS6d70Y3M07j0J4z3xoDAFeZ3+5Qs0Kfj087DD
 5sMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnAZsUGXkNJq2jW7tIhMe0nRSAqZ9QGYzXGvC2f13U1LyHZYa+BQLltXSn6NtmPvto/BQ2cQ/whUan0Q2tpiI5k2u0nMje7R9hnL/z5A==
X-Gm-Message-State: AOJu0Yx2fBNpSk8SVFRjuQWeImHVkh0OaCQDyMnMXqv3zCDbWTY9FF0e
 ry/Jmw4tXC20LYr7YwePQC/xUP5qW3OFSygnmFyj4ZSldll0kraM
X-Google-Smtp-Source: AGHT+IEhRNWc7ygs2p2wM0MT3kx3bcUGY1sYt1xLXERT5C+84DdSu6pXIPjdcVRXQP8H/D9iahyvNQ==
X-Received: by 2002:a05:600c:3c95:b0:41a:5521:d82c with SMTP id
 bg21-20020a05600c3c9500b0041a5521d82cmr1455218wmb.29.1713939549835; 
 Tue, 23 Apr 2024 23:19:09 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 l37-20020a05600c1d2500b004186f979543sm26656085wms.33.2024.04.23.23.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 23:19:09 -0700 (PDT)
Message-ID: <a9797ada-63b8-4d3b-827e-f8173ae03abb@gmail.com>
Date: Wed, 24 Apr 2024 08:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix two reset triggered in a row
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
 <572623ed-f353-46f2-809e-4678b152fa5e@amd.com>
 <eab5193a-7613-4733-a006-9eaf5598647a@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <eab5193a-7613-4733-a006-9eaf5598647a@amd.com>
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

Am 23.04.24 um 20:05 schrieb Felix Kuehling:
>
> On 2024-04-23 01:50, Christian König wrote:
>> Am 22.04.24 um 21:45 schrieb Yunxiang Li:
>>> Reset request from KFD is missing a check for if a reset is already in
>>> progress, this causes a second reset to be triggered right after the
>>> previous one finishes. Add the check to align with the other reset 
>>> sources.
>>
>> NAK, that isn't how this should be handled.
>>
>> Instead all reset source which are handled by a previous reset should 
>> be canceled.
>>
>> In other words there should be a cancel_work(&adev->kfd.reset_work); 
>> somewhere in the KFD code. When this doesn't work correctly then that 
>> is somehow missing.
>>
>> If you see the use of amdgpu_in_reset() outside of the low level 
>> functions than that is clearly a bug.
> Do we need to do that for all reset workers in the driver separately? 
> I don't see where this is done for other reset workers.

Yeah, I think so. But we don't have so many reset workers if I'm not 
completely mistaken.

We have the KFD, FLR, the per engine one in the scheduler and IIRC one 
more for the CP (illegal operation and register write).

I'm not sure about the CP one, but all others should be handled 
correctly with the V2 patch as far as I can see.

Regards,
Christian.

>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 3b4591f554f1..ce3dbb1cc2da 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -283,7 +283,7 @@ int amdgpu_amdkfd_post_reset(struct 
>>> amdgpu_device *adev)
>>>     void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>>>   {
>>> -    if (amdgpu_device_should_recover_gpu(adev))
>>> +    if (amdgpu_device_should_recover_gpu(adev) && 
>>> !amdgpu_in_reset(adev))
>>>           amdgpu_reset_domain_schedule(adev->reset_domain,
>>>                            &adev->kfd.reset_work);
>>>   }
>>

