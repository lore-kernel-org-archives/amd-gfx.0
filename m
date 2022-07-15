Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4665C433EF
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:40:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51C8C10EB99;
	Sat, 16 Jul 2022 14:36:10 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DBB10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOkuL6ZT5IJgCHrHYZ+1ztY6WCEcE64tImCyjM847J/rycMcfzzEKlDZ1grxMhfQhuio57odwDPwt+Ql4yINpLZycckjVj8BVMkcUxeShHRO6Eku8ILRfhLCfBNXhXZHKoQehZkb8a7x6W6DrvFLxCB9DOMhLwFEAbuZkTfZhiwFioBEE8Zin9tV3gjjW92AQR1iwpborgg9UJmFvZ2z/6chIo9j8eReenLfv+SZ2VRDRRZbRb3PMd3g+3kAeQ5OcaE3l5QiwFhNTFOD176sz8PKoknWU78GcoLG4exInrfvTp6vMRL8JdX4pYTaQYIDCdROK2/dd/MXG5Hdbflg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOg48YDJXIYkAVkCdz7mqdHfqeJuJa7Lds8ANq18oH0=;
 b=aloK1Dq5JtGJBHFfpwf9w7nBTVBPpWrzDAX8QDaifexCQMUskWBVXs/NhGrm8pHZt5y4n1l3PMiEbh5ZVEzfD4dRZ/dDYDyizsgODRY4A2OnW4Aa2H+Jk8yp7fctzYflxpT4v9A/rfP0zGb85Q4EarN4s4tp/G205y+g3UMfzvM3Ygu2Xcf6FWaBqr6MqW8B8qEF7zjixrxEHIfCNZmp/rdjIiJf/X/atd1k9EOq3nAkdjxFlk3AtmMn4CGmXZpZUFk09Qx3nuJ6Ggkno7K6rDY5cXBiiloCBWd02Izu4bj0wA+TeP0k3qn/BS0CCXWWxKCjxf4WfeloQO9h+C2v9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOg48YDJXIYkAVkCdz7mqdHfqeJuJa7Lds8ANq18oH0=;
 b=1MB6U6ijahVVRBm37zYgU6eroLsKL+J0q2Si1mdlLSdGw+zxK2tipXWcJ0yhCc93dsyjFak154Rga+MRwKgjGGubQAwEqnZJO3hiaWBvtge0pCgy/SqXqOb7ihR1ryopBIYi96bSLfJiFXugYzDAkGUaPQYz5qr0byK7oIHVOKE=
Received: from MW4PR04CA0254.namprd04.prod.outlook.com (2603:10b6:303:88::19)
 by DM5PR12MB1804.namprd12.prod.outlook.com (2603:10b6:3:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 15 Jul
 2022 18:17:49 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::c6) by MW4PR04CA0254.outlook.office365.com
 (2603:10b6:303:88::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:49 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:48 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:47 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/31] drm/amd/display: Move populate phaton function to dml
Date: Fri, 15 Jul 2022 14:16:53 -0400
Message-ID: <20220715181705.1030401-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e333dd2b-afd7-4d75-3584-08da668e533e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1804:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+GBIDLN0jBYgaJnyKCt+Pdgj1MXDdNcvBxDIy/qFI+vfPWE6NnvQAGu1ca7MTWdfB99u8ApwUodulhpQJ657iZu19EBFoE41O7YYud/rAMmuyHvnp0f3xm+/x0dJtakxB9QM5JsMWmoYgr984FQ2jJIZsKCci0fWkv/imIR5U4iUWMcKFEOy4yUCbqDLzG6Ao3CzsJGFh5YUO/XNBkx6rQRHJgCXJtIb6ZIuP5PydP/iy4qlBlJshpMVPXSbK399/moSIkPCm1WdFnBORosjxdsROLoehPnzJfkjTGc/rSWXHoHOkmKUlmJdRToTrH40bRJlgsnzkiufT61Wos2tsPtBPr9krtrA5sMxOzeclBjsy4YW9CtGqKJOVH3epSZwRDrO7jLzIiTKcuTgE5aff7yI4e6eOpzohV3yZ6w8DH21V0+6VhPYotJ2MVfOkRS7Ho4i9nD+2GtNS58eajnaM3LB0U+2jr1UQk5Bmsr6mZdvkGcTS+rAQMrXVYpVY8Jqd+v8IB1C1uW0oaiuL8B6AZXHBNi0R4zaRQeI0VX7RqkrjaJJ1Ec9PXIsxzvOs2NBDr5RAwLP5TRhGfWkumpZhj59uX0pFkn6yj/k+2l/jwGsWEmwIcCQY9CrENnP8oHGs+Ij7fP/kVr4/1J8qXZ1jj45wnbWtkJImxVR3YNuIteBus2vwWohp6lWq61+He06ZM5GIBortEF5a92lt8x8QPRYR1IdCwmBZ4lHXVL8/oeWeFc6j5H3kdTHGthevbMdTzkbu9K6xcRv5oIQk5HwKyrcH8ufIHQlPrI36Vo885C9R9pREo1S6BRcAbjRY7HAE6WATIYlWyddZWmH1KIXdlAUyPe/xgU3r01E1BWCF4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966006)(36840700001)(40470700004)(2906002)(36756003)(316002)(82310400005)(40480700001)(5660300002)(4326008)(8936002)(8676002)(6916009)(70206006)(40460700003)(54906003)(86362001)(70586007)(2616005)(356005)(47076005)(478600001)(41300700001)(6666004)(1076003)(186003)(83380400001)(81166007)(336012)(36860700001)(26005)(82740400003)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:49.2446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e333dd2b-afd7-4d75-3584-08da668e533e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1804
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

