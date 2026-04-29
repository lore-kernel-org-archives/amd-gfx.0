Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3266BFF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 20:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9BFD10E0E7;
	Wed, 29 Apr 2026 20:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="QF2t5hwN";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1881D10E0E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 20:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h9Ew1y7b+0WtYeT6egQWgy2HkJwye9X4QtF/an2ihs4=; b=QF2t5hwNCi1jIoLGwIKv7ChEHT
 VsimvnkIqrkTSgv8fqCTxIuasIPkykXqmIU3wKl1btwRpWIz5uLCP//vedIqQEAToQoemsVl+J8sP
 Y4EKbkgDQ+k2NlSaF8nQgPh6+Pa+PB5jnAhv4hPju/oMGr28hmYRKsBAvBf00G/H4b1VLEcTAf1qy
 yaUNOgdidprELf/ESmK7WcuaEgGJsLSfS9YHyJUKrLU5lgVqs21VT0DFZqiDr9N7FdI2CPR87+sHu
 oRWmNEc7iCCX7vrLjXrMG/LVEjrGY8BQUVw8wnjpxDNcOuDyM0MUdpdBUIvJI3MeGT878+WZ1hqYN
 VbLks4cw==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIBfD-0047NO-H7; Wed, 29 Apr 2026 22:37:42 +0200
Message-ID: <d271711c-0d8e-416d-9fa1-75e161ba82aa@igalia.com>
Date: Wed, 29 Apr 2026 17:37:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] drm/amd/display: Delete dm_pp_clocks_state
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-9-timur.kristof@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260423191519.73127-9-timur.kristof@gmail.com>
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
> It isn't used by anything anymore.
>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../drm/amd/display/dc/dm_services_types.h    | 27 -------------------
>   1 file changed, 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
> index 44aa8d213d386..b3505d93503fd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
> @@ -36,30 +36,7 @@ struct dm_pp_clock_range {
>   	int max_khz;
>   };
>   
> -enum dm_pp_clocks_state {
> -	DM_PP_CLOCKS_STATE_INVALID,
> -	DM_PP_CLOCKS_STATE_ULTRA_LOW,
> -	DM_PP_CLOCKS_STATE_LOW,
> -	DM_PP_CLOCKS_STATE_NOMINAL,
> -	DM_PP_CLOCKS_STATE_PERFORMANCE,
> -
> -	/* Starting from DCE11, Max 8 levels of DPM state supported. */
> -	DM_PP_CLOCKS_DPM_STATE_LEVEL_INVALID = DM_PP_CLOCKS_STATE_INVALID,
> -	DM_PP_CLOCKS_DPM_STATE_LEVEL_0,
> -	DM_PP_CLOCKS_DPM_STATE_LEVEL_1,
> -	DM_PP_CLOCKS_DPM_STATE_LEVEL_2,
> -	/* to be backward compatible */
> -	DM_PP_CLOCKS_DPM_STATE_LEVEL_3,
> -	DM_PP_CLOCKS_DPM_STATE_LEVEL_4,
> -	DM_PP_CLOCKS_DPM_STATE_LEVEL_5,
> -	DM_PP_CLOCKS_DPM_STATE_LEVEL_6,
> -	DM_PP_CLOCKS_DPM_STATE_LEVEL_7,
> -
> -	DM_PP_CLOCKS_MAX_STATES
> -};
> -
>   struct dm_pp_gpu_clock_range {
> -	enum dm_pp_clocks_state clock_state;
>   	struct dm_pp_clock_range sclk;
>   	struct dm_pp_clock_range mclk;
>   	struct dm_pp_clock_range eclk;
> @@ -246,10 +223,6 @@ enum dm_acpi_display_type {
>   	AcpiDisplayType_DFP6 = 12
>   };
>   
> -struct dm_pp_power_level_change_request {
> -	enum dm_pp_clocks_state power_level;
> -};
Ah, okay, here is the dm_pp_power_level_change_request removal.
I think it should be removed earlier.

Apart from that,

Reviewed-by: Melissa Wen <mwen@igalia.com>
> -
>   struct dm_pp_clock_for_voltage_req {
>   	enum dm_pp_clock_type clk_type;
>   	uint32_t clocks_in_khz;

