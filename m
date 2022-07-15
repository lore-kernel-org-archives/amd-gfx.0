Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355BEC433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F3BA10EA22;
	Sat, 16 Jul 2022 14:36:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7DDE10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NnF2KkZQFegpk+zbYLwhzkvxTdaSahmkCxmO9lpL0ID00wahjRjuGvz7mOgqOVj8+SqaDpczhOBM6NA3rKKhanY9gV0s/Ba1dYmE1fFeMzqDRbETGlXxURJDSJX30k2fBNeT3l7qRG/o34+6HQUqnO/4yaE+bgo4DA2w2lOybPDvWrmIAyKV+hU1jaijLTvfHDyzihkdmz01J0vhmXUIr8NgLhVcVntIZxoIUKYuXH6ulbCKpYfWT0AjX4RKS9AHUnbeLeEna+um5M5QYV3zWjbt1fJARrhRmzzjNzXP27ji3mPOyj0DOhzF0PvuqCOyZPkNC2lkcv5vRCUg4uyJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pVFWtkTt/ysFNSmRraax2nqoCKf7/UjgxrauGxj9pfs=;
 b=E5ZzVa5E1pGWlaeiwCygP2qN8mh8/94G5PLz91TqTF7+AvNJxS1K37hPFaGdQQfZeOCsEZex6fIvrqhzGehNkWcfczOKktu8YtyGwGsM0N7A7SbMEPc8rqVQxtMoJugSP6Fx/TTJOMj+cGElf+FTA9k6PWFxfohrSaDTP2lwSOvwxrOqpAiMrewOlxKRZjkcJB4QXU9WS5CVTbID77hwi4Iu+tGdrKzJsFrX36jYfv1pi45lFMjGVdU4u1+MPWzN71zr/GVmmw/InCxL/pW7UdLiPfIMtoeSDywcKzfp1NWPu3OZeW0uhNQo0D5kAeYf87yG4wztF2rQ3vGzk7Gxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pVFWtkTt/ysFNSmRraax2nqoCKf7/UjgxrauGxj9pfs=;
 b=qeWFx/YoDoju0nKF4ItaLxNRHxYiOfVHG+9HRmX1p92wiWZ4XvEmDQX+ZkA8AItVKjnrM3r5MCrPJG7y+woy60mVbYc4rNzSAWd+o20CatTM+4uqGe4mKDpG5EdhTGLrIxJNWmE1+96g6+nq+c4ucaLS7gqmnDWjnzfb9m0Xs4g=
Received: from DM6PR07CA0053.namprd07.prod.outlook.com (2603:10b6:5:74::30) by
 DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12; Fri, 15 Jul 2022 18:17:48 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::61) by DM6PR07CA0053.outlook.office365.com
 (2603:10b6:5:74::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:47 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:47 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:46 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/31] drm/amd/display: Drop FPU flags from dcn32_clk_mgr
Date: Fri, 15 Jul 2022 14:16:52 -0400
Message-ID: <20220715181705.1030401-19-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcd4c98e-f4cf-4d5a-4d60-08da668e5271
X-MS-TrafficTypeDiagnostic: DM6PR12MB4563:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnvufPfKV1KH3LxgUMKIhNOp842wBhJIxP8q3Bccf/VpUdp/w4X23jYMFXKaYxp+xV82UnrK58+VWA+vab82R/USyixhRn1l0Y3evMl1np41827wWMzhQi9Bqz39oqnXJjLKVUMarcUq3MPPHZcvfCsO8xb4TE5EaC1hPJk5kr7DgR9jHZO+fVrhrJUoX51RRn5wBLt6FXc/62xji0EdvMfKMkvuarcgB7z9oa9ACA8HGpPv+ZkM3wI00Q6wwd0DkQvZ7Y+f3Q9tOZ5pcTdSnUezT+2TN7+HdB/V/60ggBbApPfhvVO9pQxRcG9FDFsSd8ispC9GU7DWhiqF/YXwJOxV8+D68eijggcoENQCJTlqjyGyF1Fg0yaC9cmV/OpCnpJqLpyWZa/bCTMbTHR41I6o6dAMhN30IJzYJ26tc0D69cT1n85hIPV30AhGw2qtySIH/4bJ5CZv0Xe2iPCM9hvhf5JIg/+socdFFLSc8/OljobNyhVSn9n97iZB0bxwinb9Q6XfVpW15/ws8HXhcizp2kpv3+FBVZWKM8HcY2k4kSCEpSe7863wrccZH0YpZ8BQx0ZHbrELb1eVEMi9n5ptsMA/mI++OdZlMVh0SZuLCBjQ07Y+pUNBM2cUoLNHttIkdKXPIwikgXZLkQ1SgadM5pFkkMgp9/hh2N2REsbc2aLHO0Nl3GNQkOQs18a6M8bJOSOb1okIAAD/Us/HA/K4/hM7+zQTI7OnwEqhgubRajkEqs81qVjvJlivcc5w/ftK+xAWwJcsrHzfe2+bRQZgmMycIV7wCSuICSiFKxbMsTfLfBOUju59ysBwIA8ykfIguFuKAOsfXC+qfMoz5eAWUzBGTwr7xRK5GHIv7Vk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(40470700004)(46966006)(36756003)(336012)(426003)(5660300002)(47076005)(30864003)(70586007)(2906002)(186003)(1076003)(36860700001)(83380400001)(2616005)(82310400005)(8936002)(70206006)(86362001)(4326008)(26005)(54906003)(6666004)(478600001)(6916009)(316002)(40480700001)(41300700001)(8676002)(82740400003)(81166007)(356005)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:47.9799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd4c98e-f4cf-4d5a-4d60-08da668e5271
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We are working to isolate FPU operations inside the DML folder, and the
file dcn32_clk_mgr has some of these operations. This commit moves the
FPU operations inside the clock manager and creates the dcn32_fpu file
to aggregate those operations. Note that there is no functional change
ere, just moving code from one part to another.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |  25 ----
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  81 +------------
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 113 ++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  34 ++++++
 5 files changed, 153 insertions(+), 102 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
