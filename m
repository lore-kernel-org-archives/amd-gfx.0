Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB51CD3424
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F2510ECE6;
	Wed,  6 May 2026 07:05:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SOI1b0j8";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60EA910ECE6
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHkYouv6Z7zrf1bU03DhKIxUNm6hoWR4A4RE2/vtWu3sJv/rXrEIqGxy8VCHoZzpovkEy8fGon1EIePof2mponKoeJK6UEGw2EHOjbSst79i/ER02PInOWwk55dRf5oXozvfeD+a+tNMXyGIgKbcJUh7KYmz9MMzcjoL8TgQKkFpzqcAWAAxSFW++0ObiWDiwRSrSyu2fIXkoHP8WRGITU0Vkdv9qvXP3j7C75bysYdodo1Zt2X19ASvP/TL2tYJXL4uPR7QQqw48IEH8djxtXLh8W5MRffrZI4XYuPhFm+HgTkOdcYXmoBO8CVApn9X9RWFX92K85B4mA3qZXbG4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wvYFClkwj33UgU2I02Y0Ti85SJSnSeRFeoRb78F1so=;
 b=fcw+nsHCLjP34Vyx2p6ljLci2DZK7VrJu1+rdDFyu2A6zgOPaptyWn8k4ndWyIUqckrWmt3feAC0trwptEE881ZZ+PxkslvJAwSR30ceToQ3ix7Vfq8q8RD0HPfKkIR8SI4hNJCuh/nN2zGAJYYkaI7yrPGgZV8w5HPwIYP8VJt1f+eSLe1FPJ8jYbUre+SiX8GJ1k4mBVf5WNiVMcL55/NgJ7RultvVkPJkQzneHghgQ7WXGax83p8j699jiGOMCGe9mp9Va9yJnjp3eyzh4ZJpzhyelzbfeKf0tB15lgMIB0v3Hz63TvGJA1SPl+ILUtHH1dF/SLJhkPC6xubxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wvYFClkwj33UgU2I02Y0Ti85SJSnSeRFeoRb78F1so=;
 b=SOI1b0j8K3ENZnKXoOyLlxMmcWFxeekiVyntB/T6A7Pa/fhyzm+Qe3tJtXEms7ClZ5gQhsJf2XZ5PahEtLvw7kfo6FgfQrRRf7N6c6218qmC24Ai/7cE9U47uK1mpq+Qj6hki0ICQ7HY0cJbBaSJb+kya4e1zQfYvKB+VEEKVR0=
