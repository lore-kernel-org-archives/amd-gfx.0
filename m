Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FFFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 06:58:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7558560FC1
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 06:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7558560FC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 142D36EB71;
	Thu, 21 Oct 2021 06:58:54 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E5B96EB71
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 06:58:53 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id e12so888268wra.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 23:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=7XduekcdClmtkiikJL4HX8zoTWCf1aBu2TH0oYRVHb8=;
 b=CAQSWS4Bc6j2YM+phtklLUVdVTFjYBmQp0zKqdO6R0iXmaZWVc0NjnV/MmhgtJ0/j0
 XkNXdGN+cE++tnu2aGs69iC/8IppN4ZAYFXUa9r0lnPeQLQW+qimKDdFkOONWa4DMhaI
 FHb1HSQoeYKsSGCeKVdko1Z37ReA/w1GBxAntBiIOqB4A16cZ1FEO3WiO1Vr2Md+YXhc
 yTRB1icDYjjHAKYJamyBnlCRjYIbRpLkwdCPgB2q/SgIGVDeAAac34W16ZoIcLwv6Vn8
 kJRfGTFVrr4SMFGg0aXXWl07oxkqhcQLQLz5+kyiF9fBas/bwKzkGDzL+1kJ0lc6aD9Z
 iOug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=7XduekcdClmtkiikJL4HX8zoTWCf1aBu2TH0oYRVHb8=;
 b=2umBI69/aEsRo1n4deaLiPD7ZlIDicUZIpKt5T5Awep/ROyLB0v7y+6cAf5F9Ngpuo
 w4QpvbxZdQiNzWbkQVgvDh0l9KHcU6pRV9tzGHuSxbi53fMA25qJHKxMM0XUDZ3krNXo
 51W+wmQdESj8m6QDKVku8ae3+Fx/Y4IORmWBqsoS/r5cNOcZiKgZP5Cso0SUJxSMFfNJ
 oUQ+yAY4fLneqYa8o948Xaq14dZ6fkk0g0tRS/Nan9Pdc8GqtnAR0pXieydsipnl7gmp
 doJ21zAyz1SbBjo+RIVSrJ65p302ToYKr6WPKAiD6wRmeJX6DvJS+KuCO0OSNoFuuYR8
 c93A==
X-Gm-Message-State: AOAM531x377UAdOgVGT5cN+kdFHk6T9BO0uFk5yAJVhxT1gypl9pdUXV
 aQyB4DXTEp+iJpgnjfb4WCrZ/xwQCGU=
X-Google-Smtp-Source: ABdhPJyrBncH3+GGpp6zU5/ncpoWJN5sjoIokz7m0BuPzLW2EZpLbVbz7u0+xe7aYICVJaWaKIpbQQ==
X-Received: by 2002:adf:d1e3:: with SMTP id g3mr5188536wrd.63.1634799532034;
 Wed, 20 Oct 2021 23:58:52 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:46a4:dec3:9292:691a?
 ([2a02:908:1252:fb60:46a4:dec3:9292:691a])
 by smtp.gmail.com with ESMTPSA id a127sm7048755wme.40.2021.10.20.23.58.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Oct 2021 23:58:51 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: fix BO leak after successful move test
To: "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Alexander.Deucher@amd.com,
 zhang <botton_zhang@163.com>
References: <20211012121018.81693-1-nirmoy.das@amd.com>
 <20211013150902.6646-1-nirmoy.das@amd.com>
 <7f990838-a3e3-333e-3237-09f4595ee452@gmail.com>
 <b246a463-0774-b4f4-8d28-86c71e791f49@gmail.com>
 <df7e2391-8169-7d2e-ebb5-87a97a999430@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2445310c-fdaf-d0c1-cc80-e9437a254be0@gmail.com>
Date: Thu, 21 Oct 2021 08:58:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <df7e2391-8169-7d2e-ebb5-87a97a999430@amd.com>
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



