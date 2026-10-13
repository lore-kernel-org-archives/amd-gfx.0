Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE0BCC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9119010E7D0;
	Tue, 13 Oct 2026 11:17:34 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95E3710F718
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:17:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cnr52IY4Z1arLbFV0BVD+Oc3EjSc1CtN1h8R/DH36X8CiUnmtDHMKtAfk6B813dxjW/ZT9oDKMRz0tTacH2aKnXr6V3JUR/nhJtCywAGDL2GKVf4wXqSP6l5QzqX9Ph4uMF7eAyo91dGHdU9OXJf6U/7+e6UiIkLzIdnhc0Oe5b/tXTwrDNST2QPYr1SBeDQR/JZOtqIcEatNUZ+VWxe8G/81lXtA3KH9qYqwMMTvrY+ErCOf+sEx5yZFds2CbXEFnu6xW/8C5kbklbfYNVnKkxaMzBYk4m3SB4NmWdShyaaYkmRsCfkdNC2q0fwXCklMOGCixAvBOMUifUsc8Qc3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78eSoMya9/eBpNKzIdeIASKHzHi++RjuKP9qf/CZX2U=;
 b=jbJBJxe65kgqv+EYCxwdK3t9MEsQNMVwA4LY0cJsWukGGqXM//1PPU8g3FiVZk1pUhL4cboXB7/+lliruKwiTHfKM4NkKtse09D+bZM5PaFRQvaGIaJUB+YXru/Aknu/+4prPTasiaJFGC2VMjdWdS8vvViWAiyYAviJ5NbuT5d/9XiRMHTb+oxoOdHeXo608IHV38abnckEaaRpgnD98mKbCctjesvmXTrM1V3Jz+kQ9Gntxzt9KaFkkxTGP8nvh73ou9I2fokv1khRIRma0cQvrJqm3x9c4a/9e2gNOmjIMrttRj51DXBNZeOfJKcjQI99vHyNosaiCDkHjVoq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78eSoMya9/eBpNKzIdeIASKHzHi++RjuKP9qf/CZX2U=;
 b=Fkq8vRsDYRpX92gGrNYJFM8SGvNZUaT5mLztlbn4yadA9h9H23BsM576toiLvRr1I+4lpYIddIWLihNo8/CoXdvOtE/tHHNfAeHTclxHGITyAAAAEVfOcphbmN2AxXyNsaZjiA2j0NaGfmb3TczkPK57FBvmMQPyR0EYOTufRm0=
Received: from BY1P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::12)
 by DS0PR12MB9037.namprd12.prod.outlook.com (2603:10b6:8:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:17:21 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::96) by BY1P220CA0025.outlook.office365.com
 (2603:10b6:a03:5c3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:17:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:17:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:17:03 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:16:54 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 08/30] drm/amd/display: reject invalid per-mode FreeSync timing
