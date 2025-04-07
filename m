Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD37EC369A2
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 14:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A28910E4C7;
	Mon,  7 Apr 2025 14:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XmX08E6Z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C41C010E1C4;
 Mon,  7 Apr 2025 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744037075; x=1775573075;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=UCUUSUeiLfWWGb6fL1dKPqrQ3/1RuxraDiZxVeaRnkU=;
 b=XmX08E6ZFzCND1tY71OWqUF+mQSC9hkUk1kL4z8wB1/6fRqJ4LsCUFpY
 mq3qOO1AOD4Bllft9vC24rEbL8dZTQJpxNu3AWn/RHCLHSphGesPP75lW
 4rOUu7J7KatN8UyDi8waJ1HtzIL22d1iE5WbJ1Xmm1qtzq7nVLLtbFjhs
 LZzqSpHgUpglZIkXlVGEvyS1wEkrlYJMUTCdnE4YO8poVDZBCCMPEvhRO
 CPtpTIzoutsISAK62H4LAwvmpnDpXlt8rWzoKZDqpXgwgM/GC2LYKNlAr
 3WvLL7L3lpeDpc0w0Xer29g3JY4Z89nmwdvxb0v1mqktcHSTh0HsidOYd Q==;
X-CSE-ConnectionGUID: ecczQNzTQU2WMsEcwDwI3A==
X-CSE-MsgGUID: zjCn5c0/TpOE1FD1Hu9ChQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="70803207"
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="70803207"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 07:44:35 -0700
X-CSE-ConnectionGUID: OZ3q3j4CT8qsCAzxIK7Iyw==
X-CSE-MsgGUID: I8EUySWQSXuJxR9Cm3QPPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,194,1739865600"; d="scan'208";a="132116316"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO [10.245.245.196])
 ([10.245.245.196])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 07:44:33 -0700
Message-ID: <8ae9b377-5a2d-435f-8e29-ed393b984870@intel.com>
Date: Mon, 7 Apr 2025 15:44:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/dma_buf: fix page_link check
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 intel-xe@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, stable@vger.kernel.org
References: <20250407141823.44504-3-matthew.auld@intel.com>
 <20250407141823.44504-4-matthew.auld@intel.com>
 <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <a4b1190d-4d4f-4c66-9fb7-2be19d2ea3dc@gmail.com>
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

On 07/04/2025 15:32, Christian König wrote:
> Am 07.04.25 um 16:18 schrieb Matthew Auld:
>> The page_link lower bits of the first sg could contain something like
>> SG_END, if we are mapping a single VRAM page or contiguous blob which
>> fits into one sg entry. Rather pull out the struct page, and use that in
>> our check to know if we mapped struct pages vs VRAM.
>>
>> Fixes: f44ffd677fb3 ("drm/amdgpu: add support for exporting VRAM using DMA-buf v3")
>> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org
>> Cc: <stable@vger.kernel.org> # v5.8+
> 
> Good point, haven't thought about that at all since we only abuse the sg table as DMA addr container.
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>
> 
> Were is patch #1 from this series?

That one is xe specific:
https://lore.kernel.org/intel-xe/20250407141823.44504-3-matthew.auld@intel.com/T/#m4ef16e478cfc8853d4518448dd345a66d5a7f6d9

I copied your approach with using page_link here, but with added sg_page().

> 
> Thanks,
> Christian.
> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> index 9f627caedc3f..c9842a0e2a1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>> @@ -184,7 +184,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>>   				 struct sg_table *sgt,
>>   				 enum dma_data_direction dir)
>>   {
>> -	if (sgt->sgl->page_link) {
>> +	if (sg_page(sgt->sgl)) {
>>   		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>>   		sg_free_table(sgt);
>>   		kfree(sgt);
> 

