Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C978EE3682
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Feb 2026 13:39:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BFB10E746;
	Thu, 12 Feb 2026 13:39:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="YQqrxTW8";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0914810E62C;
 Wed, 11 Feb 2026 17:10:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1770829830; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GR7lKyC+ozaWg05oGsrqz0Z7rDS9ZIOYDtgmfUS9yF8SGsv5hLRBebSLLDot9wWTiPzrScyHd1uc1cH6tCAqkEaDLVlhG/9q//xhGaCZM5na149IiIrTOSzqQdfzSK0uZAQjX1MaL0OC2MNTBjUnA2K5ISt7h8ZObYSjndqEqQ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770829830;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0Dl0Z2RybvDxucJFvyk0rYh+K+gwu9CR8COPAfPaa6E=; 
 b=NKYhL+OqEH99ViXECN4WyH9CMsuK1vCMRqR2WtwAdscA0R8g5M0y0c2e3RfqDb9jUC5IZaPlkG/OstQPMWZNl7RkNL1pI8qGhYOURVBChPmks2lej2W0Mt6+0hrkM+6nVTD4V5Is57RwzMY7Vx0JTTOawjmXP0WHC61ax4qiFQk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770829830; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=0Dl0Z2RybvDxucJFvyk0rYh+K+gwu9CR8COPAfPaa6E=;
 b=YQqrxTW8kGhGYrH+a120mKUsZ4yMJMBXI1KYvdR3zSb+MvINyxPnAaGAThZTRNtV
 XNtcgjNA6v8n4VOAUn7uY/ttvmgO3lGGIh1q9ZIZGdAsVHJuwFL7uzAIPH0SqdU3PgO
 x6yJHpRLXjsytia4XH7HYMs7925RGM+XxwbVKn0A=
Received: by mx.zohomail.com with SMTPS id 1770829827913685.3686734865292;
 Wed, 11 Feb 2026 09:10:27 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, kernel@collabora.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org,
 Marius Vlad <marius.vlad@collabora.com>
Subject: Re: [PATCH v7 03/22] drm: Add enum conversions between
 DRM_COLOR_FORMAT and HDMI_COLORSPACE
Date: Wed, 11 Feb 2026 18:10:18 +0100
Message-ID: <4732908.LvFx2qVVIh@workhorse>
In-Reply-To: <20260210-prophetic-elk-of-superiority-b0ab03@houat>
References: <20260121-color-format-v7-0-ef790dae780c@collabora.com>
 <2028270.PYKUYFuaPT@workhorse>
 <20260210-prophetic-elk-of-superiority-b0ab03@houat>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Thu, 12 Feb 2026 13:39:22 +0000
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

