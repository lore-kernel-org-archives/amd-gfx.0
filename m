Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E197F8D75B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 15:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA17210E139;
	Thu, 16 Apr 2026 15:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sVYvtbKB";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE6E10E139
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 15:46:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjX5txEo7gfJT/8W4bEqrqq+HAy9ViA0IbOPKl8nKxX5gcNGqQDS9QeS6MUSKRSDsCnMzkPsYMvJrf0WkbHa8OR2LV1CUBUFxfPd0ygY68IAK7a1tkbK9Y8rI7VhnZqnB2T9O5QYZEvnCnraUztu3qwAOhF9uMpgLzi4MdbFb5Bog7tiyxOphDP/l5VJxM8ai9R75i347sLna/N1siDEU00YDK0BnC375CCguahCnx2mAkRx96sHMnS1mLkQO1g3lCSAEcmRVRkI1uxeOEoGvM7pS1HsUBYcZUhThH2+ImG1FywurZ+cj/ExSGfT6WSWZzR+vHrqO9P0+Y2t1KSgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdUi0E5m99j9CXzKkq2RkeAXblDabEJ3jljY8DLraHE=;
 b=oceFnYMTVrZwxYI93ULsMIr5er+S4G7cEnubX3O0ZFuHMe3kGp0wabgY5I6Wgvo5DlYDl398+OGJdGurhWNMn09rJ+tfNTHqpgxt32v9s3X7Hg2svdbzhpExfXBim0oPcowrQPD7zCMyzAsnXSitMs9FohD7lWXwdL9WyQiLVbA7N4216ri/E4W48Yb33LudbsX/5c7NpLUjDbCcxICRQGhevGQ8IM2EZKBeU40R7PL6LWkk0b6rgSxcSoy61iVE2iHYvkBbi9e1Y+Vh2HJcG9NwkclBOWWpWpOYsOyHJsCcLTCOo+dQukQzSSd1yQ2CJu69pJtpYT+RLg8VtNZntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdUi0E5m99j9CXzKkq2RkeAXblDabEJ3jljY8DLraHE=;
 b=sVYvtbKBvY2gnqdDHkcrnHj+UK6btfWl78P9XEdhZnW+VEKHvgKl4AyWSbjg7JD8+9MnudB14I4GTymsgXxoHvXsb6sY5nh7ouYG/pFe5g93KGG5R4iNdYJyKtdYeEsDTh3jctoXUZDSRaZH0Asgz01ftQXiUyEb07hpM8ofK40=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Thu, 16 Apr
 2026 15:46:47 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9818.023; Thu, 16 Apr 2026
 15:46:47 +0000
Message-ID: <b6e52939-5593-4874-a8d0-010594d6a637@amd.com>
Date: Thu, 16 Apr 2026 09:46:45 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Restore analog connector support
To: Roman.Li@amd.com, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Harry.Wentland@amd.com, Sunpeng.Li@amd.com,
 Aurabindo.Pillai@amd.com, timur.kristof@gmail.com
