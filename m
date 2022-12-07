Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736E9C4708E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 16:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8CA510E3EC;
	Wed,  7 Dec 2022 16:10:54 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C20010E3EC;
 Wed,  7 Dec 2022 16:10:52 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 r65-20020a1c4444000000b003d1e906ca23so1360776wma.3; 
 Wed, 07 Dec 2022 08:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LQnrVJ37l1LDYVzTkd4lpnU5mu+FBdq07Xj27AvExrw=;
 b=Vxq2kmrGwm644U8TJ1mCFA2aZyG/P5HGnyPnTffTcqgcofzDlq8LQlbhnrqYfmb6+s
 HE8V5RcpcfXExiTHCfD1fUnUFs99DkHIHvtB9SBW2Jr44vnTSgAz8/U3LRnTAeBTlYgH
 V1+9Qo7hEcX7dRzohGYCuaDrCyfZrxWhXfjojnutTbQ/zFDxM2OAlTMbXhoV2bWDbcAO
 NRY26TdSv2RhwbyFL4GCVBX6ekz0nN9kILy8ZpeWaGypdjvE6lJUYfapfH5K0r0NQkMa
 EMY/V40Mvq3bgezTgMeIAAW/DhVgp4QNaxp8pgOYWaYyE5Pz26rrd6bB8lFWmDcScgwq
 deLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LQnrVJ37l1LDYVzTkd4lpnU5mu+FBdq07Xj27AvExrw=;
 b=ALiunXG1Rby/aG401GdERKlxYgGOED+h7AFrqkqt6CvPpbm4JZ+y0fhHtzU+guKUUf
 I0lH5r912KOX6G2sOR48TX8Xctq5LHRa76R+H0BedMOd6KmYybJqiu2268P7+JKZfu6N
 sQLFfW97HD4vkLQ0l7//HGdLqf5y0HPUyLPl464q7/AN5ovCUx+QlBoxi9UrLyBKhr0q
 P3ZWByDp67fnfMWlEKlmJlCy7cpRNZuwbGWR3ogvKroMOqkO1eotdGoWD5mVqvynGhWY
 vtc87ESVMw7Y9bVwSkL2SeePYlZEylJbXYpckObrcSrsZ9Bb4Rnl9eRFGzsRB57C4oD9
 diNA==
X-Gm-Message-State: ANoB5plGkGEJN2hUg0QxvVzVMZykxUszk1ba76Iag2evttEI1keDXkAg
 kIDUThSlDSECF+/22y8itGc=
X-Google-Smtp-Source: AA0mqf58AhIbETtbCIaI86KGXHyEEd4soC3jmzgn0c6pXmuoGdCX2H8tU0z+cFbxSWpgW2UvtYnlbA==
X-Received: by 2002:a05:600c:3d8f:b0:3cf:6b14:1033 with SMTP id
 bi15-20020a05600c3d8f00b003cf6b141033mr67926214wmb.103.1670429450984; 
 Wed, 07 Dec 2022 08:10:50 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:1690:3794:61d2:e9e1?
 ([2a02:908:1256:79a0:1690:3794:61d2:e9e1])
 by smtp.gmail.com with ESMTPSA id
 h1-20020a05600c350100b003a2f2bb72d5sm3006318wmq.45.2022.12.07.08.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Dec 2022 08:10:50 -0800 (PST)
