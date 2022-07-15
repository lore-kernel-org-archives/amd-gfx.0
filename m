Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A27EC43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DD010F734;
	Sat, 16 Jul 2022 14:35:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2069.outbound.protection.outlook.com [40.107.243.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331C610E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ie/vdtaWllR8pfdKqCOEVXMdH0ATX5CCj5mKkHoWAz10v6QAzMjUn0XslHNIKR4LKJEiTBEPfAxJ1SgwRLKXbwUM/zk64TfJk1HU24JkAoyGHmtU4yyBvAlj+eyE6ge/l1jj5XRbxbZ/gHJoXzhVLgfj7sK17p2HVhzGxeqIvP63WW6VjX/ZHPCrbl+miG7oD8FcAy9w0ZrquAaqTUt7Lf5MujVmdv4wjwwYEAt1rdVYzpb0N8ZRodc+qOllfMsxVUpEdgYGDf045xLCU22ZgLs8zgIcmfjw+G7lp3yrSObwvD9va/LC5zonKjqoIgIQrBEdfZgc/6x9gSFX2OdQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/51cKmCIrHW9iTIhGogzr1byQsa4GyF/A9nwikL4V1A=;
 b=JdVGTyvW2g5KSAXWey7sB7H1xEpn0ldBB3bHlVj2yc0ZMpZoRoqIXgIcR702wrW3Ch/yaFvkc8Dzram3oBlCUvoUXxOT6P64wkSRMuTMwogiLDp7tlb1CVntblBrhrEtZ54XjZdo0B18yBQAobU6P1ryA1SjURXIRvMmVTQRRU5PfgDuXoaOw/gKs4xAqYZrDfBCsc4DtR2lhUcs02e3gR1wCynsKKDOYYbjVTcP+Cmw9TRHPrTXKtJS6MIuq1dtlM8uYigjKOufM2pOU5iv5bZmJmpFKq9xnVPcLdw3x/DY1l+pOn7P83U/Ud/r6pyZSK/0v3VE87vFROhVf6L3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/51cKmCIrHW9iTIhGogzr1byQsa4GyF/A9nwikL4V1A=;
 b=tOZBXxzT0exUtbLqUEB9/XNptV8cfjM7e568ZFwm1Qr3zSXP4u1CZOhwYedNmjFoHRbXbszKWWtVsDN9I9ijV5tFRgpwJJkpXFfrqerPgRQDRgL/z3col8jVw0HCe7Wjx4EJDCy2dqHfjQUlS9hEWg1RhHtXkyVz2mF9+cYAHvk=
Received: from MW4PR04CA0242.namprd04.prod.outlook.com (2603:10b6:303:88::7)
 by DM6PR12MB3468.namprd12.prod.outlook.com (2603:10b6:5:38::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Fri, 15 Jul
 2022 18:17:47 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::46) by MW4PR04CA0242.outlook.office365.com
 (2603:10b6:303:88::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:46 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:46 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:45 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 17/31] drm/amd/display: Update DML logic for unbounded req
 handling
Date: Fri, 15 Jul 2022 14:16:51 -0400
Message-ID: <20220715181705.1030401-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34caf47e-3dbc-4fdf-35cf-08da668e5214
X-MS-TrafficTypeDiagnostic: DM6PR12MB3468:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gpa7UBmeWMxk8d8cfGRQBQwtoMyHawgVJ9ZFTo6uU8l4SmIqIxjjK5xLdgJMCmIGxrOd0dU3N6/lysc8grwp6DdGDorzwCSHL9thnVX2+SyGSfbmOjaUoUcHAs87dAGRPGvb6PtC4iH2Pb4Gr1qQ7NgALirqYKROdYZb6It3Xe6Q087YSHR/Z9bA60E8IQA28FdNhJAu5F6jGxWeVXGKzdGQjxnzHkRNQr2E1XlVlC10MNuS60Fg2ebseMBHJ5MH6kHAqECN6lJAx0S/NHtHFVHKAIShM5PT4F+N3RpQHIo/NjN6h5VAmHPmAXYf0F2FjamvPHvjobNrlKLt/Ups5xmY/v3IM9DFP2YbfjPcSHeE4iLo9Z+s/Hiv1zJ4X91cMlHB5I2Q+evzuQ/8mLc8O6jHG7KV2cfhgLn/7HKpakgt9UXVcY8n7MO18UuKvtQIEV3yEFKhpVgCnhDPlDx6L4OZ8oSQ4zxXgzTRk9CYWt8li4RrN+RbNNp/XGJmlrT6o+2zAYCojp3/pEP9DkojLcF5LRAeUHkzqqQNQuGkOmYD8EiGO72x4WNu6l0jwk3FdlXktsWb1CZnbeM+QD6x/pqP6jWC/r+KZyAa2xKFSDtbICJF2QRyeLMENIPn+3nXdmK/fe6uWwjx2iPf8oMOG1H5Eq3w6WVUytcW51XmQKSiRWayPR3SIjWMq0XoL/5RwhZ5ZaqxIyIV4Ecy3DNJrUMqF9emYweUvx7UDtgIxWGCiJaZ4ovlFtNm7rGZO3VA8Bl/PGo0U6ygCMUo+fvCldEbG/6pxB957XF95pxOqkVHw+1W3PgTWtREJqfzq+GJKhK5BY+jSR+/co8h9W3vgv67CnN4WjwRD2anOLGMoxs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(40470700004)(36840700001)(46966006)(478600001)(81166007)(4326008)(41300700001)(8936002)(6666004)(15650500001)(2906002)(54906003)(5660300002)(86362001)(82310400005)(70206006)(70586007)(356005)(8676002)(82740400003)(40480700001)(6916009)(30864003)(47076005)(426003)(336012)(316002)(186003)(36860700001)(36756003)(83380400001)(40460700003)(2616005)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:47.2917 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34caf47e-3dbc-4fdf-35cf-08da668e5214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3468
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
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jun Lei <jun.lei@amd.com>

[why]
Unbounded request logic in resource/DML has some issues where unbounded
request is being enabled incorrectly. SW today enables unbounded request
unconditionally in hardware, on the assumption that HW can always
support it in single pipe scenarios.

This worked until now because the same assumption is made in DML. A new
DML update is needed to fix a bug, where there are single pipe scenarios
where unbounded cannot be enabled, and this change in DML needs to be
ported in, and dcn32 resource logic fixed.

[how]
First, dcn32_resource should program unbounded req in HW according to
unbounded req enablement output from DML, as opposed to DML input.

Second, port in DML update which disables unbounded req in some
scenarios to fix an issue with poor stutter performance

Signed-off-by: Jun Lei <jun.lei@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 11 +++-
 .../dc/dml/dcn32/display_mode_vba_32.c        | 44 +++++++++++++---
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 51 ++++++++++++++++---
 .../dc/dml/dcn32/display_mode_vba_util_32.h   | 10 +++-
 .../drm/amd/display/dc/dml/display_mode_vba.c |  1 +
 5 files changed, 103 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 32da47e24839..39214a0dcdf2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -3322,6 +3322,7 @@ void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context, display
 {
 	int i, pipe_idx;
 	bool usr_retraining_support = false;
+	bool unbounded_req_enabled = false;
 
 	/* Writeback MCIF_WB arbitration parameters */
 	dc->res_pool->funcs->set_mcif_arb_params(dc, context, pipes, pipe_cnt);
@@ -3357,6 +3358,14 @@ void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context, display
 	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
 		context->bw_ctx.bw.dcn.clk.dispclk_khz = dc->debug.min_disp_clk_khz;
 
+	unbounded_req_enabled = get_unbounded_request_enabled(&context->bw_ctx.dml, pipes, pipe_cnt);
+
+	if (unbounded_req_enabled && pipe_cnt > 1) {
+		// Unbounded requesting should not ever be used when more than 1 pipe is enabled.
+		ASSERT(false);
+		unbounded_req_enabled = false;
+	}
+
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
@@ -3375,7 +3384,7 @@ void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context, display
 		} else {
 			context->res_ctx.pipe_ctx[i].det_buffer_size_kb = get_det_buffer_size_kbytes(&context->bw_ctx.dml, pipes, pipe_cnt,
 							pipe_idx);
-			context->res_ctx.pipe_ctx[i].unbounded_req = pipes[pipe_idx].pipe.src.unbounded_req_mode;
+			context->res_ctx.pipe_ctx[i].unbounded_req = unbounded_req_enabled;
 		}
 		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
 			context->bw_ctx.bw.dcn.clk.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 1712843dafaa..092782b6e341 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -226,6 +226,9 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				mode_lib->vba.NumberOfActiveSurfaces,
 				mode_lib->vba.nomDETInKByte,
 				mode_lib->vba.UseUnboundedRequesting,
+				mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment,
+				mode_lib->vba.ip.pixel_chunk_size_kbytes,
+				mode_lib->vba.ip.rob_buffer_size_kbytes,
 				mode_lib->vba.CompressedBufferSegmentSizeInkByteFinal,
 				v->dummy_vars
 					.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation
@@ -287,6 +290,10 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				mode_lib->vba.DETBufferSizeC,
 				&v->UnboundedRequestEnabled,
 				&v->CompressedBufferSizeInkByte,
+				&v->CompBufReservedSpaceKBytes,
+				&v->dummy_vars
+					.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation
+					.dummy_boolean,       /* bool *CompBufReservedSpaceNeedAjustment */
 				v->dummy_vars
 					.DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation
 					.dummy_boolean_array, /* bool ViewportSizeSupportPerSurface[] */
@@ -295,6 +302,9 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 					 .dummy_boolean); /* bool *ViewportSizeSupport */
 	}
 
