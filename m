Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12BDC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B18F610CB
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 11:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B18F610CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D907A6E973;
	Wed, 20 Oct 2021 11:51:31 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 688206E973
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 11:51:30 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 67-20020a1c1946000000b0030d4c90fa87so9564406wmz.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 04:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=xoVQPCwTktcJJxKSKvYvkOx9BJ8CGvHJ1Z/LHC1slC8=;
 b=GV5Cx0YhNn5hM/gt8TxTR+d7WgkzSuT+FoOmM7QrUvYUuTFWMs3Yzz0JbkvtM9yJeF
 4oIx6P8OHAeCUQbwlvMQ3zQ1VoNpG/HeVUh0OFBgeElOozTHubGO+JE51XFQr/gURArF
 O7tm1gn9Vc9AJG8I4zFconlVn/ME+Z0db5joAe9Ygqwe/03FYk47hdJ4T8WN2wv1+O3x
 +s7MzUcdKcVp+yH1eemd2wqODfef31EHV8l4G+fWJ1f2u7w3f3lOKoiVA4H9TL4QD8FN
 I7OsG9EpxtuFfj9IEkSxVCFUGAJethVVdxP0x5oBfCMZW6ADBPbSduUFlmgV9FpiopNt
 Omvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=xoVQPCwTktcJJxKSKvYvkOx9BJ8CGvHJ1Z/LHC1slC8=;
 b=Tx3H6QPNDKKDavJomwYe8FaTTMkSmGfuScXk63CLBm+kU6nUGhLH/UOnA3GFLkVEca
 8TeuDvb3kXx6hgMG8F9LAhVng0Nbom2HbRV/n39c+roXb+Km77XZ3bxQkos50nL1ln/i
 010S/OtwOzSNEyKnmzMdpGCd8o+1PofN9bVnPhi8d9thEjsjqnDcpFRmPYi498jmrunW
 E2ICw71vtheGxXw5UlSTd4QnQTxS0AIA5QK+Lz6+0yz3wlQ1wM0uJCiO/kIDW+vx4a6M
 O0j8wHH/XimFkXpFRvo+akQKmfukz4jYc1f/dJRPXb6u1h6oTTGUiyHaTJpt4J1vfj7/
 oK/Q==
X-Gm-Message-State: AOAM530I2OlqnthtV+LzYft8FkFuX2zXBEwhJdgFhnBR4ZCtNXcEX8sP
 kSWv7oBPx7kRsGeh/jG7srM=
X-Google-Smtp-Source: ABdhPJx90cSKaL9fgazHj9++/PVNNeZiMzgMTwDlQaYJvSGO0s1+fT+Ppxkasf+zrkG6Yxaqh5nUug==
X-Received: by 2002:a05:6000:145:: with SMTP id
 r5mr9004812wrx.64.1634730688766; 
 Wed, 20 Oct 2021 04:51:28 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6048:8836:7968:5df6?
 ([2a02:908:1252:fb60:6048:8836:7968:5df6])
 by smtp.gmail.com with ESMTPSA id f3sm1738589wml.11.2021.10.20.04.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Oct 2021 04:51:28 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: fix BO leak after successful move test
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Alexander.Deucher@amd.com,
 zhang <botton_zhang@163.com>
References: <20211012121018.81693-1-nirmoy.das@amd.com>
 <20211013150902.6646-1-nirmoy.das@amd.com>
 <7f990838-a3e3-333e-3237-09f4595ee452@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <b246a463-0774-b4f4-8d28-86c71e791f49@gmail.com>
Date: Wed, 20 Oct 2021 13:51:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7f990838-a3e3-333e-3237-09f4595ee452@gmail.com>
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

Am 20.10.21 um 13:50 schrieb Christian König:
>
>
> Am 13.10.21 um 17:09 schrieb Nirmoy Das:
>> GTT BO cleanup code is with in the test for loop and
>> we would skip cleaning up GTT BO on success.
>>
>> Reported-by: zhang <botton_zhang@163.com>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 25 ++++++++++++------------
>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>> index 909d830b513e..5fe7ff680c29 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>> @@ -35,6 +35,7 @@ static void amdgpu_do_test_moves(struct 
>> amdgpu_device *adev)
>>       struct amdgpu_bo *vram_obj = NULL;
>>       struct amdgpu_bo **gtt_obj = NULL;
>>       struct amdgpu_bo_param bp;
>> +    struct dma_fence *fence = NULL;
>>       uint64_t gart_addr, vram_addr;
>>       unsigned n, size;
>>       int i, r;
>> @@ -82,7 +83,6 @@ static void amdgpu_do_test_moves(struct 
>> amdgpu_device *adev)
>>           void *gtt_map, *vram_map;
>>           void **gart_start, **gart_end;
>>           void **vram_start, **vram_end;
>> -        struct dma_fence *fence = NULL;
>>             bp.domain = AMDGPU_GEM_DOMAIN_GTT;
>>           r = amdgpu_bo_create(adev, &bp, gtt_obj + i);
>> @@ -212,24 +212,23 @@ static void amdgpu_do_test_moves(struct 
>> amdgpu_device *adev)
>>             DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT 
>> offset 0x%llx\n",
>>                gart_addr - adev->gmc.gart_start);
>> -        continue;
>> +    }
>>   +    --i;
>>   out_lclean_unpin:
>> -        amdgpu_bo_unpin(gtt_obj[i]);
>> +    amdgpu_bo_unpin(gtt_obj[i]);
>>   out_lclean_unres:
>> -        amdgpu_bo_unreserve(gtt_obj[i]);
>> +    amdgpu_bo_unreserve(gtt_obj[i]);
>>   out_lclean_unref:
>> -        amdgpu_bo_unref(&gtt_obj[i]);
>> +    amdgpu_bo_unref(&gtt_obj[i]);
>>   out_lclean:
>> -        for (--i; i >= 0; --i) {
>> -            amdgpu_bo_unpin(gtt_obj[i]);
>> -            amdgpu_bo_unreserve(gtt_obj[i]);
>> -            amdgpu_bo_unref(&gtt_obj[i]);
>> -        }
>> -        if (fence)
>> -            dma_fence_put(fence);
>> -        break;
>> +    for (--i; i >= 0; --i) {
>
> The usual idiom for cleanups like that is "while (i--)..." because 
> that also works with an unsigned i.
>
> Apart from that looks good to me.

But I'm not sure that we would want to keep the in kernel tests around 
anyway.

We now have my amdgpu_stress tool to test memory bandwidth and mesa has 
an option for that for a long time as well.

Christian.

>
> Christian.
>
>> +        amdgpu_bo_unpin(gtt_obj[i]);
>> +        amdgpu_bo_unreserve(gtt_obj[i]);
>> +        amdgpu_bo_unref(&gtt_obj[i]);
>>       }
>> +    if (fence)
>> +        dma_fence_put(fence);
>>         amdgpu_bo_unpin(vram_obj);
>>   out_unres:
>

