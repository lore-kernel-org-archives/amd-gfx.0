Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F06C433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8747E10E58B;
	Wed,  9 Nov 2022 06:17:59 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EF4310E58B
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUR9JFhICYPFNB/6ffwVTPDhDZbO9bS2NYpyRDog/ECD6CYdAI7oPlxDgAGmP7ia7t4vatDAt2raKdq/+JV7CdyRz4WQNKG/w+rmm1F1M92V8Qk6vNb4xS7zy+fKgblUhJ/AnXihphTuAUuIWLHou62qk39lBRNCYoq/TZjKyqwS1uakL7mGqH7SIWjMP5pxPPbjai9YtHgfwW6GMI2x/zP9b+StJLV4aLJGGzObUtUmDMluA8nqq5THBkUtDQjCLMkYlvEyrEWv3yRTNbDhCsg9Oqry/AIHbupvDdgAFKHGLyZNP0DUGz6C7G0RcJ48yrJw1EoNl4CMcIsWdK9hgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WtR8NAF7yqodloXEO7VVdn1XT8RmC2bfZ8rpKKfbYc=;
 b=jXZ980/w/HJrr51gtMe9f1/X08L3THduHwjbZT7sO5dE7W1HO6j23TlVNQEwvtMiNX8seNemBZgHE5oRewLU1CUWYMRdKcayqqd6Xtpf+up9GRa3F9GnuHWkuGCboJyZAQK9uHZlsFtU1lxDwONmCipwbJDcHUFpr3WVO2XwGLEHWUf4tdqoFg8R3CK7VL2Pe9C2FHSomk1sHA0SAtcV8tinxlZN0NiPVwnsuuCZhdIxWbJM80LupcvTfRTy9sFFm4OtQIzNmqj+jvULbLHFGmH2y6Ct1O5JIepJBKAR9Hy24klqf9OEwpZKN/KvxqVAW+YWrtxLxDPdeeMCrGNu6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WtR8NAF7yqodloXEO7VVdn1XT8RmC2bfZ8rpKKfbYc=;
 b=1ozeAlp6IStFNnXziluRYflZU4sega+5Yhq+cQZntfXd7lSEY+YP80dgptQYVKEbUjBNkKxUOm8JX5LbmUjnqAmxbjCLJeEIHcG3/2mqiq4G1DWWcYVHKQnAQ8u9xsm1/V7mw62vaiyRutQ+J3Gt5KVhevdkPKgc2+uKmNmGSPM=
Received: from MW4PR04CA0132.namprd04.prod.outlook.com (2603:10b6:303:84::17)
 by DS0PR12MB6582.namprd12.prod.outlook.com (2603:10b6:8:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 06:17:51 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::2f) by MW4PR04CA0132.outlook.office365.com
 (2603:10b6:303:84::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Wed, 9 Nov 2022 06:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:17:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:17:49 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:17:47 -0600
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:17:42 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/29] drm/amd/display: use uclk pstate latency for fw
 assisted mclk validation dcn32
Date: Wed, 9 Nov 2022 14:13:14 +0800
Message-ID: <20221109061319.2870943-25-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT036:EE_|DS0PR12MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dff4970-200f-45a0-db39-08dac21a2193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5jkrn8vXNkVq/WiPhhbKcJ9bkvm1bZEDqwKkKrCUeN/WM2xPHGhwDzBeXb+K+WpHxQu3CSuZo0A1v+ViTLlv27QmaOtou4WgQU+70ev9dQTnCZLMGIea8KrLqgrb5yd0TO+apeapfe1JB8Kzdncf58NJEookoJFQGDJXwxxnspUfzzjCwof6nNOwhm3voU8b3aM2PPfbXOUqKutKy7hhN5JQghQJKu5f3R97D6bBrmP3VouehlFHwHUJmcHGxP7m3dw3g/9bhj96Z3Wh2WFpduknWeNqv+04Uy8BEyJ4qfU5g3LGcXcfhIke5gzoLUcFCUVxlUv5ruB3DH8/opf+tPWk8pLoGRMnfAvNSFzwrdKbtAaF4j2hX5pFg1gDavAZXlhVRim+QH+9Mr4ULIhXtfqHUBvOAEkAeWbF7onSXvbNDCZvHNwEeMXRPG1Hbw65l2YnCx07LrpAJ5H4EFRzk/KtfnIaZggSJXBdKHToArAkiID6uppgjijQpTV/kqZHF/5ErnyP7FAWO0XMd/2VW7YWh19CIct2vuI5bP8RX/PP+Uw/IegWImuKO2EE5GaKAarvlF3F4lYr3jJi/ckJyeJtDO1+T9ENh0XSEaiRgDfJ1wz7QW7O8GNtBskjpuVJx9FvpN+F56UBpv+ui8F3DBtPmiIvZp1rAwGG0UGhUQziU1d20CJN5TxjKmjZM4ULLzIjlQWzoGZW7UKsmYWc4g8l3+vpEEDA96aZ3JFOOZZEsKpKBdnusBEI3WfMSCQeVJkCpPy0LcOoFtgZ5fghiwzsMITPF7fVYRp7DCl4j8g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(40470700004)(36840700001)(46966006)(81166007)(36756003)(86362001)(82740400003)(426003)(26005)(40460700003)(8936002)(40480700001)(2906002)(47076005)(6666004)(1076003)(186003)(7696005)(83380400001)(2616005)(356005)(336012)(6916009)(36860700001)(5660300002)(41300700001)(82310400005)(70586007)(316002)(54906003)(4326008)(478600001)(70206006)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:17:51.2747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dff4970-200f-45a0-db39-08dac21a2193
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6582
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
Cc: stylon.wang@amd.com, Dillon Varone <Dillon.Varone@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
DCN32 uses fclk pstate watermarks for dummy pstate, and must always be
supported.

[HOW?]
Validation needs to be run with fclk pstate latency set
as the dummy pstate latency to get correct prefetch and bandwidth outputs.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 51b4b1d0ba99..97b333b230d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1844,6 +1844,12 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 			 */
 			context->bw_ctx.dml.soc.dram_clock_change_latency_us =
 					dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
+			/* For DCN32/321 need to validate with fclk pstate change latency equal to dummy so
+			 * prefetch is scheduled correctly to account for dummy pstate.
+			 */
+			if (dummy_latency_index == 0)
+				context->bw_ctx.dml.soc.fclk_change_latency_us =
+						dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
 			dcn32_internal_validate_bw(dc, context, pipes, &pipe_cnt, &vlevel, false);
 			maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 			dcfclk_from_fw_based_mclk_switching = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
@@ -2031,6 +2037,10 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 
 	context->perf_params.stutter_period_us = context->bw_ctx.dml.vba.StutterPeriod;
 
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && dummy_latency_index == 0)
+		context->bw_ctx.dml.soc.fclk_change_latency_us =
+				dc->clk_mgr->bw_params->dummy_pstate_table[dummy_latency_index].dummy_pstate_latency_us;
+
 	dcn32_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
 
 	if (!pstate_en)
@@ -2038,8 +2048,12 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
 				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching)
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
 		dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(dc, context);
+		if (dummy_latency_index == 0)
+			context->bw_ctx.dml.soc.fclk_change_latency_us =
+					dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.fclk_change_latency_us;
+	}
 }
 
 static void dcn32_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
-- 
2.25.1

