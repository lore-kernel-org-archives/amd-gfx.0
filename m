Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17496C6FA86
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 21:38:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3456710EA40;
	Wed, 28 Sep 2022 21:38:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E98B10EA45
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664401078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NW+hPnc8ltRRyw1JoLCHvkVBxa3HbmO0cDA/9HFGDws=;
 b=bkGB86NZJ40vtYPEnh/I2zM1vvU4E9290SUrDsFtfPPALbIFNM3hLFinZGS2OZWl4csecz
 gE95+A104GRmFbKRAgwBRUuWa/6q4N7xcsQf8iSvzPzrzMlTJEaUO1Km6eIhfH7pIEZ7cM
 KldtI2c+MA1ggMVN4bc0IZr1AbQuG20=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-85-odb9oAHFMUqmjUswKk3FXA-1; Wed, 28 Sep 2022 17:37:57 -0400
X-MC-Unique: odb9oAHFMUqmjUswKk3FXA-1
Received: by mail-qv1-f71.google.com with SMTP id
 g12-20020a0cfdcc000000b004ad431ceee0so8605102qvs.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 14:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:user-agent:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date;
 bh=NW+hPnc8ltRRyw1JoLCHvkVBxa3HbmO0cDA/9HFGDws=;
 b=cCTz2IQnBBP/AYX9dzcY8Rhc28nsstAUA14P4PV/IiCZs4hTVshYCm2axLCgv25YKz
 9EfdEbHQjQH5DH8IWD0vH0l2m6sUmy3J9owPzTCb1MKBODsxm4eJ6ljz5lfD+c4Aa8yv
 ORbjbwpExnviBEav9H2Snt/VSwl0cyHRbEgDVeszX0HoCgQ0wITyNJrkTge3e61hbAa3
 xfB/Fl+6Eg1cWq3ObGsQqNIkahRPWgw/HyOAiwWYRR09UGMG5gbJtvo75rH40Pi+Cuoj
 TyzXGPAl8sD4E8UrfAWH5zCCvW9JmaJmy2HgtbTotgp3MHN4p362jeVyIS0ziZUznNaY
 MAIQ==
X-Gm-Message-State: ACrzQf1snzZwzKTTbj30j2IEmuD/5nzBPCUbYIlaihmxV+/EYyT2iRh+
 0CLkmrjUC55c8CPSMS8ls9IFbWwgIruG24d4nog3nApHXGnutaNpBdmIFguxmhNjSRMg3nAukVg
 4Vq6R3xkGtPdja6ql2/ZsPHQVhA==
X-Received: by 2002:a05:620a:21c7:b0:6cd:52bc:b578 with SMTP id
 h7-20020a05620a21c700b006cd52bcb578mr74198qka.385.1664401076816; 
 Wed, 28 Sep 2022 14:37:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM471Bcus/IrN+YWIeg7hqlJQkYwhfHMIbXHdbGFr95JT37FsXUZuIl2USVC2745pqscAFNiTQ==
X-Received: by 2002:a05:620a:21c7:b0:6cd:52bc:b578 with SMTP id
 h7-20020a05620a21c700b006cd52bcb578mr74177qka.385.1664401076544; 
 Wed, 28 Sep 2022 14:37:56 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c48:e00::feb? ([2600:4040:5c48:e00::feb])
 by smtp.gmail.com with ESMTPSA id
 c25-20020a05620a269900b006cea2984c9bsm4340202qkp.100.2022.09.28.14.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Sep 2022 14:37:54 -0700 (PDT)
Message-ID: <e337e6f4a65d5ac596f8363e2af4f70201ef4bc8.camel@redhat.com>
Subject: Re: [PATCH v2 7/8] nouveau/dmem: Evict device private memory during
 release
From: Lyude Paul <lyude@redhat.com>
To: Alistair Popple <apopple@nvidia.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-mm@kvack.org
Date: Wed, 28 Sep 2022 17:37:52 -0400
In-Reply-To: <66277601fb8fda9af408b33da9887192bf895bda.1664366292.git-series.apopple@nvidia.com>
References: <cover.60659b549d8509ddecafad4f498ee7f03bb23c69.1664366292.git-series.apopple@nvidia.com>
 <66277601fb8fda9af408b33da9887192bf895bda.1664366292.git-series.apopple@nvidia.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
