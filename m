Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE267CD13DA
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 18:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F97B10E0D1;
	Thu, 30 Apr 2026 18:54:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="f4Ve5hEO";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D0810E0D1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 18:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=a4xBpHvuhFsDgBktAb+2KMMoDJyEaMu7Ac9LkXINbP4=; b=f4Ve5hEONYiX/f8eGE+dW2s6pC
 kpwNjpQFsBUYopsZFceIAvqDC6MrWsyKb8IixBkZLzVUqgXod1my4erwnebthmTz9ZwoYg5cf92+G
 /XqaGqJ19JGDVyzbnENtbPJnOSG4GPh230Zjh3SEEIG0gl57naUPR8JMVg5fz9Z+9Mx9vKs67Wezp
 0SeKDObtJCOajIrKm9Fr34q6nYPfrjNLbMrcNOiJRykFL+uJs8uRZbpuE64KvIpaLQqxi4d1M4Dct
 WnYmj+yrrkwxtfFusp06g1znbtmBSpH0ut+TyGAR7Euy9oUzbTjViPX7Bqyw96Tw++jXMxoIJCxn8
 l3jVWlaw==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIWWV-004YRz-Eo; Thu, 30 Apr 2026 20:54:06 +0200
Message-ID: <681d94b5-499e-47d5-b41f-c9d8698bbbff@igalia.com>
Date: Thu, 30 Apr 2026 15:53:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] drm/amd/pm: Delete non-functional SMU8
 get_dal_power_level implementation
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-12-timur.kristof@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260423191519.73127-12-timur.kristof@gmail.com>
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
> This function was effectively a no-op because it always
> returned the maximum possible power level, because the
> maximum voltage is in millivolts while the dependency
> table didn't contain actual voltages.

Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 22 -------------------
>   1 file changed, 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index 736e5a8af4779..8a37c745cb117 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -1522,27 +1522,6 @@ static int smu8_store_cc6_data(struct pp_hwmgr *hwmgr, uint32_t separation_time,
>   	return 0;
>   }
>   
> -static int smu8_get_dal_power_level(struct pp_hwmgr *hwmgr,
> -		struct amd_pp_simple_clock_info *info)
> -{
> -	uint32_t i;
> -	const struct phm_clock_voltage_dependency_table *table =
> -			hwmgr->dyn_state.vddc_dep_on_dal_pwrl;
> -	const struct phm_clock_and_voltage_limits *limits =
> -			&hwmgr->dyn_state.max_clock_voltage_on_ac;
> -
> -	info->engine_max_clock = limits->sclk;
> -	info->memory_max_clock = limits->mclk;
> -
> -	for (i = table->count - 1; i > 0; i--) {
> -		if (limits->vddc >= table->entries[i].v) {
> -			info->level = table->entries[i].clk;
> -			return 0;
> -		}
> -	}
> -	return -EINVAL;
> -}
> -
>   static int smu8_force_clock_level(struct pp_hwmgr *hwmgr,
>   		enum pp_clock_type type, uint32_t mask)
>   {
> @@ -2063,7 +2042,6 @@ static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
>   	.store_cc6_data = smu8_store_cc6_data,
>   	.force_clock_level = smu8_force_clock_level,
>   	.emit_clock_levels = smu8_emit_clock_levels,
> -	.get_dal_power_level = smu8_get_dal_power_level,
>   	.get_performance_level = smu8_get_performance_level,
>   	.get_current_shallow_sleep_clocks = smu8_get_current_shallow_sleep_clocks,
>   	.get_clock_by_type = smu8_get_clock_by_type,

