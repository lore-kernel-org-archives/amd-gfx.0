From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Thu, 24 Jan 2019 10:59:13 +0100
Message-ID: <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net> <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org> <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org> <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org> <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
 <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com> <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Christoph Hellwig <hch@infradead.org>, Alex Deucher <alexdeucher@gmail.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, Maxime Ripard <maxime.ripard@bootlin.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, "Huang, Ray" <Ray.Huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Michael Ellerman <mpe@ellerman.id.au>, "Zhang, Jerry" <Jerry.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, 24 Jan 2019 at 10:45, Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 24.01.19 um 10:28 schrieb Ard Biesheuvel:
> > On Thu, 24 Jan 2019 at 10:25, Koenig, Christian
> > <Christian.Koenig@amd.com> wrote:
> >> Am 24.01.19 um 10:13 schrieb Christoph Hellwig:
> >>> On Wed, Jan 23, 2019 at 05:52:50PM +0100, Ard Biesheuvel wrote:
> >>>> But my concern is that it seems likely that non-cache coherent
> >>>> implementations are relying on this hack as well. There must be a
> >>>> reason that this hack is only disabled for PowerPC platforms if they
> >>>> are cache coherent, for instance, and I suspect that that reason is
> >>>> that the hack is the only thing ensuring that the CPU mapping
> >>>> attributes match the device ones used for these buffers (the vmap()ed
> >>>> ones), whereas the rings and other consistent data structures are
> >>>> using the DMA API as intended, and thus getting uncached attributes in
> >>>> the correct way.
> >>> Dave, who added that commit is on Cc together with just about everyone
> >>> involved in the review chain.  Based on the previous explanation
> >>> that idea what we might want an uncached mapping for some non-coherent
> >>> architectures for this to work at all makes sense, but then again
> >>> the way to create those mappings is entirely architecture specific,
> >>> and also need a cache flushing before creating the mapping to work
> >>> properly.  So my working theory is that this code never properly
> >>> worked on architectures without DMA coherent for PCIe at all, but
> >>> I'd love to be corrected by concrete examples including an explanation
> >>> of how it actually ends up working.
> >> Cache coherency is mandatory for modern GPU operation.
> >>
> >> Otherwise you can't implement a bunch of the requirements of the
> >> userspace APIs.
> >>
> >> In other words the applications doesn't inform the driver that the GPU
> >> or the CPU is accessing data, it just does it and assumes that it works.
> >>
> > Wonderful!
> >
> > In that case, do you have any objections to the patch proposed by
> > Christoph above?
>
> Yeah, the patch of Christoph actually goes way to far cause we have
> reports that this works on a bunch of other architectures.
>
> E.g. X86 64bit, PowerPC (under some conditions) and some MIPS.
>

This is *exactly* my point the whole time.

The current code has

static inline bool drm_arch_can_wc_memory(void)
{
#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
   return false;

which means the optimization is disabled *unless the system is
non-cache coherent*

So if you have reports that the optimization works on some PowerPC, it
must be non-cache coherent PowerPC, because that is the only place
where it is enabled in the first place.

> The only problematic here actually seems to be ARM, so you should
> probably just add an "#ifdef .._ARM return false;".
>

ARM/arm64 does not have a Kconfig symbol like
CONFIG_NOT_COHERENT_CACHE, so we can only disable it everywhere. If
there are non-coherent ARM systems that are currently working in the
same way as those non-coherent PowerPC systems, we will break them by
doing this.
