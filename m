Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCBCC64EC4
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 17:56:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F0310E9CE;
	Fri, 10 Mar 2023 17:56:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EAA410E303
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 17:56:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mG1LDaj+sM1mSsQ5pb4DmToY1+lrpqdTgKL1Iz2qm7g8FZIaIP7eMM8KCPp1BNz/fKB6FuD3lSefxkUattxK5SJCjaoQsfnGlAFzejgRKaaj0OGlF+qFDRmVIBKF2im8IDdHoNcf7VWY+pNLFdEQjJDgsnBjq0KLNTOS6kXcV39mTCODwfKtVa3NcFy5/47RBmSTiKDcfdDH5Aw2rBi0h0mFZ5nx9a/tZ5RlVdja/Oud7meb3dqer3AMRTSC62YOHyECYtDSuhK9QWymo3fxLFe2WksosjaHU9u/bJCKj3ms55D3sdn1C0Vupr/CCc6ayYdo1Dw1YGH88Jx4gzNHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M95ZWuNMUe28tyV9JFNZuR0hfvKNnNOXNbqQYd8iV1Y=;
 b=j17RGV7KQrUAOkZE40TnFPpqYN7dc7zEeCGjcsRfcHZo4CvP6WKYVzatU00BoZO59eHLu4ddimSEbVlQEp16FLV+bxaQFQQTgsAArcmpyBSJFwRGPrOXiIZYBSObNE/3QUdYPiYQZAEny12OkWoBSNs0VkUdikJzCh43XVy0zL7fZB4lFNrKOaCnHh07YdX4oYkZfGgH3TF9ULemdVXBKtBhoviqkF1toQgXcr1zmDtuyR7bpLVkFCDf6UbGt/4IpjYdQSfY8wvz+K/l0UbV/cAjFkRGiE6DzmLTMMhqEHEawjpXbwX/bYuyiyTcm+MzYOvxQS0K3DMc9PTM8Tp7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M95ZWuNMUe28tyV9JFNZuR0hfvKNnNOXNbqQYd8iV1Y=;
 b=4JGqhrieJJVrxPlDKXKWc0hGVPkbACR+YyVLanMhgnqmFGEZTmPzVUyYu8nGY29eYjieu6tliqqPBviYmTRKktEQXJXySsX61D9PVB/WaIBHiz8STU2swDbMWW7rW3C+WX4Ohjq9cHE8hwNUzGU62rjxlDK65R4rSgTgYwCHCe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by SA1PR12MB6920.namprd12.prod.outlook.com (2603:10b6:806:258::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 17:56:16 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3ee4:9bf6:c9ee:3821]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::3ee4:9bf6:c9ee:3821%9]) with mapi id 15.20.6178.019; Fri, 10 Mar 2023
 17:56:15 +0000
