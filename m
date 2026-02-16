Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597C8E81A2B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 15:16:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E776310E39A;
	Mon, 16 Feb 2026 15:16:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mNnClYqt";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 827C610E057
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 15:16:56 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-436356740e6so3928264f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 07:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771255015; x=1771859815; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OCTGVrDnYg/AvyveAGhR+o0VhL8zBJpPuCpBsOtgcI=;
 b=mNnClYqt++KefHKlw+eox1q1vv5afP11n3gTnt3YM6iX4HCOIqTAB3mLpzmdKbn0H8
 DPhM+1CYwOfe9QuhdbdYqTHLJZyCwy2rP2lY0t3YtrJJR0jFg3CXBeGf0LJhXetGyUHI
 /A821XxshZ+mpI1XTTdPe+VeFhOM2gxIBMjRgqranXFeM9du5kXUoTNoSIwx7Ujx5Wss
 NA+UAWoEzksTdtsgfXVwEDmVgKATdKY3s/ScfhfgduoaHrCGOu9yaYh47Tu4FBZNzjkH
 rgCExz4y8hlyEGoDzyF1U2sfkjzeKs5dPTqEoTUm7Yw57+mYuo2ikI/R9QEoUfNdtgK4
 hx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771255015; x=1771859815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0OCTGVrDnYg/AvyveAGhR+o0VhL8zBJpPuCpBsOtgcI=;
 b=HiEJlTrbeuGVotcGage3UAZllsMibGtLsVD62vwPh1F/39DLVhe3TsiyDHpsCyp2P9
 yBhjA8a5ySjGGWGWsIwsFpZavtn8XpplrhHD2S6ByaLHhsgPxbqCp6z9+7YoT1B3aZCb
 vT15JFy1jht0+qIuGpcR/FBn+VBH9iD/nihStH0YDms2xjUTtywGnt4wKVvrHecINk7U
 LQQijEPbXBROBOSataqs6Kw+k5oVoZYQbw8YFX1rVPf6pgsHREvEi2ahv6CR1hCprCwj
 k2BJAvBqeqngo9zuNnTHwkHOJBwx6srEMCzUF+dhzD++oLaiD8aWFvTK5OI96AZsTiUY
 CHpQ==
X-Gm-Message-State: AOJu0YyBThLbUGJhNoMxXB/6Bw2Et6yuMf9dp6IRRIgBNz61GqjphI74
 c720+e5YpLq+NiveCbClY876Ko0jH75biLDZ7HtLB+fELfKOKHDYb77lsUryiw==
X-Gm-Gg: AZuq6aI0r2mz0eSr84k1Xo/dYAGBAhuGd7Xv47wacIDREDRfqXqTCVlIhVtIFw0hedI
 pAlwOqS67NoKrZLH4k6/xOvNOdQBS0YfWxHD34f8jZldWvYTp9En6L1MDAzsLKyjH4PaOOIh7XT
 qhs3Uuj0ryDHzEzR2bktxRHO2fBnARN8FfymUvTPDWXyIOItMgVtiOfuLY2V8cJbFJ9AOooGY0M
 ZGWKihazjuzXlts2QLfCxjS3jWLWBAdUnqFIytIXJeZt0Oiv1XCevOwbBbsaUXhrRsfxI6MCAG2
 sf1sNgA7vCymF6c3jbUoOpoUiXL0WfIuUBHf6LtlDbaLS+E4oVugX4MzLq7/GWI6o06YaBqtyYU
 zdhrQ10W1bBYlj2fPQNo4DmRLY2A8a5Hy0GuHNChzzct4s4xuSxn0Zfg1NgP/+UCwg9eet+qW4A
 sJUnYcQKikDFgGo9pukVb8QwlCc94gk6qGALcK52Q5zrVmk1LczWIdWRchCOkozO35UtmHTdqVB
 Sd2/NBvvQnWIM6Ftbk3vK1bD3cgiPbDW7qJj40=
X-Received: by 2002:a05:6000:2c0c:b0:435:dba0:7c0b with SMTP id
 ffacd0b85a97d-4379db31b43mr14100534f8f.3.1771255014587; 
 Mon, 16 Feb 2026 07:16:54 -0800 (PST)