index 053084121db2..a48453612d10 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
@@ -188,31 +188,6 @@ CLK_MGR_DCN32 = dcn32_clk_mgr.o dcn32_clk_mgr_smu_msg.o
 
 AMD_DAL_CLK_MGR_DCN32 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn32/,$(CLK_MGR_DCN32))
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn32/dcn32_clk_mgr.o := -msse2
-endif
-endif
-
 AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN32)
 
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 08f07f31fe73..10726571007d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -42,6 +42,7 @@
 #include "dcn/dcn_3_2_0_sh_mask.h"
 
 #include "dcn32/dcn32_clk_mgr.h"
+#include "dml/dcn32/dcn32_fpu.h"
 
 #define DCN_BASE__INST0_SEG1                       0x000000C0
 
@@ -146,83 +147,9 @@ static void dcn32_init_single_clock(struct clk_mgr_internal *clk_mgr, PPCLK_e cl
 
 static void dcn32_build_wm_range_table(struct clk_mgr_internal *clk_mgr)
 {
-	/* defaults */
-	double pstate_latency_us = clk_mgr->base.ctx->dc->dml.soc.dram_clock_change_latency_us;
-	double fclk_change_latency_us = clk_mgr->base.ctx->dc->dml.soc.fclk_change_latency_us;
-	double sr_exit_time_us = clk_mgr->base.ctx->dc->dml.soc.sr_exit_time_us;
-	double sr_enter_plus_exit_time_us = clk_mgr->base.ctx->dc->dml.soc.sr_enter_plus_exit_time_us;
-	/* For min clocks use as reported by PM FW and report those as min */
-	uint16_t min_uclk_mhz			= clk_mgr->base.bw_params->clk_table.entries[0].memclk_mhz;
-	uint16_t min_dcfclk_mhz			= clk_mgr->base.bw_params->clk_table.entries[0].dcfclk_mhz;
-	uint16_t setb_min_uclk_mhz		= min_uclk_mhz;
-	uint16_t dcfclk_mhz_for_the_second_state = clk_mgr->base.ctx->dc->dml.soc.clock_limits[2].dcfclk_mhz;
-
-	/* For Set B ranges use min clocks state 2 when available, and report those to PM FW */
-	if (dcfclk_mhz_for_the_second_state)
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk = dcfclk_mhz_for_the_second_state;
-	else
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk = clk_mgr->base.bw_params->clk_table.entries[0].dcfclk_mhz;
-
-	if (clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz)
-		setb_min_uclk_mhz = clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz;
-
-	/* Set A - Normal - default values */
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].valid = true;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us = pstate_latency_us;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].dml_input.fclk_change_latency_us = fclk_change_latency_us;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us = sr_exit_time_us;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.wm_type = WATERMARKS_CLOCK_RANGE;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_dcfclk = 0xFFFF;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_uclk = min_uclk_mhz;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_uclk = 0xFFFF;
-
-	/* Set B - Performance - higher clocks, using DPM[2] DCFCLK and UCLK */
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].valid = true;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].dml_input.pstate_latency_us = pstate_latency_us;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].dml_input.fclk_change_latency_us = fclk_change_latency_us;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].dml_input.sr_exit_time_us = sr_exit_time_us;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.wm_type = WATERMARKS_CLOCK_RANGE;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.max_dcfclk = 0xFFFF;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_uclk = setb_min_uclk_mhz;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.max_uclk = 0xFFFF;
-
-	/* Set C - Dummy P-State - P-State latency set to "dummy p-state" value */
-	/* 'DalDummyClockChangeLatencyNs' registry key option set to 0x7FFFFFFF can be used to disable Set C for dummy p-state */
-	if (clk_mgr->base.ctx->dc->bb_overrides.dummy_clock_change_latency_ns != 0x7FFFFFFF) {
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].valid = true;
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.pstate_latency_us = 38;
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.fclk_change_latency_us = fclk_change_latency_us;
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us = sr_exit_time_us;
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.wm_type = WATERMARKS_DUMMY_PSTATE;
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.max_dcfclk = 0xFFFF;
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.min_uclk = min_uclk_mhz;
-		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.max_uclk = 0xFFFF;
-		clk_mgr->base.bw_params->dummy_pstate_table[0].dram_speed_mts = clk_mgr->base.bw_params->clk_table.entries[0].memclk_mhz * 16;
-		clk_mgr->base.bw_params->dummy_pstate_table[0].dummy_pstate_latency_us = 38;
-		clk_mgr->base.bw_params->dummy_pstate_table[1].dram_speed_mts = clk_mgr->base.bw_params->clk_table.entries[1].memclk_mhz * 16;
-		clk_mgr->base.bw_params->dummy_pstate_table[1].dummy_pstate_latency_us = 9;
-		clk_mgr->base.bw_params->dummy_pstate_table[2].dram_speed_mts = clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz * 16;
-		clk_mgr->base.bw_params->dummy_pstate_table[2].dummy_pstate_latency_us = 8;
-		clk_mgr->base.bw_params->dummy_pstate_table[3].dram_speed_mts = clk_mgr->base.bw_params->clk_table.entries[3].memclk_mhz * 16;
-		clk_mgr->base.bw_params->dummy_pstate_table[3].dummy_pstate_latency_us = 5;
-	}
-	/* Set D - MALL - SR enter and exit time specific to MALL, TBD after bringup or later phase for now use DRAM values / 2 */
-	/* For MALL DRAM clock change latency is N/A, for watermak calculations use lowest value dummy P state latency */
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].valid = true;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us = clk_mgr->base.bw_params->dummy_pstate_table[3].dummy_pstate_latency_us;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.fclk_change_latency_us = fclk_change_latency_us;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us = sr_exit_time_us; // TBD
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us; // TBD
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.wm_type = WATERMARKS_MALL;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_dcfclk = 0xFFFF;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_uclk = min_uclk_mhz;
-	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_uclk = 0xFFFF;
+	DC_FP_START();
+	dcn32_build_wm_range_table_fpu(clk_mgr);
+	DC_FP_END();
 }
 
 void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index c48688cdd7f7..01cb0ef3a2b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -72,6 +72,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_32.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/display_rq_dlg_calc_32.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_ccflags)