On Tuesday, 10 February 2026 18:24:46 Central European Standard Time Maxime Ripard wrote:
> Hi,
> 
> On Sat, Feb 07, 2026 at 08:55:16PM +0100, Nicolas Frattaroli wrote:
> > On Friday, 6 February 2026 15:08:46 Central European Standard Time Maxime Ripard wrote:
> > > On Wed, Jan 21, 2026 at 03:45:10PM +0100, Nicolas Frattaroli wrote:
> > > > While the two enums have similar values, they're not identical, and
> > > > HDMI's enum is defined as per the HDMI standard.
> > > > 
> > > > Add a simple conversion function from DRM to HDMI. Unexpected inputs
> > > > aren't handled in any clever way, DRM_COLOR_FORMAT_AUTO and any other
> > > > value that doesn't cleanly map to HDMI just gets returned as
> > > > HDMI_COLORSPACE_RGB.
> > > > 
> > > > Add a second conversion function that gets a DRM_COLOR_FORMAT from an
> > > > HDMI_COLORSPACE as well. In this case, reserved HDMI values that can't
> > > > be converted will result in an -EINVAL return value.
> > > > 
> > > > Co-developed-by: Marius Vlad <marius.vlad@collabora.com>
> > > > Signed-off-by: Marius Vlad <marius.vlad@collabora.com>
> > > > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > > > ---
> > > >  include/drm/drm_connector.h | 54 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 54 insertions(+)
> > > > 
> > > > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > > > index b5604dca728a..ffeb42f3b4a3 100644
> > > > --- a/include/drm/drm_connector.h
> > > > +++ b/include/drm/drm_connector.h
> > > > @@ -2612,6 +2612,60 @@ int drm_connector_attach_color_format_property(struct drm_connector *connector);
> > > >  
> > > >  const char *drm_get_color_format_name(enum drm_color_format color_fmt);
> > > >  
> > > > +/**
> > > > + * drm_color_format_to_hdmi_colorspace - convert DRM color format to HDMI
> > > > + * @fmt: the &enum drm_color_format to convert
> > > > + *
> > > > + * Convert a given &enum drm_color_format to an equivalent
> > > > + * &enum hdmi_colorspace. For non-representable values and
> > > > + * %DRM_COLOR_FORMAT_AUTO, the value %HDMI_COLORSPACE_RGB is returned.
> > > > + *
> > > > + * Returns: the corresponding &enum hdmi_colorspace value
> > > > + */
> > > > +static inline enum hdmi_colorspace __pure
> > > > +drm_color_format_to_hdmi_colorspace(enum drm_color_format fmt)
> > > > +{
> > > > +	switch (fmt) {
> > > > +	default:
> > > > +	case DRM_COLOR_FORMAT_AUTO:
> > > > +	case DRM_COLOR_FORMAT_RGB444:
> > > > +		return HDMI_COLORSPACE_RGB;
> > > 
> > > I don't think that's correct. What auto ends up as totally depends on
> > > the atomic state it comes with.
> > > 
> > > At the very least, you should output a warning there, because that case
> > > should never happen.
> > 
> > Yeah, my hope was to keep this function __pure so that the compiler
> > has maximum freedom to do whatever. With a WARN, it's got side-effects
> > now, and we're no longer pure. With a status return value and an output
> > parameter, it's no longer pure either, because the output parameter is
> > not local memory.
> > 
> > The limiting factor here is that as I understand correctly, I can't
> > really extend the hdmi_colorspace enum, as it's basically 1:1 from
> > the standard. Doing this would be the ideal solution, because we'd
> > keep the function pure and without surprise conversions happening.
> 
> I feel like this kind of loops back into the other two reviews I did:
> you paint yourself into a corner by having auto in the enum, and by
> passing it directly to that function.
> 
> If, instead, you don't allow auto in the drm_color_format enum, and
> resolve auto in the hdmi_compute_config function instead of passing it
> directly, then we don't have to deal with it here.

You're right. Though that means I need to figure out how I'll handle
the conversion from enum to bitfield for !HDMI cases. I guess for DP,
I can do this in drm_dp_helper or something. I don't know if i915 or
amdgpu call into that at all though, but it's as good of a time as any
to start doing so now if not. Just also learned about the existence of
`enum dp_pixelformat`, which imho has the best naming out of all of
these enums. (I hope "HDMI Colorspace" to describe pixel formats is
straight from the standard because if it's something we in the kernel
came up with then I will put renaming it on my list of long-term
kernel tasks to get around to some day.)

And yes I will add the necessary KUnit tests for the DP helper side of
things as well. :)

Nothing registers the property for DSI so we should be good on that front
for now.

Thanks for the reviews.

Kind regards,
Nicolas Frattaroli

> > Looking at hdmi_colorspace_get_name in drivers/video/hdmi.c, it returns
> > "Invalid" for any value not in the enum itself. Would it be allowable
> > to tack an HDMI_COLORSPACE_INVALID at the end of the enum with perhaps
> > a negative value, or is there a different approach you'd prefer?
> 
> And again, if we only ever have to deal with RGB, YUV420, 444 or 422,
> then we always have valid values for HDMI_COLORSPACE.
> 
> Plus, the hdmi_colorspace enum matches what the hdmi spec defines, so we
> can't really extend it, and most importantly, hdmi_colorspace_get_name()
> is only ever used for debugging / logging purposes, it's never in the
> "functional" path.
> 
> Maxime
> 




