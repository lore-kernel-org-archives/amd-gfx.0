Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7A60CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 13:34:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 814AB10E4F2;
	Thu, 19 Oct 2023 13:34:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2C210E4F0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 13:34:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fbhm5u22RJk6MLc44ni0nCY6BRrUbkl2oLEnMBQDUePvDW+JMXEhDS6XYnSTdr/yt3pyhlBJF5/UNECd5pwmgzo1qhz9zd9FlokXCHai1UbmnTdeuaFGQbB5yVtzDVTrTtca/LCMkozQktWqWkSh7/GLbXlQPlxCxngrPMXH1fMD3IliMTnkPGcCebdCd7cZEMRiOfl5qyyNrionjL3ZogSugq7pC2/oSgcx5x9f+j0pvyrSuowluVV4X3k1OzEEa4g490mo3eR82fL5QVzLFbXyjt6vie/+buTtp78l3sUPHdPjj4KopM79c3gzL1F5WbNOcUJcb7d+f1tD0bXpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu+BZHry+AxR+QBcYhVfbp7h+Fd62ENvnlhG8Pt9iNg=;
 b=FGPqizEWD5H1EnwcFTXpXJ9q/k1viroD7CHaDOh7oNcftQXUeDNTuaZdVN4eIuEvU/jBS6WqScbsfhI259g9tQcToe1CJbme+xtBro68vxyx+tV7JuMOhRZsMAROSoFuAzzv+tr15Ogoj7begZb16h9oxiXPJLK1bDOeejMTHaZW2DPv85nNuj3Q29vI4+b+K9yKouplp+4qtOdl7yuE9DYjgZGaizOI5WKY+X9Z7Hu/xnRkI+1mV1bhTrAQo3rY4jYZ+jB4CayRG85nOXIO8sKg5wvr2X0QXHk5Ir71noGd0g+hCozxHGgPIUfo7DeFMR4s5rXNy7XeqRtKHtN+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu+BZHry+AxR+QBcYhVfbp7h+Fd62ENvnlhG8Pt9iNg=;
 b=Y8FIzgR1LF43HdxLULy0XJs78Acv5iG88MCGi5Vx93utKqZS/RtoaOxJMSnyPGppLm3dJpeVzhmkA0k13pNeMURm9xrqVRco1cadlNQCPqbaFyNnZZiHRsjCVpUnVr4vUV5qIqQSH7PWA7DUJOESrtS/gbR1nhmMYoph95V6xAQ=
Received: from BYAPR02CA0028.namprd02.prod.outlook.com (2603:10b6:a02:ee::41)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Thu, 19 Oct
 2023 13:34:34 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::e8) by BYAPR02CA0028.outlook.office365.com
 (2603:10b6:a02:ee::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Thu, 19 Oct 2023 13:34:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.23 via Frontend Transport; Thu, 19 Oct 2023 13:34:34 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 08:34:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 06:34:18 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 08:34:18 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 18/24] drm/amd/display: Update FAMS sequence for DCN30 &
 DCN32
