Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD260C4167B
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Nov 2023 11:02:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45A9F10E4DA;
	Tue, 28 Nov 2023 11:02:14 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B612210E4D9;
 Tue, 28 Nov 2023 11:02:11 +0000 (UTC)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi
 [213.243.189.158])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id D62BB289;
 Tue, 28 Nov 2023 12:01:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1701169295;
 bh=aOAHm+7QlLBOLkQLIk6VxL4p/A6pjROBAZGcdianszY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=v8+IzSk347HNHTPwNz7exqJZKmnjvWzzfpUbvmt6+wJs24E02b+XylMVxxev6yACS
 15V6JrhH76sVK6ycJAsuGY2ghEhtg1XN8CBo6z3kshcrcsMHgycpi7ONSwOWQ1xqUE
 t8kTepEHPUYGy/lHMwwpZEuB0YuJ8qi0Knl7Mbqc=
Date: Tue, 28 Nov 2023 13:02:16 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 8/8] drm/xlnx: Do not include <drm/drm_plane_helper.h>
Message-ID: <20231128110216.GE25590@pendragon.ideasonboard.com>
References: <20231128104723.20622-1-tzimmermann@suse.de>
 <20231128104723.20622-9-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231128104723.20622-9-tzimmermann@suse.de>
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
Cc: amd-gfx@lists.freedesktop.org, suijingfeng@loongson.cn,
 maarten.lankhorst@linux.intel.com, javierm@redhat.com, mripard@kernel.org,
 linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, airlied@gmail.com, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Thomas,

Thank you for the patch.

On Tue, Nov 28, 2023 at 11:45:24AM +0100, Thomas Zimmermann wrote:
> Remove unnecessary include statements for <drm/drm_plane_helper.h>.
> The file contains helpers for non-atomic code and should not be
> required by most drivers. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Assuming you've compile-tested the driver,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Please get this merged through drm-misc as part of the series if
possible.

> ---
>  drivers/gpu/drm/xlnx/zynqmp_kms.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> index a7f8611be6f42..db3bb4afbfc46 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
> @@ -27,7 +27,6 @@
>  #include <drm/drm_managed.h>
>  #include <drm/drm_mode_config.h>
>  #include <drm/drm_plane.h>
> -#include <drm/drm_plane_helper.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_simple_kms_helper.h>
>  #include <drm/drm_vblank.h>

-- 
Regards,

Laurent Pinchart
