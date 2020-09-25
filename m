Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6586BC47425
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72D5206F7
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 14:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qkjehuPT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72D5206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5788A6ED15;
	Fri, 25 Sep 2020 14:55:37 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 815176ED0B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 14:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkRtP7bQtwBF5D1kxQIGwWCeeCmzdeG9lQKX9Xpwf2eBzhmZRLKIW+XeXiNVYl9xSjeyfMAdCNsuq9H94fM46ycciccF8Lrb5SdMSMO5qC9oBpxY5OzvoG6P4X/DbYHmANN2wj/hMK3ATQbqLz1VgBvcgnKAw0d0i4X4w8a4h2K/RAGUbWjP3vfEJmB6vDeh7R6us+35OZ6HDvSkxWTnhZZBb6dplbo8zUo4f1CxJjfzQ4I73Yl910iQHnzEdJWnUwx39qQdShqbeNMe2BfFcQJl53KqaV2okgnxfFJR67KmpHXPvjlC8YMHt0lc4TAKphwx+DEEh2GsfQxOuI7lhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBjDEI+G0iLhkibAH2g09Xf7KM+SnqM2nAzaBFwuCvc=;
 b=jNfMR1UZUWvuX8LZ6IYC990qdbctVwCBEb5wBzHoacRvKXwVaScE280zsaOmqm9FOMsJpk3I2EuRQavxCo1/PzsRhB3+yPkqWNuGOltBiW0bOO6oAvdFKcA+QdgXbis3iUruRmMYRvPTI0lVFk/MHrQKbGQX5eC8gXbQtUXkBULZiLPLC8ezdRFsfzUCuMJm5rDWVYlKCWkSlrHCo5Jl9jglHGpjkizOHLMdeMYHzM3smT6tDYQ1Q4lDCEpacZ3K8nqiW/jWIYVbuDWPsjYmDxaANwWuggARUi9zLLV2wTELYBUGgeLBGYZ8Hnxcd5oO0pc2U98QUgsAKXl5oRuSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBjDEI+G0iLhkibAH2g09Xf7KM+SnqM2nAzaBFwuCvc=;
 b=qkjehuPT3lVHGvyUykbWix6HGKgwlFStZKQ4+EbKppwzjxP4wO5gzQ+8B8Ofs+Q3XirlwLg5uPnUIOG7RPxLGpWdTO6XkZ+evDU0C1jOP+JsJ4qLZRj8Su9vl2MhrFL2Zucu3L1AwNqyrKit7T9zBs3S0+gRtjmpBzIpx7cOBEY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM6PR12MB4219.namprd12.prod.outlook.com (2603:10b6:5:217::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.23; Fri, 25 Sep
 2020 14:55:13 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::25a1:ace4:4ca8:167e%7]) with mapi id 15.20.3412.020; Fri, 25 Sep 2020
 14:55:13 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/9] drm/amd/display: Calc DLG from dummy p-state if full
 p-state unsupported
Date: Fri, 25 Sep 2020 10:54:51 -0400
Message-Id: <20200925145455.2398170-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
References: <20200925145455.2398170-1-Rodrigo.Siqueira@amd.com>
X-Originating-IP: [2607:fea8:56e0:6d60::980e]
X-ClientProxiedBy: YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::38) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::980e) by
 YTBPR01CA0025.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Fri, 25 Sep 2020 14:55:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c927f8d7-5b75-4c8e-4faa-08d861630183
