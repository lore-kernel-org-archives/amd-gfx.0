Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B970C004D4
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 18:15:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DCD210E1D2;
	Thu, 19 Jan 2023 18:15:21 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8B010E1D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oV/cT3RB8nK9a00M22Yd8GIXpFdY3NRB7fTA5xuV+PA=; b=UZfidR4j55DjStTJ8St8WB3TGL
 Spajq6neSEHsUM3B50M7BRg6c1jT/9/iEgFU5db2PaQwu8Hvb+I2z7AGfBMR9VAXcvCkJmN3XxfNl
 2O112IqPG1z/oTC3gmCo53tfhRSsUNDcn6ddzYDIr9VjEjFj0wbhWqKr0m/jEzMxwESu2jyvAqM0N
 tpojaDsa4kJCt9IieDQhmhcdJ4k1C7/9yhkyfkqznB0HqF2Uf0rGh65QnUz4hu2nSA27uH1GJ8Rf0
 LvjHSUYwYEgQoZSzH5qYkuVQmtomRPeoUlxegQCIxHsvXVhAq+fINSgO5hQ6TVfqiNeofSRIvtBS4
 0sD2Teig==;
Received: from [38.44.66.31] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pIZRV-00CX9p-2h; Thu, 19 Jan 2023 19:15:17 +0100
Date: Thu, 19 Jan 2023 17:14:58 -0100
From: Melissa Wen <mwen@igalia.com>
To: Joshua Ashton <joshua@froggi.es>
Subject: Re: [PATCH 1/2] drm/amd/display: Hook up 'content type' property for
 HDMI
Message-ID: <20230119181458.n4divmninme7o3dr@mail.igalia.com>
References: <20230117212620.11262-1-joshua@froggi.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="e4x3r6nzmbsofjlw"
Content-Disposition: inline
In-Reply-To: <20230117212620.11262-1-joshua@froggi.es>
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--e4x3r6nzmbsofjlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01/17, Joshua Ashton wrote:
> Implements the 'content type' property for HDMI connectors.
> Verified by checking the avi infoframe on a connected TV.
>=20
> This also simplifies a lot of the code in that area as well, there were
> a lot of temp variables doing very little and unnecessary logic
> that was quite confusing.
>=20
> It is not necessary to check for support in the EDID before sending a
> 'content type' value in the avi infoframe also.
>=20
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++
>  .../gpu/drm/amd/display/dc/core/dc_resource.c | 69 ++++++-------------
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
>  3 files changed, 46 insertions(+), 48 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9547037857b6..999965fe3de9 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5216,6 +5216,24 @@ get_output_color_space(const struct dc_crtc_timing=
 *dc_crtc_timing)