References: <20260415224150.1807020-1-Roman.Li@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260415224150.1807020-1-Roman.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0157.namprd04.prod.outlook.com
 (2603:10b6:303:85::12) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a08dceb-8895-4561-13a7-08de9bcf5df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 1cF87qZqkPXAAabKd/Tdp/294XvWVQS0EO63ND3OoffKpDR2UA6XV6oDzHt3p481glzsnIVp4S6Llqf2q9JcxeceMnFom+vnH0pejrUWK6ZLbZ3czD3F+TP3HybxySPES8gfRHm8LrjNtpWZ4civ6rIvzOiVmtjN8yFWmaJbxaOtRcB4evfkbh1xMHXbNM3nD660zDFKqLcRdDOi+iu9KOhoBYXY51hDhIv2TuETNXs+xlYVsVcl/RWPHLxFlXDvE96MysLTxWrtTfwZ66cXGG20zgisNJieUobBIdOcT2YmGPwV61oNnVK5iegP0Pmzi/0ENTjDj98uZa4J+Ydi8fDBM1CbfiMw3r/EAkXFO9yMAcuyTPSvbV+EjATpxiFYiyHpoz5HpWOkrGLifq0PEtLdaQaV6jjNwmJLs6P47Rn/hgx2XqYNRHUQ1IGlhMWJm67ymZfmO55lKr7A4Pw0x71xTMi6RknlvyunxnQbWqOS8Pq9hThDCxz6P0ULVmQH6WK8/xwwjbHId4wY4BhnzcsOyskDrWn0oq9v2Renjrkxj/QRBgdeE19SnaPrOFk638gqOUo/h/m1vIOp0gZMituS4n+Y8JCl9HtUcmcmUdwB7L+CUtfX6RCeQktqSEveR1DFK2mTYsQ/5YXdQXVmLh/+rcJueS9sRDulib8U6G5ShEyLzQc8oqM0qTQiOrZSwJZrmRhhgBndCWHwx+VcJ4k921ih9JMXYnuw9purIno=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDh4RFVHZUF2T0loZjNuOG1VV01TVGl1bnFUMXFFeElqQktpSERBaTdXMHhz?=
 =?utf-8?B?YmhlRnNDeDNha21sZXh4c2tZOEd6L091SjhnNHRLTlQzcnNFSVphMjJEQytP?=
 =?utf-8?B?WHhLaGRFaXd4NnFKcU9zZEh2dEJPMzdWT1RLWkFLd1NNRnJ2d2RHMVFpMFBE?=
 =?utf-8?B?bnBiMHEvQWxYS3MwWlJJY1RJekNKY1lrY3lxRnZ2ZkxtUlhOSWtLTU12WUdu?=
 =?utf-8?B?VXQwVlFJQWl2RDJkejI4QVdOWVB0V1gwRWhTak5IKzdpd2NCNGR1cnlkV3E4?=
 =?utf-8?B?a1lMbzFIdmJqeGxiQm00NTBuaXloL243QTlWQm9FMW9UTGV5RzRkeDhtY1VO?=
 =?utf-8?B?VUVud0VHUE9BTFpSTGhaak4rU1AxcVkzQW02OU5wNzZXNVdoK01hSUVJY05H?=
 =?utf-8?B?UTArdUVwWjZaNGVnd1hFRmxpSGZ3VXJ5ZEEwZ21yMGw1alBYZDBTRjd4Nms2?=
 =?utf-8?B?bG9Za0EwaHo0R1NHQkVjSjZaSGNUc3VxNlBxUXQvc1lMU0pySk4rZWVISkJ6?=
 =?utf-8?B?UlhnRnE4WWdZdFozK2hhVG50WTVGTlBSWUFWSVk5VmluQTcxVUVrbHY1OVR1?=
 =?utf-8?B?alpCWGxsd1M3K3RQTTFxQTkxRENPRDNvTXlIUWFZNnAwOHN5U3RqYW5hb053?=
 =?utf-8?B?bVVLblBnb1N0aGJKa1grYUQxenZITVZtOWZ1WWVaOElQMGoxcWhCNnBXYkZU?=
 =?utf-8?B?R3krZXZXbEJPeGNRN1lFR0w0VUxOWGtuRzlVbU0xbklFQ3lYb2FwNm1oaWpP?=
 =?utf-8?B?SWFGWkxNZVlWWjhlN2Z0c0F4VXF0cFp5cDVTRG55S1RPVjJVVDVGajJEV0Qr?=
 =?utf-8?B?OWM4cDFVa04xSXcyR0MxVlg0TFN5WFd0ajd4YnV3TlFub0k3aFBDT3hveVRp?=
 =?utf-8?B?bUZ0elFjUG5raXVJLzhjN1RLVUJaT01vaHY5WDE5RDFuU0NUeW1RT3gydSth?=
 =?utf-8?B?TU5JRE9IN0REVVZzd0YxMjhLN0kraHNJV2dRWXYxbmNYWXAzZk44M1M2eldO?=
 =?utf-8?B?aHROMjc5aVBmMEVTemNNaS9TcFRjOXVqZ1BGRHFsUkNVWG1tN0U4NnUxMFY4?=
 =?utf-8?B?aStkdkZYdkVQRnVFTjEwOUcxSy9VVVF5cDdpYUQ0YTZZSFdQbzRXZ3VYR1Jt?=
 =?utf-8?B?T3MxdzN2ZVI5S0F0aUpnUHNkVGthTFhBZ0VJL2dhZmY4bVM0NlM2d1I0NDhq?=
 =?utf-8?B?NUF0RWxoWFRRVXFGcmpYTWR3Mm8ybEh0Q0hKN1VLZWVlYWlKK1FXaUZKbnht?=
 =?utf-8?B?dklkdm1ZN0Y1NzVQWEo2NkQ0b2FnUlhIMXdDR2NIWEtaWTRzV0UvV0FrN3hz?=
 =?utf-8?B?QXpHdkViajZXZkJYRFRzNm0vQUtkSE5rOWhMdVU3YkI4VncvUW1QbWl0ZENp?=
 =?utf-8?B?TXBmbmVTTTNuOXhZYStEOFBqRjhXaXg0SFhPRnFwUVREUVlxMzAzSU4wRVl4?=
 =?utf-8?B?U1RBM01hRTIySEp0eG1HVXpUeWYwdnV5VlRjcDRFZHA2QkFlS0xuVTNxLzR2?=
 =?utf-8?B?NVc4VW9qRmdoYk9XVWl0ZmlmaWhUVUxWaFFpWEFFZWRCQUxsNGhCYTB5UDBR?=
 =?utf-8?B?TGJBQzBRa0I4dHl0ekRIb3Z6VFE4Ym51R1J6WmVoOTJUZGhSK29rRjByTzdE?=
 =?utf-8?B?US9tajlmUmEybC82dkRDNTVmcC9zYmk1cmdncFpWQWtCUzcvQ0tvR0d3cjdS?=
 =?utf-8?B?QzVwUUFUNWNpSFpRcUQ5bmREWjZHRjNoQnZIL0U1RlNLbDhscmw3MlZIcXpn?=
 =?utf-8?B?czBHL09sRnllTWVmMnFKVXNUMlp6K0Z5ZVZSM0FQeEVLay81NEFxVklnUDdo?=
 =?utf-8?B?QjBUdldKK09NUXpMNjAzakNFdkpJQzZOUVlzcDB1VmcxeW9NQnpRc2lWYVgz?=
 =?utf-8?B?N2ZDRVF0WkNJeStjSnI2bkl2b2xuR3lUUDF5SHl4UzRYZ3BDTGIxaE1IWG8z?=
 =?utf-8?B?c2JQV3VmeDBtVGlWMW4rREpuU056ejVQSHZNbUNKb1RLaFhmbkZBQWU5NlBU?=
 =?utf-8?B?WXNlVm9TeGZWbGJCLzNDL04zVHRHWHZORC9hLzdJS2k1NkhIYk1hNFVWQTR4?=
 =?utf-8?B?N3dxWGsrdE9aWWl1cmdrTldrUnFNY2JJWWRSSEdJM3ZOVEVOWGgzVW9GNXhW?=
 =?utf-8?B?am1oNC9lWDFvREhydWtxVnErcjNoSmpTY0s0dDkxUWdoM1BFVlBmNDhvbzc2?=
 =?utf-8?B?L25yUi84dS9FWmdrVUVsSkVhaTA3NTEwVXZEQ3pmNXlpbWRndFhWaDJ0YWxk?=
 =?utf-8?B?NGFnUEMweEdBcHZqNGs5eDNqNkhIMTZGN0V3cXdCTG5mckhZUzJCdU5xaUFU?=
 =?utf-8?B?S3ZaYlVsYkpMY2V3WXgyMXM0ampxbTF1MU5VWFlZaCtBam5KR3E5UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a08dceb-8895-4561-13a7-08de9bcf5df6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 15:46:47.2395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KG5s1zZg6LDstU2BtwCBrJOwlnsAD8vqVGtacdgqmtYpP+7IbStFxHcYjxo05EeO41Mckf2ZKpEVsQTDw5di2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 4/15/26 16:41, Roman.Li@amd.com wrote:
