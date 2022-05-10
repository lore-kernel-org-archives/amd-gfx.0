Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E045DC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5749F10E832;
	Tue, 10 May 2022 20:45:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 482C510E819
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:45:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArfbhpkqsspzMryelDAKESop2S81ibReFYFa/a0P75nHSTn0yTL7i1qIdjNIcgwffIInZlHvnHXF9UGTolHw6NrTemhTCMlvcxkhRuL5DHOOoLAak4bOLk3uiija8BOqTVS7o/kwJrD3X7o8fUNB4Yr99dBCvVFpyCOCbjaFc7saqqEvtkMUAd6DSaog1ICHXmIl0zThuVeHZ4UFa7KcL+BqmTASnBR/qEQbBBwkTggq/fje1uH0i1GdHNjC4Z0/XTaiBRcDfoK2i20msRmrBeAXB19o3nlcDFngzadtZnGScC7pBCIg1FO16z/pwEPzv8+iU3T4WwUTux+gB+7hYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc1taukHv19UQO+KFHbN6Bw64nsLtW+yhlxLQm8ZjjU=;
 b=TLQDUtcrFLNAXkzWTSp5XaV94uXYyl8DFmSa6+pWx3uk9gixS3pUsnvRd1WmnDSYsfOU7jyL/rgAZVQfpqLJBVYt+8MnW+cy2aNk2V8ChSnSRiseKpFP/t0q/z3EOMbZd3LejjhhlvDFbzRu/nVekAAvGp10Bn46bMhA9kdHT+umeBGxN3xvF2NLjuGXtDaov296CyD5Zvq73V/A+wuIirMwoDQ0vyc/7aOYhAgHQdbMFPEAAdqjwPtn24PgFVtXkSdS5MnEmABnoJTVekgvHIDrnH/EfbjgwO3fh0KMLx/PFbDkNJHPhmo3Nkm8lS2RZRJNxNRM7wqqt+WOgTEfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc1taukHv19UQO+KFHbN6Bw64nsLtW+yhlxLQm8ZjjU=;
 b=HcOLxQzYpCMssCDKHJFoJzhU/08aBS+08lxZFdutJHSfbY225xT5DHADuSGyGmjr4Hak8dJK6OYyM/6SfR8jHhS+k3Mpd+eewThCBRkflyEKfST4BHkXK+S5t1vDYrh9U09mzmXP6aQGalsPQ88Ool7xtD9tnvvjXSpMg51F4qg=
Received: from MW4PR03CA0358.namprd03.prod.outlook.com (2603:10b6:303:dc::33)
 by BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:3b3::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 20:45:24 +0000
