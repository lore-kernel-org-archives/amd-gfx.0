From: Liam Mark <lmark@codeaurora.org>
Subject: [PATCH 01/12] dma-buf: add dynamic caching of sg_table
Date: Fri, 26 Apr 2019 17:01:09 -0700
Message-ID: <1556323269-19670-1-git-send-email-lmark@codeaurora.org>
References: <20190416183841.1577-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416183841.1577-1-christian.koenig@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ckoenig.leichtzumerken@gmail.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, sumit.semwal@linaro.org, lmark@codeaurora.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, 16 Apr 2019, Christian König wrote:

> To allow a smooth transition from pinning buffer objects to dynamic
> invalidation we first start to cache the sg_table for an attachment
> unless the driver explicitly says to not do so.
> 
> ---
>  drivers/dma-buf/dma-buf.c | 24 ++++++++++++++++++++++++
>  include/linux/dma-buf.h   | 11 +++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 7c858020d14b..65161a82d4d5 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -573,6 +573,20 @@ struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
>  	list_add(&attach->node, &dmabuf->attachments);
>  
>  	mutex_unlock(&dmabuf->lock);
> +
> +	if (!dmabuf->ops->dynamic_sgt_mapping) {
> +		struct sg_table *sgt;
> +
> +		sgt = dmabuf->ops->map_dma_buf(attach, DMA_BIDIRECTIONAL);
> +		if (!sgt)
> +			sgt = ERR_PTR(-ENOMEM);
> +		if (IS_ERR(sgt)) {
> +			dma_buf_detach(dmabuf, attach);
> +			return ERR_CAST(sgt);
> +		}
> +		attach->sgt = sgt;
> +	}
> +
>  	return attach;
>  
>  err_attach:
> @@ -595,6 +609,10 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
>  	if (WARN_ON(!dmabuf || !attach))
>  		return;
>  
> +	if (attach->sgt)
> +		dmabuf->ops->unmap_dma_buf(attach, attach->sgt,
> +					   DMA_BIDIRECTIONAL);
> +
>  	mutex_lock(&dmabuf->lock);
>  	list_del(&attach->node);
>  	if (dmabuf->ops->detach)
> @@ -630,6 +648,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *attach,
>  	if (WARN_ON(!attach || !attach->dmabuf))
>  		return ERR_PTR(-EINVAL);
>  
> +	if (attach->sgt)
> +		return attach->sgt;
> +

I am concerned by this change to make caching the sg_table the default 
behavior as this will result in the exporter's map_dma_buf/unmap_dma_buf 
calls are no longer being called in 
dma_buf_map_attachment/dma_buf_unmap_attachment.
	
This seems concerning to me as it appears to ignore the cache maintenance 
aspect of the map_dma_buf/unmap_dma_buf calls.
For example won't this potentially cause issues for clients of ION.

If we had the following
- #1 dma_buf_attach coherent_device
- #2 dma_buf attach non_coherent_device
- #3 dma_buf_map_attachment non_coherent_device
- #4 non_coherent_device writes to buffer
- #5 dma_buf_unmap_attachment non_coherent_device
- #6 dma_buf_map_attachment coherent_device
- #7 coherent_device reads buffer
- #8 dma_buf_unmap_attachment coherent_device	

There wouldn't be any CMO at step #5 anymore (specifically no invalidate) 
so now at step #7 the coherent_device could read a stale cache line.

Also, now by default dma_buf_unmap_attachment no longer removes the 
mappings from the iommu, so now by default dma_buf_unmap_attachment is not 
doing what I would expect and clients are losing the potential sandboxing 
benefits of removing the mappings.
Shouldn't this caching behavior be something that clients opt into instead 
of being the default?

Liam

Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
