Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 090D7C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 19 Mar 2022 07:47:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4498F10EF5C;
	Sat, 19 Mar 2022 07:47:54 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F4910EF5C
 for <amd-gfx@lists.freedesktop.org>; Sat, 19 Mar 2022 07:47:53 +0000 (UTC)
Received: from [192.168.0.7] (ip5f5ae905.dynamic.kabel-deutschland.de
 [95.90.233.5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id CBB1E61EA1923;
 Sat, 19 Mar 2022 08:47:51 +0100 (CET)
Message-ID: <7d25a05c-379b-8b97-1e91-78f0c2076bd2@molgen.mpg.de>
Date: Sat, 19 Mar 2022 08:47:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 05/13] drm/amd/display: Add fSMC_MSG_SetDtbClk support
Content-Language: en-US
To: Alex Hung <alex.hung@amd.com>, Oliver Logush <oliver.logush@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
 <20220318214800.3565679-6-alex.hung@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220318214800.3565679-6-alex.hung@amd.com>
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, amd-gfx@lists.freedesktop.org,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Alex, dear Oliver,


Am 18.03.22 um 22:47 schrieb Alex Hung:
> From: Oliver Logush <oliver.logush@amd.com>
> 
> [why]
> Needed to support dcn315

Please elaborate. What is wrong with `dcn315_smu_get_smu_fclk()`?

> Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
> Acked-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Oliver Logush <oliver.logush@amd.com>
> ---
>   .../display/dc/clk_mgr/dcn315/dcn315_smu.c    | 19 +++++++++++++++----
>   .../display/dc/clk_mgr/dcn315/dcn315_smu.h    |  4 +++-
>   2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
> index 880ffea2afc6..2600313fea57 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.c
> @@ -80,8 +80,8 @@ static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D
>   #define VBIOSSMC_MSG_SetDppclkFreq                0x06 ///< Set DPP clock frequency in MHZ
>   #define VBIOSSMC_MSG_SetHardMinDcfclkByFreq       0x07 ///< Set DCF clock frequency hard min in MHZ
>   #define VBIOSSMC_MSG_SetMinDeepSleepDcfclk        0x08 ///< Set DCF clock minimum frequency in deep sleep in MHZ
> -#define VBIOSSMC_MSG_SetPhyclkVoltageByFreq       0x09 ///< Set display phy clock frequency in MHZ in case VMIN does not support phy frequency
> -#define VBIOSSMC_MSG_GetFclkFrequency             0x0A ///< Get FCLK frequency, return frequemcy in MHZ
> +#define VBIOSSMC_MSG_GetDtbclkFreq                0x09 ///< Get display dtb clock frequency in MHZ in case VMIN does not support phy frequency
> +#define VBIOSSMC_MSG_SetDtbClk                    0x0A ///< Set dtb clock frequency, return frequemcy in MHZ
>   #define VBIOSSMC_MSG_SetDisplayCount              0x0B ///< Inform PMFW of number of display connected
>   #define VBIOSSMC_MSG_EnableTmdp48MHzRefclkPwrDown 0x0C ///< To ask PMFW turn off TMDP 48MHz refclk during display off to save power
>   #define VBIOSSMC_MSG_UpdatePmeRestore             0x0D ///< To ask PMFW to write into Azalia for PME wake up event
> @@ -324,15 +324,26 @@ int dcn315_smu_get_dpref_clk(struct clk_mgr_internal *clk_mgr)
>   	return (dprefclk_get_mhz * 1000);
>   }
>   
> -int dcn315_smu_get_smu_fclk(struct clk_mgr_internal *clk_mgr)
> +int dcn315_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr)
>   {
>   	int fclk_get_mhz = -1;
>   
>   	if (clk_mgr->smu_present) {
>   		fclk_get_mhz = dcn315_smu_send_msg_with_param(
>   			clk_mgr,
> -			VBIOSSMC_MSG_GetFclkFrequency,
> +			VBIOSSMC_MSG_GetDtbclkFreq,
>   			0);
>   	}
>   	return (fclk_get_mhz * 1000);
>   }
> +
> +void dcn315_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable)
> +{
> +	if (!clk_mgr->smu_present)
> +		return;
> +
> +	dcn315_smu_send_msg_with_param(
> +			clk_mgr,
> +			VBIOSSMC_MSG_SetDtbClk,
> +			enable);
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.h
> index 66fa42f8dd18..5aa3275ac7d8 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.h
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_smu.h
> @@ -37,6 +37,7 @@
>   #define NUM_SOC_VOLTAGE_LEVELS  4
>   #define NUM_DF_PSTATE_LEVELS    4
>   
> +

Unrelated.

>   typedef struct {
>     uint16_t MinClock; // This is either DCFCLK or SOCCLK (in MHz)
>     uint16_t MaxClock; // This is either DCFCLK or SOCCLK (in MHz)
> @@ -124,5 +125,6 @@ void dcn315_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
>   void dcn315_smu_request_voltage_via_phyclk(struct clk_mgr_internal *clk_mgr, int requested_phyclk_khz);
>   void dcn315_smu_enable_pme_wa(struct clk_mgr_internal *clk_mgr);
>   int dcn315_smu_get_dpref_clk(struct clk_mgr_internal *clk_mgr);
> -int dcn315_smu_get_smu_fclk(struct clk_mgr_internal *clk_mgr);
> +int dcn315_smu_get_dtbclk(struct clk_mgr_internal *clk_mgr);
> +void dcn315_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable);
>   #endif /* DAL_DC_315_SMU_H_ */


Kind regards,

Paul
