Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16760C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 19 May 2022 20:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F1DE10E33D;
	Thu, 19 May 2022 20:00:35 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C4F710E33D
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 May 2022 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TdBdhwWSWCxibwzGzJ3ITKkzOhwaoVLOK9exnnk9c0c=; b=USSfqflnViOv6yMt53KboLpCPo
 Uq8We5G2mjZQLtUk9dym3f41RLET+ie9SNuKbweTq1sDmjOmVjX+GT81k1m8uqMA4ZBV+8Ma6/Ar4
 3fvpcfvYSurBYmV1b/PPdCMukG1UU+6EmEOzNex6M64piggvIHbDtqzHd0SLicIYDskKcJZJQbmh7
 y2SWn8RBSuPDIhXP13gRBER4fA9FQjozriKqs1+uFj2AItfj6eEa/pQToJ9nlSKVdQur2cJmv5MhP
 iElLwa91BLU/eJu7Ex1Unr04kPHvDTVQLPaBXDSW/rXShOgVq20bDaB/RPiMwjgC6xdJvzBVgRIPv
 HXZqCC9A==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1nrmJy-00Be8F-HJ; Thu, 19 May 2022 22:00:30 +0200
Date: Thu, 19 May 2022 19:00:10 -0100
From: Melissa Wen <mwen@igalia.com>
To: Sung Joon Kim <Sungjoon.Kim@amd.com>
Subject: Re: [PATCH v2] drm/amd/display: add Coverage blend mode for overlay
 plane
Message-ID: <20220519200010.h2xw6s5ma6lj5x3z@mail.igalia.com>
References: <20220513202200.4698-1-Sungjoon.Kim@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jdf5v4xyiwgbkxx6"
Content-Disposition: inline
In-Reply-To: <20220513202200.4698-1-Sungjoon.Kim@amd.com>
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
Cc: sunpeng.li@amd.com, contact@emersion.fr, rodrigo.siqueira@amd.com,
 amd-gfx@lists.freedesktop.org, markyacoub@chromium.org,
 alexander.deucher@amd.com, harry.wentland@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--jdf5v4xyiwgbkxx6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/13, Sung Joon Kim wrote:
> Issue fixed: Overlay plane alpha channel blending is incorrect
>=20
> Issue tracker: https://gitlab.freedesktop.org/drm/amd/-/issues/1769
>=20
> According to the KMS man page, there is a
> "Coverage" alpha blend mode that assumes the
> pixel color values have NOT been pre-multiplied
> and will be done when the actual blending to
> the background color values happens.
>=20
> Previously, this mode hasn't been enabled
> in our driver and it was assumed that all
> normal overlay planes are pre-multiplied
> by default.
>=20
> When a 3rd party app is used to input a image
> in a specific format, e.g. PNG, as a source
> of a overlay plane to blend with the background
> primary plane, the pixel color values are not
> pre-multiplied. So by adding "Coverage" blend
> mode, our driver will support those cases.
>=20
Hi,

overall lgtm. I would move those "Issue" points to here (after change
description).

> Reference:
> https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#plane-composition-p=
roperties
>=20
> Adding Coverage support also enables IGT
> kms_plane_alpha_blend Coverage subtests:
> 1. coverage-7efc
> 2. coverage-vs-premult-vs-constant

