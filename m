Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90B8C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 11:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF5610E72C;
	Fri, 25 Nov 2022 11:14:49 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E50DD10E72C;
 Fri, 25 Nov 2022 11:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669374887; x=1700910887;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=6vQDUUCmN97OeyrTkEtUVUUPMl1l0TNrYP591bjYOJs=;
 b=HEC2rmH0nXZJEiKB69E/ywYwPQ4mjCRd5NygK7PRne6bCn3f7GHCv8cD
 4kdDj4i0wKtxlc987IG/jK8hm8t9IPXyl3n1cG/7oWkrktKBxRorbE1Ij
 Xgw0NTEvWR0XF9t5p2qQbZ+znwi2vgZxv7FdvQWTnRw+JEeejqZWeQsQg
 RxxzkWqqYTGHYRI1Gs9hb+TcR5ByZhRTn/sGkCuyNy6NMl3iAMKaWVvAH
 FV9Zm5mhFnpgIr71qzF3GMoyvefSwjeH6wswgIzZ5FovIeKzOzRTbalbX
 TNHn5l6RfHvaqwRjfHNgAQkZ6Kl5NINHf6Y3a2Sohlwm0h0VDz6SJuVeH g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="376607627"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="376607627"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 03:14:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10541"; a="620310984"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="620310984"
Received: from jbrophy1-mobl1.amr.corp.intel.com (HELO [10.213.194.13])
 ([10.213.194.13])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 03:14:44 -0800
Message-ID: <d92312af-3c84-8bd9-108b-719fb1ec3a6b@linux.intel.com>
Date: Fri, 25 Nov 2022 11:14:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [Intel-gfx] [PATCH 7/9] drm/i915: stop using ttm_bo_wait
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Matthew Auld <matthew.auld@intel.com>
References: <20221125102137.1801-1-christian.koenig@amd.com>
 <20221125102137.1801-7-christian.koenig@amd.com>
From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
In-Reply-To: <20221125102137.1801-7-christian.koenig@amd.com>
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


+ Matt

On 25/11/2022 10:21, Christian König wrote:
> TTM is just wrapping core DMA functionality here, remove the mid-layer.
> No functional change.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_ttm.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> index 5247d88b3c13..d409a77449a3 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
> @@ -599,13 +599,16 @@ i915_ttm_resource_get_st(struct drm_i915_gem_object *obj,
>   static int i915_ttm_truncate(struct drm_i915_gem_object *obj)
>   {
>   	struct ttm_buffer_object *bo = i915_gem_to_ttm(obj);
> -	int err;
> +	long err;
>   
>   	WARN_ON_ONCE(obj->mm.madv == I915_MADV_WILLNEED);
>   
> -	err = ttm_bo_wait(bo, true, false);
> -	if (err)
> +	err = dma_resv_wait_timeout(bo->base.resv, DMA_RESV_USAGE_BOOKKEEP,
> +				    true, 15 * HZ);

This 15 second stuck out a bit for me and then on a slightly deeper look 
it seems this timeout will "leak" into a few of i915 code paths. If we 
look at the difference between the legacy shmem and ttm backend I am not 
sure if the legacy one is blocking or not - but if it can block I don't 
think it would have an arbitrary timeout like this. Matt your thoughts?

Regards,

Tvrtko

> +	if (err < 0)
>   		return err;
> +	if (err == 0)
> +		return -EBUSY;
>   
>   	err = i915_ttm_move_notify(bo);
>   	if (err)
