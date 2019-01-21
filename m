From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Mon, 21 Jan 2019 08:35:39 -0800
Message-ID: <20190121163539.GA18070@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
 <20190121150734.GA30582@infradead.org>
 <CAKv+Gu-hR=uieOeg7QheA5yfAycUoi2vjZsDUvROKVjW4eUNqw@mail.gmail.com>
 <20190121155908.GA8084@infradead.org>
 <CAKv+Gu8LzS9OgvVnzUT8BZWVgDmx4OfqNiPSf+8=riY_LByN-g@mail.gmail.com>
 <20190121162238.GA17651@infradead.org>
 <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-5V-UjP_YzZBCEsa+o_G6BRSVw2ZimYGNEfRGf-aRPNg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Will Deacon <will.deacon@arm.com>, David Zhou <David1.Zhou@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Michel Daenzer <michel.daenzer@amd.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Junwei Zhang <Jerry.Zhang@amd.com>, Huang Rui <ray.huang@amd.com>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jan 21, 2019 at 05:30:00PM +0100, Ard Biesheuvel wrote:
> > Until that happens we should just change the driver ifdefs to default
> > the hacks to off and only enable them on setups where we 100%
> > positively know that they actually work.  And document that fact
> > in big fat comments.
> 
> Well, as I mentioned in my commit log as well, if we default to off
> unless CONFIG_X86, we may break working setups on MIPS and Power where
> the device is in fact non-cache coherent, and relies on this
> 'optimization' to get things working. The same could be true for
> non-coherent ARM systems, hence my approach to disable this hack for
> cache coherent devices on non-X86 only.

Do we break existing setups or just reduce performance due to the lack
of WC mappings?  I thought it was the latter.  The point is that
even your check won't do what you actually said.  At lot of non-loongson
mips platforms are not cache coherent.  As are a lot of arm setups
and all sparc64 ones for example.  And chances that someone will
hacks this file out in a random subsystem when adding news ports also
is rather slim, so we'll remaing broken by default.

That is why I want at very least:  a whitelist instead of a blacklist
and some very big comments explaining what is going on here.  And in
the mid to long term even drm really needs to learn to use the
proper APIs :(
