From: Lyude Paul <lyude@redhat.com>
Subject: Re: [PATCH] drm/radeon: Unbreak HPD handling for r600+
Date: Mon, 15 May 2017 10:19:57 -0400
Message-ID: <1494857997.14698.1.camel@redhat.com>
References: <20170511233112.15962-1-lyude@redhat.com>
         <70de5a62-1afa-b13b-d0d1-c3415ddbc788@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <70de5a62-1afa-b13b-d0d1-c3415ddbc788@amd.com>
Sender: stable-owner@vger.kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Mind giving me this a poke when this gets pushed upstream btw?

On Fri, 2017-05-12 at 08:56 +0200, Christian König wrote:
> Am 12.05.2017 um 01:31 schrieb Lyude:
> > We end up reading the interrupt register for HPD5, and then writing
> > it
> > to HPD6 which on systems without anything using HPD5 results in
> > permanently disabling hotplug on one of the display outputs after
> > the
> > first time we acknowledge a hotplug interrupt from the GPU.
> > 
> > This code is really bad. But for now, let's just fix this. I will
> > hopefully have a large patch series to refactor all of this soon.
> > 
> > Signed-off-by: Lyude <lyude@redhat.com>
> > Cc: stable@vger.kernel.org
> 
> Really nice catch! And yes I agree the copy&pasted code in HPD
> handling 
> always scared me as well.
> 
> Patch is Reviewed-by: Christian König <christian.koenig@amd.com>.
> 
> Christian.
> 
> > ---
> >   drivers/gpu/drm/radeon/cik.c       | 4 ++--
> >   drivers/gpu/drm/radeon/evergreen.c | 4 ++--
> >   drivers/gpu/drm/radeon/r600.c      | 2 +-
> >   drivers/gpu/drm/radeon/si.c        | 4 ++--
> >   4 files changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/radeon/cik.c
> > b/drivers/gpu/drm/radeon/cik.c
> > index 53710dd..cfc917c 100644
> > --- a/drivers/gpu/drm/radeon/cik.c
> > +++ b/drivers/gpu/drm/radeon/cik.c
> > @@ -7401,7 +7401,7 @@ static inline void cik_irq_ack(struct
> > radeon_device *rdev)
> >   		WREG32(DC_HPD5_INT_CONTROL, tmp);
> >   	}
> >   	if (rdev->irq.stat_regs.cik.disp_int_cont5 &
> > DC_HPD6_INTERRUPT) {
> > -		tmp = RREG32(DC_HPD5_INT_CONTROL);
> > +		tmp = RREG32(DC_HPD6_INT_CONTROL);
> >   		tmp |= DC_HPDx_INT_ACK;
> >   		WREG32(DC_HPD6_INT_CONTROL, tmp);
> >   	}
> > @@ -7431,7 +7431,7 @@ static inline void cik_irq_ack(struct
> > radeon_device *rdev)
> >   		WREG32(DC_HPD5_INT_CONTROL, tmp);
> >   	}
> >   	if (rdev->irq.stat_regs.cik.disp_int_cont5 &
> > DC_HPD6_RX_INTERRUPT) {
> > -		tmp = RREG32(DC_HPD5_INT_CONTROL);
> > +		tmp = RREG32(DC_HPD6_INT_CONTROL);
> >   		tmp |= DC_HPDx_RX_INT_ACK;
> >   		WREG32(DC_HPD6_INT_CONTROL, tmp);
> >   	}
> > diff --git a/drivers/gpu/drm/radeon/evergreen.c
> > b/drivers/gpu/drm/radeon/evergreen.c
> > index d1b1e0c..c48d19e 100644
> > --- a/drivers/gpu/drm/radeon/evergreen.c
> > +++ b/drivers/gpu/drm/radeon/evergreen.c
> > @@ -4933,7 +4933,7 @@ static void evergreen_irq_ack(struct
> > radeon_device *rdev)
> >   		WREG32(DC_HPD5_INT_CONTROL, tmp);
> >   	}
> >   	if (rdev->irq.stat_regs.evergreen.disp_int_cont5 &
> > DC_HPD6_INTERRUPT) {
> > -		tmp = RREG32(DC_HPD5_INT_CONTROL);
> > +		tmp = RREG32(DC_HPD6_INT_CONTROL);
> >   		tmp |= DC_HPDx_INT_ACK;
> >   		WREG32(DC_HPD6_INT_CONTROL, tmp);
> >   	}
> > @@ -4964,7 +4964,7 @@ static void evergreen_irq_ack(struct
> > radeon_device *rdev)
> >   		WREG32(DC_HPD5_INT_CONTROL, tmp);
> >   	}
> >   	if (rdev->irq.stat_regs.evergreen.disp_int_cont5 &
> > DC_HPD6_RX_INTERRUPT) {
> > -		tmp = RREG32(DC_HPD5_INT_CONTROL);
> > +		tmp = RREG32(DC_HPD6_INT_CONTROL);
> >   		tmp |= DC_HPDx_RX_INT_ACK;
> >   		WREG32(DC_HPD6_INT_CONTROL, tmp);
> >   	}
> > diff --git a/drivers/gpu/drm/radeon/r600.c
> > b/drivers/gpu/drm/radeon/r600.c
> > index 0a08517..e06e2d8 100644
> > --- a/drivers/gpu/drm/radeon/r600.c
> > +++ b/drivers/gpu/drm/radeon/r600.c
> > @@ -3988,7 +3988,7 @@ static void r600_irq_ack(struct radeon_device
> > *rdev)
> >   			WREG32(DC_HPD5_INT_CONTROL, tmp);
> >   		}
> >   		if (rdev->irq.stat_regs.r600.disp_int_cont2 &
> > DC_HPD6_INTERRUPT) {
> > -			tmp = RREG32(DC_HPD5_INT_CONTROL);
> > +			tmp = RREG32(DC_HPD6_INT_CONTROL);
> >   			tmp |= DC_HPDx_INT_ACK;
> >   			WREG32(DC_HPD6_INT_CONTROL, tmp);
> >   		}
> > diff --git a/drivers/gpu/drm/radeon/si.c
> > b/drivers/gpu/drm/radeon/si.c
> > index 528e5a4..bfeb774 100644
> > --- a/drivers/gpu/drm/radeon/si.c
> > +++ b/drivers/gpu/drm/radeon/si.c
> > @@ -6330,7 +6330,7 @@ static inline void si_irq_ack(struct
> > radeon_device *rdev)
> >   		WREG32(DC_HPD5_INT_CONTROL, tmp);
> >   	}
> >   	if (rdev->irq.stat_regs.evergreen.disp_int_cont5 &
> > DC_HPD6_INTERRUPT) {
> > -		tmp = RREG32(DC_HPD5_INT_CONTROL);
> > +		tmp = RREG32(DC_HPD6_INT_CONTROL);
> >   		tmp |= DC_HPDx_INT_ACK;
> >   		WREG32(DC_HPD6_INT_CONTROL, tmp);
> >   	}
> > @@ -6361,7 +6361,7 @@ static inline void si_irq_ack(struct
> > radeon_device *rdev)
> >   		WREG32(DC_HPD5_INT_CONTROL, tmp);
> >   	}
> >   	if (rdev->irq.stat_regs.evergreen.disp_int_cont5 &
> > DC_HPD6_RX_INTERRUPT) {
> > -		tmp = RREG32(DC_HPD5_INT_CONTROL);
> > +		tmp = RREG32(DC_HPD6_INT_CONTROL);
> >   		tmp |= DC_HPDx_RX_INT_ACK;
> >   		WREG32(DC_HPD6_INT_CONTROL, tmp);
> >   	}
> 
> 
