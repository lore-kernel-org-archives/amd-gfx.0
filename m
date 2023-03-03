Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580B2C7EE2D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Mar 2023 15:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0798810E6D8;
	Fri,  3 Mar 2023 15:48:43 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B1A010E6D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Mar 2023 15:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCwT52z4NQSumBQQTTRUG5jPMtv6OHn6XiAtk2ZdnJM06gwi8UTekmibeQNvy01dLGZheJl8a4mWAy0ZKZDfcsd6w/7FHi0H/JCxStc+rUiSEyf59rpExq7OADSuihn2eDWDN6ADdLMicr6oZF9kO1qiOGyzLeH8k2HOiW2M3/shTXVZUZDVWliF74qjBkpVb6CSHCUim9xlnRO2bRCHQpOLlPHrwOn8x55EM8STXz6Mc4y7AwrZnOVCJNkNY+LkZUaE9Fv5B2lh3xShhgOKJWH72c+cCagn1XvCvJ745T4assnS5gR1JA8R1iCr5WH+T3M2QHUE3d9ThwDe2GVyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qbw3C684u5vzHHG4S2MA+8gPxeiTuG5MpMkjXPCaLnM=;
 b=dYv1w1BsGx+tmreW6Besp9KqcAS0KraI9VrjedhxqKw+xxTTCEEaNBMbPVlSxpgNcWEu/aFtJ6rH41OWzeDN570mRdM6sYehUxJYbMkrFwooLcxCllr9bLtt9CJRUZmw61p+8+DOZfb3N7rMfPhSg/L81ia8X1Cqr1HNW+96ytr2vr7NFnuAvNkMi3gEXQr1BhUjNb3p86suh/h52vEz5aBiNSAVPmF1jmYrB/PgiYMQRm6zg0ZvDqKhl0U9umFXMlVCFI+NnjycSkmSMVUGCp8NlZZh5Lyb1lAHI0KgW0eEs8Z7EqfzzidWhkFS1iD7eku90xkTIsiqJHqJqAjs4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qbw3C684u5vzHHG4S2MA+8gPxeiTuG5MpMkjXPCaLnM=;
 b=k3eD56i63bNgiD2uKqT0PSP1uRkZ2he8iNzXxufhHz41ZNQ1d45AZuG9Eqsm/U1t6EeSj1R5aQ1+GncfZeaEhGE8v1T2YYGpIlXdMLG0mt4ksVfx8yQNJnnrfbfWJ0eZKaj4i80Op2vFU4bUcMhuXiP/U2LLqmxmF3YiN35ThtM=
Received: from MW3PR05CA0014.namprd05.prod.outlook.com (2603:10b6:303:2b::19)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 15:48:37 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::de) by MW3PR05CA0014.outlook.office365.com
 (2603:10b6:303:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.10 via Frontend
 Transport; Fri, 3 Mar 2023 15:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.23 via Frontend Transport; Fri, 3 Mar 2023 15:48:36 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Mar
 2023 09:48:17 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/33] drm/amd/display: link link_dp_dpia_bw.o in makefile
