Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E685AC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  5 May 2022 14:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B4810E05C;
	Thu,  5 May 2022 14:23:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8E9B10E05C
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 May 2022 14:23:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LYYBAb8Inb8uvQYo4Ii3w0/orXIB9/soX1G1mLCh1IMNQf1O98al/0Ljw5cF8Oq7JC7l34Fw+WWaGPTaKkQ3+dNFZ6YhiBwJCvClNtOwpULhZ+ok7K6dXp47/s5ncnl+8QuFO6RWMFsIq9DBgXn0JZS4sTlozPP1ErNxR8dIJJTkgjq9NxORZSFar3ED0nQZkxqTuSnOfJ2c3uLGjpzkXOstkbp+vmqemaAMdXB8rCmrMFkZVz3RXUrCFn8ULWgCFuZsCXTHnfWYJscwgErPmWjyu+zEMAceLwPH2FZfn+x8RLaay1iLQWTEW9c230lAA+mBJmFEDwpoo0jhorEv/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc1taukHv19UQO+KFHbN6Bw64nsLtW+yhlxLQm8ZjjU=;
 b=RgWyFCw6haHRXo7DWxnKrxNtuc8V1YO406YjSEpE2idjSCuVUGxhaKNJQV3IYhQZqrBJYuwjU/m6tbhmeFL6fQY+M6a2sTOvBCuYbyhOlwGl7Ixk94FxA2MIA+Wv8HroK7xlT+JP3PHK7ChWKK0KpuJmJbA0NiNZdVTc7A6t2dE8wAhFW+gEJ8H+mVw4zz+0fawa55JDHfCq5H4oRVuGRDNnya8gPvwdHNke31EPvGqQccDXDBS5se8CfdLeR2Uy3UEDdANlxaMNaM4Icq6+PMJWi3BAo150mtX75OHUe/teB/Ke5ZpslYR0LjD88bP3O/e2M9Be3sPrO3r7cQroyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc1taukHv19UQO+KFHbN6Bw64nsLtW+yhlxLQm8ZjjU=;
 b=ZE3RXOMZmJp1+WuDqxCOAXxLI7QJZGkHMDbjieMmJuAjPOY9WQ0767/7ZNr0i1/k6fH0RGEdetE4PrDR/HZRCt9DZ72rfWR3n3VrO9ZqyNTm0n8MSK4mhtMTyKbIxZ2c7N7nJQ6WsuCt/9lJJtg33eoQc+D23LnXY2c62jhilcM=
Received: from DM6PR06CA0022.namprd06.prod.outlook.com (2603:10b6:5:120::35)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Thu, 5 May
 2022 14:23:41 +0000
Received: from DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::ed) by DM6PR06CA0022.outlook.office365.com
 (2603:10b6:5:120::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Thu, 5 May 2022 14:23:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT013.mail.protection.outlook.com (10.13.173.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Thu, 5 May 2022 14:23:40 +0000
Received: from Gundam.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 5 May
 2022 09:23:39 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/17] drm/amd/display: align dmub cmd header to latest dmub
 FW to support PSR-SU
Date: Thu, 5 May 2022 10:23:07 -0400
Message-ID: <20220505142323.2566949-2-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220505142323.2566949-1-dingchen.zhang@amd.com>
References: <20220505142323.2566949-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a339ea1-0eae-49b8-6ead-08da2ea2da6c
X-MS-TrafficTypeDiagnostic: BL3PR12MB6569:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB65696C39E5E8C564032E0E7C8DC29@BL3PR12MB6569.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NTxdPcGms1xpu/+4lud1Y6PhJdmvfjaTUQxkvAsOsuI1XzRM7YANPpdEFsEmfY5lK3X9U4UBp9SNSyKSwhmkhk4oQi09ReHZgxRtCNom2b/x5/9/3fz0Y2rf8G5CTA20VwVSm+ObYasRk/ud9uxQeLlDRZtLa3nnp5ORqeGW8JhLcRFJXhk5IF1B6nFNb6XSwBwxOO+5awpGrgcqqdihwAFw1XnPsdGRsSwbmCOXJAwl9yhic9rOytCg7upZaxKo8B/wjBMsgKhW0alSP3rEHuu9pelBQ+vrH2xYoMHiBFHbEhCySjWsiWcy6ppfExSp31uJcqjvTmK4uvX0ibyDM1N1RrT0aK6qHTg1ENGiS02X6T7DIqHUdIQNiU439ImKXLw/Q+qIFpx0H5EsHDzOoMUAMYFLfctjVPiUGExW7ahrBaOfWgOmHwXudz/ltKmw5vYJqnmkvXNjufKoUgV0HvLu3nDwCBd1YRBiCDCYZrt8yt02mkSBlYYLdhnWMW+hYkc6B7F1TGlH2Gz40AXzt6X6We8dV/CVQ+MEyKjejpVy2yQ7mXjtHplYIbQkgGBwCM8+DJ0npmKYNpWyMJ6JSfMaDeIz0U37WFhCILQ/pzusWLcwpHoY5x1i6eXk4H18A/KeqHJlxgfTjmTElxunEz/GNZ2TuA7f1Cb/VVraf/E8131lboA8A2IZu2qQ/SRlyhNv+flTKFiijsetgc/eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(16526019)(5660300002)(54906003)(6916009)(82310400005)(7696005)(186003)(426003)(47076005)(1076003)(6666004)(40460700003)(2616005)(8936002)(356005)(2906002)(83380400001)(316002)(36756003)(8676002)(4326008)(70206006)(70586007)(36860700001)(81166007)(86362001)(336012)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 14:23:40.9528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a339ea1-0eae-49b8-6ead-08da2ea2da6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
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

