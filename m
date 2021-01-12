Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ECAC433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E11D922CE3
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 09:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E11D922CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C2F16E16F;
	Tue, 12 Jan 2021 09:01:35 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5B056E161
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 09:01:34 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id d26so1568707wrb.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 01:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rvdotRgawhIL6mvIVyI/dyFURn6mdvmeVOlnSFghUUA=;
 b=WA27r8HUAy4eaksQTJck5ZrE7peKFw6nOcSJzp6aNX42gNXEoazVRHEX7/Cvwiv6LU
 lgpRQki72QahsKTP8Vq57/SfBopknVJuQ+aXAqD1CkjuIS4CmiheckhThItM1QWgygHb
 AVLYjBmdEoUhkULwQflLRgWBYkPrmr1t++3FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rvdotRgawhIL6mvIVyI/dyFURn6mdvmeVOlnSFghUUA=;
 b=FW3pI4lelwBkVpaVpAyWn0PADlvsPq1udqZTjkCaVFGa+e5aJI2NpN9+LPUdAwrsHW
 9yiLvDwEGNDO5T1sFAa44saCyFC8qR5L/INWchc4ELjNQpDDiIvBjmrQ4N3cRjq8zLnB
 gjy2x6gN4Hq4GyU6Ca87yR3CMiQAUgSP48vc1FuVDqIc0VVaTUeNx80fnnZKK71i9GV4
 GmSm6VF3lA5Stm4q/wggWvbwjI9WqIJ1cvDH2yPY0wKR+DgEtEfLmtlzFQE4MAODLOOs
 nL4suqpku1qWtWTGSZYh1OkzsYwsUyKKeNJsu9mGIXHEy+PiYiAHSNx1Ol3jcAxe6Gv1
 3EFw==
X-Gm-Message-State: AOAM533cksCrwWNY6ILfJ5loAYMRSNlztGbQxZhi9rwkVkZ5ol6A+MG/
 gqjAXBIKdiYiGrwyoMJpdSyRqA==
X-Google-Smtp-Source: ABdhPJzE1BHOOjXJ8oRIHu9inyACpheLoIi8I07LnC3sMfePGXduVT29tRmGL2joiZ8b+wtwZ1gnkg==
X-Received: by 2002:adf:ec41:: with SMTP id w1mr3169707wrn.12.1610442093566;
 Tue, 12 Jan 2021 01:01:33 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id a62sm2667930wmf.7.2021.01.12.01.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 01:01:32 -0800 (PST)
Date: Tue, 12 Jan 2021 10:01:30 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/6] drm: Implement drm_need_swiotlb() in drm_cache.c
Message-ID: <X/1laqvIEeBKhOHw@phenom.ffwll.local>
References: <20210112081035.6882-1-tzimmermann@suse.de>
 <20210112081035.6882-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112081035.6882-3-tzimmermann@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
Cc: amd-gfx@lists.freedesktop.org, airlied@linux.ie,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jan 12, 2021 at 09:10:31AM +0100, Thomas Zimmermann wrote:
> The function is declared in drm_cache.h. I also removed the curly
> braces from the for loop to adhere to kernel coding style.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

s/implement in/move to/ in the subject. Also would be nice to add
kerneldoc while moving (there's not kerneldoc for drm_memory) to avoid the
new warning. With that fixed:

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

It's mildly confusing, but in a way drm_cache.c is our "hack around
dma-api layering issues" pile, so fits :-) Maybe we should even make this
the official DOC: kerneldoc intro section for this file ...

Cheers, Daniel

> ---
>  drivers/gpu/drm/drm_cache.c  | 32 ++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_memory.c | 33 ---------------------------------
>  2 files changed, 32 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
> index 0fe3c496002a..49551a7fa22f 100644
> --- a/drivers/gpu/drm/drm_cache.c
> +++ b/drivers/gpu/drm/drm_cache.c
> @@ -30,6 +30,7 @@
>  
>  #include <linux/export.h>
>  #include <linux/highmem.h>
> +#include <xen/xen.h>
>  
>  #include <drm/drm_cache.h>
>  
> @@ -176,3 +177,34 @@ drm_clflush_virt_range(void *addr, unsigned long length)
>  #endif
>  }
>  EXPORT_SYMBOL(drm_clflush_virt_range);
> +
> +bool drm_need_swiotlb(int dma_bits)
> +{
> +	struct resource *tmp;
> +	resource_size_t max_iomem = 0;
> +
> +	/*
> +	 * Xen paravirtual hosts require swiotlb regardless of requested dma
> +	 * transfer size.
> +	 *
> +	 * NOTE: Really, what it requires is use of the dma_alloc_coherent
> +	 *       allocator used in ttm_dma_populate() instead of
> +	 *       ttm_populate_and_map_pages(), which bounce buffers so much in
> +	 *       Xen it leads to swiotlb buffer exhaustion.
> +	 */
> +	if (xen_pv_domain())
> +		return true;
> +
> +	/*
> +	 * Enforce dma_alloc_coherent when memory encryption is active as well
> +	 * for the same reasons as for Xen paravirtual hosts.
> +	 */
> +	if (mem_encrypt_active())
> +		return true;
> +
> +	for (tmp = iomem_resource.child; tmp; tmp = tmp->sibling)
> +		max_iomem = max(max_iomem,  tmp->end);
> +
> +	return max_iomem > ((u64)1 << dma_bits);
> +}
> +EXPORT_SYMBOL(drm_need_swiotlb);
> diff --git a/drivers/gpu/drm/drm_memory.c b/drivers/gpu/drm/drm_memory.c
> index f4f2bffdd5bd..e4f20a2eb6e7 100644
> --- a/drivers/gpu/drm/drm_memory.c
> +++ b/drivers/gpu/drm/drm_memory.c
> @@ -37,7 +37,6 @@
>  #include <linux/highmem.h>
>  #include <linux/pci.h>
>  #include <linux/vmalloc.h>
> -#include <xen/xen.h>
>  
>  #include <drm/drm_agpsupport.h>
>  #include <drm/drm_cache.h>
> @@ -138,35 +137,3 @@ void drm_legacy_ioremapfree(struct drm_local_map *map, struct drm_device *dev)
>  		iounmap(map->handle);
>  }
>  EXPORT_SYMBOL(drm_legacy_ioremapfree);
> -
> -bool drm_need_swiotlb(int dma_bits)
> -{
> -	struct resource *tmp;
> -	resource_size_t max_iomem = 0;
> -
> -	/*
> -	 * Xen paravirtual hosts require swiotlb regardless of requested dma
> -	 * transfer size.
> -	 *
> -	 * NOTE: Really, what it requires is use of the dma_alloc_coherent
> -	 *       allocator used in ttm_dma_populate() instead of
> -	 *       ttm_populate_and_map_pages(), which bounce buffers so much in
> -	 *       Xen it leads to swiotlb buffer exhaustion.
> -	 */
> -	if (xen_pv_domain())
> -		return true;
> -
> -	/*
> -	 * Enforce dma_alloc_coherent when memory encryption is active as well
> -	 * for the same reasons as for Xen paravirtual hosts.
> -	 */
> -	if (mem_encrypt_active())
> -		return true;
> -
> -	for (tmp = iomem_resource.child; tmp; tmp = tmp->sibling) {
> -		max_iomem = max(max_iomem,  tmp->end);
> -	}
> -
> -	return max_iomem > ((u64)1 << dma_bits);
> -}
> -EXPORT_SYMBOL(drm_need_swiotlb);
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