Date: Fri, 3 Mar 2023 10:40:04 -0500
Message-ID: <20230303154022.2667-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230303154022.2667-1-qingqing.zhuo@amd.com>
References: <20230303154022.2667-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eb61ce9-0e67-46bc-9e43-08db1bfec06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mpSnSF9z0ZAqW1caohlmPhfZnouS9pzFT6P/l8LT/dYK+HFedDXSj2fOp3Fhrz8wnHHqmtgoLYDpHELrGgqKqAuiEWWHaZjzqQpfrHqDLafSalo2vTJTjz3TdXRAjEeO8wfwfgmcqYOZGM7pxOryKt2szJ2elFM85GeK/BWAuhumRb8NXi46JjR9ZGfq2Pf6WWm3EwnTo71kCZyur3frHr2QGBLV9z0MJP9yThNIky3EwRBm8KIxMedt7dWh6AG3pt4EqWr4aJZPXgzGEntcoAF9ySCa5CNxKRBte0BwMQLwSSLKXPFZ/VtEobs3k9gGVrfzjGDfVsTFk/bx4PfCah5wYLcLUNd10JftV0LxrXKUBS/kkqNYYk449mo5IRjmGWWK4LS9ugCCFXktgh4kZDmhTnHJ+uLO9sHw8ROqJ7UAi2FK1khw4At26YXi0dtPMTdqWqJWmGaXWhywB/XxzIaOqEgOfjw6/RDnk2iqzQ7V1X+0v7CsLymFo4DMydyy2pflQ4nZy71VHwl4SYsnjEk04aD+rAI79EpLHIV8u32vO6eUh+NlXpH0RMAXCDS/ONs18I9jEB1ay8LbO1XUmv1tsL54xck2q64c0WwD9QKE/WhIH8LJz0fo/QMtBWplF1zuYD85PKH9Goy5q7YqLgtr73y90JfTxtLM+tAxT5/5BMYSJi6OqCa4uq8Q7UE4NOa7iDzZAskKDBShQoV2J7p7V85p/OwzPZwIk/Gbz18=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199018)(36840700001)(46966006)(40470700004)(40460700003)(36756003)(47076005)(6666004)(336012)(26005)(186003)(2616005)(70206006)(16526019)(41300700001)(54906003)(4326008)(30864003)(316002)(8676002)(44832011)(2906002)(6916009)(70586007)(82740400003)(8936002)(478600001)(5660300002)(82310400005)(40480700001)(86362001)(1076003)(356005)(81166007)(36860700001)(83380400001)(66899018)(66574015)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 15:48:36.5350 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb61ce9-0e67-46bc-9e43-08db1bfec06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
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
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[Why & How]
- We have added link_dp_dpia_bw code but it is not currently
added in makefile. We are adding this to makefile so it would
be built.
- Remove unused dc_link.h

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  66 +-
 drivers/gpu/drm/amd/display/dc/dc_link.h      | 579 ------------------
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   2 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |  31 +-
 .../dc/link/protocols/link_dp_dpia_bw.h       |   2 +-
 5 files changed, 68 insertions(+), 612 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dc_link.h

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index 4bccce94d83b..af53278662ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -921,12 +921,6 @@ struct dpcd_usb4_dp_tunneling_info {
 #ifndef DP_DFP_CAPABILITY_EXTENSION_SUPPORT
 #define DP_DFP_CAPABILITY_EXTENSION_SUPPORT		0x0A3
 #endif
-#ifndef DP_LINK_SQUARE_PATTERN
-#define DP_LINK_SQUARE_PATTERN				0x10F
-#endif
-#ifndef DP_CABLE_ATTRIBUTES_UPDATED_BY_DPTX
-#define DP_CABLE_ATTRIBUTES_UPDATED_BY_DPTX		0x110
-#endif
 #ifndef DP_DSC_CONFIGURATION
 #define DP_DSC_CONFIGURATION				0x161
 #endif
@@ -939,12 +933,6 @@ struct dpcd_usb4_dp_tunneling_info {
 #ifndef DP_128b_132b_TRAINING_AUX_RD_INTERVAL
 #define DP_128b_132b_TRAINING_AUX_RD_INTERVAL		0x2216
 #endif
-#ifndef DP_LINK_SQUARE_PATTERN
-#define DP_LINK_SQUARE_PATTERN				0x10F
-#endif
-#ifndef DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX
-#define DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX		0x2217
-#endif
 #ifndef DP_TEST_264BIT_CUSTOM_PATTERN_7_0
 #define DP_TEST_264BIT_CUSTOM_PATTERN_7_0		0X2230
 #endif
@@ -988,10 +976,6 @@ struct dpcd_usb4_dp_tunneling_info {
 #define DP_INTRA_HOP_AUX_REPLY_INDICATION		(1 << 3)
 /* TODO - Use DRM header to replace above once available */
 #endif // DP_INTRA_HOP_AUX_REPLY_INDICATION
-
-#ifndef DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE
-#define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE	0x50
-#endif
 union dp_main_line_channel_coding_cap {
 	struct {
 		uint8_t DP_8b_10b_SUPPORTED	:1;
@@ -1368,4 +1352,54 @@ struct dp_trace {
 	bool is_initialized;
 	struct edp_trace_power_timestamps edp_trace_power_timestamps;
 };
+
+/* TODO - This is a temporary location for any new DPCD definitions.
+ * We should move these to drm_dp header.
+ */
+#ifndef DP_LINK_SQUARE_PATTERN
+#define DP_LINK_SQUARE_PATTERN				0x10F
+#endif
+#ifndef DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX
+#define DP_CABLE_ATTRIBUTES_UPDATED_BY_DPRX		0x2217
+#endif
+#ifndef DP_CABLE_ATTRIBUTES_UPDATED_BY_DPTX
+#define DP_CABLE_ATTRIBUTES_UPDATED_BY_DPTX		0x110
+#endif
+#ifndef DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE
+#define DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE	0x50
+#endif
+#ifndef DP_TUNNELING_IRQ
+#define DP_TUNNELING_IRQ				(1 << 5)
+#endif
+/** USB4 DPCD BW Allocation Registers Chapter 10.7 **/
+#ifndef DP_TUNNELING_CAPABILITIES
+#define DP_TUNNELING_CAPABILITIES			0xE000D /* 1.4a */
+#endif
+#ifndef USB4_DRIVER_ID
+#define USB4_DRIVER_ID					0xE000F /* 1.4a */
+#endif
+#ifndef USB4_DRIVER_BW_CAPABILITY
+#define USB4_DRIVER_BW_CAPABILITY			0xE0020 /* 1.4a */
+#endif
+#ifndef DP_IN_ADAPTER_TUNNEL_INFO
+#define DP_IN_ADAPTER_TUNNEL_INFO			0xE0021 /* 1.4a */
+#endif
+#ifndef DP_BW_GRANULALITY
+#define DP_BW_GRANULALITY				0xE0022 /* 1.4a */
+#endif
+#ifndef ESTIMATED_BW
+#define ESTIMATED_BW					0xE0023 /* 1.4a */
+#endif
+#ifndef ALLOCATED_BW
+#define ALLOCATED_BW					0xE0024 /* 1.4a */
+#endif
+#ifndef DP_TUNNELING_STATUS
+#define DP_TUNNELING_STATUS				0xE0025 /* 1.4a */
+#endif
+#ifndef DPTX_BW_ALLOCATION_MODE_CONTROL
+#define DPTX_BW_ALLOCATION_MODE_CONTROL			0xE0030 /* 1.4a */
+#endif
+#ifndef REQUESTED_BW
+#define REQUESTED_BW					0xE0031 /* 1.4a */
+#endif
 #endif /* DC_DP_TYPES_H */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
deleted file mode 100644
index 80e18c770cda..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ /dev/null
@@ -1,579 +0,0 @@
-/*
- * Copyright 2012-14 Advanced Micro Devices, Inc.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-#ifndef DC_LINK_H_
-#define DC_LINK_H_
-
-#include "dc.h"
-#include "dc_types.h"
-#include "grph_object_defs.h"
-
-struct link_resource;
-enum aux_return_code_type;
-
-enum dc_link_fec_state {
-	dc_link_fec_not_ready,
-	dc_link_fec_ready,
-	dc_link_fec_enabled
-};
-
-/* DP MST stream allocation (payload bandwidth number) */
-struct link_mst_stream_allocation {
-	/* DIG front */
-	const struct stream_encoder *stream_enc;
-	/* HPO DP Stream Encoder */
-	const struct hpo_dp_stream_encoder *hpo_dp_stream_enc;
-	/* associate DRM payload table with DC stream encoder */
-	uint8_t vcp_id;
-	/* number of slots required for the DP stream in transport packet */
-	uint8_t slot_count;
-};
-
-/* DP MST stream allocation table */
-struct link_mst_stream_allocation_table {
-	/* number of DP video streams */
-	int stream_count;
-	/* array of stream allocations */
-	struct link_mst_stream_allocation stream_allocations[MAX_CONTROLLER_NUM];
-};
-
-struct edp_trace_power_timestamps {
-	uint64_t poweroff;
-	uint64_t poweron;
-};
-
-struct dp_trace_lt_counts {
-	unsigned int total;
-	unsigned int fail;
-};
-
-struct dp_trace_lt {
-	struct dp_trace_lt_counts counts;
-	struct dp_trace_timestamps {
-		unsigned long long start;
-		unsigned long long end;
-	} timestamps;
-	enum link_training_result result;
-	bool is_logged;
-};
-
-struct dp_trace {
-	struct dp_trace_lt detect_lt_trace;
-	struct dp_trace_lt commit_lt_trace;
-	unsigned int link_loss_count;
-	bool is_initialized;
-	struct edp_trace_power_timestamps edp_trace_power_timestamps;
-};
-
-/* PSR feature flags */
-struct psr_settings {
-	bool psr_feature_enabled;		// PSR is supported by sink
-	bool psr_allow_active;			// PSR is currently active
-	enum dc_psr_version psr_version;		// Internal PSR version, determined based on DPCD
-	bool psr_vtotal_control_support;	// Vtotal control is supported by sink
-	unsigned long long psr_dirty_rects_change_timestamp_ns;	// for delay of enabling PSR-SU
-
-	/* These parameters are calculated in Driver,
-	 * based on display timing and Sink capabilities.
-	 * If VBLANK region is too small and Sink takes a long time
-	 * to set up RFB, it may take an extra frame to enter PSR state.
-	 */
-	bool psr_frame_capture_indication_req;
-	unsigned int psr_sdp_transmit_line_num_deadline;
-	uint8_t force_ffu_mode;
-	unsigned int psr_power_opt;
-};
-
-/* To split out "global" and "per-panel" config settings.
- * Add a struct dc_panel_config under dc_link
- */
-struct dc_panel_config {
-	/* extra panel power sequence parameters */
-	struct pps {
-		unsigned int extra_t3_ms;
-		unsigned int extra_t7_ms;
-		unsigned int extra_delay_backlight_off;
-		unsigned int extra_post_t7_ms;
-		unsigned int extra_pre_t11_ms;
-		unsigned int extra_t12_ms;
-		unsigned int extra_post_OUI_ms;
-	} pps;
-	/* PSR */
-	struct psr {
-		bool disable_psr;
-		bool disallow_psrsu;
-		bool rc_disable;
-		bool rc_allow_static_screen;
-		bool rc_allow_fullscreen_VPB;
-	} psr;
-	/* ABM */
-	struct varib {
-		unsigned int varibright_feature_enable;
-		unsigned int def_varibright_level;
-		unsigned int abm_config_setting;
-	} varib;
-	/* edp DSC */
-	struct dsc {
-		bool disable_dsc_edp;
-		unsigned int force_dsc_edp_policy;
-	} dsc;
-	/* eDP ILR */
-	struct ilr {
-		bool optimize_edp_link_rate; /* eDP ILR */
-	} ilr;
-};
-
-/*
- *  USB4 DPIA BW ALLOCATION STRUCTS
- */
-struct dc_dpia_bw_alloc {
-	int sink_verified_bw;  // The Verified BW that sink can allocated and use that has been verified already
-	int sink_allocated_bw; // The Actual Allocated BW that sink currently allocated
-	int sink_max_bw;       // The Max BW that sink can require/support
-	int estimated_bw;      // The estimated available BW for this DPIA
-	int bw_granularity;    // BW Granularity
-	bool bw_alloc_enabled; // The BW Alloc Mode Support is turned ON for all 3:  DP-Tx & Dpia & CM
-	bool response_ready;   // Response ready from the CM side
-};
-
-#define MAX_SINKS_PER_LINK 4
-
-/*
- * A link contains one or more sinks and their connected status.
- * The currently active signal type (HDMI, DP-SST, DP-MST) is also reported.
- */
-struct dc_link {
-	struct dc_sink *remote_sinks[MAX_SINKS_PER_LINK];
-	unsigned int sink_count;
-	struct dc_sink *local_sink;
-	unsigned int link_index;
-	enum dc_connection_type type;
-	enum signal_type connector_signal;
-	enum dc_irq_source irq_source_hpd;
-	enum dc_irq_source irq_source_hpd_rx;/* aka DP Short Pulse  */
-	bool is_hpd_filter_disabled;
-	bool dp_ss_off;
-
-	/**
-	 * @link_state_valid:
-	 *
-	 * If there is no link and local sink, this variable should be set to
-	 * false. Otherwise, it should be set to true; usually, the function
-	 * core_link_enable_stream sets this field to true.
-	 */
-	bool link_state_valid;
-	bool aux_access_disabled;
-	bool sync_lt_in_progress;
-	bool is_internal_display;
-
-	/* TODO: Rename. Flag an endpoint as having a programmable mapping to a
-	 * DIG encoder. */
-	bool is_dig_mapping_flexible;
-	bool hpd_status; /* HPD status of link without physical HPD pin. */
-	bool is_hpd_pending; /* Indicates a new received hpd */
-	bool is_automated; /* Indicates automated testing */
-
-	bool edp_sink_present;
-
-	struct dp_trace dp_trace;
-
-	/* caps is the same as reported_link_cap. link_traing use
-	 * reported_link_cap. Will clean up.  TODO
-	 */
-	struct dc_link_settings reported_link_cap;
-	struct dc_link_settings verified_link_cap;
-	struct dc_link_settings cur_link_settings;
-	struct dc_lane_settings cur_lane_setting[LANE_COUNT_DP_MAX];
-	struct dc_link_settings preferred_link_setting;
-	/* preferred_training_settings are override values that
-	 * come from DM. DM is responsible for the memory
-	 * management of the override pointers.
-	 */
-	struct dc_link_training_overrides preferred_training_settings;
-	struct dp_audio_test_data audio_test_data;
-
-	uint8_t ddc_hw_inst;
-
-	uint8_t hpd_src;
-
-	uint8_t link_enc_hw_inst;
-	/* DIG link encoder ID. Used as index in link encoder resource pool.
-	 * For links with fixed mapping to DIG, this is not changed after dc_link
-	 * object creation.
-	 */
-	enum engine_id eng_id;
-
-	bool test_pattern_enabled;
-	union compliance_test_state compliance_test_state;
-
-	void *priv;
-
-	struct ddc_service *ddc;
-
-	bool aux_mode;
-
-	/* Private to DC core */
-
-	const struct dc *dc;
-
-	struct dc_context *ctx;
-
-	struct panel_cntl *panel_cntl;
-	struct link_encoder *link_enc;
-	struct graphics_object_id link_id;
-	/* Endpoint type distinguishes display endpoints which do not have entries
-	 * in the BIOS connector table from those that do. Helps when tracking link
-	 * encoder to display endpoint assignments.
-	 */
-	enum display_endpoint_type ep_type;
-	union ddi_channel_mapping ddi_channel_mapping;
-	struct connector_device_tag_info device_tag;
-	struct dpcd_caps dpcd_caps;
-	uint32_t dongle_max_pix_clk;
-	unsigned short chip_caps;
-	unsigned int dpcd_sink_count;
-#if defined(CONFIG_DRM_AMD_DC_HDCP)
-	struct hdcp_caps hdcp_caps;
-#endif
-	enum edp_revision edp_revision;
-	union dpcd_sink_ext_caps dpcd_sink_ext_caps;
-
-	struct psr_settings psr_settings;
-
-	/* Drive settings read from integrated info table */
-	struct dc_lane_settings bios_forced_drive_settings;
-
-	/* Vendor specific LTTPR workaround variables */
-	uint8_t vendor_specific_lttpr_link_rate_wa;
-	bool apply_vendor_specific_lttpr_link_rate_wa;
-
-	/* MST record stream using this link */
-	struct link_flags {
-		bool dp_keep_receiver_powered;
-		bool dp_skip_DID2;
-		bool dp_skip_reset_segment;
-		bool dp_skip_fs_144hz;
-		bool dp_mot_reset_segment;
-		/* Some USB4 docks do not handle turning off MST DSC once it has been enabled. */
-		bool dpia_mst_dsc_always_on;
-		/* Forced DPIA into TBT3 compatibility mode. */
-		bool dpia_forced_tbt3_mode;
-		bool dongle_mode_timing_override;
-	} wa_flags;
-	struct link_mst_stream_allocation_table mst_stream_alloc_table;
-
-	struct dc_link_status link_status;
-	struct dprx_states dprx_states;
-
-	struct gpio *hpd_gpio;
-	enum dc_link_fec_state fec_state;
-	bool link_powered_externally;	// Used to bypass hardware sequencing delays when panel is powered down forcibly
-
-	struct dc_panel_config panel_config;
-	struct phy_state phy_state;
-	// BW ALLOCATON USB4 ONLY
-	struct dc_dpia_bw_alloc dpia_bw_alloc_config;
-};
-
-
-/**
- * dc_get_link_at_index() - Return an enumerated dc_link.
- *
- * dc_link order is constant and determined at
- * boot time.  They cannot be created or destroyed.
- * Use dc_get_caps() to get number of links.
- */
-static inline struct dc_link *dc_get_link_at_index(struct dc *dc, uint32_t link_index)
-{
-	return dc->links[link_index];
-}
-
-static inline void get_edp_links(const struct dc *dc,
-		struct dc_link **edp_links,
-		int *edp_num)
-{
-	int i;
-
-	*edp_num = 0;
-	for (i = 0; i < dc->link_count; i++) {
-		// report any eDP links, even unconnected DDI's
-		if (!dc->links[i])
-			continue;
-		if (dc->links[i]->connector_signal == SIGNAL_TYPE_EDP) {
-			edp_links[*edp_num] = dc->links[i];
-			if (++(*edp_num) == MAX_NUM_EDP)
-				return;
-		}
-	}
-}
-
-static inline bool dc_get_edp_link_panel_inst(const struct dc *dc,
-		const struct dc_link *link,
-		unsigned int *inst_out)
-{
-	struct dc_link *edp_links[MAX_NUM_EDP];
-	int edp_num, i;
-
-	*inst_out = 0;
-	if (link->connector_signal != SIGNAL_TYPE_EDP)
-		return false;
-	get_edp_links(dc, edp_links, &edp_num);
-	for (i = 0; i < edp_num; i++) {
-		if (link == edp_links[i])
-			break;
-		(*inst_out)++;
-	}
-	return true;
-}
-
-/* Set backlight level of an embedded panel (eDP, LVDS).
- * backlight_pwm_u16_16 is unsigned 32 bit with 16 bit integer
- * and 16 bit fractional, where 1.0 is max backlight value.
- */
-bool dc_link_set_backlight_level(const struct dc_link *dc_link,
-		uint32_t backlight_pwm_u16_16,
-		uint32_t frame_ramp);
-
-/* Set/get nits-based backlight level of an embedded panel (eDP, LVDS). */
-bool dc_link_set_backlight_level_nits(struct dc_link *link,
-		bool isHDR,
-		uint32_t backlight_millinits,
-		uint32_t transition_time_in_ms);
-
-bool dc_link_get_backlight_level_nits(struct dc_link *link,
-		uint32_t *backlight_millinits,
-		uint32_t *backlight_millinits_peak);
-
-int dc_link_get_backlight_level(const struct dc_link *dc_link);
-
-int dc_link_get_target_backlight_pwm(const struct dc_link *link);
-
-bool dc_link_set_psr_allow_active(struct dc_link *dc_link, const bool *enable,
-		bool wait, bool force_static, const unsigned int *power_opts);
-
-bool dc_link_get_psr_state(const struct dc_link *dc_link, enum dc_psr_state *state);
-
-bool dc_link_setup_psr(struct dc_link *dc_link,
-		const struct dc_stream_state *stream, struct psr_config *psr_config,
-		struct psr_context *psr_context);
-
-bool dc_link_get_hpd_state(struct dc_link *dc_link);
-
-/* Notify DC about DP RX Interrupt (aka Short Pulse Interrupt).
- * Return:
- * true - Downstream port status changed. DM should call DC to do the
- * detection.
- * false - no change in Downstream port status. No further action required
- * from DM. */
-bool dc_link_handle_hpd_rx_irq(struct dc_link *dc_link,
-		union hpd_irq_data *hpd_irq_dpcd_data, bool *out_link_loss,
-		bool defer_handling, bool *has_left_work);
-
-/*
- * On eDP links this function call will stall until T12 has elapsed.
- * If the panel is not in power off state, this function will return
- * immediately.
- */
-bool dc_link_wait_for_t12(struct dc_link *link);
-
-void dc_link_dp_handle_automated_test(struct dc_link *link);
-void dc_link_dp_handle_link_loss(struct dc_link *link);
-bool dc_link_dp_allow_hpd_rx_irq(const struct dc_link *link);
-bool dc_link_check_link_loss_status(struct dc_link *link,
-		union hpd_irq_data *hpd_irq_dpcd_data);
-enum dc_status dc_link_dp_read_hpd_rx_irq_data(
-	struct dc_link *link,
-	union hpd_irq_data *irq_data);
-struct dc_sink_init_data;
-
-struct dc_sink *dc_link_add_remote_sink(
-		struct dc_link *dc_link,
-		const uint8_t *edid,
-		int len,
-		struct dc_sink_init_data *init_data);
-
-void dc_link_remove_remote_sink(
-	struct dc_link *link,
-	struct dc_sink *sink);
-
-/* Used by diagnostics for virtual link at the moment */
-
-bool dc_link_dp_set_test_pattern(
-	struct dc_link *link,
-	enum dp_test_pattern test_pattern,
-	enum dp_test_pattern_color_space test_pattern_color_space,
-	const struct link_training_settings *p_link_settings,
-	const unsigned char *p_custom_pattern,
-	unsigned int cust_pattern_size);
-
-bool dc_link_dp_get_max_link_enc_cap(const struct dc_link *link, struct dc_link_settings *max_link_enc_cap);
-
-/**
- *****************************************************************************
- *  Function: dc_link_enable_hpd_filter
- *
- *  @brief
- *     If enable is true, programs HPD filter on associated HPD line to default
- *     values dependent on link->connector_signal
- *
- *     If enable is false, programs HPD filter on associated HPD line with no
- *     delays on connect or disconnect
- *
- *  @param [in] link: pointer to the dc link
- *  @param [in] enable: boolean specifying whether to enable hbd
- *****************************************************************************
- */
-void dc_link_enable_hpd_filter(struct dc_link *link, bool enable);
-
-bool dc_link_is_dp_sink_present(struct dc_link *link);
-/*
- * DPCD access interfaces
- */
-
-void dc_link_set_drive_settings(struct dc *dc,
-				struct link_training_settings *lt_settings,
-				const struct dc_link *link);
-void dc_link_set_preferred_link_settings(struct dc *dc,
-					 struct dc_link_settings *link_setting,
-					 struct dc_link *link);
-void dc_link_set_preferred_training_settings(struct dc *dc,
-					struct dc_link_settings *link_setting,
-					struct dc_link_training_overrides *lt_overrides,
-					struct dc_link *link,
-					bool skip_immediate_retrain);
-void dc_link_enable_hpd(const struct dc_link *link);
-void dc_link_disable_hpd(const struct dc_link *link);
-void dc_link_set_test_pattern(struct dc_link *link,
-			enum dp_test_pattern test_pattern,
-			enum dp_test_pattern_color_space test_pattern_color_space,
-			const struct link_training_settings *p_link_settings,
-			const unsigned char *p_custom_pattern,
-			unsigned int cust_pattern_size);
-
-const struct dc_link_settings *dc_link_get_link_cap(
-		const struct dc_link *link);
-
-void dc_link_overwrite_extended_receiver_cap(
-		struct dc_link *link);
-
-bool dc_is_oem_i2c_device_present(
-	struct dc *dc,
-	size_t slave_address
-);
-
-bool dc_submit_i2c(
-		struct dc *dc,
-		uint32_t link_index,
-		struct i2c_command *cmd);
-
-bool dc_submit_i2c_oem(
-		struct dc *dc,
-		struct i2c_command *cmd);
-
-bool dc_link_is_fec_supported(const struct dc_link *link);
-bool dc_link_should_enable_fec(const struct dc_link *link);
-
-uint32_t dc_link_bw_kbps_from_raw_frl_link_rate_data(uint8_t bw);
-enum dp_link_encoding dc_link_dp_mst_decide_link_encoding_format(const struct dc_link *link);
-
-/* take a snapshot of current link resource allocation state */
-void dc_get_cur_link_res_map(const struct dc *dc, uint32_t *map);
-/* restore link resource allocation state from a snapshot */
-void dc_restore_link_res_map(const struct dc *dc, uint32_t *map);
-void dp_trace_reset(struct dc_link *link);
-bool dc_dp_trace_is_initialized(struct dc_link *link);
-unsigned long long dc_dp_trace_get_lt_end_timestamp(struct dc_link *link,
-		bool in_detection);
-void dc_dp_trace_set_is_logged_flag(struct dc_link *link,
-		bool in_detection,
-		bool is_logged);
-bool dc_dp_trace_is_logged(struct dc_link *link,
-		bool in_detection);
-struct dp_trace_lt_counts *dc_dp_trace_get_lt_counts(struct dc_link *link,
-		bool in_detection);
-unsigned int dc_dp_trace_get_link_loss_count(struct dc_link *link);
-
-/* Attempt to transfer the given aux payload. This function does not perform
- * retries or handle error states. The reply is returned in the payload->reply
- * and the result through operation_result. Returns the number of bytes
- * transferred,or -1 on a failure.
- */
-int dc_link_aux_transfer_raw(struct ddc_service *ddc,
-		struct aux_payload *payload,
-		enum aux_return_code_type *operation_result);
-
-enum lttpr_mode dc_link_decide_lttpr_mode(struct dc_link *link,
-		struct dc_link_settings *link_setting);
-void dc_link_dp_receiver_power_ctrl(struct dc_link *link, bool on);
-bool dc_link_decide_edp_link_settings(struct dc_link *link,
-		struct dc_link_settings *link_setting,
-		uint32_t req_bw);
-void dc_link_edp_panel_backlight_power_on(struct dc_link *link,
-		bool wait_for_hpd);
-
-/*
- *  USB4 DPIA BW ALLOCATION PUBLIC FUNCTIONS
- */
-/*
- * Send a request from DP-Tx requesting to allocate BW remotely after
- * allocating it locally. This will get processed by CM and a CB function
- * will be called.
- *
- * @link: pointer to the dc_link struct instance
- * @req_bw: The requested bw in Kbyte to allocated
- *
- * return: none
- */
-void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw);
-
-/*
- * Handle function for when the status of the Request above is complete.
- * We will find out the result of allocating on CM and update structs.
- *
- * @link: pointer to the dc_link struct instance
- * @bw: Allocated or Estimated BW depending on the result
- * @result: Response type
- *
- * return: none
- */
-void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result);
-
-/*
- * Handle the USB4 BW Allocation related functionality here:
- * Plug => Try to allocate max bw from timing parameters supported by the sink
- * Unplug => de-allocate bw
- *
- * @link: pointer to the dc_link struct instance
- * @peak_bw: Peak bw used by the link/sink
- *
- * return: allocated bw else return 0
- */
-int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *link, int peak_bw);
-
-/* TODO: this is not meant to be exposed to DM. Should switch to stream update
- * interface i.e stream_update->dsc_config
- */
-bool dc_link_update_dsc_config(struct pipe_ctx *pipe_ctx);
-#endif /* DC_LINK_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/Makefile b/drivers/gpu/drm/amd/display/dc/link/Makefile
index 40352d8d7648..a52b56e2859e 100644
--- a/drivers/gpu/drm/amd/display/dc/link/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/link/Makefile
@@ -55,7 +55,7 @@ LINK_PROTOCOLS = link_hpd.o link_ddc.o link_dpcd.o link_dp_dpia.o \
 link_dp_training.o link_dp_training_8b_10b.o link_dp_training_128b_132b.o \
 link_dp_training_dpia.o link_dp_training_auxless.o \
 link_dp_training_fixed_vs_pe_retimer.o link_dp_phy.o link_dp_capability.o \
-link_edp_panel_control.o link_dp_irq_handler.o
+link_edp_panel_control.o link_dp_irq_handler.o link_dp_dpia_bw.o
 
 AMD_DAL_LINK_PROTOCOLS = $(addprefix $(AMDDALPATH)/dc/link/protocols/, \
 $(LINK_PROTOCOLS))
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index c950857ef02c..65f43572011b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -26,10 +26,9 @@
 /*********************************************************************/
 //				USB4 DPIA BANDWIDTH ALLOCATION LOGIC
 /*********************************************************************/
-#include "dc.h"
 #include "link_dp_dpia_bw.h"
-#include "drm_dp_helper_dc.h"
 #include "link_dpcd.h"
+#include "dc_dmub_srv.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
@@ -195,15 +194,13 @@ static int get_host_router_total_bw(struct dc_link *link, uint8_t type)
  */
 static bool dpia_bw_alloc_unplug(struct dc_link *link)
 {
-	bool ret = false;
-
 	if (!link)
 		return true;
 
 	return deallocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
 			link->dpia_bw_alloc_config.sink_allocated_bw, link);
 }
-static void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw)
+void dc_link_set_usb4_req_bw_req(struct dc_link *link, int req_bw)
 {
 	uint8_t requested_bw;
 	uint32_t temp;
@@ -281,7 +278,6 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 			DC_LOG_DEBUG("%s: **** FAILURE Enabling DPtx BW Allocation Mode Support ***\n",
 					__func__);
 		} else {
-
 			// SUCCESS Enabled DPtx BW Allocation Mode Support
 			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
 			DC_LOG_DEBUG("%s: **** SUCCESS Enabling DPtx BW Allocation Mode Support ***\n",
@@ -297,6 +293,11 @@ bool link_dp_dpia_set_dptx_usb4_bw_alloc_support(struct dc_link *link)
 }
 void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uint8_t result)
 {
+	int bw_needed = 0;
+	int available = 0;
+	int estimated = 0;
+	int host_router_total_estimated_bw = 0;
+
 	if (!get_bw_alloc_proceed_flag((link)))
 		return;
 
@@ -330,12 +331,12 @@ void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uin
 		// 2. SUCCESS after prev. FAIL before any Pruning is done
 		// 3. SUCCESS after Pruning is done but before enabling link
 
-		int needed = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
+		bw_needed = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
 
 		// 1.
 		if (!link->dpia_bw_alloc_config.sink_allocated_bw) {
 
-			allocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw, needed, link);
+			allocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw, bw_needed, link);
 			link->dpia_bw_alloc_config.sink_verified_bw =
 					link->dpia_bw_alloc_config.sink_allocated_bw;
 
