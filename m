Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3C4FA0C42
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Apr 2026 07:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C51C310E692;
	Wed, 15 Apr 2026 07:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lr15GekE";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012045.outbound.protection.outlook.com
 [40.107.200.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCFCE10E692
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Apr 2026 07:43:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/57G0cDbZyCCLwmUMr10KVwrz5qWyPlV4ujbi3rs6abDUoy0Z5BB9FsSskET0fkE36CwbKVDp2n2bmVxxyD5jnGmhxzDNkN/OGxBGURiW1oOdPInYHWlHpaPuOFnJNPHMLau9lVjCBnEryZeQhXbBIMJlxN8a6ntP7YWYDW3j1TCAcyEDyUGUYuHR11P1HHKjiOzN6Z5bk8nLiodlWHN0W61kwyggjgy9Z/Yh7KnJ2GonvMO54pf82eW/KvyMODm+5e+5c48zau3VUxk3NYMBQJXP6FtvBEhsqRmHhcRDCMuPxa/+85UfH0SLAtwO6vyu3yDteuS+7qNMxwDhZgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQO1UfP5eVVfnhirSzy21WyyfR5FHRby6ETrEalTw4k=;
 b=oVaz2DqxymEm9ABogoSaehvV6o5bTCjL462nXX33gn0AENesYuw5q5thInZbKFXdVpbXYNIsGumD+kywXeAa8plclh6Eun+1S2Sp4WFjtAeH9VlKo55N5fNhZWPA9db7n+yUywy/epySXmTaVptsg40t7AoZ1AKO6HsN/1GFWL3oGBLR1XkiFHLWjJ54PRHfI0Oxp6I1w3132Na2X5PiViovPMdM+R5A2YUf49ElW+0pFDyIVdoPjaNtPbOGoxH6XI1+bbvEvw6Eg8NWiMVFugei8/0rq1pIYaPwFdOj0qmarl0zHlqwRHjDXg4rQ4PmVB+yoAtM9Xan0f5o3sVu1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQO1UfP5eVVfnhirSzy21WyyfR5FHRby6ETrEalTw4k=;
 b=lr15GekEMDXtKy7r4Py/VS+6E/KF193Ko3xBUpaOfms21bONRGu2zXFuxTS2ipTCO/oJ2dZxIlRFMhRWdvdP6ZvScK+xacrhneD+bUSUk5IhAoyXI9Jf2pj34PVfhACAb39cQRVhbz3AUdw88KycHbQBoXuU25WCW2fen3dcF1c=
Received: from MN2PR08CA0027.namprd08.prod.outlook.com (2603:10b6:208:239::32)
 by LV2PR12MB5750.namprd12.prod.outlook.com (2603:10b6:408:17e::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 07:43:13 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:239:cafe::71) by MN2PR08CA0027.outlook.office365.com
 (2603:10b6:208:239::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.48 via Frontend Transport; Wed,
 15 Apr 2026 07:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 07:43:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 02:43:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 15 Apr
 2026 00:43:11 -0700
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 15 Apr 2026 02:43:08 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Chenyu Chen
 <chen-yu.chen@amd.com>
Subject: [PATCH 05/19] drm/amd/display: Align HWSS fast commit path with
 legacy path
Date: Wed, 15 Apr 2026 15:39:44 +0800
Message-ID: <20260415074223.34848-6-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|LV2PR12MB5750:EE_
X-MS-Office365-Filtering-Correlation-Id: f25aff44-5404-41b7-d206-08de9ac2a5f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: YA4Zkrst810lqsGPiBq5nK4BVkwGxpMYVD4dDHLm51Ticf4NhgJW8wg7wLTdCVEB/5mY15870ubP2dYFQd7cxJe+e201Qq7estSqp3cIKwsdKib0p5iJu/hLSWxO55UeC0fyALy9ilPyycO1j2NRlxr9uqWD41ieJQPE2zTcsEWEf8M0c+pPq6dVSZoB69Cqb1N5vYD1lGf+3ajlKiwhXYSQE5wVzs9qeOefCE1QihFTaxtQKBKZNNwcFiollKvnSGyKQ4AlkwAJ4KqJfGrzMsdOsFv8t94Xbv35zaCVmHLScCZBB8RjVAXnsXr38Po7m4I+7kjra0leStYmJlcaGJVcw4cwhJiho5OsXVWdZueIKwQ9Np7xcLQ7xTjl/IY0iSTlKaRJAiUz1pPPFLruga/UDcNWPHcQ57Xypp1IfdRLLn4gJJJ6fMnaWlc4Y17dpJ8orYmt+8hTu+JwixtcGbANrXPAexviFm8bK+2oCytLSKiKlsr+HNKxAIUKoibkgE8wG8uV+mwKKHMxZMlBx9FK7gvezDZ0Oe4Z1GUWrqNPBbQDjY+XPIdhf0tK/d91p/s7lLOJuMQRwxYiFf1lbI9pBfb+Di6g/Q9FYgSTCQbsYviKctFKl2nzGaC3DVCKj9HBdKGxfAovJSPWHdHgIPhZ9i3o5GvFhmEkh1WxxTDYImvwkHVvL/3TB3OjHoDABBGnGrlUiNbsPYocWzfJVf8qCY1q0UdAI0905YCre/EdsWL4aVsJHa8Ex0jCN3d+439aL+cgWU+/iqFlsKbfrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xPGGVPwM47z4PgjqWg8InP/JANp/EC5xnj5JlzqqWbGA15Cir8qCIb5KpSpuy32asG0Dwi8bv4TaxJQ+zc1HjGHPmgyPEGx2bntINx7ouieUWsZ2GBwgdDGFrs8x2/f35/npkYFW365d3AcRZkip+rCji09q9ozAoXzxuAHgyXvMUZ3t409XANkm26OXsXT1eEkBXxW2u73ahe8VvNWhOYvnNSSJxMknay0CoYMcvUNwFYbkOGJVNMaxeLV4rfErnaj/YfMbjM/oH+jY4XcIVIXAnBOUDZhBNJOldj5Ywkg+DoHsaT2FCZlgpFRQlG3R/DlHzCloRAVqQ8YUvbK6ZbUYSUrvzbIq4DP0+njave3fE0wuiRBUSAB8htMK8IPuUutxVmSz4Ycqo4jWI7JukajUcKu13AZum1AD5LH4NJfbcIfziR/iE6VkGdP2QDEL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 07:43:13.1106 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f25aff44-5404-41b7-d206-08de9ac2a5f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5750
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

Add missing operations to commit_planes_for_stream_fast and
hwss_build_fast_sequence to match the legacy commit_planes_for_stream
behavior for UPDATE_TYPE_FAST updates.

- Add stream-level fast update flags (cursor_attr, cursor_pos,
  periodic_interrupt, info_frame, dmdata, dither) to dc_stream.h
- Add stream-level fields to dc_fast_update struct for fast/full
  update classification in populate_fast_updates/fast_updates_exist
- Add HWSS_SETUP_PERIODIC_INTERRUPT block sequence entry, delegating
  to dc->hwss.setup_periodic_interrupt instead of calling dcn10
  directly
- Add HUBP_ENABLE_3DLUT_FL block for 3DLUT FL with
  should_update_pipe_for_stream/plane guards
- Add DPP_SET_CURSOR_MATRIX block with new cursor_csc_change flag
- Widen DPP_PROGRAM_GAMUT_REMAP to also trigger on stream gamut_remap
- Add info frame, dmdata, dither, and cursor blocks to
  hwss_build_fast_sequence
- Reclassify cursor_position/cursor_attributes as UPDATE_TYPE_FAST
- Extract dc_dmdata_types.h to resolve circular include between
  hw_sequencer.h and dc_stream.h
- Remove dcn10_hwseq.h include from dc_hw_sequencer.c

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 117 ++++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 475 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  15 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  35 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  30 ++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 138 +++++
 6 files changed, 765 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 63f51c69919b..534f770949d5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2947,6 +2947,11 @@ static struct surface_update_descriptor det_surface_update(
 		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 	}
 
+	if (u->cursor_csc_color_matrix) {
+		update_flags->bits.cursor_csc_color_matrix_change = 1;
+		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+	}
+
 	if (u->coeff_reduction_factor) {
 		update_flags->bits.coeff_reduction_change = 1;
 		elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
@@ -3074,7 +3079,7 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL | LOCK_DESCRIPTOR_LINK);
 		}
 
-		if (stream_update->gamut_remap)
+		if (check_config->enable_legacy_fast_update && stream_update->gamut_remap)
 			su_flags->bits.gamut_remap = 1;
 
 		if (stream_update->wb_update)
@@ -3105,6 +3110,29 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 			elevate_update_type(&overall_type, UPDATE_TYPE_FULL, LOCK_DESCRIPTOR_GLOBAL);
 
 		// Non-global cases
+
+		if (stream_update->gamut_remap) {
+			su_flags->bits.gamut_remap = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		}
+
+		if ((stream_update->hdr_static_metadata && !stream_update->stream->use_dynamic_meta) ||
+				stream_update->vrr_infopacket ||
+				stream_update->vsc_infopacket ||
+				stream_update->vsp_infopacket ||
+				stream_update->hfvsif_infopacket ||
+				stream_update->adaptive_sync_infopacket ||
+				stream_update->vtem_infopacket ||
+				stream_update->avi_infopacket) {
+			su_flags->bits.info_frame = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		}
+
+		if (stream_update->hdr_static_metadata && stream_update->stream->use_dynamic_meta) {
+			su_flags->bits.dmdata = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		}
+
 		if (stream_update->output_csc_transform) {
 			su_flags->bits.out_csc = 1;
 			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
@@ -3114,6 +3142,26 @@ static struct surface_update_descriptor check_update_surfaces_for_stream(
 			su_flags->bits.out_tf = 1;
 			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
 		}
+
+		if (stream_update->periodic_interrupt) {
+			su_flags->bits.periodic_interrupt = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		}
+
+		if (stream_update->dither_option) {
+			su_flags->bits.dither = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		}
+
+		if (stream_update->cursor_attributes) {
+			su_flags->bits.cursor_attr = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		}
+
+		if (stream_update->cursor_position) {
+			su_flags->bits.cursor_pos = 1;
+			elevate_update_type(&overall_type, UPDATE_TYPE_FAST, LOCK_DESCRIPTOR_STREAM);
+		}
 	}
 
 	for (int i = 0 ; i < surface_count; i++) {
@@ -5110,9 +5158,35 @@ void populate_fast_updates(struct dc_fast_update *fast_update,
 	if (stream_update) {
 		fast_update[0].out_transfer_func = stream_update->out_transfer_func;
 		fast_update[0].output_csc_transform = stream_update->output_csc_transform;
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
 	} else {
 		fast_update[0].out_transfer_func = NULL;
 		fast_update[0].output_csc_transform = NULL;
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
 	}
 
 	for (i = 0; i < surface_count; i++) {
@@ -5133,7 +5207,20 @@ static bool fast_updates_exist(const struct dc_fast_update *fast_update, int sur
 	int i;
 
 	if (fast_update[0].out_transfer_func ||
-		fast_update[0].output_csc_transform)
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
 		return true;
 
 	for (i = 0; i < surface_count; i++) {
@@ -5157,7 +5244,20 @@ bool fast_nonaddr_updates_exist(struct dc_fast_update *fast_update, int surface_
 	int i;
 
 	if (fast_update[0].out_transfer_func ||
-		fast_update[0].output_csc_transform)
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
 		return true;
 
 	for (i = 0; i < surface_count; i++) {
@@ -5241,23 +5341,12 @@ static bool full_update_required(
 			(((stream_update->src.height != 0 && stream_update->src.width != 0) ||
 			(stream_update->dst.height != 0 && stream_update->dst.width != 0) ||
 			stream_update->integer_scaling_update) ||
-			stream_update->hdr_static_metadata ||
 			stream_update->abm_level ||
-			stream_update->periodic_interrupt ||
-			stream_update->vrr_infopacket ||
-			stream_update->vsc_infopacket ||
-			stream_update->vsp_infopacket ||
-			stream_update->hfvsif_infopacket ||
-			stream_update->vtem_infopacket ||
-			stream_update->adaptive_sync_infopacket ||
-			stream_update->avi_infopacket ||
 			stream_update->dpms_off ||
 			stream_update->allow_freesync ||
 			stream_update->vrr_active_variable ||
 			stream_update->vrr_active_fixed ||
-			stream_update->gamut_remap ||
 			stream_update->output_color_space ||
-			stream_update->dither_option ||
 			stream_update->wb_update ||
 			stream_update->dsc_config ||
 			stream_update->mst_bw_update ||
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 7333f5905330..f8a6916bbd4d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -39,6 +39,8 @@
 #include "abm.h"
 #include "dcn10/dcn10_hubbub.h"
 #include "dce/dmub_hw_lock_mgr.h"
+#include "custom_float.h"
+#include "link_service.h"
 
 #define MAX_NUM_MCACHE 8
 
@@ -789,8 +791,242 @@ void hwss_build_fast_sequence(struct dc *dc,
 		(*num_steps)++;
 	}
 
+	if (dc->hwss.setup_periodic_interrupt && stream->update_flags.bits.periodic_interrupt) {
+		block_sequence[*num_steps].params.setup_periodic_interrupt_params.dc = dc;
+		block_sequence[*num_steps].params.setup_periodic_interrupt_params.pipe_ctx = pipe_ctx;
+		block_sequence[*num_steps].func = HWSS_SETUP_PERIODIC_INTERRUPT;
+		(*num_steps)++;
+	}
+
+	if (stream->update_flags.bits.info_frame) {
+		resource_build_info_frame(pipe_ctx);
+		block_sequence[*num_steps].params.update_info_frame_params.dc = dc;
+		block_sequence[*num_steps].params.update_info_frame_params.pipe_ctx = pipe_ctx;
+		block_sequence[*num_steps].func = HWSS_UPDATE_INFO_FRAME;
+		(*num_steps)++;
+
+		if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+			block_sequence[*num_steps].params.dp_trace_source_sequence_params.dc = dc;
+			block_sequence[*num_steps].params.dp_trace_source_sequence_params.link = pipe_ctx->stream->link;
+			block_sequence[*num_steps].params.dp_trace_source_sequence_params.dp_test_mode = DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME;
+			block_sequence[*num_steps].func = DP_TRACE_SOURCE_SEQUENCE;
+			(*num_steps)++;
+		}
+	}
+
+	if (dc->hwss.set_dmdata_attributes && stream->update_flags.bits.dmdata &&
+			stream->use_dynamic_meta && pipe_ctx->stream->dmdata_address.quad_part != 0) {
+		struct dc_dmdata_attributes attr = { 0 };
+
+		attr.dmdata_mode = DMDATA_HW_MODE;
+		attr.dmdata_size = dc_is_hdmi_signal(pipe_ctx->stream->signal) ? 32 : 36;
+		attr.address.quad_part = pipe_ctx->stream->dmdata_address.quad_part;
+		attr.dmdata_dl_delta = 0;
+		attr.dmdata_qos_mode = 0;
+		attr.dmdata_qos_level = 0;
+		attr.dmdata_repeat = 1; /* always repeat */
+		attr.dmdata_updated = 1;
+		attr.dmdata_sw_data = NULL;
+
+		block_sequence[*num_steps].params.set_dmdata_attributes_params.hubp = pipe_ctx->plane_res.hubp;
+		block_sequence[*num_steps].params.set_dmdata_attributes_params.attr = attr;
+		block_sequence[*num_steps].func = HUBP_SET_DMDATA_ATTRIBUTES;
+		(*num_steps)++;
+	}
+
+	/* Track cursor lock state - separate locks for attribute and position updates */
+	bool enable_cursor_offload = false;
+
+	if ((dc->hwss.set_cursor_attribute && stream->update_flags.bits.cursor_attr) ||
+		(dc->hwss.set_cursor_position && stream->update_flags.bits.cursor_pos))
+		enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
+
+	/* Cursor attribute updates - separate lock/iterate/unlock */
+	if (dc->hwss.set_cursor_attribute && stream->update_flags.bits.cursor_attr) {
+		struct pipe_ctx *cursor_pipe_to_program = NULL;
+
+		for (i = 0; i < MAX_PIPES; i++) {
+			current_pipe = &context->res_ctx.pipe_ctx[i];
+
+			if (current_pipe->stream != stream)
+				continue;
+
+			if (!cursor_pipe_to_program) {
+				cursor_pipe_to_program = current_pipe;
+
+				if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
+					block_sequence[*num_steps].params.begin_cursor_offload_update_params.dc = dc;
+					block_sequence[*num_steps].params.begin_cursor_offload_update_params.pipe_ctx =
+						current_pipe;
+					block_sequence[*num_steps].func = HWSS_BEGIN_CURSOR_OFFLOAD_UPDATE;
+					(*num_steps)++;
+				} else {
+					block_sequence[*num_steps].params.cursor_lock_params.dc = dc;
+					block_sequence[*num_steps].params.cursor_lock_params.pipe_ctx = current_pipe;
+					block_sequence[*num_steps].params.cursor_lock_params.lock = true;
+					block_sequence[*num_steps].func = HWSS_CURSOR_LOCK;
+					(*num_steps)++;
+
+					if (current_pipe->next_odm_pipe) {
+						block_sequence[*num_steps].params.cursor_lock_params.dc = dc;
+						block_sequence[*num_steps].params.cursor_lock_params.pipe_ctx =
+							current_pipe->next_odm_pipe;
+						block_sequence[*num_steps].params.cursor_lock_params.lock = true;
+						block_sequence[*num_steps].func = HWSS_CURSOR_LOCK;
+						(*num_steps)++;
+					}
+				}
+			}
+
+			block_sequence[*num_steps].params.hubp_set_cursor_attributes_params.hubp =
+				current_pipe->plane_res.hubp;
+			block_sequence[*num_steps].params.hubp_set_cursor_attributes_params.attributes =
+				&current_pipe->stream->cursor_attributes;
+			block_sequence[*num_steps].func = HUBP_SET_CURSOR_ATTRIBUTES;
+			(*num_steps)++;
+
+			block_sequence[*num_steps].params.dpp_set_cursor_attributes_params.dpp =
+				current_pipe->plane_res.dpp;
+			block_sequence[*num_steps].params.dpp_set_cursor_attributes_params.attributes =
+				&current_pipe->stream->cursor_attributes;
+			block_sequence[*num_steps].func = DPP_SET_CURSOR_ATTRIBUTES;
+			(*num_steps)++;
+
+			if (dc->ctx->dmub_srv) {
+				block_sequence[*num_steps].params.send_cursor_info_to_dmu_params.pipe_ctx =
+					current_pipe;
+				block_sequence[*num_steps].params.send_cursor_info_to_dmu_params.pipe_idx =
+					current_pipe->pipe_idx;
+				block_sequence[*num_steps].func = DC_SEND_CURSOR_INFO_TO_DMU;
+				(*num_steps)++;
+			}
+
+			block_sequence[*num_steps].params.set_cursor_sdr_white_level_params.dc = dc;
+			block_sequence[*num_steps].params.set_cursor_sdr_white_level_params.pipe_ctx =
+				current_pipe;
+			block_sequence[*num_steps].func = SET_CURSOR_SDR_WHITE_LEVEL;
+			(*num_steps)++;
+
+			if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe) {
+				block_sequence[*num_steps].params.update_cursor_offload_pipe_params.dc = dc;
+				block_sequence[*num_steps].params.update_cursor_offload_pipe_params.pipe_ctx =
+					current_pipe;
+				block_sequence[*num_steps].func = HWSS_UPDATE_CURSOR_OFFLOAD_PIPE;
+				(*num_steps)++;
+			}
+		}
+
+		/* Unlock cursor attributes after all pipes have been programmed */
+		if (cursor_pipe_to_program) {
+			if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
+				block_sequence[*num_steps].params.commit_cursor_offload_update_params.dc = dc;
+				block_sequence[*num_steps].params.commit_cursor_offload_update_params.pipe_ctx =
+					cursor_pipe_to_program;
+				block_sequence[*num_steps].func = HWSS_COMMIT_CURSOR_OFFLOAD_UPDATE;
+				(*num_steps)++;
+			} else {
+				block_sequence[*num_steps].params.cursor_lock_params.dc = dc;
+				block_sequence[*num_steps].params.cursor_lock_params.pipe_ctx = cursor_pipe_to_program;
+				block_sequence[*num_steps].params.cursor_lock_params.lock = false;
+				block_sequence[*num_steps].func = HWSS_CURSOR_LOCK;
+				(*num_steps)++;
+
+				if (cursor_pipe_to_program->next_odm_pipe) {
+					block_sequence[*num_steps].params.cursor_lock_params.dc = dc;
+					block_sequence[*num_steps].params.cursor_lock_params.pipe_ctx =
+						cursor_pipe_to_program->next_odm_pipe;
+					block_sequence[*num_steps].params.cursor_lock_params.lock = false;
+					block_sequence[*num_steps].func = HWSS_CURSOR_LOCK;
+					(*num_steps)++;
+				}
+			}
+		}
+	}
+
+	/* Cursor position updates */
+	if (dc->hwss.set_cursor_position && stream->update_flags.bits.cursor_pos) {
+		struct pipe_ctx *cursor_pipe_to_program = NULL;
+
+		for (i = 0; i < MAX_PIPES; i++) {
+			current_pipe = &context->res_ctx.pipe_ctx[i];
+
+			if (current_pipe->stream != stream ||
+					(!current_pipe->plane_res.mi && !current_pipe->plane_res.hubp) ||
+					!current_pipe->plane_state ||
+					(!current_pipe->plane_res.xfm && !current_pipe->plane_res.dpp) ||
+					(!current_pipe->plane_res.ipp && !current_pipe->plane_res.dpp))
+				continue;
+
+			if (!cursor_pipe_to_program) {
+				cursor_pipe_to_program = current_pipe;
+
+				if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
+					block_sequence[*num_steps].params.begin_cursor_offload_update_params.dc = dc;
+					block_sequence[*num_steps].params.begin_cursor_offload_update_params.pipe_ctx =
+						current_pipe;
+					block_sequence[*num_steps].func = HWSS_BEGIN_CURSOR_OFFLOAD_UPDATE;
+					(*num_steps)++;
+				} else {
+					block_sequence[*num_steps].params.cursor_lock_params.dc = dc;
+					block_sequence[*num_steps].params.cursor_lock_params.pipe_ctx = current_pipe;
+					block_sequence[*num_steps].params.cursor_lock_params.lock = true;
+					block_sequence[*num_steps].func = HWSS_CURSOR_LOCK;
+					(*num_steps)++;
+				}
+			}
+
+			block_sequence[*num_steps].params.set_cursor_position_params.dc = dc;
+			block_sequence[*num_steps].params.set_cursor_position_params.pipe_ctx = current_pipe;
+			block_sequence[*num_steps].func = SET_CURSOR_POSITION;
+			(*num_steps)++;
+
+			if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe) {
+				block_sequence[*num_steps].params.update_cursor_offload_pipe_params.dc = dc;
+				block_sequence[*num_steps].params.update_cursor_offload_pipe_params.pipe_ctx =
+					current_pipe;
+				block_sequence[*num_steps].func = HWSS_UPDATE_CURSOR_OFFLOAD_PIPE;
+				(*num_steps)++;
+			}
+
+			if (dc->ctx->dmub_srv) {
+				block_sequence[*num_steps].params.send_cursor_info_to_dmu_params.pipe_ctx =
+					current_pipe;
+				block_sequence[*num_steps].params.send_cursor_info_to_dmu_params.pipe_idx =
+					current_pipe->pipe_idx;
+				block_sequence[*num_steps].func = DC_SEND_CURSOR_INFO_TO_DMU;
+				(*num_steps)++;
+			}
+		}
+
+		/* Unlock cursor position after all pipes have been programmed */
+		if (cursor_pipe_to_program) {
+			if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
+				block_sequence[*num_steps].params.commit_cursor_offload_update_params.dc = dc;
+				block_sequence[*num_steps].params.commit_cursor_offload_update_params.pipe_ctx =
+					cursor_pipe_to_program;
+				block_sequence[*num_steps].func = HWSS_COMMIT_CURSOR_OFFLOAD_UPDATE;
+				(*num_steps)++;
+			} else {
+				block_sequence[*num_steps].params.cursor_lock_params.dc = dc;
+				block_sequence[*num_steps].params.cursor_lock_params.pipe_ctx = cursor_pipe_to_program;
+				block_sequence[*num_steps].params.cursor_lock_params.lock = false;
+				block_sequence[*num_steps].func = HWSS_CURSOR_LOCK;
+				(*num_steps)++;
+			}
+		}
+	}
+
 	current_pipe = pipe_ctx;
 	while (current_pipe) {
+		if (current_pipe->stream->update_flags.bits.dither) {
+			resource_build_bit_depth_reduction_params(current_pipe->stream, &current_pipe->stream->bit_depth_params);
+			block_sequence[*num_steps].params.opp_program_fmt_params.opp = current_pipe->stream_res.opp;
+			block_sequence[*num_steps].params.opp_program_fmt_params.fmt_bit_depth = &current_pipe->stream->bit_depth_params;
+			block_sequence[*num_steps].params.opp_program_fmt_params.clamping = &current_pipe->stream->clamping;
+			block_sequence[*num_steps].func = OPP_PROGRAM_FMT;
+			(*num_steps)++;
+		}
+
 		current_mpc_pipe = current_pipe;
 		while (current_mpc_pipe) {
 			if (current_mpc_pipe->plane_state) {
@@ -831,7 +1067,9 @@ void hwss_build_fast_sequence(struct dc *dc,
 					(*num_steps)++;
 				}
 
-				if (dc->hwss.program_gamut_remap && current_mpc_pipe->plane_state->update_flags.bits.gamut_remap_change) {
+				if (dc->hwss.program_gamut_remap &&
+						(current_mpc_pipe->plane_state->update_flags.bits.gamut_remap_change ||
+						 current_mpc_pipe->stream->update_flags.bits.gamut_remap)) {
 					block_sequence[*num_steps].params.program_gamut_remap_params.pipe_ctx = current_mpc_pipe;
 					block_sequence[*num_steps].func = DPP_PROGRAM_GAMUT_REMAP;
 					(*num_steps)++;
@@ -856,6 +1094,16 @@ void hwss_build_fast_sequence(struct dc *dc,
 					block_sequence[*num_steps].func = DPP_PROGRAM_CM_HIST;
 					(*num_steps)++;
 				}
+
+				if (current_mpc_pipe->plane_res.dpp &&
+						current_mpc_pipe->plane_res.dpp->funcs->set_cursor_matrix &&
+						current_mpc_pipe->plane_state->update_flags.bits.cursor_csc_color_matrix_change) {
+					block_sequence[*num_steps].params.dpp_set_cursor_matrix_params.dpp = current_mpc_pipe->plane_res.dpp;
+					block_sequence[*num_steps].params.dpp_set_cursor_matrix_params.color_space = current_mpc_pipe->plane_state->color_space;
+					block_sequence[*num_steps].params.dpp_set_cursor_matrix_params.cursor_csc_color_matrix = &current_mpc_pipe->plane_state->cursor_csc_color_matrix;
+					block_sequence[*num_steps].func = DPP_SET_CURSOR_MATRIX;
+					(*num_steps)++;
+				}
 			}
 			if (hws->funcs.set_output_transfer_func && current_mpc_pipe->stream->update_flags.bits.out_tf) {
 				block_sequence[*num_steps].params.set_output_transfer_func_params.dc = dc;
@@ -989,7 +1237,25 @@ void hwss_execute_sequence(struct dc *dc,
 					params->set_input_transfer_func_params.plane_state);
 			break;
 		case DPP_PROGRAM_GAMUT_REMAP:
-			dc->hwss.program_gamut_remap(params->program_gamut_remap_params.pipe_ctx);
+			hwss_program_gamut_remap(params);
+			break;
+		case HUBP_ENABLE_3DLUT_FL:
+			hwss_hubp_enable_3dlut_fl(params);
+			break;
+		case OTG_SETUP_VERTICAL_INTERRUPT:
+			hwss_tg_setup_vertical_interrupt0(params);
+			break;
+		case HWSS_SETUP_PERIODIC_INTERRUPT:
+			hwss_setup_periodic_interrupt(dc, params);
+			break;
+		case HWSS_UPDATE_INFO_FRAME:
+			hwss_update_info_frame(dc, params);
+			break;
+		case DP_TRACE_SOURCE_SEQUENCE:
+			hwss_dp_trace_source_sequence(params);
+			break;
+		case HUBP_SET_DMDATA_ATTRIBUTES:
+			hwss_set_dmdata_attributes(params);
 			break;
 		case DPP_SETUP_DPP:
 			hwss_setup_dpp(params);
@@ -1311,9 +1577,30 @@ void hwss_execute_sequence(struct dc *dc,
 		case ABORT_CURSOR_OFFLOAD_UPDATE:
 			hwss_abort_cursor_offload_update(params);
 			break;
+		case HWSS_CURSOR_LOCK:
+			hwss_cursor_lock(params);
+			break;
+		case HWSS_BEGIN_CURSOR_OFFLOAD_UPDATE:
+			hwss_begin_cursor_offload_update(params);
+			break;
+		case HWSS_COMMIT_CURSOR_OFFLOAD_UPDATE:
+			hwss_commit_cursor_offload_update(params);
+			break;
+		case HWSS_UPDATE_CURSOR_OFFLOAD_PIPE:
+			hwss_update_cursor_offload_pipe(params);
+			break;
+		case DC_SEND_CURSOR_INFO_TO_DMU:
+			hwss_send_cursor_info_to_dmu(params);
+			break;
 		case SET_CURSOR_ATTRIBUTE:
 			hwss_set_cursor_attribute(params);
 			break;
+		case HUBP_SET_CURSOR_ATTRIBUTES:
+			hwss_hubp_set_cursor_attributes(params);
+			break;
+		case DPP_SET_CURSOR_ATTRIBUTES:
+			hwss_dpp_set_cursor_attributes(params);
+			break;
 		case SET_CURSOR_POSITION:
 			hwss_set_cursor_position(params);
 			break;
@@ -1732,6 +2019,21 @@ void hwss_add_tg_set_vtg_params(struct block_sequence_state *seq_state,
 	}
 }
 
+/*
+ * Helper function to add OTG setup vertical interrupt0 to block sequence
+ */
+void hwss_add_vertical_interrupt_setup(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, uint32_t start_line, uint32_t end_line)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.tg_setup_vertical_interrupt0_params.tg = tg;
+		seq_state->steps[*seq_state->num_steps].params.tg_setup_vertical_interrupt0_params.start_line = start_line;
+		seq_state->steps[*seq_state->num_steps].params.tg_setup_vertical_interrupt0_params.end_line = end_line;
+		seq_state->steps[*seq_state->num_steps].func = OTG_SETUP_VERTICAL_INTERRUPT;
+		(*seq_state->num_steps)++;
+	}
+}
+
 /*
  * Helper function to add TG setup vertical interrupt2 to block sequence
  */
@@ -1947,6 +2249,27 @@ void hwss_add_tg_wait_double_buffer_pending(struct block_sequence_state *seq_sta
 	}
 }
 
+void hwss_add_hubp_enable_3dlut_fl(struct block_sequence_state *seq_state,
+		struct hubp *hubp)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.hubp_enable_3dlut_fl_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_ENABLE_3DLUT_FL;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_set_dmdata_attributes(struct block_sequence_state *seq_state,
+		struct hubp *hubp, struct dc_dmdata_attributes *attr)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].params.set_dmdata_attributes_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.set_dmdata_attributes_params.attr = *attr;
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SET_DMDATA_ATTRIBUTES;
+		(*seq_state->num_steps)++;
+	}
+}
+
 void hwss_program_manual_trigger(union block_sequence_params *params)
 {
 	struct pipe_ctx *pipe_ctx = params->program_manual_trigger_params.pipe_ctx;
@@ -2416,6 +2739,59 @@ void hwss_tg_set_vtg_params(union block_sequence_params *params)
 		tg->funcs->set_vtg_params(tg, timing, program_fp2);
 }
 
+void hwss_hubp_enable_3dlut_fl(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_enable_3dlut_fl_params.hubp;
+
+	if (hubp->funcs->hubp_enable_3dlut_fl)
+		hubp->funcs->hubp_enable_3dlut_fl(hubp, true);
+}
+
+void hwss_update_info_frame(struct dc *dc, union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->update_info_frame_params.pipe_ctx;
+
+	if (dc->hwss.update_info_frame)
+		dc->hwss.update_info_frame(pipe_ctx);
+}
+
+void hwss_setup_periodic_interrupt(struct dc *dc, union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->setup_periodic_interrupt_params.pipe_ctx;
+
+	if (dc->hwss.setup_periodic_interrupt)
+		dc->hwss.setup_periodic_interrupt(dc, pipe_ctx);
+}
+
+void hwss_dp_trace_source_sequence(union block_sequence_params *params)
+{
+	struct dc *dc = params->dp_trace_source_sequence_params.dc;
+	struct dc_link *link = params->dp_trace_source_sequence_params.link;
+	uint8_t dp_test_mode = params->dp_trace_source_sequence_params.dp_test_mode;
+
+	if (dc->link_srv->dp_trace_source_sequence)
+		dc->link_srv->dp_trace_source_sequence(link, dp_test_mode);
+}
+
+void hwss_set_dmdata_attributes(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->set_dmdata_attributes_params.hubp;
+	struct dc_dmdata_attributes *attr = &params->set_dmdata_attributes_params.attr;
+
+	if (hubp->funcs->dmdata_set_attributes)
+		hubp->funcs->dmdata_set_attributes(hubp, attr);
+}
+
+void hwss_tg_setup_vertical_interrupt0(union block_sequence_params *params)
+{
+	struct timing_generator *tg = params->tg_setup_vertical_interrupt0_params.tg;
+	uint32_t start_line = params->tg_setup_vertical_interrupt0_params.start_line;
+	uint32_t end_line = params->tg_setup_vertical_interrupt0_params.end_line;
+
+	if (tg->funcs->setup_vertical_interrupt0)
+		tg->funcs->setup_vertical_interrupt0(tg, start_line, end_line);
+}
+
 void hwss_tg_setup_vertical_interrupt2(union block_sequence_params *params)
 {
 	struct timing_generator *tg = params->tg_setup_vertical_interrupt2_params.tg;
@@ -3113,6 +3489,51 @@ void hwss_abort_cursor_offload_update(union block_sequence_params *params)
 		dc->hwss.abort_cursor_offload_update(dc, pipe_ctx);
 }
 
+void hwss_cursor_lock(union block_sequence_params *params)
+{
+	struct dc *dc = params->cursor_lock_params.dc;
+	struct pipe_ctx *pipe_ctx = params->cursor_lock_params.pipe_ctx;
+	bool lock = params->cursor_lock_params.lock;
+
+	if (dc && dc->hwss.cursor_lock)
+		dc->hwss.cursor_lock(dc, pipe_ctx, lock);
+}
+
+void hwss_begin_cursor_offload_update(union block_sequence_params *params)
+{
+	struct dc *dc = params->begin_cursor_offload_update_params.dc;
+	struct pipe_ctx *pipe_ctx = params->begin_cursor_offload_update_params.pipe_ctx;
+
+	if (dc && dc->hwss.begin_cursor_offload_update)
+		dc->hwss.begin_cursor_offload_update(dc, pipe_ctx);
+}
+
+void hwss_commit_cursor_offload_update(union block_sequence_params *params)
+{
+	struct dc *dc = params->commit_cursor_offload_update_params.dc;
+	struct pipe_ctx *pipe_ctx = params->commit_cursor_offload_update_params.pipe_ctx;
+
+	if (dc && dc->hwss.commit_cursor_offload_update)
+		dc->hwss.commit_cursor_offload_update(dc, pipe_ctx);
+}
+
+void hwss_update_cursor_offload_pipe(union block_sequence_params *params)
+{
+	struct dc *dc = params->update_cursor_offload_pipe_params.dc;
+	struct pipe_ctx *pipe_ctx = params->update_cursor_offload_pipe_params.pipe_ctx;
+
+	if (dc && dc->hwss.update_cursor_offload_pipe)
+		dc->hwss.update_cursor_offload_pipe(dc, pipe_ctx);
+}
+
+void hwss_send_cursor_info_to_dmu(union block_sequence_params *params)
+{
+	struct pipe_ctx *pipe_ctx = params->send_cursor_info_to_dmu_params.pipe_ctx;
+	int pipe_idx = params->send_cursor_info_to_dmu_params.pipe_idx;
+
+	dc_send_update_cursor_info_to_dmu(pipe_ctx, pipe_idx);
+}
+
 void hwss_set_cursor_attribute(union block_sequence_params *params)
 {
 	struct dc *dc = params->set_cursor_attribute_params.dc;
@@ -3122,6 +3543,24 @@ void hwss_set_cursor_attribute(union block_sequence_params *params)
 		dc->hwss.set_cursor_attribute(pipe_ctx);
 }
 
+void hwss_hubp_set_cursor_attributes(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->hubp_set_cursor_attributes_params.hubp;
+	const struct dc_cursor_attributes *attributes = params->hubp_set_cursor_attributes_params.attributes;
+
+	if (hubp && hubp->funcs->set_cursor_attributes)
+		hubp->funcs->set_cursor_attributes(hubp, attributes);
+}
+
+void hwss_dpp_set_cursor_attributes(union block_sequence_params *params)
+{
+	struct dpp *dpp = params->dpp_set_cursor_attributes_params.dpp;
+	struct dc_cursor_attributes *attributes = params->dpp_set_cursor_attributes_params.attributes;
+
+	if (dpp && dpp->funcs->set_cursor_attributes)
+		dpp->funcs->set_cursor_attributes(dpp, attributes);
+}
+
 void hwss_set_cursor_position(union block_sequence_params *params)
 {
 	struct dc *dc = params->set_cursor_position_params.dc;
@@ -3140,6 +3579,14 @@ void hwss_set_cursor_sdr_white_level(union block_sequence_params *params)
 		dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
 }
 
+void hwss_program_gamut_remap(union block_sequence_params *params)
+{
+	struct dc *dc = params->program_gamut_remap_params.pipe_ctx->stream->ctx->dc;
+
+	if (dc && dc->hwss.program_gamut_remap)
+		dc->hwss.program_gamut_remap(params->program_gamut_remap_params.pipe_ctx);
+}
+
 void hwss_program_output_csc(union block_sequence_params *params)
 {
 	struct dc *dc = params->program_output_csc_params.dc;
@@ -4009,6 +4456,30 @@ void hwss_add_set_cursor_attribute(struct block_sequence_state *seq_state,
 	}
 }
 
+void hwss_add_hubp_set_cursor_attributes(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		const struct dc_cursor_attributes *attributes)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBP_SET_CURSOR_ATTRIBUTES;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_cursor_attributes_params.hubp = hubp;
+		seq_state->steps[*seq_state->num_steps].params.hubp_set_cursor_attributes_params.attributes = attributes;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_dpp_set_cursor_attributes(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		struct dc_cursor_attributes *attributes)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = DPP_SET_CURSOR_ATTRIBUTES;
+		seq_state->steps[*seq_state->num_steps].params.dpp_set_cursor_attributes_params.dpp = dpp;
+		seq_state->steps[*seq_state->num_steps].params.dpp_set_cursor_attributes_params.attributes = attributes;
+		(*seq_state->num_steps)++;
+	}
+}
+
 void hwss_add_set_cursor_position(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 7f55ba09b191..1b10b9770982 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1485,6 +1485,7 @@ union surface_update_flags {
 		uint32_t pixel_format_change:1;
 		uint32_t plane_size_change:1;
 		uint32_t gamut_remap_change:1;
+		uint32_t cursor_csc_color_matrix_change:1;
 
 		/* Full updates */
 		uint32_t new_plane:1;
@@ -1894,6 +1895,20 @@ struct dc_fast_update {
 #if defined(CONFIG_DRM_AMD_DC_DCN4_2)
 	struct cm_hist_control *cm_hist_control;
 #endif
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
 };
 
 struct dc_surface_update {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 7c38fa6f8cb1..88f70a9b64b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -64,35 +64,6 @@ struct dc_stream_status {
 	bool fpo_in_use;
 };
 
-enum hubp_dmdata_mode {
-	DMDATA_SW_MODE,
-	DMDATA_HW_MODE
-};
-
-struct dc_dmdata_attributes {
-	/* Specifies whether dynamic meta data will be updated by software
-	 * or has to be fetched by hardware (DMA mode)
-	 */
-	enum hubp_dmdata_mode dmdata_mode;
-	/* Specifies if current dynamic meta data is to be used only for the current frame */
-	bool dmdata_repeat;
-	/* Specifies the size of Dynamic Metadata surface in byte.  Size of 0 means no Dynamic metadata is fetched */
-	uint32_t dmdata_size;
-	/* Specifies if a new dynamic meta data should be fetched for an upcoming frame */
-	bool dmdata_updated;
-	/* If hardware mode is used, the base address where DMDATA surface is located */
-	PHYSICAL_ADDRESS_LOC address;
-	/* Specifies whether QOS level will be provided by TTU or it will come from DMDATA_QOS_LEVEL */
-	bool dmdata_qos_mode;
-	/* If qos_mode = 1, this is the QOS value to be used: */
-	uint32_t dmdata_qos_level;
-	/* Specifies the value in unit of REFCLK cycles to be added to the
-	 * current time to produce the Amortized deadline for Dynamic Metadata chunk request
-	 */
-	uint32_t dmdata_dl_delta;
-	/* An unbounded array of uint32s, represents software dmdata to be loaded */
-	uint32_t *dmdata_sw_data;
-};
 
 struct dc_writeback_info {
 	bool wb_enabled;
@@ -146,6 +117,12 @@ union stream_update_flags {
 		uint32_t fams_changed : 1;
 		uint32_t scaler_sharpener : 1;
 		uint32_t sharpening_required : 1;
+		uint32_t cursor_attr : 1;
+		uint32_t cursor_pos : 1;
+		uint32_t periodic_interrupt : 1;
+		uint32_t info_frame : 1;
+		uint32_t dmdata : 1;
+		uint32_t dither : 1;
 	} bits;
 
 	uint32_t raw;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index c08d5c005df6..476db257d4ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -790,6 +790,36 @@ struct dc_clock_config {
 	uint32_t current_clock_khz;/*current clock in use*/
 };
 
+enum hubp_dmdata_mode {
+	DMDATA_SW_MODE,
+	DMDATA_HW_MODE
+};
+
+struct dc_dmdata_attributes {
+	/* Specifies whether dynamic meta data will be updated by software
+	 * or has to be fetched by hardware (DMA mode)
+	 */
+	enum hubp_dmdata_mode dmdata_mode;
+	/* Specifies if current dynamic meta data is to be used only for the current frame */
+	bool dmdata_repeat;
+	/* Specifies the size of Dynamic Metadata surface in byte.  Size of 0 means no Dynamic metadata is fetched */
+	uint32_t dmdata_size;
+	/* Specifies if a new dynamic meta data should be fetched for an upcoming frame */
+	bool dmdata_updated;
+	/* If hardware mode is used, the base address where DMDATA surface is located */
+	PHYSICAL_ADDRESS_LOC address;
+	/* Specifies whether QOS level will be provided by TTU or it will come from DMDATA_QOS_LEVEL */
+	bool dmdata_qos_mode;
+	/* If qos_mode = 1, this is the QOS value to be used: */
+	uint32_t dmdata_qos_level;
+	/* Specifies the value in unit of REFCLK cycles to be added to the
+	 * current time to produce the Amortized deadline for Dynamic Metadata chunk request
+	 */
+	uint32_t dmdata_dl_delta;
+	/* An unbounded array of uint32s, represents software dmdata to be loaded */
+	uint32_t *dmdata_sw_data;
+};
+
 struct hw_asic_id {
 	uint32_t chip_id;
 	uint32_t chip_family;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index d1dba7ffcd9b..1cb2be00bf72 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -91,6 +91,37 @@ struct program_gamut_remap_params {
 	struct pipe_ctx *pipe_ctx;
 };
 
+struct hubp_enable_3dlut_fl_params {
+	struct hubp *hubp;
+};
+
+struct tg_setup_vertical_interrupt0_params {
+	struct timing_generator *tg;
+	uint32_t start_line;
+	uint32_t end_line;
+};
+
+struct update_info_frame_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct setup_periodic_interrupt_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct dp_trace_source_sequence_params {
+	struct dc *dc;
+	struct dc_link *link;
+	uint8_t dp_test_mode;
+};
+
+struct set_dmdata_attributes_params {
+	struct hubp *hubp;
+	struct dc_dmdata_attributes attr;
+};
+
 struct program_manual_trigger_params {
 	struct pipe_ctx *pipe_ctx;
 };
@@ -707,11 +738,47 @@ struct abort_cursor_offload_update_params {
 	struct pipe_ctx *pipe_ctx;
 };
 
+struct cursor_lock_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+	bool lock;
+};
+
+struct begin_cursor_offload_update_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct commit_cursor_offload_update_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct update_cursor_offload_pipe_params {
+	struct dc *dc;
+	struct pipe_ctx *pipe_ctx;
+};
+
+struct send_cursor_info_to_dmu_params {
+	struct pipe_ctx *pipe_ctx;
+	int pipe_idx;
+};
+
 struct set_cursor_attribute_params {
 	struct dc *dc;
 	struct pipe_ctx *pipe_ctx;
 };
 
+struct hubp_set_cursor_attributes_params {
+	struct hubp *hubp;
+	const struct dc_cursor_attributes *attributes;
+};
+
+struct dpp_set_cursor_attributes_params {
+	struct dpp *dpp;
+	struct dc_cursor_attributes *attributes;
+};
+
 struct set_cursor_position_params {
 	struct dc *dc;
 	struct pipe_ctx *pipe_ctx;
@@ -747,6 +814,12 @@ union block_sequence_params {
 	struct program_triplebuffer_params program_triplebuffer_params;
 	struct set_input_transfer_func_params set_input_transfer_func_params;
 	struct program_gamut_remap_params program_gamut_remap_params;
+	struct hubp_enable_3dlut_fl_params hubp_enable_3dlut_fl_params;
+	struct tg_setup_vertical_interrupt0_params tg_setup_vertical_interrupt0_params;
+	struct update_info_frame_params update_info_frame_params;
+	struct setup_periodic_interrupt_params setup_periodic_interrupt_params;
+	struct dp_trace_source_sequence_params dp_trace_source_sequence_params;
+	struct set_dmdata_attributes_params set_dmdata_attributes_params;
 	struct program_manual_trigger_params program_manual_trigger_params;
 	struct send_dmcub_cmd_params send_dmcub_cmd_params;
 	struct setup_dpp_params setup_dpp_params;
@@ -855,7 +928,14 @@ union block_sequence_params {
 	struct dpp_set_scaler_params dpp_set_scaler_params;
 	struct hubp_mem_program_viewport_params hubp_mem_program_viewport_params;
 	struct abort_cursor_offload_update_params abort_cursor_offload_update_params;
+	struct cursor_lock_params cursor_lock_params;
+	struct begin_cursor_offload_update_params begin_cursor_offload_update_params;
+	struct commit_cursor_offload_update_params commit_cursor_offload_update_params;
+	struct update_cursor_offload_pipe_params update_cursor_offload_pipe_params;
+	struct send_cursor_info_to_dmu_params send_cursor_info_to_dmu_params;
 	struct set_cursor_attribute_params set_cursor_attribute_params;
+	struct hubp_set_cursor_attributes_params hubp_set_cursor_attributes_params;
+	struct dpp_set_cursor_attributes_params dpp_set_cursor_attributes_params;
 	struct set_cursor_position_params set_cursor_position_params;
 	struct set_cursor_sdr_white_level_params set_cursor_sdr_white_level_params;
 	struct program_output_csc_params program_output_csc_params;
@@ -871,6 +951,12 @@ enum block_sequence_func {
 	HUBP_UPDATE_PLANE_ADDR,
 	DPP_SET_INPUT_TRANSFER_FUNC,
 	DPP_PROGRAM_GAMUT_REMAP,
+	HUBP_ENABLE_3DLUT_FL,
+	OTG_SETUP_VERTICAL_INTERRUPT,
+	HWSS_SETUP_PERIODIC_INTERRUPT,
+	HWSS_UPDATE_INFO_FRAME,
+	DP_TRACE_SOURCE_SEQUENCE,
+	HUBP_SET_DMDATA_ATTRIBUTES,
 	OPTC_PROGRAM_MANUAL_TRIGGER,
 	DMUB_SEND_DMCUB_CMD,
 	DPP_SETUP_DPP,
@@ -975,7 +1061,14 @@ enum block_sequence_func {
 	DPP_SET_SCALER,
 	HUBP_MEM_PROGRAM_VIEWPORT,
 	ABORT_CURSOR_OFFLOAD_UPDATE,
+	HWSS_CURSOR_LOCK,
+	HWSS_BEGIN_CURSOR_OFFLOAD_UPDATE,
+	HWSS_COMMIT_CURSOR_OFFLOAD_UPDATE,
+	HWSS_UPDATE_CURSOR_OFFLOAD_PIPE,
+	DC_SEND_CURSOR_INFO_TO_DMU,
 	SET_CURSOR_ATTRIBUTE,
+	HUBP_SET_CURSOR_ATTRIBUTES,
+	DPP_SET_CURSOR_ATTRIBUTES,
 	SET_CURSOR_POSITION,
 	SET_CURSOR_SDR_WHITE_LEVEL,
 	PROGRAM_OUTPUT_CSC,
@@ -1463,6 +1556,18 @@ void hwss_tg_wait_for_state(union block_sequence_params *params);
 
 void hwss_tg_set_vtg_params(union block_sequence_params *params);
 
+void hwss_hubp_enable_3dlut_fl(union block_sequence_params *params);
+
+void hwss_update_info_frame(struct dc *dc, union block_sequence_params *params);
+
+void hwss_setup_periodic_interrupt(struct dc *dc, union block_sequence_params *params);
+
+void hwss_dp_trace_source_sequence(union block_sequence_params *params);
+
+void hwss_set_dmdata_attributes(union block_sequence_params *params);
+
+void hwss_tg_setup_vertical_interrupt0(union block_sequence_params *params);
+
 void hwss_tg_setup_vertical_interrupt2(union block_sequence_params *params);
 
 void hwss_dpp_set_hdr_multiplier(union block_sequence_params *params);
@@ -1603,12 +1708,28 @@ void hwss_hubp_mem_program_viewport(union block_sequence_params *params);
 
 void hwss_abort_cursor_offload_update(union block_sequence_params *params);
 
+void hwss_cursor_lock(union block_sequence_params *params);
+
+void hwss_begin_cursor_offload_update(union block_sequence_params *params);
+
+void hwss_commit_cursor_offload_update(union block_sequence_params *params);
+
+void hwss_update_cursor_offload_pipe(union block_sequence_params *params);
+
+void hwss_send_cursor_info_to_dmu(union block_sequence_params *params);
+
 void hwss_set_cursor_attribute(union block_sequence_params *params);
 
+void hwss_hubp_set_cursor_attributes(union block_sequence_params *params);
+
+void hwss_dpp_set_cursor_attributes(union block_sequence_params *params);
+
 void hwss_set_cursor_position(union block_sequence_params *params);
 
 void hwss_set_cursor_sdr_white_level(union block_sequence_params *params);
 
+void hwss_program_gamut_remap(union block_sequence_params *params);
+
 void hwss_program_output_csc(union block_sequence_params *params);
 
 void hwss_hubp_set_legacy_tiling_compat_level(union block_sequence_params *params);
@@ -1695,6 +1816,9 @@ void hwss_add_tg_wait_for_state(struct block_sequence_state *seq_state,
 void hwss_add_tg_set_vtg_params(struct block_sequence_state *seq_state,
 		struct timing_generator *tg, struct dc_crtc_timing *dc_crtc_timing, bool program_fp2);
 
+void hwss_add_vertical_interrupt_setup(struct block_sequence_state *seq_state,
+		struct timing_generator *tg, uint32_t start_line, uint32_t end_line);
+
 void hwss_add_tg_setup_vertical_interrupt2(struct block_sequence_state *seq_state,
 		struct timing_generator *tg, int start_line);
 
@@ -2012,6 +2136,14 @@ void hwss_add_set_cursor_attribute(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx);
 
+void hwss_add_hubp_set_cursor_attributes(struct block_sequence_state *seq_state,
+		struct hubp *hubp,
+		const struct dc_cursor_attributes *attributes);
+
+void hwss_add_dpp_set_cursor_attributes(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		struct dc_cursor_attributes *attributes);
+
 void hwss_add_set_cursor_position(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx);
@@ -2056,4 +2188,10 @@ void hwss_add_opp_program_left_edge_extra_pixel(struct block_sequence_state *seq
 		enum dc_pixel_encoding pixel_encoding,
 		bool is_otg_master);
 
+void hwss_add_hubp_enable_3dlut_fl(struct block_sequence_state *seq_state,
+		struct hubp *hubp);
+
+void hwss_add_set_dmdata_attributes(struct block_sequence_state *seq_state,
+		struct hubp *hubp, struct dc_dmdata_attributes *attr);
+
 #endif /* __DC_HW_SEQUENCER_H__ */
-- 
2.43.0

