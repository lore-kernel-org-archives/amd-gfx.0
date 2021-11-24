Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A506FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 07:09:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A346E9E1;
	Wed, 24 Nov 2021 07:09:22 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB2F6E9DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 07:09:21 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id o29so1288787wms.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 23:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=yAEezA8eds9buPilUnGfjRDgbvXhhK1X3SuRgB3G4DA=;
 b=R5nC0x+AtpkXNBAB1f3mawZBjmNJCLEwrTiBikjV92/cXX3GulOQkGVQs6P/mMWcWE
 TvqDSM+UKsqNQ04tQx0tIyCHx4q0aOgdRh+wlJl22xEe77ip5lV+Cz+NPwMSVdk5j/GR
 2dLFrQ5vzr6OsebBt5+7ff8cNKqlCboO+YNGQz/JVi0XNp7xsigGgsCLa8pNaT1YErOC
 PpiQtm+JbMsv3PvS/pwAfaO2VZy+ya0UcxhIoX5ouXL6ZTNWvY3+6L/dHtA1tYX7qUD0
 WB56NH6nmiLbGkZQKx6Z1Kfsfxr0Kr8lje+BbwYAr3KIL1bz0um8ZYY/+EnbeNHl/1yH
 w9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=yAEezA8eds9buPilUnGfjRDgbvXhhK1X3SuRgB3G4DA=;
 b=mTcer+NSp0APxBlXGIVXTx9GBMFfH8NgsSCq/kfjgHi9yQD5K08CmV7Rs2uRMDMqoM
 k6zAK+kare//GcQytQxxsJRqo9bRy7nYwXDp67fxxVGnZaohLCtQJrQYH1FRD+693Iss
 UN8tFIg2wtVF35b3FhmwdrlzFzYQU37jSLLxNFFgurjMoJreDB5MA78DMZ1+jveiIlIJ
 IIFBuFVse1BOwWTItWvA4KbYbmny7oJNHev80yyt7G7KaNK7DFQrqda+VkKfYnt8FirN
 lB6+XsdC3X6cWwNPc4mXGC+TJy5WGhzWNVlxeuXxDLQfb7UZy8/WC4I/3CixYvsFVZvj
 9imQ==
X-Gm-Message-State: AOAM531vw7jkB++CTsCPHAAjqld8CG9RG9dtEQ7JBdNZwYheVpIjejs2
 g/YWWlqgWJk3vdN+YDYbfJnQIocsjUs=
X-Google-Smtp-Source: ABdhPJxZnVps1h19MZFfc7zIzOm7fCGEeIU2aSxybBjJ+g6bRfrN7UamyifCec4ZoAJCKwnRCqit7Q==
X-Received: by 2002:a05:600c:35d4:: with SMTP id
 r20mr12177241wmq.76.1637737759677; 
 Tue, 23 Nov 2021 23:09:19 -0800 (PST)
Received: from [192.168.178.21] (p57b0b77b.dip0.t-ipconnect.de.
 [87.176.183.123])
 by smtp.gmail.com with ESMTPSA id r7sm13913263wrq.29.2021.11.23.23.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Nov 2021 23:09:19 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu/pm: fix powerplay OD interface
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211123200113.1979433-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <2242416a-286a-03f8-3285-2dd0152702e8@gmail.com>
Date: Wed, 24 Nov 2021 08:09:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211123200113.1979433-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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