Message-ID: <dc4fe2d1-a767-7bce-795d-e13bfcad7311@amd.com>
Date: Fri, 10 Mar 2023 12:56:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] drm/amd/display: Enable FAMS for DCN3x
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230310174849.1619771-1-aurabindo.pillai@amd.com>
 <20230310174849.1619771-2-aurabindo.pillai@amd.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <20230310174849.1619771-2-aurabindo.pillai@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0079.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::12) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5284:EE_|SA1PR12MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f0e106d-ec02-44bf-3b26-08db2190be45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h3J9iDHmFLxZOVxGyHz+V7Rcw8mmTxEfFCC2dMicTyDP/uJzCb8vwINs7R8G14N7CWWZri/9K6iCwsDTUZ5wmIDdB13K8YjAR3hyBraE/P3aDbMuYzhBUAmQnmsxt9CmQ8712HzPyPIX/LjO9pUeaPRsCehGefi4sdy8VoeaU5mH6qM49z9kmHKz5cE1eJrcqXQzsmq7gBXGIyTsqvS9+UKLFc2hVZnliya17BKfNZdc9V0i1RQNQM9tK7Y2zBJUni2GdEHMcIf/VVrq/WvlVEQ6pE0/OEGKqL694pryqAG7pArWZAfG3by4olswk2sksZqya4V9O3tpZ8aytH7nPWEsbxraZs36m2538K7DWMOAfoYfbGqsQjjLABhyq2o123IMJgWT1FsIOtLEYULBIWOTQ+4/EJs1R2T6u6jWU6oFnUAhVV94mV3dFxlNFXWkzYx0WojSjGciSRpGqFyvlWuCYp4/aBGJA7lrygEFOr0veIGeyZEnoqlJokONf73heSAIUs7cneTIzx1j+GAXrPOdAn130ajgmuV+qOtNAZAPcrnJqLu7aiVD3BfrKOQAAidDj3wOo7ocSpea+FeU/6AI37rrLSEUqghCq9RTcSXMT6O117WP76VTk5Ru3w/RwFDxaJ+iVCnNn1i6G+bD5+IB+CPqDCI/XGbYUtJL6xQ0qKy+H1j1RPWuaueLqs1Yte1hC8m2QWTpPsMU/k4HIMbBYXBrgKhOr7cL157O1yo6GxJoVInGkCpx6uwfu2cQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199018)(31686004)(36756003)(6916009)(86362001)(31696002)(6512007)(38100700002)(6506007)(53546011)(26005)(83380400001)(186003)(2616005)(316002)(2906002)(5660300002)(478600001)(6486002)(4326008)(8936002)(30864003)(41300700001)(66476007)(8676002)(66946007)(66556008)(44832011)(32563001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnhrcjJ2RlAxWkExSDFKakR0WmhoazRIdEZpRkZvcnRUdWpxWk9LbVltMEti?=
 =?utf-8?B?dUpKK2NTWitNc1NDSlZUZWg2V25zMDhOS3YvVlI4SU9FYkwxYmFMdmx1SnQ4?=
 =?utf-8?B?VFJ3NTdzY0xqK1dVYlptWHZCNkd1cGw1Q3I3YXRFSXM0cWZKQVhEM2dzUHpw?=
 =?utf-8?B?VG5wdDhzUk5YV0l4elJRbmVTbWI5YmY1cFRVdEkwSXQxNzdoa1hVRHBQR2dB?=
 =?utf-8?B?ZE5RSy9reTBCVUl0WGxMNDk4WHU3L3NleTdLQ0pLOEhmeHdWdGNWTVZTTXhO?=
 =?utf-8?B?bVE1U1ZlR3E1ZlNRWVRLbngvcEJlT2tlYmt2aHhjQzVxNjMxbzNqcjIxQWZD?=
 =?utf-8?B?L1NJcXNTUGJkSXJRUjVzd2ZNczhWOTkyWGlsUnJMRGU1OUsxb2VDSmNIZjlR?=
 =?utf-8?B?ZTBEU3Erb2hKdVJCUzlGbTI2VUMxczFDWWcycFJDSEQ3NTh0ck4wejhMYUtv?=
 =?utf-8?B?UnltMHQ1SFJ0YnNxUDRNNmJwRmIybVhYamtBTVlkeU5wREZvQ0lUbmlsRWgw?=
 =?utf-8?B?VWJnVGtrWjlMYzdLWG1VKzhDc0xGT3dGZEtRL1VRYUV2ODN1S0RkNGdqL2Z3?=
 =?utf-8?B?WXVra1ZCWmM3bXkxeXJ2a1BlS0hSM2haRDhQNDl3c3hLM0NBVTRnTnI3VGov?=
 =?utf-8?B?alBjREkxYVpoRFdSS1g0eUkwZDdqemkvM0ZSRTBKbXdNU0w3RXRJUXVDM0VG?=
 =?utf-8?B?Wk00K2kreURWaDgzdDZmUWNXdURvWDUvK0F0UzYvS3FJWHBVazlWMGxGYVFO?=
 =?utf-8?B?VjRxY0xGL1ZnRHowM29DNHJiaVVpYXo5RkF3OVV6c1dxQmRseWRVWld6Zldm?=
 =?utf-8?B?Tkc0eVB3UzZJZGEvZE0xVU1NRTcxRFU4NUgvWmR0eFZ0dVpoZ0dsNUpSRkgw?=
 =?utf-8?B?Y2Z5MTZjWld5UlFDeFJJMWRCY1V0ZGVoK29nS0JndWFoWDZvaS9hemQ5U1hq?=
 =?utf-8?B?enJncnRneW9iUEF3V2pleVYzVHphU2R6cW8yME1CcmVhbWlJTk4wVlprbGhB?=
 =?utf-8?B?WjQxSUl0WDEzWUl2YitkL00wTVdVUkd1RUw4Uzl4Ty85SklqSkhKS1A3bnl6?=
 =?utf-8?B?R1NhVW9jUmVFZjFheEIxWVI0VDAxR0k1dTVLVEhEQUxMUEMranFEc2xoQzV3?=
 =?utf-8?B?ZzdXL1pPSFVINFhDYWZCUnVsbU1vYnhDMml4bW82MVN5Y01OVTBkcGlGeFBK?=
 =?utf-8?B?eTBJa2JpQ05wdWMva2xDQWRhZ3g2QzFDcVZiRmZPaEo1dGVWNWhlaVJUNzV1?=
 =?utf-8?B?NlUxcnNJb050Rjd0eVlZaDFYekc3dS9CbmxkY0I0bkE4ZlRtWnY1aC9JU2pu?=
 =?utf-8?B?eDJVam5MMGtzL2syZldKbmlLbUhUWmxZTHJtVjgxR2hyNTh0aEVjQzkxNFgr?=
 =?utf-8?B?Q2V6eG9EVlAySlkzWU1WQ1VzQi9aRktRdEs5cFgxaVBKems3TFgyTWdMSzNE?=
 =?utf-8?B?MklQdkgyQnlWUm1qUWpSSjhLOGVPTFByQ1VrcmRDTDRiZXJrS2FmbmlrcWJ0?=
 =?utf-8?B?cWdTeUgwOWZPaXFFK1p5UzJIWFgxNnNXTGlCS0w4STY5b2NaNmF4bkI4dWht?=
 =?utf-8?B?bjYxUHZFSjI0L2l1K1FPQm9FZnlTQnAwU2hyMWJkb2UyNWtOWmtnN2tHYmdW?=
 =?utf-8?B?aVlsNG11NVQzM3NtUFoySEJIRmF0amVSaU03MVJQVTZESzltdlZMcUFoelBp?=
 =?utf-8?B?aHhPcEtxamFuOUorUjF2emxyUll2ZnZGcUQ5UTlTSytVR2NwbmtMd0RObGs2?=
 =?utf-8?B?anJKZXpVQ0tNdWpHU0FmOUlzRnZPdDRIdlBnYTBVNjQxTlpTeE9qS0UzeEE5?=
 =?utf-8?B?UjFlYmMxSmtRZlZZWlRLc21YOXJaVFBXakNHU1B5TEdIZUJxdEdRQXRqd3RD?=
 =?utf-8?B?RCsycmlqUmN0eTV4NmZZci94VmNxYTJLWDdCZWdhajFrdzhRWUU5NWN5WEl2?=
 =?utf-8?B?T0phelVIYi92K0ZpWTNoa0hmZGZFZG5WcktTZkdRVEloTFE5MFB1UXZVaERF?=
 =?utf-8?B?SkRkNzJ2bTBxUUVkVVlKWkIyYk83WGdXdVIvYm1UdnZWWlh2aVVra2dEc3RN?=
 =?utf-8?B?NW5tZmNqek1pck9uZjluV01mZHp3bnBCQjQ2TjRvZ2tNMC9FT1FFUVpZRC9s?=
 =?utf-8?Q?ix+mmv7CmB+p6bI/ebB5Er8jV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f0e106d-ec02-44bf-3b26-08db2190be45
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:56:15.6615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUn3vbCq0py6IpTpzvudH/ZBXkBvZ4yrLSXzkDYjAlXhLijv/D/e6kyXlc8g216txw6294xY0EpCaIXRSngeeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6920
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
Cc: harry.wentland@amd.com, rodrigo.siqueira@amd.com, hamza.mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/10/23 12:48, Aurabindo Pillai wrote:
> [Why&How]
> Firmware Assisted Memclk Switching enables lowering mclk using DMCUB
> when it cannot be normally done due to not having enough time within
> vblank. FAMS extends vblank on monitors that support variable refresh
> rate thereby allowing enough time to do an mclk switch sequence
> during vblank.
> 
> When tested with 4k@144Hz monitor on DCN32, power consumption of about
> 40W was saved since multiple clocks like MCLK, SOCCLK, and FCLK
> were brought down.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  7 +-
>   .../drm/amd/display/dc/dcn30/dcn30_resource.h |  3 +
>   .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  4 ++
>   .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  2 +
>   .../drm/amd/display/dc/dcn32/dcn32_resource.c |  2 +-
>   .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  | 71 ++++++++++++++++---
>   .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  5 ++
>   7 files changed, 84 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> index 08b92715e2e6..9963bffb1e07 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
> @@ -301,7 +301,12 @@ void optc3_wait_drr_doublebuffer_pending_clear(struct timing_generator *optc)
>   
>   void optc3_set_vtotal_min_max(struct timing_generator *optc, int vtotal_min, int vtotal_max)
>   {
> -	optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
> +	struct dc *dc = optc->ctx->dc;
> +
> +	if (dc->caps.dmub_caps.mclk_sw && !dc->debug.disable_fams)
> +		dc_dmub_srv_drr_update_cmd(dc, optc->inst, vtotal_min, vtotal_max);
> +	else
> +		optc1_set_vtotal_min_max(optc, vtotal_min, vtotal_max);
>   }
>   
>   void optc3_tg_init(struct timing_generator *optc)
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
> index 8e6b8b7368fd..d8805618a9a1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
> @@ -102,6 +102,9 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
>   
>   bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context);
>   void dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context);
> +
> +void dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc, struct dc_state *context);
> +

