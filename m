From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 05/12] dma-buf: add explicit buffer pinning
Date: Wed, 17 Apr 2019 16:40:11 +0200
Message-ID: <20190417144011.GI13337@phenom.ffwll.local>
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-6-christian.koenig@amd.com>
 <20190417142002.GE13337@phenom.ffwll.local>
 <20190417143051.GG13337@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190417143051.GG13337@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, sumit.semwal@linaro.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Apr 17, 2019 at 04:30:51PM +0200, Daniel Vetter wrote:
> On Wed, Apr 17, 2019 at 04:20:02PM +0200, Daniel Vetter wrote:
> > On Tue, Apr 16, 2019 at 08:38:34PM +0200, Christian König wrote:
> > > Add optional explicit pinning callbacks instead of implicitly assume the
> > > exporter pins the buffer when a mapping is created.
> > > 
> > > Signed-off-by: Christian König <christian.koenig@amd.com>
> > 
> > Don't we need this together with the invalidate callback and the dynamic
> > stuff? Also I'm assuming that pin/unpin is pretty much required for
> > dynamic bo, so could we look at these callbacks instead of the dynamic
> > flag you add in patch 1.
> > 
> > I'm assuming following rules hold:
> > no pin/upin from exporter:
> > 
> > dma-buf is not dynamic, and pinned for the duration of map/unmap. I'm
> > not 100% sure whether really everyone wants the mapping to be cached for
> > the entire attachment, only drm_prime does that. And that's not the only
> > dma-buf importer.
> > 
> > pin/unpin calls are noops.
> > 
> > pin/unpin exist in the exporter, but importer has not provided an
> > invalidate callback:
> > 
> > We map at attach time, and we also have to pin, since the importer can't
> > handle the buffer disappearing, at attach time. We unmap/unpin at detach.
> 
> For this case we should have a WARN in pin/unpin, to make sure importers
> don't do something stupid. One more thought below on pin/unpin.
> 
> > pin/unpin from exporter, invalidate from importer:
> > 
> > Full dynamic mapping. We assume the importer will do caching, attach
> > fences as needed, and pin the underlying bo when it needs it it
> > permanently, without attaching fences (i.e. the scanout case).
> > 
> > Assuming I'm not terribly off with my understanding, then I think it'd be
> > best to introduce the entire new dma-buf api in the first patch, and flesh
> > it out later. Instead of spread over a few patches. Plus the above (maybe
> > prettier) as a nice kerneldoc overview comment for how dynamic dma-buf is
> > supposed to work really.
> > -Daniel
> > 
> > > ---
> > >  drivers/dma-buf/dma-buf.c | 39 +++++++++++++++++++++++++++++++++++++++
> > >  include/linux/dma-buf.h   | 37 +++++++++++++++++++++++++++++++------
> > >  2 files changed, 70 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > index a3738fab3927..f23ff8355505 100644
> > > --- a/drivers/dma-buf/dma-buf.c
> > > +++ b/drivers/dma-buf/dma-buf.c
> > > @@ -630,6 +630,41 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
> > >  }
> > >  EXPORT_SYMBOL_GPL(dma_buf_detach);
> > >  
> > > +/**
> > > + * dma_buf_pin - Lock down the DMA-buf
> > > + *
> > > + * @dmabuf:	[in]	DMA-buf to lock down.
> > > + *
> > > + * Returns:
> > > + * 0 on success, negative error code on failure.
> > > + */
> > > +int dma_buf_pin(struct dma_buf *dmabuf)
> 
> Hm, I think it'd be better to pin the attachment, not the underlying
> buffer. Attachment is the thin the importer will have to pin, and it's at
> attach/detach time where dma-buf needs to pin for importers who don't
> understand dynamic buffer sharing.
> 
> Plus when we put that onto attachments, we can do a
> 
> 	WARN_ON(!attach->invalidate);
> 
> sanity check. I think that would be good to have.

Another validation idea: dma-buf.c could track the pin_count on the struct
dma_buf, and if an exporter tries to invalidate while pinned WARN and bail
out. Because that's clearly a driver bug.

All in the interest in making the contract between importers and exporters
as clear as possible.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
