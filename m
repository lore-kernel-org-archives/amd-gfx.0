From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 02/12] dma-buf: add dma_buf_(un)map_attachment_locked
 variants v3
Date: Mon, 27 May 2019 12:56:15 +0200
Message-ID: <76bc8afb-8797-9057-ccb5-2d4f788d2f9e@gmail.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-3-christian.koenig@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190416183841.1577-3-christian.koenig@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hillf Danton <hdanton@sina.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org, sumit.semwal@linaro.org, linux-media@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Thanks for the comments, but you are looking at a completely outdated 
patchset.

If you are interested in the newest one please ping me and I'm going to 
CC you when I send out the next version.

Christian.

Am 25.05.19 um 03:04 schrieb Hillf Danton:
> On Tue, 16 Apr 2019 20:38:31 +0200 Christian König wrote:
>> Add function variants which can be called with the reservation lock
>> already held.
>>
>> v2: reordered, add lockdep asserts, fix kerneldoc
>> v3: rebased on sgt caching
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/dma-buf/dma-buf.c | 63 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/dma-buf.h   |  5 ++++
>>   2 files changed, 68 insertions(+)
>>
>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
>> index 65161a82d4d5..ef480e5fb239 100644
>> --- a/drivers/dma-buf/dma-buf.c
>> +++ b/drivers/dma-buf/dma-buf.c
>> @@ -623,6 +623,43 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
>>   }
>>   EXPORT_SYMBOL_GPL(dma_buf_detach);
>>   
>> +/**
>> + * dma_buf_map_attachment_locked - Maps the buffer into _device_ address space
>> + * with the reservation lock held. Is a wrapper for map_dma_buf() of the
> Something is missing; seems to be s/of the/of the dma_buf_ops./
>> + *
>> + * Returns the scatterlist table of the attachment;
>> + * dma_buf_ops.
> Oh it is sitting here!
>
>> + * @attach:	[in]	attachment whose scatterlist is to be returned
>> + * @direction:	[in]	direction of DMA transfer
>> + *
>> + * Returns sg_table containing the scatterlist to be returned; returns ERR_PTR
>> + * on error. May return -EINTR if it is interrupted by a signal.
>> + *
> EINTR looks impossible in the code.
>
>> + * A mapping must be unmapped by using dma_buf_unmap_attachment_locked(). Note
>> + * that the underlying backing storage is pinned for as long as a mapping
>> + * exists, therefore users/importers should not hold onto a mapping for undue
>> + * amounts of time.
>> + */
>> +struct sg_table *
>> +dma_buf_map_attachment_locked(struct dma_buf_attachment *attach,
>> +			      enum dma_data_direction direction)
>> +{
>> +	struct sg_table *sg_table;
>> +
>> +	might_sleep();
>> +	reservation_object_assert_held(attach->dmabuf->resv);
>> +
>> +	if (attach->sgt)
>> +		return attach->sgt;
>> +
>> +	sg_table = attach->dmabuf->ops->map_dma_buf(attach, direction);
>> +	if (!sg_table)
>> +		sg_table = ERR_PTR(-ENOMEM);
>> +
>> +	return sg_table;
>> +}
>> +EXPORT_SYMBOL_GPL(dma_buf_map_attachment_locked);
>> +
> Best Regards
> Hillf
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