This is duplicate and will remove before applying.
>   int dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc, struct dc_state *context,
>   		display_e2e_pipe_params_st *pipes, int pipe_cnt, int vlevel);
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> index 80a0c5a575a9..40080113ed5e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
> @@ -295,6 +295,10 @@ void dcn31_init_hw(struct dc *dc)
>   	if (dc->res_pool->hubbub->funcs->init_crb)
>   		dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
>   #endif
> +	/* Get DMCUB capabilities */
> +	dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
> +	dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
> +	dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
>   }
>   
>   void dcn31_dsc_pg_control(
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> index f87db2271924..3220f9ad8a47 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
> @@ -919,6 +919,8 @@ void dcn32_init_hw(struct dc *dc)
>   	if (dc->ctx->dmub_srv) {
>   		dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
>   		dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
> +		dc->caps.dmub_caps.mclk_sw = dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch;
> +

Will remove the extra newline before applying
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index 100b6df33b33..b1944e49a65d 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -2013,7 +2013,7 @@ int dcn32_populate_dml_pipes_from_context(
>   	// In general cases we want to keep the dram clock change requirement
>   	// (prefer configs that support MCLK switch). Only override to false
>   	// for SubVP
> -	if (subvp_in_use)
> +	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || subvp_in_use)
>   		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = false;
>   	else
>   		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = true;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> index 4fa636364793..53f21b0b3630 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
> @@ -368,7 +368,9 @@ void dcn30_fpu_update_soc_for_wm_a(struct dc *dc, struct dc_state *context)
>   	dc_assert_fp_enabled();
>   
>   	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
> -		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
> +		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching ||
> +				context->bw_ctx.dml.soc.dram_clock_change_latency_us == 0)
> +			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
>   		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
>   		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
>   	}
> @@ -384,9 +386,34 @@ void dcn30_fpu_calculate_wm_and_dlg(
>   	int i, pipe_idx;
>   	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][maxMpcComb];
>   	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] != dm_dram_clock_change_unsupported;
> +	unsigned int dummy_latency_index = 0;
>   
>   	dc_assert_fp_enabled();
>   
> +	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
> +
> +	if (!pstate_en) {
> +		/* only when the mclk switch can not be natural, is the fw based vblank stretch attempted */
> +		context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching =
> +			dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(dc, context);
> +
> +		if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
> +			dummy_latency_index = dcn30_find_dummy_latency_index_for_fw_based_mclk_switch(dc,
> +				context, pipes, pipe_cnt, vlevel);
> +
> +			/* After calling dcn30_find_dummy_latency_index_for_fw_based_mclk_switch
> +			 * we reinstate the original dram_clock_change_latency_us on the context
> +			 * and all variables that may have changed up to this point, except the
> +			 * newly found dummy_latency_index
> +			 */
> +			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
> +			dcn30_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false, true);
> +			maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
> +			dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
> +			pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] != dm_dram_clock_change_unsupported;
> +		}
> +	}
> +
>   	if (context->bw_ctx.dml.soc.min_dcfclk > dcfclk)
>   		dcfclk = context->bw_ctx.dml.soc.min_dcfclk;
>   
> @@ -449,15 +476,29 @@ void dcn30_fpu_calculate_wm_and_dlg(
>   		unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
>   		unsigned int min_dram_speed_mts_margin = 160;
>   
> -		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_unsupported)
> -			min_dram_speed_mts = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz * 16;
> +		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
> +			dc->clk_mgr->bw_params->dummy_pstate_table[0].dummy_pstate_latency_us;
>   
> -		/* find largest table entry that is lower than dram speed, but lower than DPM0 still uses DPM0 */
> -		for (i = 3; i > 0; i--)
> -			if (min_dram_speed_mts + min_dram_speed_mts_margin > dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts)
> -				break;
> +		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] ==
> +			dm_dram_clock_change_unsupported) {
> +			int min_dram_speed_mts_offset = dc->clk_mgr->bw_params->clk_table.num_entries - 1;
> +
> +			min_dram_speed_mts =
> +				dc->clk_mgr->bw_params->clk_table.entries[min_dram_speed_mts_offset].memclk_mhz * 16;
> +		}
>   
> -		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
> +		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
> +			/* find largest table entry that is lower than dram speed,
> +			 * but lower than DPM0 still uses DPM0
> +			 */
> +			for (dummy_latency_index = 3; dummy_latency_index > 0; dummy_latency_index--)
> +				if (min_dram_speed_mts + min_dram_speed_mts_margin >
> +					dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dram_speed_mts)
> +					break;
> +		}
> +
> +		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
> +			dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
>   
>   		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
>   		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
> @@ -520,6 +561,20 @@ void dcn30_fpu_calculate_wm_and_dlg(
>   		pipe_idx++;
>   	}
>   
> +	/* WA: restrict FW MCLK switch to use first non-strobe mode (Beige Goby BW issue) */
> +	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching &&
> +			dc->dml.soc.num_chans <= 4 &&
> +			context->bw_ctx.dml.vba.DRAMSpeed <= 1700 &&
> +			context->bw_ctx.dml.vba.DRAMSpeed >= 1500) {
> +
> +		for (i = 0; i < dc->dml.soc.num_states; i++) {
> +			if (dc->dml.soc.clock_limits[i].dram_speed_mts > 1700) {
> +				context->bw_ctx.dml.vba.DRAMSpeed = dc->dml.soc.clock_limits[i].dram_speed_mts;
> +				break;
> +			}
> +		}
> +	}
> +
>   	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
>   
>   	if (!pstate_en)
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> index 077674be452b..ee2683200799 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> @@ -1331,6 +1331,11 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
>   			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb]
>   					!= dm_dram_clock_change_unsupported;
>   
> +	/* Pstate change might not be supported by hardware, but it might be
> +	 * possible with firmware driven vertical blank stretching.
> +	 */
> +	context->bw_ctx.bw.dcn.clk.p_state_change_support |= context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching;
> +
>   	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
>   	context->bw_ctx.bw.dcn.clk.dtbclk_en = is_dtbclk_required(dc, context);
>   	context->bw_ctx.bw.dcn.clk.ref_dtbclk_khz = context->bw_ctx.dml.vba.DTBCLKPerState[vlevel] * 1000;