Date: Tue, 13 Oct 2026 19:07:55 +0800
Message-ID: <20261013111616.2267344-9-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|DS0PR12MB9037:EE_
X-MS-Office365-Filtering-Correlation-Id: ad5eea88-ed6c-4931-2b61-08df291b8c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|10067099003|3023799007|261009223027099003|5023799004|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: KlKnqP35qq7/FHT0K7RzFoOaUSQzvcPSL3a7ussad1W6tMGq4aNTuHl2v3cXWD6Mb9g926A2KLxMC0jVJNQZ1/F4uzL/9IZW92UyJOdZcP9W+MlJxFJCwuoMb107oztDu/sBW0VeZPUYm4NOYVY1eGq6VeXle4VEvdPWg+EVaEv3p7lvhERnT1pHJnZmNF3J5/8KL5FOWoWTKzWZZ8iwIyppyU93cXGJFGbvOW9MR7S3CitAMzkrwLfhXLOzMngcPGvqhYLSdQCw+C/56ZKGV9j9BHkjSbJZfLyfbFfIdjncXQg0ZNib1ulA3H7Ta7BwDyO8w2+QXuEc2HFo6oNAGuygoWfr2zGIICfSlg2OTtgBrNMDHfwoZHniccUnP667y97et2ibFaDUlulBtAxzeiPwL42cyM0MV8tfqIeaAlKjdp5FYM81En2WoSVTexZPMFWYyFjzhbcb39QA3nyIqssea30l3Z5drHNb9gf0zVXVj8Vx5dKh+4mcInjrEQB57IVIBgo04xcsfMxr2eygZ9fo2W7bsGi5/5TkfBhAe0uSeWNj6lR53RNm/oskeCG5Xm6U6FFRVRzQNq+cQK3kbes8zeQokbKtOGkfsQC06JJYnnBp1/czBIfgByL2tsb+w/4BYwCk5dfRSDu/c8Azbb6Yyo34PD/hDZ/wqvHqPA64yFvjku/zYifwx0fMejAP5H7d01xiswHT2fYA2qxXcQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(10067099003)(3023799007)(261009223027099003)(5023799004)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DY5Jbqmx1YRpxkQ1XviBsVHfQ/kdzdF7HhxXPGOAX9CbW/EdiVA66LsLpFm20sNED53gX0E1IILqd5ibNpq9kG47WV25IFxnbckWo40ggEGRZGqT4scBEZZpO37S121HWPR3YRdWMvUXJw63RRqk/eYhaGgQsJqL3ZMwYYPOwN806IWmkrp4haeCv2HndV4g6QkKlzfQmaJnzXRnM+06y7XLyvOiN19W84FUmWQRs5tAR3pSuX2sj7SBlzSF94qGeAef3T/NTGx81bmLeKnKk3ZVdu7zVMah76MdDjYxgF/wQCNwpmlkqDYYELPIuwAA32X+j0NPGS/+CsIvrb33wjkPDnAsULMscX1kuZlPNwqlUHIlqzXS6bbbTM6sR/IPUcYJmk9yi7Gfg0YKE+qHq3zraoTZVar54O3Latw/0HrCGQJzAdkE1yxeNC/dvFPU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:17:20.8019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad5eea88-ed6c-4931-2b61-08df291b8c94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9037
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
A zero EDID FreeSync VCP code means that no dynamic FreeSync on/off
control is available from the monitor OSD; it does not mean that the
sink lacks FreeSync capability. Do not clear freesync_capable solely
because freesync_vcp_code is zero; keep capability based on the parsed
FreeSync range while validating VRR timing per CRTC.

Some display modes cannot represent the sink's advertised maximum
FreeSync refresh without reducing the mode's nominal vertical total.
The FreeSync module clamps such a calculated vtotal back to nominal
while the stream can remain FreeSync-capable, leaving no valid timing
window for the requested maximum refresh. This affects low-clock
timings such as 720x576p50.

Compute the vtotal required at max_vfreq from each mode's pixel clock
and htotal, using ceiling division. Mark VRR unsupported when this
value is below the mode's nominal vtotal. If timing or range inputs
are incomplete, preserve the existing capability decision.

Add KUnit coverage for the invalid 720x576 timing and a valid 4K60
timing.

Fixes: 6f742bc837f1 ("drm/amd/display: Restore FreeSync VCP code check for HDMI/PCON sinks")
Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  6 ---
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    | 26 ++++++++++-
 .../tests/amdgpu_dm_connector_test.c          |  8 ++--
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 45 +++++++++++++++++--
 4 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 428a5f9377c6..224e8c6121c4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -4018,12 +4018,6 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 			amdgpu_dm_connector->min_vfreq;
 	}
 
