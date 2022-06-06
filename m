Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD320C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 14:11:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7007C10F9DE;
	Mon,  6 Jun 2022 14:11:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B6A10F9DE
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 14:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRnSp4vCNswccBCXsTdnMtfJjAInOydAd1ooTTbABwjuAa9kOzRk3h3wCBx1KQlcJdesv3YJLh3EpBjgxvjxLr6budPRnRooq2n4wAZj++ASibhB7MANvBN6sTYkcLQD4bcsm4naR9Gixm43uxNdeO5/MPG678Fg0WBe8G/4z7Y1xfI7O0s5Kfja5ppoUNpx6iaiUHV+2zIBlhqaQ65+Fsz5UazqDLuHI2FKT1ZB6Y5f1kfoCQb8fX/P+FuDV6rKYly73YOhQyuxmxtLwM7IFSTzra34DgBQE8u0X8TIkyjW3krUZTZjVCTkJwGqaw1uwM+jgmEd77g5Kd8wP9njfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KlkfBHeovysl0NYg19bQzOBztyb+NtxI6iE6Gq/vp4=;
 b=IMrnmnp7QuQo+PzqTHQg/PjhO6DoUcepX3yJtG5h09rGlWe2nApzny8dXmvlhEm5GuWJhFdigWY0cDapTjhnrqixswgSX6w3z6td41J0d5INakXQvjTIAO5knN62ggHzTjRByiHgwYQlLOTZTARUA0rq/2WJHZkURMT5eH4y5WjKdCOlqWsKn6AU+uUQ639stfeOSbQ0tnKkx47y/dpR5GB5o8OSyY3pNc/SW4r/7PLmMM23zQRuHDx7CJvGhN77WhrAVjlAxiU8nPf8sP1aq6hDTzmZiL9V4Xlt5it1/Wpi5V/ltUVuhEoDayCVjIditZ64NiaMuxLqlug6LHOgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9KlkfBHeovysl0NYg19bQzOBztyb+NtxI6iE6Gq/vp4=;
 b=wusMbwNyoRO9HvWsTuv+TJtVMSwckDXAnuTN+iEKhqY85xJxOmwWsU0ZqGQtV6meKQepBIKO9IDuMf3pZ/EkXP3rrlLN0A2hD8mZ33nsGrWUJ1n6j7loZmNy5C0jkfba+kOxOHGSmA7LLrcer8xElx8s/D2QuD6Xb0vR91QuikU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY4PR1201MB2502.namprd12.prod.outlook.com (2603:10b6:903:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Mon, 6 Jun
 2022 14:11:04 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:11:03 +0000
Message-ID: <b6d6fb40-c4be-89ef-cc9e-28f7a21750e2@amd.com>
Date: Mon, 6 Jun 2022 10:10:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 4/6] drm/amd/display: Reduce frame size in the bouding box
 for DCN31/316
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
 <20220603185042.3408844-5-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220603185042.3408844-5-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::20) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a92a73b-b60b-463b-b6f2-08da47c6641c
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2502:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB250237098B24C32AE42ACE9F8CA29@CY4PR1201MB2502.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXe6fMqosd58L4kTcodCMKpA4xgx27OsiOT/j8TBfjcEPYWE+eP5rLX3U2GA71bjOJlRuuLnPFJdn2FCVAmdBPRAT0GZhR6cmgXASKujSRjjqv0f4x8tMCGxdm6MgUegfTyn5og8P5KEtvjVP+V3q2qYr/xY9nuM9iK1ot6Q9zFz1JLr8XngO5nRBNKXNjo8YqLnIZ9ZhoUZZspdOZjRh4632ZwiPTwfnMjYHgM6vukcU4aEUsLF5EoAzcsO4Zx7106YQ80bhROlaHx/K6JV2ou8EBP3GwutcNgvbcPzfl+hHcd3x8ziQ8JUvr9NiAvNIBpwtq33/Dwurj5bEKjF+8BT5yHQ16nVlNLjUCjGRtJh2Iootp0w4XmZvsoFQymdFuUTdKnFg2mRHfttkPOa3xZovsAVcvv9o3Pgtwh8xT8nXVSz24/hGgmzQosN9L5sfoBdLY+kvustWTYZIADdAtiTlpsY/G36d/dYavDnvXvAt6oHKJzf2lioKcegU5+Hq0/p2oYRVFTT2ah8x7zT6eRUfIUhjovXyuFhPSlm3BBLUCu0rpjcUfaHGrPF0CWesPRGxoHKhYJx51PDOzuihem9BOXwX0CyPx0JqYRzjcBl0gy3R6Uhy0MES+sDCy6AyBwzZJZZN5RaCZ11HqTypYD1WD6gWrzz6/JRwgoTtSqCesRP75MLOeNoSpmcrxglT1y5rlTHBeIZ0wAW7StPdVSko+Iny7X7nTxV8dNhW4c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(86362001)(31696002)(36756003)(8936002)(38100700002)(6486002)(6666004)(31686004)(508600001)(8676002)(44832011)(4326008)(5660300002)(66946007)(66476007)(66556008)(54906003)(316002)(26005)(2906002)(186003)(6512007)(2616005)(53546011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnRER2VkYkdhMS9vRXh6NDhxaFdNcnAvaEJ0emtjMlRIa1IzY084d2Q3ajRO?=
 =?utf-8?B?MHQvWUFRQWVObXFWWmNzQWx6QlFxQy90QVkyTlA5Tyt6cTRLNlhCK3FiTTg4?=
 =?utf-8?B?MWc3STZtV3M2OFlPQmMrNjJSMzVRNkd3TnFYcGJ6QUJWM2JVckVhQUFtOStn?=
 =?utf-8?B?R0V1UlltbzhtWnI1TDlHSXdjYWFnWE5JZUFqaDlQZ2VwZk1rRmhtalhHSGdG?=
 =?utf-8?B?UlVKeU5YUlZzSm94UEYrS1pSc1UrckZwdW9sUU5jeSszQ09OOTRXQS9NV0du?=
 =?utf-8?B?eWRzc3VUNWFiN0ZCTkVJakM5czBjYWR3V21KdGxYdVFsSVRhQnUzNndpMWR4?=
 =?utf-8?B?Rk5yQTEwaXVPWnpXZGlxQW5Td1VDNG93WHFPRjF5Z2FQS3pGSzNoeTVzNmxt?=
 =?utf-8?B?azFNMHI3aEIzNk1EK3lmTWdlRWhmS0tlQjNSLzFsSnoybi9XaDIxWW9SRXEv?=
 =?utf-8?B?bDVabExrcldXRWUxVy9XUUNrQnBRVjZJVjk3cldTRStVTHpXTTFxWGZnL3p3?=
 =?utf-8?B?VXRQRlh0bmlOeTdhTGVndUlHeHBYcU5LSHhnaTJoTTJHMU5sUTVlYmFwNXk4?=
 =?utf-8?B?NExVN0JYbGRTWnZ5R3diMmlNOWZsTDgvRTlwZ0ZnL08vOWRPWitIQVZsQU14?=
 =?utf-8?B?MEkwdllOZFRZbG45L0xYL0hNbHdvaVM5YVgrMkRVWXBnd3FRM2xLbTVNVU9s?=
 =?utf-8?B?akFHRlpiSUtNc0Nwc1lrTnR2T3doQnVMWEo3SmFIN2x3TEFxUUJPSkhOS2xX?=
 =?utf-8?B?M3RXQTlTMDR3bVZsZk02NDhpSnZqSVJBQi95eS9kenlqSVd4S0JLK0l1OUUz?=
 =?utf-8?B?MlF0NENjYXVqOHhUSXlQV3Q5MUxzakFXTnEzdm9uSktOVVZxNnB0TGNuZGo1?=
 =?utf-8?B?OFpqVHgxMDRBWlMrdFM2NXVGL3pUNXY2Uk5Hb1ZITEplc0x3K0RJQXNpYmha?=
 =?utf-8?B?a1k2M1RWYW93eE1oVGdiVnNaSTJGeVV2dUVkcm9iTm85MWtYVjJNSVVRaUFB?=
 =?utf-8?B?ckdjbE96cElkRmIwellIQ29uMG00SzBQN1ZrTWdnU2RwdlpMMENSUnhEanUr?=
 =?utf-8?B?MXBicWRxZ1R4SisvWk5yeXJIWGtNVnE5bTVPTzFuS1dWaldyN2QzUjBJNllR?=
 =?utf-8?B?ZlVZTEU4WjZSUU1sL0RGSEd2SmVyY1VhOUVqV292K3BxNUdsY1dLME0weSs5?=
 =?utf-8?B?TlVGN3AzVnpNdWoxdTVzRGVSMEdDZ2NONmwrWHh2dUd3NXR3OGZpSjQrcWdp?=
 =?utf-8?B?RXFDdG5yb2ZSTm1PR1VIZ2s4VWFoSEI3L2Jic2hKZzVKbUMxcHVma0plWUhE?=
 =?utf-8?B?d2Nqc1BkYzh6Yk1WYzJVaHNjT2Q1Sm5MUEZYUlJrUFpUR0psbFVOaW1PZVl4?=
 =?utf-8?B?VkFXTkhhWU00ZzVzRkV2dzVjQ0R1c2pjODVvZ0Z3TkpxdkpPN1NTdWFRY1JJ?=
 =?utf-8?B?TG50bUJiMnFTTy9OTXdYOHNKanpMZjZVUDNNYmlKNFlQRkNFT0dWVFdZbks0?=
 =?utf-8?B?NDNKdTM4V24zWldXdW9QaHhSa095YUhVRlhIYm1wMldDdWFaYlg3NkJmMzNF?=
 =?utf-8?B?WXd2N2FnempLa2FnNzBiREgvNEtTVmoyYzN3dHZSeGdmOVZ6SXlzQU9TczZk?=
 =?utf-8?B?SW5IdDdwWDloRWNmUytrOVJJaU1GOHV6UVhpYjh4NTRlTm9mZ2cvUnVhR0pn?=
 =?utf-8?B?UVpJaXJOUEtEUzlYUkNOSXpoT1RPeWh2TXEreE9KdmgrUC9pVzZJdzBXdTFE?=
 =?utf-8?B?em1yRVEyeUZMZFFDNml3bVZFMzdGWDNhVTlHRHRRb3Q4VVAzMU8vMjVKZWtR?=
 =?utf-8?B?elFVMHUwS1I3bEtFUi9YdkZsRkdjVWgrUDl6NmVJcndzV0dGYWlSM0hNT1RO?=
 =?utf-8?B?NkxiZURsOVRCYXM5V0hsNmV4RW5DaWJGVXdpQmNmaW1ROFJkOVhXYmtKYVZz?=
 =?utf-8?B?aHNXaFJzUGdoVytBNVZsV29sRlZUWjRkMnAxcXIxenY5TzRZa2dFWFJFdkk4?=
 =?utf-8?B?VzZTN3puV2NzNDNDU3dyN2FZeFd1Y1h1M1RJZE9zOXN4N3ZsNHN6dG9yNVFl?=
 =?utf-8?B?a2pmdXpXanYvUkY2RzBFTDhXckZWL29JVXZXUXBiSW5PMGtJZStWS1ZsZXpX?=
 =?utf-8?B?b3BFeGhvWnJiNEM1YkdLT2s1TXRaRWJVWCt3aHNMTVMxRjN4byttcytqaTZY?=
 =?utf-8?B?M2cya2gyaytyNXpidHJjTVUxLzBhUC9CcWxjaXRrZTNJVTZvL0xsVXhvR1gv?=
 =?utf-8?B?SXdESGNlQWp4VmNXMGNzQU54UURkcmV5TUNCZ0FkM0NNMEtFMGRLeTZiMmhK?=
 =?utf-8?B?MmZsVmk2VFJsL0dYd3NyQ0lTRWhmUW8zY2g5aGZoSjBsLzdBbGw5dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a92a73b-b60b-463b-b6f2-08da47c6641c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:11:03.7546 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEpqS42QvUgzTnCxDFktuMi3lGimgnAkhm2lPhzsyknIzWtnStCCgTaTqfTFjgju4wUsJDFpkPg6Av+VRtINIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2502
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-03 14:50, Rodrigo Siqueira wrote:
> GCC throw warnings for the function dcn31_update_bw_bounding_box and
> dcn316_update_bw_bounding_box due to its frame size that looks like
> this:
> 
>  error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> For fixing this issue I dropped an intermadiate variable.
> 
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 58 +++++++++----------
>  1 file changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> index 54db2eca9e6b..ee898bc93fd5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> @@ -574,7 +574,6 @@ void dcn31_calculate_wm_and_dlg_fp(
>  void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
>  {
>  	struct clk_limit_table *clk_table = &bw_params->clk_table;
> -	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
>  	unsigned int i, closest_clk_lvl;
>  	int j;
>  
> @@ -607,29 +606,27 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
>  				}
>  			}
>  
> -			clock_limits[i].state = i;
> +			dcn3_1_soc.clock_limits[i].state = i;
>  
>  			/* Clocks dependent on voltage level. */
> -			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> -			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> -			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> -			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
> +			dcn3_1_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> +			dcn3_1_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> +			dcn3_1_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> +			dcn3_1_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
>  
>  			/* Clocks independent of voltage level. */
> -			clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
> +			dcn3_1_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
>  				dcn3_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
>  
> -			clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
> +			dcn3_1_soc.clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
>  				dcn3_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
>  
> -			clock_limits[i].dram_bw_per_chan_gbps = dcn3_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> -			clock_limits[i].dscclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> -			clock_limits[i].dtbclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> -			clock_limits[i].phyclk_d18_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> -			clock_limits[i].phyclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
> +			dcn3_1_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> +			dcn3_1_soc.clock_limits[i].dscclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> +			dcn3_1_soc.clock_limits[i].dtbclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> +			dcn3_1_soc.clock_limits[i].phyclk_d18_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> +			dcn3_1_soc.clock_limits[i].phyclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
>  		}
> -		for (i = 0; i < clk_table->num_entries; i++)
> -			dcn3_1_soc.clock_limits[i] = clock_limits[i];
>  		if (clk_table->num_entries) {
>  			dcn3_1_soc.num_states = clk_table->num_entries;
>  		}
> @@ -701,7 +698,6 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
>  void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
>  {
>  	struct clk_limit_table *clk_table = &bw_params->clk_table;
> -	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
>  	unsigned int i, closest_clk_lvl;
>  	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
>  	int j;
> @@ -739,34 +735,32 @@ void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
>  				closest_clk_lvl = dcn3_16_soc.num_states - 1;
>  			}
>  
> -			clock_limits[i].state = i;
> +			dcn3_16_soc.clock_limits[i].state = i;
>  
>  			/* Clocks dependent on voltage level. */
> -			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> +			dcn3_16_soc.clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
>  			if (clk_table->num_entries == 1 &&
> -				clock_limits[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
> +				dcn3_16_soc.clock_limits[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
>  				/*SMU fix not released yet*/
> -				clock_limits[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
> +				dcn3_16_soc.clock_limits[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
>  			}
> -			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> -			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> -			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
> +			dcn3_16_soc.clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> +			dcn3_16_soc.clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
> +			dcn3_16_soc.clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
>  
>  			/* Clocks independent of voltage level. */
> -			clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
> +			dcn3_16_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
>  				dcn3_16_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
>  
> -			clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
> +			dcn3_16_soc.clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
>  				dcn3_16_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
>  
> -			clock_limits[i].dram_bw_per_chan_gbps = dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> -			clock_limits[i].dscclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> -			clock_limits[i].dtbclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> -			clock_limits[i].phyclk_d18_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> -			clock_limits[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
> +			dcn3_16_soc.clock_limits[i].dram_bw_per_chan_gbps = dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> +			dcn3_16_soc.clock_limits[i].dscclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> +			dcn3_16_soc.clock_limits[i].dtbclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> +			dcn3_16_soc.clock_limits[i].phyclk_d18_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> +			dcn3_16_soc.clock_limits[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
>  		}
> -		for (i = 0; i < clk_table->num_entries; i++)
> -			dcn3_16_soc.clock_limits[i] = clock_limits[i];
>  		if (clk_table->num_entries) {
>  			dcn3_16_soc.num_states = clk_table->num_entries;
>  		}

