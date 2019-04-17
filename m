From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: dynamic DMA-buf sharing between devices
Date: Wed, 17 Apr 2019 15:59:51 +0200
Message-ID: <04558379-9788-bbcc-5c64-7fa9ad92f60d@gmail.com>
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <b19612a3-0143-f8b5-7758-7e80c46d33d4@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b19612a3-0143-f8b5-7758-7e80c46d33d4@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chunming Zhou <zhoucm1@amd.com>, "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On top of those I have 6 more patches in the pipeline to enable VRAM P2P 
with DMA-buf.

So that is not the end of the patch set :)

Christian.

Am 17.04.19 um 15:52 schrieb Chunming Zhou:
> Thanks Christian, great job. I will verify it this week when I finish my
> current work on hand.
>
> -David
>
> 在 2019/4/17 2:38, Christian König wrote:
>> Hi everybody,
>>
>> core idea in this patch set is that DMA-buf importers can now provide an optional invalidate callback. Using this callback and the reservation object exporters can now avoid pinning DMA-buf memory for a long time while sharing it between devices.
>>
>> I've already send out an older version roughly a year ago, but didn't had time to further look into cleaning this up.
>>
>> The last time a major problem was that we would had to fix up all drivers implementing DMA-buf at once.
>>
>> Now I avoid this by allowing mappings to be cached in the DMA-buf attachment and so driver can optionally move over to the new interface one by one.
>>
>> This is also a prerequisite to my patchset enabling sharing of device memory with DMA-buf.
>>
>> Please review and/or comment,
>> Christian.
>>
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
