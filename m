Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5293ACA0FF2
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Aug 2024 13:04:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0741B10E3B1;
	Fri, 30 Aug 2024 13:04:05 +0000 (UTC)
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [195.130.132.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503FD10E8E7
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Aug 2024 09:45:24 +0000 (UTC)
Received: from andre.telenet-ops.be (andre.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:15])
 by gauss.telenet-ops.be (Postfix) with ESMTPS id 4WwCtp6lwPz50PqV
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Aug 2024 11:45:22 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:f0d5:75e3:232:dfed])
 by andre.telenet-ops.be with cmsmtp
 id 69lM2D00L4wyYGe019lMm3; Fri, 30 Aug 2024 11:45:22 +0200
Received: from geert (helo=localhost)
 by ramsan.of.borg with local-esmtp (Exim 4.95)
 (envelope-from <geert@linux-m68k.org>) id 1sjyC1-001KOP-Bj;
 Fri, 30 Aug 2024 11:45:21 +0200
Date: Fri, 30 Aug 2024 11:45:21 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
cc: daniel@ffwll.ch, airlied@gmail.com, jfalempe@redhat.com, 
 javierm@redhat.com, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v3 04/81] drm: Add client-agnostic setup helper
In-Reply-To: <20240830084456.77630-5-tzimmermann@suse.de>
Message-ID: <6c78eb72-c555-1fa8-18f9-c1e671a8b12@linux-m68k.org>
References: <20240830084456.77630-1-tzimmermann@suse.de>
 <20240830084456.77630-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Mailman-Approved-At: Fri, 30 Aug 2024 13:04:03 +0000
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

 	Hi Thomas,

On Fri, 30 Aug 2024, Thomas Zimmermann wrote:
> DRM may support multiple in-kernel clients that run as soon as a DRM
> driver has been registered. To select the client(s) in a single place,
> introduce drm_client_setup().
>
> Drivers that call the new helper automatically instantiate the kernel's
> configured default clients. Only fbdev emulation is currently supported.
> Later versions can add support for DRM-based logging, a boot logo or even
> a console.
>
> Some drivers handle the color mode for clients internally. Provide the
> helper drm_client_setup_with_color_mode() for them.
>
> v3:
> - fix build error
> v2:
> - add drm_client_setup_with_fourcc() (Laurent)
> - push default-format handling into actual clients
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/gpu/drm/drm_client_setup.c

> +/**
> + * drm_client_setup_with_fourcc() - Setup in-kernel DRM clients for color mode
> + * @dev: DRM device
> + * @fourcc: Preferred pixel format as 4CC code for the device
> + *
> + * This function sets up the in-kernel DRM clients. It is equivalent
> + * to drm_client_setup(), but expects a 4CC code as second argument.
> + *
> + * Do not use this function in new drivers. Prefer drm_client_setup() with a
> + * format of NULL.

Why? To me this looks like the right function to call on hardware
that does not support ARGB8888 natively.

BTW, once this series is applied, I plan to check again how to wire up
native fbcon support for monochrome (DRM_FORMAT_R1) and grayscale
(DRM_FORMAT_R8), as used by the Solomon driver.

> + */
> +void drm_client_setup_with_fourcc(struct drm_device *dev, u32 fourcc)
> +{
> +	drm_client_setup(dev, drm_format_info(fourcc));
> +}
> +EXPORT_SYMBOL(drm_client_setup_with_fourcc);
> +
> +/**
> + * drm_client_setup_with_color_mode() - Setup in-kernel DRM clients for color mode
> + * @dev: DRM device
> + * @color_mode: Preferred color mode for the device
> + *
> + * This function sets up the in-kernel DRM clients. It is equivalent
> + * to drm_client_setup(), but expects a color mode as second argument.
> + *
> + * Do not use this function in new drivers. Prefer drm_client_setup() with a


Yeah, this is definitely not to be used in new drivers, as color_mode is
ambiguous.

> + * format of NULL.

or drm_client_setup_with_fourcc().

> + */
> +void drm_client_setup_with_color_mode(struct drm_device *dev, unsigned int color_mode)
> +{
> +	u32 fourcc = drm_driver_color_mode_format(dev, color_mode);
> +
> +	drm_client_setup_with_fourcc(dev, fourcc);
> +}
> +EXPORT_SYMBOL(drm_client_setup_with_color_mode);

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
