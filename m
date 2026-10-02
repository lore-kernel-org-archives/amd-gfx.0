Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FB7CA5FE4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A6EB10F9B3;
	Fri,  2 Oct 2026 19:33:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CYFTfbMt";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCF610E6BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yij2G/UwBZkPtLdaJDFDWVTWP7MnoXuZIMkvh4WnTsStjbDlCrqWf6knMJVLuLQU+/2NB3oJ7uvmajUnJK9z/gg7f03gia94XZVamdhFQgrFinThP89Hr1B5dB1be/4juvgsq08bz1M4P7ZHyjbyqz6F1+pidTM98XAaeAm60lZ0NMui9qE6i+PH97N5pTa5CUIgH8IRnTnyMvGbRoPTrS4MaTYaynq6Poov8qNpzSgY32t6prm3FS4VwA+MWv1D3wRBCmrgRKAPX61F6iYf8bhSYAWdQCb9qaI82MX2K6mJMq8/PBG0Xrctr5GvCrL22ZNpEuQEBpnbR0XkecXALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6w5qaWJAU5tmn1Du4mSZCp5RiyVh9h8mifE5DuP4gI=;
 b=xOfKcV4E2Rm06H3mjlo4jS+O1xwiqV1UzlVHovdrw/lq1K/HQXYNIMb5ZvalQMTAbt5qOjpr1BJaTRWyB4Z9JwBAZVdr0wKvpxDm46G2Gx5Me4SzJllSNonW70V1jMGhCw1nkTATdC7Vhl8uuMy4A1UoKJXxOVkKhwNkjem2z4TkWDDyqX4Ot74cECl+EPgrUehWtNzrxp29uu7bmMGfePDTgVwLbQzy/AADw5MtRmmrIs+BHZOF1C3k2dj7u/YaMePmDY8nngpkDepg3oscTd0ayOgaWZoIsp6B0YBscX8LpVrASZlU9KKS1MDLyArBn64IUlRRFVPPK/E+wgu61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6w5qaWJAU5tmn1Du4mSZCp5RiyVh9h8mifE5DuP4gI=;
 b=CYFTfbMtLVfKBkOLKu1Ot+RyKdgtdljW6kJjkTFo85U2hpEStRNAe+C3dqsi0Hwr4ShJOT6GWok4KzGrAtH4jqoWnUXVZzaTdOzvd8OivLjk2E3m5z4GJ2XGum1ggxcaPggr0ih42/3suJapPGh+ICK9J0k/ywx7hFV8fRG0Cjg=
