Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4AAFF8873
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 20:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BFBE10E041;
	Wed, 29 Apr 2026 20:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="J9RdT9yj";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E19410E041
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 20:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rl2GUUdg8Gp5lhcQe90Ox1F3yM7BLweWQAT6P28XRRU=; b=J9RdT9yjDTt7IwP70duWaJ4uaO
 9Wfpe2PNjW9Gst2kmAkSOnL97mGxO1fO2mQgLtZf1aH7UUbTnzPzpF/2vBRnECfuCNP1Rk0mo0dYA
 IQiZQN7TccQiaMXWe7huDrPxqjV43vmy6g23ta10B57/y+l+5VhfXPxx0f78DVSIUWeC4JepoGU0M
 FqHeFW2FG9ayn0XVhpgoKMG1jxG9GgdnCrfec4hkPGmbE4BY7TULiLdscK+1OSG2Ikj5ZRzQSgqNO
 3EopV/WiC1mz9EEKlAwLOEkNjAYEdLmwy27ROJGqMg1sJnlgFdhNqrCnHuvitPu7jzfjIz0J7+rt9
 CSqpBCfQ==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIBcu-0047LZ-FI; Wed, 29 Apr 2026 22:35:19 +0200
Message-ID: <2c83c16b-7e5c-4d1d-93f1-23109ee52a59@igalia.com>
Date: Wed, 29 Apr 2026 17:35:16 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] drm/amd/display: Delete disp_clk_voltage from
 integrated info
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-8-timur.kristof@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260423191519.73127-8-timur.kristof@gmail.com>
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
> Only DCE 11.0 relies on this information and even that
> didn't use this field, because it queries the information
> from the pplib. It also filled the field incorrectly on
> that version.
>
> On newer GPUs, the VIOS integrated info no longer contains
> display clock voltage dependencies, so we don't need it.
>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../gpu/drm/amd/display/dc/bios/bios_parser.c | 36 -------------------
>   .../drm/amd/display/dc/bios/bios_parser2.c    |  9 -----
>   .../display/include/grph_object_ctrl_defs.h   |  9 -----
>   3 files changed, 54 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> index 25c94962e1415..298a70852c1a8 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -2348,15 +2348,6 @@ static enum bp_result get_integrated_info_v8(
>   	info->dentist_vco_freq = le32_to_cpu(info_v8->ulDentistVCOFreq) * 10;
>   	info->boot_up_uma_clock = le32_to_cpu(info_v8->ulBootUpUMAClock) * 10;
>   
> -	for (i = 0; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
> -		/* Convert [10KHz] into [KHz] */
> -		info->disp_clk_voltage[i].max_supported_clk =
> -			le32_to_cpu(info_v8->sDISPCLK_Voltage[i].
> -				    ulMaximumSupportedCLK) * 10;
> -		info->disp_clk_voltage[i].voltage_index =
> -			le32_to_cpu(info_v8->sDISPCLK_Voltage[i].ulVoltageIndex);
> -	}
> -
>   	info->boot_up_req_display_vector =
>   		le32_to_cpu(info_v8->ulBootUpReqDisplayVector);
>   	info->gpu_cap_info =
> @@ -2499,14 +2490,6 @@ static enum bp_result get_integrated_info_v9(
>   	info->dentist_vco_freq = le32_to_cpu(info_v9->ulDentistVCOFreq) * 10;
>   	info->boot_up_uma_clock = le32_to_cpu(info_v9->ulBootUpUMAClock) * 10;
>   
> -	for (i = 0; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
> -		/* Convert [10KHz] into [KHz] */
> -		info->disp_clk_voltage[i].max_supported_clk =
> -			le32_to_cpu(info_v9->sDISPCLK_Voltage[i].ulMaximumSupportedCLK) * 10;
> -		info->disp_clk_voltage[i].voltage_index =
> -			le32_to_cpu(info_v9->sDISPCLK_Voltage[i].ulVoltageIndex);
> -	}
> -
>   	info->boot_up_req_display_vector =
>   		le32_to_cpu(info_v9->ulBootUpReqDisplayVector);
>   	info->gpu_cap_info = le32_to_cpu(info_v9->ulGPUCapInfo);
> @@ -2648,25 +2631,6 @@ static enum bp_result construct_integrated_info(
>   		}
>   	}
>   
> -	/* Sort voltage table from low to high*/
> -	if (result == BP_RESULT_OK) {
> -		int32_t i;
> -		int32_t j;
> -
> -		for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
> -			for (j = i; j > 0; --j) {
> -				if (
> -						info->disp_clk_voltage[j].max_supported_clk <
> -						info->disp_clk_voltage[j-1].max_supported_clk) {
> -					/* swap j and j - 1*/
> -					swap(info->disp_clk_voltage[j - 1],
> -					     info->disp_clk_voltage[j]);
> -				}
> -			}
> -		}
> -
> -	}
> -
>   	return result;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> index b4dd8219b8f09..0e7250f1d3f73 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> @@ -3023,7 +3023,6 @@ static enum bp_result construct_integrated_info(
>   	struct atom_data_revision revision;
>   
>   	int32_t i;
> -	int32_t j;
>   
>   	if (!info)
>   		return result;
> @@ -3125,14 +3124,6 @@ static enum bp_result construct_integrated_info(
>   			DC_LOG_BIOS("driver forced fixdpvoltageswing = %d\n", info->ext_disp_conn_info.fixdpvoltageswing);
>   		}
>   	}
> -	/* Sort voltage table from low to high*/
> -	for (i = 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
> -		for (j = i; j > 0; --j) {
> -			if (info->disp_clk_voltage[j].max_supported_clk <
> -			    info->disp_clk_voltage[j-1].max_supported_clk)
> -				swap(info->disp_clk_voltage[j-1], info->disp_clk_voltage[j]);
> -		}
> -	}

I see in `get_integrated_info_v11()` a big portion of very old unused 
code guarded by a `#if 0` that uses `NUMBER_OF_DISP_CLK_VOLTAGE` but 
probably doesn't make sense anymore.
How about removing it too?

>   
>   	return result;
>   }
> diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
> index 38a77fa9b4afd..130d377f4f1d2 100644
> --- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
> +++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
> @@ -269,7 +269,6 @@ struct transmitter_configuration {
>   #define NUMBER_OF_UCHAR_FOR_GUID 16
>   #define MAX_NUMBER_OF_EXT_DISPLAY_PATH 7
>   #define NUMBER_OF_CSR_M3_ARB 10
> -#define NUMBER_OF_DISP_CLK_VOLTAGE 4
>   #define NUMBER_OF_AVAILABLE_SCLK 5
>   
>   struct i2c_reg_info {
> @@ -298,14 +297,6 @@ struct edp_info {
>   
>   /* V6 */
>   struct integrated_info {
> -	struct clock_voltage_caps {
> -		/* The Voltage Index indicated by FUSE, same voltage index
> -		shared with SCLK DPM fuse table */
> -		uint32_t voltage_index;
> -		/* Maximum clock supported with specified voltage index */
> -		uint32_t max_supported_clk; /* in KHz */
> -	} disp_clk_voltage[NUMBER_OF_DISP_CLK_VOLTAGE];
> -
>   	struct display_connection_info {
>   		struct external_display_path {
>   			/* A bit vector to show what devices are supported */