Cc: Ralph Campbell <rcampbell@nvidia.com>, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, John Hubbard <jhubbard@nvidia.com>,
 Ben Skeggs <bskeggs@redhat.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2022-09-28 at 22:01 +1000, Alistair Popple wrote:
> When the module is unloaded or a GPU is unbound from the module it is
> possible for device private pages to still be mapped in currently
> running processes. This can lead to a hangs and RCU stall warnings when
> unbinding the device as memunmap_pages() will wait in an uninterruptible
> state until all device pages have been freed which may never happen.
> 
> Fix this by migrating device mappings back to normal CPU memory prior to
> freeing the GPU memory chunks and associated device private pages.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_dmem.c | 48 +++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index 65f51fb..5fe2091 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -367,6 +367,52 @@ nouveau_dmem_suspend(struct nouveau_drm *drm)
>  	mutex_unlock(&drm->dmem->mutex);
>  }
>  
> +/*
> + * Evict all pages mapping a chunk.
> + */
> +static void
> +nouveau_dmem_evict_chunk(struct nouveau_dmem_chunk *chunk)
> +{
> +	unsigned long i, npages = range_len(&chunk->pagemap.range) >> PAGE_SHIFT;
> +	unsigned long *src_pfns, *dst_pfns;
> +	dma_addr_t *dma_addrs;
> +	struct nouveau_fence *fence;
> +
> +	src_pfns = kcalloc(npages, sizeof(*src_pfns), GFP_KERNEL);
> +	dst_pfns = kcalloc(npages, sizeof(*dst_pfns), GFP_KERNEL);
> +	dma_addrs = kcalloc(npages, sizeof(*dma_addrs), GFP_KERNEL);
> +
> +	migrate_device_range(src_pfns, chunk->pagemap.range.start >> PAGE_SHIFT,
> +			npages);
> +
> +	for (i = 0; i < npages; i++) {
> +		if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
> +			struct page *dpage;
> +
> +			/*
> +			 * _GFP_NOFAIL because the GPU is going away and there
> +			 * is nothing sensible we can do if we can't copy the
> +			 * data back.
> +			 */
> +			dpage = alloc_page(GFP_HIGHUSER | __GFP_NOFAIL);
> +			dst_pfns[i] = migrate_pfn(page_to_pfn(dpage));
> +			nouveau_dmem_copy_one(chunk->drm,
> +					migrate_pfn_to_page(src_pfns[i]), dpage,
> +					&dma_addrs[i]);
> +		}
> +	}
> +
> +	nouveau_fence_new(chunk->drm->dmem->migrate.chan, false, &fence);
> +	migrate_device_pages(src_pfns, dst_pfns, npages);
> +	nouveau_dmem_fence_done(&fence);
> +	migrate_device_finalize(src_pfns, dst_pfns, npages);
> +	kfree(src_pfns);
> +	kfree(dst_pfns);
> +	for (i = 0; i < npages; i++)
> +		dma_unmap_page(chunk->drm->dev->dev, dma_addrs[i], PAGE_SIZE, DMA_BIDIRECTIONAL);
> +	kfree(dma_addrs);
> +}
> +
>  void
>  nouveau_dmem_fini(struct nouveau_drm *drm)
>  {
> @@ -378,8 +424,10 @@ nouveau_dmem_fini(struct nouveau_drm *drm)
>  	mutex_lock(&drm->dmem->mutex);
>  
>  	list_for_each_entry_safe(chunk, tmp, &drm->dmem->chunks, list) {
> +		nouveau_dmem_evict_chunk(chunk);
>  		nouveau_bo_unpin(chunk->bo);
>  		nouveau_bo_ref(NULL, &chunk->bo);
> +		WARN_ON(chunk->callocated);
>  		list_del(&chunk->list);
>  		memunmap_pages(&chunk->pagemap);
>  		release_mem_region(chunk->pagemap.range.start,

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