Am 23.11.21 um 21:01 schrieb Alex Deucher:
> The overclocking interface currently appends data to a
> string.  Revert back to using sprintf().
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1774
> Fixes: 6db0c87a0a8ee1 ("amdgpu/pm: Replace hwmgr smu usage of sprintf with sysfs_emit")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 20 +++----
>   .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 24 ++++----
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   |  6 +-
>   .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 28 +++++----
>   .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 10 ++--
>   .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 58 +++++++++----------
>   6 files changed, 67 insertions(+), 79 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 258c573acc97..1f406f21b452 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1024,8 +1024,6 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	uint32_t min_freq, max_freq = 0;
>   	uint32_t ret = 0;
>   
> -	phm_get_sysfs_buf(&buf, &size);
> -
>   	switch (type) {
>   	case PP_SCLK:
>   		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetGfxclkFrequency, &now);
> @@ -1038,13 +1036,13 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		else
>   			i = 1;
>   
> -		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
> +		size += sprintf(buf + size, "0: %uMhz %s\n",
>   					data->gfx_min_freq_limit/100,
>   					i == 0 ? "*" : "");
> -		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
> +		size += sprintf(buf + size, "1: %uMhz %s\n",
>   					i == 1 ? now : SMU10_UMD_PSTATE_GFXCLK,
>   					i == 1 ? "*" : "");
> -		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n",
> +		size += sprintf(buf + size, "2: %uMhz %s\n",
>   					data->gfx_max_freq_limit/100,
>   					i == 2 ? "*" : "");
>   		break;
> @@ -1052,7 +1050,7 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetFclkFrequency, &now);
>   
>   		for (i = 0; i < mclk_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   					i,
>   					mclk_table->entries[i].clk / 100,
>   					((mclk_table->entries[i].clk / 100)
> @@ -1067,10 +1065,10 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   			if (ret)
>   				return ret;
>   
> -			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> -			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
> +			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
> +			size += sprintf(buf + size, "0: %10uMhz\n",
>   			(data->gfx_actual_soft_min_freq > 0) ? data->gfx_actual_soft_min_freq : min_freq);
> -			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
> +			size += sprintf(buf + size, "1: %10uMhz\n",
>   			(data->gfx_actual_soft_max_freq > 0) ? data->gfx_actual_soft_max_freq : max_freq);
>   		}
>   		break;
> @@ -1083,8 +1081,8 @@ static int smu10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   			if (ret)
>   				return ret;
>   
> -			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> -			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
> +			size += sprintf(buf + size, "%s:\n", "OD_RANGE");
> +			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
>   				min_freq, max_freq);
>   		}
>   		break;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index aceebf584225..611969bf4520 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -4914,8 +4914,6 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	int size = 0;
>   	uint32_t i, now, clock, pcie_speed;
>   
> -	phm_get_sysfs_buf(&buf, &size);
> -
>   	switch (type) {
>   	case PP_SCLK:
>   		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_API_GetSclkFrequency, &clock);
> @@ -4928,7 +4926,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		now = i;
>   
>   		for (i = 0; i < sclk_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   					i, sclk_table->dpm_levels[i].value / 100,
>   					(i == now) ? "*" : "");
>   		break;
> @@ -4943,7 +4941,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		now = i;
>   
>   		for (i = 0; i < mclk_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   					i, mclk_table->dpm_levels[i].value / 100,
>   					(i == now) ? "*" : "");
>   		break;
> @@ -4957,7 +4955,7 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		now = i;
>   
>   		for (i = 0; i < pcie_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %s %s\n", i,
> +			size += sprintf(buf + size, "%d: %s %s\n", i,
>   					(pcie_table->dpm_levels[i].value == 0) ? "2.5GT/s, x8" :
>   					(pcie_table->dpm_levels[i].value == 1) ? "5.0GT/s, x16" :
>   					(pcie_table->dpm_levels[i].value == 2) ? "8.0GT/s, x16" : "",
> @@ -4965,32 +4963,32 @@ static int smu7_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		break;
>   	case OD_SCLK:
>   		if (hwmgr->od_enabled) {
> -			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> +			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
>   			for (i = 0; i < odn_sclk_table->num_of_pl; i++)
> -				size += sysfs_emit_at(buf, size, "%d: %10uMHz %10umV\n",
> +				size += sprintf(buf + size, "%d: %10uMHz %10umV\n",
>   					i, odn_sclk_table->entries[i].clock/100,
>   					odn_sclk_table->entries[i].vddc);
>   		}
>   		break;
>   	case OD_MCLK:
>   		if (hwmgr->od_enabled) {
> -			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
> +			size += sprintf(buf + size, "%s:\n", "OD_MCLK");
>   			for (i = 0; i < odn_mclk_table->num_of_pl; i++)
> -				size += sysfs_emit_at(buf, size, "%d: %10uMHz %10umV\n",
> +				size += sprintf(buf + size, "%d: %10uMHz %10umV\n",
>   					i, odn_mclk_table->entries[i].clock/100,
>   					odn_mclk_table->entries[i].vddc);
>   		}
>   		break;
>   	case OD_RANGE:
>   		if (hwmgr->od_enabled) {
> -			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> -			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
> +			size += sprintf(buf + size, "%s:\n", "OD_RANGE");
> +			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
>   				data->golden_dpm_table.sclk_table.dpm_levels[0].value/100,
>   				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
> -			size += sysfs_emit_at(buf, size, "MCLK: %7uMHz %10uMHz\n",
> +			size += sprintf(buf + size, "MCLK: %7uMHz %10uMHz\n",
>   				data->golden_dpm_table.mclk_table.dpm_levels[0].value/100,
>   				hwmgr->platform_descriptor.overdriveLimit.memoryClock/100);
> -			size += sysfs_emit_at(buf, size, "VDDC: %7umV %11umV\n",
> +			size += sprintf(buf + size, "VDDC: %7umV %11umV\n",
>   				data->odn_dpm_table.min_vddc,
>   				data->odn_dpm_table.max_vddc);
>   		}
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index 8e28a8eecefc..03bf8f069222 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -1550,8 +1550,6 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	uint32_t i, now;
>   	int size = 0;
>   
> -	phm_get_sysfs_buf(&buf, &size);
> -
>   	switch (type) {
>   	case PP_SCLK:
>   		now = PHM_GET_FIELD(cgs_read_ind_register(hwmgr->device,
> @@ -1561,7 +1559,7 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				CURR_SCLK_INDEX);
>   
>   		for (i = 0; i < sclk_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   					i, sclk_table->entries[i].clk / 100,
>   					(i == now) ? "*" : "");
>   		break;
> @@ -1573,7 +1571,7 @@ static int smu8_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				CURR_MCLK_INDEX);
>   
>   		for (i = SMU8_NUM_NBPMEMORYCLOCK; i > 0; i--)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   					SMU8_NUM_NBPMEMORYCLOCK-i, data->sys_info.nbp_memory_clock[i-1] / 100,
>   					(SMU8_NUM_NBPMEMORYCLOCK-i == now) ? "*" : "");
>   		break;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index c981fc2882f0..e6336654c565 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4639,8 +4639,6 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   
>   	int i, now, size = 0, count = 0;
>   
> -	phm_get_sysfs_buf(&buf, &size);
> -
>   	switch (type) {
>   	case PP_SCLK:
>   		if (data->registry_data.sclk_dpm_key_disabled)
> @@ -4654,7 +4652,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		else
>   			count = sclk_table->count;
>   		for (i = 0; i < count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   					i, sclk_table->dpm_levels[i].value / 100,
>   					(i == now) ? "*" : "");
>   		break;
> @@ -4665,7 +4663,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &now);
>   
>   		for (i = 0; i < mclk_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   					i, mclk_table->dpm_levels[i].value / 100,
>   					(i == now) ? "*" : "");
>   		break;
> @@ -4676,7 +4674,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentSocclkIndex, &now);
>   
>   		for (i = 0; i < soc_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   					i, soc_table->dpm_levels[i].value / 100,
>   					(i == now) ? "*" : "");
>   		break;
> @@ -4688,7 +4686,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				PPSMC_MSG_GetClockFreqMHz, CLK_DCEFCLK, &now);
>   
>   		for (i = 0; i < dcef_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   					i, dcef_table->dpm_levels[i].value / 100,
>   					(dcef_table->dpm_levels[i].value / 100 == now) ?
>   					"*" : "");
> @@ -4702,7 +4700,7 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   			gen_speed = pptable->PcieGenSpeed[i];
>   			lane_width = pptable->PcieLaneCount[i];
>   
> -			size += sysfs_emit_at(buf, size, "%d: %s %s %s\n", i,
> +			size += sprintf(buf + size, "%d: %s %s %s\n", i,
>   					(gen_speed == 0) ? "2.5GT/s," :
>   					(gen_speed == 1) ? "5.0GT/s," :
>   					(gen_speed == 2) ? "8.0GT/s," :
> @@ -4721,34 +4719,34 @@ static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
>   
>   	case OD_SCLK:
>   		if (hwmgr->od_enabled) {
> -			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> +			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
>   			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_sclk;
>   			for (i = 0; i < podn_vdd_dep->count; i++)
> -				size += sysfs_emit_at(buf, size, "%d: %10uMhz %10umV\n",
> +				size += sprintf(buf + size, "%d: %10uMhz %10umV\n",
>   					i, podn_vdd_dep->entries[i].clk / 100,
>   						podn_vdd_dep->entries[i].vddc);
>   		}
>   		break;
>   	case OD_MCLK:
>   		if (hwmgr->od_enabled) {
> -			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
> +			size += sprintf(buf + size, "%s:\n", "OD_MCLK");
>   			podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_mclk;
>   			for (i = 0; i < podn_vdd_dep->count; i++)
> -				size += sysfs_emit_at(buf, size, "%d: %10uMhz %10umV\n",
> +				size += sprintf(buf + size, "%d: %10uMhz %10umV\n",
>   					i, podn_vdd_dep->entries[i].clk/100,
>   						podn_vdd_dep->entries[i].vddc);
>   		}
>   		break;
>   	case OD_RANGE:
>   		if (hwmgr->od_enabled) {
> -			size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> -			size += sysfs_emit_at(buf, size, "SCLK: %7uMHz %10uMHz\n",
> +			size += sprintf(buf + size, "%s:\n", "OD_RANGE");
> +			size += sprintf(buf + size, "SCLK: %7uMHz %10uMHz\n",
>   				data->golden_dpm_table.gfx_table.dpm_levels[0].value/100,
>   				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
> -			size += sysfs_emit_at(buf, size, "MCLK: %7uMHz %10uMHz\n",
> +			size += sprintf(buf + size, "MCLK: %7uMHz %10uMHz\n",
>   				data->golden_dpm_table.mem_table.dpm_levels[0].value/100,
>   				hwmgr->platform_descriptor.overdriveLimit.memoryClock/100);
> -			size += sysfs_emit_at(buf, size, "VDDC: %7umV %11umV\n",
> +			size += sprintf(buf + size, "VDDC: %7umV %11umV\n",
>   				data->odn_dpm_table.min_vddc,
>   				data->odn_dpm_table.max_vddc);
>   		}
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> index f7e783e1c888..a2f4d6773d45 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
> @@ -2246,8 +2246,6 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	int i, now, size = 0;
>   	struct pp_clock_levels_with_latency clocks;
>   
> -	phm_get_sysfs_buf(&buf, &size);
> -
>   	switch (type) {
>   	case PP_SCLK:
>   		PP_ASSERT_WITH_CODE(
> @@ -2260,7 +2258,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				"Attempt to get gfx clk levels Failed!",
>   				return -1);
>   		for (i = 0; i < clocks.num_levels; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   				i, clocks.data[i].clocks_in_khz / 1000,
>   				(clocks.data[i].clocks_in_khz / 1000 == now / 100) ? "*" : "");
>   		break;
> @@ -2276,7 +2274,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				"Attempt to get memory clk levels Failed!",
>   				return -1);
>   		for (i = 0; i < clocks.num_levels; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   				i, clocks.data[i].clocks_in_khz / 1000,
>   				(clocks.data[i].clocks_in_khz / 1000 == now / 100) ? "*" : "");
>   		break;
> @@ -2294,7 +2292,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				"Attempt to get soc clk levels Failed!",
>   				return -1);
>   		for (i = 0; i < clocks.num_levels; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   				i, clocks.data[i].clocks_in_khz / 1000,
>   				(clocks.data[i].clocks_in_khz / 1000 == now) ? "*" : "");
>   		break;
> @@ -2312,7 +2310,7 @@ static int vega12_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				"Attempt to get dcef clk levels Failed!",
>   				return -1);
>   		for (i = 0; i < clocks.num_levels; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   				i, clocks.data[i].clocks_in_khz / 1000,
>   				(clocks.data[i].clocks_in_khz / 1000 == now) ? "*" : "");
>   		break;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> index 03e63be4ee27..85d55ab4e369 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
> @@ -3366,8 +3366,6 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	int ret = 0;
>   	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
>   
> -	phm_get_sysfs_buf(&buf, &size);
> -
>   	switch (type) {
>   	case PP_SCLK:
>   		ret = vega20_get_current_clk_freq(hwmgr, PPCLK_GFXCLK, &now);
> @@ -3376,13 +3374,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				return ret);
>   
>   		if (vega20_get_sclks(hwmgr, &clocks)) {
> -			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
> +			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
>   				now / 100);
>   			break;
>   		}
>   
>   		for (i = 0; i < clocks.num_levels; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   				i, clocks.data[i].clocks_in_khz / 1000,
>   				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
>   		break;
> @@ -3394,13 +3392,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				return ret);
>   
>   		if (vega20_get_memclocks(hwmgr, &clocks)) {
> -			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
> +			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
>   				now / 100);
>   			break;
>   		}
>   
>   		for (i = 0; i < clocks.num_levels; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   				i, clocks.data[i].clocks_in_khz / 1000,
>   				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
>   		break;
> @@ -3412,13 +3410,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				return ret);
>   
>   		if (vega20_get_socclocks(hwmgr, &clocks)) {
> -			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
> +			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
>   				now / 100);
>   			break;
>   		}
>   
>   		for (i = 0; i < clocks.num_levels; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   				i, clocks.data[i].clocks_in_khz / 1000,
>   				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
>   		break;
> @@ -3430,7 +3428,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				return ret);
>   
>   		for (i = 0; i < fclk_dpm_table->count; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   				i, fclk_dpm_table->dpm_levels[i].value,
>   				fclk_dpm_table->dpm_levels[i].value == (now / 100) ? "*" : "");
>   		break;
> @@ -3442,13 +3440,13 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   				return ret);
>   
>   		if (vega20_get_dcefclocks(hwmgr, &clocks)) {
> -			size += sysfs_emit_at(buf, size, "0: %uMhz * (DPM disabled)\n",
> +			size += sprintf(buf + size, "0: %uMhz * (DPM disabled)\n",
>   				now / 100);
>   			break;
>   		}
>   
>   		for (i = 0; i < clocks.num_levels; i++)
> -			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
> +			size += sprintf(buf + size, "%d: %uMhz %s\n",
>   				i, clocks.data[i].clocks_in_khz / 1000,
>   				(clocks.data[i].clocks_in_khz == now * 10) ? "*" : "");
>   		break;
> @@ -3462,7 +3460,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   			gen_speed = pptable->PcieGenSpeed[i];
>   			lane_width = pptable->PcieLaneCount[i];
>   
> -			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
> +			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
>   					(gen_speed == 0) ? "2.5GT/s," :
>   					(gen_speed == 1) ? "5.0GT/s," :
>   					(gen_speed == 2) ? "8.0GT/s," :
> @@ -3483,18 +3481,18 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   	case OD_SCLK:
>   		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
>   		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
> -			size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
> -			size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
> +			size += sprintf(buf + size, "%s:\n", "OD_SCLK");
> +			size += sprintf(buf + size, "0: %10uMhz\n",
>   				od_table->GfxclkFmin);
> -			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
> +			size += sprintf(buf + size, "1: %10uMhz\n",
>   				od_table->GfxclkFmax);
>   		}
>   		break;
>   
>   	case OD_MCLK:
>   		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
> -			size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
> -			size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
> +			size += sprintf(buf + size, "%s:\n", "OD_MCLK");
> +			size += sprintf(buf + size, "1: %10uMhz\n",
>   				od_table->UclkFmax);
>   		}
>   
> @@ -3507,14 +3505,14 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
>   		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
>   		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
> -			size += sysfs_emit_at(buf, size, "%s:\n", "OD_VDDC_CURVE");
> -			size += sysfs_emit_at(buf, size, "0: %10uMhz %10dmV\n",
> +			size += sprintf(buf + size, "%s:\n", "OD_VDDC_CURVE");
> +			size += sprintf(buf + size, "0: %10uMhz %10dmV\n",
>   				od_table->GfxclkFreq1,
>   				od_table->GfxclkVolt1 / VOLTAGE_SCALE);
> -			size += sysfs_emit_at(buf, size, "1: %10uMhz %10dmV\n",
> +			size += sprintf(buf + size, "1: %10uMhz %10dmV\n",
>   				od_table->GfxclkFreq2,
>   				od_table->GfxclkVolt2 / VOLTAGE_SCALE);
> -			size += sysfs_emit_at(buf, size, "2: %10uMhz %10dmV\n",
> +			size += sprintf(buf + size, "2: %10uMhz %10dmV\n",
>   				od_table->GfxclkFreq3,
>   				od_table->GfxclkVolt3 / VOLTAGE_SCALE);
>   		}
> @@ -3522,17 +3520,17 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		break;
>   
>   	case OD_RANGE:
> -		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
> +		size += sprintf(buf + size, "%s:\n", "OD_RANGE");
>   
>   		if (od8_settings[OD8_SETTING_GFXCLK_FMIN].feature_id &&
>   		    od8_settings[OD8_SETTING_GFXCLK_FMAX].feature_id) {
> -			size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
> +			size += sprintf(buf + size, "SCLK: %7uMhz %10uMhz\n",
>   				od8_settings[OD8_SETTING_GFXCLK_FMIN].min_value,
>   				od8_settings[OD8_SETTING_GFXCLK_FMAX].max_value);
>   		}
>   
>   		if (od8_settings[OD8_SETTING_UCLK_FMAX].feature_id) {
> -			size += sysfs_emit_at(buf, size, "MCLK: %7uMhz %10uMhz\n",
> +			size += sprintf(buf + size, "MCLK: %7uMhz %10uMhz\n",
>   				od8_settings[OD8_SETTING_UCLK_FMAX].min_value,
>   				od8_settings[OD8_SETTING_UCLK_FMAX].max_value);
>   		}
> @@ -3543,22 +3541,22 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
>   		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].feature_id &&
>   		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].feature_id &&
>   		    od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].feature_id) {
> -			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
> +			size += sprintf(buf + size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhz\n",
>   				od8_settings[OD8_SETTING_GFXCLK_FREQ1].min_value,
>   				od8_settings[OD8_SETTING_GFXCLK_FREQ1].max_value);
> -			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
> +			size += sprintf(buf + size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmV\n",
>   				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].min_value,
>   				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].max_value);
> -			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
> +			size += sprintf(buf + size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhz\n",
>   				od8_settings[OD8_SETTING_GFXCLK_FREQ2].min_value,
>   				od8_settings[OD8_SETTING_GFXCLK_FREQ2].max_value);
> -			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
> +			size += sprintf(buf + size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmV\n",
>   				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].min_value,
>   				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].max_value);
> -			size += sysfs_emit_at(buf, size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
> +			size += sprintf(buf + size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhz\n",
>   				od8_settings[OD8_SETTING_GFXCLK_FREQ3].min_value,
>   				od8_settings[OD8_SETTING_GFXCLK_FREQ3].max_value);
> -			size += sysfs_emit_at(buf, size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
> +			size += sprintf(buf + size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmV\n",
>   				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].min_value,
>   				od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].max_value);
>   		}

