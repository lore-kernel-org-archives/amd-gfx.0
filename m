Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2ADC5479D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Jan 2023 16:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B58810E784;
	Wed, 11 Jan 2023 16:06:43 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E04DE10E776;
 Wed, 11 Jan 2023 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1673453201; x=1704989201;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=UeQTUbcXpxM0aHWVF3BkeWxkAwUagUrs8L1aujbAKXs=;
 b=dI6g9UOalr9qf4WVFhnIxeblOnwF6QT9wcmvWfpsbYhQi8qfP9Zirbcb
 hYN/JDqwrbRzJ7SMscyKwPs1NwLFQo2cyKU7pjBF3SkRkPBpcgm2rLY+2
 PbZ449i6y97qBp2XXAnfMv2T0BKdWVLZ2q/2nSRT+hRHW+L6R6uapHXxF
 YgLVzZHVj/rdJjhPvae1wd9NrjSX08Dh1oNT/AoVpwnDZrNZUy10jlXA5
 XwENZPc99UKmswMvqXDAAh7a+71audO4LhadHFhXQkgVhyTG5xGkM4Qey
 yuBH4/+IpugED7tQGAzTWLm1QA85hqhOm0ofqoPVflKO3K3xa/MmQZhFC g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="387919249"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; d="scan'208";a="387919249"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2023 08:04:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="720769432"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; d="scan'208";a="720769432"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
 by fmsmga008.fm.intel.com with SMTP; 11 Jan 2023 08:03:54 -0800
Received: by stinkbox (sSMTP sendmail emulation);
 Wed, 11 Jan 2023 18:03:53 +0200
Date: Wed, 11 Jan 2023 18:03:53 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v2 06/10] drm: Define enum mode_set_atomic in
 drm_modeset_helper_tables.h
Message-ID: <Y77d6bbqvG8YOY0D@intel.com>
References: <20230111130206.29974-1-tzimmermann@suse.de>
 <20230111130206.29974-7-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111130206.29974-7-tzimmermann@suse.de>
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

On Wed, Jan 11, 2023 at 02:02:02PM +0100, Thomas Zimmermann wrote:
> Define enum mode_set_atomic next to the only interface that uses
> the type. This will allow for removing several include statements
> for drm_fb_helper.h. No functional changes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> ---
>  include/drm/drm_fb_helper.h              | 5 -----
>  include/drm/drm_modeset_helper_vtables.h | 6 +++++-
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
> index b111dc7ada78..f443e1f11654 100644
> --- a/include/drm/drm_fb_helper.h
> +++ b/include/drm/drm_fb_helper.h
> @@ -37,11 +37,6 @@ struct drm_fb_helper;
>  
>  #include <drm/drm_client.h>
>  
> -enum mode_set_atomic {
> -	LEAVE_ATOMIC_MODE_SET,
> -	ENTER_ATOMIC_MODE_SET,
> -};
> -
>  /**
>   * struct drm_fb_helper_surface_size - describes fbdev size and scanout surface size
>   * @fb_width: fbdev width
> diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
> index 77a540ad7dcd..206f495bbf06 100644
> --- a/include/drm/drm_modeset_helper_vtables.h
> +++ b/include/drm/drm_modeset_helper_vtables.h
> @@ -48,10 +48,14 @@
>   * To make this clear all the helper vtables are pulled together in this location here.
>   */
>  
> -enum mode_set_atomic;
>  struct drm_writeback_connector;
>  struct drm_writeback_job;
>  
> +enum mode_set_atomic {
> +	LEAVE_ATOMIC_MODE_SET,
> +	ENTER_ATOMIC_MODE_SET,
> +};
> +
>  /**
>   * struct drm_crtc_helper_funcs - helper operations for CRTCs
>   *
> -- 
> 2.39.0

-- 
Ville Syrjälä
Intel
