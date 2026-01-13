Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2166D30CDB
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 22:38:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9CE10E561;
	Tue, 13 Jan 2026 22:38:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="vLckx10g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5EC310E561
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 22:38:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 50CE640AAB;
 Tue, 13 Jan 2026 22:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA28BC19423;
 Tue, 13 Jan 2026 22:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768343924;
 bh=4cgnKUefhRKwFLUbnV8rNzACEXUctKDlbClwQFLMNRA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vLckx10gDHTCse67SFqunTLsqRh9OfleOGudyQBor/aqHLCZXmHR3yjlkZvOtso83
 6yOmB7wjW0ifWFhduf7UKV7E/WxpDzhGI6a3z5rh9GVbcXGNQEj0UtxAWTb5Czacjp
 nP4FqMgFsMs2TXcRhEsdGcXHCBtHARmG0QP1oho95DGEuu6jQEwFn4pRJmbiwwgGPk
 tvJvv8CVh19G7QYtlRDAXBxWyjHx93oWneDfirAEbA8ivHnS+1j0JoucVZQRdAvoDs
 jJlfZS+p7k1OVBgf9W3UtgxB3HUEU0hBrdAA7bhv0cNP2FyjJXR+vjb+KD24IdngID
 48kmJ2SLh06Kg==
Message-ID: <f2849dc4-ae29-463e-9f67-667e9174c5b5@kernel.org>
Date: Tue, 13 Jan 2026 16:38:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Add an hdmi_hpd_debounce_delay_ms module
To: IVAN.LIPSKI@amd.com, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
References: <20260113223012.494982-1-IVAN.LIPSKI@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20260113223012.494982-1-IVAN.LIPSKI@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 1/13/2026 4:29 PM, IVAN.LIPSKI@amd.com wrote:
> From: Ivan Lipski <ivan.lipski@amd.com>
> 
> [Why&How]
> Right now, the HDMI HPD filter is enabled by default at 1500ms.
> 
> We want to disable it by default, as most modern displays with HDMI do
> not require it for DPMS mode.
> 
> The HPD can instead be enabled as a driver parameter with a custom delay
> value in ms (up to 5000ms).
> 
> Fixes: c97da4785b3b ("drm/amd/display: Add an HPD filter for HDMI")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4859
> 
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---

Makes sense to me.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

>   drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 +++++++++++
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 ++++++++++++---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 ++++-
>   4 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 11a36c132905..9903da2d28b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -269,6 +269,8 @@ extern int amdgpu_rebar;
>   extern int amdgpu_wbrf;
>   extern int amdgpu_user_queue;
>   
> +extern int amdgpu_hdmi_hpd_debounce_delay_ms;
> +
>   #define AMDGPU_VM_MAX_NUM_CTX			4096
>   #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
>   #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index d67bbaa8ce02..771c89c84608 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -247,6 +247,7 @@ int amdgpu_damage_clips = -1; /* auto */
>   int amdgpu_umsch_mm_fwlog;
>   int amdgpu_rebar = -1; /* auto */
>   int amdgpu_user_queue = -1;
> +uint amdgpu_hdmi_hpd_debounce_delay_ms;
>   
>   DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
>   			"DRM_UT_CORE",
> @@ -1123,6 +1124,16 @@ module_param_named(rebar, amdgpu_rebar, int, 0444);
>   MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disable, 1 = enable, 2 = enable UQs and disable KQs)");
>   module_param_named(user_queue, amdgpu_user_queue, int, 0444);
>   
> +/*
> + * DOC: hdmi_hpd_debounce_delay_ms (uint)
> + * HDMI HPD disconnect debounce delay in milliseconds.
> + *
> + * Used to filter short disconnect->reconnect HPD toggles some HDMI sinks
> + * generate while entering/leaving power save. Set to 0 to disable by default.
> + */
> +MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
> +module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
> +
>   /* These devices are not supported by amdgpu.
>    * They are supported by the mach64, r128, radeon drivers
>    */
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 354e359c4507..ba7e1f72fde1 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8918,9 +8918,18 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
>   	mutex_init(&aconnector->hpd_lock);
>   	mutex_init(&aconnector->handle_mst_msg_ready);
>   
> -	aconnector->hdmi_hpd_debounce_delay_ms = AMDGPU_DM_HDMI_HPD_DEBOUNCE_MS;
> -	INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, hdmi_hpd_debounce_work);
> -	aconnector->hdmi_prev_sink = NULL;
> +	/*
> +	 * If HDMI HPD debounce delay is set, use the minimum between selected
> +	 * value and AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS
> +	 */
> +	if (amdgpu_hdmi_hpd_debounce_delay_ms) {
> +		aconnector->hdmi_hpd_debounce_delay_ms = min(amdgpu_hdmi_hpd_debounce_delay_ms,
> +							     AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS);
> +		INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, hdmi_hpd_debounce_work);
> +		aconnector->hdmi_prev_sink = NULL;
> +	} else {
> +		aconnector->hdmi_hpd_debounce_delay_ms = 0;
> +	}
>   
>   	/*
>   	 * configure support HPD hot plug connector_>polled default value is 0
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 7065b20aa2e6..6fe7f78b66c5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -59,7 +59,10 @@
>   
>   #define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
>   
> -#define AMDGPU_DM_HDMI_HPD_DEBOUNCE_MS 1500
> +/*
> + * Maximum HDMI HPD debounce delay in milliseconds
> + */
> +#define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
>   /*
>   #include "include/amdgpu_dal_power_if.h"
>   #include "amdgpu_dm_irq.h"

