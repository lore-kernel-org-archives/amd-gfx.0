Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9960DE7B5E1
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 09:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F43A10E358;
	Wed,  4 Oct 2023 09:24:28 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B8010E355
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 09:24:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4IvevJRGyryozj49A048JtEvO1N+LXNNu4Mk+3OzDHJ7aFj+1prNaF5n65gcO6Re5C6W56bzHabIuLjFMbQCsr8QejMS/0pCjWXgZzA7kFKEPVVVm/TF0iEOBIYYDeOkt+es4GBaQbPLQ+yscW9fO9sOY01YUtTDSmZFbPQYI917uLnO1Z5hZt/xx41R3Sg9uWLBZs9ammcmeLOnPzmJIb2ssbcNPy6WnjHWyjwrU0QNklw+udBU0MVTColxhPvFhpTfqImEZf7JPKZlnFaOUK4WBnPVcHqQ7LfEZH8me89kVpUuSf9PekJBziNNkPzNtkSIbh31jIeKlJbW46NBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLEvIUnx12yTCdfcsEB4MouGeslaTcdGRwvoxzd1T8Y=;
 b=FrOZoEoF/jZIvM8KGm+hcWV6Q9i0sfpR7mzJLusMmDKcPlF6ccFQR1aA+at6tWYzl015MOMmoHCj0mINKE7GM11JlqcgguJWMHDv9KeA1pNmsggYFxYYLxSdzI61xadwG7scUF+lgJNYD3iz6C79IG7vpKbK+INoYIt5wEHxpRTdPQiQ5RG6XrdtF9EyO6Jm/7IHEXw+Do7zMtCvEqcVUjzQbAjlx/gqWnkAYVHOjX/uin1z3xms4UKdSQGUU63kxMU9ANAi+II8gqI3BzBAb9kec6bgKsspZoJK3f5yWoNxnjoqGgZ+6X/G/lzUtTk3d0UJh2eGkAO1qVimHLKkAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLEvIUnx12yTCdfcsEB4MouGeslaTcdGRwvoxzd1T8Y=;
 b=gtmRqJQJ4niFd1IkndaVnn0cM96WJX47s6YntcXZVYbynZBPAD+HaCuscQZBQl0GrErSAerCBZlvmKfUaUrZaxvaKdcbrELqY4NOCsGHn4tgqPWxb7HiCddRVPgDwVDKeMNgPe96BbBFpZTpMn/kGs8AmMml0uhAri6GxftNKy0=
