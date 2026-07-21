Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32499C4452B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 17:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAF6810E369;
	Tue, 21 Jul 2026 17:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R4619fn3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2174B10E369
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jul 2026 17:14:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F200F40874;
 Tue, 21 Jul 2026 17:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FF9C1F00A3A;
 Tue, 21 Jul 2026 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784654046;
 bh=IvEkqaPJhGIH9CuwSJAja+NNijobUX4lyHDD1B+0lGs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=R4619fn3jQ7pl+HyIPxp3uC6Pfcz24gueXRMJqi2vR+mUKifgAmW/+vOEozvJb/zP
 gmArAi4u0F8IiYcOR9dP5gT0kuj4KNZDCRUxjGKIpGv+ZplJogbs5+v7+57aeHV/if
 jjnLwmN65VkvziqN5Em8+0OyJn5Scb94wp4fEnCCxmqxi+HUvBbSxUt3qoso93Z09o
 gWGg7bpdU0bAP51dT9dN45BoDl8q2ghZ3zJf5YfjOtjM0N7vKVtvrYfhlwcqLLxkW9
 I0IZ5BK5vEcQyUrdNT2ObPx+O7TnM+JolQHyc38m2f7GixMBPbnmW4EPP+3tdFUybA
 vsTe+gKpUgncQ==
Message-ID: <53ba9a3e-7cce-4fa5-9cc9-a6c43afcb840@kernel.org>
Date: Tue, 21 Jul 2026 12:14:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Update driver if header for SMU V15.0.5
Content-Language: en-US
To: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>,
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 Pratik.Vishwakarma@amd.com, Lijo.Lazar@amd.com, amd-gfx@lists.freedesktop.org
Cc: Veerabadhran.Gopalakrishnan@amd.com, Pierre.Jabbour@amd.com
References: <20260721145054.1295003-1-Kanala.RamalingeswaraReddy@amd.com>
 <20260721164417.1902635-1-Kanala.RamalingeswaraReddy@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260721164417.1902635-1-Kanala.RamalingeswaraReddy@amd.com>
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