Received: from MN2PR03CA0024.namprd03.prod.outlook.com (2603:10b6:208:23a::29)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:05:47 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::dc) by MN2PR03CA0024.outlook.office365.com
 (2603:10b6:208:23a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.27 via Frontend Transport; Wed,
 6 May 2026 07:05:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:05:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:05:40 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:05:31 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Aric Cyr
 <aric.cyr@amd.com>, James Lin <pinglei.lin@amd.com>
Subject: [PATCH 16/20] drm/amd/display: Revert "Unify fast update
 classification paths"
Date: Wed, 6 May 2026 12:31:14 +0800
Message-ID: <20260506043342.2164710-17-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|MN2PR12MB4142:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c97019-ac0c-4026-78ec-08deab3de64f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Qpbi9Lc3T5DFmcelrnLPKdnzvYFulDGn2mTylA+0RolY0nQQdbiATkO5YzCM86ghZ6H5xe1/9NJb2tomhCBDjaEz20C/MxbBYzC7+TCKXAsiG/NLSN0JdrL3YBQ6768hj1fgUx1bes7vDU/j5ZPWxX6BVsF9MgoNH26emfmSRmRCo/3RHaxlwsyKXS9wnVZ53ODYHYxFBYSYTYwgOrA4A/p+sFYnVSPh4VGRYn+bSMOXmfMNgj7WaqsNjaWq+al6HS+oaqgrV2z6MPpSLHaqzLI9NAGp6hOMFoWmJc1y+z5hKFEse0z+HYNBDP2JZyl8AMVSEk+CwxcL7VVXVcJ73wwptoyIhUvGDYpDuYyNRQNqgv4xXocoVBVFowICi4jhUMeOya2QCJisIvdZGa+9okuEYc/6tt4t39XiIJmeNJ+S4suBwOWtV/nROYDEwKBk2+TaBFB9tOrvDzfcvVmERlL4z3v8eoiyI863aotF6tOqsU1SKn2JKU0zmISwwMsmv8uWfOaaKPAqsT+Ewt3R4ULxpV0MCOJkqi3pulJY9Eec3cTaEz0esP8qLTFqOqvFaAIqXdg11jfHvWRKOhol9DNP7Xr/iUcmjMjrFZiS19DRibPCR8ntMAMPoVdn/06RAuhnX71MEC2qGfrI+Cw0wfeZL5IMpXI3f1SstfMffdLODRcMcJ8Yufz0tB+xJH0h7jPyAH8YYzmpVVK8omcwEedS5aBbR3bbRNm3yK+81lQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LyAmIZ0VCSxCsaPlg0CbVc0KD3GCeP6JskW8N1KpBECxpPnmkOrAGDP8r2IOHta0/ehiOYncKjI0FeAQ89+MKend/+fBSlPhKmaXbGRbPiNXDDiSoBFI2xrPW80dV3g8dhx/mmohEPC5TjNlxiScisFrLiCFeXQoX85mMHJOFzcFtMRznHYCz/ELvxChsz1y0JxhGinoHNGdK2ql9Hx1Q7mD3+38vl3+nHdyKInrIIvf23HqjFSFESFin2hfwD0AAxseVFoN+MS/O6i/57yp+3ZzqeYeUjYhgv/3xhG5DafnfTCrIPZrDOaUN1UenJVpfLY9mfkpRgkKsPlnj4pSa2P0oaYiLE9r4h90zIJKgD99GGQeieuY3FinNOj7dHkRDgdp5+ylBr9NJMqiihPuhdsbQU6EO3eVY7zoNWuwnbPjg8LanXgFsEFJF+mfHGzF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:05:47.8167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c97019-ac0c-4026-78ec-08deab3de64f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
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

From: Ovidiu Bunea <ovidiu.bunea@amd.com>

[why & how]
This change causes regressions in ACPI and display off/on testing.
Revert the change to unblock testing.
This reverts commit e8d5c0ef03bb7a3fea8495908e0c47d3ef31f1bf.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 242 ++++++++++++++++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  12 -
 drivers/gpu/drm/amd/display/dc/dc.h           |  34 ++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 -
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   2 -
 5 files changed, 252 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 842a8b11b17a..48d32adb9eb3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3012,8 +3012,7 @@ static struct surface_update_descriptor det_surface_update(
 			update_flags->bits.gamut_remap_change ||
 			update_flags->bits.input_csc_change ||
 			update_flags->bits.cm_hist_change ||
-			update_flags->bits.coeff_reduction_change ||
-			update_flags->bits.cursor_csc_color_matrix_change)) {
+			update_flags->bits.coeff_reduction_change)) {
 		elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 	}
 	return overall_type;
@@ -3103,10 +3102,8 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 				stream_update->vrr_active_variable || stream_update->vrr_active_fixed))
 			su_flags->bits.fams_changed = 1;
 
-		if (stream_update->scaler_sharpener_update) {
+		if (stream_update->scaler_sharpener_update)
 			su_flags->bits.scaler_sharpener = 1;
-			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STREAM);
-		}
 
 		if (stream_update->sharpening_required)
 			su_flags->bits.sharpening_required = 1;
@@ -3171,16 +3168,6 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 			su_flags->bits.cursor_pos = 1;
 			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 		}
-
-		if (stream_update->func_shaper) {
-			su_flags->bits.func_shaper = 1;
-			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STREAM);
-		}
-
-		if (stream_update->lut3d_func) {
-			su_flags->bits.lut3d_func = 1;
-			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_STREAM);
-		}
 	}
 
 	for (int i = 0 ; i < surface_count; i++) {
@@ -4550,7 +4537,7 @@ static void build_dmub_update_dirty_rect(
 	}
 }
 
