Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1579DF3C982
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 14:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 881B810E594;
	Tue, 24 Feb 2026 14:38:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JU+tftSl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D04B710E591;
 Tue, 24 Feb 2026 14:38:19 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BE21D61118;
 Tue, 24 Feb 2026 14:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CFBC19422;
 Tue, 24 Feb 2026 14:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771943898;
 bh=wPlstvr1vtng5Z8cvx+47DS9+o9aAqKW2r6GHJ7uuxs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JU+tftSlcd79SWpTaxWdip1YcYQks3WUmm2YHyKc3+YvW3ns5HJT8soxQt6BFF+Zm
 ozi8Fcj8ZOsA2noENdn7ylcF+2PK5rggTKgUt01GZLDC7zMrgJ8/3NZZi38tLHvHuK
 cv3/3a1iNs1b6NHxVBI2LxUNgppG15UWc9XzNGPsABX50htLCFUP7Eu7hjHHTQxod5
 2S7h5ePYGzvdAM49gY+928Tl+rAWOhAmtNJ3WdO9hcdXXzef7MijVOrCWrFf3ccAOU
 ebyWMrcwYSX4376zU5+LJrds5gdSqYP1LbkbnfOUQTsRSCRljp84Z99GT+01wS7CyD
 U1cy0u88rQGtw==
Date: Tue, 24 Feb 2026 15:38:15 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Dmitry Baryshkov <lumag@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 kernel@collabora.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-doc@vger.kernel.org, 
 Andri Yngvason <andri@yngvason.is>, Werner Sembach <wse@tuxedocomputers.com>, 
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v8 02/20] drm: Add new general DRM property "color format"
Message-ID: <20260224-elegant-fine-mule-f45bca@houat>
References: <20260216-color-format-v8-0-5722ce175dd5@collabora.com>
 <20260216-color-format-v8-2-5722ce175dd5@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="mibp7hbznkdzhzwa"
Content-Disposition: inline
In-Reply-To: <20260216-color-format-v8-2-5722ce175dd5@collabora.com>
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


--mibp7hbznkdzhzwa
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v8 02/20] drm: Add new general DRM property "color format"
MIME-Version: 1.0

Hi Nicolas,

I've sent some preliminary work here that should help you with this, and
the HDMI helpers.

https://lore.kernel.org/r/20260224-drm-rework-color-formats-v1-0-bebc76604ada@kernel.org

On Mon, Feb 16, 2026 at 02:01:16PM +0100, Nicolas Frattaroli wrote:
> +/**
> + * enum drm_color_format_enum - color model description
> + *
> + * This enum is a high-level description of the component makeup of the image
> + * data. It says nothing about how the components are ordered or how many bits
> + * they take up (i.e. is unlike MEDIA_BUS_FMT\_ or DRM_FORMAT\_), but
> + * describes the type of components (Luminance-Chrominance vs. RGB) and the
> + * sub-sampling.
> + *
> + * &enum drm_color_format_enum makes statements about the same attribute of
> + * an image as the DRM_COLOR_FORMAT\_ bitfields do. Its purpose is to inform
> + * choices made by display protocol specific implementations when it comes to
> + * translating it to e.g. &enum hdmi_colorspace or &enum dp_pixelformat, both
> + * of which also describe the same attribute of the image at the same level of
> + * specificity.
> + *
> + * In precise terms, this enum describes a color model. It makes no statements
> + * about the primaries, gamma, or current phase of the moon used in conversion
> + * from one to the other. Furthermore, it also makes no statements about the
> + * order of components (e.g. RGB vs. BGR), their depth in bits, or their binary
> + * packing.
> + */
> +enum drm_color_format_enum {
> +	/**
> +	 * @DRM_COLOR_FORMAT_ENUM_AUTO: The choice of format is left up to the
> +	 * display protocol implementation. All implementations of the same
> +	 * display protocol (e.g. HDMI) are supposed to behave the same way,
> +	 * though display protocols may choose to behave differently compared to
> +	 * each other (e.g. HDMI's "AUTO" does not have to match DP's "AUTO").
> +	 *
> +	 * Implementations may rely on @DRM_COLOR_FORMAT_ENUM_AUTO to be falsy.
> +	 */

The HDMI (and others if they exist) behaviour should be documented, and
referred to here.

> +	DRM_COLOR_FORMAT_ENUM_AUTO = 0,
> +
> +	/**
> +	 * @DRM_COLOR_FORMAT_ENUM_RGB444: Image components are encoded as RGB
> +	 * values of equal resolution.
> +	 */
> +	DRM_COLOR_FORMAT_ENUM_RGB444,
> +
> +	/**
> +	 * @DRM_COLOR_FORMAT_ENUM_YCBCR444: Image components are encoded as
> +	 * luminance and chrominance of equal resolution.
> +	 */
> +	DRM_COLOR_FORMAT_ENUM_YCBCR444,
> +
> +	/**
> +	 * @DRM_COLOR_FORMAT_ENUM_YCBCR422: Image components are encoded as
> +	 * luminance and chrominance with the chrominance components having half
> +	 * the horizontal resolution.
> +	 */
> +	DRM_COLOR_FORMAT_ENUM_YCBCR422,
> +
> +	/**
> +	 * @DRM_COLOR_FORMAT_ENUM_YCBCR420: Image components are encoded as
> +	 * luminance and chrominance with the chrominance components having half
> +	 * the horizontal and vertical resolution.
> +	 */
> +	DRM_COLOR_FORMAT_ENUM_YCBCR420,
> +
> +	/**
> +	 * @DRM_COLOR_FORMAT_ENUM_NUM: The number of valid color format values
> +	 * in this enum. Itself not a valid color format.
> +	 */
> +	DRM_COLOR_FORMAT_ENUM_NUM,
> +
> +	/**
> +	 * @DRM_COLOR_FORMAT_ENUM_INVALID: Error return value for conversion
> +	 * functions encountering unexpected inputs.
> +	 */
> +	DRM_COLOR_FORMAT_ENUM_INVALID = -EINVAL,
> +};

So, I think with my series mentioned above, we can settle on having this
enum as the property value (and called drm_connector_output_format or
something?) and drm_output_color_format used internally by everyone that
needs to list the supported formats, or the one being enforced.

Assuming we use the names I mentioned before, that means the
drm_connector_output_format -> drm_output_color_format conversion needs
to be done by the driver (or helpers like HDMI) to expand what "auto"
means, and could be fallible, but the drm_output_color_format ->
drm_connector_output_format conversion is infallible. Which should also
simplify your code paths.

Maxime

--mibp7hbznkdzhzwa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaZ231wAKCRAnX84Zoj2+
dgv7AX0TPqjjMKqbcMxhzowC9vgkD4abbWiLZG7BLnMDNWqVjvbTeZ19YIowWZg1
BzVjkb4BfjqM/rkI15M8Ts5OoyNuqrWr4Zui3f3bxCVLAB5tGzQMIYlhBIHVp1om
T5DrzyQ2lw==
=VVcr
-----END PGP SIGNATURE-----

--mibp7hbznkdzhzwa--