On 7/21/26 11:44, Kanala Ramalingeswara Reddy wrote:
> Update smu v15.0.0 driver if header to be v15.0.5 compatible.
> 
> Signed-off-by: Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>
> ---
>   .../inc/pmfw_if/smu15_driver_if_v15_0_0.h     |  38 +++
>   drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h  |   2 +-
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 220 +++++++++++++++++-
>   3 files changed, 253 insertions(+), 7 deletions(-)
> 
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
> index 47ddf533b08f..a5d3e8d88860 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
> @@ -144,6 +144,44 @@ typedef struct {
>     uint32_t MaxGfxClk;
>   } DpmClocks_t;
>   
> +//Freq in MHz
> +//Voltage in milli volts with 2 fractional bits
> +typedef struct {
> +	uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
> +	uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
> +	uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
> +	uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
> +
> +	uint32_t VPEClocks[NUM_VPE_DPM_LEVELS];
> +	uint32_t FclkClocks_Freq[NUM_FCLK_DPM_LEVELS];
> +	uint32_t FclkClocks_Voltage[NUM_FCLK_DPM_LEVELS];
> +	uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
> +	MemPstateTable_t MemPstateTable[NUM_MEM_PSTATE_LEVELS];
> +
> +	uint8_t  NumDcfClkLevelsEnabled;
> +	uint8_t  NumDispClkLevelsEnabled; //Applies to both Dispclk and Dppclk
> +	uint8_t  NumSocClkLevelsEnabled;
> +
> +	uint8_t  VpeClkLevelsEnabled;
> +
> +	uint8_t  NumMemPstatesEnabled;
> +	uint8_t  NumFclkLevelsEnabled;
> +	uint8_t  Spare1;
> +	uint8_t  Spare2;
> +
> +	uint8_t  Spare3;
> +	uint8_t  Spare4;
> +	uint8_t  Spare5[2];
> +
> +	uint32_t MinGfxClk;
> +	uint32_t MaxGfxClk;
> +
> +	uint32_t Spare6[8];
> +	uint32_t Spare7[8];
> +	uint32_t Spare8[8];
> +	uint32_t Spare9[8];
> +} DpmClocks_t_v15_0_5;
> +
>   typedef struct {
>     uint16_t CoreFrequency[16];          //Target core frequency [MHz]
>     uint16_t CorePower[16];              //CAC calculated core power [mW]
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> index 13723d45a7de..38e625cda97d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v15_0.h
> @@ -26,7 +26,7 @@
>   #include "amdgpu_smu.h"
>   
>   #define SMU15_DRIVER_IF_VERSION_INV 0xFFFFFFFF
> -#define SMU15_DRIVER_IF_VERSION_SMU_V15_0 0x7
> +#define SMU15_DRIVER_IF_VERSION_SMU_V15_0 0x9
>   
>   
>   #define FEATURE_MASK(feature) (1ULL << feature)
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index bb8d09e73c7d..faa7d661f3bf 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -168,7 +168,7 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
>   
>   	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
>   		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> -	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
> +	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t_v15_0_5),
>   		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
>   	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
>   		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
> @@ -178,7 +178,7 @@ static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
>   		goto err0_out;
>   	smu_table->metrics_time = 0;
>   
> -	smu_table->clocks_table = kzalloc_obj(DpmClocks_t);
> +	smu_table->clocks_table = kzalloc_obj(DpmClocks_t_v15_0_5);
>   	if (!smu_table->clocks_table)
>   		goto err1_out;
>   
> @@ -752,11 +752,48 @@ static int smu_v15_0_0_get_dpm_freq_by_index(struct smu_context *smu,
>   	return 0;
>   }
>   
> +static int smu_v15_0_5_get_dpm_freq_by_index(struct smu_context *smu,
> +						enum smu_clk_type clk_type,
> +						uint32_t dpm_level,
> +						uint32_t *freq)
> +{
> +	DpmClocks_t_v15_0_5 *clk_table = smu->smu_table.clocks_table;
> +
> +	if (!clk_table || clk_type >= SMU_CLK_COUNT)
> +		return -EINVAL;
> +
> +	switch (clk_type) {
> +	case SMU_SOCCLK:
> +		if (dpm_level >= clk_table->NumSocClkLevelsEnabled)
> +			return -EINVAL;
> +		*freq = clk_table->SocClocks[dpm_level];
> +		break;
> +	case SMU_UCLK:
> +	case SMU_MCLK:
> +		if (dpm_level >= clk_table->NumMemPstatesEnabled)
> +			return -EINVAL;
> +		*freq = clk_table->MemPstateTable[dpm_level].MemClk;
> +		break;
> +	case SMU_FCLK:
> +		if (dpm_level >= clk_table->NumFclkLevelsEnabled)
> +			return -EINVAL;
> +		*freq = clk_table->FclkClocks_Freq[dpm_level];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static int smu_v15_0_common_get_dpm_freq_by_index(struct smu_context *smu,
>   						enum smu_clk_type clk_type,
>   						uint32_t dpm_level,
>   						uint32_t *freq)
>   {
> +	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 5))
> +		smu_v15_0_5_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
> +	else
>   		smu_v15_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
>   
>   	return 0;
> @@ -907,12 +944,116 @@ static int smu_v15_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static int smu_v15_0_5_get_dpm_ultimate_freq(struct smu_context *smu,
> +							enum smu_clk_type clk_type,
> +							uint32_t *min,
> +							uint32_t *max)
> +{
> +	DpmClocks_t_v15_0_5 *clk_table = smu->smu_table.clocks_table;
> +	uint32_t clock_limit;
> +	uint32_t max_dpm_level, min_dpm_level;
> +	int ret = 0;
> +
> +	if (!smu_v15_0_0_clk_dpm_is_enabled(smu, clk_type)) {
> +		switch (clk_type) {
> +		case SMU_MCLK:
> +		case SMU_UCLK:
> +			clock_limit = smu->smu_table.boot_values.uclk;
> +			break;
> +		case SMU_FCLK:
> +			clock_limit = smu->smu_table.boot_values.fclk;
> +			break;
> +		case SMU_GFXCLK:
> +		case SMU_SCLK:
> +			clock_limit = smu->smu_table.boot_values.gfxclk;
> +			break;
> +		case SMU_SOCCLK:
> +			clock_limit = smu->smu_table.boot_values.socclk;
> +			break;
> +		default:
> +			clock_limit = 0;
> +			break;
> +		}
> +
> +		/* clock in Mhz unit */
> +		if (min)
> +			*min = clock_limit / 100;
> +		if (max)
> +			*max = clock_limit / 100;
> +
> +		return 0;
> +	}
> +
> +	if (max) {
> +		switch (clk_type) {
> +		case SMU_GFXCLK:
> +		case SMU_SCLK:
> +			*max = clk_table->MaxGfxClk;
> +			break;
> +		case SMU_MCLK:
> +		case SMU_UCLK:
> +			max_dpm_level = 0;
> +			break;
> +		case SMU_FCLK:
> +			max_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
> +			break;
> +		case SMU_SOCCLK:
> +			max_dpm_level = clk_table->NumSocClkLevelsEnabled - 1;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto failed;
> +		}
> +
> +		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
> +			ret = smu_v15_0_common_get_dpm_freq_by_index(smu, clk_type,
> +				max_dpm_level, max);
> +			if (ret)
> +				goto failed;
> +		}
> +	}
> +
> +	if (min) {
> +		switch (clk_type) {
> +		case SMU_GFXCLK:
> +		case SMU_SCLK:
> +			*min = clk_table->MinGfxClk;
> +			break;
> +		case SMU_MCLK:
> +		case SMU_UCLK:
> +			min_dpm_level = clk_table->NumMemPstatesEnabled - 1;
> +			break;
> +		case SMU_FCLK:
> +			min_dpm_level = 0;
> +			break;
> +		case SMU_SOCCLK:
> +			min_dpm_level = 0;
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			goto failed;
> +		}
> +
> +		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
> +			ret = smu_v15_0_common_get_dpm_freq_by_index(smu, clk_type,
> +				min_dpm_level, min);
> +			if (ret)
> +				goto failed;
> +		}
> +	}
> +
> +failed:
> +	return ret;
> +}
> +
>   static int smu_v15_0_common_get_dpm_ultimate_freq(struct smu_context *smu,
>   							enum smu_clk_type clk_type,
>   							uint32_t *min,
>   							uint32_t *max)
>   {
> -	if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
> +	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 5))
> +		smu_v15_0_5_get_dpm_ultimate_freq(smu, clk_type, min, max);
> +	else if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
>   		smu_v15_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
>   
>   	return 0;
> @@ -986,11 +1127,36 @@ static int smu_v15_0_0_get_dpm_level_count(struct smu_context *smu,
>   	return 0;
>   }
>   
> +static int smu_v15_0_5_get_dpm_level_count(struct smu_context *smu,
> +					   enum smu_clk_type clk_type,
> +					   uint32_t *count)
> +{
> +	DpmClocks_t_v15_0_5 *clk_table = smu->smu_table.clocks_table;
> +
> +	switch (clk_type) {
> +	case SMU_SOCCLK:
> +		*count = clk_table->NumSocClkLevelsEnabled;
> +		break;
> +	case SMU_MCLK:
> +		*count = clk_table->NumMemPstatesEnabled;
> +		break;
> +	case SMU_FCLK:
> +		*count = clk_table->NumFclkLevelsEnabled;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
>   static int smu_v15_0_common_get_dpm_level_count(struct smu_context *smu,
>   					   enum smu_clk_type clk_type,
>   					   uint32_t *count)
>   {
> -	if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
> +	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 5))
> +		smu_v15_0_5_get_dpm_level_count(smu, clk_type, count);
> +	else if (clk_type != SMU_VCLK1 && clk_type != SMU_DCLK1)
>   		smu_v15_0_0_get_dpm_level_count(smu, clk_type, count);
>   
>   	return 0;
> @@ -1363,9 +1529,24 @@ static int smu_v15_0_0_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
>   	return 0;
>   }
>   
> +static int smu_v15_0_5_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
> +{
> +	DpmClocks_t_v15_0_5 *clk_table = smu->smu_table.clocks_table;
> +
> +	smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
> +	smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
> +	smu->gfx_actual_hard_min_freq = 0;
> +	smu->gfx_actual_soft_max_freq = 0;
> +
> +	return 0;
> +}
> +
>   static int smu_v15_0_common_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
>   {
> -	smu_v15_0_0_set_fine_grain_gfx_freq_parameters(smu);
> +	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 5))
> +		smu_v15_0_5_set_fine_grain_gfx_freq_parameters(smu);
> +	else
> +		smu_v15_0_0_set_fine_grain_gfx_freq_parameters(smu);
>   
>   	return 0;
>   }
> @@ -1405,9 +1586,36 @@ static int smu_v15_0_0_get_dpm_table(struct smu_context *smu, struct dpm_clocks
>   	return 0;
>   }
>   
> +static int smu_v15_0_5_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
> +{
> +	DpmClocks_t_v15_0_5 *clk_table = smu->smu_table.clocks_table;
> +	uint8_t idx;
> +
> +	/*
> +	 * Only the Clock information of SOC and
> +	 * VPE is copied to provide VPE DPM settings for use.
> +	 */
> +	for (idx = 0; idx < NUM_SOCCLK_DPM_LEVELS; idx++) {
> +		clock_table->SocClocks[idx].Freq =
> +			(idx < clk_table->NumSocClkLevelsEnabled) ? clk_table->SocClocks[idx]:0;
> +		clock_table->SocClocks[idx].Vol = 0;
> +	}
> +
> +	for (idx = 0; idx < NUM_VPE_DPM_LEVELS; idx++) {
> +		clock_table->VPEClocks[idx].Freq =
> +			(idx < clk_table->VpeClkLevelsEnabled) ? clk_table->VPEClocks[idx]:0;
> +		clock_table->VPEClocks[idx].Vol = 0;
> +	}
> +
> +	return 0;
> +}
> +
>   static int smu_v15_0_common_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
>   {
> -	smu_v15_0_0_get_dpm_table(smu, clock_table);
> +	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(15, 0, 5))
> +		smu_v15_0_5_get_dpm_table(smu, clock_table);
> +	else
> +		smu_v15_0_0_get_dpm_table(smu, clock_table);
>   
>   	return 0;
>   }

