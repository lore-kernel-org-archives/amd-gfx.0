Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B35E7DEF0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 14:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A79FB10E2C1;
	Mon,  2 Feb 2026 14:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="XCaZ91Uv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5678510E2C1
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=02KAIhMexXbmBqBG4LI7ETwQLU+S53a8neL/BsWHHsg=; b=XCaZ91UvupkmwER1PjdzjaZWHB
 5uKZPBLY8xzrUHN+vVi6L/Ce7zvasRE28mervOiuScAROdMeQxmUMPvXg9Qi4UrRuvfMIO09yPBZT
 /6P/sQxw7JxjIXr7DvprMHGgVAwDaGAKvmk439ReEm4AwudjPwMYBdglyirh2aWYuiO2zh4k6eQDb
 ADLmPJr1voGfgG51ODSbYc0Y4xxsi3V4vx73OSrhERGBtn6VK0UHUyNfiV8wBQYWuMjNDzrcyA8eP
 3okUgjeyWTGVyBAFz+80y+D58xX4h5scjR84E+hZO3OMoU81j1tGRxMxpWCweFQpi6QvhKxk8rn5o
 bhghjF3A==;
Received: from d198-53-218-11.abhsia.telus.net ([198.53.218.11] helo=atmagalia)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vmvGP-00Coka-1j; Mon, 02 Feb 2026 15:50:53 +0100
Date: Mon, 2 Feb 2026 07:50:49 -0700
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com, 
 Leo Li <sunpeng.li@amd.com>
Subject: Re: [PATCH 1/5] drm/amd/display: Use dce_audio_create for DCE 6
Message-ID: <aYC5hPSi6Rn9W_eK@atmagalia>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
 <20260118173150.19790-2-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118173150.19790-2-timur.kristof@gmail.com>
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

