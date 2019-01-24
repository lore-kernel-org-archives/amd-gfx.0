From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Thu, 24 Jan 2019 08:54:19 -0500
Message-ID: <CADnq5_PCCj1dgYTnJoWdFp45X8GMwdT34sMtWH7p6Ms1_SncOQ@mail.gmail.com>
References: <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net>
 <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net> <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org> <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org> <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <20190124091316.GA22796@infradead.org> <bb559f74-4b1e-d5ee-74fb-b5dcd4a128cb@amd.com>
 <CAKv+Gu_3LurSN-6w1WijPfpJpc+Pgu0YTnwTfMrXMF3-AKAnJA@mail.gmail.com>
 <953e5e5f-5d47-d6df-40df-c8c94db5447f@amd.com> <CAKv+Gu9umPEmB+wh54NOTYcQ14oxf7rwVAXgCqo7V2A+VwkqPA@mail.gmail.com>
 <57590a48-4629-e2a1-8673-ce9eb2ec210b@amd.com> <CAKv+Gu_2f0FaJ+Th7H48u4GrPX=MM9xw0fFjdwhfRrr1nhgEkA@mail.gmail.com>
 <40ad3ae7-9970-0cb9-d35c-05e128f83820@amd.com> <CAKv+Gu_D4FC05Rz3Oxm_dTWLaGt+a3EDecbsrge1eHY7gFXEYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu_D4FC05Rz3Oxm_dTWLaGt+a3EDecbsrge1eHY7gFXEYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, Christoph Hellwig <hch@infradead.org>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>, Maxime Ripard <maxime.ripard@bootlin.com>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, "Huang, Ray" <Ray.Huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Michael Ellerman <mpe@ellerman.id.au>, "Zhang, Jerry" <Jerry.Zhang@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jan 24, 2019 at 6:45 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 24 Jan 2019 at 12:37, Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
> >
> > Am 24.01.19 um 12:26 schrieb Ard Biesheuvel:
> > > On Thu, 24 Jan 2019 at 12:23, Koenig, Christian
> > > <Christian.Koenig@amd.com> wrote:
> > >> Am 24.01.19 um 10:59 schrieb Ard Biesheuvel:
> > >>> [SNIP]
> > >>> This is *exactly* my point the whole time.
> > >>>
> > >>> The current code has
> > >>>
> > >>> static inline bool drm_arch_can_wc_memory(void)
> > >>> {
> > >>> #if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
> > >>>      return false;
> > >>>
> > >>> which means the optimization is disabled *unless the system is
> > >>> non-cache coherent*
> > >>>
> > >>> So if you have reports that the optimization works on some PowerPC, it
> > >>> must be non-cache coherent PowerPC, because that is the only place
> > >>> where it is enabled in the first place.
> > >>>
> > >>>> The only problematic here actually seems to be ARM, so you should
> > >>>> probably just add an "#ifdef .._ARM return false;".
> > >>>>
> > >>> ARM/arm64 does not have a Kconfig symbol like
> > >>> CONFIG_NOT_COHERENT_CACHE, so we can only disable it everywhere. If
> > >>> there are non-coherent ARM systems that are currently working in the
> > >>> same way as those non-coherent PowerPC systems, we will break them by
> > >>> doing this.
> > >> Summing the things I've read so far for ARM up I actually think it
> > >> depends on a runtime configuration and not on compile time one.
> > >>
> > >> So the whole idea of providing the device to the drm_*_can_wc_memory()
> > >> function isn't so far fetched.
> > >>
> > > Thank you.
> > >
> > >> But for now I do prefer working and slightly slower system over broken
> > >> one, so I think we should just disable this on ARM for now.
> > >>
> > > Again, this is not about non-cache coherent being slower without the
> > > optimization, it is about non-cache coherent likely not working *at
> > > all* unless the optimization is enabled.
> >
> > As Michel tried to explain this CAN'T happen. The optimization is a
> > purely optional request from userspace.
> >
>
> Right.
>
> So in that case, we can assume that the following test
>
> static inline bool drm_arch_can_wc_memory(void)
> {
> #if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
>     return false;
>
> is bogus, and it was just unnecessary caution on the part of the
> author to disregard non-cache coherent devices.
> Unfortunately, those commits have no log messages whatsoever, so it is
> difficult to infer the intent retroactively.
>
> > > Otherwise, the driver will vmap() DMA pages with cacheable attributes,
> > > while the non-cache coherent device uses uncached attributes, breaking
> > > coherency.
> >
> > Again this is mandated by the userspace APIs anyway. E.g. we can't
> > vmap() pages in any other way or our userspace APIs would break.
> >
>
> OK,
>
> So let's just disable this for all ARM and arm64 then, given that
> non-cache coherent is not supported in any case

So I think we are back to this patch:
https://patchwork.kernel.org/patch/10739023/

Alex
