Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336B3C3064D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 08:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC7DD10E55D;
	Tue,  2 Jul 2024 08:17:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBBFA10E561
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jul 2024 08:17:55 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.whiteo.stw.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1sOYhu-0000qG-P7; Tue, 02 Jul 2024 10:17:46 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <p.zabel@pengutronix.de>)
 id 1sOYhs-006ZA9-VZ; Tue, 02 Jul 2024 10:17:44 +0200
Received: from pza by lupine with local (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1sOYhs-0002Ut-30;
 Tue, 02 Jul 2024 10:17:44 +0200
Message-ID: <dbc1c68bc090b8caa84e0e56e309dced74957c68.camel@pengutronix.de>
Subject: Re: [PATCH 4/4] drm/etnaviv: export client GPU usage statistics via
 fdinfo
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Lucas Stach <l.stach@pengutronix.de>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Luben
 Tuikov <ltuikov89@gmail.com>, Matthew Brost <matthew.brost@intel.com>
Cc: Pan Xinhui <Xinhui.Pan@amd.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org, 
 kernel@pengutronix.de, patchwork-lst@pengutronix.de
Date: Tue, 02 Jul 2024 10:17:44 +0200
In-Reply-To: <20240701171447.3823888-4-l.stach@pengutronix.de>
References: <20240701171447.3823888-1-l.stach@pengutronix.de>
 <20240701171447.3823888-4-l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: amd-gfx@lists.freedesktop.org
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mo, 2024-07-01 at 19:14 +0200, Lucas Stach wrote:
> This exposes a accumulated GPU active time per client via the
> fdinfo infrastructure.
>=20
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> v2:
> - new patch
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 32 ++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etna=
viv/etnaviv_drv.c
> index 6500f3999c5f..f42b982f9a16 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -24,6 +24,7 @@
>  #include "etnaviv_gem.h"
>  #include "etnaviv_mmu.h"
>  #include "etnaviv_perfmon.h"
> +#include "common.xml.h"

This seems to be unused.

>  /*
>   * DRM operations:
> @@ -488,7 +489,36 @@ static const struct drm_ioctl_desc etnaviv_ioctls[] =
=3D {
>  	ETNA_IOCTL(PM_QUERY_SIG, pm_query_sig, DRM_RENDER_ALLOW),
>  };
> =20
> -DEFINE_DRM_GEM_FOPS(fops);
> +static void etnaviv_fop_show_fdinfo(struct seq_file *m, struct file *f)
> +{
> +	struct drm_file *file =3D f->private_data;
> +	struct drm_device *dev =3D file->minor->dev;
> +	struct etnaviv_drm_private *priv =3D dev->dev_private;
> +	struct etnaviv_file_private *ctx =3D file->driver_priv;
> +
> +	/*
> +	 * For a description of the text output format used here, see
> +	 * Documentation/gpu/drm-usage-stats.rst.
> +	 */
> +	seq_printf(m, "drm-driver:\t%s\n", dev->driver->name);
> +	seq_printf(m, "drm-client-id:\t%u\n", ctx->id);
> +
> +	for (int i =3D 0; i < ETNA_MAX_PIPES; i++) {
> +		struct etnaviv_gpu *gpu =3D priv->gpu[i];
> +
> +		if (!gpu)
> +			continue;
> +
> +		seq_printf(m, "drm-engine-pipe%d:\t%llu ns\n", i,
> +			drm_sched_entity_time_spent(&ctx->sched_entity[i]));

Align to open parenthesis for consistency with most of the other code
in this file?


regards
Philipp