The function dcn32_helper_populate_phantom_dlg_params uses FPU
operations. For this reason, this commit moves this function to the
dcn32_fpu file, and we ensure that we only invoke it under the
kernel_fpu protection.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  7 +++
 .../display/dc/dcn32/dcn32_resource_helpers.c | 44 -------------------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 43 ++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  5 +++
 4 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 39214a0dcdf2..411ce13847c2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -88,6 +88,7 @@
 #include "dml/dcn30/display_mode_vba_30.h"
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
+#include "dml/dcn32/dcn32_fpu.h"
 
 #define DCN_BASE__INST0_SEG1                       0x000000C0
 #define DCN_BASE__INST0_SEG2                       0x000034C0
@@ -312,6 +313,7 @@ enum dcn32_clk_src_array_id {
 		.reg_name = NBIO_BASE(regBIF_BX0_ ## reg_name ## _BASE_IDX) + \
 					regBIF_BX0_ ## reg_name
 
+#undef CTX
 #define CTX ctx
 #define REG(reg_name) \
 	(DCN_BASE.instance[0].segment[reg ## reg_name ## _BASE_IDX] + reg ## reg_name)
@@ -2667,6 +2669,11 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 			memset(merge, 0, MAX_PIPES * sizeof(bool));
 			*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
 
+			// Most populate phantom DLG params before programming hardware / timing for phantom pipe
+			DC_FP_START();
+			dcn32_helper_populate_phantom_dlg_params(dc, context, pipes, *pipe_cnt);
+			DC_FP_END();
+
 			// Note: We can't apply the phantom pipes to hardware at this time. We have to wait
 			// until driver has acquired the DMCUB lock to do it safely.
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index a6ef1dba01fe..633d3ee18cfa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -28,50 +28,6 @@
 #include "dcn20/dcn20_resource.h"
 #include "dml/dcn32/display_mode_vba_util_32.h"
 
-/**
- * ********************************************************************************************
- * dcn32_helper_populate_phantom_dlg_params: Get DLG params for phantom pipes and populate pipe_ctx
- * with those params.
- *
- * This function must be called AFTER the phantom pipes are added to context and run through DML
- * (so that the DLG params for the phantom pipes can be populated), and BEFORE we program the
- * timing for the phantom pipes.
- *
- * @param [in] dc: current dc state
- * @param [in] context: new dc state
- * @param [in] pipes: DML pipe params array
- * @param [in] pipe_cnt: DML pipe count
- *
- * @return: void
- *
- * ********************************************************************************************
- */
-void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
-		struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt)
-{
-	uint32_t i, pipe_idx;
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		if (!pipe->stream)
-			continue;
-
-		if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
-			pipes[pipe_idx].pipe.dest.vstartup_start = get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt,
-					pipe_idx);
-			pipes[pipe_idx].pipe.dest.vupdate_offset = get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt,
-					pipe_idx);
-			pipes[pipe_idx].pipe.dest.vupdate_width = get_vupdate_width(&context->bw_ctx.dml, pipes, pipe_cnt,
-					pipe_idx);
-			pipes[pipe_idx].pipe.dest.vready_offset = get_vready_offset(&context->bw_ctx.dml, pipes, pipe_cnt,
-					pipe_idx);
-			pipe->pipe_dlg_param = pipes[pipe_idx].pipe.dest;
-		}
-		pipe_idx++;
-	}
-}
-
 /**
  * ********************************************************************************************
  * dcn32_helper_calculate_num_ways_for_subvp: Calculate number of ways needed for SubVP
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 89b596599c3d..253ff9659b0d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -111,3 +111,46 @@ void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr)
 	clk_mgr->base.bw_params->wm_table.nv_entries[WM_D].pmfw_breakdown.max_uclk = 0xFFFF;
 }
 
+/**
+ * dcn32_helper_populate_phantom_dlg_params - Get DLG params for phantom pipes
+ * and populate pipe_ctx with those params.
+ *
+ * This function must be called AFTER the phantom pipes are added to context
+ * and run through DML (so that the DLG params for the phantom pipes can be
+ * populated), and BEFORE we program the timing for the phantom pipes.
+ *
+ * @dc: [in] current dc state
+ * @context: [in] new dc state
+ * @pipes: [in] DML pipe params array
+ * @pipe_cnt: [in] DML pipe count
+ */
+void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
+					      struct dc_state *context,
+					      display_e2e_pipe_params_st *pipes,
+					      int pipe_cnt)
+{
+	uint32_t i, pipe_idx;
+
+	dc_assert_fp_enabled();
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		if (pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			pipes[pipe_idx].pipe.dest.vstartup_start =
+				get_vstartup(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+			pipes[pipe_idx].pipe.dest.vupdate_offset =
+				get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+			pipes[pipe_idx].pipe.dest.vupdate_width =
+				get_vupdate_width(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+			pipes[pipe_idx].pipe.dest.vready_offset =
+				get_vready_offset(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+			pipe->pipe_dlg_param = pipes[pipe_idx].pipe.dest;
+		}
+		pipe_idx++;
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index 72a6dd75af0e..492f99b6d561 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -31,4 +31,9 @@
 
 void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr);
 
+void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
+					      struct dc_state *context,
+					      display_e2e_pipe_params_st *pipes,
+					      int pipe_cnt);
+
 #endif
-- 
2.37.0

