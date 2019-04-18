From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: dynamic DMA-buf sharing between devices
Date: Thu, 18 Apr 2019 11:13:15 +0200
Message-ID: <20190418091315.GU13337@phenom.ffwll.local>
References: <20190416183841.1577-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190416183841.1577-1-christian.koenig@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: sumit.semwal@linaro.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Apr 16, 2019 at 08:38:29PM +0200, Christian König wrote:
> Hi everybody,
> 
> core idea in this patch set is that DMA-buf importers can now provide an optional invalidate callback. Using this callback and the reservation object exporters can now avoid pinning DMA-buf memory for a long time while sharing it between devices.
> 
> I've already send out an older version roughly a year ago, but didn't had time to further look into cleaning this up.
> 
> The last time a major problem was that we would had to fix up all drivers implementing DMA-buf at once.
> 
> Now I avoid this by allowing mappings to be cached in the DMA-buf attachment and so driver can optionally move over to the new interface one by one.
> 
> This is also a prerequisite to my patchset enabling sharing of device memory with DMA-buf.

Ok, with the discussions and thinking I think this design is solid and
should work out. Bunch of api and documentation polishing still to do, to
make sure we have really clear semantics and as little room as possible
for misunderstanding - refactoring a mess in dma-buf is a lot more tricky
than just ttm, there's a lot more users.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
