Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61EBC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Dec 2022 08:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E4D10E46F;
	Thu,  8 Dec 2022 08:19:09 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2231510E46F;
 Thu,  8 Dec 2022 08:19:06 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id e13so1085141edj.7;
 Thu, 08 Dec 2022 00:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T1AFEAYMaBU8xgrytg9PkmlBf90Hjr7hbMHiO+fxfko=;
 b=nG85WdhQ0p+FQgAf+ZqF4QNU8P5BkL6V9likRtLGq2HFsjmlOb2GXH538YVQp1SRYf
 0Y9xgD/SCjfrFateDN8EyxIP9s7yrggT4P8A3S0XyQ/EMXvaOmOD0DbdRxw3hsL/9b+b
 N1rhwZXo6m83PZF7VIRD1U2HrI3xqBceSgLRfPWc4OcRYscB3dy2XIkFyuWPdj1xjU7t
 CtvvO+8eOO2RSLxmzqdGQj2ypPR3Y1FXE4OkJVH+gI6dKgurPBcwxdbnwANVG8Kg7q2N
 ChfSGgD6izMATDHtsGKFGm4c72fCYPuq4UiZOOQhn9+/5XTcYsczACzYrFnBh9VagURb
 qRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T1AFEAYMaBU8xgrytg9PkmlBf90Hjr7hbMHiO+fxfko=;
 b=hAlJAyJYv1hktGYbVj5pTL7klTUd6IHVLa9Scp8a+o2U9EQ3m3dMADyVvkHABDQMVv
 3JMNC7n7xPz01T4cAq9/3Oq299Qk6B85g478pP6WUYpqCS8RyVX0XfhdGo+dc37feX26
 IG01sIr/YfvUIpRZiSZxC/0Tz+3k5JmO2866yyPItzFwUydFZdFhkZ+E95HTA2k7eMAS
 DKjHqCRpRRnBr/uYUKM/Ct5pl0nzmW57agkdw5GmuVhY0mO7spUh6OKFo/nqk7GcKBtw
 DKA00LVYWw2uA3e7ws5bfBBqUmgoWQcxkOG0nBB6+Ac2bnbKqlQg+tKYErjvAuyyyys0
 1wJw==
X-Gm-Message-State: ANoB5plOBmsToWa3zSkpVhI+NFWgBuHFPUae8esyGcUcE8wznhTj0ije
 DuD6wSo9GSXGuFIJf3nXryM=
X-Google-Smtp-Source: AA0mqf4nDyoDWXw+55cOGyTyJqvNgngbhSYjDduJyjpKRcRhYoL2hHblUnHRde6EylSnmbNp5R3Fxw==
X-Received: by 2002:a05:6402:1c1a:b0:46c:74f0:c064 with SMTP id
 ck26-20020a0564021c1a00b0046c74f0c064mr16959224edb.85.1670487544567; 
 Thu, 08 Dec 2022 00:19:04 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:172d:b6f5:d270:8dd2?
 ([2a02:908:1256:79a0:172d:b6f5:d270:8dd2])
 by smtp.gmail.com with ESMTPSA id
 v24-20020a056402175800b0046182b3ad46sm3084203edx.20.2022.12.08.00.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Dec 2022 00:19:03 -0800 (PST)
