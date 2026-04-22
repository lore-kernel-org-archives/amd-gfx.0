Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5D6F94CC2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:57:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F4510E1FF;
	Wed, 22 Apr 2026 03:57:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KcEExsIP";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6123610E1FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:57:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xev4Ju6Dx9+tOQ1KPnx5ZhXy6W95KqFjMfxtCILt3sClG0Bc9p+aSyt7XOx5vfMjP/pH4vPdCLPQnH5+fWjH17Z/1iomaAWQkYSKnXxBJzm4Q84epnj/vd56tUeVdP0DJBameDXTcqqhqBd0KiXqpKuDFUWhoebm8h2hZDgTiEU2PO/wJ+0Q94AyW8/QfGSy9jEhjQBekwMA7/XerxCoMzOP0p39c4hiOPS8o7DRxqPB1/pPjKqVGJnd+A86oKBhGMYOzZynD7WaPGwHyNdd//s8i0H53Blj9sOyTOP6A/ZYYqkXXHyk1Y+SCqcHGr7KOMP0rq++pDaHDi1jdRxLmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ty/ArRJH8tyvb4CauL8umD1hTCaJ5D3sou/Xykpk/wk=;
 b=m0vj0pZ/6Pgm4jj3MitG2Y4fgXuVLf4JJJpT22eVVVXc2ti3Juvax577GNQP0VLgwBWyf8FUOBqDrw1aSsv0stPF3k1A0XZMjnzwgc8JJ7rwjTEMgNLow2nbhA7XijjTtSmPt8gh7Bxg9aXhxG3nFxlPxodja7H6hWVnIX54W2sM8XzFgSF2uDR3zkvyZ++07FQ5FERIu4nCzyoplF3+5obHTcEXwH0Taem2iO52iA7wDqxEh47zgUf1ruFHLprtHbv4Pr9CTXs81Gt79PnKUiPodpCAyHZHPzW8XkbWrMVpUScHSPUZX9cUruZmdrS6d5bO44vyXtVrah3rkluVVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ty/ArRJH8tyvb4CauL8umD1hTCaJ5D3sou/Xykpk/wk=;
 b=KcEExsIPpETGo8t99fXzpqs7bkNAg26Y2Ykv9BQRa4k29AWHVzT66P9FS9bsVykVAYmZMqRUi0DllvMcx9N0krdIACAfeExd/4SPC/1EjkgqLlY2EvzNhUOTqMe0rNOqXFHOKC70sR2THjM71IfSYSr2/Xu77Pmtt4SC/Yr2Ozw=
Received: from BN9PR03CA0389.namprd03.prod.outlook.com (2603:10b6:408:f7::34)
 by SAWPR12MB999163.namprd12.prod.outlook.com (2603:10b6:806:4e0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Wed, 22 Apr
 2026 03:56:56 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::1a) by BN9PR03CA0389.outlook.office365.com
 (2603:10b6:408:f7::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 03:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:56:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:55 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 21 Apr
 2026 22:56:55 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:56:51 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 08/14] drm/amd/display: Unify fast update classification paths
