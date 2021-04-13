Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C116CC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F462613B1
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F462613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EA0A6E1ED;
	Tue, 13 Apr 2021 18:08:23 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58CEB6E1ED
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 18:08:21 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id g17so19734686edm.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 11:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=9drFMLbC50ineLu9S9jQUwgayeJFJoB50tZ0bU2FdVE=;
 b=uRVRWouNxkRejW2LG/QiwtbTHG9Bk8daD6kGHDUNFB/ldrxrOqBVaseibHkxPV96Xk
 fgwfaxkL8G5Zub8xOayoCt7EPHPxGdZuFFn6JDf9iyKVLAEbGfVfbf418zY7OqIhAenl
 N9fhidO+Vbr5S64fJyB/McwdRDIhVd8r2wrVYRKkk0MYKvTjbGKhPrzYHn9e5jS4VCyC
 E9nd8WR8GIRuGoHXyTnY+EwnEhpyxUQVM9q3XZqLAoDZO5E+4dl8msVd+cgx3NibahL1
 TI0OyEc6SRcOxiDzOO+QM5LbeoL2xGztaUgjeNJH/N18h1juqHU5UiGDGRfh8s19VOGP
 fclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9drFMLbC50ineLu9S9jQUwgayeJFJoB50tZ0bU2FdVE=;
 b=Yg4tJUhm4fH34qzwqjW1YzXc3YGVp1SgXdwKyF/7HqvwIu3uIudtfmca9mumsw6eJk
 MWm35j+WQp+DZFRUvzidWTF0+z9XMgJYqrmsFVnyfHEC/2dwnb/zZ776kE34nueuqSpi
 njw1AfTa3lJ6AtWpkq6JCrtCawD2OEwwIWs95hgaWY+VPKk3f1HvTPhlZBJzF4jz/kl4
 C6PWN0HLwMS6phlAeQSBVqoWXMxtKKwWB3GT7HKFCV5q6fiRKVBmdVLxGPdzk6DDlfQC
 1Tg7WsBv5sFiZJBB5ZTkQ94Ow+Bb3xYGz3XZXwjywpG+SP6IZuI5xC+hyb/c5BKAhmB7
 b/6w==
X-Gm-Message-State: AOAM53021vSKioRwvSExjaC9oiGvV+BhXfRh+VEGL/lH4b7nKDC+AsEJ
 VmSCMMMdMY69GU413vhSeZ4vnTZrH3U=
