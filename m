From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Mon, 21 Jan 2019 17:30:00 +0100
Message-ID: <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org> <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121162238.GA17651@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, David Zhou <David1.Zhou@amd.com>, Huang Rui <ray.huang@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>, Michel Daenzer <michel.daenzer@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 21, 2019 at 05:14:37PM +0100, Ard Biesheuvel wrote:
> > > I'll add big fat comments.  But the fact that nothing is exported
> > > there should be a fairly big hint.
> > >
> >
> > I don't follow. How do other header files 'export' things in a way
> > that this header doesn't?
>
> Well, I'll add comments to make it more obvious..
>
> > As far as I can tell, these drivers allocate DMA'able memory [in
> > ttm_tt_populate()] and subsequently create their own CPU mappings for
> > it, assuming that
> > a) the default is cache coherent, so vmap()ing those pages with
> > cacheable attributes works, and
>
> Yikes.  vmaping with different attributes is generally prone to
> create problems on a lot of architectures.
>

Indeed. But if your starting point is the assumption that DMA is
always cache coherent, those vmap() attributes are never different.

> > b) telling the GPU to use NoSnoop attributes makes the accesses it
> > performs coherent with non-cacheable CPU mappings of those physical
> > pages
> >
> > Since the latter is not true for many arm64 systems, I need this patch
> > to get a working system.
>
> Do we know that this actually works anywhere but x86?
>

In theory, it could work on arm64 systems with stage2-only SMMUs and
correctly configured PCIe RCs that set the right AMBA attributes for
inbound transactions with the NoSnoop attributes set.

Unfortunately, it seems that the current SMMU ARM code will clobber
those AMBA attributes when it uses stage1 mappings, since it forces
the memory attributes to WBWA for cache coherent devices.

So, as I pointed out in the commit log, the main difference between
x86 and other arches it that it can easily tolerate when NoSnoop is
non-functional.

> In general I would call these above sequence rather bogus and would
> prefer we could get rid of such antipatterns in the kernel and just use
> dma_alloc_attrs with DMA_ATTR_WRITECOMBINE if we want writecombine
> semantics.
>

Agreed.

> Until that happens we should just change the driver ifdefs to default
> the hacks to off and only enable them on setups where we 100%
> positively know that they actually work.  And document that fact
> in big fat comments.

Well, as I mentioned in my commit log as well, if we default to off
unless CONFIG_X86, we may break working setups on MIPS and Power where
the device is in fact non-cache coherent, and relies on this
'optimization' to get things working. The same could be true for
non-coherent ARM systems, hence my approach to disable this hack for
cache coherent devices on non-X86 only.
