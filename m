From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
Date: Thu, 24 Jan 2019 09:01:37 -0500
Message-ID: <CADnq5_PETD6umm9Df7OZ9BdaV5MZutmhN+HTAnVkcRLg5=TNWw@mail.gmail.com>
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org>
 <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com> <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Carsten Haitzler <Carsten.Haitzler@arm.com>, David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, dri-devel <dri-devel@lists.freedesktop.org>, "Daenzer, Michel" <Michel.Daenzer@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Christoph Hellwig <hch@infradead.org>, "Zhang, Jerry" <Jerry.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jan 24, 2019 at 9:00 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
> >
> > Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
> > > The DRM driver stack is designed to work with cache coherent devices
> > > only, but permits an optimization to be enabled in some cases, where
> > > for some buffers, both the CPU and the GPU use uncached mappings,
> > > removing the need for DMA snooping and allocation in the CPU caches.
> > >
> > > The use of uncached GPU mappings relies on the correct implementation
> > > of the PCIe NoSnoop TLP attribute by the platform, otherwise the GPU
> > > will use cached mappings nonetheless. On x86 platforms, this does not
> > > seem to matter, as uncached CPU mappings will snoop the caches in any
> > > case. However, on ARM and arm64, enabling this optimization on a
> > > platform where NoSnoop is ignored results in loss of coherency, which
> > > breaks correct operation of the device. Since we have no way of
> > > detecting whether NoSnoop works or not, just disable this
> > > optimization entirely for ARM and arm64.
> > >
> > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > Cc: Alex Deucher <alexander.deucher@amd.com>
> > > Cc: David Zhou <David1.Zhou@amd.com>
> > > Cc: Huang Rui <ray.huang@amd.com>
> > > Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> > > Cc: Michel Daenzer <michel.daenzer@amd.com>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > > Cc: Sean Paul <sean@poorly.run>
> > > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Christoph Hellwig <hch@infradead.org>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > > Cc: dri-devel <dri-devel@lists.freedesktop.org>
> > > Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> > > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > The subject line should probably read "disable uncached...".
> >
>
> Ugh, of course ...
>
> > With that fixed the patch is Reviewed-by: Christian K=C3=B6nig
> > <christian.koenig@amd.com>.
> >

Same:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Thanks.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