On 01/18, Timur Kristóf wrote:
> The only difference between DCE 6 and other DCE versions is
> that DCE 6 doesn't support DCCG_AUDIO_DTO2_USE_512FBR_DTO.
> Recently a check was added to dce_aud_wall_dto_setup() to
> check that. So now DCE 6 can just use dce_aud_wall_dto_setup()
> just like other DCE versions.
> 
> Clean up DCE 6 specific audio functions which were otherwise
> identical to the rest.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  .../gpu/drm/amd/display/dc/dce/dce_audio.c    | 131 ------------------
>  .../gpu/drm/amd/display/dc/dce/dce_audio.h    |   9 --
>  .../dc/resource/dce60/dce60_resource.c        |   2 +-
>  3 files changed, 1 insertion(+), 141 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> index fcad61c618a1..1276f19164b3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
> @@ -1150,98 +1150,6 @@ void dce_aud_wall_dto_setup(
>  	}
>  }
>  
> -#if defined(CONFIG_DRM_AMD_DC_SI)
> -static void dce60_aud_wall_dto_setup(
> -	struct audio *audio,
> -	enum signal_type signal,
> -	const struct audio_crtc_info *crtc_info,
> -	const struct audio_pll_info *pll_info)
> -{
> -	struct dce_audio *aud = DCE_AUD(audio);
> -
> -	struct azalia_clock_info clock_info = { 0 };
> -
> -	if (dc_is_hdmi_signal(signal)) {
> -		uint32_t src_sel;
> -
> -		/*DTO0 Programming goal:
> -		-generate 24MHz, 128*Fs from 24MHz
> -		-use DTO0 when an active HDMI port is connected
> -		(optionally a DP is connected) */
> -
> -		/* calculate DTO settings */
> -		get_azalia_clock_info_hdmi(
> -			crtc_info->requested_pixel_clock_100Hz,
> -			crtc_info->calculated_pixel_clock_100Hz,
> -			&clock_info);
> -
> -		DC_LOG_HW_AUDIO("\n%s:Input::requested_pixel_clock_100Hz = %d"\
> -				"calculated_pixel_clock_100Hz =%d\n"\
> -				"audio_dto_module = %d audio_dto_phase =%d \n\n", __func__,\
> -				crtc_info->requested_pixel_clock_100Hz,\
> -				crtc_info->calculated_pixel_clock_100Hz,\
> -				clock_info.audio_dto_module,\
> -				clock_info.audio_dto_phase);
> -
> -		/* On TN/SI, Program DTO source select and DTO select before
> -		programming DTO modulo and DTO phase. These bits must be
> -		programmed first, otherwise there will be no HDMI audio at boot
> -		up. This is a HW sequence change (different from old ASICs).
> -		Caution when changing this programming sequence.
> -
> -		HDMI enabled, using DTO0
> -		program master CRTC for DTO0 */
> -		src_sel = pll_info->dto_source - DTO_SOURCE_ID0;
> -		REG_UPDATE_2(DCCG_AUDIO_DTO_SOURCE,
> -			DCCG_AUDIO_DTO0_SOURCE_SEL, src_sel,
> -			DCCG_AUDIO_DTO_SEL, 0);
> -
> -		/* module */
> -		REG_UPDATE(DCCG_AUDIO_DTO0_MODULE,
> -			DCCG_AUDIO_DTO0_MODULE, clock_info.audio_dto_module);
> -
> -		/* phase */
> -		REG_UPDATE(DCCG_AUDIO_DTO0_PHASE,
> -			DCCG_AUDIO_DTO0_PHASE, clock_info.audio_dto_phase);
> -	} else {
> -		/*DTO1 Programming goal:
> -		-generate 24MHz, 128*Fs from 24MHz (DCE6 does not support 512*Fs)
> -		-default is to used DTO1, and switch to DTO0 when an audio
> -		master HDMI port is connected
> -		-use as default for DP
> -
> -		calculate DTO settings */
> -		get_azalia_clock_info_dp(
> -			crtc_info->requested_pixel_clock_100Hz,
> -			pll_info,
> -			&clock_info);
> -
> -		/* Program DTO select before programming DTO modulo and DTO
> -		phase. default to use DTO1 */
> -
> -		REG_UPDATE(DCCG_AUDIO_DTO_SOURCE,
> -				DCCG_AUDIO_DTO_SEL, 1);
> -
> -			/* DCCG_AUDIO_DTO2_USE_512FBR_DTO, 1)
> -			 * Cannot select 512fs for DP
> -			 *
> -			 * DCE6 has no DCCG_AUDIO_DTO2_USE_512FBR_DTO mask
> -			*/
> -
> -		/* module */
> -		REG_UPDATE(DCCG_AUDIO_DTO1_MODULE,
> -				DCCG_AUDIO_DTO1_MODULE, clock_info.audio_dto_module);
> -
> -		/* phase */
> -		REG_UPDATE(DCCG_AUDIO_DTO1_PHASE,
> -				DCCG_AUDIO_DTO1_PHASE, clock_info.audio_dto_phase);
> -
> -		/* DCE6 has no DCCG_AUDIO_DTO2_USE_512FBR_DTO mask in DCCG_AUDIO_DTO_SOURCE reg */
> -
> -	}
> -}
> -#endif
> -
>  static bool dce_aud_endpoint_valid(struct audio *audio)
>  {
>  	uint32_t value;
> @@ -1303,18 +1211,6 @@ static const struct audio_funcs funcs = {
>  	.destroy = dce_aud_destroy,
>  };
>  
> -#if defined(CONFIG_DRM_AMD_DC_SI)
> -static const struct audio_funcs dce60_funcs = {
> -	.endpoint_valid = dce_aud_endpoint_valid,
> -	.hw_init = dce_aud_hw_init,
> -	.wall_dto_setup = dce60_aud_wall_dto_setup,
> -	.az_enable = dce_aud_az_enable,
> -	.az_disable = dce_aud_az_disable,
> -	.az_configure = dce_aud_az_configure,
> -	.destroy = dce_aud_destroy,
> -};
> -#endif
> -
>  void dce_aud_destroy(struct audio **audio)
>  {
>  	struct dce_audio *aud = DCE_AUD(*audio);
> @@ -1347,30 +1243,3 @@ struct audio *dce_audio_create(
>  	audio->masks = masks;
>  	return &audio->base;
>  }
> -
> -#if defined(CONFIG_DRM_AMD_DC_SI)
> -struct audio *dce60_audio_create(
> -		struct dc_context *ctx,
> -		unsigned int inst,
> -		const struct dce_audio_registers *reg,
> -		const struct dce_audio_shift *shifts,
> -		const struct dce_audio_mask *masks
> -		)
> -{
> -	struct dce_audio *audio = kzalloc(sizeof(*audio), GFP_KERNEL);
> -
> -	if (audio == NULL) {
> -		ASSERT_CRITICAL(audio);
> -		return NULL;
> -	}
> -
> -	audio->base.ctx = ctx;
> -	audio->base.inst = inst;
> -	audio->base.funcs = &dce60_funcs;
> -
> -	audio->regs = reg;
> -	audio->shifts = shifts;
> -	audio->masks = masks;
> -	return &audio->base;
> -}
> -#endif
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
> index 1b7b8b079af4..3f1d161a0045 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.h
> @@ -151,15 +151,6 @@ struct audio *dce_audio_create(
>  		const struct dce_audio_shift *shifts,
>  		const struct dce_audio_mask *masks);
>  
> -#if defined(CONFIG_DRM_AMD_DC_SI)
> -struct audio *dce60_audio_create(
> -		struct dc_context *ctx,
> -		unsigned int inst,
> -		const struct dce_audio_registers *reg,
> -		const struct dce_audio_shift *shifts,
> -		const struct dce_audio_mask *masks);
> -#endif
> -
>  void dce_aud_destroy(struct audio **audio);
>  
>  void dce_aud_hw_init(struct audio *audio);
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> index f0152933bee2..e0fbb08e6985 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
> @@ -495,7 +495,7 @@ static void read_dce_straps(
>  static struct audio *create_audio(
>  		struct dc_context *ctx, unsigned int inst)
>  {
> -	return dce60_audio_create(ctx, inst,
> +	return dce_audio_create(ctx, inst,
>  			&audio_regs[inst], &audio_shift, &audio_mask);

Very nice clean-up.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

>  }
>  
> -- 
> 2.52.0
> 

-- 
Rodrigo Siqueira
https://siqueira.tech
