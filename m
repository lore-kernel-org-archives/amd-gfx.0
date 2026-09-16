Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A88AAC88E77
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 00:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A4710E10C;
	Wed, 16 Sep 2026 00:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="usAMAsqB";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013030.outbound.protection.outlook.com
 [40.107.201.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B4C010E10C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 00:12:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1FPAqN5t0oS6HW5oigyN+wydPsFA6hvbDF5rFKAv+NIxgZw/66d5Um0pJ10lFAPGAcrdDDsBrUyFFpwxUNk7ooaWtyAJHs+yaOhpRaNMuDIdgt3LASXfH0L6hlPR0cPRl0x1r7RNDNPkfb6KknO+xnHOeMdI5FW9gzyWfEdAs/EeQeklB+W8yZxI4sL+7D8bKuPvE4455DDSRGcJ3zv1hBa0UoyopAPByFSibSqJJTwDi4LdQdOA67aI+orztjzc6zFq/JMT5RBiQ+q22MJL89M+EHIrgblR2gQm5sNgtuB3a7AWKMq311O3bWOzdHeIoYUPwM7Oo4ONu0SUnXYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmrfWPEH+zf0bzA0rn/nWWcfWqHpojvHizSVfbhj21s=;
 b=htFfLcPXTvFRwl/u7Zp6wGorVHW9S0Z6Un5syFG+mN4HDWOzWHMknSimlcOmwVul2Uo98R9gXh0ZJ8My1oaQD28vULcxyUnl9va3lv7MG8iHqB1B2mnesI9NZctfdQrDW5O/HjY67FBGRljZ4JvZcRXOZIWhq8cHZFLqfL30l/k4fO/YHj3u0Bk084y5ciXBKZYwE2i3F/UxuQr5Svc1Mw1hHzE6ux1cKARjf4DDh+QN4Hx5MIXASJtu6qBV0ZWlRmhfY+zegWwrvtnHy9/iHNnEoy5utKXN2lDYfp4/IMk9hplrhQ7Og5eHpr9gq9Sb/h4M/i/R4if6ZYY3tsTaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmrfWPEH+zf0bzA0rn/nWWcfWqHpojvHizSVfbhj21s=;
 b=usAMAsqBPYLZtY2xlhnEOo5ifWE7de4n9qd2WQUQ6EftzoNzitlZk4QhI0JTo+O3rMZXSpET8V5zWBhgFWvsliDnsbr5c3IxH4wYAu4/BaZuEGhYCdnOeBHT56rstjDKOU+mWarSYfQ9ThFlky90hUM6Qw0/HQsKRYqLKXEAFME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DM6PR12MB4171.namprd12.prod.outlook.com (2603:10b6:5:21f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 00:12:24 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 00:12:24 +0000
Message-ID: <8428aa6b-c7b4-4460-ae7b-872af40b998c@amd.com>
Date: Tue, 15 Sep 2026 18:12:22 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix NULL dereference in dcn50/dcn60
 init_hw
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Dan Carpenter <error27@gmail.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Roman Li <roman.li@amd.com>, Tom Chung <chiahsuan.chung@amd.com>
References: <20260915083739.461232-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260915083739.461232-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DM6PR12MB4171:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf195a5-1bc7-4579-466e-08df13872ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|56012099006|5023799004|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8iWSxmV3YWIn8oZ+iNR95AOtAo6fJPJljmxEr3HpE4+UXdppFB6DTNaagOPVEnIhw+XMQzC+mZiNW0X0LGOjzS0j2SODwJGvKNu3YfZG5BTh6SPzWzxss0c1y2h4LGDBE7pA1Jh3F4Z26eEh3vuZhVQO8GZMGwskkyLjJW4cYUnFauEBrAfxdf6IV4+Q1XTkVwVgEhzLOaMyO/Yfrrwv7apk+b2Is7pE4Ot3lS/IwEx3Yor0VqyoWPUtEwzJYaXwJ1EXefpebtu60x2tqooDy7zwf/fTaEchv/GESshxrIdBsu679c7B6jOpXzVjLk4ZYaZdhgsyvnGMbtwZ6BUZCtP2mw5CP3Pr8/rcm8TLcLodazPpcrZntOZrZGpr4WsCopwwXutFjE0kV7f/u9BnRYzi7xNDPZtXZs8IFdoTTPf9Sz471ZBgB85S2R+85QO/Pty0iOg7SO38W/M0L9Z9p76n+CmUXuc1pWPALh425kYmvckavkJcgU7T2wB4YwX4wvAbz3fZ9nkjduDFYS6MW9nVG0bXdOTtXniHSenG2pdcKuRnDK0k/z6S8nva3kP1XBMQmGTplOae8PRY0aS+xeOcRS6CeKv1WlRSZu0s/NBEVIgB8WasvYMTc67PyEpl/Pe8iXor6VKMasm35vAH5DAyws/JrsiQDJBB/uZAN/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tkp5QVpEMzloRWw2aU50aEhxVEpQN0RuSEI4NTdVejN1ZCtoNzdwZXhQUWQx?=
 =?utf-8?B?OC90c3VLK1cvR3UwZHprOVYwRzlrbTFLVWtEV2w1eGNPQ1ZsZnVhbnp0d2V3?=
 =?utf-8?B?NXdnUTZNRlkxNTd3TGlTWlpwM091Ukptd014L2dPalJ3T0NlL2F0TDVYR3BX?=
 =?utf-8?B?bDV1MkRBVFVqQTQ0WGJ1N1RFN0xBL3BuQlJHVEZXQ21JTmxFanlCMW16SUh3?=
 =?utf-8?B?YVM3SStwMzREVFJWU2xneXdzaHBUcStoN0tFT3ZvVlo5enNtQklVTDFPSTU2?=
 =?utf-8?B?T1FiNXZzc0R1WHl1ck8vaDNWNlYwVCtmbnJXL1Rmbm4rd1VXdXhQMCs0VnJp?=
 =?utf-8?B?V3krS1UzYjNENklYcGxSdzVrWUtTcWdBdHJqbTZkcVAyTmJlL1o1dGk5STNj?=
 =?utf-8?B?cVRjWkNZb2Z4dlpGR1U0bk1HbU90VWJMQVd1bGhCd3E0L0pnOS9FUkF5MG1y?=
 =?utf-8?B?S1lIL1JqaWlKTFBqRUJBcEtFcm9CcVVwcUhPSGs5RUI4aUFncFI4MHUwZUh4?=
 =?utf-8?B?ZlM1YlhCN1ZNNjNNbi9sNzVTWGFFS21NRXN1SU44eHJUeE9UWXJ2YVV6UjNu?=
 =?utf-8?B?QUg2YVNsREEwVCtQejhySU84aFUwTHhqOStFNWZoN09aakRzZ2pXeW00Nkor?=
 =?utf-8?B?aTMwRi9YVy9HN055QVZXNi9RZHRKOG16TENGOHp4M2tWUGpxeHBteXhlVFlm?=
 =?utf-8?B?cGdzbTE2ZWg1NEJJZHZQd0J5SXlyaHFaTXZPTDhUbFFESlNNaUZIb3JLaVl1?=
 =?utf-8?B?RjRTekRrOUhhMDlPelBqQXYxQlBPNU5yWlRvM1BQVGMyMzZsS2RWZG1SNWlj?=
 =?utf-8?B?aVY4djRERVg3M2pNTEdIUzhkcnI1b29iSHBEUHZzUDV1Z0sxbXJ1dENJS0ZJ?=
 =?utf-8?B?V0NYeUowNEFsUEl3N3NPUVd5ZUpRRDVrS0FSSkpNMDBuc2FGUDg5Nm43SmhG?=
 =?utf-8?B?SlFHaGcxMHlrQUpCRFdwYndnRURraWhBYW9YWW5GM3NQdU4xNjJNaUhmbmFR?=
 =?utf-8?B?R0Nta2srSzJ1UC9ac0VxN1dPa1lHT0RWWWI2ZU5EdWxjbHNXMGN4aFNXbEth?=
 =?utf-8?B?akNwdzdOSFFtK2xmNE1WRHVNMEh1eVhadWJtVERPaDZ3TEtlSXhJUHVyMFZ5?=
 =?utf-8?B?WlJ1TDRPUzNCUi9WdEVmRmZvajhMOUx2Lzg3TXdLWEVySFBpYkFDeVlrei9j?=
 =?utf-8?B?dzQwcmhQZkp5RFo5M3BRNXV4UmxDdWdLKzNQL3Z2ZStyTFZzYUl2MlEwU2Qz?=
 =?utf-8?B?Ny84V3F5eUZMTGZiRXYrUWRRRVJlNXcyL0JtdHM4ODBHeGhtclVlWmJvK0g2?=
 =?utf-8?B?U2wzaEVRODFXWHFIcWhVQm5lWEk1aE56R2l1RkxXSWNzeWh4MnlJVjRjb21h?=
 =?utf-8?B?ZlpQWTM1dk15MUdGeDdvM0pzM2M5c0RJdFlCbDJGMG9GV1dEWERHRU9PVGR0?=
 =?utf-8?B?Q0dlMGNid0ozdVQ0ZXk2d0xBNWRwSmwxd29STmNISVhxSFBEVVhCTlRQejFT?=
 =?utf-8?B?bTBoditQeGN3cFk4Zno4M2xFdm1OWkdyL0lJQldGcUc5eE1PRGhtTnVLdVg4?=
 =?utf-8?B?Y1BuZW5weTZvdnhZQllDeUM4bGNpaThXY0FTODVQVGxhdGpFWXJOdlZSTjNv?=
 =?utf-8?B?cTZBNzhUa2RXYllLMUZIWHMvdVN0UVJvMkU1dTU5QmdSTzZEc3lqRUFkNU9x?=
 =?utf-8?B?ekI3Q2Rmc0crYWkxUm1JY1FhZWtDaGFFY2Y3OGR2OGtQRHVjYlIxQXpwWlBk?=
 =?utf-8?B?ZzRLeXBlYUxKTEkxR2dablJ3MVNzTkhyY0VwZ20zOFhhVHJzTExCK1F4SXhM?=
 =?utf-8?B?dnVzMnNiTTdkMmZoOXlYa2syMm1aSnhEN1RabzQydCtiV3dWeUU3Qmp1anBt?=
 =?utf-8?B?VmFtWFM1RkhXMnA2bXpRV25JdFVJRGg2WlQ3Rlc1aHhGbDdwR0MvdXVCOG5p?=
 =?utf-8?B?TmRyNUZ6U3d6QUlwV2tzV1FGMWwvWmptdkJZYnl3KzRhQkIwMThZNWhYVm5R?=
 =?utf-8?B?YmpUOUxUbkxaaytlVnB5VGxDWElRSGJtRi9nOHd2SzM5d1VkN0hNbkErcGdF?=
 =?utf-8?B?MGZGUkFWd0o2SmpENytDdHE2SFBFT2pLL3MzYWgzZjJhNUs3V1dFY3RHbVgx?=
 =?utf-8?B?cWRKUjZUZVhnWm5aTitvWkgzaVpjalVqTmUwTk5WbWU4T3luZy9MWENPbXJn?=
 =?utf-8?B?UlZyUHNPbVlsZmoxbHpiZ3F4RUNlb2RPYXlSRWlPWGZzdEI1VHNpR1dPajBJ?=
 =?utf-8?B?Z1g4b0hiQTUrU08yaXcrQ1psTDJjWFQ1Z1dVb0F4cXRYbWVFWDF6NHhkMGN0?=
 =?utf-8?Q?KfHRll9FltWL2/YjJX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf195a5-1bc7-4579-466e-08df13872ee2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 00:12:24.0724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZMsWLTyiKgfBjhfGkqhShiDMUZ30Bs9OXSdi/0qD+TVS1T3XMfg/8vI6O/tb+4vMeqQkup4dVtiC0p0ORu1qUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4171
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

On 9/15/26 02:37, Srinivasan Shanmugam wrote:
> dc->clk_mgr is checked for NULL earlier in dcn50_init_hw() and
> dcn60_init_hw(), but dcn50_initialize_min_clocks() and
> dcn401_initialize_min_clocks() are called without any guard,
> causing Smatch to report potential NULL dereferences.
> 
> Guard both call sites with the same pattern used throughout
> both functions:
> 
>    if (dc->clk_mgr && dc->clk_mgr->funcs)
> 
> Also fix dcn50_initialize_min_clocks() which calls
> get_dispclk_from_dentist without checking the function pointer,
> unlike the dcn401 equivalent which guards that call.
> 
> Fix kernel-doc in dcn60_hwseq.c by adding missing parameter descriptions
> for @probe in dcn60_update_probe_status() and @type in
> is_probe_measurement_type_for_hubbub().
> 
> Fixes: 04d9a88decbc ("drm/amd/display: Add new sources for DCN6")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Ivan Lipski <ivan.lipski@amd.com>
> Cc: Dan Wheeler <daniel.wheeler@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c | 7 +++++--
>   drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c | 5 ++++-
>   2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
> index 8b63e75e5ee2..a02f03311da9 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
> @@ -67,7 +67,9 @@ static void dcn50_initialize_min_clocks(struct dc *dc)
>   		 * audio corruption. Read current DISPCLK from DENTIST and request the same
>   		 * freq to ensure that the timing is valid and unchanged.
>   		 */
> -		clocks->dispclk_khz = dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
> +			if (dc->clk_mgr->funcs->get_dispclk_from_dentist)
> +				clocks->dispclk_khz =
> +					dc->clk_mgr->funcs->get_dispclk_from_dentist(dc->clk_mgr);
>   	}
>   	clocks->ref_dtbclk_khz = dc->clk_mgr->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
>   	clocks->fclk_p_state_change_support = true;
> @@ -644,7 +646,8 @@ void dcn50_init_hw(struct dc *dc)
>   			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
>   					!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
>   
> -		dcn50_initialize_min_clocks(dc);
> +		if (dc->clk_mgr && dc->clk_mgr->funcs)
> +			dcn50_initialize_min_clocks(dc);
>   
>   		/* On HW init, allow idle optimizations after pipes have been turned off.
>   		 *
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
> index a13d36ad8a9c..ef1c10bc9bfa 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
> @@ -769,7 +769,8 @@ void dcn60_init_hw(struct dc *dc)
>   			dc->res_pool->hubbub->funcs->allow_self_refresh_control(dc->res_pool->hubbub,
>   				!dc->res_pool->hubbub->ctx->dc->debug.disable_stutter);
>   
> -		dcn401_initialize_min_clocks(dc);
> +		if (dc->clk_mgr && dc->clk_mgr->funcs)
> +			dcn401_initialize_min_clocks(dc);
>   
>   		/* On HW init, allow idle optimizations after pipes have been turned off.
>   		 *
> @@ -1150,6 +1151,7 @@ static void dcn60_build_hubbub_perfmon_sequence(
>   /**
>    * dcn60_update_probe_status - Set the valid flag on a latched probe result.
>    * @status: result sink whose u was written by the GET BLS step during execute
> + * @probe: current probe state used to determine measurement type and validity
>    */
>   static void dcn60_update_probe_status(
>   		struct dc_probe_status *status,
> @@ -1187,6 +1189,7 @@ static void dcn60_update_probe_status(
>   /**
>    * is_probe_measurement_type_for_hubbub - Returns true if the probe type is
>    * served by the hubbub perfmon block on DCN60.
> + * @type: the probe measurement type to classify
>    */
>   static bool is_probe_measurement_type_for_hubbub(enum dc_probe_type type)
>   {