Received: from timur-max.localnet
 (20014C4E24C3010030B5FA8521127642.dsl.pool.telekom.hu.
 [2001:4c4e:24c3:100:30b5:fa85:2112:7642])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abd793sm27645432f8f.25.2026.02.16.07.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 07:16:53 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, Nicholas Carbones <ncarbone@amd.com>,
 Dillon Varone <dillon.varone@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: Re: [PATCH 13/21] drm/amd/display: Add Gfx Base Case For Linear Tiling
 Handling
Date: Mon, 16 Feb 2026 16:16:52 +0100
Message-ID: <2789997.lGaqSPkdTl@timur-max>
In-Reply-To: <20260128015538.568712-14-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
 <20260128015538.568712-14-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. janu=C3=A1r 28., szerda 2:51:38 k=C3=B6z=C3=A9p-eur=C3=B3pai t=C3=
=A9li id=C5=91 Wayne Lin wrote:
> From: Nicholas Carbones <ncarbone@amd.com>
>=20
> [Why]
> Post-driver cases always use linear tiling yet there is no dedicated
> Gfx handling for this condition.
>=20
> [How]
> Add DcGfxBase/DalGfxBase to gfx version enums and set tiling to linear
> when it is used. Also, enforce the use of proper tiling format as tiling
> information is used.
>=20
> Reviewed-by: Dillon Varone <dillon.varone@amd.com>
> Signed-off-by: Nicholas Carbones <ncarbone@amd.com>
> Signed-off-by: Wayne Lin <wayne.lin@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c          | 1 +
>  drivers/gpu/drm/amd/display/dc/core/dc.c                   | 1 +
>  drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c      | 7 +++++++
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c          | 1 +
>  drivers/gpu/drm/amd/display/dc/dc_hw_types.h               | 3 ++-
>  drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c         | 3 +++
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c | 3 +++
>  drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c       | 1 +
>  drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c     | 2 ++
>  drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c     | 2 ++
>  drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c     | 2 ++
>  drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   | 7 ++++++-
>  .../amd/display/dc/resource/dcn32/dcn32_resource_helpers.c | 3 ++-
>  13 files changed, 33 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c index
> fcc48994c3e3..333ff8557732 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8033,6 +8033,7 @@ static enum dc_status
> dm_validate_stream_and_context(struct dc *dc,
> dc_plane_state->plane_size.chroma_size.height  =3D stream->src.height;
> dc_plane_state->plane_size.chroma_size.width   =3D stream->src.width;
> dc_plane_state->format =3D SURFACE_PIXEL_FORMAT_GRPH_ARGB8888;
> +	dc_plane_state->tiling_info.gfxversion =3D DcGfxVersion9;
>  	dc_plane_state->tiling_info.gfx9.swizzle =3D DC_SW_UNKNOWN;
>  	dc_plane_state->rotation =3D ROTATION_ANGLE_0;
>  	dc_plane_state->is_tiling_rotated =3D false;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
> b/drivers/gpu/drm/amd/display/dc/core/dc.c index 4305691ba45e..441b7e0a3b=
22
> 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -2768,6 +2768,7 @@ static struct surface_update_descriptor
> get_plane_info_update_type(const struct case DcGfxVersion7:
>  		case DcGfxVersion8:
>  		case DcGfxVersionUnknown:
> +		case DcGfxBase:
>  		default:
>  			break;
>  		}
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c index
> 052d573408c3..a13d9d7dd6c5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -2065,6 +2065,13 @@ void get_surface_tile_visual_confirm_color(
>  	while (bottom_pipe_ctx->bottom_pipe !=3D NULL)
>  		bottom_pipe_ctx =3D bottom_pipe_ctx->bottom_pipe;
>=20
> +	if (bottom_pipe_ctx->plane_state->tiling_info.gfxversion =3D=3D=20
DcGfxBase) {
> +		/* LINEAR Surface - set border color to red */
> +		color->color_r_cr =3D color_value;
> +		return;
> +	}
> +
> +	ASSERT(bottom_pipe_ctx->plane_state->tiling_info.gfxversion =3D=3D
> DcGfxVersion9); switch
> (bottom_pipe_ctx->plane_state->tiling_info.gfx9.swizzle) { case
> DC_SW_LINEAR:
>  		/* LINEAR Surface - set border color to red */
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c index
> 848c267ef11e..b4e5a79e9749 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -4434,6 +4434,7 @@ enum dc_status dc_validate_global_state(
>=20
>  			if (dc->res_pool->funcs-
>patch_unknown_plane_state &&
>  					pipe_ctx->plane_state=20
&&
> +					pipe_ctx->plane_state-
>tiling_info.gfxversion =3D=3D DcGfxVersion9 &&
>  					pipe_ctx->plane_state-
>tiling_info.gfx9.swizzle =3D=3D DC_SW_UNKNOWN) {
>  				result =3D
> dc->res_pool->funcs->patch_unknown_plane_state(pipe_ctx->plane_state); if
> (result !=3D DC_OK)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h index
> cfa569a7bff1..7121629da38e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
> @@ -342,7 +342,8 @@ enum swizzle_mode_addr3_values {
>  };
>=20
>  enum dc_gfxversion {
> -	DcGfxVersion7 =3D 0,
> +	DcGfxBase =3D 0,
> +	DcGfxVersion7,
>  	DcGfxVersion8,
>  	DcGfxVersion9,
>  	DcGfxVersion10,
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c index
> 1c2009e38aa1..5df58fadc862 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
> @@ -100,6 +100,7 @@ static enum mi_bits_per_pixel get_mi_bpp(
>  static enum mi_tiling_format get_mi_tiling(
>  		struct dc_tiling_info *tiling_info)
>  {
> +	ASSERT(tiling_info->gfxversion =3D=3D DcGfxVersion8);
>  	switch (tiling_info->gfx8.array_mode) {
>  	case DC_ARRAY_1D_TILED_THIN1:
>  	case DC_ARRAY_1D_TILED_THICK:
> @@ -433,6 +434,7 @@ static void program_tiling(
>  	struct dce_mem_input *dce_mi, const struct dc_tiling_info *info)
>  {
>  	if (dce_mi->masks->GRPH_SW_MODE) { /* GFX9 */
> +		ASSERT(info->gfxversion =3D=3D DcGfxVersion9);
>  		REG_UPDATE_6(GRPH_CONTROL,
>  				GRPH_SW_MODE, info->gfx9.swizzle,
>  				GRPH_NUM_BANKS, log_2(info-
>gfx9.num_banks),
> @@ -447,6 +449,7 @@ static void program_tiling(
>  	}
>=20
>  	if (dce_mi->masks->GRPH_MICRO_TILE_MODE) { /* GFX8 */
> +		ASSERT(info->gfxversion =3D=3D DcGfxVersion8);

Hi,

GFX7 hits this assertion. Assuming that GFX7 requires the same register=20
programming as GFX8, the assertion should be changed to:

ASSERT(info->gfxversion =3D=3D DcGfxVersion7 ||
              info->gfxversion =3D=3D DcGfxVersion8);

That being said, I don't see much value in these assertions, because the=20
"dce_mi->masks->GRPH_MICRO_TILE_MODE" check already implies that the code i=
s=20
running on a GFX version that has this register.

Best regards,
Timur


>  		REG_UPDATE_9(GRPH_CONTROL,
>  				GRPH_NUM_BANKS, info-
>gfx8.num_banks,
>  				GRPH_BANK_WIDTH, info-
>gfx8.bank_width,
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c index
> 2c43c2422638..67cfca3361fb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_mem_input_v.c
> @@ -165,6 +165,8 @@ static void program_tiling(
>  	const struct dc_tiling_info *info,
>  	const enum surface_pixel_format pixel_format)
>  {
> +	ASSERT(info->gfxversion =3D=3D DcGfxVersion8);
> +
>  	uint32_t value =3D 0;
>=20
>  	set_reg_field_value(value, info->gfx8.num_banks,
> @@ -541,6 +543,7 @@ static const unsigned int *get_dvmm_hw_setting(
>  	else
>  		bpp =3D bpp_8;
>=20
> +	ASSERT(tiling_info->gfxversion =3D=3D DcGfxVersion8);
>  	switch (tiling_info->gfx8.array_mode) {
>  	case DC_ARRAY_1D_TILED_THIN1:
>  	case DC_ARRAY_1D_TILED_THICK:
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c index
> 74962791302f..71eeee02c0fa 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/calcs/dcn_calcs.c
> @@ -1006,6 +1006,7 @@ bool dcn_validate_bandwidth(
>=20
>  			v->source_pixel_format[input_idx] =3D=20
tl_pixel_format_to_bw_defs(
>  					pipe->plane_state-
>format);
> +			ASSERT(pipe->plane_state-
>tiling_info.gfxversion =3D=3D DcGfxVersion9);
>  			v->source_surface_mode[input_idx] =3D=20
tl_sw_mode_to_bw_defs(
>  					pipe->plane_state-
>tiling_info.gfx9.swizzle);
>  			v->lb_bit_per_pixel[input_idx] =3D
> tl_lb_bpp_to_int(pipe->plane_res.scl_data.lb_params.depth); diff --git
> a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
> b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c index
> 6378e3fd7249..e697d9bf1b44 100644
> --- a/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn10/dcn10_hubp.c
> @@ -145,6 +145,8 @@ void hubp1_program_tiling(
>  {
>  	struct dcn10_hubp *hubp1 =3D TO_DCN10_HUBP(hubp);
>=20
> +	ASSERT(info->gfxversion =3D=3D DcGfxVersion9);
> +
>  	REG_UPDATE_6(DCSURF_ADDR_CONFIG,
>  			NUM_PIPES, log_2(info->gfx9.num_pipes),
>  			NUM_BANKS, log_2(info->gfx9.num_banks),
> diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
> b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c index
> 92288de4cc10..4715e60e812a 100644
> --- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
> @@ -313,6 +313,8 @@ static void hubp2_program_tiling(
>  	const struct dc_tiling_info *info,
>  	const enum surface_pixel_format pixel_format)
>  {
> +	ASSERT(info->gfxversion =3D=3D DcGfxVersion9);
> +
>  	REG_UPDATE_3(DCSURF_ADDR_CONFIG,
>  			NUM_PIPES, log_2(info->gfx9.num_pipes),
>  			PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
> diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
> b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c index
> 0cc6f4558989..207c2f86b7d7 100644
> --- a/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn30/dcn30_hubp.c
> @@ -321,6 +321,8 @@ void hubp3_program_tiling(
>  	const struct dc_tiling_info *info,
>  	const enum surface_pixel_format pixel_format)
>  {
> +	ASSERT(info->gfxversion =3D=3D DcGfxVersion9);
> +
>  	REG_UPDATE_4(DCSURF_ADDR_CONFIG,
>  		NUM_PIPES, log_2(info->gfx9.num_pipes),
>  		PIPE_INTERLEAVE, info->gfx9.pipe_interleave,
> diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
> b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c index
> c205500290ec..861e940250af 100644
> --- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
> @@ -589,7 +589,12 @@ void hubp401_program_tiling(
>  	 *
>  	 * DIM_TYPE field in DCSURF_TILING for Display is always 1 (2D=20
dimension)
> which is HW default. */
> -	 REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, info-
>gfx_addr3.swizzle);
> +	 if (info->gfxversion =3D=3D DcGfxAddr3) {
> +		REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, info-
>gfx_addr3.swizzle);
> +	} else {
> +		/* linear */
> +		REG_UPDATE(DCSURF_TILING_CONFIG, SW_MODE, 0);
> +	}
>  }
>=20
>  void hubp401_program_size(
> diff --git
> a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
> b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c
> index f5a4e97c40ce..7d99f5d79e6d 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helper=
s.c
> +++
> b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource_helpers.c =
@@
> -401,7 +401,8 @@ void dcn32_set_det_allocations(struct dc *dc, struct
> dc_state *context, */
>  	if (pipe_cnt =3D=3D 1) {
>  		pipes[0].pipe.src.det_size_override =3D=20
DCN3_2_MAX_DET_SIZE;
> -		if (pipe->plane_state && !disable_unbounded_requesting=20
&&
> pipe->plane_state->tiling_info.gfx9.swizzle !=3D DC_SW_LINEAR) { +	=09
if
> (pipe->plane_state && !disable_unbounded_requesting &&
> pipe->plane_state->tiling_info.gfxversion !=3D DcGfxBase &&
> +			!(pipe->plane_state->tiling_info.gfxversion=20
=3D=3D DcGfxVersion9 &&
> pipe->plane_state->tiling_info.gfx9.swizzle =3D=3D DC_SW_LINEAR)) { if
> (!is_dual_plane(pipe->plane_state->format)) {
>  			=09
pipes[0].pipe.src.det_size_override =3D DCN3_2_DEFAULT_DET_SIZE;
>  			=09
pipes[0].pipe.src.unbounded_req_mode =3D true;




