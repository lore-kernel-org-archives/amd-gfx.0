From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 04/12] dma-buf: add optional invalidate_mappings callback
 v5
Date: Thu, 18 Apr 2019 10:08:26 +0200
Message-ID: <20190418080826.GN13337@phenom.ffwll.local>
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-5-christian.koenig@amd.com>
 <20190417190719.GL13337@phenom.ffwll.local>
 <03a04d1d-9bc0-8f20-0436-b0f0017f0506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <03a04d1d-9bc0-8f20-0436-b0f0017f0506@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: christian.koenig@amd.com
Cc: sumit.semwal@linaro.org, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Apr 17, 2019 at 09:13:22PM +0200, Christian König wrote:
> Am 17.04.19 um 21:07 schrieb Daniel Vetter:
> > On Tue, Apr 16, 2019 at 08:38:33PM +0200, Christian König wrote:
> > > Each importer can now provide an invalidate_mappings callback.
> > > 
> > > This allows the exporter to provide the mappings without the need to pin
> > > the backing store.
> > > 
> > > v2: don't try to invalidate mappings when the callback is NULL,
> > >      lock the reservation obj while using the attachments,
> > >      add helper to set the callback
> > > v3: move flag for invalidation support into the DMA-buf,
> > >      use new attach_info structure to set the callback
> > > v4: use importer_priv field instead of mangling exporter priv.
> > > v5: drop invalidation_supported flag
> > > 
> > > Signed-off-by: Christian König <christian.koenig@amd.com>
> > > ---
> > >   drivers/dma-buf/dma-buf.c | 37 +++++++++++++++++++++++++++++++++++++
> > >   include/linux/dma-buf.h   | 33 +++++++++++++++++++++++++++++++--
> > >   2 files changed, 68 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > index 83c92bfd964c..a3738fab3927 100644
> > > --- a/drivers/dma-buf/dma-buf.c
> > > +++ b/drivers/dma-buf/dma-buf.c
> > > @@ -563,6 +563,8 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
> > >   	attach->dev = info->dev;
> > >   	attach->dmabuf = dmabuf;
> > > +	attach->importer_priv = info->importer_priv;
> > > +	attach->invalidate = info->invalidate;
> > >   	mutex_lock(&dmabuf->lock);
> > > @@ -571,7 +573,9 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
> > >   		if (ret)
> > >   			goto err_attach;
> > >   	}
> > > +	reservation_object_lock(dmabuf->resv, NULL);
> > >   	list_add(&attach->node, &dmabuf->attachments);
> > > +	reservation_object_unlock(dmabuf->resv);
> > >   	mutex_unlock(&dmabuf->lock);
> > > @@ -615,7 +619,9 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
> > >   					   DMA_BIDIRECTIONAL);
> > >   	mutex_lock(&dmabuf->lock);
> > > +	reservation_object_lock(dmabuf->resv, NULL);
> > >   	list_del(&attach->node);
> > > +	reservation_object_unlock(dmabuf->resv);
> > >   	if (dmabuf->ops->detach)
> > >   		dmabuf->ops->detach(dmabuf, attach);
> > > @@ -653,7 +659,16 @@ dma_buf_map_attachment_locked(struct dma_buf_attachment *attach,
> > >   	if (attach->sgt)
> > >   		return attach->sgt;
> > > +	/*
> > > +	 * Mapping a DMA-buf can trigger its invalidation, prevent sending this
> > > +	 * event to the caller by temporary removing this attachment from the
> > > +	 * list.
> > > +	 */
> > > +	if (attach->invalidate)
> > > +		list_del(&attach->node);
> > Just noticed this: Why do we need this? invalidate needs the reservation
> > lock, as does map_attachment. It should be impssoble to have someone else
> > sneak in here.
> 
> I was having problems with self triggered invalidations.
> 
> E.g. client A tries to map an attachment, that in turn causes the buffer to
> move to a new place and client A is informed about that movement with an
> invalidation.

Uh, that sounds like a bug in ttm or somewhere else in the exporter. If
you evict the bo that you're trying to map, that's bad.

Or maybe it's a framework bug, and we need to track whether an attachment
has a map or not. That would make more sense ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
