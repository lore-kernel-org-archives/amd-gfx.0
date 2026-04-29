Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67640CCFA13
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 20:06:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E08F10F168;
	Wed, 29 Apr 2026 20:06:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fb2vpphE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D56A10F168
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 20:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FX1ukqpfT8vI/OrAnG/3LDsP6dOvxJTvpN2FYoQUw0Q=; b=fb2vpphER/ThSaxYiMmMtDsmB5
 7Ei/IYWerJiqijR309aTjr5UCCjgNZtPa1v5aWNvmu3qkkuZXkJD+4VBl3VLX8Au+J7eUAeyJhjNM
 r5bFSvsL3bsiwTpJoS3On7dXCbrvI1RljFsdmPkArqq0NqnoLewGFVAT3q67BH1iDYkwypcZtqOpW
 20YBajcM2Ge9QqkntGVPXvVhOZgKanbqk2eSQtJC9xNIJvVFRhKOsaoOHvQoDDyqLyjY8wafiPBIk
 HEZqee0cDLQniAk9l9BIzu7SbmX7XQ4Ljn//NAzixGZL+fJNajyrS0rjH1W1slILKPybh8bn2DHcI
 ZFzAaq6g==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIBAb-0046gN-0h; Wed, 29 Apr 2026 22:06:04 +0200
Message-ID: <9b1758c4-3e1d-49cb-a171-723d371be539@igalia.com>
Date: Wed, 29 Apr 2026 17:06:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] drm/amd/display: Delete max_clocks_state from
 dm_pp_static_clock_info
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-5-timur.kristof@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260423191519.73127-5-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 23/04/2026 16:15, Timur Kristóf wrote:
> It's not used by anything anymore.
Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 28 -------------------
>   .../drm/amd/display/dc/dm_services_types.h    |  3 --
>   2 files changed, 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index 17f42201ab862..2247969aa9acb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -183,33 +183,6 @@ static enum amd_pp_clock_type dc_to_pp_clock_type(
>   	return amd_pp_clk_type;
>   }
>   
> -static enum dm_pp_clocks_state pp_to_dc_powerlevel_state(
> -			enum PP_DAL_POWERLEVEL max_clocks_state)
> -{
> -	switch (max_clocks_state) {
> -	case PP_DAL_POWERLEVEL_0:
> -		return DM_PP_CLOCKS_DPM_STATE_LEVEL_0;
> -	case PP_DAL_POWERLEVEL_1:
> -		return DM_PP_CLOCKS_DPM_STATE_LEVEL_1;
> -	case PP_DAL_POWERLEVEL_2:
> -		return DM_PP_CLOCKS_DPM_STATE_LEVEL_2;
> -	case PP_DAL_POWERLEVEL_3:
> -		return DM_PP_CLOCKS_DPM_STATE_LEVEL_3;
> -	case PP_DAL_POWERLEVEL_4:
> -		return DM_PP_CLOCKS_DPM_STATE_LEVEL_4;
> -	case PP_DAL_POWERLEVEL_5:
> -		return DM_PP_CLOCKS_DPM_STATE_LEVEL_5;
> -	case PP_DAL_POWERLEVEL_6:
> -		return DM_PP_CLOCKS_DPM_STATE_LEVEL_6;
> -	case PP_DAL_POWERLEVEL_7:
> -		return DM_PP_CLOCKS_DPM_STATE_LEVEL_7;
> -	default:
> -		DRM_ERROR("DM_PPLIB: invalid powerlevel state: %d!\n",
> -				max_clocks_state);
> -		return DM_PP_CLOCKS_STATE_INVALID;
> -	}
> -}
> -
>   static void pp_to_dc_clock_levels(
>   		const struct amd_pp_clocks *pp_clks,
>   		struct dm_pp_clock_levels *dc_clks,
> @@ -448,7 +421,6 @@ bool dm_pp_get_static_clocks(
>   	if (amdgpu_dpm_get_current_clocks(adev, &pp_clk_info))
>   		return false;
>   
> -	static_clk_info->max_clocks_state = pp_to_dc_powerlevel_state(pp_clk_info.max_clocks_state);
>   	static_clk_info->max_mclk_khz = pp_clk_info.max_memory_clock * 10;
>   	static_clk_info->max_sclk_khz = pp_clk_info.max_engine_clock * 10;
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
> index 3b093b8699abd..44aa8d213d386 100644
> --- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
> @@ -258,9 +258,6 @@ struct dm_pp_clock_for_voltage_req {
>   struct dm_pp_static_clock_info {
>   	uint32_t max_sclk_khz;
>   	uint32_t max_mclk_khz;
> -
> -	/* max possible display block clocks state */
> -	enum dm_pp_clocks_state max_clocks_state;
>   };
>   
>   struct dtn_min_clk_info {

