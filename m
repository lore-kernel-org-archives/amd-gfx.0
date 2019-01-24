From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Thu, 24 Jan 2019 10:37:14 +0100
Message-ID: <CAKv+Gu-6=kUd_OYoe4TpFSUXHqC4etxH98mAN_gkHKvS1=1BGA@mail.gmail.com>
References: <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net>
 <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net> <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net> <CAKv+Gu_VBd8agHASc5RS0eCgyXP64Lt_i4yPuBjKwGQ+5Lpd5Q@mail.gmail.com>
 <CADnq5_O1uxCrSksfF127AZTfbmdukxmqGdh2Ee0zM6CqgG_Mhg@mail.gmail.com>
 <CAKv+Gu-4uYh_HD_5Ry_L80Nf5zpRhT4oJYhhG5_8g3gSzBs2tg@mail.gmail.com>
 <20190123071521.GB20526@infradead.org> <CAKv+Gu8+77uZHJ6ZYjGNcKQL8C3cT5Ree+TcTVmkQXAHV-ADyg@mail.gmail.com>
 <20190123164428.GA9367@infradead.org> <CAKv+Gu-9vEKu8mG-o+-4M1ZcgZmTTJVfEdNS9R27AFX8P5sqyQ@mail.gmail.com>
 <ee261b46-1a83-6af2-31fe-fb9f30894c1e@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ee261b46-1a83-6af2-31fe-fb9f30894c1e@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Christoph Hellwig <hch@infradead.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Junwei Zhang <Jerry.Zhang@amd.com>, David Airlie <airlied@linux.ie>, Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, 24 Jan 2019 at 10:31, Michel D=C3=A4nzer <michel@daenzer.net> wrote=
:
>
> On 2019-01-23 5:52 p.m., Ard Biesheuvel wrote:
> > On Wed, 23 Jan 2019 at 17:44, Christoph Hellwig <hch@infradead.org> wro=
te:
> >>
> >> I think we just want a driver-local check for those combinations
> >> where we know this hack actually works, which really just seems
> >> to be x86-64 with PAT. Something like the patch below, but maybe with
> >> even more strong warnings to not do something like this elsewhere:
> >
> > I agree that your patch seems like the right way to ensure that the WC
> > optimization hack is only used where we know it works.
> >
> > But my concern is that it seems likely that non-cache coherent
> > implementations are relying on this hack as well.
>
> I've been trying to tell you they can't rely on that, because the amdgpu
> driver doesn't use this functionality for fundamentals such as ring
> buffers used for feeding the hardware with commands. Instead, for those
> it relies on snooped PCIe transfers being coherent with the CPU caches.
>

I understand it does not use this functionality for the ring. Instead,
it uses the DMA API, no?

On non-cache coherent systems, that DMA API will allocate memory and
map it uncached for the CPU so that it is coherent with the non-cache
coherent device.

In any case, if non-cache coherent systems are unlikely to work, and
unsupported in case they do, I am fine with disabling this
optimization unconditionally for non-X86 architectures.

>
> >> -#elif defined(CONFIG_X86) && !defined(CONFIG_X86_PAT)
> >> -       /* Don't try to enable write-combining when it can't work, or =
things
> >> -        * may be slow
> >> -        * See https://bugs.freedesktop.org/show_bug.cgi?id=3D88758
> >> -        */
> >> -
> >> -#ifndef CONFIG_COMPILE_TEST
> >> -#warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better perf=
ormance \
> >> -        thanks to write-combining
> >> -#endif
> >> -
> >> -       if (bo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
> >> -               DRM_INFO_ONCE("Please enable CONFIG_MTRR and CONFIG_X8=
6_PAT for "
> >> -                             "better performance thanks to write-comb=
ining\n");
>
> FWIW, please don't drop these compile and build time warnings where we
> continue to take advantage of PAT.
>
>
> --
> Earthling Michel D=C3=A4nzer               |               http://www.amd=
.com
> Libre software enthusiast             |             Mesa and X developer
