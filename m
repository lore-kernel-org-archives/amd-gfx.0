Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F95FC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 May 2022 11:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D498610E29F;
	Fri, 13 May 2022 11:25:40 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6D4610E29F
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 May 2022 11:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=djr53grlmSrQ3k9xAfzC+E2tmbVjDipDHj3EKWoHTkY=; b=iXIjJDZgmTuMHSLQfKcDwh8Uj4
 pM1xKQb3jhsJK34CYnt3KTI3TG8G1LgmLivxkNVEHKCozJptvZGb0TWV+sXx4XxWmp3Kum8TJ1O30
 WRT8XkRZyXMboSTQAQXUdo6fqDtfWmh/UreYA+/P+bywMQ+ROrp6Z4KP4YaC+LXBZryopYmrmhiD/
 oCyYBc7GYTgpcWM/BKsgWidvlCY3oXxifhWAPvZ0BD06ZXBueFdpYQaOvv/etbl9DTfoUs+B1b+zk
 tEPP7lVQVHVl1ERfK/YFmotBndQMdn67R7xaeJl+4odnm+sSGcPrXvNFjBgNjnqj9FgK6YoVlML9n
 pGtQ5VRw==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1npTQI-001gcK-Cf; Fri, 13 May 2022 13:25:30 +0200
Date: Fri, 13 May 2022 10:25:18 -0100
From: Melissa Wen <mwen@igalia.com>
To: Sung Joon Kim <Sungjoon.Kim@amd.com>
Subject: Re: [PATCH] drm/amd/display: add Coverage blend mode for overlay plane
Message-ID: <20220513112500.ckytxldsewebl5fa@mail.igalia.com>
References: <20220512204746.4533-1-Sungjoon.Kim@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kuoepcf3nfgithyo"
Content-Disposition: inline
In-Reply-To: <20220512204746.4533-1-Sungjoon.Kim@amd.com>
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


--kuoepcf3nfgithyo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05/12, Sung Joon Kim wrote:
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
Hi,

Thanks, enabling coverage mode is great.

I also verify that adding coverage support enables IGT
kms_plane_alpha_blend subtests for coverage blend mode (coverage-7efc
and coverage-vs-premult-vs-constant). Can you include it in the commit
description?

Regarding results, coverage-vs-premult-vs-constant is succesful and I
think coverage-7efc fails for the same issues that led me to refactor
the alpha-7efc in the past.

