From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 1/4] drm/radeon: handle PCIe root ports with addressing limitations
Date: Thu, 15 Aug 2019 10:15:48 -0400
Message-ID: <CADnq5_NghUyn1K7ed6E_vk-8SgLXKj3QpriGRxbNDChdb0hU5Q@mail.gmail.com>
References: <20190815072703.7010-1-hch@lst.de> <20190815072703.7010-2-hch@lst.de>
 <d1cf1435-92e3-edb5-c239-18c71f2d27c7@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d1cf1435-92e3-edb5-c239-18c71f2d27c7@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: Christoph Hellwig <hch@lst.de>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Aug 15, 2019 at 4:34 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Am 15.08.19 um 09:27 schrieb Christoph Hellwig:
> > radeon uses a need_dma32 flag to indicate to the drm core that some
> > allocations need to be done using GFP_DMA32, but it only checks the
> > device addressing capabilities to make that decision.  Unfortunately
> > PCIe root ports that have limited addressing exist as well.  Use the
> > dma_addressing_limited instead to also take those into account.
> >
> > Reported-by: Atish Patra <Atish.Patra@wdc.com>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>
> Looks sane to me. Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd=
.com>.

Is this for the full series or just this patch?

Alex

>
> Should we merge this through our normal amdgpu/radeon branches or do you
> want to send this upstream somehow else?
>
> Thanks,
> Christian.
>
> > ---
> >   drivers/gpu/drm/radeon/radeon.h        |  1 -
> >   drivers/gpu/drm/radeon/radeon_device.c | 12 +++++-------
> >   drivers/gpu/drm/radeon/radeon_ttm.c    |  2 +-
> >   3 files changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/r=
adeon.h
> > index 32808e50be12..1a0b22526a75 100644
> > --- a/drivers/gpu/drm/radeon/radeon.h
> > +++ b/drivers/gpu/drm/radeon/radeon.h
> > @@ -2387,7 +2387,6 @@ struct radeon_device {
> >       struct radeon_wb                wb;
> >       struct radeon_dummy_page        dummy_page;
> >       bool                            shutdown;
> > -     bool                            need_dma32;
> >       bool                            need_swiotlb;
> >       bool                            accel_working;
> >       bool                            fastfb_working; /* IGP feature*/
> > diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/r=
adeon/radeon_device.c
> > index dceb554e5674..b8cc05826667 100644
> > --- a/drivers/gpu/drm/radeon/radeon_device.c
> > +++ b/drivers/gpu/drm/radeon/radeon_device.c
> > @@ -1365,27 +1365,25 @@ int radeon_device_init(struct radeon_device *rd=
ev,
> >       else
> >               rdev->mc.mc_mask =3D 0xffffffffULL; /* 32 bit MC */
> >
> > -     /* set DMA mask + need_dma32 flags.
> > +     /* set DMA mask.
> >        * PCIE - can handle 40-bits.
> >        * IGP - can handle 40-bits
> >        * AGP - generally dma32 is safest
> >        * PCI - dma32 for legacy pci gart, 40 bits on newer asics
> >        */
> > -     rdev->need_dma32 =3D false;
> > +     dma_bits =3D 40;
> >       if (rdev->flags & RADEON_IS_AGP)
> > -             rdev->need_dma32 =3D true;
> > +             dma_bits =3D 32;
> >       if ((rdev->flags & RADEON_IS_PCI) &&
> >           (rdev->family <=3D CHIP_RS740))
> > -             rdev->need_dma32 =3D true;
> > +             dma_bits =3D 32;
> >   #ifdef CONFIG_PPC64
> >       if (rdev->family =3D=3D CHIP_CEDAR)
> > -             rdev->need_dma32 =3D true;
> > +             dma_bits =3D 32;
> >   #endif
> >
> > -     dma_bits =3D rdev->need_dma32 ? 32 : 40;
> >       r =3D pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
> >       if (r) {
> > -             rdev->need_dma32 =3D true;
> >               dma_bits =3D 32;
> >               pr_warn("radeon: No suitable DMA available\n");
> >       }
> > diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/rade=
on/radeon_ttm.c
> > index fb3696bc616d..116a27b25dc4 100644
> > --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> > +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> > @@ -794,7 +794,7 @@ int radeon_ttm_init(struct radeon_device *rdev)
> >       r =3D ttm_bo_device_init(&rdev->mman.bdev,
> >                              &radeon_bo_driver,
> >                              rdev->ddev->anon_inode->i_mapping,
> > -                            rdev->need_dma32);
> > +                            dma_addressing_limited(&rdev->pdev->dev));
> >       if (r) {
> >               DRM_ERROR("failed initializing buffer object driver(%d).\=
n", r);
> >               return r;
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
