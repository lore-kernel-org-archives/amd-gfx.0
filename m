Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14DAC352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E16110E3CB;
	Wed,  7 Dec 2022 15:23:32 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A63010E3CB;
 Wed,  7 Dec 2022 15:23:28 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 p13-20020a05600c468d00b003cf8859ed1bso1314608wmo.1; 
 Wed, 07 Dec 2022 07:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6lfX2espe1pbe0zK7LfbYp7zz5fE9qT+Xo+bUOcdecc=;
 b=nCV7pIGbyhHwjZE8iTUIWZsq+uU6zeZif5rXDWflrwM+Onp1EtmiS3FlXGJ4UU+Mls
 wYqh2Ljs3Ghjc05XsiKDo9kpKvMrX+NV7cYOOJ3na07rFP8DJQzFL0d8S9Yhdym6O+BY
 uMb7HrTlnMC097/3KVl7u4SU00CGVGERhkl8ZwZ30XFB2h52/vXvV+oh2qmc8h/Rh4yX
 XMToMkad9OVALf4d/IIffHy9c850ZXbY5ofKYMAC9YhrANLIyWaGyG/pHYAno4rNt07x
 nXtECo5T4PeubYrchvFgZUmDmyz0OqZBaicmnXB5N1WUkwxIPXrXQ5HLXUnpfTy4F3W3
 e33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6lfX2espe1pbe0zK7LfbYp7zz5fE9qT+Xo+bUOcdecc=;
 b=Tr+D6bWrbq0fgvZduXvkAWUn9mr1B6xahRbDfB5z0cHP7ZH08+8t7BWHxtjPTk7XSv
 GQ+IuAWtlYAEs3zjLlrwzbvjX8ygBuc7+NSrULoe5ZOiYhw2htegWXUnhDLggCNbw9a2
 d/a2By5mDGxILEfEDBW/YCK4L5IPjfrAcX9lXfqN/qCOxhe67IwOpIQ9m9hUFD0GqMQZ
 hIS7g2IUJMWllyWCnjRCfTw8GtJlhH4ZIo6YXTr0SvER2Zqj16WWk2R15GDsjumJ2s0f
 JUssg6NPSFRAT9dGrsjD4tJ7KiSPdh9kBkvMQDSbaSFOL9dvyTJIuzfHTmQMTSRMRZ1x
 lJ6A==
X-Gm-Message-State: ANoB5pkxEO/OqTun5qg97X1SazHhO98dDbqz39Di/ePChP3LOm1phhem
 CVP4V9U18kolodCJlZPnKOk=
X-Google-Smtp-Source: AA0mqf6BTcK38C5ZIWnbGezst0tEHtZt/OvyiArc/t+C/XK8tbhe2Y84wh82vQAKcgPg+3SdZecehQ==
X-Received: by 2002:a1c:2b81:0:b0:3b4:88ba:a74c with SMTP id
 r123-20020a1c2b81000000b003b488baa74cmr53562589wmr.77.1670426607012; 
 Wed, 07 Dec 2022 07:23:27 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:1690:3794:61d2:e9e1?
 ([2a02:908:1256:79a0:1690:3794:61d2:e9e1])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a5d44cc000000b002362f6fcaf5sm19779843wrr.48.2022.12.07.07.23.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Dec 2022 07:23:26 -0800 (PST)
Message-ID: <4e415872-3fcf-27b9-dc74-b3e86f171e1c@gmail.com>
Date: Wed, 7 Dec 2022 16:23:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: try allowed domain when pin framebuffer failed
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
References: <DM4PR12MB51524585CEC4E2B4B8370874E31A9@DM4PR12MB5152.namprd12.prod.outlook.com>
 <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_NWr9SAzcQ=x-UVXWHDBci6f_pg-sRj3AD8q5GWYbBJOw@mail.gmail.com>
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 amd-gfx <amd-gfx-bounces@lists.freedesktop.org>, "Paneer Selvam,
 Arunpravin" <Arunpravin.PaneerSelvam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I would go a step further and just allow GTT domain on ASICs != CARRIZO 
| STONEY.

I can't see a good reason we should still have any limitation here, VRAM 
doesn't have any advantage any more as far as I know.

Christian.

Am 07.12.22 um 16:10 schrieb Alex Deucher:
> Does this patch fix the problem?
>
> Alex
>
> On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) <Jesse.Zhang@amd.com> wrote:
>> [AMD Official Use Only - General]
>>
>>
>>      drm/amdgpu: try allowed domain when pin framebuffer failed.
>>
>>
>>
>>      [WHY&HOW]
>>
>>
>>
>>      in some scenarios, the allocate memory often failed. such as do hot plug or play games.
>>
>>      so we can try allowed domain, if the preferred domain cannot allocate memory.
>>
>>
>>
>>      Signed-off-by: jie1zhan jesse.zhang@amd.com
>>
>>      Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
>>
>>
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>
>> index 1ae0c8723348..05fcaf7f9d92 100644
>>
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>
>> @@ -39,6 +39,7 @@
>>
>> #include "amdgpu.h"
>>
>> #include "amdgpu_trace.h"
>>
>> #include "amdgpu_amdkfd.h"
>>
>> +#include "amdgpu_display.h"
>>
>>
>>
>> /**
>>
>>    * DOC: amdgpu_object
>>
>> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>>
>>                          bo->placements[i].lpfn = lpfn;
>>
>>          }
>>
>>
>>
>> +       retry:
>>
>>          r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>
>>          if (unlikely(r)) {
>>
>> +               //try allowed domain when pin failed. just a workaround.
>>
>> +               if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
>>
>> +                       amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>>
>> +                       goto retry;
>>
>> +               }
>>
>>                  dev_err(adev->dev, "%p pin failed\n", bo);
>>
>>                  goto error;
>>
>>          }