>  	return color_space;
>  }
> =20
> +static enum display_content_type
> +get_output_content_type(const struct drm_connector_state *connector_stat=
e)
> +{
> +	switch (connector_state->content_type) {
> +	default:
> +	case DRM_MODE_CONTENT_TYPE_NO_DATA:
> +		return DISPLAY_CONTENT_TYPE_NO_DATA;
> +	case DRM_MODE_CONTENT_TYPE_GRAPHICS:
> +		return DISPLAY_CONTENT_TYPE_GRAPHICS;
> +	case DRM_MODE_CONTENT_TYPE_PHOTO:
> +		return DISPLAY_CONTENT_TYPE_PHOTO;
> +	case DRM_MODE_CONTENT_TYPE_CINEMA:
> +		return DISPLAY_CONTENT_TYPE_CINEMA;
> +	case DRM_MODE_CONTENT_TYPE_GAME:
> +		return DISPLAY_CONTENT_TYPE_GAME;
> +	}
> +}
> +
>  static bool adjust_colour_depth_from_display_info(
>  	struct dc_crtc_timing *timing_out,
>  	const struct drm_display_info *info)
> @@ -5349,6 +5367,7 @@ static void fill_stream_properties_from_drm_display=
_mode(
>  	}
> =20
>  	stream->output_color_space =3D get_output_color_space(timing_out);
> +	stream->content_type =3D get_output_content_type(connector_state);
>  }
> =20
>  static void fill_audio_info(struct audio_info *audio_info,
> @@ -7123,6 +7142,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu=
_display_manager *dm,
>  				adev->mode_info.abm_level_property, 0);
>  	}
> =20
> +	if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA) {
> +		/* Content Type is currently only implemented for HDMI. */
> +		drm_connector_attach_content_type_property(&aconnector->base);
> +	}
> +
>  	if (connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA ||
>  	    connector_type =3D=3D DRM_MODE_CONNECTOR_DisplayPort ||
>  	    connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) {
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index a5b5f8592c1b..39ceccdb6586 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -2944,14 +2944,9 @@ static void set_avi_info_frame(
>  	uint32_t pixel_encoding =3D 0;
>  	enum scanning_type scan_type =3D SCANNING_TYPE_NODATA;
>  	enum dc_aspect_ratio aspect =3D ASPECT_RATIO_NO_DATA;
> -	bool itc =3D false;
> -	uint8_t itc_value =3D 0;
> -	uint8_t cn0_cn1 =3D 0;
> -	unsigned int cn0_cn1_value =3D 0;
>  	uint8_t *check_sum =3D NULL;
>  	uint8_t byte_index =3D 0;
>  	union hdmi_info_packet hdmi_info;
> -	union display_content_support support =3D {0};
>  	unsigned int vic =3D pipe_ctx->stream->timing.vic;
>  	unsigned int rid =3D pipe_ctx->stream->timing.rid;
>  	unsigned int fr_ind =3D pipe_ctx->stream->timing.fr_index;
> @@ -3055,49 +3050,27 @@ static void set_avi_info_frame(
>  	/* Active Format Aspect ratio - same as Picture Aspect Ratio. */
>  	hdmi_info.bits.R0_R3 =3D ACTIVE_FORMAT_ASPECT_RATIO_SAME_AS_PICTURE;
> =20
> -	/* TODO: un-hardcode cn0_cn1 and itc */
> -
> -	cn0_cn1 =3D 0;
> -	cn0_cn1_value =3D 0;
> -
> -	itc =3D true;
> -	itc_value =3D 1;
> -
> -	support =3D stream->content_support;
> -
> -	if (itc) {
> -		if (!support.bits.valid_content_type) {
> -			cn0_cn1_value =3D 0;
> -		} else {
> -			if (cn0_cn1 =3D=3D DISPLAY_CONTENT_TYPE_GRAPHICS) {
> -				if (support.bits.graphics_content =3D=3D 1) {
> -					cn0_cn1_value =3D 0;
> -				}
> -			} else if (cn0_cn1 =3D=3D DISPLAY_CONTENT_TYPE_PHOTO) {
> -				if (support.bits.photo_content =3D=3D 1) {
> -					cn0_cn1_value =3D 1;
> -				} else {
> -					cn0_cn1_value =3D 0;
> -					itc_value =3D 0;
> -				}
> -			} else if (cn0_cn1 =3D=3D DISPLAY_CONTENT_TYPE_CINEMA) {
> -				if (support.bits.cinema_content =3D=3D 1) {
> -					cn0_cn1_value =3D 2;
> -				} else {
> -					cn0_cn1_value =3D 0;
> -					itc_value =3D 0;
> -				}
> -			} else if (cn0_cn1 =3D=3D DISPLAY_CONTENT_TYPE_GAME) {
> -				if (support.bits.game_content =3D=3D 1) {
> -					cn0_cn1_value =3D 3;
> -				} else {
> -					cn0_cn1_value =3D 0;
> -					itc_value =3D 0;
> -				}
> -			}
> -		}
> -		hdmi_info.bits.CN0_CN1 =3D cn0_cn1_value;
> -		hdmi_info.bits.ITC =3D itc_value;
> +	switch (stream->content_type) {
> +	case DISPLAY_CONTENT_TYPE_NO_DATA:
> +		hdmi_info.bits.CN0_CN1 =3D 0;
> +		hdmi_info.bits.ITC =3D 0;
Hmm.. why is ITC value equal zero here ^, instead of the same hardcoded
`itc_value =3D 1`? Does it come from a DRM default value?

Other than that, changes seem fine to me and it's nice to see the code
wired to the DRM and actually used.

CC'ing other AMD DC folks since I don't know if these changes affect
other platforms. Can you guys verify it?

> +		break;
> +	case DISPLAY_CONTENT_TYPE_GRAPHICS:
> +		hdmi_info.bits.CN0_CN1 =3D 0;
> +		hdmi_info.bits.ITC =3D 1;
> +		break;
> +	case DISPLAY_CONTENT_TYPE_PHOTO:
> +		hdmi_info.bits.CN0_CN1 =3D 1;
> +		hdmi_info.bits.ITC =3D 1;
> +		break;
> +	case DISPLAY_CONTENT_TYPE_CINEMA:
> +		hdmi_info.bits.CN0_CN1 =3D 2;
> +		hdmi_info.bits.ITC =3D 1;
> +		break;
> +	case DISPLAY_CONTENT_TYPE_GAME:
> +		hdmi_info.bits.CN0_CN1 =3D 3;
> +		hdmi_info.bits.ITC =3D 1;
> +		break;
>  	}
> =20
>  	if (stream->qs_bit =3D=3D 1) {
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm=
/amd/display/dc/dc_stream.h
> index ef33d7d8a2bf..51dc30706e43 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -205,6 +205,7 @@ struct dc_stream_state {
>  	struct dc_csc_transform csc_color_matrix;
> =20
>  	enum dc_color_space output_color_space;
> +	enum display_content_type content_type;
>  	enum dc_dither_option dither_option;
> =20
>  	enum view_3d_format view_format;
> --=20
> 2.39.0
>=20

--e4x3r6nzmbsofjlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmPJiJwACgkQwqF3j0dL
ehyWiBAAwYBiWLbxVENcI48F1Y3GViMMBR2UY5cMeSDAQUNNuQQbHrkeVq9O1aLL
jP5Y/FZ3umLKG977Us/FDUeM9QspwgL+imhqxxQvOh/8ZLeTR2UERv7TQt8uR9zd
davqr8NGF+dx9jZ0LYHL7Z0Ixnl/szRVewYhyDgm6ZdN0nrfUW2sUNGbJlrnzcDc
bWGP3gwgvWtRs+PfAoXZLKm7tg5Pu1U+E6AUV7T6kL79bzQ/34N1lWuD/EhYaHaq
SGMSXVCiTl9YaHVXouVJeYeUWfJRRI00n9xkQ2E1f2iF8xxb3wghtebZGG8nnA6b
qlIqDqDitjj8djZAd2Kgh7wDZKNBFG+o09VUSPDxqaQ8NRJDqaOmzN8PEbL501s3
Zc0TgDOS1PpXl9iZ0SkvyvdRFInM2lotDAturqk0oOn4foJdKPuymiaGSONiI9i3
TnP/4dheZdH2XXXetkSlhBM+McFrkoWUNDpdzSJYQVGfjlLZxZuvip0msOsV0r3z
NT2Ea0IJnur0U4Ia9ZU5fZ4mgO1TfrWUdsiukTeSrRjSkyP+N5peHTWsdvHz5O7c
QsEBmAXiD9gw6/T46uOCuJFkcS+JMZpympfqZGSakaLDzLo786jjEK6Kj+Hj/3Ek
jJCb9AYCg9X2Wuh6gjQ+/Lv/qaFxFGkLT22e5/TGMbxxec58nDc=
=YnWK
-----END PGP SIGNATURE-----

--e4x3r6nzmbsofjlw--
