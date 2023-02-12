Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2FDC636D3
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Feb 2023 17:00:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E6410E2E9;
	Sun, 12 Feb 2023 17:00:42 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F2D510E2E7
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Feb 2023 17:00:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW0n6xgjAuicXNkYOcvRmtcwe4SqMBnUbY+NiVMljzqB5AGVaCxd0nUPmkITEliJyxLoaEbYqz2aY60IxgF8mWwp+pNJq/GwcVkQrJn9CZVX6oHiyPuqsOAPfLlKsewm16dKbCA9ux3zH6silM2ZycUcFUAXVK5nleDK8pRTH2cqkYqmOqa3jZca2AfPFx7vBfB/I1YdlwIQLu3aqiKmJ1huIwp2nuDufZdDRaUloSzzN86rtA0TJWaOPKBLVGwmhQ/Ztpyf1Y9sIiTQ9rhflHBCWpFxdBZCVBUXoxqu7mbB4LGVd0ySwaI14X8CC8JIiKjvPzE0SBg5FKrKXunbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JH99YCcQ4a7b9dILV+9mrZF4eecghcgNuI244O2sGIk=;
 b=aqbjm94dAiT/gjSw/stbhmAKs6pktFCbRDgjdvfdsx5gQWhKXNwumb7zW0hoepjTxITM83Z+F7R7glpdONA+9nqY9HTZ7aP6JdlvG0R40W/MQfZZwSqpUw4VvtZUYGgMIbu+8k59Y6yTd20f2rMAmKPbBWpkZOIs7PKNio5+fsa7zqNWkRc3GQi8TB3iamYuXhcvOGEZHJfLQRpMu3bE+cpiqmUZMxgIiapOS7jhG7whCBEE1GdmnH48Mo5003LhmEqUXinN0i5YqHqMYKVLqh8p42bzCVS5WTLYO4JG4gRBHDD2b4wg2WBfhkRJrH04xQfq70gBTranJYQWxlRwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JH99YCcQ4a7b9dILV+9mrZF4eecghcgNuI244O2sGIk=;
 b=DgV67aAfd08Hd1V0TnzZz4nciXQ2uPQzoL2TpW1KZlJ02zyu7MP5HEhjKHC8N6EwBbBd1Ur2eir0bUV8IokFpzkPDf/siYrxJwifsPHlCin2Lhez37ta+WBQna08CQgyZ1q0IcXqDngRsAEUXgfo1ByGiLqa1U2z1yh46cgEo4E=
Received: from DS7PR05CA0001.namprd05.prod.outlook.com (2603:10b6:5:3b9::6) by
 DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.23; Sun, 12 Feb 2023 17:00:34 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::87) by DS7PR05CA0001.outlook.office365.com
 (2603:10b6:5:3b9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.9 via Frontend
 Transport; Sun, 12 Feb 2023 17:00:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.23 via Frontend Transport; Sun, 12 Feb 2023 17:00:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:33 -0600
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 12 Feb
 2023 11:00:32 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/22] drm/amd/display: Set max vratio for prefetch to 7.9 for
 YUV420 MPO
Date: Sun, 12 Feb 2023 11:59:35 -0500
Message-ID: <20230212165955.1993601-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
References: <20230212165955.1993601-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|DM4PR12MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 505c0613-4ca8-43a9-117d-08db0d1aa82d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ZNhzG35W50URFxJZfy+ucQbSDHrWEoyShhRvPX4ut6V3flmajcopFiM8Rt+qxzSKI1001iiZiDfLx+1SG2uchK6Vvf/6AUdSzyP4i7B5kcNz89iTB1KUhEoA4bySQ5+t2oXt026U+rr2Jzbcq1MIJdv25YR6nPQKXRWtosPK94x/Xmw7OM4+59RL1iQ3Vz93r8xmFKPs/FQClSB48lNdxuOmVw3/HHy5nORu6xSjkEk9wEgs4K64SKZl8UupHTJxVKivWmMtyptyVstsMEKOs2SEOiFGXkiF5TL6/Q2PggwHpfs0FPMlWefJ1Iux5wNhP7ca6fOTpKqJMw7d6JMknNuWcgxKCv3flAigbxT1RFKoEdS6caEAEnCvkLZJ8FwilTcQPjDMnycmNbFbl7pIUDrZbNsLo9WI/hXC8JmsJ6FWHrSVLU2S+QWWUHmupdLNv5zr9+apQAtj0lSNXToK7VjR7t453F8IgZdyJCzDwdqRt4btIUL87XaeXbdaOHOslyDnH7nVEU/8cAdnHdvLoSKo1tM4W1T69uCYjmunDQA8Swj8EDv9S45JrWDNm9kJKJ8/pCl7Oj5USyoHoz4n77MDTglmCWyhW4iESSMl7V0MrtJhdGhWosW+0P3Vqh4NbppBSMN+V8b79yi8J4ZrOXnelBfaF8CeZiA5ZZ3cp6s2E3gAW2jhH+HeMGQrj9ioldJ5nEMs739DPOBSnw63oXpMQ+/Y+nSNU4+959gzKo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(83380400001)(5660300002)(41300700001)(8936002)(44832011)(47076005)(426003)(81166007)(36860700001)(82740400003)(82310400005)(86362001)(36756003)(40480700001)(356005)(40460700003)(2906002)(316002)(19627235002)(54906003)(1076003)(26005)(16526019)(186003)(4326008)(6916009)(336012)(478600001)(2616005)(8676002)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2023 17:00:34.4112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 505c0613-4ca8-43a9-117d-08db0d1aa82d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
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
index 27b62ef4f62d..3372ede2dc28 100644
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