X-Google-Smtp-Source: ABdhPJw0ohDfj8H/VQSfj1vHGsPW3YwOrq5VGkiTPdiHgiqC2/TRjdihkLiyWMNg3E6/Gqi0SpXWyA==
X-Received: by 2002:aa7:db95:: with SMTP id u21mr36252421edt.152.1618337299960; 
 Tue, 13 Apr 2021 11:08:19 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:68fb:3c11:fcc3:c883?
 ([2a02:908:1252:fb60:68fb:3c11:fcc3:c883])
 by smtp.gmail.com with ESMTPSA id h8sm9753601ede.25.2021.04.13.11.08.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 11:08:19 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: Use iterator methods exposed by
 amdgpu_res_cursor.h in building SG_TABLE's for a VRAM BO
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210413171736.12102-1-Ramesh.Errabolu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4ed4d2c4-2312-7a1a-913b-360061ad7cc4@gmail.com>
Date: Tue, 13 Apr 2021 20:08:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210413171736.12102-1-Ramesh.Errabolu@amd.com>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.04.21 um 19:17 schrieb Ramesh Errabolu:
> Extend current implementation of SG_TABLE construction method to
> allow exportation of sub-buffers of a VRAM BO. This capability will
> enable logical partitioning of a VRAM BO into multiple non-overlapping
> sub-buffers. One example of this use case is to partition a VRAM BO
> into two sub-buffers, one for SRC and another for DST.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c  |  6 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 34 ++++++++++++++------
>   3 files changed, 29 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index e0c4f7c7f1b9..57534b93bd91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -255,6 +255,7 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   	struct sg_table *sgt;
> +	u64 num_bytes;
>   	long r;
>   
>   	if (!bo->tbo.pin_count) {
> @@ -291,8 +292,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   		break;
>   
>   	case TTM_PL_VRAM:
> -		r = amdgpu_vram_mgr_alloc_sgt(adev, &bo->tbo.mem, attach->dev,
> -					      dir, &sgt);
> +		num_bytes = bo->tbo.mem.num_pages << PAGE_SHIFT;

Please rather use bo->tbo.base.size here. It is already in bytes.

> +		r = amdgpu_vram_mgr_alloc_sgt(adev, &bo->tbo.mem, 0, num_bytes,
> +					      attach->dev, dir, &sgt);
>   		if (r)
>   			return ERR_PTR(r);
>   		break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index dec0db8b0b13..9e38475e0f8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -112,6 +112,7 @@ int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
>   u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);
>   int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   			      struct ttm_resource *mem,
> +			      u64 offset, u64 size,
>   			      struct device *dev,
>   			      enum dma_data_direction dir,
>   			      struct sg_table **sgt);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 592a2dd16493..c1a7772fa8e8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -25,6 +25,7 @@
>   #include <linux/dma-mapping.h>
>   #include "amdgpu.h"
>   #include "amdgpu_vm.h"
> +#include "amdgpu_res_cursor.h"
>   #include "amdgpu_atomfirmware.h"
>   #include "atom.h"
>   
> @@ -565,6 +566,8 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
>    *
>    * @adev: amdgpu device pointer
>    * @mem: TTM memory object
> + * @offset: byte offset from the base of VRAM BO
> + * @length: number of bytes to export in sg_table
>    * @dev: the other device
>    * @dir: dma direction
>    * @sgt: resulting sg table
> @@ -573,39 +576,47 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
>    */
>   int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   			      struct ttm_resource *mem,
> +			      u64 offset, u64 length,
>   			      struct device *dev,
>   			      enum dma_data_direction dir,
>   			      struct sg_table **sgt)
>   {
> -	struct drm_mm_node *node;
> +	struct amdgpu_res_cursor cursor;
>   	struct scatterlist *sg;
>   	int num_entries = 0;
> -	unsigned int pages;
>   	int i, r;
>   
>   	*sgt = kmalloc(sizeof(**sgt), GFP_KERNEL);
>   	if (!*sgt)
>   		return -ENOMEM;
>   
> -	for (pages = mem->num_pages, node = mem->mm_node;
> -	     pages; pages -= node->size, ++node)
> -		++num_entries;
> +	/* Determine the number of DRM_MM nodes to export */
> +	amdgpu_res_first(mem, offset, length, &cursor);
> +	while (cursor.remaining) {
> +		num_entries++;
> +		amdgpu_res_next(&cursor, cursor.size);
> +	}
>   
>   	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
>   	if (r)
>   		goto error_free;
>   
> +	/* Initialize scatterlist nodes of sg_table */
>   	for_each_sgtable_sg((*sgt), sg, i)
>   		sg->length = 0;
>   
> -	node = mem->mm_node;
> +	/*
> +	 * Walk down DRM_MM nodes to populate scatterlist nodes
> +	 * @note: Use iterator api to get first the DRM_MM node
> +	 * and the number of bytes from it. Access the following
> +	 * DRM_MM node(s) if more buffer needs to exported
> +	 */
> +	amdgpu_res_first(mem, offset, length, &cursor);
>   	for_each_sgtable_sg((*sgt), sg, i) {
> -		phys_addr_t phys = (node->start << PAGE_SHIFT) +
> -			adev->gmc.aper_base;
> -		size_t size = node->size << PAGE_SHIFT;
>   		dma_addr_t addr;
> +		size_t size = cursor.size;
> +		phys_addr_t phys = cursor.start + adev->gmc.aper_base;

Please reorder the declarations in reverse xmas tree order.

Apart from those nit picks the patch looks good to me.

Thanks,
Christian.

>   
> -		++node;
>   		addr = dma_map_resource(dev, phys, size, dir,
>   					DMA_ATTR_SKIP_CPU_SYNC);
>   		r = dma_mapping_error(dev, addr);
> @@ -615,7 +626,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   		sg_set_page(sg, NULL, size, 0);
>   		sg_dma_address(sg) = addr;
>   		sg_dma_len(sg) = size;
> +
> +		amdgpu_res_next(&cursor, cursor.size);
>   	}
> +
>   	return 0;
>   
>   error_unmap:

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