@@ -349,12 +350,12 @@ void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uin
 		else if (link->dpia_bw_alloc_config.sink_allocated_bw) {
 
 			// Find out how much do we need to de-alloc
-			if (link->dpia_bw_alloc_config.sink_allocated_bw > needed)
+			if (link->dpia_bw_alloc_config.sink_allocated_bw > bw_needed)
 				deallocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
-						link->dpia_bw_alloc_config.sink_allocated_bw - needed, link);
+						link->dpia_bw_alloc_config.sink_allocated_bw - bw_needed, link);
 			else
 				allocate_usb4_bw(&link->dpia_bw_alloc_config.sink_allocated_bw,
-						needed - link->dpia_bw_alloc_config.sink_allocated_bw, link);
+						bw_needed - link->dpia_bw_alloc_config.sink_allocated_bw, link);
 		}
 
 		// 4. If this is the 2nd sink then any unused bw will be reallocated to master DPIA
@@ -367,8 +368,8 @@ void dc_link_handle_usb4_bw_alloc_response(struct dc_link *link, uint8_t bw, uin
 
 		DC_LOG_DEBUG("%s: *** ESTIMATED BW CHANGED for DP-TX Request ***\n", __func__);
 
-		int available = 0, estimated = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
-		int host_router_total_estimated_bw = get_host_router_total_bw(link, HOST_ROUTER_BW_ESTIMATED);
+		estimated = bw * (Kbps_TO_Gbps / link->dpia_bw_alloc_config.bw_granularity);
+		host_router_total_estimated_bw = get_host_router_total_bw(link, HOST_ROUTER_BW_ESTIMATED);
 
 		// 1. If due to unplug of other sink
 		if (estimated == host_router_total_estimated_bw) {
@@ -415,7 +416,7 @@ int dc_link_dp_dpia_handle_usb4_bandwidth_allocation_for_link(struct dc_link *li
 		dc_link_set_usb4_req_bw_req(link, link->dpia_bw_alloc_config.sink_max_bw);
 
 		do {
-			if (!timeout > 0)
+			if (!(timeout > 0))
 				timeout--;
 			else
 				break;
@@ -449,7 +450,7 @@ int link_dp_dpia_allocate_usb4_bandwidth_for_stream(struct dc_link *link, int re
 	if (req_bw != link->dpia_bw_alloc_config.sink_allocated_bw) {
 		dc_link_set_usb4_req_bw_req(link, req_bw);
 		do {
-			if (!timeout > 0)
+			if (!(timeout > 0))
 				timeout--;
 			else
 				break;
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
index 46d141a1366f..e869e5e36568 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.h
@@ -25,7 +25,7 @@
 
 #ifndef DC_INC_LINK_DP_DPIA_BW_H_
 #define DC_INC_LINK_DP_DPIA_BW_H_
-
+#include "link.h"
 /*
  * Host Router BW type
  */
-- 
2.34.1