Date: Thu, 19 Oct 2023 09:32:16 -0400
Message-ID: <20231019133222.1633077-19-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133222.1633077-1-Roman.Li@amd.com>
References: <20231019133222.1633077-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: 365f538a-f3cf-4e63-2ce8-08dbd0a821d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5RofWDmmd+sf/khMkEnaOZnhvxr5v4UPJUV2U4Bn68RZpZesLiZ9bepZH2laFrnMTn7mWVk3HX41aXxcIZoWgcjDS2vHf/Xvtft7ZVD93kyg3ZJs8jVxBIV7vUn5eSdkcoMfeJAppiCb4/TAh74xv0zDazOtqIY9j9nVvox2w4jo3PAHagyOpvqpXJsu6WV6e6m+wR4maCg4icfxpe6Y6cQ9CI/z9M7J918JFkgUWI7hUrYGnR3XouIdgKpuiyW0FyabB3zqy+xCFCsQDuh6X6fSnxlX5kcm1tuQofTX90Y5cTQV46ilNGlgPeFo3g8NsPrw9ZxwB+4iBcMXjGXOJx2U/zCaOvckFCJsxAtd2Au22DBy1/abPBZRPMgG6G5TAc+hXT5tQj5DadLmx8iSJ0SufocE10YuHQmOYZT6GmCyy8ErbyH0Ae5WFiomNqiivGMZRM5gZXV84EMkMbeHYH8XSnPcR55KNF+PJqFpSwE1rUStfcLNIRvthDwcfGp06K/ty/Kz/YRWSSwOCuuaO5SrMrRkiQE50DO/nlOhJKAduOHIg7XUyrJlFP1Z+mpKHLBsKAvJkkXPTmWvyxoG7Vz97HJ4ThB8chEKxuf3Y0fp0JZNuGmrXEww5Vn6hHCJT77MpiFlRMLm08AWAfqX6ckSEBqvXu0JjKZxZWLdTnalms2J6oVnbO2rfq4Vt1Bx4rj3yYt9JkBwo8ilWDhopTELTwms2fUSTvjXG39C/rvh0vy1Po0Whj+HSRvGvjW5+OvSh8mNP7+J0X7GwRrWKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(230922051799003)(82310400011)(1800799009)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(478600001)(70206006)(70586007)(7696005)(6916009)(316002)(5660300002)(54906003)(40480700001)(82740400003)(47076005)(81166007)(356005)(83380400001)(36860700001)(426003)(2616005)(36756003)(1076003)(15650500001)(336012)(2876002)(2906002)(26005)(40460700003)(41300700001)(4326008)(8936002)(8676002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 13:34:34.2196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 365f538a-f3cf-4e63-2ce8-08dbd0a821d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Samson Tam <samson.tam@amd.com>,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

Provide DCN32 specific sequence and update DCN30 sequence

Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 21 ++-----------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 31 +++++++++++++++++++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  3 ++
 4 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 90f061edb64c..427cfc8c24a4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -60,7 +60,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
-	.prepare_bandwidth = dcn30_prepare_bandwidth,
+	.prepare_bandwidth = dcn32_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 9247a8ed5570..fd8a8c10a201 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -997,11 +997,7 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
 	struct dc_state *context)
 {
-	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
-	/* Any transition into an FPO config should disable MCLK switching first to avoid
-	 * driver and FW P-State synchronization issues.
-	 */
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && !dc->clk_mgr->clks.fw_based_mclk_switching) {
 		dc->optimized_required = true;
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 	}
@@ -1012,20 +1008,9 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
-	/*
-	 * enabled -> enabled: do not disable
-	 * enabled -> disabled: disable
-	 * disabled -> enabled: don't care
-	 * disabled -> disabled: don't care
-	 */
-	if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching)
-		dc_dmub_srv_p_state_delegate(dc, false, context);
 
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
-		/* After disabling P-State, restore the original value to ensure we get the correct P-State
-		 * on the next optimize. */
-		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
-	}
+	if (!dc->clk_mgr->clks.fw_based_mclk_switching)
+		dc_dmub_srv_p_state_delegate(dc, false, context);
 }
 
 void dcn30_set_static_screen_control(struct pipe_ctx **pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 2173d84e4953..e837554b8a28 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -50,6 +50,7 @@
 #include "dce/dmub_hw_lock_mgr.h"
 #include "dcn32/dcn32_resource.h"
 #include "link.h"
+#include "../dcn20/dcn20_hwseq.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1677,3 +1678,33 @@ bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 
 	return is_seamless;
 }
+
+void dcn32_prepare_bandwidth(struct dc *dc,
+	struct dc_state *context)
+{
+	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
+	/* Any transition into an FPO config should disable MCLK switching first to avoid
+	 * driver and FW P-State synchronization issues.
+	 */
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
+		dc->optimized_required = true;
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
+	}
+
+	if (dc->clk_mgr->dc_mode_softmax_enabled)
+		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
+				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
+
+	dcn20_prepare_bandwidth(dc, context);
+
+	if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching)
+		dc_dmub_srv_p_state_delegate(dc, false, context);
+
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
+		/* After disabling P-State, restore the original value to ensure we get the correct P-State
+		 * on the next optimize.
+		 */
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index 9992e40acd21..cecf7f0f5671 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -124,4 +124,7 @@ bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 		const struct dc_state *cur_ctx,
 		const struct dc_state *new_ctx);
 
+void dcn32_prepare_bandwidth(struct dc *dc,
+	struct dc_state *context);
+
 #endif /* __DC_HWSS_DCN32_H__ */
-- 
2.34.1

