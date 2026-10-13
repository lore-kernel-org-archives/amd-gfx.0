Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F810CC6B08
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB47010F786;
	Tue, 13 Oct 2026 11:20:00 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012046.outbound.protection.outlook.com [52.101.48.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E66610F78A
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:19:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r7SxE7HLKvdvKBwlwDyiqbpfJK3UQUf+JAQFf4TJWuADuql81BNuqv7Ly/W9HgZZnmmi+SjdZ2qyJxOC4jLCzBavCCnbr1CpSabP+yeW6KkPMwkirNMO/wIsxNEbHCh3VMAvgxXDQk7xM/SQzt+BDnlSIiCycAlVOfbxjPWCemn5hMKeZzTD8h2ZQJaResb13j5iy82T0pPPK1vrdvmBJK2PrMOGcXFQtIpL/OLKThl7hxCrqCM/YklShkLCcUyuk4GWxFbyf0ZmCn5y0Ke44ok8/uXGHg8P5LlJrJUvGOtjcMOlqhZbrqAGUB3CmklXVFHOhhDgkLThZ2Ganp/cqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3akjpicVX4vUtjB4MZLaLjhnw1HWqhl4KO9/lvFAEo=;
 b=LmHA5Y/QtxvycQePZ52gIZ87VaSBp/wJTeCkCIp0klAy/+MDnGmbHw8NKQQ/RasMWn4Oa4HPtWru1ZQAfhn2Vgp3eY5aQygZ1WCgn+/seIcRW/1Oy3N3AWcgPCRy214Evo817IuoMJEAzEYlbe6WC8ehV3gm267xGfwsqmJ4WO6p11T0da/QhPs7INQg//MYQKLxjoufXY5z3ifsfC6Uk09nwD8ORX0/sO4vVwmszIk9Yjv9Ab8PPKba9fr4XFl8OcFriu6pdcfYpULz9ru9B08INevttR6Mp+spo5sGC6XfXQCy9hM9OSflVSAwvn25ol5+c77lJfMksUEgo84DNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3akjpicVX4vUtjB4MZLaLjhnw1HWqhl4KO9/lvFAEo=;
 b=bEBFOCKShfHylK1+rLx2fQ8C4v2zOOOOLvafMqCJ4FpL5JNS/bW3Zm10pzEYOlxvzrSYU0jQtHfSxtfqSmsSMDTMAKKsUwOLIFIaeQfz6NkbmVcMr8XEOFl+piAqu+AmwgVKs5JKjJkr05TfAy3Qzqd8NAb9c9bwsxRmEZS6DDI=
Received: from CH2PR02CA0008.namprd02.prod.outlook.com (2603:10b6:610:4e::18)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Tue, 13 Oct
 2026 11:19:51 +0000
Received: from DM3PEPF000265C6.namprd03.prod.outlook.com
 (2603:10b6:610:4e:cafe::85) by CH2PR02CA0008.outlook.office365.com
 (2603:10b6:610:4e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:19:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C6.mail.protection.outlook.com (10.167.23.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:19:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:19:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:19:45 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:19:36 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>, Pei-Hsin Yang
 <peihsiny@valvesoftware.com>
Subject: [PATCH 25/30] drm/amd/display: align VRR timing gate with FreeSync
 module
Date: Tue, 13 Oct 2026 19:08:12 +0800
Message-ID: <20261013111616.2267344-26-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C6:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 98064e61-be2e-42e6-fd11-08df291be66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|10067099003|261009223027099003|11063799006|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: suPGnxdWLIUzm6ZhIM5c1Lnpd0iOo+0GjWnZ8xgzwFpU5/ao3mnH9eKsURxnSne+73Npm1ls3aDL79CV5WI9BbGTZ2NZl8hq7NzgL+lgPnZkFzUMpbiDiWERthdgS93g4LOpfcEgkg9GPh+vagsJDX+Z6+FPvDv4VXM7p7EPGrSxCWOKvc69Ft3jEb4d2vDl5Won15LjSKHa27ly4XdtClhvwHM7HNyJH14SMgGwV8Op+qyLyS129VxXfgMvrimMVwJbXoeIkKTrHFy4/Elt86+vRqhQGiWcKz5A6FUl+F0LZNX9UJUDWU85+bVEUglGiIy2oZGIf65NejXtyb8U5fi5U3KDzmeknQFi5tVthPwCGYDzmISfYdY53iAMl4rQKrFr+Y5Yw4kW6v1Vf6GeW0agl/cAR/OcUIWGBPJuugpO42KnYuX/+CFlB+YTXtgJ/DSkMc90SjXhIVbjXLyYRfTGsZCHsTyp8xqE4ujQmPEB0TGjWaNMDtxdCA+TJ8uXlJXEb3Sm4kooEkwWpMgyxErwi0SkUzFPbTEHKaoReYW3msgXkRXHlxWSUppyXc0FlIyjtA9DNQu7j9xLsBg/6J3855awyLqgPmbJljwDWVOSQ/gEOujEB+QmNwNnEq6C+qo40uIt0j8GY0HaD36i41ekvcJhjsYfNMWq+gg+y3jjUNtjHDQaJCaVdAn2gP/Erv5qGza1sWHZc29VY0ExtQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(10067099003)(261009223027099003)(11063799006)(5023799004)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +i7V5lhSambu8BM8WbPUVgHSwfNKncAJ/bWJ7KVyNpVucGZ+jFuczWgzByLy1cAW3uLh9Td2tAEUHf5wqbZZdGWFBUX6gyn+Ku1a59X9P0XYPEpxIFzEkJ6hBN4E1zDNyaNOjuXs/YWxgXhzVgxmIH3OvsALcrZFztpsTeCotqOhUQJXfxfkeXd0nJrYFDuwAH2CCt4sUnN5SQ6P35pMrDb1SWZ8ojWG1Y5T/KCaa83W3xY/WeG3PbYZzGbwgiCU042wNWMjdmGLJKlGeAjRNkrI1Uefq+lwD/O6QIu5Mp/rI4AsgAcLCV9UrA7WcFiS4Kvj17gmNG4lTlIpcTloqOgkmdTyPgVncZNnN/6UpurIB6oiOuUtlrp9PVebs0OMAWbma849vUHziA+blJXml1awJOZi5MRcdguRucji9Ztkzsn9sgBMPC2TjhqwjzH0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:19:51.5877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98064e61-be2e-42e6-fd11-08df291be66c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790
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

From: Fangzhi Zuo <jerry.zuo@amd.com>

[Why & How]
Use mod_freesync_calc_nominal_field_rate() when validating per-CRTC VRR
timing so atomic check uses the same stream timing basis as the later
FreeSync VRR parameter builder.

The previous gate compared the vtotal required for the sink's advertised
maximum refresh against the mode's nominal vtotal. That rejects every
mode below the panel's maximum refresh, even though VRR only needs to
vary below the mode's nominal refresh.

Cap the usable maximum at the mode nominal refresh and require a 10 Hz
minimum span above min_vfreq, matching the FreeSync module's
MIN_REFRESH_RANGE. This enables the affected 4K120 and 1080p60 modes
while continuing to reject degenerate ranges such as 720x576p50.

Fixes: 2553022aea6f ("drm/amd/display: reject invalid per-mode FreeSync timing")
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Pei-Hsin Yang <peihsiny@valvesoftware.com>
---
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 43 +++++++++++++------
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c |  8 +++-
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index 49c6048d0cc9..386ba88c57c6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -112,24 +112,28 @@ void amdgpu_dm_reset_freesync_config_for_crtc(
 }
 EXPORT_IF_KUNIT(amdgpu_dm_reset_freesync_config_for_crtc);
 
-static bool amdgpu_dm_is_vrr_timing_valid(const struct drm_display_mode *mode,
-		int max_vfreq)
+/* FreeSync module gates ACTIVE_VARIABLE on this minimum refresh span (Hz). */
+#define AMDGPU_DM_VRR_MIN_REFRESH_RANGE 10
+
+static bool amdgpu_dm_is_vrr_timing_valid(const struct dc_stream_state *stream,
+					  int min_vfreq, int max_vfreq)
 {
-	u64 numerator, denominator, vtotal_at_max_refresh;
+	u64 nominal_vfreq_uhz, usable_max_vfreq_uhz;
 
-	/*
-	 * Leave the existing decision unchanged without complete timing data;
-	 * otherwise, the computed vtotal must not be below the nominal vtotal.
-	 */
-	if (!mode->clock || !mode->htotal || !mode->vtotal || max_vfreq <= 0)
+	/* Without complete timing/range data, leave the existing decision. */
+	if (!stream || !stream->timing.pix_clk_100hz ||
+	    !stream->timing.h_total || !stream->timing.v_total ||
+	    min_vfreq <= 0 || max_vfreq <= 0)
 		return true;
 
-	numerator = (u64)mode->clock * 1000;
-	denominator = (u64)mode->htotal * max_vfreq;
-	vtotal_at_max_refresh =
-		div64_u64(numerator + denominator - 1, denominator);
+	/* Match the FreeSync module's nominal-rate calculation. */
+	nominal_vfreq_uhz = mod_freesync_calc_nominal_field_rate(stream);
+	usable_max_vfreq_uhz = min_t(u64, (u64)max_vfreq * 1000000,
+				     nominal_vfreq_uhz);
 
-	return vtotal_at_max_refresh >= mode->vtotal;
+	return usable_max_vfreq_uhz >=
+	       (u64)min_vfreq * 1000000 +
+	       (u64)AMDGPU_DM_VRR_MIN_REFRESH_RANGE * 1000000;
 }
 
 void amdgpu_dm_get_freesync_config_for_crtc(
@@ -148,7 +152,18 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 
 	aconnector = to_amdgpu_dm_connector(new_con_state->base.connector);
 
-	vrr_timing_valid = amdgpu_dm_is_vrr_timing_valid(mode, aconnector->max_vfreq);
+	vrr_timing_valid = amdgpu_dm_is_vrr_timing_valid(new_crtc_state->stream,
+							 aconnector->min_vfreq,
+							 aconnector->max_vfreq);
+	if (!vrr_timing_valid)
+		drm_dbg_kms(new_con_state->base.connector->dev,
+			    "VRR invalid %s %s %dx%d@%d %d-%d clk=%u h=%u v=%u\n",
+			    new_con_state->base.connector->name, mode->name,
+			    mode->hdisplay, mode->vdisplay, vrefresh,
+			    aconnector->min_vfreq, aconnector->max_vfreq,
+			    new_crtc_state->stream->timing.pix_clk_100hz,
+			    new_crtc_state->stream->timing.h_total,
+			    new_crtc_state->stream->timing.v_total);
 
 	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
 					vrefresh >= aconnector->min_vfreq &&
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index 85670e1cbb05..616a2b385140 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -349,8 +349,11 @@ static void dm_test_freesync_config_invalid_timing(struct kunit *test)
 	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
 
 	ctx->conn_state->freesync_capable = true;
-	ctx->aconnector->min_vfreq = 40;
+	ctx->aconnector->min_vfreq = 45;
 	ctx->aconnector->max_vfreq = 60;
+	ctx->stream->timing.pix_clk_100hz = 270000;
+	ctx->stream->timing.h_total = 864;
+	ctx->stream->timing.v_total = 625;
 	ctx->crtc_state->base.mode.clock = 27000;
 	ctx->crtc_state->base.mode.hdisplay = 720;
 	ctx->crtc_state->base.mode.vdisplay = 576;
@@ -363,6 +366,9 @@ static void dm_test_freesync_config_invalid_timing(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
 			(int)VRR_STATE_UNSUPPORTED);
 
+	ctx->stream->timing.pix_clk_100hz = 5940000;
+	ctx->stream->timing.h_total = 4400;
+	ctx->stream->timing.v_total = 2250;
 	ctx->crtc_state->base.mode.clock = 594000;
 	ctx->crtc_state->base.mode.hdisplay = 3840;
 	ctx->crtc_state->base.mode.vdisplay = 2160;
-- 
2.43.0

