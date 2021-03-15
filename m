Return-Path: <SRS0=AQd/=IN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E923EC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:15:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A39A664F18
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Mar 2021 19:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A39A664F18
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C7F66E0E7;
	Mon, 15 Mar 2021 19:15:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34A56E0E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Mar 2021 19:15:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AfCCSvm7UJmflSrfNZpRRIPt865xxReyrSpMj67mJ+j1AuCwe3KmUAPSA/lWxAsONT6U1yTs6NK4tmjegYSL7WNCpvjp/EeI02KWMQ8mmdvSOTIuL4/5KvGa2Mw4klqpfVRFBhYU9Hc3i1ORJuHyV2KO3UpgSoRjQdlBBX/G7IN/TGTd6DKv5u64nQaP70iHOWIXq8gHarZ4ZnnWjrsd5Omsa6BWKEDwjVnfDdq1W8ISQ+Rp566vIV//cnpXvjesRATXoBRXSQDSOBCz4pBJJr1psk8eyYmFoGvkjD/lIboiVoBR/bFMFbgvQvxlGlaEP9Ql/j5etH4SxZJQ6+EnXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5vM2ESkwJdHpo+Z7rZ0J2WbPqs8IPF2zTGoNw78xns=;
 b=KrzgSBSie9kZBIfK3mGpp86UZKDqGCkju0iHNu8psstGQjyc86MxPPH84Tb2yvggWkazKP7C9iPQK1y9oRYG50AvvoZ7Jsw7UkBaXa1ygI3Hrv6BZme/glo/xadt9uc6B1JsZ+tC7IFnzxsq9uAQtFVL0YAKR7ar/jhwlJVhAlxtTJlCJLs0AR0P4QJ5ar5CkhIt22lu5RmWP6R7x9poFFh1vH5iBNwJKTXC5+N+26us1bkTt30CFHatUiKdpOEaoUhHyLzEj7xPo4APMeWDOXctYjc6gtigu8/j1yflp/aJkBVPU453fjf+XzWzvGsv8fEaKIBhmeocjG56h04v6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5vM2ESkwJdHpo+Z7rZ0J2WbPqs8IPF2zTGoNw78xns=;
 b=DuaGLFfcCEJ/leXTWtNY+UUOr1JgFaxUci98wsF/HpJBmiheiIW3dDRdzHCirrveWqCCCOsAhhceQlLp3MQxGTI7d7ToanJEvmKym0+oEW0j/wb43txOp8Bg//0x5DYxcqg6R5nL+HhOwkvsuupsH/a+hAzOV40qTIz7uUTjfr8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB2468.namprd12.prod.outlook.com (2603:10b6:903:d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 19:15:28 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 19:15:28 +0000
