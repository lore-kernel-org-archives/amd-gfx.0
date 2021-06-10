Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B998C47094
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 08:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD385613CA
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 08:11:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD385613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 987F26EC7A;
	Thu, 10 Jun 2021 08:11:52 +0000 (UTC)
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com
 [IPv6:2a00:1450:4864:20::143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B42116E52C;
 Thu, 10 Jun 2021 08:11:50 +0000 (UTC)
Received: by mail-lf1-x143.google.com with SMTP id f30so1834261lfj.1;
 Thu, 10 Jun 2021 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version; bh=QBEz8WW48tL++mHlIbEXl2SOVC4FnBjVosXF2O0HZkk=;
 b=S7NHtcCsuDDJ7DRDSnUR5ZVQTdlnZIfgEcJt/4oOqys8gg/6Q+vKBZTC81pKX63+JF
 LmOK7quYv4iF8z9yjGD6bNdN7kaKLKokEYw2+qeJQSDlGCNLFmbjG+JJmVLZQ5i1gTCz
 ctsG0vOTV3NepoEiwdjA7VWvALNEdjCn5lHtc/k3lTsBlBW2e2d3T45jlpTlb9XS03DU
 KKhxbKnS7N7mGc/bj1X7zZwzuxl9UpJgTDy5keCI8hBURJ4ooWyl3cb/VLYmaKRgr0zn
 27sfcBj3frnf3f/oE3Q01gdGXjtKcYboWPvdD1HEO60980kPrNSff7emCgasGEuQ4iM+
 gFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=QBEz8WW48tL++mHlIbEXl2SOVC4FnBjVosXF2O0HZkk=;
 b=B/DeyQvm8//JxLRWZQvM3NV5t8eYe/7P/NYBqiXORY8gLN9bQxR/O//sM4BHzRjV4U
 Yds75yTIgcgJ3Sgn5hUjtu7Z36FtCgE2TSwuosRjNwG7Wk5EDZicrpJEwPZpTs0Imaua
 Ld36Pp2VvKqLx0ct6s6h+IIB7MAnO+Qat0uwXc0AKtxiSBODVra89Obyty+CiR33pUs2
 cXhgBGz7zPIHUGsc+ATKKr624CBsWon54J2Okh5tA3Sw+JOsJ8EN3RntDvCiJBeLkb2T
 qkntq+fWuoVZ1fmu/2HHm/HbF3zWdZQO4b5T0/Lam0wrz1yd1EgyG8wjj3YRxQN8Bkt1
 5iGw==
X-Gm-Message-State: AOAM532sCiXkui4KfnB6XtXbzy4qrYxJpZvMa8SJKtBMtV17sQTxChzB
 isj7HuC+CVjBbjZk0G4CYuI=
X-Google-Smtp-Source: ABdhPJzzY+o71G1h0X1OHWJYoX8LliR9Q8slGnWDJMdHyOz32K4VAZOp6mrVmXdp0Emhb5rYJStx/g==
X-Received: by 2002:a19:6007:: with SMTP id u7mr1177350lfb.471.1623312708970; 
 Thu, 10 Jun 2021 01:11:48 -0700 (PDT)
Received: from eldfell ([194.136.85.206])
 by smtp.gmail.com with ESMTPSA id v6sm226614lfr.182.2021.06.10.01.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 01:11:48 -0700 (PDT)
Date: Thu, 10 Jun 2021 11:11:45 +0300
From: Pekka Paalanen <ppaalanen@gmail.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Subject: Re: [PATCH v2 5/7] drm/uAPI: Add "active color format" drm property
 as feedback for userspace
Message-ID: <20210610111145.7fdf9a53@eldfell>
In-Reply-To: <20210608174320.37429-6-wse@tuxedocomputers.com>
References: <20210608174320.37429-1-wse@tuxedocomputers.com>
 <20210608174320.37429-6-wse@tuxedocomputers.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: amd-gfx@lists.freedesktop.org, tzimmermann@suse.de,
 intel-gfx@lists.freedesktop.org, sunpeng.li@amd.com,
 dri-devel@lists.freedesktop.org, joonas.lahtinen@linux.intel.com,
 maarten.lankhorst@linux.intel.com, linux-kernel@vger.kernel.org,
 mripard@kernel.org, airlied@linux.ie, jani.nikula@linux.intel.com,
 daniel@ffwll.ch, rodrigo.vivi@intel.com, alexander.deucher@amd.com,
 harry.wentland@amd.com, christian.koenig@amd.com
Content-Type: multipart/mixed; boundary="===============0394674457=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0394674457==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/A0zawA.ljA68TAxQdb2Sl2J"; protocol="application/pgp-signature"

--Sig_/A0zawA.ljA68TAxQdb2Sl2J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue,  8 Jun 2021 19:43:18 +0200
Werner Sembach <wse@tuxedocomputers.com> wrote:

> Add a new general drm property "active color format" which can be used by
> graphic drivers to report the used color format back to userspace.
>=20
> There was no way to check which color format got actually used on a given
> monitor. To surely predict this, one must know the exact capabilities of =
the
> monitor, the GPU, and the connection used and what the default behaviour =
of the
> used driver is (e.g. amdgpu prefers YCbCr 4:4:4 while i915 prefers RGB). =
This
> property helps eliminating the guessing on this point.
>=20
> In the future, automatic color calibration for screens might also depend =
on this
> information being available.
>=20
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  drivers/gpu/drm/drm_atomic_uapi.c |  2 ++
>  drivers/gpu/drm/drm_connector.c   | 46 +++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h       | 13 +++++++++
>  3 files changed, 61 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atom=
ic_uapi.c
> index 7ae4e40936b5..bb78da2405f9 100644
> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> @@ -875,6 +875,8 @@ drm_atomic_connector_get_property(struct drm_connecto=
r *connector,
>  		*val =3D state->max_requested_bpc;
>  	} else if (property =3D=3D connector->active_bpc_property) {
>  		*val =3D state->active_bpc;
> +	} else if (property =3D=3D connector->active_color_format_property) {
> +		*val =3D state->active_color_format;
>  	} else if (connector->funcs->atomic_get_property) {
>  		return connector->funcs->atomic_get_property(connector,
>  				state, property, val);
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index c0c3c09bfed0..f4f35c4117b6 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -887,6 +887,14 @@ static const struct drm_prop_enum_list drm_dp_subcon=
nector_enum_list[] =3D {
>  	{ DRM_MODE_SUBCONNECTOR_Native,	     "Native"    }, /* DP */
>  };
> =20
> +static const struct drm_prop_enum_list drm_color_format_enum_list[] =3D {
> +	{ 0, "none" },
> +	{ DRM_COLOR_FORMAT_RGB444, "rgb" },
> +	{ DRM_COLOR_FORMAT_YCRCB444, "ycbcr444" },
> +	{ DRM_COLOR_FORMAT_YCRCB422, "ycbcr422" },
> +	{ DRM_COLOR_FORMAT_YCRCB420, "ycbcr420" },
> +};
> +
>  DRM_ENUM_NAME_FN(drm_get_dp_subconnector_name,
>  		 drm_dp_subconnector_enum_list)
> =20
> @@ -1202,6 +1210,14 @@ static const struct drm_prop_enum_list dp_colorspa=
ces[] =3D {
>   *	display engine and connected monitor, and the "max bpc" property.
>   *	Drivers shall use drm_connector_attach_active_bpc_property() to insta=
ll
>   *	this property.
> +
> + * active color format:
> + *	This read-only property tells userspace the color format actually used
> + *	by the hardware display engine on "the cable" on a connector. The cho=
sen
> + *	value depends on hardware capabilities, both display engine and
> + *	connected monitor. Drivers shall use
> + *	drm_connector_attach_active_color_format_property() to install this
> + *	property.

Hi,

I think also the enum values should be documented in the UAPI docs. Or
listed at the very least. Otherwise userspace developers "do not know"
what strings to decode.


Thanks,
pq


>   *
>   * Connectors also have one standardized atomic property:
>   *
> @@ -2191,6 +2207,36 @@ int drm_connector_attach_active_bpc_property(struc=
t drm_connector *connector,
>  }
>  EXPORT_SYMBOL(drm_connector_attach_active_bpc_property);
> =20
> +/**
> + * drm_connector_attach_active_color_format_property - attach "active co=
lor format" property
> + * @connector: connector to attach active color format property on.
> + *
> + * This is used to check the applied color format on a connector.
> + *
> + * Returns:
> + * Zero on success, negative errno on failure.
> + */
> +int drm_connector_attach_active_color_format_property(struct drm_connect=
or *connector)
> +{
> +	struct drm_device *dev =3D connector->dev;
> +	struct drm_property *prop;
> +
> +	prop =3D connector->active_color_format_property;
> +	if (!prop) {
> +		prop =3D drm_property_create_enum(dev, 0, "active color format", drm_c=
olor_format_enum_list, ARRAY_SIZE(drm_color_format_enum_list));
> +		if (!prop)
> +			return -ENOMEM;
> +
> +		connector->active_color_format_property =3D prop;
> +	}
> +
> +	drm_object_attach_property(&connector->base, prop, 0);
> +	connector->state->active_color_format =3D 0;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_connector_attach_active_color_format_property);
> +
>  /**
>   * drm_connector_set_vrr_capable_property - sets the variable refresh ra=
te
>   * capable property for a connector
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index c58cba2b6afe..167cd36129ae 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -788,6 +788,12 @@ struct drm_connector_state {
>  	 */
>  	u8 active_bpc;
> =20
> +	/**
> +	 * active_color_format: Read only property set by the GPU driver to the
> +	 * actually used color format after evaluating all hardware limitations.
> +	 */
> +	u32 active_color_format;
> +
>  	/**
>  	 * @hdr_output_metadata:
>  	 * DRM blob property for HDR output metadata
> @@ -1393,6 +1399,12 @@ struct drm_connector {
>  	 */
>  	struct drm_property *active_bpc_property;
> =20
> +	/**
> +	 * @active_color_format_property: Default connector property for the
> +	 * active color format to be driven out of the connector.
> +	 */
> +	struct drm_property *active_color_format_property;
> +
>  #define DRM_CONNECTOR_POLL_HPD (1 << 0)
>  #define DRM_CONNECTOR_POLL_CONNECT (1 << 1)
>  #define DRM_CONNECTOR_POLL_DISCONNECT (1 << 2)
> @@ -1713,6 +1725,7 @@ int drm_connector_attach_max_bpc_property(struct dr=
m_connector *connector,
>  					  int min, int max);
>  int drm_connector_attach_active_bpc_property(struct drm_connector *conne=
ctor,
>  					  int min, int max);
> +int drm_connector_attach_active_color_format_property(struct drm_connect=
or *connector);
> =20
>  /**
>   * struct drm_tile_group - Tile group metadata


--Sig_/A0zawA.ljA68TAxQdb2Sl2J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmDByUEACgkQI1/ltBGq
qqcDsBAAoZ37FOS1kD4IHt354PTB/cEH2cwQYzIr2HmJT5Goehl7zJzKwH3nUfhv
8XBsNC2bKnizZ/sY7LletT2Rs1bWWmAUY9VmRTmE4wH2/rXHdyTpXhekpdGe4lFP
hWCi7dhw65t8pHNN4XCkCpoQ2aFO+UroE7r4uN7A+cwRQOpqK4Honh7Vgf2dk2IK
ywDySVE1f4n7TI+xOdgbfF8cgBO3dYgmJWZ1vnu6vq0uKFFZ+WLPMcTb0kK+Z6pf
O9ljxlA0gDfTwnOleQ25h3QHJrTNNNoYdgwxLv2mZbAKZdar9NGK0QK4xmUZxtid
YpdHyg2c7odJ1vtqR27my84PTvogHceZ4IrxHvbPfB6kwdscmLf8jNYzuF19JgzA
LbkePNb4AFGVxiaehMhOlxI08iVfy/qGFg2dYkOvxAPtYwdFKVe/RcfURBZ38dL/
pdejjwEryY+wTF+a6CTHeCvHkqtoAXdU+v8pAvvWPQG/U/z5XyOtu/FnyEsrr9cN
2Ym5b07q7IegW+Zw7/6aZJjl4MkxKuKlh3wL41necM4mSs70dYBLrzs18L3fAr7y
xAlwpImABIx/rGtvjD+iAEUgXwrzdTdyWG0XTjSoNUJSnakJXzsNbCkLXyhmcjH5
vmn3NcgravqYxIKozewO8aBAQ4iD1P9ZzCbZodZOo0SP/J3OvOU=
=N+iF
-----END PGP SIGNATURE-----

--Sig_/A0zawA.ljA68TAxQdb2Sl2J--

--===============0394674457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0394674457==--
