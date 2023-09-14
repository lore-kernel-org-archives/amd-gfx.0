Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381FBEE0203
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:02:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EBF10E4E3;
	Thu, 14 Sep 2023 02:02:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440D310E4E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:02:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcHidBLaKY7NELPPacLq7dUsduT7v7b/w2xIMJmcEKaLW9mHN1Qy6HqCCKiOadCItzb7Qn9U0mas8uZBPN3gYnr0Z0s0s0u7UeBw5TmgGd6xGSEVeBDzs3VvCAhm4V0LRnytTxl55NRsWHTw7jT+QY0jMHhihusQ8kT6eftjWHbhCkK1TIaJNGmN6xvL1Z7y6LnudygwzrNtjxFDZmXnU2TQrD3rWh4KH1RrlC5B8JtymV756o/LOixUU/poSUS1OHQbug+Sz4hyizWAiifcRFYAFpMOxht2WY4QrLSQ2vpMA99j54k3jMeJ22DL7KzzkL4jRGLBaLZm7hH43kSxbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwtvZAm43bu83Fcld/feQH7sS9ORyvDMynl3tFP7F/U=;
 b=Jq+xCAty4sukw6OUZcm6/AOUmv5jua7CsTLbwC9IgaLt2D7JtZIAfU+EZ6y3ztCe3SZEK+ivsewTNP13Pn9OIFHeBAyDGBFacZD3vALKvaVM0yrLkL+TFpcy8WkV/tZCpi7dfG9BMHTclLeS+74S/boPQd00obgpFXcVohD3mTTDRzeQWwXQFxM8Yvh0/a9ygwdZlx53aaU1J3Z1yBy5o7WsspHs62VollwkxDAeZGZwWI06mILo+Z+hmZCvwiZItKYGwIMrQ9M1WnoGA3E3wNBgHwfdHyRqxZ8MvmE0qdbzOf9eAq8paS3vWyaSAM/LZfPI/cS/J3hqploykHkEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwtvZAm43bu83Fcld/feQH7sS9ORyvDMynl3tFP7F/U=;
 b=VX93SBbnwOWoFRXFcehyP0rQG4bpL7e8GX49z/0gOY2y4IQpnc90NGJHOcGrraj2nV5ao2Nbs3/0+zUoGAmuRwrZr+nXiJMAIa2Cjrx4yh2DZDsoxOFwmmWYbGl6/S4zqy3sXqFUmbOPLHYMVkEi55xGciCRuST8A2N34/DoDNo=
Received: from SA0PR11CA0069.namprd11.prod.outlook.com (2603:10b6:806:d2::14)
 by DS0PR12MB7560.namprd12.prod.outlook.com (2603:10b6:8:133::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Thu, 14 Sep
 2023 02:02:17 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:d2:cafe::4) by SA0PR11CA0069.outlook.office365.com
 (2603:10b6:806:d2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:02:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 02:02:17 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:02:06 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 25/28] drm/amd/display: Expand DML to better support replay
Date: Wed, 13 Sep 2023 20:00:18 -0600
Message-ID: <20230914020021.2890026-26-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|DS0PR12MB7560:EE_
X-MS-Office365-Filtering-Correlation-Id: 238eb0a7-0765-4cd2-f4c9-08dbb4c69f62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3JxAPRbZsLtcEocpPg38A6ojZ0cq+/x6IZKwJthbUiXnl7ZmHyMaTlrj85FbBfQzjsSjNttQdPDjxHrBuH00uwOIkFTkzWOAP8rxEN0MYzdwULa1gyxPNk1LNcsjWbWxfdLESLoJQshzAO2w1qjNYvxQT9KRnSLDPxheKlLia/pivBJC91mbc5jP1AN6QTMhQwzcJiLfBwJQcnZcknQKwUuj1PYDy275Ob7ZsnSW10ED8f+HiKDALJMEEYLKNT4XXEQ81DZXC4pjkrcbotk8JBHQIQgKc+lcxfLCrPpu+1aYCLLNjL1caD8Nkpb9VJBju0z8PYb2FrQMmPfMtMibTO9f8809sbtQd2AI3q87N/SNr7TZN0h1H39NScm76+HTdhNKSbqzUfbWbyfE8tOj0tPY4gRixYDKQemULaDpIxUAgKlbnUb4I9rYXcIS9Oinuwbxk5VS7m24kkr0pthQ/wtDRL2jUc2WCJ4FFXevFyC13lwNgwwUhXk6dMNd4iY/hMgO1zVmKx4Z9A9wlneHaLWPL2moto40KQO1YW/xUJA+KfJne0lt4kQ2Xc6MPfqGaWNO2oDO1fRio/sHZ/vIFcZAf2Z9WooiGoK+/91utgGtR7n52wcuyGaEz41BjJxsyCQseOjd9InhcJD1aVzpAmeFCqU+YoAMLOB6nUnAQKYl5V2YvQU4YCww1riYlpe5f9V9dQp1g/u9+7Hmg//jCE+6My/0Dy1njtUivDbQ8FaufIK+GQqHidhR4Tt2+9u3gaKKCqMn1FTsDr7SIwsVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(82310400011)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(36860700001)(83380400001)(70586007)(47076005)(336012)(478600001)(6666004)(356005)(36756003)(426003)(86362001)(16526019)(2616005)(1076003)(82740400003)(81166007)(26005)(6916009)(316002)(40480700001)(2906002)(54906003)(70206006)(5660300002)(8676002)(8936002)(41300700001)(4326008)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:02:17.3018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 238eb0a7-0765-4cd2-f4c9-08dbb4c69f62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7560
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

