From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] drm: enable uncached DMA optimization for ARM and arm64
Date: Thu, 24 Jan 2019 13:32:15 +0100
Message-ID: <CAKv+Gu9OG3O4+4F2nioaQ-3U-1kwRBr5KVj-1gD1ZEsUx_Ud5A@mail.gmail.com>
References: <20190124120658.30288-1-ard.biesheuvel@linaro.org> <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3cca35a9-c71c-a100-b29d-31ba0d1d10b1@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Zhang, Jerry" <Jerry.Zhang@amd.com>, "Daenzer, Michel" <Michel.Daenzer@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>, Christoph Hellwig <hch@infradead.org>, Robin Murphy <robin.murphy@arm.com>am
List-Id: amd-gfx.lists.freedesktop.org

On Thu, 24 Jan 2019 at 13:31, Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 24.01.19 um 13:06 schrieb Ard Biesheuvel:
> > The DRM driver stack is designed to work with cache coherent devices
> > only, but permits an optimization to be enabled in some cases, where
> > for some buffers, both the CPU and the GPU use uncached mappings,
> > removing the need for DMA snooping and allocation in the CPU caches.
> >
> > The use of uncached GPU mappings relies on the correct implementation
> > of the PCIe NoSnoop TLP attribute by the platform, otherwise the GPU
> > will use cached mappings nonetheless. On x86 platforms, this does not
> > seem to matter, as uncached CPU mappings will snoop the caches in any
> > case. However, on ARM and arm64, enabling this optimization on a
> > platform where NoSnoop is ignored results in loss of coherency, which
> > breaks correct operation of the device. Since we have no way of
> > detecting whether NoSnoop works or not, just disable this
> > optimization entirely for ARM and arm64.
> >
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: David Zhou <David1.Zhou@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Junwei Zhang <Jerry.Zhang@amd.com>
> > Cc: Michel Daenzer <michel.daenzer@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> > Cc: Sean Paul <sean@poorly.run>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
> > Cc: dri-devel <dri-devel@lists.freedesktop.org>
> > Reported-by: Carsten Haitzler <Carsten.Haitzler@arm.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> The subject line should probably read "disable uncached...".
>

Ugh, of course ...

> With that fixed the patch is Reviewed-by: Christian K=C3=B6nig
> <christian.koenig@amd.com>.
>

Thanks.