-	/* HDMI/PCON without an EDID FreeSync VCP code is not FreeSync-capable. */
-	if ((sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
-	     as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) &&
-	    !sink->edid_caps.freesync_vcp_code)
-		freesync_capable = false;
-
 	/* Handle MCCS */
 	if (do_mccs) {
 		dm_helpers_read_mccs_caps(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index ab9cfbce8d73..b65af2cc1fb7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -112,6 +112,26 @@ void amdgpu_dm_reset_freesync_config_for_crtc(
 }
 EXPORT_IF_KUNIT(amdgpu_dm_reset_freesync_config_for_crtc);
 
+static bool amdgpu_dm_is_vrr_timing_valid(const struct drm_display_mode *mode,
+		int max_vfreq)
+{
+	u64 numerator, denominator, vtotal_at_max_refresh;
+
+	/*
+	 * Leave the existing decision unchanged without complete timing data;
+	 * otherwise, the computed vtotal must not be below the nominal vtotal.
+	 */
+	if (!mode->clock || !mode->htotal || !mode->vtotal || max_vfreq <= 0)
+		return true;
+
+	numerator = (u64)mode->clock * 1000;
+	denominator = (u64)mode->htotal * max_vfreq;
+	vtotal_at_max_refresh =
+		div64_u64(numerator + denominator - 1, denominator);
+
+	return vtotal_at_max_refresh >= mode->vtotal;
+}
+
 void amdgpu_dm_get_freesync_config_for_crtc(
 	struct dm_crtc_state *new_crtc_state,
 	struct dm_connector_state *new_con_state)
@@ -121,15 +141,19 @@ void amdgpu_dm_get_freesync_config_for_crtc(
 	struct drm_display_mode *mode = &new_crtc_state->base.mode;
 	int vrefresh = drm_mode_vrefresh(mode);
 	bool fs_vid_mode = false;
+	bool vrr_timing_valid;
 
 	if (new_con_state->base.connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 		return;
 
 	aconnector = to_amdgpu_dm_connector(new_con_state->base.connector);
 
+	vrr_timing_valid = amdgpu_dm_is_vrr_timing_valid(mode, aconnector->max_vfreq);
+
 	new_crtc_state->vrr_supported = new_con_state->freesync_capable &&
 					vrefresh >= aconnector->min_vfreq &&
-					vrefresh <= aconnector->max_vfreq;
+					vrefresh <= aconnector->max_vfreq &&
+					vrr_timing_valid;
 
 	if (new_crtc_state->vrr_supported) {
 		new_crtc_state->stream->ignore_msa_timing_param = true;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index de3a0b9c961a..d291ae40ca1d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -9572,7 +9572,7 @@ static void dm_test_fs_caps_hdmi_vsdb(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->aconnector->max_vfreq, 60);
 	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.min_vfreq, 24);
 	KUNIT_EXPECT_EQ(test, connector->display_info.monitor_range.max_vfreq, 60);
-	KUNIT_EXPECT_FALSE(test, dm_test_fs_caps_capable(ctx));
+	KUNIT_EXPECT_TRUE(test, dm_test_fs_caps_capable(ctx));
 }
 
 /**
@@ -9599,8 +9599,8 @@ static void dm_test_fs_caps_hdmi_no_vsdb(struct kunit *test)
  * @test: The KUnit test context
  *
  * A whitelisted protocol converter re-parses the AMD VSDB, enables SDP v1.3
- * packing and adopts the converter adaptive sync type. Without an EDID
- * FreeSync VCP code, the connector is not marked FreeSync-capable.
+ * packing and adopts the converter adaptive sync type. The connector remains
+ * FreeSync-capable when the EDID has no FreeSync VCP code.
  */
 static void dm_test_fs_caps_pcon_whitelist(struct kunit *test)
 {
@@ -9622,7 +9622,7 @@ static void dm_test_fs_caps_pcon_whitelist(struct kunit *test)
 			(int)FREESYNC_TYPE_PCON_IN_WHITELIST);
 	KUNIT_EXPECT_EQ(test, ctx->aconnector->min_vfreq, 24);
 	KUNIT_EXPECT_EQ(test, ctx->aconnector->max_vfreq, 60);
-	KUNIT_EXPECT_FALSE(test, dm_test_fs_caps_capable(ctx));
+	KUNIT_EXPECT_TRUE(test, dm_test_fs_caps_capable(ctx));
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
index 5ad50bc31613..547a543b9f5d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_freesync_test.c
@@ -340,6 +340,42 @@ static void dm_test_freesync_config_out_of_range(struct kunit *test)
 			(int)VRR_STATE_UNSUPPORTED);
 }
 
+/**
+ * dm_test_freesync_config_invalid_timing - Reject an invalid VRR timing
+ * @test: The KUnit test context
+ */
+static void dm_test_freesync_config_invalid_timing(struct kunit *test)
+{
+	struct dm_test_freesync_ctx *ctx = dm_test_freesync_ctx_alloc(test);
+
+	ctx->conn_state->freesync_capable = true;
+	ctx->aconnector->min_vfreq = 40;
+	ctx->aconnector->max_vfreq = 60;
+	ctx->crtc_state->base.mode.clock = 27000;
+	ctx->crtc_state->base.mode.hdisplay = 720;
+	ctx->crtc_state->base.mode.vdisplay = 576;
+	ctx->crtc_state->base.mode.htotal = 864;
+	ctx->crtc_state->base.mode.vtotal = 625;
+
+	amdgpu_dm_get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_FALSE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_UNSUPPORTED);
+
+	ctx->crtc_state->base.mode.clock = 594000;
+	ctx->crtc_state->base.mode.hdisplay = 3840;
+	ctx->crtc_state->base.mode.vdisplay = 2160;
+	ctx->crtc_state->base.mode.htotal = 4400;
+	ctx->crtc_state->base.mode.vtotal = 2250;
+
+	amdgpu_dm_get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
+
+	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->vrr_supported);
+	KUNIT_EXPECT_EQ(test, (int)ctx->crtc_state->freesync_config.state,
+			(int)VRR_STATE_INACTIVE);
+}
+
 /**
  * dm_test_freesync_config_active_variable - Test vrr_enabled yields ACTIVE_VARIABLE
  * @test: The KUnit test context
@@ -350,7 +386,7 @@ static void dm_test_freesync_config_active_variable(struct kunit *test)
 
 	ctx->conn_state->freesync_capable = true;
 	ctx->aconnector->min_vfreq = 48;
-	ctx->aconnector->max_vfreq = 120;
+	ctx->aconnector->max_vfreq = 60;
 	ctx->crtc_state->base.vrr_enabled = true;
 
 	amdgpu_dm_get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
@@ -362,7 +398,7 @@ static void dm_test_freesync_config_active_variable(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->crtc_state->freesync_config.min_refresh_in_uhz,
 			48000000U);
 	KUNIT_EXPECT_EQ(test, ctx->crtc_state->freesync_config.max_refresh_in_uhz,
-			120000000U);
+			60000000U);
 	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->freesync_config.vsif_supported);
 	KUNIT_EXPECT_TRUE(test, ctx->crtc_state->freesync_config.btr);
 }
@@ -377,7 +413,7 @@ static void dm_test_freesync_config_inactive(struct kunit *test)
 
 	ctx->conn_state->freesync_capable = true;
 	ctx->aconnector->min_vfreq = 48;
-	ctx->aconnector->max_vfreq = 120;
+	ctx->aconnector->max_vfreq = 60;
 	ctx->crtc_state->base.vrr_enabled = false;
 
 	amdgpu_dm_get_freesync_config_for_crtc(ctx->crtc_state, ctx->conn_state);
@@ -397,7 +433,7 @@ static void dm_test_freesync_config_active_fixed(struct kunit *test)
 
 	ctx->conn_state->freesync_capable = true;
 	ctx->aconnector->min_vfreq = 48;
-	ctx->aconnector->max_vfreq = 120;
+	ctx->aconnector->max_vfreq = 60;
 	/* Pre-set fixed state selects the freesync-video (fixed) path */
 	ctx->crtc_state->freesync_config.state = VRR_STATE_ACTIVE_FIXED;
 	ctx->crtc_state->freesync_config.fixed_refresh_in_uhz = 60000000;
@@ -842,6 +878,7 @@ static struct kunit_case amdgpu_dm_freesync_tests[] = {
 	KUNIT_CASE(dm_test_freesync_config_writeback),
 	KUNIT_CASE(dm_test_freesync_config_not_capable),
 	KUNIT_CASE(dm_test_freesync_config_out_of_range),
+	KUNIT_CASE(dm_test_freesync_config_invalid_timing),
 	KUNIT_CASE(dm_test_freesync_config_active_variable),
 	KUNIT_CASE(dm_test_freesync_config_inactive),
 	KUNIT_CASE(dm_test_freesync_config_active_fixed),
-- 
2.43.0

