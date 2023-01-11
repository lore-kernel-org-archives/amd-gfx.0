Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E19C5479D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 16:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B42B10E778;
	Wed, 11 Jan 2023 16:05:56 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A2B10E787;
 Wed, 11 Jan 2023 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673453153; x=1704989153;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=yS1Tx9MBv2MTrnHDrpfFP/1IYvWDkXEmBZQT9Uxwuqg=;
 b=jCyjK+8TJID2nkW+w4hMSPExvK0TNwRgKmUds9P7DMFD7Vv2O48iBW1g
 nk877iid91UkneusAJFBamJ/TSQoG7mwbgC6Jugd32OwquVnr3luWdEob
 uBN/bmnx0RIzspof2l1e3sHIgSDG/IocSdPnm2j7WVtri8PB2hKDJqsTT
 S6WGjX7oL5RQry26u5nUdQk++ijzbLFR9Wbmhblsg0EVgrvCyKS8utHaQ
 cVjjRp2YEBp7l80y/9qJCeFLYVvNHNPOXDBvi3jmnPO7mManGPd4rKfZ6
 l1PbdNBymqWWJuXJ+xYXRcG7vBDlD8+j27rf/UIRWUiYfNcxZxgJbG3Vo g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="387919018"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; d="scan'208";a="387919018"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2023 08:03:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720769406"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; d="scan'208";a="720769406"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
 by fmsmga008.fm.intel.com with SMTP; 11 Jan 2023 08:03:31 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Wed, 11 Jan 2023 18:03:31 +0200
Date: Wed, 11 Jan 2023 18:03:31 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 03/10] drm: Don't include <linux/fb.h> in
 drm_crtc_helper.h
Message-ID: <Y77d0x9ZV5ZZyT/0@intel.com>
References: <20230111130206.29974-1-tzimmermann@suse.de>
 <20230111130206.29974-4-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111130206.29974-4-tzimmermann@suse.de>
X-Patchwork-Hint: comment
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
Cc: f.fainelli@gmail.com, amd-gfx@lists.freedesktop.org, sam@ravnborg.org,
 dri-devel@lists.freedesktop.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, thierry.reding@gmail.com, james.qian.wang@arm.com,
 patrik.r.jakobsson@gmail.com, daniel@ffwll.ch, alexander.deucher@amd.com,
 bcm-kernel-feedback-list@broadcom.com, liviu.dudau@arm.com, airlied@gmail.com,
 christian.koenig@amd.com, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 11, 2023 at 02:01:59PM +0100, Thomas Zimmermann wrote:
> Including <linux/fb.h> in drm_crtc_helper.h is not required. Remove
> the include statement and avoid rebuilding DRM whenever the fbdev
> header changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  include/drm/drm_crtc_helper.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
> index 1840db247f69..072bc4f90349 100644
> --- a/include/drm/drm_crtc_helper.h
> +++ b/include/drm/drm_crtc_helper.h
> @@ -37,8 +37,6 @@
>  #include <linux/types.h>
>  #include <linux/idr.h>

^ bunch of other unnecessary headers there as well.

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

>  
> -#include <linux/fb.h>
> -
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_modeset_helper.h>
> -- 
> 2.39.0

-- 
Ville Syrjälä
Intel
