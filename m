From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH] drm: disable WC optimization for cache coherent
 devices on non-x86
Date: Mon, 21 Jan 2019 07:07:34 -0800
Message-ID: <20190121150734.GA30582@infradead.org>
References: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190121100617.2311-1-ard.biesheuvel@linaro.org>
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
Cc: Will Deacon <will.deacon@arm.com>, David Zhou <David1.Zhou@amd.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Michel Daenzer <michel.daenzer@amd.com>, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, Junwei Zhang <Jerry.Zhang@amd.com>, Huang Rui <ray.huang@amd.com>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, Michael Ellerman <mpe@ellerman.id.au>, Alex Deucher <alexander.deucher@amd.com>, Sean Paul <sean@poorly.run>, Christian Koenig <christian.koenig@amd.com>, linux-arm-kernel@lists.infradead.org
List-Id: amd-gfx.lists.freedesktop.org

> +#include <linux/dma-noncoherent.h>

This header is not for usage in device drivers, but purely for
dma-mapping implementations!

> +static inline bool drm_device_can_wc_memory(struct drm_device *ddev)
>  {
> +	if (IS_ENABLED(CONFIG_PPC))
> +		return IS_ENABLED(CONFIG_NOT_COHERENT_CACHE);
> +	else if (IS_ENABLED(CONFIG_MIPS))
> +		return !IS_ENABLED(CONFIG_CPU_LOONGSON3);
> +	else if (IS_ENABLED(CONFIG_X86))
> +		return true;
> +
> +	return !dev_is_dma_coherent(ddev->dev);

And even if something like this was valid to do, it would have to be
a core function with an arch hook, and not hidden in a random driver.
