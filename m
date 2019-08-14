From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
Date: Tue, 13 Aug 2019 18:36:33 -0700
Message-ID: <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
References: <20190806160554.14046-1-hch@lst.de> <20190806160554.14046-5-hch@lst.de>
 <20190807174548.GJ1571@mellanox.com> <CAPcyv4hPCuHBLhSJgZZEh0CbuuJNPLFDA3f-79FX5uVOO0yubA@mail.gmail.com>
 <20190808065933.GA29382@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808065933.GA29382@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Jason Gunthorpe <jgg@mellanox.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>, Ralph Campbell <rcampbell@nvidia.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Aug 7, 2019 at 11:59 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Aug 07, 2019 at 11:47:22AM -0700, Dan Williams wrote:
> > > Unrelated to this patch, but what is the point of getting checking
> > > that the pgmap exists for the page and then immediately releasing it?
> > > This code has this pattern in several places.
> > >
> > > It feels racy
> >
> > Agree, not sure what the intent is here. The only other reason call
> > get_dev_pagemap() is to just check in general if the pfn is indeed
> > owned by some ZONE_DEVICE instance, but if the intent is to make sure
> > the device is still attached/enabled that check is invalidated at
> > put_dev_pagemap().
> >
> > If it's the former case, validating ZONE_DEVICE pfns, I imagine we can
> > do something cheaper with a helper that is on the order of the same
> > cost as pfn_valid(). I.e. replace PTE_DEVMAP with a mem_section flag
> > or something similar.
>
> The hmm literally never dereferences the pgmap, so validity checking is
> the only explanation for it.
>
> > > +               /*
> > > +                * We do put_dev_pagemap() here so that we can leverage
> > > +                * get_dev_pagemap() optimization which will not re-take a
> > > +                * reference on a pgmap if we already have one.
> > > +                */
> > > +               if (hmm_vma_walk->pgmap)
> > > +                       put_dev_pagemap(hmm_vma_walk->pgmap);
> > > +
> >
> > Seems ok, but only if the caller is guaranteeing that the range does
> > not span outside of a single pagemap instance. If that guarantee is
> > met why not just have the caller pass in a pinned pagemap? If that
> > guarantee is not met, then I think we're back to your race concern.
>
> It iterates over multiple ptes in a non-huge pmd.  Is there any kind of
> limitations on different pgmap instances inside a pmd?  I can't think
> of one, so this might actually be a bug.

Section alignment constraints somewhat save us here. The only example
I can think of a PMD not containing a uniform pgmap association for
each pte is the case when the pgmap overlaps normal dram, i.e. shares
the same 'struct memory_section' for a given span. Otherwise, distinct
pgmaps arrange to manage their own exclusive sections (and now
subsections as of v5.3). Otherwise the implementation could not
guarantee different mapping lifetimes.

That said, this seems to want a better mechanism to determine "pfn is
ZONE_DEVICE".
