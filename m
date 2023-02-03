Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229E9C05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 15:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5B510E7F8;
	Fri,  3 Feb 2023 15:25:39 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 109CF88668
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 15:25:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h96P19GffUzwHAmv4XrCJZ65VQvor00TjYvTVqD5u45HyydXMqOeu+yhUin+VSq8ZkI20aGR/VbByznsM0COp7jMUaWZSFBeimiCm2zNaG/gP4Db8mTti/WZLDImXBP8G5+QjrRUHEcXraVXH+6sFVJ+BZQt/73mxtL/J+LwBMUIElzfXuYYG8XshIG6/jvqFX/eRgNjQAhfq+sUz3sTVbd4VhyUt9Vm0wUmQ7YWdkHehhSZgh+z3Z1zWiS5DeG9HXJQuzS2waJsanA+cpaCREj+OqbaEkPcr8NnsevFpa0t3o3D8z7RXJcG1oz25fH7JgXj9LosfPBnUlRD/sCC/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwGrMbdUbAjsmBoruv4eSJ33jozRpQKQU9bXMqguY9g=;
 b=CvRNLS50juEGy7U5ofxXfarxyp5xsD3rTex6QSvSJiB3Ald+y1YjGvvuQaEzOdiBVDmmhr3o1l9k6JNYkGhzD6n9xodkytHXn91YMK5oSjbc/Q/uJRqn0DZz6RVCy1LFDFGEh1r0f64xodrs8iPL4EuSVhlVcqx8VA1XBUCMDGtZtNugjBLBqjlK/LBpg5SgThSViDtYHnl5C0TQEMQU1IXjlCo7axz7xKN9KvDWrOIgt5+cDPE9MP6dSwQSo/ogMw/aIWLZgAbR2gdaelBvKzhcXR12CYtYjBLlYyis8K8UNT/O4MhAflYDA4OvpIs6by1ZiADz6XaVCUNbL+X8pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwGrMbdUbAjsmBoruv4eSJ33jozRpQKQU9bXMqguY9g=;
 b=MGHPM6Bo/+gcoKE1WVjtdbh7lSD/MbW1hQEUmSLdzIDsfw3kihFi6trRmCB9OwS+SwBboMSPsnvbe6cKM1rjaFp8iYR7sM9ZhP5gj4gLWtPHoeuNBoJameITAKVB1T/0YID8Pc9oO06yzw58wQTUVUm/Iv3BmpipguaD/Hc9svc=
