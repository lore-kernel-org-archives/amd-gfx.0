From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Wed, 23 Jan 2019 10:08:22 +0100
Message-ID: <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
References: <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
 <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net> <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net> <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net> <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com> <20190123071521.GB20526@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190123071521.GB20526@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, Maxime Ripard <maxime.ripard@bootlin.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Michael Ellerman <mpe@ellerman.id.au>, Junwei Zhang <Jerry.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, 23 Jan 2019 at 08:15, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Jan 22, 2019 at 10:07:07PM +0100, Ard Biesheuvel wrote:
> > Yes, so much was clear. And the reason this breaks on some arm64
> > systems is because
> > a) non-snooped PCIe TLP attributes may be ignored, and
> > b) non-x86 CPUs do not snoop the caches when accessing uncached mappings.
> >
> > I don't think there is actually any disagreement on this part. And I
> > think my patch is reasonable, only Christoph is objecting to it on the
> > grounds that drivers should not go around the DMA API and create
> > vmap()s of DMA pages with self chosen attributes.
>
> I object to it on various grounds.  While the above is correct it really
> is a mid to long-term fix.
>
> But even in the short term your patch just maintains a random list of
> idefs in a random driver, pokes into the dma-mapping internals and lacks
> any comments in the code explaining on what is going on, leading to
> futher cargo culting.  So it very clearly is not acceptable.

Fair enough. It would be helpful, though, if you could give more
guidance on what you do find acceptable. You haven't answered my
question on whether you think drivers should be allowed to reason at
all about the device's cache coherence.

In any case, I think we (you and I) could easily agree on the correct fix being:
- introduce DMA_ATTR_NOSNOOP
- implement it as a no-op for non-cache coherent devices (since
nosnoop is implied)
- permit non-x86 architectures to override/ignore it if not supported
- rip out all the explicit vmap()/kmap()s of DMA pages from the DRM
drivers, and instead, set the DMA_ATTR_NOSNOOP attribute where
desired, and always use the mappings provided by the DMA API.

The problem is that we will need the DRM/radeon/amdgpu maintainers on
board with this, and until this happens, I am stuck in the middle with
a broken arm64 system.

So, given the above, what /would/ you find acceptable?
