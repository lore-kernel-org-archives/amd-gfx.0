Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A129606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=TP3b8LUA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93E110F8FA;
	Wed, 11 Nov 2026 01:45:38 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783B010F8FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:45:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThJqYhf3MXkyuuftOwC1rRURfGBtoBuFmmbs4VK8WrxpJ8bX896fVCi7rpGvkoaer17BPsdNBT2E9PmDYgx7CeRn4gK63nxyiOF6i94vxVGpJngl3cSTMnADvmrXyIY1pdmRYejcTsFkeIo+2tE/KBuwi5diuId7V82NdrTb5nd8Vnmc+KdBPLjmgCG7fgCcClKAgELSqo7bMRy8kKgzv6g0qn7E2TsPPMC2QzQWZil2WHSWBrGPDPtTTIWJLWnIpcRB5OP/8ei+Jj+NHDlnfyx60aYj6zBl/qwmxfh7RVNI45PFezOtcnTwbIJNgvGSSKK2MCU83bwFf+XklG5+CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veQ5oxDHiJsBtOhqL7hDveoDAQIL+dBYkZDprZgkwrY=;
 b=h5IYb4n80Bjew1Cna54ZKEOD1jAmBosbMAPUr6wmFCPAHKF076mLDH8ZmRZeNP8N63V5UGmyCFzHd8nwxIVWcdMUZzfPRBX69XgLRXcqxCVLecqBRHdUOsccFZFdtcQy6tH6qSqCQu/s5enGulxILtBdiyCZFdbcwJCgJrk2Da30cxX9e7oS7cbAE51OR3+8oTyzFiMLin/BLr+MR7zTXXJcJqSvgt47ym9iml7hXz1tbL84eL0M9Qj5Ol4mpKpCEJ0Nz5nQvgIqb6mopIE7olP2i9rnH2X0EF0QQel0zzrSTq5TRKE+0FAf+M7p+VuxfLuLfV4+TjDcE30JD2qopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=veQ5oxDHiJsBtOhqL7hDveoDAQIL+dBYkZDprZgkwrY=;
 b=TP3b8LUAqpaC4CrLRz27ciT48BF8NJ+zLKwqLfyyDh28OkYySPPEOlzqYND5ogblW1t1gcOOvLdrzNiBQj8cgT0Y9lsGhy4dHBOWX/HBcEanbAbMqc9ejwL7jTVjlUaPXvG6TCMvmr0qhfWTUmgdWxdI2eXaHxPO1TH6Arm1jCw=
