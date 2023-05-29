Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7650C7EE23
	for <amd-gfx@archiver.kernel.org>; Mon, 29 May 2023 19:42:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2562310E2DD;
	Mon, 29 May 2023 19:42:15 +0000 (UTC)
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com
 (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CDE10E2DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 May 2023 19:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa1;
 h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
 message-id:subject:cc:to:from:date:from;
 bh=wUfXvnVscNDHokiq7vn1jObWtrFuRJJpIbqINcxXDJE=;
 b=knGLUans50LTZIo5f1iVlVgufTKBN3qIzs+NSf9br/jM5jHjHmYBi5g2/FBkei1b0wJjoFKhxSShV
 QSoZGiUz86hzh4UgxBsuS6euL3xR/ZonuALCFFhA8XiecTqW5AIGdTQoHEMPsH9rkMV1dpB468TCAG
 JoeCW69AvlKmWm0o9tIxIDbln+tJ5/ckfNmXDeJWMVVpyyxlihT0HnD0BJeIZX1SnasSm/RgHLuTIk
 F2e3h8bQ7f830k9spRcCLPbS4DJ9UgZqRFFqnLuzg2A9XlMmULp7Xdre3rmfleaPQthSb5WgHOa1Fe
 EvHZd+/jsf5bfp2smSgvH5E4TzLlwCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed1;
 h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
 message-id:subject:cc:to:from:date:from;
 bh=wUfXvnVscNDHokiq7vn1jObWtrFuRJJpIbqINcxXDJE=;
 b=SPkPhAKKpLhNfEwhgL3ZL2sVscqxwpfUw6ze1N9enTq8D4Ch51D8bRwX0xHhLkO4hgMRMxnb09WWw
 5HU9e0GDA==
X-HalOne-ID: c141e50e-fe58-11ed-8a8a-592bb1efe9dc
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay4 (Halon) with ESMTPSA
 id c141e50e-fe58-11ed-8a8a-592bb1efe9dc;
 Mon, 29 May 2023 19:41:08 +0000 (UTC)
Date: Mon, 29 May 2023 21:41:07 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v4 13/13] drm/i915: Implement dedicated fbdev I/O helpers
Message-ID: <20230529194107.GG1370714@ravnborg.org>
References: <20230524092150.11776-1-tzimmermann@suse.de>
 <20230524092150.11776-14-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524092150.11776-14-tzimmermann@suse.de>
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
Cc: Jani Nikula <jani.nikula@linux.intel.com>, freedreno@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, amd-gfx@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 maarten.lankhorst@linux.intel.com, javierm@redhat.com,
 dri-devel@lists.freedesktop.org,
 Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
 mripard@kernel.org, daniel@ffwll.ch, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 linux-tegra@vger.kernel.org, airlied@gmail.com,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Thomas,

On Wed, May 24, 2023 at 11:21:50AM +0200, Thomas Zimmermann wrote:
> Implement dedicated fbdev helpers for framebuffer I/O instead
> of using DRM's helpers. Use an fbdev generator macro for
> deferred I/O to create the fbdev callbacks. i915 was the only
> caller of the DRM helpers, so remove them from the helper module.
> 
> i915's fbdev emulation is still incomplete as it doesn't implement
> deferred I/O and damage handling for mmaped pages.
> 
> v4:
> 	* generate deferred-I/O helpers
> 	* use initializer macros for fb_ops
> v2:
> 	* use FB_IO_HELPERS options
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> Cc: "Ville Syrjälä" <ville.syrjala@linux.intel.com>
> ---
>  drivers/gpu/drm/Kconfig                    |   3 -
>  drivers/gpu/drm/drm_fb_helper.c            | 107 ---------------------
>  drivers/gpu/drm/i915/Kconfig               |   1 +
>  drivers/gpu/drm/i915/display/intel_fbdev.c |  14 +--
>  include/drm/drm_fb_helper.h                |  39 --------
>  5 files changed, 9 insertions(+), 155 deletions(-)

Nice diffstat!
Assuming there is a good explanation on the dirty check:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