X-MS-TrafficTypeDiagnostic: DM6PR12MB4219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB421943FA7D7CC1358BA9BF6A98360@DM6PR12MB4219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YA5CJJKTwdynjjnhzr4vpjTGfgFPhx6LFKL6NPM8aemjfXLPQ8as6fImCKDJY58wHsulXN3qiKH9Xo4mzWy91fXDM6SfV5zlANLYucBoQGOxNDST1NNNM5QGGA42+ZU1vCgNoUu9cL6iVzp/X04de9VNKxfYmXtAlQNsotJV/SLXlguPuJFaCcF0zWlMHWGAfz+LNmuYIScn9Cl2I72GVe8pyEXgemy0YCmKPh6hvzxFF8QsITCyZERwACo4cZUZf+Zsyl9oQcNQyZ7GDhmwl+U/Sf28euHLPxAiJjvEqpkwCYX434lclotfaEfmfJ7Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(66946007)(6666004)(36756003)(16526019)(4326008)(6506007)(52116002)(2906002)(86362001)(2616005)(478600001)(6512007)(66556008)(186003)(66476007)(6916009)(1076003)(5660300002)(30864003)(54906003)(316002)(8936002)(83380400001)(6486002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5h6pHvpdvRUd8MRxSlPV6U8hJpk2JUBa3eBYWq2pq01qslXhP9MSGlYo4XbjkZVW6RIzneFpzbBgAvmAlc9ngMp9ydRFZ8ff/3sjRUgKOMn+THIBRHO1J72KQo20usyxeFzQhAR4jEDYpELKldlh8260zZwRfo+YVgui95hEiqIuIwPmfiv/TOdF+sM/gt22JY+pQzrEMWEKy0T0kdw9hmIVFahO1ZdXb3aC789+ME8illQK/NB7cthawHAerRynNAe1bXPYXXapI8NwTqhK27SaAJgUn1dl3PU05+Rvw/o107lS/jNJkQ7kQWPL7U6VD3mLzFf9xIoCeuGtn81QeRd3wuEdkacjX3nujMj3JCaPTRsP2sc61mlKVHFfsPFjUbu6WcdOz99Myd3nmqlXmFkTmdJxyyzqzNnBGPZkXM7HoBJs8x4up373ODURSCci3KENDhORrJYaBi2WMFyL4WAxkgbMxFXQsKD1PDDAJ2EtAcLLTRhN/uubV/PKmCnqnmM0DI2s3T0H+PcdzZdkGCI141Uqvf2eoQdP+3yCi8JypGNQOew/RwiaOVqVdz1SibrTxDTZOyuSrPHoEQP/+3QkY3TOWFP/0fvM+grJzi763zWqAKFGnK2vFMLgft5RiOIuF93PZ/DgQzHLdwUHKToEgICiQ8bZjTnIe+a5xNZjScpdi2gqjp0X12liWmjP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c927f8d7-5b75-4c8e-4faa-08d861630183
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 14:55:13.0045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xf3SuUn+duyoJ4M7HvaGNb4CDPfvJSK9Rad5sG6YeQD32ApqObzPZDYujEh0mBZbXYkD3nKQD8z2F8aQ+KyMkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4219
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
Cc: Joshua Aberback <joshua.aberback@amd.com>, Eryk.Brol@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Joshua Aberback <joshua.aberback@amd.com>

[Why]
Currently, when full p-state changes are not supported, DLG parameters
are calculated for no p-state support at all. However, we are required
to always support dummy p-state changes, so we should instead calculate
DLG based on dummy p-state latency when full p-state is unsupported.
This behaviour already exists for DCN2.

[How]
 - move DLG calculation inside WM calculation
 - if p-state unsupported, do not recalculate for set A, instead copy from
set C, and perform DLG calculation with dummy p-state latency

Signed-off-by: Joshua Aberback <joshua.aberback@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 114 ++++++++++++------
 .../drm/amd/display/dc/dcn30/dcn30_resource.h |   5 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +-
 3 files changed, 80 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index dde87baf1370..7f3354b3512d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2127,7 +2127,7 @@ static bool dcn30_internal_validate_bw(
 	return out;
 }
 
-static void dcn30_calculate_wm(
+void dcn30_calculate_wm_and_dlg(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
 		int pipe_cnt,
@@ -2135,6 +2135,8 @@ static void dcn30_calculate_wm(
 {
 	int i, pipe_idx;
 	double dcfclk = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
+	bool pstate_en = context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] !=
+			dm_dram_clock_change_unsupported;
 
 	if (context->bw_ctx.dml.soc.min_dcfclk > dcfclk)
 		dcfclk = context->bw_ctx.dml.soc.min_dcfclk;
@@ -2168,30 +2170,12 @@ static void dcn30_calculate_wm(
 	pipes[0].clks_cfg.voltage = vlevel;
 	pipes[0].clks_cfg.dcfclk_mhz = dcfclk;
 
-	/* Set C:
-	 * DCFCLK: Min Required
-	 * FCLK(proportional to UCLK): 1GHz or Max
-	 * pstate latency overriden to 5us
-	 */
-	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.pstate_latency_us;
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
-	}
-	context->bw_ctx.bw.dcn.watermarks.c.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.c.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-
 	/* Set D:
 	 * DCFCLK: Min Required
 	 * FCLK(proportional to UCLK): 1GHz or Max
 	 * sr_enter_exit = 4, sr_exit = 2us
 	 */
+	/*
 	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].valid) {
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us;
 		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us;
@@ -2205,29 +2189,72 @@ static void dcn30_calculate_wm(
 	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.d.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 	context->bw_ctx.bw.dcn.watermarks.d.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	*/
 
-	/* Set A:
+	/* Set C:
 	 * DCFCLK: Min Required
 	 * FCLK(proportional to UCLK): 1GHz or Max
-	 *
-	 * Set A calculated last so that following calculations are based on Set A
+	 * pstate latency overridden to 5us
 	 */
-	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
-		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
-		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
-		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
+	if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].valid) {
+		unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
+		unsigned int min_dram_speed_mts_margin = 160;
+
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[0].dummy_pstate_latency_us;
+
+		if (context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] == dm_dram_clock_change_unsupported)
+			min_dram_speed_mts = dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz * 16;
+
+		for (i = 3; i > 0; i--) {
+			if ((min_dram_speed_mts + min_dram_speed_mts_margin > dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts) &&
+					(min_dram_speed_mts - min_dram_speed_mts_margin < dc->clk_mgr->bw_params->dummy_pstate_table[i].dram_speed_mts))
+				context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->dummy_pstate_table[i].dummy_pstate_latency_us;
+		}
+
+		context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us;
+		context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us;
 	}
-	context->bw_ctx.bw.dcn.watermarks.a.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.a.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-	context->bw_ctx.bw.dcn.watermarks.a.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-
-	context->perf_params.stutter_period_us =
-		context->bw_ctx.dml.vba.StutterPeriod;
+	context->bw_ctx.bw.dcn.watermarks.c.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	context->bw_ctx.bw.dcn.watermarks.c.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+
+	if (!pstate_en) {
+		/* The only difference between A and C is p-state latency, if p-state is not supported we want to
+		 * calculate DLG based on dummy p-state latency, and max out the set A p-state watermark
+		 */
+		context->bw_ctx.bw.dcn.watermarks.a = context->bw_ctx.bw.dcn.watermarks.c;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = 0x13FFFF;
+	} else {
+		/* Set A:
+		 * DCFCLK: Min Required
+		 * FCLK(proportional to UCLK): 1GHz or Max
+		 *
+		 * Set A calculated last so that following calculations are based on Set A
+		 */
+		if (dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].valid) {
+			context->bw_ctx.dml.soc.dram_clock_change_latency_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+			context->bw_ctx.dml.soc.sr_enter_plus_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us;
+			context->bw_ctx.dml.soc.sr_exit_time_us = dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us;
+		}
+		context->bw_ctx.bw.dcn.watermarks.a.urgent_ns = get_wm_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.pte_meta_urgent_ns = get_wm_memory_trip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		context->bw_ctx.bw.dcn.watermarks.a.urgent_latency_ns = get_urgent_latency(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	}
+
+	context->perf_params.stutter_period_us = context->bw_ctx.dml.vba.StutterPeriod;
+
+	/* Make set D = set A until set D is enabled */
+	context->bw_ctx.bw.dcn.watermarks.d = context->bw_ctx.bw.dcn.watermarks.a;
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
@@ -2247,6 +2274,13 @@ static void dcn30_calculate_wm(
 
 		pipe_idx++;
 	}
+
+	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
+
+	if (!pstate_en)
+		/* Restore full p-state latency */
+		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
+				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 }
 
 bool dcn30_validate_bandwidth(struct dc *dc,
@@ -2279,8 +2313,7 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 		goto validate_out;
 	}
 
