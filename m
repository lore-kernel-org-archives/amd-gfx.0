From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
Date: Thu, 15 Aug 2019 20:54:46 -0700
Message-ID: <CAPcyv4gMPVmY59aQAT64jQf9qXrACKOuV=DfVs4sNySCXJhkdA@mail.gmail.com>
References: <20190814073854.GA27249@lst.de> <20190814132746.GE13756@mellanox.com>
 <CAPcyv4g8usp8prJ+1bMtyV1xuedp5FKErBp-N8+KzR=rJ-v0QQ@mail.gmail.com>
 <20190815180325.GA4920@redhat.com> <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com>
 <20190815194339.GC9253@redhat.com> <CAPcyv4jid8_=-8hBpn_Qm=c4S8BapL9B9RGT7e9uu303yH=Yqw@mail.gmail.com>
 <20190815203306.GB25517@redhat.com> <20190815204128.GI22970@mellanox.com>
 <CAPcyv4j_Mxbw+T+yXTMdkrMoS_uxg+TXXgTM_EPBJ8XfXKxytA@mail.gmail.com> <20190816004053.GB9929@mellanox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190816004053.GB9929@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 15, 2019 at 5:41 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Aug 15, 2019 at 01:47:12PM -0700, Dan Williams wrote:
> > On Thu, Aug 15, 2019 at 1:41 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
> > >
> > > On Thu, Aug 15, 2019 at 04:33:06PM -0400, Jerome Glisse wrote:
> > >
> > > > So nor HMM nor driver should dereference the struct page (i do not
> > > > think any iommu driver would either),
> > >
> > > Er, they do technically deref the struct page:
> > >
> > > nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
> > >                          struct hmm_range *range)
> > >                 struct page *page;
> > >                 page = hmm_pfn_to_page(range, range->pfns[i]);
> > >                 if (!nouveau_dmem_page(drm, page)) {
> > >
> > >
> > > nouveau_dmem_page(struct nouveau_drm *drm, struct page *page)
> > > {
> > >         return is_device_private_page(page) && drm->dmem == page_to_dmem(page)
> > >
> > >
> > > Which does touch 'page->pgmap'
> > >
> > > Is this OK without having a get_dev_pagemap() ?
> > >
> > > Noting that the collision-retry scheme doesn't protect anything here
> > > as we can have a concurrent invalidation while doing the above deref.
> >
> > As long take_driver_page_table_lock() in Jerome's flow can replace
> > percpu_ref_tryget_live() on the pagemap reference. It seems
> > nouveau_dmem_convert_pfn() happens after:
> >
> >                         mutex_lock(&svmm->mutex);
> >                         if (!nouveau_range_done(&range)) {
> >
> > ...so I would expect that to be functionally equivalent to validating
> > the reference count.
>
> Yes, OK, that makes sense, I was mostly surprised by the statement the
> driver doesn't touch the struct page..
>
> I suppose "doesn't touch the struct page out of the driver lock" is
> the case.
>
> However, this means we cannot do any processing of ZONE_DEVICE pages
> outside the driver lock, so eg, doing any DMA map that might rely on
> MEMORY_DEVICE_PCI_P2PDMA has to be done in the driver lock, which is
> a bit unfortunate.

Wouldn't P2PDMA use page pins? Not needing to hold a lock over
ZONE_DEVICE page operations was one of the motivations for plumbing
get_dev_pagemap() with a percpu-ref.
