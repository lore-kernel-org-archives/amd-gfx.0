Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A32C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 06:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323C510F422;
	Wed,  6 Apr 2022 06:18:42 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3166710F41F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Apr 2022 06:18:40 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef4f.dynamic.kabel-deutschland.de
 [95.90.239.79])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 36DEA61E64846;
 Wed,  6 Apr 2022 08:18:38 +0200 (CEST)
Message-ID: <2b5a8876-0ea7-4449-7415-d75c6d0ccb09@molgen.mpg.de>
Date: Wed, 6 Apr 2022 08:18:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] drm/amdgpu/smu10: fix SoC/fclk units in auto mode
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>
References: <20220401151608.2910979-1-alexander.deucher@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220401151608.2910979-1-alexander.deucher@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex,


Thank you for your patch.

Am 01.04.22 um 17:16 schrieb Alex Deucher:
> SMU takes clock limits in Mhz units.  socclk and fclk were
> using 10 khz units in some cases.  Switch to Mhz units.
> Fixes higher than required SoC clocks.

It’d be great if you used 75 characters per line in commit messages.

> Fixes: 97cf32996c46d9 ("drm/amd/pm: Removed fixed clock in auto mode DPM")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 9ddd8491ff00..545dd68a8c18 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -773,13 +773,13 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
>   		smum_send_msg_to_smc_with_parameter(hwmgr,
>   						PPSMC_MSG_SetHardMinFclkByFreq,
>   						hwmgr->display_config->num_display > 3 ?
> -						data->clock_vol_info.vdd_dep_on_fclk->entries[0].clk :
> +						    (data->clock_vol_info.vdd_dep_on_fclk->entries[0].clk / 100) :
>   						min_mclk,

Should that also be indented now?

>   						NULL);
>   
>   		smum_send_msg_to_smc_with_parameter(hwmgr,
>   						PPSMC_MSG_SetHardMinSocclkByFreq,
> -						data->clock_vol_info.vdd_dep_on_socclk->entries[0].clk,
> +						data->clock_vol_info.vdd_dep_on_socclk->entries[0].clk / 100,
>   						NULL);
>   		smum_send_msg_to_smc_with_parameter(hwmgr,
>   						PPSMC_MSG_SetHardMinVcn,
> @@ -792,11 +792,11 @@ static int smu10_dpm_force_dpm_level(struct pp_hwmgr *hwmgr,
>   						NULL);
>   		smum_send_msg_to_smc_with_parameter(hwmgr,
>   						PPSMC_MSG_SetSoftMaxFclkByFreq,
> -						data->clock_vol_info.vdd_dep_on_fclk->entries[index_fclk].clk,
> +						data->clock_vol_info.vdd_dep_on_fclk->entries[index_fclk].clk / 100,
>   						NULL);
>   		smum_send_msg_to_smc_with_parameter(hwmgr,
>   						PPSMC_MSG_SetSoftMaxSocclkByFreq,
> -						data->clock_vol_info.vdd_dep_on_socclk->entries[index_socclk].clk,
> +						data->clock_vol_info.vdd_dep_on_socclk->entries[index_socclk].clk / 100,
>   						NULL);
>   		smum_send_msg_to_smc_with_parameter(hwmgr,
>   						PPSMC_MSG_SetSoftMaxVcn,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