Message-ID: <581403d1-f5f3-72a6-5447-6deef4405d47@gmail.com>
Date: Wed, 7 Dec 2022 17:10:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
 <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
 <CADnq5_PShNRZUwvnsTawW1OaCOjK73rdKTxxQhA=Znf2gqbJ=Q@mail.gmail.com>
 <ce75ecb5-1d07-d8a6-2722-59da84c22c10@gmail.com>
 <CADnq5_Mo_hmc7SCYJxQHc-TgdzXS7+YD-SUt9aF-Gx2AovriRw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_Mo_hmc7SCYJxQHc-TgdzXS7+YD-SUt9aF-Gx2AovriRw@mail.gmail.com>
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 amd-gfx <amd-gfx-bounces@lists.freedesktop.org>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 07.12.22 um 17:08 schrieb Alex Deucher:
> On Wed, Dec 7, 2022 at 10:52 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> Am 07.12.22 um 16:38 schrieb Alex Deucher:
>>> On Wed, Dec 7, 2022 at 10:23 AM Christian König
>>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>>> I would go a step further and just allow GTT domain on ASICs != CARRIZO
>>>> | STONEY.
>>>>
>>>> I can't see a good reason we should still have any limitation here, VRAM
>>>> doesn't have any advantage any more as far as I know.
>>> Well, if VRAM is available we want to make sure someone uses it
>>> otherwise it's just wasted.
>> Well it still gets used when it's free. So now problem at all here.
>>
>> We should just not force anything into VRAM or GTT any more if it's
>> technically not necessary.
> So just this?
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 919bbea2e3ac..8e8f07fa7a93 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1506,7 +1506,7 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
>   uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
>                                              uint32_t domain)
>   {
> -       if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {

We still need to keep this check to avoid trying to adjust VRAM only 
allocations (the cursor still needs this IIRC).

Apart from that I think that should work.

Christian.

> +       if ((adev->asic_type == CHIP_CARRIZO) || (adev->asic_type ==
> CHIP_STONEY)) {
>                  domain = AMDGPU_GEM_DOMAIN_VRAM;
>                  if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
>                          domain = AMDGPU_GEM_DOMAIN_GTT;
>
>
>
>> Christian.
>>
>>> Alex
>>>
>>>
>>>> Christian.
>>>>
>>>> Am 07.12.22 um 16:10 schrieb Alex Deucher:
>>>>> Does this patch fix the problem?
>>>>>
>>>>> Alex
>>>>>
>>>>> On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) <Jesse.Zhang@amd.com> wrote:
>>>>>> [AMD Official Use Only - General]
>>>>>>
>>>>>>
>>>>>>        drm/amdgpu: try allowed domain when pin framebuffer failed.
>>>>>>
>>>>>>
>>>>>>
>>>>>>        [WHY&HOW]
>>>>>>
>>>>>>
>>>>>>
>>>>>>        in some scenarios, the allocate memory often failed. such as do hot plug or play games.
>>>>>>
>>>>>>        so we can try allowed domain, if the preferred domain cannot allocate memory.
>>>>>>
>>>>>>
>>>>>>
>>>>>>        Signed-off-by: jie1zhan jesse.zhang@amd.com
>>>>>>
>>>>>>        Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
>>>>>>
>>>>>>
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>
>>>>>> index 1ae0c8723348..05fcaf7f9d92 100644
>>>>>>
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>>
>>>>>> @@ -39,6 +39,7 @@
>>>>>>
>>>>>> #include "amdgpu.h"
>>>>>>
>>>>>> #include "amdgpu_trace.h"
>>>>>>
>>>>>> #include "amdgpu_amdkfd.h"
>>>>>>
>>>>>> +#include "amdgpu_display.h"
>>>>>>
>>>>>>
>>>>>>
>>>>>> /**
>>>>>>
>>>>>>      * DOC: amdgpu_object
>>>>>>
>>>>>> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>>>>>>
>>>>>>                            bo->placements[i].lpfn = lpfn;
>>>>>>
>>>>>>            }
>>>>>>
>>>>>>
>>>>>>
>>>>>> +       retry:
>>>>>>
>>>>>>            r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>>>
>>>>>>            if (unlikely(r)) {
>>>>>>
>>>>>> +               //try allowed domain when pin failed. just a workaround.
>>>>>>
>>>>>> +               if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
>>>>>>
>>>>>> +                       amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>>>>>>
>>>>>> +                       goto retry;
>>>>>>
>>>>>> +               }
>>>>>>
>>>>>>                    dev_err(adev->dev, "%p pin failed\n", bo);
>>>>>>
>>>>>>                    goto error;
>>>>>>
>>>>>>            }

