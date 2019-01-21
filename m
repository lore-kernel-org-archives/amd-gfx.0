From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Mon, 21 Jan 2019 17:14:37 +0100
Message-ID: <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121155908.GA8084@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, David Zhou <David1.Zhou@amd.com>, Huang Rui <ray.huang@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>, Michel Daenzer <michel.daenzer@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, 21 Jan 2019 at 16:59, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 21, 2019 at 04:33:27PM +0100, Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 16:07, Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > > +#include <linux/dma-noncoherent.h>
> > >
> > > This header is not for usage in device drivers, but purely for
> > > dma-mapping implementations!
> > >
> >
> > Is that documented anywhere?
>
> I'll add big fat comments.  But the fact that nothing is exported
> there should be a fairly big hint.
>

I don't follow. How do other header files 'export' things in a way
that this header doesn't?

> > > And even if something like this was valid to do, it would have to be
> > > a core function with an arch hook, and not hidden in a random driver.
> >
> > Why would it not be valid to do? Is it wrong for a driver to be aware
> > of whether a device is cache coherent or not?
> >
> > And in case it isn't, do you have an alternative suggestion on how to
> > fix this mess?
>
> For the write combine mappings we need a proper core API how instances
> can advertise the support.  One thing I want to do fairly soon is
> error checking of the attrs argument to dma_alloc_attrs - so if you
> pass in something unsupported it will give you back an error.
>

That sounds useful.

> It seems that isn't quite enough for the drm use case, so we might
> also need a way to query these features, but that really has to go
> through the usual dma layer abstraction as well and not hacked together
> in a driver based on an eduacted guestimate.

As far as I can tell, these drivers allocate DMA'able memory [in
ttm_tt_populate()] and subsequently create their own CPU mappings for
it, assuming that
a) the default is cache coherent, so vmap()ing those pages with
cacheable attributes works, and
b) telling the GPU to use NoSnoop attributes makes the accesses it
performs coherent with non-cacheable CPU mappings of those physical
pages

Since the latter is not true for many arm64 systems, I need this patch
to get a working system.

So how do you propose we proceed to get this fixed? Does it have to
wait for this proper core API plus followup changes for DRM?