-	dcn30_calculate_wm(dc, context, pipes, pipe_cnt, vlevel);
-	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
+	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
 
 	BW_VAL_TRACE_END_WATERMARKS();
 
@@ -2448,6 +2481,7 @@ static const struct resource_funcs dcn30_res_pool_funcs = {
 	.link_enc_create = dcn30_link_encoder_create,
 	.panel_cntl_create = dcn30_panel_cntl_create,
 	.validate_bandwidth = dcn30_validate_bandwidth,
+	.calculate_wm_and_dlg = dcn30_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn30_populate_dml_pipes_from_context,
 	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
index c9d5f94092a0..d163812af858 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.h
@@ -55,6 +55,11 @@ unsigned int dcn30_calc_max_scaled_time(
 
 bool dcn30_validate_bandwidth(struct dc *dc, struct dc_state *context,
 		bool fast_validate);
+void dcn30_calculate_wm_and_dlg(
+		struct dc *dc, struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt,
+		int vlevel);
 void dcn30_populate_dml_writeback_from_context(
 		struct dc *dc, struct resource_context *res_ctx, display_e2e_pipe_params_st *pipes);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 1daa563c8ff4..6e6bc66e49f0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -101,7 +101,7 @@ struct resource_funcs {
 					struct dc *dc,
 					struct dc_state *context,
 					bool fast_validate);
-	void (*calculate_wm)(
+	void (*calculate_wm_and_dlg)(
 				struct dc *dc, struct dc_state *context,
 				display_e2e_pipe_params_st *pipes,
 				int pipe_cnt,
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