It'd also be nice to say here the issue on AMD issue tracker this patch
addresses.
>=20
> Reference:
> https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#plane-composition-p=
roperties
>=20
> Signed-off-by: Sung Joon Kim <Sungjoon.Kim@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 17 ++++++++++++-----
>  drivers/gpu/drm/amd/display/dc/dc.h             |  2 ++
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c  | 15 +++++++++------
>  3 files changed, 23 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2ea20dd7fccf..48a179182d22 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5380,17 +5380,19 @@ fill_plane_buffer_attributes(struct amdgpu_device=
 *adev,
> =20
>  static void
>  fill_blending_from_plane_state(const struct drm_plane_state *plane_state,
> -			       bool *per_pixel_alpha, bool *global_alpha,
> -			       int *global_alpha_value)
> +			       bool *per_pixel_alpha, bool *alpha_not_pre_multiplied,
> +			       bool *global_alpha, int *global_alpha_value)
>  {
>  	*per_pixel_alpha =3D false;
> +	*alpha_not_pre_multiplied =3D false;
Why not use `pre_multiplied_alpha` to follow the same name in mpcc blnd_cfg=
=2Epre_multiplied_alpha?
>  	*global_alpha =3D false;
>  	*global_alpha_value =3D 0xff;
> =20
>  	if (plane_state->plane->type !=3D DRM_PLANE_TYPE_OVERLAY)
>  		return;
> =20
> -	if (plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_PREMULTI) {
> +	if (plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_PREMULTI ||
> +		plane_state->pixel_blend_mode =3D=3D DRM_MODE_BLEND_COVERAGE) {
code style: aligment should match open parenthesis ^
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
> +			*alpha_not_pre_multiplied =3D true;
>  	}
> =20
>  	if (plane_state->alpha < 0xffff) {
> @@ -5567,7 +5572,7 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *a=
dev,
>  		return ret;
> =20
>  	fill_blending_from_plane_state(
> -		plane_state, &plane_info->per_pixel_alpha,
> +		plane_state, &plane_info->per_pixel_alpha, &plane_info->alpha_not_pre_=
multiplied,
>  		&plane_info->global_alpha, &plane_info->global_alpha_value);
> =20
>  	return 0;
> @@ -5614,6 +5619,7 @@ static int fill_dc_plane_attributes(struct amdgpu_d=
evice *adev,
>  	dc_plane_state->tiling_info =3D plane_info.tiling_info;
>  	dc_plane_state->visible =3D plane_info.visible;
>  	dc_plane_state->per_pixel_alpha =3D plane_info.per_pixel_alpha;
> +	dc_plane_state->alpha_not_pre_multiplied =3D plane_info.alpha_not_pre_m=
ultiplied;
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
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/di=
splay/dc/dc.h
> index 26c24db8f1da..714047d0c4f9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1011,6 +1011,7 @@ struct dc_plane_state {
> =20
>  	bool is_tiling_rotated;
>  	bool per_pixel_alpha;
> +	bool alpha_not_pre_multiplied;
>  	bool global_alpha;
>  	int  global_alpha_value;
>  	bool visible;
> @@ -1045,6 +1046,7 @@ struct dc_plane_info {
>  	bool horizontal_mirror;
>  	bool visible;
>  	bool per_pixel_alpha;
> +	bool alpha_not_pre_multiplied;
>  	bool global_alpha;
>  	int  global_alpha_value;
>  	bool input_csc_enabled;
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers=
/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> index e1f87bd72e4a..e541fe85c455 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> @@ -2346,12 +2346,15 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe=
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
> +		blnd_cfg.pre_multiplied_alpha =3D pipe_ctx->plane_state->alpha_not_pre=
_multiplied ? false : true;
so, `pre_multiplied_alpha` is easier to follow/handle than
`alpha_not_pre_multiplied` here.
> +		if (pipe_ctx->plane_state->global_alpha) {
> +			blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINE=
D_GLOBAL_GAIN;
> +			blnd_cfg.global_gain =3D pipe_ctx->plane_state->global_alpha_value;
> +		} else
> +			blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
code style: else statement needs braces to be balanced to if clause
>  	} else {
> +		blnd_cfg.pre_multiplied_alpha =3D false;
>  		blnd_cfg.alpha_mode =3D MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;
>  	}
> =20
> @@ -2365,7 +2368,7 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_c=
tx *pipe_ctx)
>  	blnd_cfg.top_gain =3D 0x1f000;
>  	blnd_cfg.bottom_inside_gain =3D 0x1f000;
>  	blnd_cfg.bottom_outside_gain =3D 0x1f000;
> -	blnd_cfg.pre_multiplied_alpha =3D per_pixel_alpha;
> +=09
>  	if (pipe_ctx->plane_state->format
>  			=3D=3D SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA)
>  		blnd_cfg.pre_multiplied_alpha =3D false;
I'm not an AMD expert, but should coverage mode also apply to dcn10 and
therefore should this change be expanded to 1.0 family too? I just
remember this recomendation from a previous related patch.

Thanks,

Melissa
> --=20
> 2.20.1
>=20

--kuoepcf3nfgithyo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmJ+QB4ACgkQwqF3j0dL
ehyneBAAihrmaJ54XOCB2SkPj4WYLPnBBocyxAd9LLXkJZRp01nrQfunuup31UrG
gDrFNGcaoZOY9yjxRxeMRK8v19/dQPzwbUY9aMjytMzVjz0Gq0uqhDM2sd69H1Gf
r+zVtGUmI2qcnTEJGFTzT+gQ7lAfV2JyGgvISVSys5N17PZcKG52kCqgqmR9VQ/Q
JHXSJ95uAlt4+O+Surom0wkAxtZbRhzhCGZN+sAxhoJdQOKvvCUMNhCiynUZ5tHn
jNnmSSqUpsPmKn//Csvr4nS/osMTXFv8ihNMALnPLMPmd01TmBK9W67Xoi/tBUcZ
GK4e6sUq6CC8ylrI6VlUJMJQFAGOpSv8Q5Uf2W/EMXTIJLla89/vgqtgLd9uMVPU
cXsEgHJIcf5iCJOTkSqrdJB1NEOa/+YuPDDO0IfASjgrsJ/o9m142B0/L0R+loW1
9nPoNG6ITJFMTTmXZKgYfqT4DpFq+wRWbEOPNmdu9bAnHxs9AiKbqDcYV8Q4iJ2L
rzGa8L4VzUvH7z5uqiF1AH5XK/cMWKeSvy9zZMDS9OKyXFPqOUjBeRwEW6AEZple
z1JT8L5GPl3B946FRP3DMJjAEywc8xo5s5ceh6tbb7oBkw8Q302MkiQZkxujHq1q
44VxZnwSQzEFeEJDyE76pGv5TxUhHZ8Uz+7RIHYM7FJjV2ggJbo=
=wR5l
-----END PGP SIGNATURE-----

--kuoepcf3nfgithyo--