Date: Wed, 22 Apr 2026 11:52:46 +0800
Message-ID: <20260422035611.1870316-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|SAWPR12MB999163:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b6ccc1-87ae-462a-a800-08dea0233286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: YSTaSwwSMYokhRtneTQ2PLeicv3dsciM8dZMCctb/J02JKLv5QAQsIK8hDWY8QBLMMusgUj8qrp+2RRHiOcKE7omDqtWTtQkJ+bs77SKC9HIRmb3AB9BejTbgYjBCATxu2P+x7Uv/QwUvM9lC7GjWVVseuPhDLIMKSWiFnlfE02UjiT4CP7GmCUs+dIbj13mX2Nm2Jl1E053qIFZb68mS2ldf9f5AmuaWhvJ5wr2cj+iexSUeGm2xf0ADCmOQHyDR9CB9L5m2FO52GpxdUDoZ0pH7aIHDNL2ZkGnMgGNkNAstLZASDnsIpHXNdLwcn/TivvK5q3R01pderMTXllLkmlYuE5XxGYR1DXiSuyJIbjUMtShhHcZjLLAuRQ715i8ioNFLc8hMjSHUNUxHup6lq8YzRc1ryOsPgz+pPSz6xINILwoi8RrEkt1KQQ0y1n1PXfFko3aGA9/9clyWbeJ4fxS9nXPcVRXH93579disLq7h7HONOZ0jbV/7eVXEXfUX+1oQr0jVtnU9a2GXnppv/8ad0Fydmf0o3hr6maoGwVsCZfsHdexhDEjbfJyV7RM62tqE1aP5+cLh6TRnBUi8A6Msr66m8oOYThZvjvGK+5gotXmnkamD6kUyOYprOXwnNRMp7ZFF4Qx+FJr21xowRWU0uIDDJwc2k60t9zxRXccMr4KmZ9LtPt3lsTtGvFsijkAKTr3FfX+yNGs9rwYAk1CWN02hTcMQ8xBxlqxkSTXNrOcJP2n4Fm0L8PIZiIIvoWlVu2pfbwzoe3ti/yNJw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Jhj7s3DnTYpG2ZLM/j2QUQS1UittwVRuMIZpE+7BLRLRGw2WHEexUn4DJZx+rYDaOU7GOIUv5dPXJRv8X9ZyeVIb1ix6HuWlV3/D64gQZzRb5MllIwZVQNnTtYDzKhgwiU5vYgNW6+Bz8JCUjqQgfHzeoIUKHNcFeD0xBqPQv+lCIKrKA/XehNLOdXZhgZye/UmUVC9mb+tXy6GPQ6gpD319LoaVCFQptJfqVSOXbNuIvt6mdV2JDti3NDBq+OQcdqjtdTSjaYCRHCrHZi4pihp/r7ya8DqN3BrPoFt/s5WKaZUi5ITXFkhkm1idHpHZ2yAsrDX5luANRIWCydpsibEl4Ovh99eLfluPLFOUzpeBUM2d2iNyhBkIAaMSBrpPXY8xoeojqv/9oLZ0dt/KGkyXKh5LbX+YICipLfpmE9Uskkfc317gW++q9XD159Wr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:56:56.4747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b6ccc1-87ae-462a-a800-08dea0233286
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999163
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[Why]
The dc_fast_update intermediate struct created code duplication and
complexity with multiple classification paths (populate_fast_updates,
fast_nonaddr_updates_exist, full_update_required). This refactoring
simplifies the update classification system by consolidating to a
single path while maintaining compatibility and adding comprehensive
test coverage for fast sequence functionality.

[How]
Remove entire dc_fast_update struct and associated helper functions:
- populate_fast_updates
- fast_nonaddr_updates_exist
- full_update_required
and
- Refactor check_update_surfaces_for_stream as the single
  classification path with explicit handling for func_shaper,
  lut3d_func, cursor_csc_color_matrix_change and
  scaler_sharpener_update.
- Add reserved bitfields to surface_update_flags and
  stream_update_flags unions for completeness guards.
- Extract dc_check_address_only_update and
  dc_check_update_surfaces_for_stream as public.
- Add comprehensive test coverage with parameterized tests for all
  FAST flags, update classification tests for MED/FULL paths,
  and completeness guard tests.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 252 ++----------------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  12 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  36 +--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 4 files changed, 39 insertions(+), 264 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0c7c84276d1f..a162193800e5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3006,7 +3006,8 @@ static struct surface_update_descriptor det_surface_update(
 			update_flags->bits.gamut_remap_change ||
 			update_flags->bits.input_csc_change ||
 			update_flags->bits.cm_hist_change ||
-			update_flags->bits.coeff_reduction_change)) {
+			update_flags->bits.coeff_reduction_change ||
+			update_flags->bits.cursor_csc_color_matrix_change)) {
 		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 	return overall_type;
@@ -3096,8 +3097,10 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 				stream_update->vrr_active_variable || stream_update->vrr_active_fixed))
 			su_flags->bits.fams_changed = 1;
 
-		if (stream_update->scaler_sharpener_update)
+		if (stream_update->scaler_sharpener_update) {
 			su_flags->bits.scaler_sharpener = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STREAM);
+		}
 
 		if (stream_update->sharpening_required)
 			su_flags->bits.sharpening_required = 1;
@@ -3162,6 +3165,16 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 			su_flags->bits.cursor_pos = 1;
 			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 		}
