From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Mon, 21 Jan 2019 08:22:38 -0800
Message-ID: <20190121162238.GA17651@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>, David Zhou <David1.Zhou@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Michel Daenzer <michel.daenzer@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Junwei Zhang <Jerry.Zhang@amd.com>, Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jan 21, 2019 at 05:14:37PM +0100, Ard Biesheuvel wrote:
> > I'll add big fat comments.  But the fact that nothing is exported
> > there should be a fairly big hint.
> >
> 
> I don't follow. How do other header files 'export' things in a way
> that this header doesn't?

Well, I'll add comments to make it more obvious..

> As far as I can tell, these drivers allocate DMA'able memory [in
> ttm_tt_populate()] and subsequently create their own CPU mappings for
> it, assuming that
> a) the default is cache coherent, so vmap()ing those pages with
> cacheable attributes works, and

Yikes.  vmaping with different attributes is generally prone to
create problems on a lot of architectures.

> b) telling the GPU to use NoSnoop attributes makes the accesses it
> performs coherent with non-cacheable CPU mappings of those physical
> pages
> 
> Since the latter is not true for many arm64 systems, I need this patch
> to get a working system.

Do we know that this actually works anywhere but x86?

In general I would call these above sequence rather bogus and would
prefer we could get rid of such antipatterns in the kernel and just use
dma_alloc_attrs with DMA_ATTR_WRITECOMBINE if we want writecombine
semantics.

Until that happens we should just change the driver ifdefs to default
the hacks to off and only enable them on setups where we 100%
positively know that they actually work.  And document that fact
in big fat comments.
