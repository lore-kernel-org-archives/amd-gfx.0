From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Thu, 24 Jan 2019 01:13:16 -0800
Message-ID: <20190124091316.GA22796@infradead.org>
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
 <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org>
 <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org>
 <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Christoph Hellwig <hch@infradead.org>, Alex Deucher <alexdeucher@gmail.com>, Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Maxime Ripard <maxime.ripard@bootlin.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Michael Ellerman <mpe@ellerman.id.au>, Junwei Zhang <Jerry.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Jan 23, 2019 at 05:52:50PM +0100, Ard Biesheuvel wrote:
> But my concern is that it seems likely that non-cache coherent
> implementations are relying on this hack as well. There must be a
> reason that this hack is only disabled for PowerPC platforms if they
> are cache coherent, for instance, and I suspect that that reason is
> that the hack is the only thing ensuring that the CPU mapping
> attributes match the device ones used for these buffers (the vmap()ed
> ones), whereas the rings and other consistent data structures are
> using the DMA API as intended, and thus getting uncached attributes in
> the correct way.

Dave, who added that commit is on Cc together with just about everyone
involved in the review chain.  Based on the previous explanation
that idea what we might want an uncached mapping for some non-coherent
architectures for this to work at all makes sense, but then again
the way to create those mappings is entirely architecture specific,
and also need a cache flushing before creating the mapping to work
properly.  So my working theory is that this code never properly
worked on architectures without DMA coherent for PCIe at all, but
I'd love to be corrected by concrete examples including an explanation
of how it actually ends up working.