Update with extended blank Vstartup adjustment for replay.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 46eb2d0592f3..4d5ee2aad9e4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -29,6 +29,7 @@
 #include "dcn32/dcn32_resource.h"
 #include "dcn35/dcn35_resource.h"
 #include "dml/dcn31/dcn31_fpu.h"
+#include "dml/dml_inline_defs.h"
 
 #include "link.h"
 
@@ -358,6 +359,36 @@ static bool is_dual_plane(enum surface_pixel_format format)
 		format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
 }
 
+/*
+ * micro_sec_to_vert_lines () - converts time to number of vertical lines for a given timing
+ *
+ * @param: num_us: number of microseconds
+ * @return: number of vertical lines. If exact number of vertical lines is not found then
+ *          it will round up to next number of lines to guarantee num_us
+ */
+static unsigned int micro_sec_to_vert_lines(unsigned int num_us, struct dc_crtc_timing *timing)
+{
+	unsigned int num_lines = 0;
+	unsigned int lines_time_in_ns = 1000.0 *
+			(((float)timing->h_total * 1000.0) /
+			 ((float)timing->pix_clk_100hz / 10.0));
+
+	num_lines = dml_ceil(1000.0 * num_us / lines_time_in_ns, 1.0);
+
+	return num_lines;
+}
+
+static unsigned int get_vertical_back_porch(struct dc_crtc_timing *timing)
+{
+	unsigned int v_active = 0, v_blank = 0, v_back_porch = 0;
+
+	v_active = timing->v_border_top + timing->v_addressable + timing->v_border_bottom;
+	v_blank = timing->v_total - v_active;
+	v_back_porch = v_blank - timing->v_front_porch - timing->v_sync_width;
+
+	return v_back_porch;
+}
+
 int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
 					      struct dc_state *context,
 					      display_e2e_pipe_params_st *pipes,
@@ -367,12 +398,15 @@ int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool upscaled = false;
+	const unsigned int max_allowed_vblank_nom = 1023;
 
 	dcn31_populate_dml_pipes_from_context(dc, context, pipes,
 					      fast_validate);
 
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 		struct dc_crtc_timing *timing;
+		unsigned int num_lines = 0;
+		unsigned int v_back_porch = 0;
 
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
@@ -380,6 +414,9 @@ int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
+		num_lines = micro_sec_to_vert_lines(dcn3_5_ip.VBlankNomDefaultUS, timing);
+		v_back_porch  = get_vertical_back_porch(timing);
+
 		if (pipe->stream->adjust.v_total_max ==
 		    pipe->stream->adjust.v_total_min &&
 		    pipe->stream->adjust.v_total_min > timing->v_total) {
@@ -389,6 +426,16 @@ int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
 				pipes[pipe_cnt].pipe.dest.vactive;
 		}
 
+		pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, num_lines);
+		// vblank_nom should not smaller than (VSync (timing->v_sync_width + v_back_porch) + 2)
+		// + 2 is because
+		// 1 -> VStartup_start should be 1 line before VSync
+		// 1 -> always reserve 1 line between start of vblank to vstartup signal
+		pipes[pipe_cnt].pipe.dest.vblank_nom =
+			max(pipes[pipe_cnt].pipe.dest.vblank_nom, timing->v_sync_width + v_back_porch + 2);
+		pipes[pipe_cnt].pipe.dest.vblank_nom = min(pipes[pipe_cnt].pipe.dest.vblank_nom, max_allowed_vblank_nom);
+
 		if (pipe->plane_state &&
 		    (pipe->plane_state->src_rect.height <
 		     pipe->plane_state->dst_rect.height ||
-- 
2.40.1