-bool dc_check_address_only_update(union surface_update_flags update_flags)
+static bool check_address_only_update(union surface_update_flags update_flags)
 {
 	union surface_update_flags addr_only_update_flags;
 	addr_only_update_flags.raw = 0;
@@ -4656,7 +4643,7 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 		for (i = 0; i < surface_count; i++) {
 			if (srf_updates[i].surface &&
 					srf_updates[i].surface->update_flags.raw &&
-					!dc_check_address_only_update(srf_updates[i].surface->update_flags)) {
+					!check_address_only_update(srf_updates[i].surface->update_flags)) {
 				/* more than address update, need to acquire FAMS2 lock */
 				should_offload_fams2_flip = false;
 				break;
@@ -5624,6 +5611,127 @@ static bool commit_minimal_transition_state(struct dc *dc,
 	return true;
 }
 
+void populate_fast_updates(struct dc_fast_update *fast_update,
+		struct dc_surface_update *srf_updates,
+		int surface_count,
+		struct dc_stream_update *stream_update)
+{
+	int i = 0;
+
+	if (stream_update) {
+		fast_update[0].out_transfer_func = stream_update->out_transfer_func;
+		fast_update[0].output_csc_transform = stream_update->output_csc_transform;
+		fast_update[0].cursor_attributes = stream_update->cursor_attributes;
+		fast_update[0].cursor_position = stream_update->cursor_position;
+		fast_update[0].periodic_interrupt = stream_update->periodic_interrupt;
+		fast_update[0].dither_option = stream_update->dither_option;
+		fast_update[0].gamut_remap = stream_update->gamut_remap;
+		fast_update[0].vrr_infopacket = stream_update->vrr_infopacket;
+		fast_update[0].vsc_infopacket = stream_update->vsc_infopacket;
+		fast_update[0].vsp_infopacket = stream_update->vsp_infopacket;
+		fast_update[0].hfvsif_infopacket = stream_update->hfvsif_infopacket;
+		fast_update[0].vtem_infopacket = stream_update->vtem_infopacket;
+		fast_update[0].adaptive_sync_infopacket = stream_update->adaptive_sync_infopacket;
+		fast_update[0].avi_infopacket = stream_update->avi_infopacket;
+		fast_update[0].hdr_static_metadata = stream_update->hdr_static_metadata;
+	} else {
+		fast_update[0].out_transfer_func = NULL;
+		fast_update[0].output_csc_transform = NULL;
+		fast_update[0].cursor_attributes = NULL;
+		fast_update[0].cursor_position = NULL;
+		fast_update[0].periodic_interrupt = NULL;
+		fast_update[0].dither_option = NULL;
+		fast_update[0].gamut_remap = NULL;
+		fast_update[0].vrr_infopacket = NULL;
+		fast_update[0].vsc_infopacket = NULL;
+		fast_update[0].vsp_infopacket = NULL;
+		fast_update[0].hfvsif_infopacket = NULL;
+		fast_update[0].vtem_infopacket = NULL;
+		fast_update[0].adaptive_sync_infopacket = NULL;
+		fast_update[0].avi_infopacket = NULL;
+		fast_update[0].hdr_static_metadata = NULL;
+	}
+
+	for (i = 0; i < surface_count; i++) {
+		fast_update[i].flip_addr = srf_updates[i].flip_addr;
+		fast_update[i].gamma = srf_updates[i].gamma;
+		fast_update[i].gamut_remap_matrix = srf_updates[i].gamut_remap_matrix;
+		fast_update[i].input_csc_color_matrix = srf_updates[i].input_csc_color_matrix;
+		fast_update[i].coeff_reduction_factor = srf_updates[i].coeff_reduction_factor;
+		fast_update[i].cursor_csc_color_matrix = srf_updates[i].cursor_csc_color_matrix;
+		fast_update[i].cm_hist_control = srf_updates[i].cm_hist_control;
+	}
+}
+
+static bool fast_updates_exist(const struct dc_fast_update *fast_update, int surface_count)
+{
+	int i;
+
+	if (fast_update[0].out_transfer_func ||
+		fast_update[0].output_csc_transform ||
+		fast_update[0].cursor_attributes ||
+		fast_update[0].cursor_position ||
+		fast_update[0].periodic_interrupt ||
+		fast_update[0].dither_option ||
+		fast_update[0].gamut_remap ||
+		fast_update[0].vrr_infopacket ||
+		fast_update[0].vsc_infopacket ||
+		fast_update[0].vsp_infopacket ||
+		fast_update[0].hfvsif_infopacket ||
+		fast_update[0].vtem_infopacket ||
+		fast_update[0].adaptive_sync_infopacket ||
+		fast_update[0].avi_infopacket ||
+		fast_update[0].hdr_static_metadata)
+		return true;
+
+	for (i = 0; i < surface_count; i++) {
+		if (fast_update[i].flip_addr ||
+				fast_update[i].gamma ||
+				fast_update[i].gamut_remap_matrix ||
+				fast_update[i].input_csc_color_matrix ||
+				fast_update[i].cursor_csc_color_matrix ||
+				fast_update[i].cm_hist_control ||
+				fast_update[i].coeff_reduction_factor)
+			return true;
+	}
+
+	return false;
+}
+
+bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_count)
+{
+	int i;
+
+	if (fast_update[0].out_transfer_func ||
+		fast_update[0].output_csc_transform ||
+		fast_update[0].gamut_remap ||
+		fast_update[0].cursor_attributes ||
+		fast_update[0].cursor_position ||
+		fast_update[0].periodic_interrupt ||
+		fast_update[0].dither_option ||
+		fast_update[0].vrr_infopacket ||
+		fast_update[0].vsc_infopacket ||
+		fast_update[0].vsp_infopacket ||
+		fast_update[0].hfvsif_infopacket ||
+		fast_update[0].vtem_infopacket ||
+		fast_update[0].adaptive_sync_infopacket ||
+		fast_update[0].avi_infopacket ||
+		fast_update[0].hdr_static_metadata)
+		return true;
+
+	for (i = 0; i < surface_count; i++) {
+		if (fast_update[i].input_csc_color_matrix ||
+				fast_update[i].gamma ||
+				fast_update[i].gamut_remap_matrix ||
+				fast_update[i].coeff_reduction_factor ||
+				fast_update[i].cm_hist_control ||
+				fast_update[i].cursor_csc_color_matrix)
+			return true;
+	}
+
+	return false;
+}
+
 static bool full_update_required_weak(
 		const struct dc *dc,
 		const struct dc_surface_update *srf_updates,
@@ -5652,6 +5760,72 @@ static bool full_update_required_weak(
 	return false;
 }
 
+static bool full_update_required(
+		const struct dc *dc,
+		const struct dc_surface_update *srf_updates,
+		int surface_count,
+		const struct dc_stream_update *stream_update,
+		const struct dc_stream_state *stream)
+{
+	if (full_update_required_weak(dc, srf_updates, surface_count, stream_update, stream))
+		return true;
+
+	for (int i = 0; i < surface_count; i++) {
+		if (srf_updates &&
+				(srf_updates[i].plane_info ||
+				srf_updates[i].scaling_info ||
+				(srf_updates[i].hdr_mult.value &&
+				srf_updates[i].hdr_mult.value != srf_updates->surface->hdr_mult.value) ||
+				(srf_updates[i].sdr_white_level_nits &&
+				srf_updates[i].sdr_white_level_nits != srf_updates->surface->sdr_white_level_nits) ||
+				srf_updates[i].in_transfer_func ||
+				srf_updates[i].func_shaper ||
+				srf_updates[i].lut3d_func ||
+				srf_updates[i].surface->force_full_update ||
+				(srf_updates[i].flip_addr &&
+				srf_updates[i].flip_addr->address.tmz_surface != srf_updates[i].surface->address.tmz_surface) ||
+				(srf_updates[i].cm2_params &&
+				 (srf_updates[i].cm2_params->component_settings.shaper_3dlut_setting != srf_updates[i].surface->mcm_shaper_3dlut_setting ||
+				  srf_updates[i].cm2_params->component_settings.lut1d_enable != srf_updates[i].surface->mcm_lut1d_enable))))
+			return true;
+	}
+
+	if (stream_update &&
+			(((stream_update->src.height != 0 && stream_update->src.width != 0) ||
+			(stream_update->dst.height != 0 && stream_update->dst.width != 0) ||
+			stream_update->integer_scaling_update) ||
+			stream_update->abm_level ||
+			stream_update->dpms_off ||
+			stream_update->allow_freesync ||
+			stream_update->vrr_active_variable ||
+			stream_update->vrr_active_fixed ||
+			stream_update->output_color_space ||
+			stream_update->wb_update ||
+			stream_update->dsc_config ||
+			stream_update->mst_bw_update ||
+			stream_update->func_shaper ||
+			stream_update->lut3d_func ||
+			stream_update->pending_test_pattern ||
+			stream_update->crtc_timing_adjust ||
+			stream_update->scaler_sharpener_update ||
+			stream_update->hw_cursor_req))
+		return true;
+
+	return false;
+}
+
+static bool fast_update_only(
+		const struct dc *dc,
+		const struct dc_fast_update *fast_update,
+		const struct dc_surface_update *srf_updates,
+		int surface_count,
+		const struct dc_stream_update *stream_update,
+		const struct dc_stream_state *stream)
+{
+	return fast_updates_exist(fast_update, surface_count)
+			&& !full_update_required(dc, srf_updates, surface_count, stream_update, stream);
+}
+
 static bool update_planes_and_stream_v2(struct dc *dc,
 		struct dc_surface_update *srf_updates, int surface_count,
 		struct dc_stream_state *stream,
@@ -5659,6 +5833,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 {
 	struct dc_state *context;
 	enum surface_update_type update_type;
+	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
 
 	/* In cases where MPO and split or ODM are used transitions can
 	 * cause underflow. Apply stream configuration with minimal pipe
@@ -5666,7 +5841,11 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 	 */
 	bool force_minimal_pipe_splitting = 0;
 	bool is_plane_addition = 0;
+	bool is_fast_update_only;
 
+	populate_fast_updates(fast_update, srf_updates, surface_count, stream_update);
+	is_fast_update_only = fast_update_only(dc, fast_update, srf_updates,
+			surface_count, stream_update, stream);
 	force_minimal_pipe_splitting = could_mpcc_tree_change_for_active_pipes(
 			dc,
 			stream,
@@ -5704,7 +5883,7 @@ static bool update_planes_and_stream_v2(struct dc *dc,
 		commit_minimal_transition_state_in_dc_update(dc, context, stream,
 				srf_updates, surface_count);
 
-	if (update_type == UPDATE_TYPE_FAST && !dc->check_config.enable_legacy_fast_update) {
+	if (is_fast_update_only && !dc->check_config.enable_legacy_fast_update) {
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
 				surface_count,
@@ -5740,8 +5919,13 @@ static void commit_planes_and_stream_update_on_current_context(struct dc *dc,
 		struct dc_stream_update *stream_update,
 		enum surface_update_type update_type)
 {
+	struct dc_fast_update fast_update[MAX_SURFACES] = {0};
+
 	ASSERT(update_type < UPDATE_TYPE_FULL);
-	if (update_type == UPDATE_TYPE_FAST &&
+	populate_fast_updates(fast_update, srf_updates, surface_count,
+			stream_update);
+	if (fast_update_only(dc, fast_update, srf_updates, surface_count,
+			stream_update, stream) &&
 			!dc->check_config.enable_legacy_fast_update)
 		commit_planes_for_stream_fast(dc,
 				srf_updates,
@@ -7744,6 +7928,23 @@ static bool update_planes_and_stream_prepare_v3(
 	ASSERT(scratch->flow == UPDATE_V3_FLOW_INVALID);
 	dc_exit_ips_for_hw_access(scratch->dc);
 
+	/* HWSS path determination needs to be done prior to updating the surface and stream states. */
+	struct dc_fast_update fast_update[MAX_SURFACES] = { 0 };
+
+	populate_fast_updates(fast_update,
+			      scratch->surface_updates,
+			      scratch->surface_count,
+			      scratch->stream_update);
+
+	const bool is_hwss_fast_path_only =
+		fast_update_only(scratch->dc,
+				 fast_update,
+				 scratch->surface_updates,
+				 scratch->surface_count,
+				 scratch->stream_update,
+				 scratch->stream) &&
+		!scratch->dc->check_config.enable_legacy_fast_update;
+
 	if (!update_planes_and_stream_state(
 			scratch->dc,
 			scratch->surface_updates,
@@ -7759,8 +7960,7 @@ static bool update_planes_and_stream_prepare_v3(
 	if (scratch->new_context == scratch->dc->current_state) {
 		ASSERT(scratch->update_type < UPDATE_TYPE_FULL);
 
-		scratch->flow = (scratch->update_type == UPDATE_TYPE_FAST &&
-				!scratch->dc->check_config.enable_legacy_fast_update)
+		scratch->flow = is_hwss_fast_path_only
 				? UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FAST
 				: UPDATE_V3_FLOW_NO_NEW_CONTEXT_CONTEXT_FULL;
 		return true;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index ffa3130853c2..1916aa3ebaea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1057,18 +1057,6 @@ void hwss_build_fast_sequence(struct dc *dc,
 					(*num_steps)++;
 				}
 
-				if (current_mpc_pipe->plane_state->update_flags.bits.lut_3d &&
-						current_mpc_pipe->plane_state->mcm_luts.lut3d_data.lut3d_src ==
-								DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM &&
-						current_mpc_pipe->plane_state->mcm_shaper_3dlut_setting ==
-								DC_CM2_SHAPER_3DLUT_SETTING_ENABLE_SHAPER_3DLUT &&
-						current_mpc_pipe->plane_res.hubp->funcs->hubp_enable_3dlut_fl) {
-					block_sequence[*num_steps].params.hubp_enable_3dlut_fl_params.hubp =
-						current_mpc_pipe->plane_res.hubp;
-					block_sequence[*num_steps].func = HUBP_ENABLE_3DLUT_FL;
-					(*num_steps)++;
-				}
-
 				if (hws->funcs.set_input_transfer_func && current_mpc_pipe->plane_state->update_flags.bits.gamma_change) {
 					block_sequence[*num_steps].params.set_input_transfer_func_params.dc = dc;
 					block_sequence[*num_steps].params.set_input_transfer_func_params.pipe_ctx = current_mpc_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 30ff7f1b9513..d87bf8f4f56e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1467,14 +1467,11 @@ union surface_update_flags {
 		uint32_t full_update:1;
 		uint32_t sdr_white_level_nits:1;
 		uint32_t cm_hist_change:1;
-		uint32_t reserved:2; /* adjust when adding new flags */
 	} bits;
 
 	uint32_t raw;
 };
 
-bool dc_check_address_only_update(union surface_update_flags update_flags);
-
 #define DC_REMOVE_PLANE_POINTERS 1
 
 struct dc_plane_state {
@@ -1854,6 +1851,32 @@ struct dc_scaling_info {
 	struct scaling_taps scaling_quality;
 };
 
+struct dc_fast_update {
+	const struct dc_flip_addrs *flip_addr;
+	const struct dc_gamma *gamma;
+	const struct colorspace_transform *gamut_remap_matrix;
+	const struct dc_csc_transform *input_csc_color_matrix;
+	const struct fixed31_32 *coeff_reduction_factor;
+	struct dc_transfer_func *out_transfer_func;
+	struct dc_csc_transform *output_csc_transform;
+	const struct dc_csc_transform *cursor_csc_color_matrix;
+	struct cm_hist_control *cm_hist_control;
+	/* stream-level fast updates */
+	const struct colorspace_transform *gamut_remap;
+	const struct dc_cursor_attributes *cursor_attributes;
+	const struct dc_cursor_position *cursor_position;
+	const struct periodic_interrupt_config *periodic_interrupt;
+	const enum dc_dither_option *dither_option;
+	struct dc_info_packet *vrr_infopacket;
+	struct dc_info_packet *vsc_infopacket;
+	struct dc_info_packet *vsp_infopacket;
+	struct dc_info_packet *hfvsif_infopacket;
+	struct dc_info_packet *vtem_infopacket;
+	struct dc_info_packet *adaptive_sync_infopacket;
+	struct dc_info_packet *avi_infopacket;
+	struct dc_info_packet *hdr_static_metadata;
+};
+
 struct dc_surface_update {
 	struct dc_plane_state *surface;
 
@@ -1988,6 +2011,11 @@ bool dc_resource_is_dsc_encoding_supported(const struct dc *dc);
 void get_audio_check(struct audio_info *aud_modes,
 	struct audio_check *aud_chk);
 
+bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_count);
+void populate_fast_updates(struct dc_fast_update *fast_update,
+		struct dc_surface_update *srf_updates,
+		int surface_count,
+		struct dc_stream_update *stream_update);
 /*
  * Set up streams and links associated to drive sinks
  * The streams parameter is an absolute set of all active streams.
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 1649fbab08aa..4154cd059562 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -123,9 +123,6 @@ union stream_update_flags {
 		uint32_t info_frame : 1;
 		uint32_t dmdata : 1;
 		uint32_t dither : 1;
-		uint32_t func_shaper : 1;
-		uint32_t lut3d_func : 1;
-		uint32_t reserved : 11; /* adjust when adding new flags */
 	} bits;
 
 	uint32_t raw;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 204f11b784bb..124a1ccec741 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -493,12 +493,10 @@ void dcn401_populate_mcm_luts(struct dc *dc,
 		break;
 	case DC_CM2_TRANSFER_FUNC_SOURCE_VIDMEM:
 		switch (mcm_luts.lut3d_data.gpu_mem_params.size) {
-#if defined(CONFIG_DRM_AMD_DC_DCN4_2)
 		case DC_CM2_GPU_MEM_SIZE_333333:
 			if (dc->caps.color.mpc.rmcm_3d_lut_caps.lut_dim_caps.dim_33)
 				width = hubp_3dlut_fl_width_33;
 			break;
-#endif
 		case DC_CM2_GPU_MEM_SIZE_171717:
 			width = hubp_3dlut_fl_width_17;
 			break;
-- 
2.43.0

