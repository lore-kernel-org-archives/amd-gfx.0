Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F744C388F7
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 17:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A21AB20E65
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 17:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PwzKW1OK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21AB20E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 232B16E8C8;
	Tue,  3 Nov 2020 17:17:49 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3FE6E8D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 17:17:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+F4ElcmhQWERD1UPhVu3Q920PEa6ZiYRznfASxiFeUSpHO0QweJMczo7JjcaPg9SoVSWekPQGZd8nwKE2G54tcnTC+T5S00gv+bEkPn0JLuCfXUuSSIcMARltdCWb48uqg2b6M+tQbKi1wKagnGvnoPKcL91aUqYrynsMeKdN3lQE/LuT2c5CFXimmGfn5vc7uUwMuHyJtX+eaizTxT8gDN9JrtElFV/Dblu17BlVKo3OesG2dqFOoxyDx4rMk0wKkdkBPNIVWczm4dmJ3nzrLkHEpfIQOvL5Jn9z4Bx/NwmxmPqn2RHjAJz0YVlsuJmQABa/zy2yGXmSYCu9Ic+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6epk3CSwmhJLdYZ5TEatFuz0jQE0iWmsjBEgBuJ2eI=;
 b=i9Eap7Z0Ie3uZZ7JJ0bcTUCbA9gYz7nvu3pT03J2BsnUWnuKSTLoisZjAAUBVLkLvnMuvVnSNXLVJrkKY86VZ3kMevlwEruQu7tFl00yY31fNMwSl7tueuTzWNEN4VWAhtemsZRCAiQXIpmrlsYLjG2tqmPgAgWsn3Sb8P5n4Qix/jx9YJeYDQ5GCy8pjZPV8Th1LYyPH2n6nRt4fhYGroPBL9ZsgokHjd4DHOvEzVECW+tjJSCXkA+9tFEYr6RleBUgN0wx4nqLTDPCTBR2MLXnR3S+bmemcIFTqt4MwWlGlIvBeJsL5i6pXpuL4o07F/UY55JGVXyTMBjvef416w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6epk3CSwmhJLdYZ5TEatFuz0jQE0iWmsjBEgBuJ2eI=;
 b=PwzKW1OKwrhSamWifGSFrR77t8x0VlI/IOX9olWvqPxDVZkacuWgh13rv+3l3wi2YrBqFPlnhFsulQjcrDVoDydHk4Jsij1y9tfD1qfIo6R+D+97Py6zeOpwDfgK0jrqiE1caUcQ9PnquX3qjhlSDiZhSMOICCd3oi3i4yDVrwY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB4801.namprd12.prod.outlook.com (2603:10b6:a03:1b1::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 3 Nov
 2020 17:17:43 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.037; Tue, 3 Nov 2020
 17:17:43 +0000
Subject: Re: [PATCH] drm/amdgpu/display: FP fixes for DCN3.x
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201102222800.334556-1-alexander.deucher@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <f9628ed2-4a04-faf9-f9ca-de168db7606a@amd.com>
Date: Tue, 3 Nov 2020 12:17:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
In-Reply-To: <20201102222800.334556-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: YTOPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::46) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTOPR0101CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Tue, 3 Nov 2020 17:17:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 110d227b-16d4-40eb-84c3-08d8801c5fbe
X-MS-TrafficTypeDiagnostic: BY5PR12MB4801:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB4801A07B08577D55B2614D05EC110@BY5PR12MB4801.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWaoRRC57wgg9qeqN87cYNbcpcL6e0W0fYZOBMu/SjH9G5FECJNt85wwOVs3eraudXgmV3C7ylFxEKdkXBgy9UagK03c9/MwqBzhygUr/jdHZ6L6tioQ7rKe76oamfe/UBPq/vdJLrrEl62YqAmPxq5nhLjazM2bbdQiet/Md8dm4w5fGHyCOYDLvt68vygcUR2wxOP415Xd5nSFaB3hOVcbz/Xp1fyKdNfnQ2U0hg1Y+j7pB98THK/CGu2MJkUFrJ5bfmIegQu9njXzrfU2aSTQf1fF9iRS/izKGMptE8g2Gw4R7RcVCAF1Ytw62tZMtjppk2DowHEnnrjRIayli0co65qla9JB77s7N5Io3iNHryu2iDfu3FEn7Nz5EiIK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(16576012)(316002)(66556008)(66476007)(8676002)(8936002)(36756003)(66946007)(31686004)(6486002)(4326008)(83380400001)(52116002)(2906002)(31696002)(16526019)(186003)(2616005)(26005)(86362001)(478600001)(53546011)(956004)(5660300002)(6666004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: y5cN7Zv7v2bs/gFFlqx8vPvkKh9umVK2/sLdNnBM1SLI97H4e33NRp9Io3UOp+VRJqVQe7MjadbLjFuFVLUbrHEqCaolVpI4fDkXeyP7ZDIqCFk/UkkBAjk8yyJwlek7+xzhb8YgIBoFSyIboU5r/49Vlddan33M6STIvJJydoqzQ9UnGPyD92ifi8YZzrZi5ieaolJCFQSNUCasSSt6Xfy5xONTDdHtaAM55TXHq9D1402uoUeGvx10FrFZdizGCh9ljlEaHHtc79T7PoVkpuGYoh+QfmH5Y4v3VvpYVaKLiZ7i6V1jINUyoF4kf/+BhCxhmR4+jHfGVamDRagKqmqm33rimA+8hS0OeR5fO42HSRypJu9cipJSbxxzTY9h9YU/aV1LrGNI3+bnMwuo/lYx8+gcfh4JVK6nCzLbM+Y0jIpejf01GvSLbBmkFdt7yufTwtvZynhfl3UVvXtb48PZ6z0rnwySq/a2ng83FnOParPJ2ryXHdX00kCnqmboKDPfE85sKw6nHRZ+LMzdT91dsfYsuDLfe4L8SVJ5NnqCDPaRX+DQsdsYHPdj+O4+v3ihqjWDYk0q3CHHYfO5HKi5/rakianxj9ST0kFbOyfsYpu0pljryr4+uJmNRosGIcBuMXKbD+8HYK/Ti0JvmQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110d227b-16d4-40eb-84c3-08d8801c5fbe
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 17:17:43.0773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvAhoNyZEQfx5TLeroowjvNeNXu+bTzIZ3wKhB5GmJvgCQvMm824WSi33yiAz1F4NK5LnVIlb4CdFCkr45wvNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4801
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-11-02 5:28 p.m., Alex Deucher wrote:
> Add proper FP_START/END handling and adjust Makefiles per
> previous asics.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   .../gpu/drm/amd/display/dc/clk_mgr/Makefile   | 13 ++++
>   .../drm/amd/display/dc/dcn30/dcn30_resource.c | 71 +++++++++++++++++--
>   drivers/gpu/drm/amd/display/dc/dml/Makefile   |  6 +-
>   3 files changed, 84 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> index facc8b970300..9f9137562cab 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
> @@ -127,6 +127,19 @@ AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN30)
>   ###############################################################################
>   CLK_MGR_DCN301 = vg_clk_mgr.o dcn301_smu.o
>   
> +# prevent build errors regarding soft-float vs hard-float FP ABI tags
> +# this code is currently unused on ppc64, as it applies to VanGogh APUs only
> +ifdef CONFIG_PPC64
> +CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn301/vg_clk_mgr.o := $(call cc-option,-mno-gnu-attribute)
> +endif
> +
> +# prevent build errors:
> +# ...: '-mgeneral-regs-only' is incompatible with the use of floating-point types
> +# this file is unused on arm64, just like on ppc64
> +ifdef CONFIG_ARM64
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/clk_mgr/dcn301/vg_clk_mgr.o := -mgeneral-regs-only
> +endif
> +
>   AMD_DAL_CLK_MGR_DCN301 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn301/,$(CLK_MGR_DCN301))
>   
>   AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN301)
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> index d65496917e93..01ac8b2921c6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
> @@ -1469,7 +1469,19 @@ int dcn30_populate_dml_pipes_from_context(
>   	return pipe_cnt;
>   }
>   
> -void dcn30_populate_dml_writeback_from_context(
> +/*
> + * This must be noinline to ensure anything that deals with FP registers
> + * is contained within this call; previously our compiling with hard-float
> + * would result in fp instructions being emitted outside of the boundaries
> + * of the DC_FP_START/END macros, which makes sense as the compiler has no
> + * idea about what is wrapped and what is not
> + *
> + * This is largely just a workaround to avoid breakage introduced with 5.6,
> + * ideally all fp-using code should be moved into its own file, only that
> + * should be compiled with hard-float, and all code exported from there
> + * should be strictly wrapped with DC_FP_START/END
> + */
> +static noinline void dcn30_populate_dml_writeback_from_context_fp(
>   		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
>   {
>   	int pipe_cnt, i, j;
> @@ -1558,6 +1570,14 @@ void dcn30_populate_dml_writeback_from_context(
>   
>   }
>   
> +void dcn30_populate_dml_writeback_from_context(
> +		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes)
> +{
> +	DC_FP_START();
> +	dcn30_populate_dml_writeback_from_context_fp(dc, res_ctx, pipes);
> +	DC_FP_END();
> +}
> +
>   unsigned int dcn30_calc_max_scaled_time(
>   		unsigned int time_per_pixel,
>   		enum mmhubbub_wbif_mode mode,
> @@ -2204,7 +2224,19 @@ static bool dcn30_internal_validate_bw(
>   	return out;
>   }
>   
> -void dcn30_calculate_wm_and_dlg(
> +/*
> + * This must be noinline to ensure anything that deals with FP registers
> + * is contained within this call; previously our compiling with hard-float
> + * would result in fp instructions being emitted outside of the boundaries
> + * of the DC_FP_START/END macros, which makes sense as the compiler has no
> + * idea about what is wrapped and what is not
> + *
> + * This is largely just a workaround to avoid breakage introduced with 5.6,
> + * ideally all fp-using code should be moved into its own file, only that
> + * should be compiled with hard-float, and all code exported from there
> + * should be strictly wrapped with DC_FP_START/END
> + */
> +static noinline void dcn30_calculate_wm_and_dlg_fp(
>   		struct dc *dc, struct dc_state *context,
>   		display_e2e_pipe_params_st *pipes,
>   		int pipe_cnt,
> @@ -2360,7 +2392,18 @@ void dcn30_calculate_wm_and_dlg(
>   				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
>   }
>   
> -bool dcn30_validate_bandwidth(struct dc *dc,
> +void dcn30_calculate_wm_and_dlg(
> +		struct dc *dc, struct dc_state *context,
> +		display_e2e_pipe_params_st *pipes,
> +		int pipe_cnt,
> +		int vlevel)
> +{
> +	DC_FP_START();
> +	dcn30_calculate_wm_and_dlg_fp(dc, context, pipes, pipe_cnt, vlevel);
> +	DC_FP_END();
> +}
> +
> +static noinline bool dcn30_validate_bandwidth_fp(struct dc *dc,
>   		struct dc_state *context,
>   		bool fast_validate)
>   {
> @@ -2411,7 +2454,20 @@ bool dcn30_validate_bandwidth(struct dc *dc,
>   	return out;
>   }
>   
> -static void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
> +bool dcn30_validate_bandwidth(struct dc *dc,
> +		struct dc_state *context,
> +		bool fast_validate)
> +{
> +	bool out;
> +
> +	DC_FP_START();
> +	out = dcn30_validate_bandwidth_fp(dc, context, fast_validate);
> +	DC_FP_END();
> +
> +	return out;
> +}
> +
> +static noinline void get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
>                                                          unsigned int *optimal_dcfclk,
>                                                          unsigned int *optimal_fclk)
>   {
> @@ -2478,8 +2534,10 @@ void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
>   
>   		// Calculate optimal dcfclk for each uclk
>   		for (i = 0; i < num_uclk_states; i++) {
> +			DC_FP_START();
>   			get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
>   					&optimal_dcfclk_for_uclk[i], NULL);
> +			DC_FP_END();
>   			if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz) {
>   				optimal_dcfclk_for_uclk[i] = bw_params->clk_table.entries[0].dcfclk_mhz;
>   			}
> @@ -2583,6 +2641,8 @@ static bool dcn30_resource_construct(
>   	struct irq_service_init_data init_data;
>   	struct ddc_service_init_data ddc_init_data;
>   
> +	DC_FP_START();
> +
>   	ctx->dc_bios->regs = &bios_regs;
>   
>   	pool->base.res_cap = &res_cap_dcn3;
> @@ -2860,10 +2920,13 @@ static bool dcn30_resource_construct(
>   		pool->base.oem_device = NULL;
>   	}
>   
> +	DC_FP_END();
> +
>   	return true;
>   
>   create_fail:
>   
> +	DC_FP_END();
>   	dcn30_resource_destruct(pool);
>   
>   	return false;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 879a930358a5..8866e1348b65 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -64,6 +64,8 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
> +CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) -Wframe-larger-than=2048
> +CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
> @@ -71,8 +73,8 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflag
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_rcflags)
> -CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) -Wframe-larger-than=2048
> -CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcflags)
>   endif
>   CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
