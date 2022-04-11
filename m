Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C319C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Apr 2022 15:17:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A102510E1A2;
	Mon, 11 Apr 2022 15:17:23 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93A0E10E1A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Apr 2022 15:17:22 +0000 (UTC)
Received: from [192.168.0.7] (ip5f5ae91f.dynamic.kabel-deutschland.de
 [95.90.233.31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 978AE61EA1923;
 Mon, 11 Apr 2022 17:17:20 +0200 (CEST)
Message-ID: <0bb0f2c0-fc84-778a-5293-270cc1b54825@molgen.mpg.de>
Date: Mon, 11 Apr 2022 17:17:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2] drm/amd/pm: Disable fan control if not supported
Content-Language: en-US
To: Elena Sakhnovitch <elena.sakhnovitch@amd.com>
References: <20220411133216.3407198-1-elena.sakhnovitch@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220411133216.3407198-1-elena.sakhnovitch@amd.com>
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

Dear Elena,


Am 11.04.22 um 15:32 schrieb Elena Sakhnovitch:
> On Sienna Cichild, not all platforms use PMFW based fan control. On such
> ASICs fan control by PMFW will be disabled in PPTable. Disable hwmon
> knobs for fan control also as it is not possible to report or control
> fan speed on such platforms through driver.
> v2: FEATURE_FAN_CONTROL_MASK is replaced with FEATURE_FAN_CONTROL_BIT

Please add a blank line before the v2 line.

Also please give one specific example for a platform without PMFW based 
fan control.

> Signed-off-by: Elena Sakhnovitch  <elena.sakhnovitch@amd.com>
> ---
>   .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index ab3e9d8b831e..ddc388b061b6 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -371,6 +371,18 @@ static void sienna_cichlid_check_bxco_support(struct smu_context *smu)
>   	}
>   }
>   
> +static void sienna_cichlid_check_fan_support(struct smu_context *smu)
> +{
> +	struct smu_table_context *table_context = &smu->smu_table;
> +	PPTable_t *pptable = table_context->driver_pptable;
> +	/* No sort of fan control possible if PPTable has it disabled */
> +	smu->adev->pm.no_fan =
> +		!(pptable->FeaturesToRun[1] & (1U << FEATURE_FAN_CONTROL_BIT));
> +	if (smu->adev->pm.no_fan)
> +		dev_info_once(smu->adev->dev,
> +			      "PMFW based fan control disabled");

Maybe clarify:

… according to PPTable.

> +}
> +
>   static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
>   {
>   	struct smu_table_context *table_context = &smu->smu_table;
> @@ -381,6 +393,7 @@ static int sienna_cichlid_check_powerplay_table(struct smu_context *smu)
>   		smu->dc_controlled_by_gpio = true;
>   
>   	sienna_cichlid_check_bxco_support(smu);
> +	sienna_cichlid_check_fan_support(smu);
>   
>   	table_context->thermal_controller_type =
>   		powerplay_table->thermal_controller_type;
> @@ -410,7 +423,7 @@ static int sienna_cichlid_append_powerplay_table(struct smu_context *smu)
>   	GET_PPTABLE_MEMBER(I2cControllers, &table_member);
>   	memcpy(table_member, smc_dpm_table->I2cControllers,
>   			sizeof(*smc_dpm_table) - sizeof(smc_dpm_table->table_header));
> -	
> +

Unrelated, and should be a separate patch.

>   	return 0;
>   }
>   


Kind regards,

Paul