Received: from CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::a1) by MW4PR03CA0358.outlook.office365.com
 (2603:10b6:303:dc::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Tue, 10 May 2022 20:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT008.mail.protection.outlook.com (10.13.175.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 10 May 2022 20:45:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:45:22 -0500
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:45:20 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 01/19] drm/amd/display: align dmub cmd header to latest
 dmub FW to support PSR-SU
Date: Tue, 10 May 2022 16:44:50 -0400
Message-ID: <20220510204508.506089-2-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a40a491f-d57f-49ef-004e-08da32c601b7
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB63800FD664ACD1AA691B7C388DC99@BL3PR12MB6380.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lk9zAdVkzjRqv8VjHo08Z7Oq+JOZ39ff9fvSVeGKLpZ0R1V3H5P1iLZDaRgYXFDwyip6z9Xvwt9dg6iLWY6uNkcQZilsf55H1RRsDZv072C1TMRxv7ZfWd//Cbi3o3CQbT0d2Y5k9IPi4VslfvzSLC0qJVoi7zcsGZOc1Cj/No1NN9Yrk1ratjhs46AVRx4p8IswAtkwvSP0qX1YUtXfMjZRFBpwDf9xznJz8UBVWwCIiY1N0+IiZF9fM1tsWsPOGevdx4b8fnMXcPojImkwzrs+PxJ7z9kaj08rOSd+3u8JQt50X3buMae5Dl4pBZPiCZckiOAKQCp3ITZWVWbEUB/b6B2IGNUVKYDvd57hXN5iyN4xVY+dGDLTzyWQX/EIfiTNqYiSV0AaKBmUieMAHtcFkMcK1b5RtZh50FBGv33lolWfGBAziYz/fLdWyeF+6IRAmbEr98wy+iwrN+rjChAfOX/wLSsX2pE3M9g49lwVdgV7b4XVl4Ssvx9Ps51I55AvJxVZCcIfbXZhe+BPv1/XBATGgK/B5GCuAR6kfN6334e85kRR0owv0V+7Ei53nu/VER0dua3MRt+++vl+v5PjMpIousnP14L++OF9MFF7hIf8ydAjdZuz1iiWrPA3EzSfyeA8x78FXIKHcULnN8WB7tzZwpy6MxS2eGwJpz/XZu4HWSxfUAaRXmuhJK10fmswkn4X8Ij3wbmGCj5Pow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(356005)(6666004)(54906003)(36860700001)(4326008)(81166007)(336012)(426003)(40460700003)(2906002)(6916009)(83380400001)(186003)(26005)(7696005)(1076003)(82310400005)(70206006)(70586007)(2616005)(8676002)(508600001)(5660300002)(47076005)(316002)(8936002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:45:23.8155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a40a491f-d57f-49ef-004e-08da32c601b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6380
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
PSR-SU is implemented in upstreamed dmub FW but not enabled on
DM and DC. We'd add necessary and missing definitions in dmub
cmd header to align w/ the up-to-date DMUB FW for PSR-SU support.

[how]
Add definitions and items below into dmub cmd header:
- DMUB psr version enumeration for PSR-SU
- dirty rectangle structure
- psr debug flag of forcing full frame update
- dmub command of updating dirty rectangle and cursor infor
- dmub psr command type of setting sink vtotal in PSR active
- dmub psr su debug flags structure
- dmub cmd structure for
  - updating dirty rectangle
  - cursor infor
  - setting sink vtotal
- dmub ringbuffer command items

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 250 +++++++++++++++++-
 1 file changed, 245 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 385c28238beb..c6d9e9d0acab 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -101,6 +101,11 @@
 /* Trace buffer offset for entry */
 #define TRACE_BUFFER_ENTRY_OFFSET  16
 
+/**
+ * Maximum number of dirty rects supported by FW.
+ */
+#define DMUB_MAX_DIRTY_RECTS 3
+
 /**
  *
  * PSR control version legacy
@@ -165,6 +170,31 @@ union dmub_addr {
 	uint64_t quad_part; /*<< 64 bit address */
 };
 
+/**
+ * Dirty rect definition.
+ */
+struct dmub_rect {
+	/**
+	 * Dirty rect x offset.
+	 */
+	uint32_t x;
+
+	/**
+	 * Dirty rect y offset.
+	 */
+	uint32_t y;
+
+	/**
+	 * Dirty rect width.
+	 */
+	uint32_t width;
+
+	/**
+	 * Dirty rect height.
+	 */
+	uint32_t height;
+};
+
 /**
  * Flags that can be set by driver to change some PSR behaviour.
  */
