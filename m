From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Mon, 21 Jan 2019 17:50:07 +0100
Message-ID: <CAKv+Gu-NxJkT7ViO8HogVMnPyiYDfOEQsEJ8AFNshexopbby8A@mail.gmail.com>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org> <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org> <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org> <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
 <20190121163539.GA18070@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190121163539.GA18070@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, David Zhou <David1.Zhou@amd.com>, Huang Rui <ray.huang@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>, Michel Daenzer <michel.daenzer@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Will Deacon <will.deacon@arm.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, 21 Jan 2019 at 17:35, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Jan 21, 2019 at 05:30:00PM +0100, Ard Biesheuvel wrote:
> > > Until that happens we should just change the driver ifdefs to default
> > > the hacks to off and only enable them on setups where we 100%
> > > positively know that they actually work.  And document that fact
> > > in big fat comments.
> >
> > Well, as I mentioned in my commit log as well, if we default to off
> > unless CONFIG_X86, we may break working setups on MIPS and Power where
> > the device is in fact non-cache coherent, and relies on this
> > 'optimization' to get things working. The same could be true for
> > non-coherent ARM systems, hence my approach to disable this hack for
> > cache coherent devices on non-X86 only.
>
> Do we break existing setups or just reduce performance due to the lack
> of WC mappings?  I thought it was the latter.

Combining this check

#if defined(CONFIG_PPC) && !defined(CONFIG_NOT_COHERENT_CACHE)
    return false;
...
#else
    return true;
#endif

with the fact that the driver assumes that DMA is cache coherent, I'd
be surprised if this hardware works without the hack.

The optimization targets cache coherent systems where pushing data
through the cache into the GPU is wasteful, given that it evicts other
data and relies on snooping by the device. In this case, disabling the
optimization reduces performance.

My point is that it is highly likely that non-cache coherent systems
may accidentally be in a working state only due to this optimization,
and not because the driver deals with non-cache coherent DMA
correctly.

> The point is that
> even your check won't do what you actually said.

Well, it enables the optimization only for non-cache coherent devices.
How is that different from what I said?

>  At lot of non-loongson
> mips platforms are not cache coherent.

You are assuming that whoever added that check cared about other MIPS platforms

> As are a lot of arm setups
> and all sparc64 ones for example.  And chances that someone will
> hacks this file out in a random subsystem when adding news ports also
> is rather slim, so we'll remaing broken by default.
>
> That is why I want at very least:  a whitelist instead of a blacklist
> and some very big comments explaining what is going on here.

ideally, we'd turn off this optimization entirely unless running on
x86. That would be my preference.

However, given the above re non-cache coherent systems, i am cautious.

>  And in
> the mid to long term even drm really needs to learn to use the
> proper APIs :(

+1
