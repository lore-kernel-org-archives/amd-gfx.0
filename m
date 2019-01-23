From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Tue, 22 Jan 2019 23:15:21 -0800
Message-ID: <20190123071521.GB20526@infradead.org>
References: <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net>
 <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Maxime Ripard <maxime.ripard@bootlin.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Michael Ellerman <mpe@ellerman.id.au>, Junwei Zhang <Jerry.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jan 22, 2019 at 10:07:07PM +0100, Ard Biesheuvel wrote:
> Yes, so much was clear. And the reason this breaks on some arm64
> systems is because
> a) non-snooped PCIe TLP attributes may be ignored, and
> b) non-x86 CPUs do not snoop the caches when accessing uncached mappings.
> 
> I don't think there is actually any disagreement on this part. And I
> think my patch is reasonable, only Christoph is objecting to it on the
> grounds that drivers should not go around the DMA API and create
> vmap()s of DMA pages with self chosen attributes.

I object to it on various grounds.  While the above is correct it really
is a mid to long-term fix.

But even in the short term your patch just maintains a random list of
idefs in a random driver, pokes into the dma-mapping internals and lacks
any comments in the code explaining on what is going on, leading to
futher cargo culting.  So it very clearly is not acceptable.