@@ -177,6 +207,12 @@ union dmub_psr_debug_flags {
 		 * Enable visual confirm in FW.
 		 */
 		uint32_t visual_confirm : 1;
+
+		/**
+		 * Force all selective updates to bw full frame updates.
+		 */
+		uint32_t force_full_frame_update : 1;
+
 		/**
 		 * Use HW Lock Mgr object to do HW locking in FW.
 		 */
@@ -616,6 +652,14 @@ enum dmub_cmd_type {
 	 * Command type used for all ABM commands.
 	 */
 	DMUB_CMD__ABM = 66,
+	/**
+	 * Command type used to update dirty rects in FW.
+	 */
+	DMUB_CMD__UPDATE_DIRTY_RECT = 67,
+	/**
+	 * Command type used to update cursor info in FW.
+	 */
+	DMUB_CMD__UPDATE_CURSOR_INFO = 68,
 	/**
 	 * Command type used for HW locking in FW.
 	 */
@@ -1419,6 +1463,10 @@ enum dmub_cmd_psr_type {
 	 * Forces PSR enabled until an explicit PSR disable call.
 	 */
 	DMUB_CMD__PSR_FORCE_STATIC		= 5,
+	/**
+	 * Set vtotal in psr active for FreeSync PSR.
+	 */
+	DMUB_CMD__SET_SINK_VTOTAL_IN_PSR_ACTIVE = 6,
 	/**
 	 * Set PSR power option
 	 */
@@ -1433,6 +1481,10 @@ enum psr_version {
 	 * PSR version 1.
 	 */
 	PSR_VERSION_1				= 0,
+	/**
+	 * Freesync PSR SU.
+	 */
+	PSR_VERSION_SU_1			= 1,
 	/**
 	 * PSR not supported.
 	 */
@@ -1600,9 +1652,15 @@ struct dmub_cmd_psr_copy_settings_data {
 	 */
 	uint8_t frame_cap_ind;
 	/**
-	 * Explicit padding to 4 byte boundary.
+	 * Granularity of Y offset supported by sink.
 	 */
-	uint8_t pad[2];
+	uint8_t su_y_granularity;
+	/**
+	 * Indicates whether sink should start capturing
+	 * immediately following active scan line,
+	 * or starting with the 2nd active scan line.
+	 */
+	uint8_t line_capture_indication;
 	/**
 	 * Multi-display optimizations are implemented on certain ASICs.
 	 */
@@ -1613,9 +1671,13 @@ struct dmub_cmd_psr_copy_settings_data {
 	 */
 	uint16_t init_sdp_deadline;
 	/**
-	 * Explicit padding to 4 byte boundary.
+	 * @ rate_control_caps : Indicate FreeSync PSR Sink Capabilities
+	 */
+	uint8_t rate_control_caps ;
+	/*
+	 * Force PSRSU always doing full frame update
 	 */
-	uint16_t pad2;
+	uint8_t force_ffu_mode;
 	/**
 	 * Length of each horizontal line in us.
 	 */
@@ -1807,6 +1869,164 @@ struct dmub_rb_cmd_psr_force_static {
 	struct dmub_cmd_psr_force_static_data psr_force_static_data;
 };
 
+/**
+ * PSR SU debug flags.
+ */
+union dmub_psr_su_debug_flags {
+	/**
+	 * PSR SU debug flags.
+	 */
+	struct {
+		/**
+		 * Update dirty rect in SW only.
+		 */
+		uint8_t update_dirty_rect_only : 1;
+		/**
+		 * Reset the cursor/plane state before processing the call.
+		 */
+		uint8_t reset_state : 1;
+	} bitfields;
+
+	/**
+	 * Union for debug flags.
+	 */
+	uint32_t u32All;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__UPDATE_DIRTY_RECT command.
+ * This triggers a selective update for PSR SU.
+ */
+struct dmub_cmd_update_dirty_rect_data {
+	/**
+	 * Dirty rects from OS.
+	 */
+	struct dmub_rect src_dirty_rects[DMUB_MAX_DIRTY_RECTS];
+	/**
+	 * PSR SU debug flags.
+	 */
+	union dmub_psr_su_debug_flags debug_flags;
+	/**
+	 * OTG HW instance.
+	 */
+	uint8_t pipe_idx;
+	/**
+	 * Number of dirty rects.
+	 */
+	uint8_t dirty_rect_count;
+	/**
+	 * PSR control version.
+	 */
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+};
+
+/**
+ * Definition of a DMUB_CMD__UPDATE_DIRTY_RECT command.
+ */
+struct dmub_rb_cmd_update_dirty_rect {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__UPDATE_DIRTY_RECT command.
+	 */
+	struct dmub_cmd_update_dirty_rect_data update_dirty_rect_data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__UPDATE_CURSOR_INFO command.
+ */
+struct dmub_cmd_update_cursor_info_data {
+	/**
+	 * Cursor dirty rects.
+	 */
+	struct dmub_rect cursor_rect;
+	/**
+	 * PSR SU debug flags.
+	 */
+	union dmub_psr_su_debug_flags debug_flags;
+	/**
+	 * Cursor enable/disable.
+	 */
+	uint8_t enable;
+	/**
+	 * OTG HW instance.
+	 */
+	uint8_t pipe_idx;
+	/**
+	 * PSR control version.
+	 */
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+};
+/**
+ * Definition of a DMUB_CMD__UPDATE_CURSOR_INFO command.
+ */
+struct dmub_rb_cmd_update_cursor_info {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Data passed from driver to FW in a DMUB_CMD__UPDATE_CURSOR_INFO command.
+	 */
+	struct dmub_cmd_update_cursor_info_data update_cursor_info_data;
+};
+
+/**
+ * Data passed from driver to FW in a DMUB_CMD__SET_SINK_VTOTAL_IN_PSR_ACTIVE command.
+ */
+struct dmub_cmd_psr_set_vtotal_data {
+	/**
+	 * 16-bit value dicated by driver that indicates the vtotal in PSR active requirement when screen idle..
+	 */
+	uint16_t psr_vtotal_idle;
+	/**
+	 * PSR control version.
+	 */
+	uint8_t cmd_version;
+	/**
+	 * Panel Instance.
+	 * Panel isntance to identify which psr_state to use
+	 * Currently the support is only for 0 or 1
+	 */
+	uint8_t panel_inst;
+	/*
+	 * 16-bit value dicated by driver that indicates the vtotal in PSR active requirement when doing SU/FFU.
+	 */
+	uint16_t psr_vtotal_su;
+	/**
+	 * Explicit padding to 4 byte boundary.
+	 */
+	uint8_t pad2[2];
+};
+
+/**
+ * Definition of a DMUB_CMD__SET_SINK_VTOTAL_IN_PSR_ACTIVE command.
+ */
+struct dmub_rb_cmd_psr_set_vtotal {
+	/**
+	 * Command header.
+	 */
+	struct dmub_cmd_header header;
+	/**
+	 * Definition of a DMUB_CMD__SET_SINK_VTOTAL_IN_PSR_ACTIVE command.
+	 */
+	struct dmub_cmd_psr_set_vtotal_data psr_set_vtotal_data;
+};
+
 /**
  * Data passed from driver to FW in a DMUB_CMD__SET_PSR_POWER_OPT command.
  */
@@ -1917,6 +2137,10 @@ enum hw_lock_client {
 	 * Driver is the client of HW Lock Manager.
 	 */
 	HW_LOCK_CLIENT_DRIVER = 0,
+	/**
+	 * PSR SU is the client of HW Lock Manager.
+	 */
+	HW_LOCK_CLIENT_PSR_SU		= 1,
 	/**
 	 * Invalid client.
 	 */
@@ -2620,7 +2844,6 @@ struct dmub_rb_cmd_get_usbc_cable_id {
  * union dmub_rb_cmd - DMUB inbox command.
  */
 union dmub_rb_cmd {
-	struct dmub_rb_cmd_lock_hw lock_hw;
 	/**
 	 * Elements shared with all commands.
 	 */
@@ -2681,6 +2904,23 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__PSR_FORCE_STATIC command.
 	 */
 	struct dmub_rb_cmd_psr_force_static psr_force_static;
+	/**
+	 * Definition of a DMUB_CMD__UPDATE_DIRTY_RECT command.
+	 */
+	struct dmub_rb_cmd_update_dirty_rect update_dirty_rect;
+	/**
+	 * Definition of a DMUB_CMD__UPDATE_CURSOR_INFO command.
+	 */
+	struct dmub_rb_cmd_update_cursor_info update_cursor_info;
+	/**
+	 * Definition of a DMUB_CMD__HW_LOCK command.
+	 * Command is used by driver and FW.
+	 */
+	struct dmub_rb_cmd_lock_hw lock_hw;
+	/**
+	 * Definition of a DMUB_CMD__SET_SINK_VTOTAL_IN_PSR_ACTIVE command.
+	 */
+	struct dmub_rb_cmd_psr_set_vtotal psr_set_vtotal;
 	/**
 	 * Definition of a DMUB_CMD__SET_PSR_POWER_OPT command.
 	 */
-- 
2.25.1

