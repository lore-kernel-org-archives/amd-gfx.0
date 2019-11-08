From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 4/5] power: avs: smartreflex: Remove superfluous cast in debugfs_create_file() call
Date: Fri, 08 Nov 2019 12:24:42 +0100
Message-ID: <4367615.jSCgeRn5tF@kreacher>
References: <20191021145149.31657-1-geert+renesas@glider.be> <20191021145149.31657-5-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021145149.31657-5-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Breno =?ISO-8859-1?Q?Leit=E3o?= <leitao@debian.org>, Nayna Jain <nayna@linux.ibm.com>, Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Herbert Xu <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>, Alex Deucher <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David@rox.of.borg, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Casey Leedom <leedom@chelsio.com>, Shannon Nelson <snelson@pensando.io>, Pensando Drivers <drivers@pensando.io>, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: amd-gfx.lists.freedesktop.org

On Monday, October 21, 2019 4:51:48 PM CET Geert Uytterhoeven wrote:
> There is no need to cast a typed pointer to a void pointer when calling
> a function that accepts the latter.  Remove it, as the cast prevents
> further compiler checks.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Greg, have you taken this one by any chance?

> ---
>  drivers/power/avs/smartreflex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> index 4684e7df833a81e9..5376f3d22f31eade 100644
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -905,7 +905,7 @@ static int omap_sr_probe(struct platform_device *pdev)
>  	sr_info->dbg_dir = debugfs_create_dir(sr_info->name, sr_dbg_dir);
>  
>  	debugfs_create_file("autocomp", S_IRUGO | S_IWUSR, sr_info->dbg_dir,
> -			    (void *)sr_info, &pm_sr_fops);
> +			    sr_info, &pm_sr_fops);
>  	debugfs_create_x32("errweight", S_IRUGO, sr_info->dbg_dir,
>  			   &sr_info->err_weight);
>  	debugfs_create_x32("errmaxlimit", S_IRUGO, sr_info->dbg_dir,
> 
