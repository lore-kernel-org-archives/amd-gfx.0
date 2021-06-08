Return-Path: <SRS0=OOkP=LC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF45AC4743D
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 06:12:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C0861287
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jun 2021 06:12:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C0861287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 692EF6EAA6;
	Tue,  8 Jun 2021 06:12:15 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E87546EA1C;
 Tue,  8 Jun 2021 06:12:13 +0000 (UTC)
IronPort-SDR: F3rqjgr5s7EDsfy7e66/xemqtSb2XHjw0mq7CJd1vv096vwVU3ZBs1Ct7xVn4FxTm3/wJWMgf1
 QTZY9ObekwTA==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="201760557"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; d="scan'208";a="201760557"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2021 23:12:13 -0700
IronPort-SDR: whekhH+DUY/L22S5XiQsTkHvvJod+1Jj3xQiVW1tsjKQSjaC4sRJHyZGYR8ZUEaVAP8Sdj+7EQ
 ig9yJmLawE3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; d="scan'208";a="481822230"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
 by orsmga001.jf.intel.com with SMTP; 07 Jun 2021 23:12:07 -0700
Received: by stinkbox (sSMTP sendmail emulation);
 Tue, 08 Jun 2021 09:12:06 +0300
Date: Tue, 8 Jun 2021 09:12:06 +0300
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH 2/4] drm/uAPI: Add "active bpc" as feedback channel for
 "max bpc" drm property
Message-ID: <YL8KNshbrHt3FBFa@intel.com>
References: <20210604171723.10276-1-wse@tuxedocomputers.com>
 <20210604171723.10276-3-wse@tuxedocomputers.com>
 <YLpiVFiBrgH29rki@intel.com>
 <bef099db-f662-9005-6e36-ce056257f537@tuxedocomputers.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bef099db-f662-9005-6e36-ce056257f537@tuxedocomputers.com>
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
Cc: mripard@kernel.org, daniel@ffwll.ch, sunpeng.li@amd.com,
 intel-gfx@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
 maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, airlied@linux.ie, jani.nikula@linux.intel.com,
 amd-gfx@lists.freedesktop.org, tzimmermann@suse.de, rodrigo.vivi@intel.com,
 alexander.deucher@amd.com, harry.wentland@amd.com, christian.koenig@amd.com
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jun 07, 2021 at 08:46:47AM +0200, Werner Sembach wrote:
> =

> Am 04.06.21 um 19:26 schrieb Ville Syrj=E4l=E4:
> > On Fri, Jun 04, 2021 at 07:17:21PM +0200, Werner Sembach wrote:
> >> Add a new general drm property "active bpc" which can be used by graph=
ic drivers
> >> to report the applied bit depth per pixel back to userspace.
> >>
> >> While "max bpc" can be used to change the color depth, there was no wa=
y to check
> >> which one actually got used. While in theory the driver chooses the be=
st/highest
> >> color depth within the max bpc setting a user might not be fully aware=
 what his
> >> hardware is or isn't capable off. This is meant as a quick way to doub=
le check
> >> the setup.
> >>
> >> In the future, automatic color calibration for screens might also depe=
nd on this
> >> information available.
> >>
> >> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> >> ---
> >>   drivers/gpu/drm/drm_atomic_uapi.c |  2 ++
> >>   drivers/gpu/drm/drm_connector.c   | 40 +++++++++++++++++++++++++++++=
++
> >>   include/drm/drm_connector.h       | 15 ++++++++++++
> >>   3 files changed, 57 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_a=
tomic_uapi.c
> >> index 268bb69c2e2f..7ae4e40936b5 100644
> >> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> >> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> >> @@ -873,6 +873,8 @@ drm_atomic_connector_get_property(struct drm_conne=
ctor *connector,
> >>   		*val =3D 0;
> >>   	} else if (property =3D=3D connector->max_bpc_property) {
> >>   		*val =3D state->max_requested_bpc;
> >> +	} else if (property =3D=3D connector->active_bpc_property) {
> >> +		*val =3D state->active_bpc;
> >>   	} else if (connector->funcs->atomic_get_property) {
> >>   		return connector->funcs->atomic_get_property(connector,
> >>   				state, property, val);
> >> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_con=
nector.c
> >> index 7631f76e7f34..5f42a5be5822 100644
> >> --- a/drivers/gpu/drm/drm_connector.c
> >> +++ b/drivers/gpu/drm/drm_connector.c
> >> @@ -1195,6 +1195,13 @@ static const struct drm_prop_enum_list dp_color=
spaces[] =3D {
> >>    *	drm_connector_attach_max_bpc_property() to create and attach the
> >>    *	property to the connector during initialization.
> >>    *
> >> + * active bpc:
> >> + *	This read-only range property is used by userspace check the bit d=
epth
> >> + *	actually applied by the GPU driver after evaluation all hardware
> >> + *	capabilities and max bpc. Drivers to use the function
> >> + *	drm_connector_attach_active_bpc_property() to create and attach the
> >> + *	property to the connector during initialization.
> >> + *
> >>    * Connectors also have one standardized atomic property:
> >>    *
> >>    * CRTC_ID:
> >> @@ -2150,6 +2157,39 @@ int drm_connector_attach_max_bpc_property(struc=
t drm_connector *connector,
> >>   }
> >>   EXPORT_SYMBOL(drm_connector_attach_max_bpc_property);
> >>   =

> >> +/**
> >> + * drm_connector_attach_active_bpc_property - attach "active bpc" pro=
perty
> >> + * @connector: connector to attach active bpc property on.
> >> + * @min: The minimum bit depth supported by the connector.
> >> + * @max: The maximum bit depth supported by the connector.
> >> + *
> >> + * This is used to check the applied bit depth on a connector.
> >> + *
> >> + * Returns:
> >> + * Zero on success, negative errno on failure.
> >> + */
> >> +int drm_connector_attach_active_bpc_property(struct drm_connector *co=
nnector,
> >> +					  int min, int max)
> >> +{
> >> +	struct drm_device *dev =3D connector->dev;
> >> +	struct drm_property *prop;
> >> +
> >> +	prop =3D connector->active_bpc_property;
> >> +	if (!prop) {
> >> +		prop =3D drm_property_create_range(dev, 0, "active bpc", min, max);
> > Should be immutable.
> Yes. I didn't know if there is a way to do this (or just don't define a =

> set-function), but I think I found the define for this.
> >
> > Also wondering what the semantics of this should be when eg. DSC
> > is active?
> I'm unfamiliar how the inner workings of DSC (I guess Display Stream =

> Compression?) are. But doesn't it also have color depth?

Some number of bits go into the compressor, smaller/equal number
of bits come out. Not sure if the choice of the input bpc affects
what the sink does when decompressing or not.

> =

> The active bpc should be what the GPU tells the display to actually show =

> the user when he looks at just one pixel.
> =

> So dithering computed on the host should not be included (aka when the =

> gpu sends a premade picture to the screen and tells it the lesser pbc), =

> while FRC dithering computed in the display firmware should be included =

> (since the GPU can't really tell the difference between FRC displays and =

> True 10-Bit displays, can't it?)

Not sure. Haven't checked if there's something in some standard for
that.

-- =

Ville Syrj=E4l=E4
Intel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
