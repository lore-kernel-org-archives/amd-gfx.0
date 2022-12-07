Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ADFC4708E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B81310E3D6;
	Wed,  7 Dec 2022 15:52:52 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8023510E3D4;
 Wed,  7 Dec 2022 15:52:47 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 v124-20020a1cac82000000b003cf7a4ea2caso1315114wme.5; 
 Wed, 07 Dec 2022 07:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mm5kDjrvZgZoiPsUSRtNB9fpskgq64eRPNEtqtayuvw=;
 b=hJ6JXaYzXBAWWWZOPqkWghZnZYNPV0pi8bfhloTsUDUU4oDIYqWZ5Hfu0FKQlUiAwn
 l7p2zWZ6igRAwYZKMj8pwbcG0GFAKy2xHy8Gj6e25n8wBKy4dzFl3z7LT5iu9CsVl/ZN
 bfKeTssUaKqkf0eR0TqmEqMeD/oDHTwCX/hNPKMgKmRU5DwvBWaHjWHPz3RfTWx/p8bh
 Ju75f/o3lxFK58L9lLqeVP/hU9IzBN1r8xDwmdE8QUdgpgLpeJiJHmg2ZjUS8nv6jAty
 6le5c/+C/4MbOWWKTLkGiTH0CWnsHcOPI3L7sbZYw31R3yETOf/uEdtKZVhb4Y3loHPT
 yvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mm5kDjrvZgZoiPsUSRtNB9fpskgq64eRPNEtqtayuvw=;
 b=iR632moJzZ4wgNC3hWp16Cifn+usci63gzlERV3e3MLUXVwrqeWeb+ejztgGKp6lE5
 CfAbOOo8d5ZHoSVNpbZTdb6hzZ8llDhM0FqTjK4iCToC7O0BTs8tVZkruS26Q0XPL8G5
 oGdmvH58/1F39F2mA9zYAciHfP9x3Fmx0GWNcDLLtnEXn8Bn/+A9gLb/bMgdv6w0ZspA
 7Xn2MvonQQyAPdrTBpNpqdkIwvLditLW8RfgRGtDhN+3jLQe94bXzHrKL/SPBSaE/DWK
 B3q6OACugEOVi+efujVG+Kjt3YmZQNeM+BG40AFBasTHRyVI/jXu7krlRK1fzvGNAmaI
 bD9A==
X-Gm-Message-State: ANoB5pmmqANpAv5ctleFOt7yRhP+Ai4c0IJCMjClMdG99Yt5ezKdqCdp
 EUXQWNMQGG3V5m27kNo9i+U=
X-Google-Smtp-Source: AA0mqf4WFc7BJ/excFt+3Ww+jEIHY6vSznCwuaJzo1Ba4eGO1jVtdEs9r12Dixcj+VHsdCovHI3jhQ==
X-Received: by 2002:a05:600c:5012:b0:3cf:486f:2700 with SMTP id
 n18-20020a05600c501200b003cf486f2700mr58936002wmr.83.1670428365979; 
 Wed, 07 Dec 2022 07:52:45 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:1690:3794:61d2:e9e1?
 ([2a02:908:1256:79a0:1690:3794:61d2:e9e1])
 by smtp.gmail.com with ESMTPSA id
 z18-20020a1c4c12000000b003d1e051f671sm2166277wmf.9.2022.12.07.07.52.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Dec 2022 07:52:45 -0800 (PST)
Message-ID: <ce75ecb5-1d07-d8a6-2722-59da84c22c10@gmail.com>
Date: Wed, 7 Dec 2022 16:52:44 +0100
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
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_PShNRZUwvnsTawW1OaCOjK73rdKTxxQhA=Znf2gqbJ=Q@mail.gmail.com>
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

Am 07.12.22 um 16:38 schrieb Alex Deucher:
> On Wed, Dec 7, 2022 at 10:23 AM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>> I would go a step further and just allow GTT domain on ASICs != CARRIZO
>> | STONEY.
>>
>> I can't see a good reason we should still have any limitation here, VRAM
>> doesn't have any advantage any more as far as I know.
> Well, if VRAM is available we want to make sure someone uses it
> otherwise it's just wasted.

Well it still gets used when it's free. So now problem at all here.

We should just not force anything into VRAM or GTT any more if it's 
technically not necessary.

Christian.

>
> Alex
>
>
>> Christian.
>>
>> Am 07.12.22 um 16:10 schrieb Alex Deucher:
>>> Does this patch fix the problem?
>>>
>>> Alex
>>>
>>> On Wed, Dec 7, 2022 at 2:27 AM Zhang, Jesse(Jie) <Jesse.Zhang@amd.com> wrote:
>>>> [AMD Official Use Only - General]
>>>>
>>>>
>>>>       drm/amdgpu: try allowed domain when pin framebuffer failed.
>>>>
>>>>
>>>>
>>>>       [WHY&HOW]
>>>>
>>>>
>>>>
>>>>       in some scenarios, the allocate memory often failed. such as do hot plug or play games.
>>>>
>>>>       so we can try allowed domain, if the preferred domain cannot allocate memory.
>>>>
>>>>
>>>>
>>>>       Signed-off-by: jie1zhan jesse.zhang@amd.com
>>>>
>>>>       Change-Id: I4b62e2ff072d02c515f901000a5789339d481273
>>>>
>>>>
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>
>>>> index 1ae0c8723348..05fcaf7f9d92 100644
>>>>
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>
>>>> @@ -39,6 +39,7 @@
>>>>
>>>> #include "amdgpu.h"
>>>>
>>>> #include "amdgpu_trace.h"
>>>>
>>>> #include "amdgpu_amdkfd.h"
>>>>
>>>> +#include "amdgpu_display.h"
>>>>
>>>>
>>>>
>>>> /**
>>>>
>>>>     * DOC: amdgpu_object
>>>>
>>>> @@ -942,8 +943,14 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>>>>
>>>>                           bo->placements[i].lpfn = lpfn;
>>>>
>>>>           }
>>>>
>>>>
>>>>
>>>> +       retry:
>>>>
>>>>           r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>>>
>>>>           if (unlikely(r)) {
>>>>
>>>> +               //try allowed domain when pin failed. just a workaround.
>>>>
>>>> +               if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
>>>>
>>>> +                       amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
>>>>
>>>> +                       goto retry;
>>>>
>>>> +               }
>>>>
>>>>                   dev_err(adev->dev, "%p pin failed\n", bo);
>>>>
>>>>                   goto error;
>>>>
>>>>           }