Am 20.10.21 um 14:55 schrieb Das, Nirmoy:
>
> On 10/20/2021 1:51 PM, Christian König wrote:
>> Am 20.10.21 um 13:50 schrieb Christian König:
>>>
>>>
>>> Am 13.10.21 um 17:09 schrieb Nirmoy Das:
>>>> GTT BO cleanup code is with in the test for loop and
>>>> we would skip cleaning up GTT BO on success.
>>>>
>>>> Reported-by: zhang <botton_zhang@163.com>
>>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 25 
>>>> ++++++++++++------------
>>>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>>> index 909d830b513e..5fe7ff680c29 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>>> @@ -35,6 +35,7 @@ static void amdgpu_do_test_moves(struct 
>>>> amdgpu_device *adev)
>>>>       struct amdgpu_bo *vram_obj = NULL;
>>>>       struct amdgpu_bo **gtt_obj = NULL;
>>>>       struct amdgpu_bo_param bp;
>>>> +    struct dma_fence *fence = NULL;
>>>>       uint64_t gart_addr, vram_addr;
>>>>       unsigned n, size;
>>>>       int i, r;
>>>> @@ -82,7 +83,6 @@ static void amdgpu_do_test_moves(struct 
>>>> amdgpu_device *adev)
>>>>           void *gtt_map, *vram_map;
>>>>           void **gart_start, **gart_end;
>>>>           void **vram_start, **vram_end;
>>>> -        struct dma_fence *fence = NULL;
>>>>             bp.domain = AMDGPU_GEM_DOMAIN_GTT;
>>>>           r = amdgpu_bo_create(adev, &bp, gtt_obj + i);
>>>> @@ -212,24 +212,23 @@ static void amdgpu_do_test_moves(struct 
>>>> amdgpu_device *adev)
>>>>             DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT 
>>>> offset 0x%llx\n",
>>>>                gart_addr - adev->gmc.gart_start);
>>>> -        continue;
>>>> +    }
>>>>   +    --i;
>>>>   out_lclean_unpin:
>>>> -        amdgpu_bo_unpin(gtt_obj[i]);
>>>> +    amdgpu_bo_unpin(gtt_obj[i]);
>>>>   out_lclean_unres:
>>>> -        amdgpu_bo_unreserve(gtt_obj[i]);
>>>> +    amdgpu_bo_unreserve(gtt_obj[i]);
>>>>   out_lclean_unref:
>>>> -        amdgpu_bo_unref(&gtt_obj[i]);
>>>> +    amdgpu_bo_unref(&gtt_obj[i]);
>>>>   out_lclean:
>>>> -        for (--i; i >= 0; --i) {
>>>> -            amdgpu_bo_unpin(gtt_obj[i]);
>>>> -            amdgpu_bo_unreserve(gtt_obj[i]);
>>>> -            amdgpu_bo_unref(&gtt_obj[i]);
>>>> -        }
>>>> -        if (fence)
>>>> -            dma_fence_put(fence);
>>>> -        break;
>>>> +    for (--i; i >= 0; --i) {
>>>
>>> The usual idiom for cleanups like that is "while (i--)..." because 
>>> that also works with an unsigned i.
>>>
>>> Apart from that looks good to me.
>>
>> But I'm not sure that we would want to keep the in kernel tests 
>> around anyway.
>>
>> We now have my amdgpu_stress tool to test memory bandwidth and mesa 
>> has an option for that for a long time as well.
>
>
> Shall I then remove amdgpu_test.c ?

Please double check if the amdgpu_stress utility gives you the same 
functionality, if yes we should probably remove this test here.

Thanks,
Christian.

>
>
> Nirmoy
>
>
>>
>> Christian.
>>
>>>
>>> Christian.
>>>
>>>> +        amdgpu_bo_unpin(gtt_obj[i]);
>>>> +        amdgpu_bo_unreserve(gtt_obj[i]);
>>>> +        amdgpu_bo_unref(&gtt_obj[i]);
>>>>       }
>>>> +    if (fence)
>>>> +        dma_fence_put(fence);
>>>>         amdgpu_bo_unpin(vram_obj);
>>>>   out_unres:
>>>
>>

