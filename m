Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22919C54EE9
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Sep 2022 17:54:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 728B810E108;
	Thu, 22 Sep 2022 17:54:19 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC55D10E108
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 17:54:14 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id m3so14644202eda.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Sep 2022 10:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date;
 bh=jkuIF0IZtMg9OQPUG25dC0/E+Cb7QeCCozqIJgMy2mc=;
 b=gE+f33mvCUzW1oduOUHuA62J6pRxedUp+3WLPeKNYhrYEGdjIUlHIA5Ena8vzZcifN
 HO29OSsC4r1xiFsPvPh/pyMdNwz73a3pRQX32fGOgWguesM7BUHf0r6WDRZAtFRJZlN2
 RAciXTbOwZdFhHfzwwHkFABX5qSq2bS0DsG8ONlpYd50gLg1jBckzVhs60AReO1dSV4w
 ul5ic7SX0Jh7KvjxAVjNr/6MA4sWB+MfMpKdgEVsHi9qrVJZn9qsqobupQNKIxGUW3iL
 9vyhU0RYGyefiwd0dWPPY7iYspixUGn8upcT/c6rX9YozOAr4PIqJNqhDmCSLU+3pcvR
 vIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=jkuIF0IZtMg9OQPUG25dC0/E+Cb7QeCCozqIJgMy2mc=;
 b=YFV77XckFrXe8VqSljAt3t6bxNZqrYiKT4G/F+qfLBNeHAFEEv/Mlea3WwZ1X0+nPd
 6iWl3Ffnv2eF6LRdOj8fDfiSL3/YalwmRLtxXnjoEhCl/WBH+JuGAmzcm3JclHj6Cns1
 CIntwNJ+E4Ju1vhFH3EqxN+Suk+dv3TYq2cFsxAviWQfp1OgPcFcl36A3qdMyH1n1uf8
 VfTtEoexLhsSM9Uxiw515xzx/Y2WlIDC2lwWJ6swRvo7HxFjbpU8mvPq8njcZCTvOPnK
 1CzKzqz1/ks3J5j1AoRTmoQYPD5gWeRURxPIntwtQTWbjqUESB39Mi59WPELfkX99jqa
 PO4w==
X-Gm-Message-State: ACrzQf0GJxXp9ySjOZ6FiAMErIGtUUiV+IX/oUHBd+xtRm6nmeuel+XY
 9IY0N2DjEXpyQeeU2BR9GE6+YCldiq4=
X-Google-Smtp-Source: AMsMyM6lmQ9/A2CEngWMMuyZ3BbPyRGAPAzSlhUgSZA/WDcagyJD3UQUE1B9VG44eU+aYGBldUOwZQ==
X-Received: by 2002:a05:6402:1761:b0:455:37bb:93c3 with SMTP id
 da1-20020a056402176100b0045537bb93c3mr2193062edb.403.1663869253165; 
 Thu, 22 Sep 2022 10:54:13 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:20f9:f579:415b:9790?
 ([2a02:908:1256:79a0:20f9:f579:415b:9790])
 by smtp.gmail.com with ESMTPSA id
 c26-20020a056402101a00b0044e6802623dsm1173524edu.18.2022.09.22.10.54.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Sep 2022 10:54:12 -0700 (PDT)
Message-ID: <e0b7d387-682d-e6a6-eb64-96ca15eba642@gmail.com>
Date: Thu, 22 Sep 2022 19:54:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix VRAM eviction issue
Content-Language: en-US
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220922151447.265696-1-Arunpravin.PaneerSelvam@amd.com>
 <dd3ac270-a338-888d-4bd3-1716504b7a8f@amd.com>
 <3be971e6-7f2c-e6ad-3a07-77fa92b56f47@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <3be971e6-7f2c-e6ad-3a07-77fa92b56f47@amd.com>
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
Cc: alexander.deucher@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



Am 22.09.22 um 17:42 schrieb Arunpravin Paneer Selvam:
>
>
> On 9/22/2022 9:01 PM, Christian König wrote:
>> Am 22.09.22 um 17:14 schrieb Arunpravin Paneer Selvam:
>>> A user reported that when he starts a game (MTGA) with wine,
>>> he observed an error msg failed to pin framebuffer with error -12.
>>> Found an issue with the VRAM mem type eviction decision condition
>>> logic. This patch will fix the if condition code error.
>>>
>>> Gitlab bug link:
>>> https://gitlab.freedesktop.org/drm/amd/-/issues/2159
>>>
>>> Fixes: ded910f368a5 ("drm/amdgpu: Implement intersect/compatible 
>>> functions")
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>
>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>
>> Can you push it yourself now?
> No, I didn't get the commit rights yet.

Pushed to drm-misc-next. Please make sure the bug is closed.

Thanks,
Christian.

>
> Thanks,
> Arun
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> index d1a2619fa89f..73a517bcf5c1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> @@ -746,7 +746,7 @@ static bool amdgpu_vram_mgr_intersects(struct 
>>> ttm_resource_manager *man,
>>>               (amdgpu_vram_mgr_block_size(block) >> PAGE_SHIFT);
>>>             if (place->fpfn < lpfn &&
>>> -            (place->lpfn && place->lpfn > fpfn))
>>> +            (!place->lpfn || place->lpfn > fpfn))
>>>               return true;
>>>       }
>>
>

