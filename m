Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F06EE14D4
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 06:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA38110E776;
	Thu,  7 Sep 2023 06:58:03 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7645810E776
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 06:58:01 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-500cfb168c6so936308e87.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Sep 2023 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694069879; x=1694674679; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kerwl5HF+Xm5JezxyYP3tASoeXxmfJiJV7EHDFZUhGI=;
 b=MPwfWyH85j/aTxtsNr7ytraaYwjIJbODKo6nhMPbc6NY8wamJkPso7BDalu3CNq8un
 RyMH/Yl/jhOlTD9/LcPw9S1MgfEfxPyJ4OQiKzh5c2DzERw5OCtblb1rmngWwlBKOwJ8
 0cR6eab+H1eT13wqXmY9OsM6gGX1TLpZTc3x/YrT+pwT+D1lL5fnUJH8Fxp6cQeso2ne
 euf+ggfkS4HG3py5UKT1TEF+jwPH0LpVG8RjhT2ZvRC3MPVKUD1R3Lb2BQcvhZPgwwpM
 ZCP+p/2JDTETpSFajKKg59WvpwErAmW9XlaeTBAA7o4PPLBAYMfal6W7r5g6ZrGoFHDw
 lJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694069879; x=1694674679;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kerwl5HF+Xm5JezxyYP3tASoeXxmfJiJV7EHDFZUhGI=;
 b=gdGb9KUE7urXTdHJcMYFKN3zrMn/VweMu0SYJHp29L1uuFZosXhLw4L1dlKbvkTSnA
 C6YCHgJer5TTy6/fE/kNXEz1EBS3rMwSTqjyHIyMjhwxmlJGPSL56pVRe+FQWbnazKF0
 rXIe22dV+2ecf3sJ91USsSAPbegQ3oJXv46YNNM6szDiBR897DtCG1begDEpj1Mlttyo
 H4TfrkNKCeUwxSJb15Z+tb3lo0c4SCP3SvKrsEBXinKKgt2PYc2vNWgWrJ7C15/EUok/
 A5HdvFeSZqj8tABzRMhqBjGY8Ye0Gy53KLLEZSEV2vm+RZf+YqRLKQMPjbx3wN2d5fpi
 OYUw==
X-Gm-Message-State: AOJu0YwG39/HyfWHwfV0PVwbFql4xcve/h4cndDqpqghrhrBeDMSr0+g
 /QfzjnLnIglibbBMuUueknc=
X-Google-Smtp-Source: AGHT+IHw8xbguNVM1ldaG+v+xPl7PNMJyKri9aBGP1mCd7KhDswsQt2eOPzzXl2GLwuU1+WXximi1w==
X-Received: by 2002:a05:6512:3b7:b0:4fd:d213:dfd0 with SMTP id
 v23-20020a05651203b700b004fdd213dfd0mr3283134lfp.11.1694069879268; 
 Wed, 06 Sep 2023 23:57:59 -0700 (PDT)
Received: from [192.168.178.25] ([134.19.111.81])
 by smtp.gmail.com with ESMTPSA id
 s23-20020a170906c31700b009934b1eb577sm10010998ejz.77.2023.09.06.23.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 23:57:58 -0700 (PDT)
Message-ID: <7e43a523-8ea9-486a-b48f-10ea7995dc31@gmail.com>
Date: Thu, 7 Sep 2023 08:57:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 04/11] drm/amdgpu: fix and cleanup
 gmc_v7_0_flush_gpu_tlb_pasid
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230905060415.1400-1-christian.koenig@amd.com>
 <20230905060415.1400-5-christian.koenig@amd.com>
 <4995b233-e9db-93a0-1ba6-60376cb5d024@amd.com>
 <e75b6e4a-d4f4-7754-e102-4d9f64e8b70b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <e75b6e4a-d4f4-7754-e102-4d9f64e8b70b@amd.com>
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

Am 06.09.23 um 16:35 schrieb Shashank Sharma:
>
> On 06/09/2023 16:25, Shashank Sharma wrote:
>>
>> On 05/09/2023 08:04, Christian König wrote:
>>> Testing for reset is pointless since the reset can start right after 
>>> the
>>> test. Grab the reset semaphore instead.
>>>
>>> The same PASID can be used by more than once VMID, build a mask of 
>>> VMIDs
>>> to reset instead of just restting the first one.
>>>
>>> Signed-off-by: Christian König <christian.koenig@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 19 ++++++++++---------
>>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> index 6a6929ac2748..9e19a752f94b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>> @@ -33,6 +33,7 @@
>>>   #include "amdgpu_ucode.h"
>>>   #include "amdgpu_amdkfd.h"
>>>   #include "amdgpu_gem.h"
>>> +#include "amdgpu_reset.h"
>>>     #include "bif/bif_4_1_d.h"
>>>   #include "bif/bif_4_1_sh_mask.h"
>>> @@ -426,23 +427,23 @@ static int gmc_v7_0_flush_gpu_tlb_pasid(struct 
>>> amdgpu_device *adev,
>>>                       uint16_t pasid, uint32_t flush_type,
>>>                       bool all_hub, uint32_t inst)
>>>   {
>>> +    u32 mask = 0x0;
>>>       int vmid;
>>> -    unsigned int tmp;
>>>   -    if (amdgpu_in_reset(adev))
>>> -        return -EIO;
>>> + if(!down_read_trylock(&adev->reset_domain->sem))
>>> +        return 0;
>>>         for (vmid = 1; vmid < 16; vmid++) {
>>> +        u32 tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>>>   -        tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
>>>           if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
>>> -            (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
>>> -            WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
>>> -            RREG32(mmVM_INVALIDATE_RESPONSE);
>>> -            break;
>>> -        }
>>> +            (tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid)
>>> +            mask |= 1 << vmid;
>>
>> I am a bit concerned here about the change in code, in the previous 
>> code we were writing the 'first match out of 16' of tmp and of mask 
>> and programming the registers with (1 << vmid), whereas in new code 
>> set we are writing the 'last match out of 16' of vmid. Is that 
>> intentional or expected ?
>>
> With last, I mean all matching bits until last :)

Take a closer look :)

The bits are ORed together for each VMID which has the matching pasid.

Christian.

>> - Shashank
>>
>>>       }
>>>   +    WREG32(mmVM_INVALIDATE_REQUEST, mask);
>>> +    RREG32(mmVM_INVALIDATE_RESPONSE);
>>> +    up_read(&adev->reset_domain->sem);
>>>       return 0;
>>>   }

