Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE014C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 09:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FC9010F026;
	Wed, 27 Mar 2024 09:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="Gi+ndK5d";
	dkim-atps=neutral
Received: from mail.damsy.net (mail.damsy.net [85.90.245.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 038EE10F026
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 09:59:38 +0000 (UTC)
Message-ID: <6a3fab58-a6c1-4b9b-b7cb-78f1cf9684ac@damsy.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=damsy.net; s=201803;
 t=1711533577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xL/vHcGcdAbaaYwaDTD78iqpybCZrj6iXi8lSl6bUl0=;
 b=Gi+ndK5dQNDhRfUNXU2pPcaQCbdHPHbRvSYZb5nd0fiZIBwyoiBLYAgP3wGGzYcQjUlOiB
 aEc6YpwbxBeySDhZvFHZQQgx/LM8Q8/MpIfdXEv+tClGaGztk9K5AmlnjorHMyB2NeRrbt
 Or92uaVqLUToB6T+GgUM/R1Xh1t6WlASsSmHoDmW1iLBfDSsFeEZXcN7efdPTg9OQoVV9x
 4E9SUtt0F0GA5oCQ0crYj82f4qO30bbghpAE66j6wM42EwpvMsXsJUEZtZF31mGoD3kTw+
 beiwCbw2Ta2IcEfY0T8/EWBK2n5D8lme6i037TyiHbS8xxdlOSo7kOk7tPOPQQ==
Date: Wed, 27 Mar 2024 10:59:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: remove invalid resource->start check
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 pierre-eric.pelloux-prayer@amd.com, xenia.ragiadakou@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: amaranath.somalapuram@amd.com
References: <20240320124946.2816-1-christian.koenig@amd.com>
 <450d7715-f990-4018-b72c-be86dac23f4e@damsy.net>
Content-Language: fr
In-Reply-To: <450d7715-f990-4018-b72c-be86dac23f4e@damsy.net>
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

On my kernel branch this produces an "unused variable" warning for 'bus_size' so it
should be dropped as well.

Pierre-Eric

Le 21/03/2024 à 13:25, Pierre-Eric Pelloux-Prayer a écrit :
> 
> Le 20/03/2024 à 13:49, Christian König a écrit :
>> The majority of those where removed in the patch aed01a68047b
>> drm/amdgpu: Remove TTM resource->start visible VRAM condition v2
>>
>> But this one was missed because it's working on the resource and not the
>> BO. Since we also no longer use a fake start address for visible BOs
>> this will now trigger invalid mapping errors.
>>
>> Fixes: aed01a68047b ("drm/amdgpu: Remove TTM resource->start visible VRAM condition v2")
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> CC: stable@vger.kernel.org
> 
> 
> Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> 
> Thanks!
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index b0ed10f4de60..6bd7e71c5ff6 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -573,9 +573,6 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>>           break;
>>       case TTM_PL_VRAM:
>>           mem->bus.offset = mem->start << PAGE_SHIFT;
>> -        /* check if it's visible */
>> -        if ((mem->bus.offset + bus_size) > adev->gmc.visible_vram_size)
>> -            return -EINVAL;
>>           if (adev->mman.aper_base_kaddr &&
>>               mem->placement & TTM_PL_FLAG_CONTIGUOUS)
