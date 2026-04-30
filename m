Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E222FCD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 19:03:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E56310F41D;
	Thu, 30 Apr 2026 19:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="KphXW2kH";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8631510F41D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 19:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yArHcDF5lW+4/LWXSkdPssjcvLAjhtzFVvh8kVR9rbE=; b=KphXW2kHmU3j7++HrfhL30eNPZ
 tR0u8d4bO3DKZ+hkGxy3EPE+l4VyjOVzU8DE0FDqMnXZDUvgk/8EOBNpFtF4KeUyGp9RnGmyf8mY8
 Q+Sks9VTmqpbSxeYvqEaov1hs5lpRAFfNt5+jrElI2pBeyNCe99+54ibkSBe/L9MEM/chEaf/Z+9h
 GTB1ZaozxENTL61RuxuFesWoT1ULpC5aFF4RBh6a3XUr2UjACy4SshPdFpxJy6K3Ys8sUgyJNqQ5q
 ibZEuenK75yjHnruq7nuR1cyXXvDUmZb/cHFjOkjBdM5OjiieEQDr5IFIoiZSH30LkhaeOBHyRV9b
 M0QsXiwg==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIWfM-004Ycs-3s; Thu, 30 Apr 2026 21:03:15 +0200
Message-ID: <33988632-e3a0-40a7-a060-6f33b5341cf3@igalia.com>
Date: Thu, 30 Apr 2026 16:03:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/14] drm/amd/pm: Delete vddc_dep_on_dal_pwrl
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-13-timur.kristof@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260423191519.73127-13-timur.kristof@gmail.com>
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
> It was not used by anything anymore.
Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../amd/pm/powerplay/hwmgr/processpptables.c  |  1 -
>   .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 41 ------------------
>   .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 42 -------------------
>   .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c |  3 --
>   drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h  |  2 -
>   5 files changed, 89 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
> index f06b29e33ba45..00e8f1be87e76 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
> @@ -1324,7 +1324,6 @@ static int init_clock_voltage_dependency(struct pp_hwmgr *hwmgr,
>   	hwmgr->dyn_state.vddc_dependency_on_sclk = NULL;
>   	hwmgr->dyn_state.vddci_dependency_on_mclk = NULL;
>   	hwmgr->dyn_state.vddc_dependency_on_mclk = NULL;
> -	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
>   	hwmgr->dyn_state.mvdd_dependency_on_mclk = NULL;
>   	hwmgr->dyn_state.vce_clock_voltage_dependency_table = NULL;
>   	hwmgr->dyn_state.uvd_clock_voltage_dependency_table = NULL;
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 5be6f82ecc6f5..f5c1f483dec87 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -127,42 +127,6 @@ static int smu10_construct_max_power_limits_table(struct pp_hwmgr *hwmgr,
>   	return 0;
>   }
>   
> -static int smu10_init_dynamic_state_adjustment_rule_settings(
> -							struct pp_hwmgr *hwmgr)
> -{
> -	int count = 8;
> -	struct phm_clock_voltage_dependency_table *table_clk_vlt;
> -
> -	table_clk_vlt = kzalloc(struct_size(table_clk_vlt, entries, count),
> -				GFP_KERNEL);
> -
> -	if (NULL == table_clk_vlt) {
> -		pr_err("Can not allocate memory!\n");
> -		return -ENOMEM;
> -	}
> -
> -	table_clk_vlt->count = count;
> -	table_clk_vlt->entries[0].clk = PP_DAL_POWERLEVEL_0;
> -	table_clk_vlt->entries[0].v = 0;
> -	table_clk_vlt->entries[1].clk = PP_DAL_POWERLEVEL_1;
> -	table_clk_vlt->entries[1].v = 1;
> -	table_clk_vlt->entries[2].clk = PP_DAL_POWERLEVEL_2;
> -	table_clk_vlt->entries[2].v = 2;
> -	table_clk_vlt->entries[3].clk = PP_DAL_POWERLEVEL_3;
> -	table_clk_vlt->entries[3].v = 3;
> -	table_clk_vlt->entries[4].clk = PP_DAL_POWERLEVEL_4;
> -	table_clk_vlt->entries[4].v = 4;
> -	table_clk_vlt->entries[5].clk = PP_DAL_POWERLEVEL_5;
> -	table_clk_vlt->entries[5].v = 5;
> -	table_clk_vlt->entries[6].clk = PP_DAL_POWERLEVEL_6;
> -	table_clk_vlt->entries[6].v = 6;
> -	table_clk_vlt->entries[7].clk = PP_DAL_POWERLEVEL_7;
> -	table_clk_vlt->entries[7].v = 7;
> -	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = table_clk_vlt;
> -
> -	return 0;
> -}
> -
>   static int smu10_get_system_info_data(struct pp_hwmgr *hwmgr)
>   {
>   	struct smu10_hwmgr *smu10_data = (struct smu10_hwmgr *)hwmgr->backend;
> @@ -176,8 +140,6 @@ static int smu10_get_system_info_data(struct pp_hwmgr *hwmgr)
>   	smu10_construct_max_power_limits_table (hwmgr,
>   				    &hwmgr->dyn_state.max_clock_voltage_on_ac);
>   
> -	smu10_init_dynamic_state_adjustment_rule_settings(hwmgr);
> -
>   	return 0;
>   }
>   
> @@ -612,9 +574,6 @@ static int smu10_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
>   	kfree(pinfo->vdd_dep_on_phyclk);
>   	pinfo->vdd_dep_on_phyclk = NULL;
>   
> -	kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
> -	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
> -
>   	kfree(hwmgr->backend);
>   	hwmgr->backend = NULL;
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> index 8a37c745cb117..63a1e3748e5cd 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
> @@ -270,42 +270,6 @@ static int smu8_construct_max_power_limits_table(struct pp_hwmgr *hwmgr,
>   	return 0;
>   }
>   
> -static int smu8_init_dynamic_state_adjustment_rule_settings(
> -			struct pp_hwmgr *hwmgr,
> -			ATOM_CLK_VOLT_CAPABILITY *disp_voltage_table)
> -{
> -	struct phm_clock_voltage_dependency_table *table_clk_vlt;
> -
> -	table_clk_vlt = kzalloc(struct_size(table_clk_vlt, entries, 8),
> -				GFP_KERNEL);
> -
> -	if (NULL == table_clk_vlt) {
> -		pr_err("Can not allocate memory!\n");
> -		return -ENOMEM;
> -	}
> -
> -	table_clk_vlt->count = 8;
> -	table_clk_vlt->entries[0].clk = PP_DAL_POWERLEVEL_0;
> -	table_clk_vlt->entries[0].v = 0;
> -	table_clk_vlt->entries[1].clk = PP_DAL_POWERLEVEL_1;
> -	table_clk_vlt->entries[1].v = 1;
> -	table_clk_vlt->entries[2].clk = PP_DAL_POWERLEVEL_2;
> -	table_clk_vlt->entries[2].v = 2;
> -	table_clk_vlt->entries[3].clk = PP_DAL_POWERLEVEL_3;
> -	table_clk_vlt->entries[3].v = 3;
> -	table_clk_vlt->entries[4].clk = PP_DAL_POWERLEVEL_4;
> -	table_clk_vlt->entries[4].v = 4;
> -	table_clk_vlt->entries[5].clk = PP_DAL_POWERLEVEL_5;
> -	table_clk_vlt->entries[5].v = 5;
> -	table_clk_vlt->entries[6].clk = PP_DAL_POWERLEVEL_6;
> -	table_clk_vlt->entries[6].v = 6;
> -	table_clk_vlt->entries[7].clk = PP_DAL_POWERLEVEL_7;
> -	table_clk_vlt->entries[7].v = 7;
> -	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = table_clk_vlt;
> -
> -	return 0;
> -}
> -
>   static int smu8_get_system_info_data(struct pp_hwmgr *hwmgr)
>   {
>   	struct smu8_hwmgr *data = hwmgr->backend;
> @@ -404,9 +368,6 @@ static int smu8_get_system_info_data(struct pp_hwmgr *hwmgr)
>   	smu8_construct_max_power_limits_table (hwmgr,
>   				    &hwmgr->dyn_state.max_clock_voltage_on_ac);
>   
> -	smu8_init_dynamic_state_adjustment_rule_settings(hwmgr,
> -				    &info->sDISPCLK_Voltage[0]);
> -
>   	return result;
>   }
>   
> @@ -1150,9 +1111,6 @@ static int smu8_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
>   static int smu8_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
>   {
>   	if (hwmgr != NULL) {
> -		kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
> -		hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
> -
>   		kfree(hwmgr->backend);
>   		hwmgr->backend = NULL;
>   	}
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> index 12f47ec87997d..8b8c4e8998784 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
> @@ -814,9 +814,6 @@ static int vega10_set_private_data_based_on_pptable(struct pp_hwmgr *hwmgr)
>   
>   static int vega10_hwmgr_backend_fini(struct pp_hwmgr *hwmgr)
>   {
> -	kfree(hwmgr->dyn_state.vddc_dep_on_dal_pwrl);
> -	hwmgr->dyn_state.vddc_dep_on_dal_pwrl = NULL;
> -
>   	kfree(hwmgr->backend);
>   	hwmgr->backend = NULL;
>   
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> index 3ae45eac0c5ca..1ee7e3044272d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
> @@ -540,7 +540,6 @@ struct phm_ppt_v1_information {
>   	struct phm_clock_array *valid_dcefclk_values;
>   	struct phm_clock_and_voltage_limits max_clock_voltage_on_dc;
>   	struct phm_clock_and_voltage_limits max_clock_voltage_on_ac;
> -	struct phm_clock_voltage_dependency_table *vddc_dep_on_dal_pwrl;
>   	struct phm_ppm_table *ppm_parameter_table;
>   	struct phm_cac_tdp_table *cac_dtp_table;
>   	struct phm_tdp_table *tdp_table;
> @@ -632,7 +631,6 @@ struct phm_dynamic_state_info {
>   	struct phm_clock_voltage_dependency_table *vddc_dependency_on_mclk;
>   	struct phm_clock_voltage_dependency_table *mvdd_dependency_on_mclk;
>   	struct phm_clock_voltage_dependency_table *vddc_dependency_on_display_clock;
> -	struct phm_clock_voltage_dependency_table *vddc_dep_on_dal_pwrl;
>   	struct phm_clock_array                    *valid_sclk_values;
>   	struct phm_clock_array                    *valid_mclk_values;
>   	struct phm_clock_and_voltage_limits       max_clock_voltage_on_dc;