Subject: Re: [PATCH] drm/amdgpu/display: drop unused DCN3.01 functions
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210315191241.1526008-1-alexander.deucher@amd.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <256fb4df-5850-ea7f-b0b6-bb2ad360c434@amd.com>
Date: Mon, 15 Mar 2021 20:15:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
In-Reply-To: <20210315191241.1526008-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [217.86.103.190]
X-ClientProxiedBy: AM0PR06CA0099.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::40) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.103.190) by
 AM0PR06CA0099.eurprd06.prod.outlook.com (2603:10a6:208:fa::40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32 via Frontend Transport; Mon, 15 Mar 2021 19:15:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e5222821-9354-4ed0-29de-08d8e7e6b18e
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2468:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB246821427F01C43134D17EEF8B6C9@CY4PR1201MB2468.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cpuEjnGHS6vHEUuP/hlvQzl4qC93YmQcPKTn6utOokq5T/GMEdxe1ujafLAI7N0hXy0rYUuXGG2vXR+X3V9G5hBOxQVI5iNv/kgKk887EJwoQXTymE9+Ohav7vbLfAYc73C8nawDvf8lexV/1AiDNJKKcIGUs9EIi60xmEp/9mKGMp8hF6PabK2aRfiX/zXqSScksYJv37pYjolLKMVGP0bzfLOzlPFiAI8gNhEBKChtKZMxefL1Gcw8Aq6OG4HGeH9xSDMPfph5LY74rrZQrzKg0AOOQc9FRXT273IKcLU6hVTziX7hjXvvXMKyFluaB8Dg3918mnjsAwJhrp9FjTh6vLHbd4LgyXg8rgPcbBKgVW3kbeC6EU7RuTZCChVIEr4XDT+G4YpQSKx/gd4/UN+KyI7rOWwE1Yh4r6UdbgC/O+fWHMVJnGxyfTDegiOcq3ngFiufbNckWhMx/ysLKZfNcMAfP+wuY0/hfJ0zLoeLB5sYXXgTTPNAtk0oFDl4WPVQUN8r9EGdNyM4+KsJZZRVHhw/YhvcQWinjWTFBhUMeVQ7vSKgT8FIrImUA8P+RrD3yQv1iXjkqxX7H+h2Wq25CByRONR4WsDy+q+1ZOvVIgai/3nktzTJjXx6q4gnqcN5MZsZyg82UXQbq8J3Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(5660300002)(31696002)(53546011)(54906003)(316002)(6486002)(4326008)(16576012)(66476007)(478600001)(66556008)(31686004)(26005)(36756003)(2616005)(6666004)(8936002)(52116002)(2906002)(186003)(16526019)(66946007)(8676002)(956004)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d1J1TXd6dXhYWElCN3NMeEZ1V2hHTzBjK1RvdHJWYitLR3BjNEpFYzlwOFp6?=
 =?utf-8?B?bG9pWU80MERrSFlaNk9KakkxY3VXRDBYeittRCt0UHNZcktmSkpmb3JrTVJO?=
 =?utf-8?B?anZaT1NoTnBBT0lleFJRUEorZ1BxZURyU1l3aWs3WUgyWWJRMFVTUHlNVkxa?=
 =?utf-8?B?aDhxUExKeWp6VWtnTHdNWUp6QWE3TUFhYjV2MTFIS3ZVbiswV1hDdDI2ajNt?=
 =?utf-8?B?cTFUb1lMWWE4dW1RMDlxbGNrZVFjWVFzMXV4TkJYQkM1cXpBeE1rbkk2Nmkr?=
 =?utf-8?B?WjFoSlFtT3QzL3QxNnpFN3ZRWno4SC95RTZBbHVTUkh4UzVuWC8veEhxQTlv?=
 =?utf-8?B?dnJ6a1ZZalBHZFJFczlYOEZxOVBRcFFScTQweWF1MnA5emNJSmdOUHAwNDJS?=
 =?utf-8?B?Zk1McTJFblZjOGZZNGdwUTBzM0w2L3dyU1JmY2NKN29rb1NqZ3d1STlObU9G?=
 =?utf-8?B?VHdTT0Q1QklsZmpQZVppbUhlVExuS0RRR0tZeEx4MEcvMEZyQjUxQVZzbnJP?=
 =?utf-8?B?cysyeE9nZXdSUDdtcVlONzhDcHcwdXV3TXB6Ry9KWk1wTGp2OHlhdDIxTlNN?=
 =?utf-8?B?U091aFg5MkpPK2VsZkUzZHhZYkVleHNodENST09OTkM3ZFE0d0JHZFd3U0dH?=
 =?utf-8?B?dVhQZFhVV0w1RWtPMHZXbXB2L2xlRGVkU21yWk1kWSt4WE5SSmZrOHFiMjUv?=
 =?utf-8?B?NktqdjBhamZVdkl0Mis5NzV0cksraGVBV0ZLUEd3VEk3Y25iK3RvSFJiWS9O?=
 =?utf-8?B?Z0gyRy9jb1U0anRBN1d2QmdyWkhQczlqVVhRclJVb3FyM29hNmJqTDcycDRk?=
 =?utf-8?B?eU5sSEV6ZnN2ZWRNQlNBYkNMMVdHZEtFUE9ZL2Fka09SSEI0QTdtTDhlWENY?=
 =?utf-8?B?RTZRaUpEYlFLVmQ4eXp6dTlIR1lCdWgrSjA4Y1ZSRnNnc3NUdFVOZndSdytE?=
 =?utf-8?B?UFRvSTVMYzZxRWY2YlJ4MVZTVndrTnBudTA1TWFRM0llejYxUFBDZnBrZ2dF?=
 =?utf-8?B?d2VJV2N5OTNRdnU3Z3RTak5MaTNnQ1EyS1p6Y3NIMTlhbUpaTytOWE1TY01T?=
 =?utf-8?B?NnFMMkNlV3E3MlFSN3k2OWQ2MnFpaVcyRXJBWGZmQVZYQ1VzQTYrdjgxUnFD?=
 =?utf-8?B?V3NFUXFXSTJjSitTZXd4dkpwSEZ1cWt2QUdBeDAzNVJGbjkrSW5PNUpKNFA0?=
 =?utf-8?B?UEpvNkFYamFuUmt4UFoyVUJ0MVlTYXRhSWc3anpTRHhCTVRaT3RWa21rcyt0?=
 =?utf-8?B?bjVTTnhZZVM5c2VGbEtGc2ptaWJ0Q244V3ZQNlcvZWltSFZkQjhsVGNOS2J1?=
 =?utf-8?B?Q2RoU0dqQ0lpT1M4d0JKcjNGeFk0dGlRUjVEVXN2cFNvajVoQkhKQ2VrNFox?=
 =?utf-8?B?VzZRc3pKMmE3dVdxMlhQVTlWWVhtMDZuQWs0bmJGTFdrN0dIT0FqeTY3UkxH?=
 =?utf-8?B?am9IOWhuMkRER2IrWGl1MGhOSXRLSDZaUlozQTZqQ3dMWWltbTFVaWszZEts?=
 =?utf-8?B?Z0dUZ0VXNjN4WDVHYWd2aEJVZ3ZtbFdxMVNtcTE2SGlHUUFOUDVqbXFYNmtt?=
 =?utf-8?B?TWVEUGVwd0ZqdTc5VE5vRFRIekRIZ3R6bFA2bzMybDhIVm1XS1RSWmhCVXRT?=
 =?utf-8?B?T1RyazgxckdHUmplekVIUm9lNXRvQnFvUGMraHF2T2pSS1h0L2oyYy81VmJq?=
 =?utf-8?B?bldxdS9MWDFpTmkyanJmbjFkU1FaaXNtQ1NVYjJrTnJxV3JXamF0MFdLVW9n?=
 =?utf-8?Q?eRcmul9PiBGzqmtc6/EFmYWsn5/epLQEfZpLArq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5222821-9354-4ed0-29de-08d8e7e6b18e
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2021 19:15:28.2232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tm19F49XHg87gFizeXIXIqYaWRIDDIyfVR6BO+KhiD12PmeA7MaMLMtkiTZTDwBx/t1Ch00pfFe+yqYXqMj4hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2468
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
Cc: Charles Sun <charles.sun@amd.com>, Nikola Cornij <nikola.cornij@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Nirmoy Das <nirmoy.das@amd.com>

On 3/15/21 8:12 PM, Alex Deucher wrote:
> No longer used.  Drop to avoid warnings.
>
> Fixes: e0e33d4006aa ("[why]  the dcn301_calculate_wm_and_dl() calculation exposed a issue  - switch to dcn30 version for now.  still need to follow up with dcn301 watermark updates version.")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Charles Sun <charles.sun@amd.com>
> Cc: Nikola Cornij <nikola.cornij@amd.com>
> ---
>   .../amd/display/dc/dcn301/dcn301_resource.c   | 94 -------------------
>   1 file changed, 94 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> index 22ffd7c64bde..c109d0cdab42 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
> @@ -1621,100 +1621,6 @@ static void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
>   	dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_DCN30);
>   }
>   
> -static void calculate_wm_set_for_vlevel(
> -		int vlevel,
> -		struct wm_range_table_entry *table_entry,
> -		struct dcn_watermarks *wm_set,
> -		struct display_mode_lib *dml,
> -		display_e2e_pipe_params_st *pipes,
> -		int pipe_cnt)
> -{
> -	double dram_clock_change_latency_cached = dml->soc.dram_clock_change_latency_us;
> -
> -	ASSERT(vlevel < dml->soc.num_states);
> -	/* only pipe 0 is read for voltage and dcf/soc clocks */
> -	pipes[0].clks_cfg.voltage = vlevel;
> -	pipes[0].clks_cfg.dcfclk_mhz = dml->soc.clock_limits[vlevel].dcfclk_mhz;
> -	pipes[0].clks_cfg.socclk_mhz = dml->soc.clock_limits[vlevel].socclk_mhz;
> -
> -	dml->soc.dram_clock_change_latency_us = table_entry->pstate_latency_us;
> -	dml->soc.sr_exit_time_us = table_entry->sr_exit_time_us;
> -	dml->soc.sr_enter_plus_exit_time_us = table_entry->sr_enter_plus_exit_time_us;
> -
> -	wm_set->urgent_ns = get_wm_urgent(dml, pipes, pipe_cnt) * 1000;
> -	wm_set->cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(dml, pipes, pipe_cnt) * 1000;
> -	wm_set->cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(dml, pipes, pipe_cnt) * 1000;
> -	wm_set->cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
> -	wm_set->pte_meta_urgent_ns = get_wm_memory_trip(dml, pipes, pipe_cnt) * 1000;
> -	wm_set->frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(dml, pipes, pipe_cnt) * 1000;
> -	wm_set->frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(dml, pipes, pipe_cnt) * 1000;
> -	wm_set->urgent_latency_ns = get_urgent_latency(dml, pipes, pipe_cnt) * 1000;
> -	dml->soc.dram_clock_change_latency_us = dram_clock_change_latency_cached;
> -
> -}
> -
> -static void dcn301_calculate_wm_and_dlg(
> -		struct dc *dc, struct dc_state *context,
> -		display_e2e_pipe_params_st *pipes,
> -		int pipe_cnt,
> -		int vlevel_req)
> -{
> -	int i, pipe_idx;
> -	int vlevel, vlevel_max;
> -	struct wm_range_table_entry *table_entry;
> -	struct clk_bw_params *bw_params = dc->clk_mgr->bw_params;
> -
> -	ASSERT(bw_params);
> -
> -	vlevel_max = bw_params->clk_table.num_entries - 1;
> -
> -	/* WM Set D */
> -	table_entry = &bw_params->wm_table.entries[WM_D];
> -	if (table_entry->wm_type == WM_TYPE_RETRAINING)
> -		vlevel = 0;
> -	else
> -		vlevel = vlevel_max;
> -	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.d,
> -						&context->bw_ctx.dml, pipes, pipe_cnt);
> -	/* WM Set C */
> -	table_entry = &bw_params->wm_table.entries[WM_C];
> -	vlevel = min(max(vlevel_req, 2), vlevel_max);
> -	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.c,
> -						&context->bw_ctx.dml, pipes, pipe_cnt);
> -	/* WM Set B */
> -	table_entry = &bw_params->wm_table.entries[WM_B];
> -	vlevel = min(max(vlevel_req, 1), vlevel_max);
> -	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.b,
> -						&context->bw_ctx.dml, pipes, pipe_cnt);
> -
> -	/* WM Set A */
> -	table_entry = &bw_params->wm_table.entries[WM_A];
> -	vlevel = min(vlevel_req, vlevel_max);
> -	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.a,
> -						&context->bw_ctx.dml, pipes, pipe_cnt);
> -
> -	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
> -		if (!context->res_ctx.pipe_ctx[i].stream)
> -			continue;
> -
> -		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
> -		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
> -
> -		if (dc->config.forced_clocks) {
> -			pipes[pipe_idx].clks_cfg.dispclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
> -			pipes[pipe_idx].clks_cfg.dppclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
> -		}
> -		if (dc->debug.min_disp_clk_khz > pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
> -			pipes[pipe_idx].clks_cfg.dispclk_mhz = dc->debug.min_disp_clk_khz / 1000.0;
> -		if (dc->debug.min_dpp_clk_khz > pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
> -			pipes[pipe_idx].clks_cfg.dppclk_mhz = dc->debug.min_dpp_clk_khz / 1000.0;
> -
> -		pipe_idx++;
> -	}
> -
> -	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
> -}
> -
>   static struct resource_funcs dcn301_res_pool_funcs = {
>   	.destroy = dcn301_destroy_resource_pool,
>   	.link_enc_create = dcn301_link_encoder_create,
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
