Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F17C54E58
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Mar 2024 12:25:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF4B310E87C;
	Thu, 21 Mar 2024 12:25:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="Alt4SXNe";
	dkim-atps=neutral
Received: from mail.damsy.net (mail.damsy.net [85.90.245.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6823E10E879
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Mar 2024 12:25:39 +0000 (UTC)
Message-ID: <450d7715-f990-4018-b72c-be86dac23f4e@damsy.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=damsy.net; s=201803;
 t=1711023936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2LGVJLUUsju8ZVOMYwCXeMeMkCZlBBILHthCRKBGzIg=;
 b=Alt4SXNerahIMLWgLhkuZr0NSJYPwr8LQq+pVkdfQ2+mrv5X9WuJPHvhCAX9G6ecDQaTDf
 Frg+E+dIA/I41dqpWXKkM/PrDtmOjQb6g1PoTMgRUx2dSHhtdUyblSA0usLnesZcTw8p45
 EURel9sjlPFmUpFFYnt/RnzIoN1x5eNZv1CVPL0hUo3Wi88arlv5bjufhF0VKaZC+AOvnu
 mMVXbeih70usDlBnDnaQxSmbMY/bcdji4BR3SbLbv96rRnj2Iq/CnH+oG5vuMdqzEsZc9U
 IxOZ/sDOrZWqRmPLcP15px7VSg4DaqunhBntYqH7Q65NTr2ElY0g7Ut9HbL+2g==
Date: Thu, 21 Mar 2024 13:25:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] drm/amdgpu: remove invalid resource->start check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 pierre-eric.pelloux-prayer@amd.com, xenia.ragiadakou@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: amaranath.somalapuram@amd.com
References: <20240320124946.2816-1-christian.koenig@amd.com>
Content-Language: fr
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20240320124946.2816-1-christian.koenig@amd.com>
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


Le 20/03/2024 à 13:49, Christian König a écrit :
> The majority of those where removed in the patch aed01a68047b
> drm/amdgpu: Remove TTM resource->start visible VRAM condition v2
> 
> But this one was missed because it's working on the resource and not the
> BO. Since we also no longer use a fake start address for visible BOs
> this will now trigger invalid mapping errors.
> 
> Fixes: aed01a68047b ("drm/amdgpu: Remove TTM resource->start visible VRAM condition v2")
> Signed-off-by: Christian König <christian.koenig@amd.com>
> CC: stable@vger.kernel.org


Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Thanks!

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b0ed10f4de60..6bd7e71c5ff6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -573,9 +573,6 @@ static int amdgpu_ttm_io_mem_reserve(struct ttm_device *bdev,
>   		break;
>   	case TTM_PL_VRAM:
>   		mem->bus.offset = mem->start << PAGE_SHIFT;
> -		/* check if it's visible */
> -		if ((mem->bus.offset + bus_size) > adev->gmc.visible_vram_size)
> -			return -EINVAL;
>   
>   		if (adev->mman.aper_base_kaddr &&
>   		    mem->placement & TTM_PL_FLAG_CONTIGUOUS)