+	v->CompBufReservedSpaceZs     = v->CompBufReservedSpaceKBytes * 1024.0 / 256.0;
+	v->CompBufReservedSpace64B    = v->CompBufReservedSpaceKBytes * 1024.0 / 64.0;
+
 	// DCFCLK Deep Sleep
 	dml32_CalculateDCFCLKDeepSleep(
 			mode_lib->vba.NumberOfActiveSurfaces,
@@ -1532,8 +1542,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			v->TotalDataReadBandwidth,
 			mode_lib->vba.DCFCLK,
 			mode_lib->vba.ReturnBW,
-			mode_lib->vba.CompbufReservedSpace64B,
-			mode_lib->vba.CompbufReservedSpaceZs,
+			v->CompbufReservedSpace64B,
+			v->CompbufReservedSpaceZs,
 			mode_lib->vba.SRExitTime,
 			mode_lib->vba.SRExitZ8Time,
 			mode_lib->vba.SynchronizeTimingsFinal,
@@ -1598,8 +1608,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->TotalDataReadBandwidth,
 				mode_lib->vba.DCFCLK,
 				mode_lib->vba.ReturnBW,
-				0, //mode_lib->vba.CompbufReservedSpace64B,
-				0, //mode_lib->vba.CompbufReservedSpaceZs,
+				0, //CompbufReservedSpace64B,
+				0, //CompbufReservedSpaceZs,
 				mode_lib->vba.SRExitTime,
 				mode_lib->vba.SRExitZ8Time,
 				mode_lib->vba.SynchronizeTimingsFinal,
@@ -1661,6 +1671,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
 {
 	unsigned int dummy_integer[4];
+	bool dummy_boolean[2];
 	bool MPCCombineMethodAsNeededForPStateChangeAndVoltage;
 	bool MPCCombineMethodAsPossible;
 	enum odm_combine_mode dummy_odm_mode[DC__NUM_DPP__MAX];
@@ -1675,6 +1686,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	bool SubViewportMALLPStateMethod;
 	bool PhantomPipeMALLPStateMethod;
 	unsigned int MaximumMPCCombine;
+	bool CompBufReservedSpaceNeedAdjustment;
+	bool CompBufReservedSpaceNeedAdjustmentSingleDPP;
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: called\n", __func__);
@@ -1907,6 +1920,9 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			mode_lib->vba.NumberOfActiveSurfaces,
 			mode_lib->vba.nomDETInKByte,
 			mode_lib->vba.UseUnboundedRequesting,
+			mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment,
+			mode_lib->vba.ip.pixel_chunk_size_kbytes,
+			mode_lib->vba.ip.rob_buffer_size_kbytes,
 			mode_lib->vba.CompressedBufferSegmentSizeInkByteFinal,
 			mode_lib->vba.Output,
 			mode_lib->vba.ReadBandwidthLuma,
@@ -1954,6 +1970,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 			v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[7], /* Long            DETBufferSizeC[]  */
 			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0][0], /* bool           *UnboundedRequestEnabled  */
 			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[0][0], /* Long           *CompressedBufferSizeInkByte  */
+			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_integer_array[1][0], /* Long           *CompBufReservedSpaceKBytes */
+			&CompBufReservedSpaceNeedAdjustmentSingleDPP,
 			mode_lib->vba.SingleDPPViewportSizeSupportPerSurface,/* bool ViewportSizeSupportPerSurface[] */
 			&v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[1][0]); /* bool           *ViewportSizeSupport */
 