Received: from MW3PR06CA0014.namprd06.prod.outlook.com (2603:10b6:303:2a::19)
 by LY0PR12MB888806.namprd12.prod.outlook.com (2603:10b6:404:234::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 01:45:27 +0000
Received: from EA8PEPF00000005.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::45) by MW3PR06CA0014.outlook.office365.com
 (2603:10b6:303:2a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:45:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF00000005.mail.protection.outlook.com (10.167.249.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:45:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:25 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:45:25 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:45:22 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ashwin Santhosh <Ashwin.Santhosh@amd.com>, "Dillon
 Varone" <dillon.varone@amd.com>
Subject: [PATCH 69/74] drm/amd/display: Account for split pipe overlap in alt
 channel copy size
Date: Wed, 11 Nov 2026 09:29:15 +0800
Message-ID: <20261111014100.3596072-70-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000005:EE_|LY0PR12MB888806:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a53f380-37da-4716-e6af-08df3f9575b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261009223027099003|10067099003|3023799007|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kvgeP6nGUgf3pVoZ+yzkE1Di7T9JNDQnoRzKzXcwB72qsBALrdbfuPqtPpaZQnBPG3zuqqa6nhzDN+61pfO1Oo1izn7ZPCYhROLCyaqKWGdxCtdovPYAv7uxBBd6jV2ykNbIuprjxp/G7EiGv1c8abEIzzUNn959v5xx7+kk9ORZBmasQrQ0/ivALU8csqc65sx0lFW9tU6ho9yHX3ooD58SmIZRS8p2a3ZBO/BPDwyk2p/CXtYUM7glk5ynfMckDlh/Q99kPYVES0/eT8BSfeKZTmP3CV8gnQlp4blv1BJDYSbXlUpypE6voesTbOikvpTCFgliAS2T4Fjfy0PxuMgGGhjO1tF+0FA2wO65M9dHVUDBHbAyVK9rkEzNtfKR/vgCxDQZ+GKNFb2Iq4ObiZ+EpwGC5EQEL81m3Em2L3R+phLdna6FCHLOqhUfBTEiXxLi14eToWDQlFGa9kuWPn6CNwUiQH0iBioqSSQTOGRGD6W+AXWr4yPXD9NsefinZoRLaZ10IOoehMfYlPfXfClCZ/Bd+AKf4aN5T4rowXaHufK3y5kp8oD80KhZIEgTwHDqU209nA6d4guz+mmIKiheaOupuc6E+ifdN0cq2VmigjlUL9FDIYqSeIWu9YRL6zq7yFpC9Ba+ejNLy8TJrUTYSRZWPLBvLA1fh7iOjYT94MXeoSzm5ujb+hvgInZt
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261009223027099003)(10067099003)(3023799007)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /VvrozaHpz6Vf3nsmQgMsOPB2D6wO8yVPsOxxtryyOVE34gDSiIbqR6Q77JE3I9Jkl5O/DsPEw+A2sxUHtFO7D4wVST7EY4g6csL63UYMhe7LdDttL6HF7Zz8ofUlvd/VP8aWmMJQbp51/89FUeK4Z80iIT1hisPq+C/m+Fqcjhjd6Skefipw2mF1Rcef/idPfIECxjEjHneSNBZ1VQM3irjaRTdgTPPZc1uPTj4bKX0g+ML/deGRk3pJ+xi4JFoxKlWGMNSKB8DEgVXyjFbbBA1K+d1Q2vs0qvi/epkKCc51mJ62vpJa6SsF+a4yFReTPVKHxXS+f6GHpwvAkWPHVIdYREbf6PlIzptjyGWAwl7sUhr8Tnj2voQxT/jpfLugZsju2ohk6EWoflLdLHkFxk9J3YnGrGdWXUT6bPsKrrzxMePUMwXyUbDfP1TUqMd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:45:26.5803 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a53f380-37da-4716-e6af-08df3f9575b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000005.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB888806
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ashwin Santhosh <Ashwin.Santhosh@amd.com>

[Why]
When a plane is split across pipes (ODM or MPC), each pipe's viewport
extends past its even share: scaler taps at the split, the leftover of
an uneven split, and the 4:2:x left edge pixel under ODM. DML sized the
per-pipe swath width and the alt channel copy region without these, so
with 8K VSR on a 4K240 panel (ODM 2:1, 6 taps) each pipe's copy was one
tile column too small and overran the next pipe's region, showing as
blocks of corruption during MCLK switches.

[How]
Add calculate_per_pipe_swath_width to pad the ODM and MPC swath widths
by these extra pixels, and size the alt channel copy from the swath
width for all pipe configs.

Cc: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Ashwin Santhosh <Ashwin.Santhosh@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    | 67 ++++++++++++++-----
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    | 26 ++-----
 2 files changed, 57 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index 569ab02ea080..9c1f66c18a19 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -242,6 +242,51 @@ void dcn5_calculate_byte_per_pixel_and_block_sizes(
 	DML_LOG_VERBOSE("DML::%s: MacroTileHeightC = %u\n", __func__, *MacroTileHeightC);
 }
 
+/*
+ * calculate_per_pipe_swath_width: Swath width of one pipe, accounting for the plane being split across pipes
+ * (ODM or MPC combine)
+ *
+ * Each pipe's viewport extends past its even share of the split:
+ * - max_recout_pixels: the widest recout (screen / dst pixels) any pipe of the split can get
+ * - h_taps: the scaler taps sampling past the split, already counted in surface (src) pixels
+ * h_ratio converts the recout into src pixels, since the swath is fetched from the surface.
+ */
+static unsigned int calculate_per_pipe_swath_width(const struct dml2_plane_parameters *plane,
+		const struct dml2_stream_parameters *stream, enum dml2_odm_mode odm_mode, unsigned int dpp_per_surface,
+		unsigned int single_dpp_swath_width, bool chroma)
+{
+	double h_ratio = chroma ? plane->composition.scaler_info.plane1.h_ratio : plane->composition.scaler_info.plane0.h_ratio;
+	unsigned int h_taps = chroma ? plane->composition.scaler_info.plane1.h_taps : plane->composition.scaler_info.plane0.h_taps;
+	unsigned int odm_factor;
+	double max_recout_pixels;
+	unsigned int swath_width;
+
+	if (odm_mode == dml2_odm_mode_combine_4to1)
+		odm_factor = 4;
+	else if (odm_mode == dml2_odm_mode_combine_3to1)
+		odm_factor = 3;
+	else if (odm_mode == dml2_odm_mode_combine_2to1)
+		odm_factor = 2;
+	else
+		odm_factor = 1;
+
+	if (odm_factor > 1) {
+		// h_active may not split evenly across ODM pipes. The last pipe takes the leftover, which is at most odm - 1 pixels
+		max_recout_pixels = (double)stream->timing.h_active / odm_factor + (odm_factor - 1);
+		// 4:2:0 / 4:2:2 outputs add a left edge pixel for the chroma subsampling filter
+		if (stream->output.output_format == dml2_420 || stream->output.output_format == dml2_s422 || stream->output.output_format == dml2_n422)
+			max_recout_pixels += 1;
+		swath_width = (unsigned int)math_ceil(max_recout_pixels * h_ratio) + h_taps;
+	} else if (dpp_per_surface == 2) {
+		// MPC splits the plane in half, with the leftover pixel of an odd width going to one pipe
+		swath_width = (single_dpp_swath_width + 1) / 2 + h_taps;
+	} else {
+		swath_width = single_dpp_swath_width;
+	}
+
+	return (unsigned int)math_min2((double)single_dpp_swath_width, (double)swath_width);
+}
+
 void dcn5_calculate_swath_width(
 		const struct dml2_display_cfg *display_cfg,
 		bool ForceSingleDPP,
@@ -273,7 +318,6 @@ void dcn5_calculate_swath_width(
 {
 	(void)BytePerPixY;
 	enum dml2_odm_mode MainSurfaceODMMode;
-	double odm_hactive_factor = 1.0;
 	unsigned int req_width_horz_y;
 	unsigned int req_width_horz_c;
 	unsigned int surface_width_ub_l;
@@ -285,6 +329,9 @@ void dcn5_calculate_swath_width(
 	DML_LOG_VERBOSE("DML::%s: NumberOfActiveSurfaces = %u\n", __func__, NumberOfActiveSurfaces);
 
 	for (unsigned int k = 0; k < NumberOfActiveSurfaces; ++k) {
+		const struct dml2_plane_parameters *plane = &display_cfg->plane_descriptors[k];
+		const struct dml2_stream_parameters *stream = &display_cfg->stream_descriptors[plane->stream_index];
+
 		if (!dml2_core_utils_is_vertical_rotation(display_cfg->plane_descriptors[k].composition.rotation_angle)) {
 			SwathWidthSingleDPPY[k] = (unsigned int)display_cfg->plane_descriptors[k].composition.viewport.plane0.width;
 		} else {
@@ -300,20 +347,7 @@ void dcn5_calculate_swath_width(
 		if (ForceSingleDPP) {
 			SwathWidthY[k] = SwathWidthSingleDPPY[k];
 		} else {
-			if (MainSurfaceODMMode == dml2_odm_mode_combine_4to1)
-				odm_hactive_factor = 4.0;
-			else if (MainSurfaceODMMode == dml2_odm_mode_combine_3to1)
-				odm_hactive_factor = 3.0;
-			else if (MainSurfaceODMMode == dml2_odm_mode_combine_2to1)
-				odm_hactive_factor = 2.0;
-
-			if (MainSurfaceODMMode == dml2_odm_mode_combine_4to1 || MainSurfaceODMMode == dml2_odm_mode_combine_3to1 || MainSurfaceODMMode == dml2_odm_mode_combine_2to1) {
-				SwathWidthY[k] = (unsigned int)(math_min2((double)SwathWidthSingleDPPY[k], math_round((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_active / odm_hactive_factor * display_cfg->plane_descriptors[k].composition.scaler_info.plane0.h_ratio)));
-			} else if (DPPPerSurface[k] == 2) {
-				SwathWidthY[k] = SwathWidthSingleDPPY[k] / 2;
-			} else {
-				SwathWidthY[k] = SwathWidthSingleDPPY[k];
-			}
+			SwathWidthY[k] = calculate_per_pipe_swath_width(plane, stream, MainSurfaceODMMode, DPPPerSurface[k], SwathWidthSingleDPPY[k], false);
 		}
 
 		DML_LOG_VERBOSE("DML::%s: k=%u HActive=%lu\n", __func__, k, display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_active);
@@ -323,8 +357,9 @@ void dcn5_calculate_swath_width(
 		DML_LOG_VERBOSE("DML::%s: k=%u SwathWidthY=%u\n", __func__, k, SwathWidthY[k]);
 
 		if (dml2_core_utils_is_420(display_cfg->plane_descriptors[k].pixel_format) || dml2_core_utils_is_422_planar(display_cfg->plane_descriptors[k].pixel_format)) {
-			SwathWidthC[k] = SwathWidthY[k] / 2;
 			SwathWidthSingleDPPC[k] = SwathWidthSingleDPPY[k] / 2;
+			// Chroma taps apply at the chroma ratio, so the padded luma width can't simply be halved
+			SwathWidthC[k] = calculate_per_pipe_swath_width(plane, stream, MainSurfaceODMMode, DPPPerSurface[k], SwathWidthSingleDPPC[k], true);
 		} else {
 			SwathWidthC[k] = SwathWidthY[k];
 			SwathWidthSingleDPPC[k] = SwathWidthSingleDPPY[k];
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
index a61a1037bb73..2ee50f8cf2f5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs_dchub.c
@@ -227,43 +227,29 @@ static unsigned int calculate_tile_aligned_size(unsigned int copy_width, unsigne
   * *******************************************************************************************************************************************************
   * calculate_max_mem_size_per_plane_per_dpp: Calculate (loose) upper bound for total number of bytes reserved in memory for the copy given number of swaths
   *
-  * - The copy width / height is the min of the vp_width/height and maximum number of pixels that can fit across an ODM slice
-  *     - This is to account for recout positions that cross the ODM seam but are "mostly" within the same ODM slice
+  * - The copy width / height is the min of the vp_width/height and the per-pipe swath width
+  *     - This is to account for recout positions that cross the ODM / MPC split but are "mostly" within the same pipe
   *
   * *******************************************************************************************************************************************************
   */
 static unsigned int calculate_max_mem_size_per_plane_per_dpp(const struct dml2_core_calcs_calculate_alternate_params *p, unsigned int plane_idx, unsigned int copy_swaths, bool chroma)
 {
 	bool vertical_access = p->display_cfg->plane_descriptors[plane_idx].composition.rotation_angle == dml2_rotation_90 || p->display_cfg->plane_descriptors[plane_idx].composition.rotation_angle == dml2_rotation_270;
-	unsigned int h_active = p->display_cfg->stream_descriptors[p->display_cfg->plane_descriptors[plane_idx].stream_index].timing.h_active;
-	double h_ratio = chroma ? p->display_cfg->plane_descriptors[plane_idx].composition.scaler_info.plane1.h_ratio : p->display_cfg->plane_descriptors[plane_idx].composition.scaler_info.plane0.h_ratio;
 	unsigned int copy_src_lines = copy_swaths * (chroma ? p->SwathHeightC[plane_idx] : p->SwathHeightY[plane_idx]);
 	unsigned int vp_width = chroma ? p->display_cfg->plane_descriptors[plane_idx].composition.viewport.plane1.width : p->display_cfg->plane_descriptors[plane_idx].composition.viewport.plane0.width;
 	unsigned int vp_height = chroma ? p->display_cfg->plane_descriptors[plane_idx].composition.viewport.plane1.height : p->display_cfg->plane_descriptors[plane_idx].composition.viewport.plane0.height;
 	unsigned int tile_width = chroma ? p->MacroTileWidthC[plane_idx] : p->MacroTileWidthY[plane_idx];
 	unsigned int tile_height = chroma ? p->MacroTileHeightC[plane_idx] : p->MacroTileHeightY[plane_idx];
 	unsigned int byte_per_pixel = chroma ? p->BytePerPixelC[plane_idx] : p->BytePerPixelY[plane_idx];
+	unsigned int swath_width = chroma ? p->SwathWidthC[plane_idx] : p->SwathWidthY[plane_idx];
 	unsigned int copy_width;
 	unsigned int copy_height;
-	unsigned int odm_combine_factor;
-	double odm_slice_pixels;
-
-	if (p->ODMMode[plane_idx] == dml2_odm_mode_combine_4to1)
-		odm_combine_factor = 4;
-	else if (p->ODMMode[plane_idx] == dml2_odm_mode_combine_3to1)
-		odm_combine_factor = 3;
-	else if (p->ODMMode[plane_idx] == dml2_odm_mode_combine_2to1)
-		odm_combine_factor = 2;
-	else
-		odm_combine_factor = 1;
-
-	odm_slice_pixels = (double)h_active / odm_combine_factor * h_ratio + (odm_combine_factor == 3 ? 2 : 0);
 
 	/* Unaligned copy region dimensions (in pixels / lines) prior to tile alignment.
-	 * No need to divide vp width/height by NoOfDPP. The entire viewport could be within a single ODM slice if less than the odm slice pixels
+	 * No need to divide vp width/height by NoOfDPP. The entire viewport could be within a single pipe if less than the swath width
 	 * (e.g., multi-plane scenario with ODM combine). */
-	copy_width = vertical_access ? copy_src_lines : (unsigned int)math_ceil(math_min2(odm_slice_pixels, vp_width));
-	copy_height = vertical_access ? (unsigned int)math_ceil(math_min2(odm_slice_pixels, vp_height)) : copy_src_lines;
+	copy_width = vertical_access ? copy_src_lines : (unsigned int)math_min2((double)swath_width, (double)vp_width);
+	copy_height = vertical_access ? (unsigned int)math_min2((double)swath_width, (double)vp_height) : copy_src_lines;
 
 	return calculate_tile_aligned_size(copy_width, copy_height, tile_width, tile_height, byte_per_pixel);
 }
-- 
2.43.0

