Return-Path: <SRS0=xcSd=EJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9658C2D0A3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 14:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 233A622264
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2020 14:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uz5zFCf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 233A622264
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5AE76ECB3;
	Tue,  3 Nov 2020 14:20:17 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E9D66ECB3
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2020 14:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QjqPhIlIPeUT4s9cuF3W8LnPA3skkLfSyw82yBvZAjoQEuHhyKxUVjijK4veUKVnqEHzDkTrTuFnNbLAVyAmsdVjiiXzlip/odV3e8/Wgenfctxt5NSFw0P2syMs2U/KhuSikcgsddeBkgqB4pBWMycGuc+M2abGIjTRfE9Mi48cUdmP3Y+KzK3ACqNvaGdn3pqt6aubKwLh/+NrXr1AaUB9dkqhLIVjM/It6xFKYuTBgDRziG7i9o0tUOD7Yjs7Ux6Ls/0vFaLPhniUhJA77/r9tRrh3LCGL34bcPo4dqKqcuK4qZ1xuyQSSAxoibUhd/izZw7Tih9Ik6PCQoK4Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHFKqO++XF9v0qMV7+5The0rJav5jpXxThvwc7xDpZY=;
 b=db/ExROsnZOQBlsfwPdxSZhAyJRxoVzMEMXvv1SAiGUiuaLHzWSd5Nq6EAW4HbPZOkIuvvs7bvjWnIXbHKL4ssCiJUozzuUYXvTEk9JK9FUZrnev5dbpy3xO785gA5WR/7uEnkNpiVSBxHQWCpozIaD0AVjFJTVj492bstKx2SeV99KTm4tm4w5QhSg6+2whpYAS4IT58HbBZPU+TykY2Haf3eSZ2kHXOUZh5MaL92rpO4Ox6hbt8Sa38oI+WDg21B4BJIDpRTV8oqA9vZAJ+aee2livwe52ntpX12/hEZPE7ulrfDQ6y5OEqDB43v7g8LjcB9kUafKoBzvLC2fJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHFKqO++XF9v0qMV7+5The0rJav5jpXxThvwc7xDpZY=;
 b=uz5zFCf2qPOWgaywVpJJ7zPXOjCjcmTQKzUPdAYQtMVg5tmyv9z8A4NNEeYNnlDJmWelKMyvwILP0FHbiAqv5daWuodPIIORGbJ3YbxuGgEwUL+Z3NDDtBiE3rNuYczIipmJ+//y8KEpdpWuvwtD7CNP8V1fcl0Z0Jrx/mkGR0U=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW2PR12MB2537.namprd12.prod.outlook.com (2603:10b6:907:6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Tue, 3 Nov
 2020 14:20:14 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::e8c1:7ef6:c905:247d]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::e8c1:7ef6:c905:247d%8]) with mapi id 15.20.3499.032; Tue, 3 Nov 2020
 14:20:14 +0000
Subject: Re: [PATCH] drm/amdgpu/display: FP fixes for DCN3.x
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20201102222800.334556-1-alexander.deucher@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <7ffba769-52ca-0eeb-df1c-c6800b3b7d45@amd.com>
Date: Tue, 3 Nov 2020 09:20:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201102222800.334556-1-alexander.deucher@amd.com>
Content-Language: en-US
X-Originating-IP: [198.200.67.155]
X-ClientProxiedBy: YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::47) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.193] (198.200.67.155) by
 YTBPR01CA0034.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::47) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.19 via Frontend Transport; Tue, 3 Nov 2020 14:20:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 30fdd0e8-113b-4990-2442-08d88003949c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2537:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2537C7F52118CBF169AFD9BB8C110@MW2PR12MB2537.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: niW4P6ki5bjAe7TPBbG9uFIZyOCcuZg9Bwa70Lp/GbGX951uqdbCWFZNUZKUHx5feY3QiBPtH9y6mPsqcfFN0QNA0Z6MCc43DIBPS2En1sYCF0xDeoL3rwhAtLnP0yizHLiigebRLtWolv7bNNJ1pqMxiay2zZIEo8ikCj8cneLyARKoSLnD0K/1NrUzWCki+wx1WM5FGTlclBtxupkIN3cNS1sTFZeH1QuGBnZksL0eFre7zQBJqgBgFu5etjoyQY29rSnAOX9EoNxk0dOCNhSa89qCxprUH2q7hVse0Y3Fi6N//y9yM+RBMc5rmXK+2avxoF3+ieElz3fnwtdFfK/s/837b+DuE2Fq8IUhSjgUCxdXALgeK8FYRgRdQ1h1
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(44832011)(86362001)(5660300002)(53546011)(8936002)(4326008)(31686004)(52116002)(6486002)(8676002)(26005)(186003)(16576012)(2906002)(316002)(478600001)(2616005)(31696002)(66476007)(16526019)(66946007)(66556008)(956004)(83380400001)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: jM6AUijSPHyZiQA6EUMUEleHOubHj3/89AFDqBzn7NPdaQYLcPmUNT6E/Tel5zb5MWEIhAZsUb2sOvjEd2Q3GMq0A3CyMc5mwmwEDNJhHIOm8WuiDNRRw6sHELKO4baS51XJFpiqw5rssSMgnuWFCk3jnLtMINasB7X6s8jkzi4JNL5jlQhfe3FUPy2KVjjsL0qJBD8Rw3V8ENli2KByyqTA/0h3nQqJsGuJgfUC6Vxe4TiFQKZKuHKkAlAmGsWXhJ72so0j/DyYEt5dXuJ9QXpiuW+mAptW4oy6TWyNFm5KQgK97g4dcLPngVxW101uxtgkoVnmy3QeHro5n6QC83HJbvBCUCI6wBywwSisy0YEnsGsI+sK9yERjTOIImPWh9/m26/Pqge/nLofICu+5+eP7H3rRR1llsOKu4RAdBzeJk+kD2grvJqEg91hyCdM44d7HREZTXm55E1ACzaD4SZRG02wCsN56QN33xj4X7eLAtR6T3fd1nia7YK24S10vQEP7D2YRsLyCyGIo6YKbQfABW0Q+dXOd64h9h6T/E8ErHgMJ9QhDbblfOUc01IujQMfSojgfNUd+F9lJD8VxACLfzSuLryaabjzPMyG/tDXebQY+TSuplnok+BwkB6sIKhqlBsVPuS8rV6BgyaZLA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30fdd0e8-113b-4990-2442-08d88003949c
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 14:20:14.1773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QX1tgFTVlKj2Ag11RN3RSIRWOjn106rmLLg4Qqx8DmaHvKoEYB5MJG1CUftpP9BproiSkME6L7uTzS5ddeFwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2537
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

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

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