@@ -2122,9 +2140,18 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 				}
 			}
 
+			// if TotalNumberOfActiveDPP is > 1, then there should be no unbounded req mode (hw limitation), the comp buf reserved adjustment is not needed regardless
+			// if TotalNumberOfActiveDPP is == 1, then will use the SingleDPP version of unbounded_req for the decision
+			CompBufReservedSpaceNeedAdjustment = (mode_lib->vba.TotalNumberOfActiveDPP[i][j] > 1) ? 0 : CompBufReservedSpaceNeedAdjustmentSingleDPP;
+
+
+
 			if (j == 1 && !dml32_UnboundedRequest(mode_lib->vba.UseUnboundedRequesting,
-							mode_lib->vba.TotalNumberOfActiveDPP[i][j], NoChroma,
-							mode_lib->vba.Output[0])) {
+					mode_lib->vba.TotalNumberOfActiveDPP[i][j], NoChroma,
+					mode_lib->vba.Output[0],
+					mode_lib->vba.SurfaceTiling[0],
+					CompBufReservedSpaceNeedAdjustment,
+					mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment)) {
 				while (!(mode_lib->vba.TotalNumberOfActiveDPP[i][j] >= mode_lib->vba.MaxNumDPP
 						|| mode_lib->vba.TotalNumberOfSingleDPPSurfaces[i][j] == 0)) {
 					double BWOfNonCombinedSurfaceOfMaximumBandwidth = 0;
@@ -2502,6 +2529,9 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.NumberOfActiveSurfaces,
 					mode_lib->vba.nomDETInKByte,
 					mode_lib->vba.UseUnboundedRequesting,
+					mode_lib->vba.DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment,
+					mode_lib->vba.ip.pixel_chunk_size_kbytes,
+					mode_lib->vba.ip.rob_buffer_size_kbytes,
 					mode_lib->vba.CompressedBufferSegmentSizeInkByteFinal,
 					mode_lib->vba.Output,
 					mode_lib->vba.ReadBandwidthLuma,
@@ -2548,6 +2578,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 					mode_lib->vba.DETBufferSizeCThisState,
 					&mode_lib->vba.UnboundedRequestEnabledThisState,
 					&mode_lib->vba.CompressedBufferSizeInkByteThisState,
+					&dummy_integer[0], /* Long CompBufReservedSpaceKBytes */
+					&dummy_boolean[0], /* bool CompBufReservedSpaceNeedAdjustment */
 					v->dummy_vars.dml32_ModeSupportAndSystemConfigurationFull.dummy_boolean_array[0],
 					&mode_lib->vba.ViewportSizeSupport[i][j]);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index febaff7d7343..f7fe8f039ba3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -454,6 +454,9 @@ void dml32_CalculateSwathAndDETConfiguration(
 		unsigned int NumberOfActiveSurfaces,
 		unsigned int nomDETInKByte,
 		enum unbounded_requesting_policy UseUnboundedRequestingFinal,
+		bool DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment,
+		unsigned int PixelChunkSizeKBytes,
+		unsigned int ROBSizeKBytes,
 		unsigned int CompressedBufferSegmentSizeInkByteFinal,
 		enum output_encoder_class Output[],
 		double ReadBandwidthLuma[],
@@ -501,6 +504,8 @@ void dml32_CalculateSwathAndDETConfiguration(
 		unsigned int DETBufferSizeC[],
 		bool *UnboundedRequestEnabled,
 		unsigned int *CompressedBufferSizeInkByte,
+		unsigned int *CompBufReservedSpaceKBytes,
+		bool *CompBufReservedSpaceNeedAdjustment,
 		bool ViewportSizeSupportPerSurface[],
 		bool *ViewportSizeSupport)
 {
@@ -519,6 +524,8 @@ void dml32_CalculateSwathAndDETConfiguration(
 
 #ifdef __DML_VBA_DEBUG__
 	dml_print("DML::%s: ForceSingleDPP = %d\n", __func__, ForceSingleDPP);
+	dml_print("DML::%s: ROBSizeKBytes = %d\n", __func__, ROBSizeKBytes);
+	dml_print("DML::%s: PixelChunkSizeKBytes = %d\n", __func__, PixelChunkSizeKBytes);
 #endif
 	dml32_CalculateSwathWidth(ForceSingleDPP,
 			NumberOfActiveSurfaces,
@@ -588,8 +595,24 @@ void dml32_CalculateSwathAndDETConfiguration(
 		}
 	}
 
-	*UnboundedRequestEnabled = dml32_UnboundedRequest(UseUnboundedRequestingFinal, TotalActiveDPP,
-			NoChromaSurfaces, Output[0]);
+	// By default, just set the reserved space to 2 pixel chunks size
+	*CompBufReservedSpaceKBytes = PixelChunkSizeKBytes * 2;
+
+	// if unbounded req is enabled, program reserved space such that the ROB will not hold more than 8 swaths worth of data
+	// - assume worst-case compression rate of 4. [ROB size - 8 * swath_size / max_compression ratio]
+	// - assume for "narrow" vp case in which the ROB can fit 8 swaths, the DET should be big enough to do full size req
+	*CompBufReservedSpaceNeedAdjustment = ((int) ROBSizeKBytes - (int) *CompBufReservedSpaceKBytes) > (int) (RoundedUpMaxSwathSizeBytesY[0]/512);
+
+	if (*CompBufReservedSpaceNeedAdjustment == 1) {
+		*CompBufReservedSpaceKBytes = ROBSizeKBytes - RoundedUpMaxSwathSizeBytesY[0]/512;
+	}
+
+	#ifdef __DML_VBA_DEBUG__
+		dml_print("DML::%s: CompBufReservedSpaceKBytes          = %d\n",  __func__, *CompBufReservedSpaceKBytes);
+		dml_print("DML::%s: CompBufReservedSpaceNeedAdjustment  = %d\n",  __func__, *CompBufReservedSpaceNeedAdjustment);
+	#endif
+
+	*UnboundedRequestEnabled = dml32_UnboundedRequest(UseUnboundedRequestingFinal, TotalActiveDPP, NoChromaSurfaces, Output[0], SurfaceTiling[0], *CompBufReservedSpaceNeedAdjustment, DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment);
 
 	dml32_CalculateDETBufferSize(DETSizeOverride,
 			UseMALLForPStateChange,
@@ -907,9 +930,12 @@ void dml32_CalculateSwathWidth(
 } // CalculateSwathWidth
 
 bool dml32_UnboundedRequest(enum unbounded_requesting_policy UseUnboundedRequestingFinal,
-		unsigned int TotalNumberOfActiveDPP,
-		bool NoChroma,
-		enum output_encoder_class Output)
+			unsigned int TotalNumberOfActiveDPP,
+			bool NoChroma,
+			enum output_encoder_class Output,
+			enum dm_swizzle_mode SurfaceTiling,
+			bool CompBufReservedSpaceNeedAdjustment,
+			bool DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment)
 {
 	bool ret_val = false;
 
@@ -917,7 +943,20 @@ bool dml32_UnboundedRequest(enum unbounded_requesting_policy UseUnboundedRequest
 			TotalNumberOfActiveDPP == 1 && NoChroma);
 	if (UseUnboundedRequestingFinal == dm_unbounded_requesting_edp_only && Output != dm_edp)
 		ret_val = false;
-	return ret_val;
+
+	if (SurfaceTiling == dm_sw_linear)
+		ret_val = false;
+
+	if (CompBufReservedSpaceNeedAdjustment == 1 && DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment)
+		ret_val = false;
+
+#ifdef __DML_VBA_DEBUG__
+	dml_print("DML::%s: CompBufReservedSpaceNeedAdjustment  = %d\n",  __func__, CompBufReservedSpaceNeedAdjustment);
+	dml_print("DML::%s: DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment  = %d\n",  __func__, DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment);
+	dml_print("DML::%s: ret_val = %d\n",  __func__, ret_val);
+#endif
+
+	return (ret_val);
 }
 
 void dml32_CalculateDETBufferSize(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
index 72461b934ee0..d293856ba906 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.h
@@ -90,6 +90,9 @@ void dml32_CalculateSwathAndDETConfiguration(
 		unsigned int NumberOfActiveSurfaces,
 		unsigned int nomDETInKByte,
 		enum unbounded_requesting_policy UseUnboundedRequestingFinal,
+		bool DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment,
+		unsigned int PixelChunkSizeKBytes,
+		unsigned int ROBSizeKBytes,
 		unsigned int CompressedBufferSegmentSizeInkByteFinal,
 		enum output_encoder_class Output[],
 		double ReadBandwidthLuma[],
@@ -137,6 +140,8 @@ void dml32_CalculateSwathAndDETConfiguration(
 		unsigned int DETBufferSizeC[],
 		bool *UnboundedRequestEnabled,
 		unsigned int *CompressedBufferSizeInkByte,
+		unsigned int *CompBufReservedSpaceKBytes,
+		bool *CompBufReservedSpaceNeedAdjustment,
 		bool ViewportSizeSupportPerSurface[],
 		bool *ViewportSizeSupport);
 
@@ -181,7 +186,10 @@ void dml32_CalculateSwathWidth(
 bool dml32_UnboundedRequest(enum unbounded_requesting_policy UseUnboundedRequestingFinal,
 		unsigned int TotalNumberOfActiveDPP,
 		bool NoChroma,
-		enum output_encoder_class Output);
+		enum output_encoder_class Output,
+		enum dm_swizzle_mode SurfaceTiling,
+		bool CompBufReservedSpaceNeedAdjustment,
+		bool DisableUnboundRequestIfCompBufReservedSpaceNeedAdjustment);
 
 void dml32_CalculateDETBufferSize(
 		unsigned int DETSizeOverride[],
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 083f89e276d6..22ce975527a3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -111,6 +111,7 @@ dml_get_attr_func(tcalc, mode_lib->vba.TCalc);
 dml_get_attr_func(fraction_of_urgent_bandwidth, mode_lib->vba.FractionOfUrgentBandwidth);
 dml_get_attr_func(fraction_of_urgent_bandwidth_imm_flip, mode_lib->vba.FractionOfUrgentBandwidthImmediateFlip);
 
+
 dml_get_attr_func(cstate_max_cap_mode, mode_lib->vba.DCHUBBUB_ARB_CSTATE_MAX_CAP_MODE);
 dml_get_attr_func(comp_buffer_size_kbytes, mode_lib->vba.CompressedBufferSizeInkByte);
 dml_get_attr_func(pixel_chunk_size_in_kbyte, mode_lib->vba.PixelChunkSizeInKByte);
-- 
2.37.0

