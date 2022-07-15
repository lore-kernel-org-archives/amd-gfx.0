Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A98EC43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F220510E90D;
	Sat, 16 Jul 2022 14:36:01 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAB3D10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfJAUTruxe+/Fpar2cmPK80Py2N5GBGuFN0cBAqRjK9QIPkO04Q5LxxrskTEhvpbsDvmW0J3Jk13Y0zdkRNea95ON9cRBdR5H/2+7DeTWXqwKPTBWERefHNvzKSiTnZsG3lQ62+0k/FBwn7uyCarLRLOPhkAlPkRLeD4sbFaXMQwdsZDUh8EO779jqdivgCZx6OPGvowlEFxm3KJc0vOkyDUGX/GbNpWFyY7xtvkaHlRyGYWZtTGcIzJnys7KXapCl75MNFfSLcbLQnFH19XijpbcC59tPuaOBKuprPSZjpsrmkVYLK9OQK0DQA+EdGxkkA+ipnIoEbs9imbEC1yJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yz5dp4wTIocOqGS+SUaOYIBB1iUEAxYQi9WFI1J4CHE=;
 b=UON2nbIO2gnb6I/UBgJ9SnQZJkHBc/lgDG8qqG6tSKKBdXZnUDxI8dhWKFf7cGHEe4dDrbBOA6eVW8ptzrm0dad8sFRhNj4CrRrGeQpgEzzcDaKNfnwhbbWus9P6I1/jB2jbgZNo9I6Dbfi4nromrvemnIKXLwPRuuOLeBvECj8SxZJsL5wC+iLGUqF1/2MbVZj/whnSBoe4kPoUKVPQ/xRq8jxZTkt/U6u1iQ+Le63hV6tRrNd+MBGawPneOPzU6f0CZyfWBEmvoK5bdpnSvGI2jPs3PlPAhG+XkMff7IaYbgLOl31uEKLGG0Sdh4me2EBxsAKTkYIVOQqvIgFhCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yz5dp4wTIocOqGS+SUaOYIBB1iUEAxYQi9WFI1J4CHE=;
 b=G1m2BrLCBfzF9gSvnNgPpJ6CQDYsn5piNR+ZuSahNXoT8yYR+j+Y9kWsfZxhDJQpmZep9Xb3puN251A19s+uq50wMnlSYYlWiwQjIVt4S7EyG31Tjl1tgp0tWkWLCNdG6L5XCAFewzEvyX1Zm31oU0Pdv3OFxBbjDPp53KR6osw=
Received: from DM6PR05CA0065.namprd05.prod.outlook.com (2603:10b6:5:335::34)
 by BL0PR12MB2449.namprd12.prod.outlook.com (2603:10b6:207:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 18:17:50 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::ff) by DM6PR05CA0065.outlook.office365.com
 (2603:10b6:5:335::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.11 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:49 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:49 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:48 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 20/31] drm/amd/display: Move predict pipe to dml fpu folder
Date: Fri, 15 Jul 2022 14:16:54 -0400
Message-ID: <20220715181705.1030401-21-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a426d47a-820b-4a8d-b110-08da668e539c
X-MS-TrafficTypeDiagnostic: BL0PR12MB2449:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULfqsLkT2msphSEeHDdrUeQVdW0x78IaEEPTzSUgLMbBn3HMEJqlxEO3NVy+qz2DNOp5n1hF0K+pAq/Yj9x1RAk9/ECNVeMR3rq9Y0S3lQGbaEy8S8L4LN29WHLDpciHiEAI5d/rftHB10sTLc+bQaLQTuyWXNPXYr23K2Ihkx3bkWVzWtchI+zqGf0xbsNO1v9eeLimR9cUaopMlKfkZODzsePXoDLPK2RM/6mitLea0ugO2h2PCC3hG5OgUvPfeqaveCWq2WpAkP9PPKIaVjLoYjdyH0M8jHBrsiVSBuejVwIVKeTl7F9A5KR86efKQog91FXbgFa0iBKYkCpdG6Cf5TX+2sMjRwB1EjeSOu6sSBBNNkvUtLko2W1czfE5hpLvaS0QsKblYCqOOMYdsxtQotNQtqS4abOlyla4ApilFXKxQ9pZZPjqaJ+fTCC93ukVfPt950QmaLTqwkPSZikuFpQUmTa3eEnkohny65+uYT9b25H93L2dCIDsVH5f/we8kMWdhuf7g6OpkgaO2bncFIPBZPcizE3UJ5v9QmH6fLO4jhmj60hMEfpIR5nwOL8DwzrwBARjDTgD+2yXEkbJ3Wt42rf4OePR0V7q622CsqSOkIU6Fz7OXxpcZyb9LmCf7ArucRsnrknsnCRjMIedC6FqO2EALKyEJRLnE6UQtIgrrvWJ1KkKpjqojEhZKuUMbzgZ5n8aqocy7VsSSg8XDSmQXYLyj9H5qEU38/ymnFUzp+vCqsdbxGCo4Ej1GZuLNAGpjLRVQ6j6Dp52b894zGMeXcMMHQ/YlFEwhPm3VpExcXjjVZ9DccYjInDDBOScDbWpM4lxpb/SrqFOT5Pn0EnOVgPjIAUluoFHZOY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(40470700004)(5660300002)(41300700001)(36860700001)(40480700001)(36756003)(86362001)(6916009)(26005)(82740400003)(186003)(81166007)(54906003)(40460700003)(8936002)(2906002)(356005)(2616005)(426003)(8676002)(6666004)(478600001)(1076003)(336012)(47076005)(4326008)(316002)(83380400001)(70206006)(70586007)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:49.9576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a426d47a-820b-4a8d-b110-08da668e539c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2449
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