=2E. and include a summary of changes from v1 here.
>=20
> Signed-off-by: Sung Joon Kim <Sungjoon.Kim@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 17 ++++++++----
>  .../gpu/drm/amd/display/dc/core/dc_surface.c  |  2 ++
>  drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
>  .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 27 ++++++++++---------
>  .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 16 ++++++-----
>  5 files changed, 40 insertions(+), 24 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2ea20dd7fccf..af2b5d232742 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5380,17 +5380,19 @@ fill_plane_buffer_attributes(struct amdgpu_device=
 *adev,
> =20
>  static void
>  fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
> -			       bool *per_pixel_alpha, bool *global_alpha,
> -			       int *global_alpha_value)
> +			       bool *per_pixel_alpha, bool *pre_multiplied_alpha,
> +			       bool *global_alpha, int *global_alpha_value)
>  {
>  	*per_pixel_alpha =3D false;
> +	*pre_multiplied_alpha =3D true;
>  	*global_alpha =3D false;
>  	*global_alpha_value =3D 0xff;
> =20
>  	if (plane_state->plane->type !=3D DRM_PLANE_TYPE_OVERLAY)
>  		return;
> =20
> -	if (plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_PREMULTI) {
> +	if (plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_PREMULTI ||
> +		plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_COVERAGE) {
>  		static const uint32_t alpha_formats[] =3D {
>  			DRM_FORMAT_ARGB8888,
>  			DRM_FORMAT_RGBA8888,
> @@ -5405,6 +5407,9 @@ fill_blending_from_plane_state(const struct drm_pla=
ne_state *plane_state,
>  				break;
>  			}
>  		}
> +
> +		if (per_pixel_alpha && plane_state->pixel_blend_mode =3D=3D DRM_MODE_B=
LEND_COVERAGE)
> +			*pre_multiplied_alpha =3D false;
>  	}
> =20
>  	if (plane_state->alpha < 0xffff) {
> @@ -5567,7 +5572,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *a=
dev,
>  		return ret;
> =20
>  	fill_blending_from_plane_state(
> -		plane_state, &plane_info->per_pixel_alpha,
> +		plane_state, &plane_info->per_pixel_alpha, &plane_info->pre_multiplied=
_alpha,
>  		&plane_info->global_alpha, &plane_info->global_alpha_value);
> =20
>  	return 0;
> @@ -5614,6 +5619,7 @@ static int fill_dc_plane_attributes(struct amdgpu_d=
evice *adev,
>  	dc_plane_state->tiling_info =3D plane_info.tiling_info;
>  	dc_plane_state->visible =3D plane_info.visible;
>  	dc_plane_state->per_pixel_alpha =3D plane_info.per_pixel_alpha;
> +	dc_plane_state->pre_multiplied_alpha =3D plane_info.pre_multiplied_alph=
a;
>  	dc_plane_state->global_alpha =3D plane_info.global_alpha;
>  	dc_plane_state->global_alpha_value =3D plane_info.global_alpha_value;
>  	dc_plane_state->dcc =3D plane_info.dcc;
> @@ -7905,7 +7911,8 @@ static int amdgpu_dm_plane_init(struct amdgpu_displ=
ay_manager *dm,
>  	if (plane->type =3D=3D DRM_PLANE_TYPE_OVERLAY &&
>  	    plane_cap && plane_cap->per_pixel_alpha) {
>  		unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> -					  BIT(DRM_MODE_BLEND_PREMULTI);
> +					  BIT(DRM_MODE_BLEND_PREMULTI) |
> +					  BIT(DRM_MODE_BLEND_COVERAGE);
> =20
>  		drm_plane_create_alpha_property(plane);
>  		drm_plane_create_blend_mode_property(plane, blend_caps);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_surface.c
> index e6b9c6a71841..5bc6ff2fa73e 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -61,6 +61,8 @@ static void dc_plane_construct(struct dc_context *ctx, =
struct dc_plane_state *pl
>  		plane_state->blend_tf->type =3D TF_TYPE_BYPASS;
>  	}
> =20
> +	plane_state->pre_multiplied_alpha =3D true;
> +
>  }
> =20
>  static void dc_plane_destruct(struct dc_plane_state *plane_state)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index 26c24db8f1da..c353842d5c40 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1011,6 +1011,7 @@ struct dc_plane_state {
> =20
>  	bool is_tiling_rotated;
>  	bool per_pixel_alpha;
> +	bool pre_multiplied_alpha;
>  	bool global_alpha;
>  	int  global_alpha_value;
>  	bool visible;
> @@ -1045,6 +1046,7 @@ struct dc_plane_info {
>  	bool horizontal_mirror;
>  	bool visible;
>  	bool per_pixel_alpha;
> +	bool pre_multiplied_alpha;
>  	bool global_alpha;
>  	int  global_alpha_value;
>  	bool input_csc_enabled;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/=
drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index e02ac75afbf7..e3a62873c0e7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -2550,12 +2550,21 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe=
_ctx *pipe_ctx)
>  	blnd_cfg.overlap_only =3D false;
>  	blnd_cfg.global_gain =3D 0xff;
> =20
> -	if (per_pixel_alpha && pipe_ctx->plane_state->global_alpha) {
> -		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED=
_GLOBAL_GAIN;
> -		blnd_cfg.global_gain =3D pipe_ctx->plane_state->global_alpha_value;
> -	} else if (per_pixel_alpha) {
> -		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
> +	if (per_pixel_alpha) {
> +		/* DCN1.0 has output CM before MPC which seems to screw with
> +		 * pre-multiplied alpha.
> +		 */
> +		blnd_cfg.pre_multiplied_alpha =3D (is_rgb_cspace(
> +				pipe_ctx->stream->output_color_space)
> +						&& pipe_ctx->plane_state->pre_multiplied_alpha);
> +		if (pipe_ctx->plane_state->global_alpha) {
> +			blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINE=
D_GLOBAL_GAIN;
> +			blnd_cfg.global_gain =3D pipe_ctx->plane_state->global_alpha_value;
> +		} else {
> +			blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
> +		}
>  	} else {
> +		blnd_cfg.pre_multiplied_alpha =3D false;
>  		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;
>  	}
> =20
> @@ -2564,14 +2573,6 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_=
ctx *pipe_ctx)
>  	else
>  		blnd_cfg.global_alpha =3D 0xff;
> =20
> -	/* DCN1.0 has output CM before MPC which seems to screw with
> -	 * pre-multiplied alpha.
> -	 */
> -	blnd_cfg.pre_multiplied_alpha =3D is_rgb_cspace(
> -			pipe_ctx->stream->output_color_space)
> -					&& per_pixel_alpha;
> -
> -
>  	/*
>  	 * TODO: remove hack
>  	 * Note: currently there is a bug in init_hw such that
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers=
/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> index e1f87bd72e4a..c117830b8b9d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> @@ -2346,12 +2346,16 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe=
_ctx *pipe_ctx)
>  	blnd_cfg.overlap_only =3D false;
>  	blnd_cfg.global_gain =3D 0xff;
> =20
> -	if (per_pixel_alpha && pipe_ctx->plane_state->global_alpha) {
> -		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED=
_GLOBAL_GAIN;
> -		blnd_cfg.global_gain =3D pipe_ctx->plane_state->global_alpha_value;
> -	} else if (per_pixel_alpha) {
> -		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
> +	if (per_pixel_alpha) {
> +		blnd_cfg.pre_multiplied_alpha =3D pipe_ctx->plane_state->pre_multiplie=
d_alpha;
> +		if (pipe_ctx->plane_state->global_alpha) {
> +			blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINE=
D_GLOBAL_GAIN;
> +			blnd_cfg.global_gain =3D pipe_ctx->plane_state->global_alpha_value;
> +		} else {
> +			blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
> +		}
>  	} else {
> +		blnd_cfg.pre_multiplied_alpha =3D false;
>  		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;
>  	}
> =20
> @@ -2365,7 +2369,7 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_c=
tx *pipe_ctx)
>  	blnd_cfg.top_gain =3D 0x1f000;
>  	blnd_cfg.bottom_inside_gain =3D 0x1f000;
>  	blnd_cfg.bottom_outside_gain =3D 0x1f000;
> -	blnd_cfg.pre_multiplied_alpha =3D per_pixel_alpha;
> +=09
^ checkpatch complains about `trailing whitespace` here.

Anyway, after addressing these minor comments, the patch is

Reviewed-by: Melissa Wen <mwen@igalia.com>

Thanks a lot!

Next, I'm going to refactor the IGT coverage-7efc test to match the
changes done to alpha-7efc (pre-multiplied).

>  	if (pipe_ctx->plane_state->format
>  			=3D=3D SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA)
>  		blnd_cfg.pre_multiplied_alpha =3D false;
> --=20
> 2.20.1
>=20

--jdf5v4xyiwgbkxx6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmKGobsACgkQwqF3j0dL
ehw82g//XVJtb1ZpEYR8SDSAQnVF8mMpS+BOsywSXnHsxIg5wQZcSNOAH/wKMvsz
KToIZcjE4yqGICiPAGDV6OIJTuyGDU4ZRc9jt4EZBPGxRKKilLZroJEkWwUI97tK
hn8SD1XYgd56VkHyJyjXCSdBfo1SUum+k72LhewHoWq3esauOdiocq9ZRBiuiCoa
qlN7+UiJQkdKGTLAjUMyb5C56tqbdB1D06ueaSxtdr4wDOrC5TI83HiSmblaL7z9
+VQI0Ag9kIf+aSeHLsyW6RlbqGs7Z/dGwC1x6h4SbHmvqLkDzSl57aXpwsjpTPCZ
/Ax+WHI7Qa+ol1G/Caw2hWmhf5JryGuSX9c97ncQowTVxTQ9aQSLmdGY5blRWJu9
0GPCCBCACEzux7MYiZkvarXWCmFCkDpf5wNLunAA8CtiS1izyLpCrZBlzR5/K4Re
GJQEz1JaJFZjyLoU8nKjHtQ1yRlSeLysVJ9NE24Noqn6XIbff4OuSwtqmhgiPgas
OsSf737SmwPoOCqps4utEiTyU15KHQRZ3JHo196rz//PNdqjiIiVde0S36BYID+W
VS1BwbepOKIZxvq4ii3XGVN3Ggh3i4JXf2XQ2VlpZVBK8lAZYOwU3iLhFYE2DFUB
25VI5oZpN88D4bTxf/RqJszTyz+m698Mt3pvSAL+pgvQ6gNo8Rs=
=fT3T
-----END PGP SIGNATURE-----

--jdf5v4xyiwgbkxx6--
