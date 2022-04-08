Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C75FC433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 10:07:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE3C10F1A4;
	Fri,  8 Apr 2022 10:07:57 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2018110F1A5
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 10:07:56 +0000 (UTC)
Received: from [141.14.14.90] (v090.vpnx.molgen.mpg.de [141.14.14.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id BB33761E6478B;
 Fri,  8 Apr 2022 12:07:53 +0200 (CEST)
Message-ID: <d47c0790-cc1e-a394-7140-b487a37ab3fe@molgen.mpg.de>
Date: Fri, 8 Apr 2022 12:07:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH Review 1/1] drm/amdgpu: add umc query error status function
Content-Language: en-US
To: Stanley Yang <Stanley.Yang@amd.com>
References: <20220408081009.31319-1-Stanley.Yang@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220408081009.31319-1-Stanley.Yang@amd.com>
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
Cc: tao.zhou1@amd.com, candice.li@amd.com, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Stanley,


Thank you for the patch.

Am 08.04.22 um 10:10 schrieb Stanley.Yang:

Please remove the dot/period from the name.

> In order to debug ras error, driver will print IPID/SYND/MISC0
> register value if detect correctable or uncorrectable error.

… if it detects …

> Provide umc_query_error_status_helper function to reduce code
> redundancy.

Can you please make this two patches. First refactoring, and then adding 
new call sites. (The current commit message summary, does not say 
anything about new call-sites.)

> Change-Id: I09a2aae85cde3ab2cb6b042b973da6839ad024ec

Without the Gerrit review instance, the Change-Id is not of any use.

> Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>

Please remove the . from the name.


Kind regards,

Paul


> ---
>   drivers/gpu/drm/amd/amdgpu/umc_v6_7.c | 106 ++++++++++++--------------
>   1 file changed, 48 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> index c45d9c14ecbc..9d3b54778417 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v6_7.c
> @@ -64,21 +64,62 @@ static inline uint32_t get_umc_v6_7_channel_index(struct amdgpu_device *adev,
>   	return adev->umc.channel_idx_tbl[umc_inst * adev->umc.channel_inst_num + ch_inst];
>   }
>   
> +static void umc_query_error_status_helper(struct amdgpu_device *adev,
> +						  uint64_t mc_umc_status, uint32_t umc_reg_offset)
> +{
> +	uint32_t mc_umc_addr;
> +	uint64_t reg_value;
> +
> +	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1)
> +		dev_info(adev->dev, "Deferred error, no user action is needed.\n");
> +
> +	if (mc_umc_status)
> +		dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
> +
> +	/* print IPID registers value */
> +	mc_umc_addr =
> +		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
> +	reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> +	if (reg_value)
> +		dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> +
> +	/* print SYND registers value */
> +	mc_umc_addr =
> +		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
> +	reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> +	if (reg_value)
> +		dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> +
> +	/* print MISC0 registers value */
> +	mc_umc_addr =
> +		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
> +	reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> +	if (reg_value)
> +		dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> +}
> +
>   static void umc_v6_7_ecc_info_query_correctable_error_count(struct amdgpu_device *adev,
>   						   uint32_t umc_inst, uint32_t ch_inst,
>   						   unsigned long *error_count)
>   {
>   	uint64_t mc_umc_status;
>   	uint32_t eccinfo_table_idx;
> +	uint32_t umc_reg_offset;
>   	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>   
> +	umc_reg_offset = get_umc_v6_7_reg_offset(adev,
> +						umc_inst, ch_inst);
> +
>   	eccinfo_table_idx = umc_inst * adev->umc.channel_inst_num + ch_inst;
>   	/* check for SRAM correctable error
>   	  MCUMC_STATUS is a 64 bit register */
>   	mc_umc_status = ras->umc_ecc.ecc[eccinfo_table_idx].mca_umc_status;
>   	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
> -	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
> +	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1) {
>   		*error_count += 1;
> +
> +		umc_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
> +	}
>   }
>   
>   static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_device *adev,
> @@ -88,8 +129,6 @@ static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_dev
>   	uint64_t mc_umc_status;
>   	uint32_t eccinfo_table_idx;
>   	uint32_t umc_reg_offset;
> -	uint32_t mc_umc_addr;
> -	uint64_t reg_value;
>   	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
>   
>   	umc_reg_offset = get_umc_v6_7_reg_offset(adev,
> @@ -106,32 +145,7 @@ static void umc_v6_7_ecc_info_querry_uncorrectable_error_count(struct amdgpu_dev
>   	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1)) {
>   		*error_count += 1;
>   
> -		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1)
> -			dev_info(adev->dev, "Deferred error, no user action is needed.\n");
> -
> -		if (mc_umc_status)
> -			dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
> -
> -		/* print IPID registers value */
> -		mc_umc_addr =
> -			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
> -		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> -
> -		/* print SYND registers value */
> -		mc_umc_addr =
> -			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
> -		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> -
> -		/* print MISC0 registers value */
> -		mc_umc_addr =
> -			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
> -		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> +		umc_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
>   	}
>   }
>   
> @@ -277,8 +291,11 @@ static void umc_v6_7_query_correctable_error_count(struct amdgpu_device *adev,
>   	  MCUMC_STATUS is a 64 bit register */
>   	mc_umc_status = RREG64_PCIE((mc_umc_status_addr + umc_reg_offset) * 4);
>   	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
> -	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1)
> +	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1) {
>   		*error_count += 1;
> +
> +		umc_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
> +	}
>   }
>   
>   static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev,
> @@ -287,8 +304,6 @@ static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev
>   {
>   	uint64_t mc_umc_status;
>   	uint32_t mc_umc_status_addr;
> -	uint32_t mc_umc_addr;
> -	uint64_t reg_value;
>   
>   	mc_umc_status_addr =
>   		SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_STATUST0);
> @@ -303,32 +318,7 @@ static void umc_v6_7_querry_uncorrectable_error_count(struct amdgpu_device *adev
>   	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1)) {
>   		*error_count += 1;
>   
> -		if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1)
> -			dev_info(adev->dev, "Deferred error, no user action is needed.\n");
> -
> -		if (mc_umc_status)
> -			dev_info(adev->dev, "MCA STATUS 0x%llx, umc_reg_offset 0x%x\n", mc_umc_status, umc_reg_offset);
> -
> -		/* print IPID registers value */
> -		mc_umc_addr =
> -			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_IPIDT0);
> -		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA IPID 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> -
> -		/* print SYND registers value */
> -		mc_umc_addr =
> -			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_SYNDT0);
> -		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA SYND 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> -
> -		/* print MISC0 registers value */
> -		mc_umc_addr =
> -			SOC15_REG_OFFSET(UMC, 0, regMCA_UMC_UMC0_MCUMC_MISC0T0);
> -		reg_value = RREG64_PCIE((mc_umc_addr + umc_reg_offset) * 4);
> -		if (reg_value)
> -			dev_info(adev->dev, "MCA MISC0 0x%llx, umc_reg_offset 0x%x\n", reg_value, umc_reg_offset);
> +		umc_query_error_status_helper(adev, mc_umc_status, umc_reg_offset);
>   	}
>   }
>   