> From: Roman Li <Roman.Li@amd.com>
> 
> [Why]
> The analog connector support was accidentally removed,
> causing a crash when connecting an analog monitor.
> 
> [How]
> This patch restores the functions and pointers required for proper analog
> and DP bridge encoder support on legacy GPUs.
> 
> Fixes: 66715fc0ecfd ("drm/amd/display: Sync dcn42 with DC 3.2.373")
> Cc: Timur Kristóf <timur.kristof@gmail.com>
> Signed-off-by: Roman Li <Roman.Li@amd.com>
> ---
>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 53 +++++++++++++++++++
>   1 file changed, 53 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 5273ca09fe12..e76abc877f4a 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -677,6 +677,48 @@ dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx, bool enable)
>   	bios->funcs->encoder_control(bios, &encoder_control);
>   }
>   
> +static void
> +dce110_external_encoder_control(enum bp_external_encoder_control_action action,
> +				struct dc_link *link,
> +				struct dc_crtc_timing *timing)
> +{
> +	struct dc *dc = link->ctx->dc;
> +	struct dc_bios *bios = link->ctx->dc_bios;
> +	const struct dc_link_settings *link_settings = &link->cur_link_settings;
> +	enum bp_result bp_result = BP_RESULT_OK;
> +	struct bp_external_encoder_control ext_cntl = {
> +		.action = action,
> +		.connector_obj_id = link->link_enc->connector,
> +		.encoder_id = link->ext_enc_id,
> +		.lanes_number = link_settings->lane_count,
> +		.link_rate = link_settings->link_rate,
> +
> +		/* Use signal type of the real link encoder, ie. DP */
> +		.signal = link->connector_signal,
> +
> +		/* We don't know the timing yet when executing the SETUP action,
> +		 * so use a reasonably high default value. It seems that ENABLE
> +		 * can change the actual pixel clock but doesn't work with higher
> +		 * pixel clocks than what SETUP was called with.
> +		 */
> +		.pixel_clock = timing ? timing->pix_clk_100hz / 10 : 300000,
> +		.color_depth = timing ? timing->display_color_depth : COLOR_DEPTH_888,
> +	};
> +	DC_LOGGER_INIT(dc->ctx);
> +
> +	bp_result = bios->funcs->external_encoder_control(bios, &ext_cntl);
> +
> +	if (bp_result != BP_RESULT_OK)
> +		DC_LOG_ERROR("Failed to execute external encoder action: 0x%x\n", action);
> +}
> +
> +static void
> +dce110_prepare_ddc(struct dc_link *link)
> +{
> +	if (link->ext_enc_id.id)
> +		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DDC_SETUP, link, NULL);
> +}
> +
>   static bool
>   dce110_dac_load_detect(struct dc_link *link)
>   {
> @@ -3376,6 +3418,15 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
>   	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
>   }
>   
> +static void dce110_enable_analog_link_output(
> +		struct dc_link *link,
> +		uint32_t pix_clk_100hz)
> +{
> +	link->link_enc->funcs->enable_analog_output(
> +			link->link_enc,
> +			pix_clk_100hz);
> +}
> +
>   void dce110_enable_dp_link_output(
>   		struct dc_link *link,
>   		const struct link_resource *link_res,
> @@ -3513,8 +3564,10 @@ static const struct hw_sequencer_funcs dce110_funcs = {
>   	.enable_lvds_link_output = dce110_enable_lvds_link_output,
>   	.enable_tmds_link_output = dce110_enable_tmds_link_output,
>   	.enable_dp_link_output = dce110_enable_dp_link_output,
> +	.enable_analog_link_output = dce110_enable_analog_link_output,
>   	.disable_link_output = dce110_disable_link_output,
>   	.dac_load_detect = dce110_dac_load_detect,
> +	.prepare_ddc = dce110_prepare_ddc,
>   };
>   
>   static const struct hwseq_private_funcs dce110_private_funcs = {

