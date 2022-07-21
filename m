Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB01C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 13:31:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60EC78E598;
	Thu, 21 Jul 2022 13:31:54 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D5E98E597
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 13:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Feu6frSuP3TN8pAfsE/TKlooFMikBBfLuaw8TtNBgB8=; b=O/l4mCL3EA5Pf81aRRMXGnEMtA
 cAKDnp/dYvsNVvovy8Qpu9TEl0lu5+3bBWxRC1L0ho8yYp58LAhewHYYbQeWWThOpNZYyuVw68Rd2
 IqbCHf4xg7TrERdwImVLv5yJ2NaD7YsMsrHPh/HwFJdwR8zI0gj1Dz3o/o9qfzwfJ5aED6Ug9/PPp
 T8tGLG1Z7y4yDz1aW7U+Rr0oBCOXeV4+UMj0gAlXEb1HPAfAYvsEqs5oANdZ6mPtBXzBBYIv/kiGd
 YJSv2rPV4/Y6XyDbTHhc91vboTSP8ojIJn7LkJW3+wqSrf/cJeVbzoJXjW+4kwUyea5Bzthsatjen
 EBGKznpA==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220]
 helo=[192.168.15.109]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1oEWHI-001Uj2-Ks; Thu, 21 Jul 2022 15:31:44 +0200
Message-ID: <69e8eb22-0350-a88c-de7a-880da9bb02b1@igalia.com>
Date: Thu, 21 Jul 2022 10:31:25 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] drm/amd/display: Drop dm_sw_gfx7_2d_thin_l_vp and
 dm_sw_gfx7_2d_thin_gl
Content-Language: en-US
To: =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
References: <20220720182228.259119-1-mairacanal@riseup.net>
From: =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220720182228.259119-1-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Cc: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, magalilemes00@gmail.com,
 David Airlie <airlied@linux.ie>, tales.aparecida@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, mwen@igalia.com,
 Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
 Harry Wentland <harry.wentland@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Às 15:22 de 20/07/22, Maíra Canal escreveu:
> As the enum dm_sw_gfx7_2d_thin_gl and dm_sw_gfx7_2d_thin_l_vp are not
> used on the codebase, this commit drops those entries from enum
> dm_swizzle_mode.
> 

dm_sw_gfx7_2d_thin_gl and dm_sw_gfx7_2d_thin_l_vp are not enums, but
rather enum items or enum entries.

And, as per Linux documentation

Describe your changes in imperative mood, e.g. “make xyzzy do frotz”
instead of “[This patch] makes xyzzy do frotz”

So replace /this commit drops/drop/

> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> ---
>  .../dc/dml/dcn20/display_mode_vba_20.c        | 26 +++++-------------
>  .../dc/dml/dcn20/display_mode_vba_20v2.c      | 26 +++++-------------
>  .../dc/dml/dcn21/display_mode_vba_21.c        | 27 +++++--------------
>  .../amd/display/dc/dml/display_mode_enums.h   |  2 --
>  .../display/dc/dml/dml_wrapper_translation.c  |  9 -------
>  5 files changed, 19 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> index d3b5b6fedf04..4e4cb0927057 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> @@ -938,7 +938,7 @@ static unsigned int CalculateVMAndRowBytes(
>  		*MetaRowByte = 0;
>  	}
>  
> -	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
> +	if (SurfaceTiling == dm_sw_linear) {
>  		MacroTileSizeBytes = 256;
>  		MacroTileHeight = BlockHeight256Bytes;
>  	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
> @@ -3347,26 +3347,12 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  										== dm_420_8
>  								|| mode_lib->vba.SourcePixelFormat[k]
>  										== dm_420_10))
> -				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
> -						|| mode_lib->vba.SurfaceTiling[k]
> -								== dm_sw_gfx7_2d_thin_l_vp)
> -						&& !((mode_lib->vba.SourcePixelFormat[k]
> -								== dm_444_64
> +				|| (mode_lib->vba.DCCEnable[k] == true
> +						&& (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
>  								|| mode_lib->vba.SourcePixelFormat[k]
> -										== dm_444_32)
> -								&& mode_lib->vba.SourceScan[k]
> -										== dm_horz
> -								&& mode_lib->vba.SupportGFX7CompatibleTilingIn32bppAnd64bpp
> -										== true
> -								&& mode_lib->vba.DCCEnable[k]
> -										== false))
> -						|| (mode_lib->vba.DCCEnable[k] == true
> -								&& (mode_lib->vba.SurfaceTiling[k]
> -										== dm_sw_linear
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_8
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_10)))) {
> +										== dm_420_8
> +								|| mode_lib->vba.SourcePixelFormat[k]
> +										== dm_420_10))) {
>  			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> index 63bbdf8b8678..eaa0cdb599ba 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> @@ -998,7 +998,7 @@ static unsigned int CalculateVMAndRowBytes(
>  		*MetaRowByte = 0;
>  	}
>  
> -	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
> +	if (SurfaceTiling == dm_sw_linear) {
>  		MacroTileSizeBytes = 256;
>  		MacroTileHeight = BlockHeight256Bytes;
>  	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
> @@ -3454,26 +3454,12 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
>  										== dm_420_8
>  								|| mode_lib->vba.SourcePixelFormat[k]
>  										== dm_420_10))
> -				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
> -						|| mode_lib->vba.SurfaceTiling[k]
> -								== dm_sw_gfx7_2d_thin_l_vp)
> -						&& !((mode_lib->vba.SourcePixelFormat[k]
> -								== dm_444_64
> +				|| (mode_lib->vba.DCCEnable[k] == true
> +						&& (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
>  								|| mode_lib->vba.SourcePixelFormat[k]
> -										== dm_444_32)
> -								&& mode_lib->vba.SourceScan[k]
> -										== dm_horz
> -								&& mode_lib->vba.SupportGFX7CompatibleTilingIn32bppAnd64bpp
> -										== true
> -								&& mode_lib->vba.DCCEnable[k]
> -										== false))
> -						|| (mode_lib->vba.DCCEnable[k] == true
> -								&& (mode_lib->vba.SurfaceTiling[k]
> -										== dm_sw_linear
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_8
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_10)))) {
> +										== dm_420_8
> +								|| mode_lib->vba.SourcePixelFormat[k]
> +										== dm_420_10))) {
>  			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
> index 8a7485e21d53..198d81861ac5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
> @@ -1342,7 +1342,7 @@ static unsigned int CalculateVMAndRowBytes(
>  		*MetaRowByte = 0;
>  	}
>  
> -	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
> +	if (SurfaceTiling == dm_sw_linear) {
>  		MacroTileSizeBytes = 256;
>  		MacroTileHeight = BlockHeight256Bytes;
>  	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
> @@ -3579,26 +3579,13 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  										== dm_420_8
>  								|| mode_lib->vba.SourcePixelFormat[k]
>  										== dm_420_10))
> -				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
> -						|| mode_lib->vba.SurfaceTiling[k]
> -								== dm_sw_gfx7_2d_thin_l_vp)
> -						&& !((mode_lib->vba.SourcePixelFormat[k]
> -								== dm_444_64
> +				|| (mode_lib->vba.DCCEnable[k] == true
> +						&& (mode_lib->vba.SurfaceTiling[k]
> +								== dm_sw_linear
>  								|| mode_lib->vba.SourcePixelFormat[k]
> -										== dm_444_32)
> -								&& mode_lib->vba.SourceScan[k]
> -										== dm_horz
> -								&& mode_lib->vba.SupportGFX7CompatibleTilingIn32bppAnd64bpp
> -										== true
> -								&& mode_lib->vba.DCCEnable[k]
> -										== false))
> -						|| (mode_lib->vba.DCCEnable[k] == true
> -								&& (mode_lib->vba.SurfaceTiling[k]
> -										== dm_sw_linear
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_8
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_10)))) {
> +										== dm_420_8
> +								|| mode_lib->vba.SourcePixelFormat[k]
> +										== dm_420_10))) {
>  			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
> index f394b3f3922a..0e06727d40b3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
> @@ -89,8 +89,6 @@ enum dm_swizzle_mode {
>  	dm_sw_var_s_x = 29,
>  	dm_sw_var_d_x = 30,
>  	dm_sw_var_r_x = 31,
> -	dm_sw_gfx7_2d_thin_l_vp,
> -	dm_sw_gfx7_2d_thin_gl,
>  };
>  enum lb_depth {
>  	dm_lb_10 = 0, dm_lb_8 = 1, dm_lb_6 = 2, dm_lb_12 = 3, dm_lb_16 = 4,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c
> index 4ec5310a2962..9edcb6fc83c1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c
> @@ -35,15 +35,6 @@ static void gfx10array_mode_to_dml_params(
>  	case DC_ARRAY_LINEAR_GENERAL:
>  		*sw_mode = dm_sw_linear;
>  		break;
> -	case DC_ARRAY_2D_TILED_THIN1:
> -// DC_LEGACY_TILING_ADDR_GEN_ZERO - undefined as per current code hence removed
> -#if 0
> -		if (compat_level == DC_LEGACY_TILING_ADDR_GEN_ZERO)
> -			*sw_mode = dm_sw_gfx7_2d_thin_l_vp;
> -		else
> -			*sw_mode = dm_sw_gfx7_2d_thin_gl;
> -#endif
> -		break;
>  	default:
>  		ASSERT(0); /* Not supported */
>  		break;
