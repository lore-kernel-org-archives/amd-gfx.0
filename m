From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Mon, 21 Jan 2019 16:33:27 +0100
Message-ID: <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org> <20190121150734.GA30582@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121150734.GA30582@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, David Zhou <David1.Zhou@amd.com>, Huang Rui <ray.huang@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>, Michel Daenzer <michel.daenzer@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, 21 Jan 2019 at 16:07, Christoph Hellwig <hch@infradead.org> wrote:
>
> > +#include <linux/dma-noncoherent.h>
>
> This header is not for usage in device drivers, but purely for
> dma-mapping implementations!
>

Is that documented anywhere?

> > +static inline bool drm_device_can_wc_memory(struct drm_device *ddev)
> >  {
> > +     if (IS_ENABLED(CONFIG_PPC))
> > +             return IS_ENABLED(CONFIG_NOT_COHERENT_CACHE);
> > +     else if (IS_ENABLED(CONFIG_MIPS))
> > +             return !IS_ENABLED(CONFIG_CPU_LOONGSON3);
> > +     else if (IS_ENABLED(CONFIG_X86))
> > +             return true;
> > +
> > +     return !dev_is_dma_coherent(ddev->dev);
>
> And even if something like this was valid to do, it would have to be
> a core function with an arch hook, and not hidden in a random driver.

Why would it not be valid to do? Is it wrong for a driver to be aware
of whether a device is cache coherent or not?

And in case it isn't, do you have an alternative suggestion on how to
fix this mess?
