Return-Path: <SRS0=Z8rF=PU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C6CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 09:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DEC600EF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Nov 2021 09:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 54DEC600EF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F1589BB3;
	Mon,  1 Nov 2021 09:52:00 +0000 (UTC)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27A2389BB3
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Nov 2021 09:51:59 +0000 (UTC)
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1mhTyt-0002xT-5J; Mon, 01 Nov 2021 10:51:55 +0100
Message-ID: <925990553bec513c3fa347178e1e0e75263026c3.camel@pengutronix.de>
Subject: Re: [PATCH 3/6] drm/etnaviv: stop getting the excl fence separately
 here
From: Lucas Stach <l.stach@pengutronix.de>
To: Christian =?ISO-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Date: Mon, 01 Nov 2021 10:51:54 +0100
In-Reply-To: <20211028132630.2330-3-christian.koenig@amd.com>
References: <20211028132630.2330-1-christian.koenig@amd.com>
 <20211028132630.2330-3-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
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

Am Donnerstag, dem 28.10.2021 um 15:26 +0200 schrieb Christian König:
> Just grab all fences in one go.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> index 8dc93863bf96..b5e8ce86dbe7 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_submit.c
> @@ -189,7 +189,7 @@ static int submit_fence_sync(struct etnaviv_gem_submit *submit)
>  			continue;
>  
>  		if (bo->flags & ETNA_SUBMIT_BO_WRITE) {
> -			ret = dma_resv_get_fences(robj, &bo->excl,
> +			ret = dma_resv_get_fences(robj, NULL,
>  						  &bo->nr_shared,
>  						  &bo->shared);
>  			if (ret)