The function dcn32_predict_pipe_split uses FPU operations. This commit
moves this function to the dcn32_fpu file, and we ensure that we only
invoke it under the kernel_fpu protection.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  2 +
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  2 -
 .../display/dc/dcn32/dcn32_resource_helpers.c | 33 ----------------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 39 ++++++++++++++++++-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  4 ++
 5 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 411ce13847c2..a56d87140eba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -3054,7 +3054,9 @@ int dcn32_populate_dml_pipes_from_context(
 				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
 		}
 
+		DC_FP_START();
 		is_pipe_split_expected[i] = dcn32_predict_pipe_split(context, pipes[i].pipe, i);
+		DC_FP_END();
 
 		pipe_cnt++;
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 10254ab7e9d9..901aa7e13bd2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -100,8 +100,6 @@ bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 bool dcn32_subvp_in_use(struct dc *dc,
 		struct dc_state *context);
 
-bool dcn32_predict_pipe_split(struct dc_state *context, display_pipe_params_st pipe, int index);
-
 void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_params_st *pipes,
 		bool *is_pipe_split_expected, int pipe_cnt);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 633d3ee18cfa..796e3d966a76 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -153,39 +153,6 @@ bool dcn32_subvp_in_use(struct dc *dc,
 	return false;
 }
 
-bool dcn32_predict_pipe_split(struct dc_state *context, display_pipe_params_st pipe, int index)
-{
-	double pscl_throughput, pscl_throughput_chroma, dpp_clk_single_dpp, clock,
-		clk_frequency = 0.0, vco_speed = context->bw_ctx.dml.soc.dispclk_dppclk_vco_speed_mhz;
-
-	dml32_CalculateSinglePipeDPPCLKAndSCLThroughput(pipe.scale_ratio_depth.hscl_ratio,
-			pipe.scale_ratio_depth.hscl_ratio_c,
-			pipe.scale_ratio_depth.vscl_ratio,
-			pipe.scale_ratio_depth.vscl_ratio_c,
-			context->bw_ctx.dml.ip.max_dchub_pscl_bw_pix_per_clk,
-			context->bw_ctx.dml.ip.max_pscl_lb_bw_pix_per_clk,
-			pipe.dest.pixel_rate_mhz,
-			pipe.src.source_format,
-			pipe.scale_taps.htaps,
-			pipe.scale_taps.htaps_c,
-			pipe.scale_taps.vtaps,
-			pipe.scale_taps.vtaps_c,
-
-			/* Output */
-			&pscl_throughput, &pscl_throughput_chroma,
-			&dpp_clk_single_dpp);
-
-	clock = dpp_clk_single_dpp * (1 + context->bw_ctx.dml.soc.dcn_downspread_percent / 100);
-
-	if (clock > 0)
-		clk_frequency = vco_speed * 4.0 / ((int) (vco_speed * 4.0));
-
-	if (clk_frequency > context->bw_ctx.dml.soc.clock_limits[index].dppclk_mhz)
-		return true;
-	else
-		return false;
-}
-
 void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_params_st *pipes,
 		bool *is_pipe_split_expected, int pipe_cnt)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 253ff9659b0d..1b9e34f1232a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -24,7 +24,7 @@
  *
  */
 #include "dcn32_fpu.h"
-
+#include "display_mode_vba_util_32.h"
 // We need this includes for WATERMARKS_* defines
 #include "clk_mgr/dcn32/dcn32_smu13_driver_if.h"
 
@@ -154,3 +154,40 @@ void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
 	}
 }
 
+bool dcn32_predict_pipe_split(struct dc_state *context, display_pipe_params_st pipe, int index)
+{
+	double pscl_throughput;
+	double pscl_throughput_chroma;
+	double dpp_clk_single_dpp, clock;
+	double clk_frequency = 0.0;
+	double vco_speed = context->bw_ctx.dml.soc.dispclk_dppclk_vco_speed_mhz;
+
+	dc_assert_fp_enabled();
+
+	dml32_CalculateSinglePipeDPPCLKAndSCLThroughput(pipe.scale_ratio_depth.hscl_ratio,
+							pipe.scale_ratio_depth.hscl_ratio_c,
+							pipe.scale_ratio_depth.vscl_ratio,
+							pipe.scale_ratio_depth.vscl_ratio_c,
+							context->bw_ctx.dml.ip.max_dchub_pscl_bw_pix_per_clk,
+							context->bw_ctx.dml.ip.max_pscl_lb_bw_pix_per_clk,
+							pipe.dest.pixel_rate_mhz,
+							pipe.src.source_format,
+							pipe.scale_taps.htaps,
+							pipe.scale_taps.htaps_c,
+							pipe.scale_taps.vtaps,
+							pipe.scale_taps.vtaps_c,
+							/* Output */
+							&pscl_throughput, &pscl_throughput_chroma,
+							&dpp_clk_single_dpp);
+
+	clock = dpp_clk_single_dpp * (1 + context->bw_ctx.dml.soc.dcn_downspread_percent / 100);
+
+	if (clock > 0)
+		clk_frequency = vco_speed * 4.0 / ((int)(vco_speed * 4.0));
+
+	if (clk_frequency > context->bw_ctx.dml.soc.clock_limits[index].dppclk_mhz)
+		return true;
+	else
+		return false;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index 492f99b6d561..d5f157cdd0b4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -36,4 +36,8 @@ void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
 					      display_e2e_pipe_params_st *pipes,
 					      int pipe_cnt);
 
+bool dcn32_predict_pipe_split(struct dc_state *context,
+			      display_pipe_params_st pipe,
+			      int index);
+
 #endif
-- 
2.37.0