Received: from MN2PR03CA0004.namprd03.prod.outlook.com (2603:10b6:208:23a::9)
 by SJ2PR12MB8111.namprd12.prod.outlook.com (2603:10b6:a03:4fe::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Fri, 3 Feb
 2023 15:25:33 +0000
Received: from BL02EPF0000C407.namprd05.prod.outlook.com
 (2603:10b6:208:23a:cafe::e6) by MN2PR03CA0004.outlook.office365.com
 (2603:10b6:208:23a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28 via Frontend
 Transport; Fri, 3 Feb 2023 15:25:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C407.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Fri, 3 Feb 2023 15:25:32 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 09:25:28 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/12] drm/amd/display: Set max vratio for prefetch to 7.9 for
 YUV420 MPO
Date: Fri, 3 Feb 2023 10:24:46 -0500
Message-ID: <20230203152452.1441747-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
References: <20230203152452.1441747-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C407:EE_|SJ2PR12MB8111:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bb3b8e-46d2-4f7f-45e6-08db05fae3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqTqCjkrys6vniDEiFyH1UXZl5Lf5mc6l67cxAyikryoL3s2jEjyElTr4cVjIRh0hqdAzoaW875VlugIVUXeX54s7py3hzKxanerU8kgaeJ1dyP8nCX1py8llnGYg3QfuxYFJOA/8TCR5bxEG+mXk6e9cYnk3wGiGNa52fZqZiG6uAI5BRD7E2rrAkJZbRCd2omvzkjb2GtMYXkDarf8lF8kRFSVDbJxBvXPayEovyRA1rM+eSe0gmbWXq1Ts0RkiOpYo8hsDNVgqBgbeHwMs/HYZGFppkpycpT5z4fj2KpIFLu+UK/RJ88EkthVYa8ZNTMgpzEcAzsdzROPsZDm0dol6QN1IrasAfLDzxV+51pq4Bt++2XHZ0y6Az4UDScCTjltyjDrQkvoD9RbvrcFi8iB0JpHJsJRM1gxQkMMneaN2C+g/7zmqSqhck2n5UaoCmEwx9vK0AUw+SkfmYkNnOFjDmCn2Hg3L2ylFMIDMob0foDBP3A/fjOI9xdSdWov9T14IvPIrc6CQ3z5NsNJAYbfOesinnw3iF9x1PCA8s9bfnPvgEInHWt+TWJyQrySufZld5Yu3JTWObrzg9Wh9/kra4wOYzbdleYm3ZPC1yuot0YgarvHOv2f/BxT8QYQgwR4uOvA/T23TZgNhOgYEbzk89HwoJ8ICfLhvXyMXI0dTvUOq/uASFgQ0hB7NDCYuarS7LT6+CmkacJ9pD2tJbcln+E6YdprubzxUDMfwfE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199018)(40470700004)(46966006)(36840700001)(316002)(5660300002)(83380400001)(54906003)(70206006)(82310400005)(4326008)(70586007)(41300700001)(6666004)(6916009)(8676002)(1076003)(356005)(36756003)(44832011)(19627235002)(2616005)(40460700003)(336012)(2906002)(86362001)(82740400003)(36860700001)(40480700001)(81166007)(8936002)(186003)(47076005)(26005)(16526019)(426003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 15:25:32.4830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bb3b8e-46d2-4f7f-45e6-08db05fae3fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C407.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8111
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Nevenko Stupar <Nevenko.Stupar@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Single 4K60 playing YUV420 MPO video blocks P-State because
  the required VRatio for prefetch is too high (luma plane for
  YUV420 is 1bpe, so swath height is 16 and prefetch requires
  more lines)
- Allow max vratio per plane to be 7.9 for single display YUV420
  MPO video cases
- Ensure that global vratio prefetch (i.e. total prefetch BW vs.
  total active bandwidth) does not excited 4.0

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |  2 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 32 +++++++++++++++++++
 .../dc/dml/dcn32/display_mode_vba_32.c        |  8 ++---
 .../dc/dml/dcn32/display_mode_vba_32.h        |  3 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   | 12 +++++--
 .../amd/display/dc/dml/display_mode_structs.h |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.h |  1 +
 8 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index a09db7c63a04..aca928edc4e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -150,6 +150,8 @@ bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe);
 
 unsigned int dcn32_calc_num_avail_chans_for_mall(struct dc *dc, int num_chans);
 
+double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *context);
+
 /* definitions for run time init of reg offsets */
 
 /* CLK SRC */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 28e9f3644bf4..942181076c83 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -27,6 +27,7 @@
 #include "dcn32/dcn32_resource.h"
 #include "dcn20/dcn20_resource.h"
 #include "display_mode_vba_util_32.h"
+#include "dml/dcn32/display_mode_vba_32.h"
 // We need this includes for WATERMARKS_* defines
 #include "clk_mgr/dcn32/dcn32_smu13_driver_if.h"
 #include "dcn30/dcn30_resource.h"
@@ -1618,6 +1619,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 	}
 
 	dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
+	context->bw_ctx.dml.soc.max_vratio_pre = dcn32_determine_max_vratio_prefetch(dc, context);
 
 	if (!fast_validate)
 		dcn32_full_validate_bw_helper(dc, context, pipes, &vlevel, split, merge, &pipe_cnt);
@@ -2744,3 +2746,33 @@ bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe)
 	}
 	return allow;
 }
