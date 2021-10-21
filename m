Return-Path: <SRS0=oZ58=PJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC383C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 02:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C2D611CC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Oct 2021 02:24:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95C2D611CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5C26EA4F;
	Thu, 21 Oct 2021 02:24:43 +0000 (UTC)
X-Greylist: delayed 952 seconds by postgrey-1.36 at gabe;
 Thu, 21 Oct 2021 02:23:34 UTC
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
 by gabe.freedesktop.org (Postfix) with ESMTP id CF4A36EA4F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Oct 2021 02:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Message-ID:Date:MIME-Version:Subject:From; bh=5croE
 5CFj58p76AseTrfqIm0L8YSM0PBRqSAK6RwLQ0=; b=gH7YxwQ+Yfba0fyBwn/XE
 v2VkzeFonQ5KWOoVE4z4vXMlYzHKm2pHDJBOwJ/CAjsefNJa0eGgJ1bKCy+4FCdT
 dpyx8cYg3Pj4/iGPoP7USiohq9u9DgeXX26V4weeQRGazhUpjrryymw10YiJufH/
 ilMIG2o/NBaXArXtNz5Fzg=
Received: from [10.20.41.172] (unknown [114.242.206.180])
 by smtp1 (Coremail) with SMTP id GdxpCgA3xE9ny3BhLtNcHQ--.6007S2;
 Thu, 21 Oct 2021 10:07:35 +0800 (CST)
Message-ID: <4141c2c0-fa61-d5ad-7302-4718d68d33c7@163.com>
Date: Thu, 21 Oct 2021 10:07:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH 1/1] drm/amdgpu: fix BO leak after successful move test
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, Alexander.Deucher@amd.com
References: <20211012121018.81693-1-nirmoy.das@amd.com>
 <20211013150902.6646-1-nirmoy.das@amd.com>
 <7f990838-a3e3-333e-3237-09f4595ee452@gmail.com>
 <b246a463-0774-b4f4-8d28-86c71e791f49@gmail.com>
From: zhang <botton_zhang@163.com>
In-Reply-To: <b246a463-0774-b4f4-8d28-86c71e791f49@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgA3xE9ny3BhLtNcHQ--.6007S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr18AF47Cr1ruw17Gw1kAFb_yoW5Aw4rpr
 WFqFWY9F4UZF17J34293WjqFyrt3WaqFyfGrWUZ3W093s8Xr98J3Z8Jr15KF95ur4kur4I
 yrWUt3y7Wan0qrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jtxhLUUUUU=
X-Originating-IP: [114.242.206.180]
X-CM-SenderInfo: xerw30xqb2xtlqj6il2tof0z/xtbByRczmF1vmOg-6wAAsj
X-Mailman-Approved-At: Thu, 21 Oct 2021 02:24:42 +0000
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


On 2021/10/20 19:51, Christian König wrote:
> Am 20.10.21 um 13:50 schrieb Christian König:
>>
>>
>> Am 13.10.21 um 17:09 schrieb Nirmoy Das:
>>> GTT BO cleanup code is with in the test for loop and
>>> we would skip cleaning up GTT BO on success.
>>>
>>> Reported-by: zhang <botton_zhang@163.com>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 25 
>>> ++++++++++++------------
>>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>> index 909d830b513e..5fe7ff680c29 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
>>> @@ -35,6 +35,7 @@ static void amdgpu_do_test_moves(struct 
>>> amdgpu_device *adev)
>>>       struct amdgpu_bo *vram_obj = NULL;
>>>       struct amdgpu_bo **gtt_obj = NULL;
>>>       struct amdgpu_bo_param bp;
>>> +    struct dma_fence *fence = NULL;
>>>       uint64_t gart_addr, vram_addr;
>>>       unsigned n, size;
>>>       int i, r;
>>> @@ -82,7 +83,6 @@ static void amdgpu_do_test_moves(struct 
>>> amdgpu_device *adev)
>>>           void *gtt_map, *vram_map;
>>>           void **gart_start, **gart_end;
>>>           void **vram_start, **vram_end;
>>> -        struct dma_fence *fence = NULL;
>>>             bp.domain = AMDGPU_GEM_DOMAIN_GTT;
>>>           r = amdgpu_bo_create(adev, &bp, gtt_obj + i);
>>> @@ -212,24 +212,23 @@ static void amdgpu_do_test_moves(struct 
>>> amdgpu_device *adev)
>>>             DRM_INFO("Tested GTT->VRAM and VRAM->GTT copy for GTT 
>>> offset 0x%llx\n",
>>>                gart_addr - adev->gmc.gart_start);
>>> -        continue;
>>> +    }
>>>   +    --i;
>>>   out_lclean_unpin:
>>> -        amdgpu_bo_unpin(gtt_obj[i]);
>>> +    amdgpu_bo_unpin(gtt_obj[i]);
>>>   out_lclean_unres:
>>> -        amdgpu_bo_unreserve(gtt_obj[i]);
>>> +    amdgpu_bo_unreserve(gtt_obj[i]);
>>>   out_lclean_unref:
>>> -        amdgpu_bo_unref(&gtt_obj[i]);
>>> +    amdgpu_bo_unref(&gtt_obj[i]);
>>>   out_lclean:
>>> -        for (--i; i >= 0; --i) {
>>> -            amdgpu_bo_unpin(gtt_obj[i]);
>>> -            amdgpu_bo_unreserve(gtt_obj[i]);
>>> -            amdgpu_bo_unref(&gtt_obj[i]);
>>> -        }
>>> -        if (fence)
>>> -            dma_fence_put(fence);
>>> -        break;
>>> +    for (--i; i >= 0; --i) {
>>
>> The usual idiom for cleanups like that is "while (i--)..." because 
>> that also works with an unsigned i.
>>
>> Apart from that looks good to me.
>
> But I'm not sure that we would want to keep the in kernel tests around 
> anyway.
>
> We now have my amdgpu_stress tool to test memory bandwidth and mesa 
> has an option for that for a long time as well.
>
> Christian.
>
   I found a  testsuit about "bo eviction Test"  for amdgpu . in libdrm  
tests.

But I couldn't found  amdgpu_stress tool to test memory bandwid anywhere

>>
>> Christian.
>>
>>> +        amdgpu_bo_unpin(gtt_obj[i]);
>>> +        amdgpu_bo_unreserve(gtt_obj[i]);
>>> +        amdgpu_bo_unref(&gtt_obj[i]);
>>>       }
>>> +    if (fence)
>>> +        dma_fence_put(fence);
>>>         amdgpu_bo_unpin(vram_obj);
>>>   out_unres:
>>