Received: from CH2PR04CA0009.namprd04.prod.outlook.com (2603:10b6:610:52::19)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:33:14 +0000
Received: from CH2PEPF00000144.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::a5) by CH2PR04CA0009.outlook.office365.com
 (2603:10b6:610:52::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:33:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000144.mail.protection.outlook.com (10.167.244.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:05 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:04 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>, Aric Cyr
 <Aric.Cyr@amd.com>, Josip Pavic <josip.pavic@amd.com>
Subject: [PATCH 03/17] drm/amd/display: only reprogram DRR when v_total values
 change
Date: Fri, 2 Oct 2026 15:32:26 -0400
Message-ID: <20261002193240.3441018-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000144:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: df62c069-0f1b-4776-4100-08df20bbfec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|10067099003|18002099003|22082099003|11063799006|56012099006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info: 6EJczIRLLrUmc/I8QM1DVqYt+2wbwlcVRFfGA+46QfcjtrpULfp0vAFjJikYmaRZY3QdZkZX9CB5HwWBe06YoCyr4Wfr09FxxmcOXvu8C4tbfmLGEaZw989UGLcxaGjRtjLOVKCL2Qk89NRzCn1hyVgmwUHNmu0T8+vsuQR+WKo/1TmHVlNJSnYtFGTxV4BdWQO7jioKXRGq4y6FVxLcTr/1cvrUzDomW/w5KCt6t7DsGTRb5865OIdEzdsQuYNxt06TwNMCoLG3Gw03DY7qpb86cIibTmJTFa2A7aDUVg0KnrdYZlJrMwDLIGaqACvv+SIUV5ed4UunSviR76N3hFaTjDNuv8gj3rxjnjxHOzHI2qGEEk6NLtJTAlFrHIqEZimPvxWmPxdyfeJ4Lu0GNgb0NfV4KXS2oKvOIay2cjEHsLWC8A9Y6eeSK2DvUwMniX3VUC+Zu8aR8hjCE949egrOD7IliTS/YlxEniwbdMZ83bjYyXHZqYpIPzAlwLrkNYbmvMJvzjVE2jBV97ahd6kIESkVfZvio3C7bSRmbSTcHK3HNn8GfFEb736oTZvtA1B56UZljlr3XlFAUOBs0p0XpcxH2kq43qwKXD2zOo3S9esbpdP80s9s5uQ91Flfc9NCcrGiHu/1u+kj06Yug7rsM8PtTOLIjDHYugeeEuz2oe4a5r0G19BABKgSzcny
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(5023799004)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IgDUhIcCDPbU18XBbY3/d54UMZATz2rPyDt3gD9OFxXjhrHkMq9fhw3BwLxPrgiaEkUX+KkR1Y7peIIHtu50UsSXMXgzsVQs0N+pc62oBfLoNON0jbrxZZuEgGcnnp01cj3kIZoIBC00n0BzRkeVa0PXjZyAKWt4Rhl7/pwJHS0IFUPkx35dOLmQddRdLOX9WxMK0+dPmHZVsXVFqDOJ1fRQy6W05UFtPvPxckXKopX3a5ZZwA4IhvKC/0FBVIkowNApuKVzpADcm6Ohb1owkA86MDurYxsHfjVGIHnfnlwOYuOA/f/6bBx13M5Iz6hNnIbPQD3Ae3QO7i9r78sVsYfII2ry9FPOPJu6AgPF4ylY6b//yJ5sod0/gib16mu9agaxXu0dt52/RnvHC++hBMIh+TxWxSN0xC6Qd5XWxZVzGCEtEuCUh/TZg7/bmUXN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:11.4938 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df62c069-0f1b-4776-4100-08df20bbfec5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000144.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220
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

From: Aric Cyr <Aric.Cyr@amd.com>

[Why]
dc_stream_adjust_vmin_vmax() programmed the OTG on every call. FreeSync
BTR calls it once per vblank, so identical v_total values were rewritten
every frame, each one paying dc_exit_ips_for_hw_access() and, when FAMS
is enabled, a blocking DMUB round trip from setup_manual_trigger().

[How]
Return early when timing_adjust_pending is clear and every v_total field
already matches the request, so hardware is only touched when the values
change. stream->adjust is still updated on every path that continues, so
a later commit programs the requested values.

timing_adjust_pending is the existing "stream->adjust has not reached
hardware" marker, so keep it accurate wherever hardware is left
untouched: set_drr_and_clear_adjust_pending() now sets it when called
with null params, which resets DRR in the OTG during pipe back-end
teardown, and the max_v_total overflow path only clears it when
set_long_vtotal() runs.

Reviewed-by: Josip Pavic <josip.pavic@amd.com>
Signed-off-by: Aric Cyr <Aric.Cyr@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 24 +++++++++++++++----
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  3 ++-
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 17db12fe8022..254c2a9c1b04 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1342,6 +1342,7 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 		struct dc_crtc_timing_adjust *adjust)
 {
 	int i;
+	bool drr_unchanged;
 
 	/*
 	 * Don't adjust DRR while there's bandwidth optimizations pending to
@@ -1356,6 +1357,19 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 		}
 	}
 
+	/* timing_adjust_pending tracks whether stream->adjust still describes the
+	 * OTG, so a cleared flag plus matching values means hw is already current.
+	 */
+	drr_unchanged = !stream->adjust.timing_adjust_pending &&
+			stream->adjust.v_total_min == adjust->v_total_min &&
+			stream->adjust.v_total_max == adjust->v_total_max &&
+			stream->adjust.v_total_mid == adjust->v_total_mid &&
+			stream->adjust.v_total_mid_frame_num == adjust->v_total_mid_frame_num &&
+			stream->adjust.allow_otg_v_count_halt == adjust->allow_otg_v_count_halt;
+
+	if (drr_unchanged)
+		return true;
+
 	dc_exit_ips_for_hw_access(dc);
 
 	stream->adjust.v_total_max = adjust->v_total_max;
@@ -1366,11 +1380,13 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 
 	if (dc->caps.max_v_total != 0 &&
 		(adjust->v_total_max > dc->caps.max_v_total || adjust->v_total_min > dc->caps.max_v_total)) {
-		stream->adjust.timing_adjust_pending = false;
-		if (adjust->allow_otg_v_count_halt)
+		if (adjust->allow_otg_v_count_halt) {
+			stream->adjust.timing_adjust_pending = false;
 			return set_long_vtotal(dc, stream, adjust);
-		else
-			return false;
+		}
+		/* Nothing reached hw, so stream->adjust no longer describes the OTG. */
+		stream->adjust.timing_adjust_pending = true;
+		return false;
 	}
 
 	for (i = 0; i < MAX_PIPES; i++) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 21a62ca4c8dc..3d88c5c377fc 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -716,7 +716,8 @@ void set_drr_and_clear_adjust_pending(
 				pipe_ctx->stream_res.tg, params);
 
 	if (stream)
-		stream->adjust.timing_adjust_pending = false;
+		/* A null params resets DRR in hw, leaving stream->adjust stale. */
+		stream->adjust.timing_adjust_pending = (params == NULL);
 }
 
 void get_fams2_visual_confirm_color(
-- 
2.34.1