Message-ID: <17c03574-363a-d4e9-edc1-48ad4c493de2@gmail.com>
Date: Thu, 8 Dec 2022 09:19:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, "Zhang, Yifan" <Yifan1.Zhang@amd.com>
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
 <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
 <CADnq5_PShNRZUwvnsTawW1OaCOjK73rdKTxxQhA=Znf2gqbJ=Q@mail.gmail.com>
 <ce75ecb5-1d07-d8a6-2722-59da84c22c10@gmail.com>
 <CADnq5_Mo_hmc7SCYJxQHc-TgdzXS7+YD-SUt9aF-Gx2AovriRw@mail.gmail.com>
 <581403d1-f5f3-72a6-5447-6deef4405d47@gmail.com>
 <CADnq5_OtFeSYKKjniNXuXUmX4WgXw1+hN-3YoRpBh-Ytjosv5g@mail.gmail.com>
 <CY5PR12MB6369519F1EABAE9A86957850C11D9@CY5PR12MB6369.namprd12.prod.outlook.com>
 <CADnq5_PR+7s=FPY71j3XqUA4C62j8zE8FRKq+Oty=nNjSN=Rzw@mail.gmail.com>
 <CY5PR12MB63699C93015F77F4C6AD5BDBC11D9@CY5PR12MB6369.namprd12.prod.outlook.com>
 <CADnq5_P0YmG0y-0NCufcx8-d6Y2CuHxf+TH2xDVY7QDhG+=C4w@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_P0YmG0y-0NCufcx8-d6Y2CuHxf+TH2xDVY7QDhG+=C4w@mail.gmail.com>
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
Cc: amd-gfx <amd-gfx-bounces@lists.freedesktop.org>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.12.22 um 05:40 schrieb Alex Deucher:
> On Wed, Dec 7, 2022 at 11:35 PM Zhang, Yifan <Yifan1.Zhang@amd.com> wrote:
>> [AMD Official Use Only - General]
>>
>> We encountered some issues in recent APUs when tried to pin a large framebuffer (e.g. 64MB w/ dual 4K display), switch to display SG could resolve such issue.  Actually we received various kinds of VRAM shortage issues recently, there is more and more pressure on APU 512MB VRAM as FWs reserve more memory, buddy system in 5.19 creates more fragment and multiple 4k display scenario is used  more often.. Since there is no difference b/w access VRAM and System memory in APUs from HW perspective, I think we can switch some of framebuffers to system memory to mitigate VRAM pressure.
>>
>> [   52.798705] [TTM] Failed to find memory space for buffer 0x00000000833a4c59 eviction
>> [   52.798707] [TTM]  No space for 00000000833a4c59 (16470 pages, 65880K, 64M)
>> [   52.798788] amdgpu 0000:e2:00.0: amdgpu: 000000003dbf313e pin failed
>> [   52.798790] [drm:dm_plane_helper_prepare_fb [amdgpu]] *ERROR* Failed to pin framebuffer with error -12
> But from the patch:
> -    if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
> +    if ((domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) &&
> +        ((adev->asic_type == CHIP_CARRIZO) || (adev->asic_type ==
> CHIP_STONEY))) {
>           domain = AMDGPU_GEM_DOMAIN_VRAM;
>           if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
>               domain = AMDGPU_GEM_DOMAIN_GTT;
>
> AMDGPU_SG_THRESHOLD is only used in this one place which only applies
> to CZ and ST.  There are not likely to be new CZ or ST boards any time
> soon so I don't think it matters for newer APUs if we change
> AMDGPU_SG_THRESHOLD.

Yeah, agree completely. We shouldn't change the threshold because of the 
hw limitations on CZ/ST.

Maybe we should even force the BOs into GTT on those boards to avoid 
using both VRAM and GTT at the same time, but not sure about that.

Regards,
Christian.

>
> Does the patch fix the issues you are seeing?
>
> Alex
>
>> Best Regards,
>> Yifan
>>
>> -----Original Message-----
>> From: Alex Deucher <alexdeucher@gmail.com>
>> Sent: Thursday, December 8, 2022 12:19 PM
>> To: Zhang, Yifan <Yifan1.Zhang@amd.com>
>> Cc: Christian König <ckoenig.leichtzumerken@gmail.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx <amd-gfx-bounces@lists.freedesktop.org>; Paneer Selvam, Arunpravin <Arunpravin.PaneerSelvam@amd.com>; amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
>>
>> On Wed, Dec 7, 2022 at 11:10 PM Zhang, Yifan <Yifan1.Zhang@amd.com> wrote:
>>> [AMD Official Use Only - General]
>>>
>>> Hi Alex,
>>>
>>> We need to adjust the AMDGPU_SG_THRESHOLD as well since recent APUs are configured w/ 512MB VRAM. Pls check attached patch.
>> Why do we need to increase this threshold?  The condition only applies to CZ and ST, not more recent APUs.
>>
>> Alex
>>
>>> Best Regards,
>>> Yifan
>>>
>>> -----Original Message-----
>>> From: Alex Deucher <alexdeucher@gmail.com>
>>> Sent: Thursday, December 8, 2022 12:21 AM
>>> To: Christian König <ckoenig.leichtzumerken@gmail.com>
>>> Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Zhang, Yifan
>>> <Yifan1.Zhang@amd.com>; amd-gfx
>>> <amd-gfx-bounces@lists.freedesktop.org>; Paneer Selvam, Arunpravin
>>> <Arunpravin.PaneerSelvam@amd.com>; amd-gfx@lists.freedesktop.org;
>>> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>>> <Christian.Koenig@amd.com>
>>> Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin
>>> framebuffer failed
>>>
>>> On Wed, Dec 7, 2022 at 11:10 AM Christian König <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>
>>>>
>>>> Am 07.12.22 um 17:08 schrieb Alex Deucher:
>>>>> On Wed, Dec 7, 2022 at 10:52 AM Christian König
>>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>>> Am 07.12.22 um 16:38 schrieb Alex Deucher:
>>>>>>> On Wed, Dec 7, 2022 at 10:23 AM Christian König
>>>>>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>>>>>> I would go a step further and just allow GTT domain on ASICs !=
>>>>>>>> CARRIZO
>>>>>>>> | STONEY.
>>>>>>>>
>>>>>>>> I can't see a good reason we should still have any limitation
>>>>>>>> here, VRAM doesn't have any advantage any more as far as I know.
>>>>>>> Well, if VRAM is available we want to make sure someone uses it
>>>>>>> otherwise it's just wasted.
>>>>>> Well it still gets used when it's free. So now problem at all here.
>>>>>>
>>>>>> We should just not force anything into VRAM or GTT any more if
>>>>>> it's technically not necessary.
>>>>> So just this?
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> index 919bbea2e3ac..8e8f07fa7a93 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>> @@ -1506,7 +1506,7 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
>>>>>    uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>>>>>                                               uint32_t domain)
>>>>>    {
>>>>> -       if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
>>>> We still need to keep this check to avoid trying to adjust VRAM only
>>>> allocations (the cursor still needs this IIRC).
>>>>
>>>> Apart from that I think that should work.
>>> Attached.  Thanks,
>>>
>>> Alex
>>>
>>>> Christian.
>>>>
>>>>> +       if ((adev->asic_type == CHIP_CARRIZO) || (adev->asic_type
>>>>> + ==
>>>>> CHIP_STONEY)) {
>>>>>                   domain = AMDGPU_GEM_DOMAIN_VRAM;
>>>>>                   if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
>>>>>                           domain = AMDGPU_GEM_DOMAIN_GTT;
>>>>>
>>>>>
>>>>>
>>>>>> Christian.
>>>>>>
>>>>>>> Alex
>>>>>>>
>>>>>>>
>>>>>>>> Christian.
>>>>>>>>
>>>>>>>> Am 07.12.22 um 16:10 schrieb Alex Deucher:
>>>>>>>>> Does this patch fix the problem?
>>>>>>>>>
>>>>>>>>> Alex
>>>>>>>>>
>>>>>>>>> On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) <Jesse.Zhang@amd.com> wrote:
>>>>>>>>>> [AMD Official Use Only - General]
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>         drm/amdgpu: try allowed domain when pin framebuffer failed.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>         [WHY&HOW]
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>         in some scenarios, the allocate memory often failed. such as do hot plug or play games.
>>>>>>>>>>
>>>>>>>>>>         so we can try allowed domain, if the preferred domain cannot allocate memory.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>         Signed-off-by: jie1zhan jesse.zhang@amd.com
>>>>>>>>>>
>>>>>>>>>>         Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>>>>>
>>>>>>>>>> index 1ae0c8723348..05fcaf7f9d92 100644
>>>>>>>>>>
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>>>>>
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>>>>>
>>>>>>>>>> @@ -39,6 +39,7 @@
>>>>>>>>>>
>>>>>>>>>> #include "amdgpu.h"
>>>>>>>>>>
>>>>>>>>>> #include "amdgpu_trace.h"
>>>>>>>>>>
>>>>>>>>>> #include "amdgpu_amdkfd.h"
>>>>>>>>>>
>>>>>>>>>> +#include "amdgpu_display.h"
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> /**
>>>>>>>>>>
>>>>>>>>>>       * DOC: amdgpu_object
>>>>>>>>>>
>>>>>>>>>> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct
>>>>>>>>>> amdgpu_bo *bo, u32 domain,
>>>>>>>>>>
>>>>>>>>>>                             bo->placements[i].lpfn = lpfn;
>>>>>>>>>>
>>>>>>>>>>             }
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> +       retry:
>>>>>>>>>>
>>>>>>>>>>             r = ttm_bo_validate(&bo->tbo, &bo->placement,
>>>>>>>>>> &ctx);
>>>>>>>>>>
>>>>>>>>>>             if (unlikely(r)) {
>>>>>>>>>>
>>>>>>>>>> +               //try allowed domain when pin failed. just a workaround.
>>>>>>>>>>
>>>>>>>>>> +               if (unlikely(r == -ENOMEM) && domain !=
>>>>>>>>>> + bo->allowed_domains) {
>>>>>>>>>>
>>>>>>>>>> +                       amdgpu_bo_placement_from_domain(bo,
>>>>>>>>>> + bo->allowed_domains);
>>>>>>>>>>
>>>>>>>>>> +                       goto retry;
>>>>>>>>>>
>>>>>>>>>> +               }
>>>>>>>>>>
>>>>>>>>>>                     dev_err(adev->dev, "%p pin failed\n", bo);
>>>>>>>>>>
>>>>>>>>>>                     goto error;
>>>>>>>>>>
>>>>>>>>>>             }

