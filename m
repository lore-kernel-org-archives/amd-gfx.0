Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480F7D167FA
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 10:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E08B010E885;
	Fri,  9 Jan 2026 10:23:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="hr3NeLi5";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="9kzXAcg/";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF09110E885
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 10:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1767954179;
 bh=s/Ri0C3dN6lio825MlhDKKU
 iIniaQSE1+2kWSoC1E0U=; b=hr3NeLi5tczyaiMX+mvvWC9sIs+T6wuR5TzyhtfgJ7ydHkZrj8
 zVJ2MDb5uGK/KnO+1UxODAyAJuwlqQ85MIEcsJp9rKttD2zZ90arsPSQzne/RuX6x5WxckMQgla
 aGBZBMxyBpEOO7GJGCdCFGKUIp+kDtfUmlaheVB41URkTqQ8z6AEh/dqezk6G4UK0WBM2sWpvqt
 vN7scqkpaaUamqkO07Jz1QZ2dCaKDW97/UfFSGvKA9Q6uCoAX83g5DGZONu72mBUK3I+deQgua8
 CPRsUsJBx4rFfFCbZhsDuQRUO0av92tHDkXE09BBRZEi28dMl+BoYwPfWugrnQjawxw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1767954179; bh=s/Ri0C3dN6lio825MlhDKKU
 iIniaQSE1+2kWSoC1E0U=; b=9kzXAcg/lc1f8bDrdAb8jWqEOyQB4ZT2dzFJNMeTZFSTa9KYM5
 BjriDiZKXbujLyxEHW6bVB+uS9bDBY+3A9Dw==;
Message-ID: <670e1581-cb76-48be-a580-efd664c12b3a@damsy.net>
Date: Fri, 9 Jan 2026 11:22:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/8] amdgpu/amdgpu_ttm: Fix
 AMDGPU_GTT_MAX_TRANSFER_SIZE for non-4K page size
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Philip Yang <yangp@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
Cc: Kent.Russell@amd.com, Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>,
 Mukesh Kumar Chaurasiya <mkchauras@linux.ibm.com>
References: <cover.1765519875.git.donettom@linux.ibm.com>
 <465b106ddc1ff0d661f0f3db0eb9a9d092097825.1765519875.git.donettom@linux.ibm.com>
 <277c65ad-a3c3-4d99-a0f4-a6ca99e61ab4@amd.com>
 <c28b117f-b3bb-42de-a1fb-a4dceccfbb72@linux.ibm.com>
 <430ac9a5-8665-4f0a-a658-5266668bc846@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <430ac9a5-8665-4f0a-a658-5266668bc846@amd.com>
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


Hi,

Le 08/01/2026 à 13:31, Christian König a écrit :
> On 1/6/26 13:55, Donet Tom wrote:
>>
>> On 12/12/25 2:23 PM, Christian König wrote:
>>> On 12/12/25 07:40, Donet Tom wrote:
>>>> The SDMA engine has a hardware limitation of 4 MB maximum transfer
>>>> size per operation.
>>> That is not correct. This is only true on ancient HW.
>>>
>>> What problems are you seeing here?
>>>
>>>> AMDGPU_GTT_MAX_TRANSFER_SIZE was hardcoded to
>>>> 512 pages, which worked correctly on systems with 4K pages but fails
>>>> on systems with larger page sizes.
>>>>
>>>> This patch divides the max transfer size / AMDGPU_GPU_PAGES_IN_CPU_PAGE
>>>> to match with non-4K page size systems.
>>> That is actually a bad idea. The value was meant to match the PMD size.
>>
>>
>> Hi Christian, Felix, Alex and philip
>>
>> Instead of hardcoding the AMDGPU_GTT_MAX_TRANSFER_SIZE value to 512,
>> what do you think about doing something like the change below?
>> This should work across all architectures and page sizes, so
>> AMDGPU_GTT_MAX_TRANSFER_SIZE will always correspond to the PMD
>> size on all architectures and with all page sizes.
>>
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> index 0be2728aa872..c594ed7dff18 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>> @@ -37,7 +37,7 @@
>>   #define AMDGPU_PL_MMIO_REMAP   (TTM_PL_PRIV + 5)
>>   #define __AMDGPU_PL_NUM        (TTM_PL_PRIV + 6)
>>   
>> -#define AMDGPU_GTT_MAX_TRANSFER_SIZE   512
>> +#define AMDGPU_GTT_MAX_TRANSFER_SIZE   1 << (PMD_SHIFT - PAGE_SHIFT)
>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS
>>
>> Could you please provide your thoughts on above? Is it looking ok to you?
> 
> It's at least reasonable. My only concern is that we have patches in the pipeline to remove that define and make it independent of the PMD size.
> 
> @Pierre-Eric how far along are we with that?


My patchset is dropping AMDGPU_GTT_NUM_TRANSFER_WINDOWS and doubling 
AMDGPU_GTT_MAX_TRANSFER_SIZE so it's not negatively affected by Tom's 
patches.

Regards,
Pierre-Eric



> 
>>
>> If this looks good - here is what we were thinking:
>>
>> Patches 1-4 are required to fix initial non-4k pagesize support to AMD GPU.
>> And since these patches are looking in good shape (since Philip has already
>> reviewed [1-3])- We thought it will be good to split the patch series into two.
>> I will send a v2 of Part-1 with patches [1-4] (will also address the review comments
>> in v2 for Patch-1 & 2 from Philip) and for the rest of the patches [5-8] Part-2, we
>> can continue the discussion till other things are sorted. That will also allow us to
>> get these initial fixes in Part-1 ready before the 6.20 merge window.
>>
>> Thoughts?
> 
> Sounds reasonable to me.
> 
> Regards,
> Christian.
> 
>>
>>
>>> Regards,
>>> Christian.
>>>
>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> index 0be2728aa872..9d038feb25b0 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
>>>> @@ -37,7 +37,7 @@
>>>>   #define AMDGPU_PL_MMIO_REMAP	(TTM_PL_PRIV + 5)
>>>>   #define __AMDGPU_PL_NUM	(TTM_PL_PRIV + 6)
>>>>   
>>>> -#define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>>>> +#define AMDGPU_GTT_MAX_TRANSFER_SIZE	(512 / AMDGPU_GPU_PAGES_IN_CPU_PAGE)
>>>>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
>>>>   
>>>>   extern const struct attribute_group amdgpu_vram_mgr_attr_group;