+
+/**
+ * *******************************************************************************************
+ * dcn32_determine_max_vratio_prefetch: Determine max Vratio for prefetch by driver policy
+ *
+ * @param [in]: dc: Current DC state
+ * @param [in]: context: New DC state to be programmed
+ *
+ * @return: Max vratio for prefetch
+ *
+ * *******************************************************************************************
+ */
+double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *context)
+{
+	double max_vratio_pre = __DML_MAX_BW_RATIO_PRE__; // Default value is 4
+	int i;
+
+	/* For single display MPO configs, allow the max vratio to be 8
+	 * if any plane is YUV420 format
+	 */
+	if (context->stream_count == 1 && context->stream_status[0].plane_count > 1) {
+		for (i = 0; i < context->stream_status[0].plane_count; i++) {
+			if (context->stream_status[0].plane_states[i]->format == SURFACE_PIXEL_FORMAT_VIDEO_420_YCbCr ||
+					context->stream_status[0].plane_states[i]->format == SURFACE_PIXEL_FORMAT_VIDEO_420_YCrCb) {
+				max_vratio_pre = __DML_MAX_VRATIO_PRE__;
+			}
+		}
+	}
+	return max_vratio_pre;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index 23e50d15e9ae..55567b9fcfc8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -896,8 +896,8 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 			if (v->DestinationLinesForPrefetch[k] < 2)
 				DestinationLineTimesForPrefetchLessThan2 = true;
 
-			if (v->VRatioPrefetchY[k] > __DML_MAX_VRATIO_PRE__
-					|| v->VRatioPrefetchC[k] > __DML_MAX_VRATIO_PRE__)
+			if (v->VRatioPrefetchY[k] > v->MaxVRatioPre
+					|| v->VRatioPrefetchC[k] > v->MaxVRatioPre)
 				VRatioPrefetchMoreThanMax = true;
 
 			//bool DestinationLinesToRequestVMInVBlankEqualOrMoreThan32 = false;
@@ -3397,8 +3397,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 
 				mode_lib->vba.VRatioInPrefetchSupported[i][j] = true;
 				for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
-					if (mode_lib->vba.VRatioPreY[i][j][k] > __DML_MAX_VRATIO_PRE__
-							|| mode_lib->vba.VRatioPreC[i][j][k] > __DML_MAX_VRATIO_PRE__
+					if (mode_lib->vba.VRatioPreY[i][j][k] > mode_lib->vba.MaxVRatioPre
+							|| mode_lib->vba.VRatioPreC[i][j][k] > mode_lib->vba.MaxVRatioPre
 							|| mode_lib->vba.NoTimeForPrefetch[i][j][k] == true) {
 						mode_lib->vba.VRatioInPrefetchSupported[i][j] = false;
 					}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
index c8b28c83ddf4..500b3dd6052d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.h
@@ -44,7 +44,8 @@
 #define __DML_MIN_DCFCLK_FACTOR__   1.15
 
 // Prefetch schedule max vratio
-#define __DML_MAX_VRATIO_PRE__ 4.0
+#define __DML_MAX_VRATIO_PRE__ 7.9
+#define __DML_MAX_BW_RATIO_PRE__ 4.0
 
 #define __DML_VBA_MAX_DST_Y_PRE__    63.75
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 0932f49cd819..069e9abb83cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -3480,7 +3480,7 @@ bool dml32_CalculatePrefetchSchedule(
 	double  prefetch_sw_bytes;
 	double  bytes_pp;
 	double  dep_bytes;
-	unsigned int max_vratio_pre = __DML_MAX_VRATIO_PRE__;
+	unsigned int max_vratio_pre = v->MaxVRatioPre;
 	double  min_Lsw;
 	double  Tsw_est1 = 0;
 	double  Tsw_est3 = 0;
@@ -6150,7 +6150,9 @@ void dml32_CalculatePrefetchBandwithSupport(unsigned int NumberOfActiveSurfaces,
 		bool *PrefetchBandwidthSupport)
 {
 	unsigned int k;
+	double ActiveBandwidthPerSurface;
 	bool NotEnoughUrgentLatencyHiding = false;
+	double TotalActiveBandwidth = 0;
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
 		if (NotUrgentLatencyHiding[k]) {
 			NotEnoughUrgentLatencyHiding = true;
@@ -6159,12 +6161,16 @@ void dml32_CalculatePrefetchBandwithSupport(unsigned int NumberOfActiveSurfaces,
 
 	*PrefetchBandwidth = 0;
 	for (k = 0; k < NumberOfActiveSurfaces; ++k) {
+		ActiveBandwidthPerSurface = ReadBandwidthLuma[k] * UrgentBurstFactorLuma[k] + ReadBandwidthChroma[k] * UrgentBurstFactorChroma[k] + cursor_bw[k] * UrgentBurstFactorCursor[k] + NumberOfDPP[k] * (meta_row_bandwidth[k] + dpte_row_bandwidth[k]);
+
+		TotalActiveBandwidth += ActiveBandwidthPerSurface;
+
 		*PrefetchBandwidth = *PrefetchBandwidth + dml_max3(NumberOfDPP[k] * prefetch_vmrow_bw[k],
-				ReadBandwidthLuma[k] * UrgentBurstFactorLuma[k] + ReadBandwidthChroma[k] * UrgentBurstFactorChroma[k] + cursor_bw[k] * UrgentBurstFactorCursor[k] + NumberOfDPP[k] * (meta_row_bandwidth[k] + dpte_row_bandwidth[k]),
+				ActiveBandwidthPerSurface,
 				NumberOfDPP[k] * (PrefetchBandwidthLuma[k] * UrgentBurstFactorLumaPre[k] + PrefetchBandwidthChroma[k] * UrgentBurstFactorChromaPre[k]) + cursor_bw_pre[k] * UrgentBurstFactorCursorPre[k]);
 	}
 
-	*PrefetchBandwidthSupport = (*PrefetchBandwidth <= ReturnBW) && !NotEnoughUrgentLatencyHiding;
+	*PrefetchBandwidthSupport = (*PrefetchBandwidth <= ReturnBW) &&  (*PrefetchBandwidth <= TotalActiveBandwidth * __DML_MAX_BW_RATIO_PRE__) && !NotEnoughUrgentLatencyHiding;
 	*FractionOfUrgentBandwidth = *PrefetchBandwidth / ReturnBW;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 64d602e6412f..3c077164f362 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -246,6 +246,7 @@ struct _vcs_dpi_soc_bounding_box_st {
 	bool disable_dram_clock_change_vactive_support;
 	bool allow_dram_clock_one_display_vactive;
 	enum self_refresh_affinity allow_dram_self_refresh_or_dram_clock_change_in_vblank;
+	double max_vratio_pre;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 8cb28b7918db..f9653f511baa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -412,6 +412,7 @@ static void fetch_socbb_params(struct display_mode_lib *mode_lib)
 		soc->urgent_latency_adjustment_fabric_clock_component_us;
 	mode_lib->vba.UrgentLatencyAdjustmentFabricClockReference =
 		soc->urgent_latency_adjustment_fabric_clock_reference_mhz;
+	mode_lib->vba.MaxVRatioPre = soc->max_vratio_pre;
 }
 
 static void fetch_ip_params(struct display_mode_lib *mode_lib)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
index 876b9b517ea2..07993741f5e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.h
@@ -263,6 +263,7 @@ struct vba_vars_st {
 	int maxMpcComb;
 	bool UseMaximumVStartup;
 
+	double MaxVRatioPre;
 	double WritebackDISPCLK;
 	double DPPCLKUsingSingleDPPLuma;
 	double DPPCLKUsingSingleDPPChroma;
-- 
2.25.1

