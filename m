From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 1/5] crypto: nx - Improve debugfs_create_u{32,64}()
 handling for atomics
Date: Fri, 25 Oct 2019 23:27:12 +0800
Message-ID: <20191025152712.26q6s5gbygdxd33j@gondor.apana.org.au>
References: <20191021145149.31657-1-geert+renesas@glider.be>
 <20191021145149.31657-2-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191021145149.31657-2-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Breno =?iso-8859-1?Q?Leit=E3o?= <leitao@debian.org>, Nayna Jain <nayna@linux.ibm.com>, Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S . Miller" <davem@davemloft.net>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David@rox.of.borg, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Casey Leedom <leedom@chelsio.com>, Shannon Nelson <snelson@pensando.io>, Pensando Drivers <drivers@pensando.io>, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozla
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Oct 21, 2019 at 04:51:45PM +0200, Geert Uytterhoeven wrote:
> Variables of type atomic{,64}_t can be used fine with
> debugfs_create_u{32,64}, when passing a pointer to the embedded counter.
> This allows to get rid of the casts, which prevented compiler checks.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/crypto/nx/nx_debugfs.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