+
+		if (stream_update->func_shaper) {
+			su_flags->bits.func_shaper = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STREAM);
+		}
+
+		if (stream_update->lut3d_func) {
+			su_flags->bits.lut3d_func = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STREAM);
+		}
 	}
 
 	for (int i = 0 ; i < surface_count; i++) {
@@ -4086,7 +4099,7 @@ static void build_dmub_update_dirty_rect(
 	}
 }
 
-static bool check_address_only_update(union surface_update_flags update_flags)
+bool dc_check_address_only_update(union surface_update_flags update_flags)
 {
 	union surface_update_flags addr_only_update_flags;
 	addr_only_update_flags.raw = 0;
@@ -4190,7 +4203,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 		for (i = 0; i < surface_count; i++) {
 			if (srf_updates[i].surface &&
 					srf_updates[i].surface->update_flags.raw &&
-					!check_address_only_update(srf_updates[i].surface->update_flags)) {
+					!dc_check_address_only_update(srf_updates[i].surface->update_flags)) {
 				/* more than address update, need to acquire FAMS2 lock */
 				should_offload_fams2_flip = false;
 				break;
@@ -5155,133 +5168,6 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	return true;
 }
 
-void populate_fast_updates(struct dc_fast_update *fast_update,
-		struct dc_surface_update *srf_updates,
-		int surface_count,
-		struct dc_stream_update *stream_update)
-{
-	int i = 0;
-
-	if (stream_update) {
-		fast_update[0].out_transfer_func = stream_update->out_transfer_func;
-		fast_update[0].output_csc_transform = stream_update->output_csc_transform;
-		fast_update[0].cursor_attributes = stream_update->cursor_attributes;
-		fast_update[0].cursor_position = stream_update->cursor_position;
-		fast_update[0].periodic_interrupt = stream_update->periodic_interrupt;
-		fast_update[0].dither_option = stream_update->dither_option;
-		fast_update[0].gamut_remap = stream_update->gamut_remap;
-		fast_update[0].vrr_infopacket = stream_update->vrr_infopacket;
-		fast_update[0].vsc_infopacket = stream_update->vsc_infopacket;
-		fast_update[0].vsp_infopacket = stream_update->vsp_infopacket;
-		fast_update[0].hfvsif_infopacket = stream_update->hfvsif_infopacket;
-		fast_update[0].vtem_infopacket = stream_update->vtem_infopacket;
-		fast_update[0].adaptive_sync_infopacket = stream_update->adaptive_sync_infopacket;
-		fast_update[0].avi_infopacket = stream_update->avi_infopacket;
-		fast_update[0].hdr_static_metadata = stream_update->hdr_static_metadata;
-	} else {
-		fast_update[0].out_transfer_func = NULL;
-		fast_update[0].output_csc_transform = NULL;
-		fast_update[0].cursor_attributes = NULL;
-		fast_update[0].cursor_position = NULL;
-		fast_update[0].periodic_interrupt = NULL;
-		fast_update[0].dither_option = NULL;
-		fast_update[0].gamut_remap = NULL;
-		fast_update[0].vrr_infopacket = NULL;
-		fast_update[0].vsc_infopacket = NULL;
-		fast_update[0].vsp_infopacket = NULL;
-		fast_update[0].hfvsif_infopacket = NULL;
-		fast_update[0].vtem_infopacket = NULL;
-		fast_update[0].adaptive_sync_infopacket = NULL;
-		fast_update[0].avi_infopacket = NULL;
-		fast_update[0].hdr_static_metadata = NULL;
-	}
-
-	for (i = 0; i < surface_count; i++) {
-		fast_update[i].flip_addr = srf_updates[i].flip_addr;
-		fast_update[i].gamma = srf_updates[i].gamma;
-		fast_update[i].gamut_remap_matrix = srf_updates[i].gamut_remap_matrix;
-		fast_update[i].input_csc_color_matrix = srf_updates[i].input_csc_color_matrix;
-		fast_update[i].coeff_reduction_factor = srf_updates[i].coeff_reduction_factor;
-		fast_update[i].cursor_csc_color_matrix = srf_updates[i].cursor_csc_color_matrix;
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
-		fast_update[i].cm_hist_control = srf_updates[i].cm_hist_control;
-#endif
-	}
-}
-
-static bool fast_updates_exist(const struct dc_fast_update *fast_update, int surface_count)
-{
-	int i;
-
-	if (fast_update[0].out_transfer_func ||
-		fast_update[0].output_csc_transform ||
-		fast_update[0].gamut_remap ||
-		fast_update[0].cursor_attributes ||
-		fast_update[0].cursor_position ||
-		fast_update[0].periodic_interrupt ||
-		fast_update[0].dither_option ||
-		fast_update[0].vrr_infopacket ||
-		fast_update[0].vsc_infopacket ||
-		fast_update[0].vsp_infopacket ||
-		fast_update[0].hfvsif_infopacket ||
-		fast_update[0].vtem_infopacket ||
-		fast_update[0].adaptive_sync_infopacket ||
-		fast_update[0].avi_infopacket ||
-		fast_update[0].hdr_static_metadata)
-		return true;
-
-	for (i = 0; i < surface_count; i++) {
-		if (fast_update[i].flip_addr ||
-				fast_update[i].gamma ||
-				fast_update[i].gamut_remap_matrix ||
-				fast_update[i].input_csc_color_matrix ||
-				fast_update[i].cursor_csc_color_matrix ||
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
-				fast_update[i].cm_hist_control ||
-#endif
-				fast_update[i].coeff_reduction_factor)
-			return true;
-	}
-
-	return false;
-}
-
-bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_count)
-{
-	int i;
-
-	if (fast_update[0].out_transfer_func ||
-		fast_update[0].output_csc_transform ||
-		fast_update[0].cursor_attributes ||
-		fast_update[0].cursor_position ||
-		fast_update[0].periodic_interrupt ||
-		fast_update[0].dither_option ||
-		fast_update[0].gamut_remap ||
-		fast_update[0].vrr_infopacket ||
-		fast_update[0].vsc_infopacket ||
-		fast_update[0].vsp_infopacket ||
-		fast_update[0].hfvsif_infopacket ||
-		fast_update[0].vtem_infopacket ||
-		fast_update[0].adaptive_sync_infopacket ||
-		fast_update[0].avi_infopacket ||
-		fast_update[0].hdr_static_metadata)
-		return true;
-
-	for (i = 0; i < surface_count; i++) {
-		if (fast_update[i].input_csc_color_matrix ||
-				fast_update[i].gamma ||
-				fast_update[i].gamut_remap_matrix ||
-				fast_update[i].coeff_reduction_factor ||
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
-				fast_update[i].cm_hist_control ||
-#endif
-				fast_update[i].cursor_csc_color_matrix)
-			return true;
-	}
-
-	return false;
-}
-
 static bool full_update_required_weak(
 		const struct dc *dc,
 		const struct dc_surface_update *srf_updates,
@@ -5310,76 +5196,6 @@ static bool full_update_required_weak(
 	return false;
 }
 
-static bool full_update_required(
-		const struct dc *dc,
-		const struct dc_surface_update *srf_updates,
-		int surface_count,
-		const struct dc_stream_update *stream_update,
-		const struct dc_stream_state *stream)
-{
-	const union dc_plane_cm_flags blend_only_flags = {
-		.bits = {
-			.blend_enable = 1,
-		}
-	};
-
-	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
-		return true;
-
-	for (int i = 0; i < surface_count; i++) {
-		if (srf_updates &&
-				(srf_updates[i].plane_info ||
-				srf_updates[i].scaling_info ||
-				(srf_updates[i].hdr_mult.value &&
-				srf_updates[i].hdr_mult.value != srf_updates->surface->hdr_mult.value) ||
-				(srf_updates[i].sdr_white_level_nits &&
-				srf_updates[i].sdr_white_level_nits != srf_updates->surface->sdr_white_level_nits) ||
-				srf_updates[i].in_transfer_func ||
-				srf_updates[i].surface->force_full_update ||
-				(srf_updates[i].flip_addr &&
-				srf_updates[i].flip_addr->address.tmz_surface != srf_updates[i].surface->address.tmz_surface) ||
-				(srf_updates[i].cm &&
-				((srf_updates[i].cm->flags.all != blend_only_flags.all && srf_updates[i].cm->flags.all != 0) ||
-				(srf_updates[i].surface->cm.flags.all != blend_only_flags.all && srf_updates[i].surface->cm.flags.all != 0)))))
-			return true;
-	}
-
-	if (stream_update &&
-			(((stream_update->src.height != 0 && stream_update->src.width != 0) ||
-			(stream_update->dst.height != 0 && stream_update->dst.width != 0) ||
-			stream_update->integer_scaling_update) ||
-			stream_update->abm_level ||
-			stream_update->dpms_off ||
-			stream_update->allow_freesync ||
-			stream_update->vrr_active_variable ||
-			stream_update->vrr_active_fixed ||
-			stream_update->output_color_space ||
-			stream_update->wb_update ||
-			stream_update->dsc_config ||
-			stream_update->mst_bw_update ||
-			stream_update->func_shaper ||
-			stream_update->lut3d_func ||
-			stream_update->pending_test_pattern ||
-			stream_update->crtc_timing_adjust ||
-			stream_update->scaler_sharpener_update ||
-			stream_update->hw_cursor_req))
-		return true;
-
-	return false;
-}
-
-static bool fast_update_only(
-		const struct dc *dc,
-		const struct dc_fast_update *fast_update,
-		const struct dc_surface_update *srf_updates,
-		int surface_count,
-		const struct dc_stream_update *stream_update,
-		const struct dc_stream_state *stream)
-{
-	return fast_updates_exist(fast_update, surface_count)
-			&& !full_update_required(dc, srf_updates, surface_count, stream_update, stream);
-}
-
 static bool update_planes_and_stream_v2(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
@@ -5387,7 +5203,6 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 {
 	struct dc_state *context;
 	enum surface_update_type update_type;
-	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
 
 	/* In cases where MPO and split or ODM are used transitions can
 	 * cause underflow. Apply stream configuration with minimal pipe
@@ -5395,11 +5210,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 	 */
 	bool force_minimal_pipe_splitting = 0;
 	bool is_plane_addition = 0;
-	bool is_fast_update_only;
 
-	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
-	is_fast_update_only = fast_update_only(dc, fast_update, srf_updates,
-			surface_count, stream_update, stream);
 	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
 			dc,
 			stream,
@@ -5437,7 +5248,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 		commit_minimal_transition_state_in_dc_update(dc, context, stream,
 				srf_updates, surface_count);
 
-	if (is_fast_update_only && !dc->check_config.enable_legacy_fast_update) {
+	if (update_type == UPDATE_TYPE_FAST && !dc->check_config.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
@@ -5473,13 +5284,8 @@ static void commit_planes_and_stream_update_on_current_context(struct dc *dc,
 		struct dc_stream_update *stream_update,
 		enum surface_update_type update_type)
 {
-	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
-
 	ASSERT(update_type < UPDATE_TYPE_FULL);
-	populate_fast_updates(fast_update, srf_updates, surface_count,
-			stream_update);
-	if (fast_update_only(dc, fast_update, srf_updates, surface_count,
-			stream_update, stream) &&
+	if (update_type == UPDATE_TYPE_FAST &&
 			!dc->check_config.enable_legacy_fast_update)
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
@@ -7457,23 +7263,6 @@ static bool update_planes_and_stream_prepare_v3(
 	ASSERT(scratch->flow == UPDATE_V3_FLOW_INVALID);
 	dc_exit_ips_for_hw_access(scratch->dc);
 
-	/* HWSS path determination needs to be done prior to updating the surface and stream states. */
-	struct dc_fast_update fast_update[MAX_SURFACES] = { 0 };
-
-	populate_fast_updates(fast_update,
-			      scratch->surface_updates,
-			      scratch->surface_count,
-			      scratch->stream_update);
-
-	const bool is_hwss_fast_path_only =
-		fast_update_only(scratch->dc,
-				 fast_update,
-				 scratch->surface_updates,
-				 scratch->surface_count,
-				 scratch->stream_update,
-				 scratch->stream) &&
-		!scratch->dc->check_config.enable_legacy_fast_update;
-
 	if (!update_planes_and_stream_state(
 			scratch->dc,
 			scratch->surface_updates,
@@ -7489,7 +7278,8 @@ static bool update_planes_and_stream_prepare_v3(
 	if (scratch->new_context == scratch->dc->current_state) {
 		ASSERT(scratch->update_type < UPDATE_TYPE_FULL);
 
-		scratch->flow = is_hwss_fast_path_only
+		scratch->flow = (scratch->update_type == UPDATE_TYPE_FAST &&
+				!scratch->dc->check_config.enable_legacy_fast_update)
 				? UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST
 				: UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL;
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 42eb2885e737..83a5e9106244 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1059,6 +1059,18 @@ void hwss_build_fast_sequence(struct dc *dc,
 					(*num_steps)++;
 				}
 
+				if (current_mpc_pipe->plane_state->update_flags.bits.lut_3d &&
+						current_mpc_pipe->plane_state->mcm_luts.lut3d_data.lut3d_src ==
+								DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM &&
+						current_mpc_pipe->plane_state->mcm_shaper_3dlut_setting ==
+								DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER_3DLUT &&
+						current_mpc_pipe->plane_res.hubp->funcs->hubp_enable_3dlut_fl) {
+					block_sequence[*num_steps].params.hubp_enable_3dlut_fl_params.hubp =
+						current_mpc_pipe->plane_res.hubp;
+					block_sequence[*num_steps].func = HUBP_ENABLE_3DLUT_FL;
+					(*num_steps)++;
+				}
+
 				if (hws->funcs.set_input_transfer_func && current_mpc_pipe->plane_state->update_flags.bits.gamma_change) {
 					block_sequence[*num_steps].params.set_input_transfer_func_params.dc = dc;
 					block_sequence[*num_steps].params.set_input_transfer_func_params.pipe_ctx = current_mpc_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 50ec5acb6c7b..db5fe8238c39 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1500,11 +1500,14 @@ union surface_update_flags {
 		uint32_t full_update:1;
 		uint32_t sdr_white_level_nits:1;
 		uint32_t cm_hist_change:1;
+		uint32_t reserved:2; /* adjust when adding new flags */
 	} bits;
 
 	uint32_t raw;
 };
 
+bool dc_check_address_only_update(union surface_update_flags update_flags);
+
 #define DC_REMOVE_PLANE_POINTERS 1
 
 struct dc_plane_state {
@@ -1883,34 +1886,6 @@ struct dc_scaling_info {
 	struct scaling_taps scaling_quality;
 };
 
-struct dc_fast_update {
-	const struct dc_flip_addrs *flip_addr;
-	const struct dc_gamma *gamma;
-	const struct colorspace_transform *gamut_remap_matrix;
-	const struct dc_csc_transform *input_csc_color_matrix;
-	const struct fixed31_32 *coeff_reduction_factor;
-	struct dc_transfer_func *out_transfer_func;
-	struct dc_csc_transform *output_csc_transform;
-	const struct dc_csc_transform *cursor_csc_color_matrix;
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
-	struct cm_hist_control *cm_hist_control;
-#endif
-	/* stream-level fast updates */
-	const struct colorspace_transform *gamut_remap;
-	const struct dc_cursor_attributes *cursor_attributes;
-	const struct dc_cursor_position *cursor_position;
-	const struct periodic_interrupt_config *periodic_interrupt;
-	const enum dc_dither_option *dither_option;
-	struct dc_info_packet *vrr_infopacket;
-	struct dc_info_packet *vsc_infopacket;
-	struct dc_info_packet *vsp_infopacket;
-	struct dc_info_packet *hfvsif_infopacket;
-	struct dc_info_packet *vtem_infopacket;
-	struct dc_info_packet *adaptive_sync_infopacket;
-	struct dc_info_packet *avi_infopacket;
-	struct dc_info_packet *hdr_static_metadata;
-};
-
 struct dc_surface_update {
 	struct dc_plane_state *surface;
 
@@ -2049,11 +2024,6 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 void get_audio_check(struct audio_info *aud_modes,
 	struct audio_check *aud_chk);
 
-bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_count);
-void populate_fast_updates(struct dc_fast_update *fast_update,
-		struct dc_surface_update *srf_updates,
-		int surface_count,
-		struct dc_stream_update *stream_update);
 /*
  * Set up streams and links associated to drive sinks
  * The streams parameter is an absolute set of all active streams.
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 6a8c1390b85f..25552f21faf3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -123,6 +123,9 @@ union stream_update_flags {
 		uint32_t info_frame : 1;
 		uint32_t dmdata : 1;
 		uint32_t dither : 1;
+		uint32_t func_shaper : 1;
+		uint32_t lut3d_func : 1;
+		uint32_t reserved : 11; /* adjust when adding new flags */
 	} bits;
 
 	uint32_t raw;
-- 
2.43.0