Received: from BL1PR13CA0392.namprd13.prod.outlook.com (2603:10b6:208:2c2::7)
 by BL0PR12MB4947.namprd12.prod.outlook.com (2603:10b6:208:17d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.28; Wed, 4 Oct
 2023 09:24:22 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::90) by BL1PR13CA0392.outlook.office365.com
 (2603:10b6:208:2c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 09:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 09:24:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 04:24:21 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 4 Oct 2023 04:24:15 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: Make DCN3x use older FPO sequence
Date: Wed, 4 Oct 2023 17:22:55 +0800
Message-ID: <20231004092301.2371458-11-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
References: <20231004092301.2371458-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|BL0PR12MB4947:EE_
X-MS-Office365-Filtering-Correlation-Id: 70356101-875f-48da-3661-08dbc4bbb1be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NoKHT3rt4GE9Y1syakHbfYB295bF9kneApy2TmNqe5bjbaZsREGMiVmxsbTeTofTUz2JNoCVTXQX+OS7d5QQjF5qOJStvof0gfPrCdRFLNbkPZAFZOLnaAiK/NJslPeYPZ8pvNDZ+tuCjwiWdCrlzoFYLSWiowui+klMgVdYdE8j1HYdtKkJlreUROy4hi4lklSn2XNYjF61udP0dPqI1CmjqjhnxkVOCbABo2RUrLDJ7L3fzLQARgPAC2RYjiiwiRd7MG9/S0pI3DSr6F10Z44YuU76XKZa1sOmJpJeOrNUQ6fU4gRqcVZkX2xK8TwWLYKAdviCuc/n3SefaURbPlPScJe3DxIDHboLIOiGXcWwJdaMyXB3ZFzUp0WG7znWK3jy6FRCi5gwWYBhIPM8iiC5P6Ek/KLd86aNxPzBKMb2JuPU+rKJcwgytng/iNug7zb2Z1FZgLGuR1jF1Dy5tSItYY+RU+cPeLdN8cbi2lVrIe6R/0aqRCUI4dzxo8TEwyy2kT8mQzZTHRdbFeyWbwYTfBtAOxE72Q0vfdkiaSxgNgVGP6J0l+dKkGLyEpInoXFD1uBzXcS57dFuRCv3ZhuiATJorn7Lf6AmuN4TP4TBERsIPoy9Fph3hLi4hJznCRFZ7tOS0mRTbHOD37JzWmr6f2wv+1b0zTH02e3Tv6wbjuiAjj/yua2IoWhGXi4s8/96unFivnj7oIp0gG6lKXClZImrlGJY+H78FhYoivF1SU4pcZw/4Wd+0sCknehfbf/REGAxH+E6LCZMXRn4AI+J+aJiRo0ay1xJ8KqHJjQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(46966006)(40470700004)(7696005)(2906002)(40460700003)(6666004)(2616005)(1076003)(70586007)(478600001)(86362001)(356005)(36860700001)(47076005)(336012)(81166007)(54906003)(83380400001)(426003)(6916009)(82740400003)(26005)(5660300002)(8936002)(36756003)(40480700001)(4326008)(8676002)(70206006)(41300700001)(316002)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:24:22.2549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70356101-875f-48da-3661-08dbc4bbb1be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4947
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
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com,
 Saaem Rizvi <syedsaaem.rizvi@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
Latest FPO sequence is causing intermittent hangs

[How]
Update the FPO sequence

Reviewed-by: Saaem Rizvi <syedsaaem.rizvi@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 21 -------------------
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 12 +++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  3 +++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +-
 4 files changed, 16 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index af9a9fc7db48..b6d88266e8ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -997,14 +997,6 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 void dcn30_prepare_bandwidth(struct dc *dc,
 	struct dc_state *context)
 {
-	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
-	/* Any transition into an FPO config should disable MCLK switching first to avoid
-	 * driver and FW P-State synchronization issues.
-	 */
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
-		dc->optimized_required = true;
-		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
-	}
 
 	if (dc->clk_mgr->dc_mode_softmax_enabled)
 		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
@@ -1012,20 +1004,7 @@ void dcn30_prepare_bandwidth(struct dc *dc,
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
 }
 
 void dcn30_set_static_screen_control(struct pipe_ctx **pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 45b557d8e089..67687e45f031 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -50,6 +50,7 @@
 #include "dce/dmub_hw_lock_mgr.h"
 #include "dcn32_resource.h"
 #include "link.h"
+#include "../dcn20/dcn20_hwseq.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -1676,3 +1677,14 @@ bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 
 	return is_seamless;
 }
+
+void dcn32_prepare_bandwidth(struct dc *dc,
+	struct dc_state *context)
+{
+	if (dc->clk_mgr->dc_mode_softmax_enabled)
+		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
+				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
+
+	dcn20_prepare_bandwidth(dc, context);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 9992e40acd21..cecf7f0f5671 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -124,4 +124,7 @@ bool dcn32_is_pipe_topology_transition_seamless(struct dc *dc,
 		const struct dc_state *cur_ctx,
 		const struct dc_state *new_ctx);
 
+void dcn32_prepare_bandwidth(struct dc *dc,
+	struct dc_state *context);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 6e7f6df1d423..04309412b087 100644
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
-- 
2.25.1

