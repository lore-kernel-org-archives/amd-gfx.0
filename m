From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Mon, 21 Jan 2019 20:18:51 +0100
Message-ID: <CAKv+Gu-gaZpKqyLt9Vft2e_zS4Xkc9+8HAYoHvuBo5C0hqL2Qw@mail.gmail.com>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org> <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org> <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <59ccf85d-b99d-b5c8-ea87-66c2a892e197@daenzer.net> <CAKv+Gu8OkbHwY5UBxahpQpM_gKh2331pQ6o-4YyJdLurbFNHvw@mail.gmail.com>
 <ccc775d3-3053-ab79-dac8-4feb28e8e690@daenzer.net> <CAKv+Gu-9VKL5RjScbKss4YfH1Cb8WbXmzU_0UsStnoXJcML7Rg@mail.gmail.com>
 <850b6aee-0040-c333-b125-45211c18ada5@daenzer.net> <CAKv+Gu99zHqcQtj6TiOXAr3Qa6WWhKem+DHVA_mAQ0-Bc0Vbqw@mail.gmail.com>
 <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <047667fd-17be-1c37-5d2a-26768cfd6ab8@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
Cc: Christoph Hellwig <hch@infradead.org>, Will Deacon <will.deacon@arm.com>, David Zhou <David1.Zhou@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>, Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, 21 Jan 2019 at 20:04, Michel D=C3=A4nzer <michel@daenzer.net> wrote=
:
>
> On 2019-01-21 7:28 p.m., Ard Biesheuvel wrote:
> > On Mon, 21 Jan 2019 at 19:24, Michel D=C3=A4nzer <michel@daenzer.net> w=
rote:
> >> On 2019-01-21 7:20 p.m., Ard Biesheuvel wrote:
> >>> On Mon, 21 Jan 2019 at 19:04, Michel D=C3=A4nzer <michel@daenzer.net>=
 wrote:
> >>>> On 2019-01-21 6:59 p.m., Ard Biesheuvel wrote:
> >>>>> On Mon, 21 Jan 2019 at 18:55, Michel D=C3=A4nzer <michel@daenzer.ne=
t> wrote:
> >>>>>> On 2019-01-21 5:30 p.m., Ard Biesheuvel wrote:
> >>>>>>> On Mon, 21 Jan 2019 at 17:22, Christoph Hellwig <hch@infradead.or=
g> wrote:
> >>>>>>>
> >>>>>>>> Until that happens we should just change the driver ifdefs to de=
fault
> >>>>>>>> the hacks to off and only enable them on setups where we 100%
> >>>>>>>> positively know that they actually work.  And document that fact
> >>>>>>>> in big fat comments.
> >>>>>>>
> >>>>>>> Well, as I mentioned in my commit log as well, if we default to o=
ff
> >>>>>>> unless CONFIG_X86, we may break working setups on MIPS and Power =
where
> >>>>>>> the device is in fact non-cache coherent, and relies on this
> >>>>>>> 'optimization' to get things working.
> >>>>>>
> >>>>>> FWIW, the amdgpu driver doesn't rely on non-snooped transfers for
> >>>>>> correct basic operation (the scenario Christian brought up is a ve=
ry
> >>>>>> specialized use-case), so that shouldn't be an issue.
> >>>>>
> >>>>> The point is that this is only true for x86.
> >>>>>
> >>>>> On other architectures, the use of non-cached mappings on the CPU s=
ide
> >>>>> means that you /do/ rely on non-snooped transfers, since if those
> >>>>> transfers turn out not to snoop inadvertently, the accesses are
> >>>>> incoherent with the CPU's view of memory.
> >>>>
> >>>> The driver generally only uses non-cached mappings if
> >>>> drm_arch/device_can_wc_memory returns true.
> >>>
> >>> Indeed. And so we should take care to only return 'true' from that
> >>> function if it is guaranteed that non-cached CPU mappings are coheren=
t
> >>> with the mappings used by the GPU, either because that is always the
> >>> case (like on x86), or because we know that the platform in question
> >>> implements NoSnoop correctly throughout the interconnect.
> >>>
> >>> What seems to be complicating matters is that in some cases, the
> >>> device is non-cache coherent to begin with, so regardless of whether
> >>> the NoSnoop attribute is used or not, those accesses will not snoop i=
n
> >>> the caches and be coherent with the non-cached mappings used by the
> >>> CPU. So if we restrict this optimization [on non-X86] to platforms
> >>> that are known to implement NoSnoop correctly, we may break platforms
> >>> that are implicitly NoSnoop all the time.
> >>
> >> Since the driver generally doesn't rely on non-snooped accesses for
> >> correctness, that couldn't "break" anything that hasn't always been br=
oken.
> >
> > Again, that is only true on x86.
> >
> > On other architectures, DMA writes from the device may allocate in the
> > caches, and be invisible to the CPU when it uses non-cached mappings.
>
> Let me try one last time:
>

I could say the same :-)

> If drm_arch_can_wc_memory returns false, the driver falls back to the
> normal mode of operation, using a cacheable CPU mapping and snooped GPU
> transfers, even if userspace asks (as a performance optimization) for a
> write-combined CPU mapping and non-snooped GPU transfers via
> AMDGPU_GEM_CREATE_CPU_GTT_USWC.

I am not talking about the case where drm_arch_can_wc_memory() returns fals=
e.

I am talking about the case where it returns true, which is currently
the default for all architectures, except Power and MIPS in some
cases.

This mode of operation breaks my cache coherent arm64 system. (AMD Seattle)
With this patch applied, everything works fine.

> This normal mode of operation is also
> used for the ring buffers at the heart of the driver's operation.

But is it really the same mode of operation? Does it also vmap() the
pages? Or does it use the DMA API to allocate the ring buffers?
Because in the latter case, this will give you non-cached CPU mappings
as well if the device is non-cache coherent.

> If
> there is a platform where this normal mode of operation doesn't work,
> the driver could never have worked reliably on that platform, since
> before AMDGPU_GEM_CREATE_CPU_GTT_USWC or drm_arch_can_wc_memory even
> existed.
>

As I said, I am talking about the case where drm_arch_can_wc_memory()
returns true on a cache coherent system. This relies on NoSnoop being
implemented correctly in the platform, or a CPU architecture that
snoops the caches when doing uncached memory accesses (such as x86)