@@ -124,6 +125,7 @@ DML += dcn30/dcn30_fpu.o dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_3
 DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
 DML += dcn32/display_mode_vba_32.o dcn32/display_rq_dlg_calc_32.o dcn32/display_mode_vba_util_32.o
 DML += dcn31/dcn31_fpu.o
+DML += dcn32/dcn32_fpu.o
 DML += dcn301/dcn301_fpu.o
 DML += dcn302/dcn302_fpu.o
 DML += dcn303/dcn303_fpu.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
new file mode 100644
index 000000000000..89b596599c3d
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+#include "dcn32_fpu.h"
+
+// We need this includes for WATERMARKS_* defines
+#include "clk_mgr/dcn32/dcn32_smu13_driver_if.h"
+
+void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr)
+{
+	/* defaults */
+	double pstate_latency_us = clk_mgr->base.ctx->dc->dml.soc.dram_clock_change_latency_us;
+	double fclk_change_latency_us = clk_mgr->base.ctx->dc->dml.soc.fclk_change_latency_us;
+	double sr_exit_time_us = clk_mgr->base.ctx->dc->dml.soc.sr_exit_time_us;
+	double sr_enter_plus_exit_time_us = clk_mgr->base.ctx->dc->dml.soc.sr_enter_plus_exit_time_us;
+	/* For min clocks use as reported by PM FW and report those as min */
+	uint16_t min_uclk_mhz			= clk_mgr->base.bw_params->clk_table.entries[0].memclk_mhz;
+	uint16_t min_dcfclk_mhz			= clk_mgr->base.bw_params->clk_table.entries[0].dcfclk_mhz;
+	uint16_t setb_min_uclk_mhz		= min_uclk_mhz;
+	uint16_t dcfclk_mhz_for_the_second_state = clk_mgr->base.ctx->dc->dml.soc.clock_limits[2].dcfclk_mhz;
+
+	dc_assert_fp_enabled();
+
+	/* For Set B ranges use min clocks state 2 when available, and report those to PM FW */
+	if (dcfclk_mhz_for_the_second_state)
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk = dcfclk_mhz_for_the_second_state;
+	else
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_dcfclk = clk_mgr->base.bw_params->clk_table.entries[0].dcfclk_mhz;
+
+	if (clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz)
+		setb_min_uclk_mhz = clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz;
+
+	/* Set A - Normal - default values */
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].valid = true;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us = pstate_latency_us;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].dml_input.fclk_change_latency_us = fclk_change_latency_us;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].dml_input.sr_exit_time_us = sr_exit_time_us;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.wm_type = WATERMARKS_CLOCK_RANGE;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_dcfclk = 0xFFFF;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.min_uclk = min_uclk_mhz;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_A].pmfw_breakdown.max_uclk = 0xFFFF;
+
+	/* Set B - Performance - higher clocks, using DPM[2] DCFCLK and UCLK */
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].valid = true;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].dml_input.pstate_latency_us = pstate_latency_us;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].dml_input.fclk_change_latency_us = fclk_change_latency_us;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].dml_input.sr_exit_time_us = sr_exit_time_us;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.wm_type = WATERMARKS_CLOCK_RANGE;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.max_dcfclk = 0xFFFF;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.min_uclk = setb_min_uclk_mhz;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_B].pmfw_breakdown.max_uclk = 0xFFFF;
+
+	/* Set C - Dummy P-State - P-State latency set to "dummy p-state" value */
+	/* 'DalDummyClockChangeLatencyNs' registry key option set to 0x7FFFFFFF can be used to disable Set C for dummy p-state */
+	if (clk_mgr->base.ctx->dc->bb_overrides.dummy_clock_change_latency_ns != 0x7FFFFFFF) {
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].valid = true;
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.pstate_latency_us = 38;
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.fclk_change_latency_us = fclk_change_latency_us;
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.sr_exit_time_us = sr_exit_time_us;
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us;
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.wm_type = WATERMARKS_DUMMY_PSTATE;
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.max_dcfclk = 0xFFFF;
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.min_uclk = min_uclk_mhz;
+		clk_mgr->base.bw_params->wm_table.nv_entries[WM_C].pmfw_breakdown.max_uclk = 0xFFFF;
+		clk_mgr->base.bw_params->dummy_pstate_table[0].dram_speed_mts = clk_mgr->base.bw_params->clk_table.entries[0].memclk_mhz * 16;
+		clk_mgr->base.bw_params->dummy_pstate_table[0].dummy_pstate_latency_us = 38;
+		clk_mgr->base.bw_params->dummy_pstate_table[1].dram_speed_mts = clk_mgr->base.bw_params->clk_table.entries[1].memclk_mhz * 16;
+		clk_mgr->base.bw_params->dummy_pstate_table[1].dummy_pstate_latency_us = 9;
+		clk_mgr->base.bw_params->dummy_pstate_table[2].dram_speed_mts = clk_mgr->base.bw_params->clk_table.entries[2].memclk_mhz * 16;
+		clk_mgr->base.bw_params->dummy_pstate_table[2].dummy_pstate_latency_us = 8;
+		clk_mgr->base.bw_params->dummy_pstate_table[3].dram_speed_mts = clk_mgr->base.bw_params->clk_table.entries[3].memclk_mhz * 16;
+		clk_mgr->base.bw_params->dummy_pstate_table[3].dummy_pstate_latency_us = 5;
+	}
+	/* Set D - MALL - SR enter and exit time specific to MALL, TBD after bringup or later phase for now use DRAM values / 2 */
+	/* For MALL DRAM clock change latency is N/A, for watermak calculations use lowest value dummy P state latency */
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].valid = true;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.pstate_latency_us = clk_mgr->base.bw_params->dummy_pstate_table[3].dummy_pstate_latency_us;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.fclk_change_latency_us = fclk_change_latency_us;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_exit_time_us = sr_exit_time_us / 2; // TBD
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].dml_input.sr_enter_plus_exit_time_us = sr_enter_plus_exit_time_us / 2; // TBD
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.wm_type = WATERMARKS_MALL;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_dcfclk = min_dcfclk_mhz;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_dcfclk = 0xFFFF;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.min_uclk = min_uclk_mhz;
+	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_uclk = 0xFFFF;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
new file mode 100644
index 000000000000..72a6dd75af0e
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DCN32_FPU_H__
+#define __DCN32_FPU_H__
+
+#include "clk_mgr_internal.h"
+
+void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr);
+
+#endif
-- 
2.37.0

