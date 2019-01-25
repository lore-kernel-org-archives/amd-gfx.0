From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
Date: Fri, 25 Jan 2019 12:35:15 +0100
Message-ID: <CAKv+Gu_faPAf+0NBTNM03EUH4-_0vWbPfDQneshps5vbaU4R_Q@mail.gmail.com>
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com> <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
 <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
 <CAKv+Gu-Yk1iEe+cF30ee7R+hcrke9XH9MdTeERA2P-0s2QpaLw@mail.gmail.com> <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <961e758d-b0a0-8f6c-a8fa-c3047e058706@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Daenzer, Michel" <Michel.Daenzer@amd.com>, Carsten Haitzler <Carsten.Haitzler@arm.com>, Maxime Ripard <maxime.ripard@bootlin.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, "Zhang, Jerry" <Jerry.Zhang@amd.com>, Christoph Hellwig <hch@infradead.org>, David Airlie <airlied@linux.ie>, "Huang, Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Michael Ellerman <mpe@ellerman.id.au>, Will Deacon <will.deacon@arm.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, Sean Paul <sean@poorly.run>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, 25 Jan 2019 at 12:30, Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 25.01.19 um 09:43 schrieb Ard Biesheuvel:
> > On Thu, 24 Jan 2019 at 15:01, Alex Deucher <alexdeucher@gmail.com> wrot=
e:
> >> On Thu, Jan 24, 2019 at 9:00 AM Ard Biesheuvel
> >> <ard.biesheuvel@linaro.org> wrote:
> >>> On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
> >>> <Christian.Koenig@amd.com> wrote:
> >>>> Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
> >>>>> The DRM driver stack is designed to work with cache coherent device=
s
> >>>>> only, but permits an optimization to be enabled in some cases, wher=
e
> >>>>> for some buffers, both the CPU and the GPU use uncached mappings,
> >>>>> removing the need for DMA snooping and allocation in the CPU caches=
.
> >>>>>
> >>>>> The use of uncached GPU mappings relies on the correct implementati=
on
> >>>>> of the PCIe NoSnoop TLP attribute by the platform, otherwise the GP=
U
> >>>>> will use cached mappings nonetheless. On x86 platforms, this does n=
ot
> >>>>> seem to matter, as uncached CPU mappings will snoop the caches in a=
ny
> >>>>> case. However, on ARM and arm64, enabling this optimization on a
> >>>>> platform where NoSnoop is ignored results in loss of coherency, whi=
ch
> >>>>> breaks correct operation of the device. Since we have no way of
> >>>>> detecting whether NoSnoop works or not, just disable this
> >>>>> optimization entirely for ARM and arm64.
> >>>>>
> >>>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>>> Cc: David Zhou <David1.Zhou@amd.com>
> >>>>> Cc: Huang Rui <ray.huang@amd.com>
> >>>>> Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> >>>>> Cc: Michel Daenzer <michel.daenzer@amd.com>
> >>>>> Cc: David Airlie <airlied@linux.ie>
> >>>>> Cc: Daniel Vetter <daniel@ffwll.ch>
> >>>>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >>>>> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> >>>>> Cc: Sean Paul <sean@poorly.run>
> >>>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
> >>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>>>> Cc: Will Deacon <will.deacon@arm.com>
> >>>>> Cc: Christoph Hellwig <hch@infradead.org>
> >>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>>>> Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> >>>>> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> >>>>> Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> >>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >>>> The subject line should probably read "disable uncached...".
> >>>>
> >>> Ugh, of course ...
> >>>
> >>>> With that fixed the patch is Reviewed-by: Christian K=C3=B6nig
> >>>> <christian.koenig@amd.com>.
> >>>>
> >> Same:
> >> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> >>
> > Thanks all
> >
> > Should I resend the patch with the subject corrected?
>
> I will update the subject line and push it upstream through
> drm-misc-next if nobody objects.
>

Wonderful, thanks.
