Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9010CC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A95110EB44;
	Tue,  8 Sep 2026 11:36:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WkBKYstj";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013000.outbound.protection.outlook.com
 [40.93.196.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DAC10EB44
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gdDzUa67MxULycVsU+OTD7zFbcuDAVpNfDNsQTRaYp4kwg70XtX/B3yMbuOFx1tiYw7DMHHpHbAb1x0w0wNungBUGKL6JiK2J+ErgmXGTNplQiZoem8xkOfg828TzCvemIyFPbdw2lyq7sUaIgDrbA0nLJC0bhRStMvlLaU+3sg0QZbx/+t5wzqWOZu00UJaN786fwYLcpVZcZ2pPPYnWyTCHSlQYt2/yndBOZyQnWf5JlzS/vWpnkPPo2s/ec23e/RPDr3YPAqNnOhYEvOMikItHnuMeexfNXgZHbrVllcx20XcxiPWHIQPtPe6pE3y9CDjn9LFbh+MpkRWl3qORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMKoYrfi4M6E44NpLZT3Y1AgL2MbQR/ITwBdoAYSZfk=;
 b=hJlvYq9m5HV9FglFRaZVDfMxs3pBrCIrHxnt80FuyT2JqBl7he4TjrTgF3f/cAfRMGEdbL3ArAPiR2cTQo2LDgzWUmceqIxql066ZYWDbHBHCzTU+YTb6BNA69JqHuH6H6s81ufxZnHYmp/VFElhuCmhJmke268m/EK0uwsl89NqwWps9Ncoc6/qCIh+LULlCg1CG3bBByBi7pkUV0fwELv7eRFX4B0iZF0azTKqv71PGvM6kwRAAN1Uzis+LsQy2DfDmMHLBglyMQxHVHEtJsVMlyY8meXsTZMzWRR/eQNtl9fM0B45MbG8+vEQ75nvgv86pVJCFm1zwV1o6pjf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMKoYrfi4M6E44NpLZT3Y1AgL2MbQR/ITwBdoAYSZfk=;
 b=WkBKYstj7lRicRM3mHCHkfbXyWc5O7DX8/wDISHIPHS2y9LuHtBbt/SrRRny0wiGrtwGQnfJKz6OljFESnDXEuSjlB4QM8MMWI5ug4VuJ4r+Ooahs8wjR0ypwAvcdps5RtU47fAXw5LhlrG3i5mcY/Fbekur67eJSSE6o6B2pMQ=
Received: from MN2PR18CA0005.namprd18.prod.outlook.com (2603:10b6:208:23c::10)
 by CH1PPFE5ACC0FD2.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::629) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 11:36:36 +0000
Received: from BN2PEPF0000A892.namprd04.prod.outlook.com
 (2603:10b6:208:23c:cafe::4f) by MN2PR18CA0005.outlook.office365.com
 (2603:10b6:208:23c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A892.mail.protection.outlook.com (10.167.248.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:36:36 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:36:35 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:36:35 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:36:27 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 19/66] drm/amd/display: Build MST DSC helpers for KUnit
Date: Tue, 8 Sep 2026 19:31:12 +0800
Message-ID: <20260908113338.2433445-20-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A892:EE_|CH1PPFE5ACC0FD2:EE_
X-MS-Office365-Filtering-Correlation-Id: f397c252-32b9-4449-3c68-08df0d9d70c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pjkx2Oth95lPXwJ9Qp+O99Rh+KA5eZIidIhaTVjNgWCieL3x4g5Vb5ADNoVr0NXLmdJo0lzES8Lq7NLO1g0zmxRLfowtutlEzPNOHFcvD5liS13QleT5APu9b64kaPooioDR73rKhHoENYSBToDIE3r+wGeuH0bAFaIBpjExWJf+9ORkMVPOBfQxc/PjtTot5pfV4Zm4dF4U6lPctg0SqQQ3Gb4/lWYCmjtfYCTjmpYUIrCGBR4xy4XQqF4LTRQek5siBtfF9iGfmMXw/sD5aEvmO58m1ajkA0utsKQuBP6FP1x1OIe/siF44AkX36hfAEEB/YIqY8ZEsVgpVR4CWuPPFSO2gHvvjNSLKoH60m4BS8BLD/onlJgkGfAdyV7nMmMVG1ArgmTlEgt0cDkYrQu8EPSdcGBnvPRmen2TyP7df5jVQAM1teXTWEiAgaqJn9mga+8NOlaYe/cgrA9o2n9RfasE8x9YDd4DDjBPXS7M+6ukwRkEYWQ+IR2QzuNGFYdSMO+LMVE5B30M+oTGjvg+bIeqI5U0MLwotdVoshOFhLgWjTOsI9gbQWE5InXCWN4/lXeNpxsGWEyH23QIAK10LGpa2w0JMaQlJV8diy1asMCRgIryDtszAMH3VNhax6LbhsLa1ahKHlPyQ0rxrntE3QSjNiV3HC+lHOrRSyHEdmCiXEz7H74vOkG95Jb6eb4OZkf1URyJdhq4MLmYRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Qe079mte4K+8fmrs8XhUJ32UkaoQ80km3nmRAfpYXETWObv02QgqaJ97z1p54t1hQeFYdk0AroAc4KItDEXi7PHwLHViyN+oeUHjINUX/Ba8yIfGrXolv6z0JEV7GbWilkWbhsd1N1se7cEsLCuXYjIcyfHdfd3pFR33VEDODwFxlFQiFZVcS4S1G0Eb7ztEEMQn+vGaoX3K3o3fLmUiwy64T0OhboYCJg9lrB/yX8HIn5xTzf6tYvxctWrR1tMN5ZPub1ruY6I7AbC5ku0/qHOI4+qcbt0lb63VxvkBf5Qn27Zac67PRmSOlAE2TGFqa1pqXAH/8W2f7H85T/TfUnIJzy1lt7xql0tScJ0jXMcX9YkWm67wAibYhEH4wTHozlJRhl2xq4EoPmqt4BBE9ZEh6/7vtTBpn22jr1qqiPgryBVwGOJQ6y6Ku1YLtlYQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:36:36.2348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f397c252-32b9-4449-3c68-08df0d9d70c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A892.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFE5ACC0FD2
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
The MST DSC helpers in amdgpu_dm_mst_types.c are compiled only when
CONFIG_DRM_AMD_DC_FP is enabled, which no UML KUnit build can select,
so none of them can be reached from the KUnit suite.

[HOW]
Widen the CONFIG_DRM_AMD_DC_FP guards to also build when
CONFIG_DRM_AMD_DC_KUNIT_TEST is set. The only caller of
validate_dsc_caps_on_connector() is guarded as well, so guard it by
IS_ENABLED() instead to keep it out of the KUnit build while still
referencing the helper. With the real bodies now built,
dm_mst_test_fp_guarded_public_stubs() no longer describes reachable
behaviour, so remove it along with its case entry.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 12 ++++++------
 .../tests/amdgpu_dm_mst_types_test.c          | 19 -------------------
 2 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index bce605fd6cdf..aad8fff2cd6f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -278,7 +278,7 @@ bool needs_dsc_aux_workaround(struct dc_link *link)
 }
 EXPORT_IF_KUNIT(needs_dsc_aux_workaround);
 
-#if defined(CONFIG_DRM_AMD_DC_FP)
+#if defined(CONFIG_DRM_AMD_DC_FP) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 static bool is_synaptics_cascaded_panamera(struct dc_link *link, struct drm_dp_mst_port *port)
 {
 	u8 branch_vendor_data[4] = { 0 }; // Vendor data 0x50C ~ 0x50F
@@ -504,8 +504,8 @@ STATIC_IFN_KUNIT int dm_dp_mst_get_modes(struct drm_connector *connector)
 		amdgpu_dm_update_freesync_caps(
 				connector, aconnector->drm_edid, true);
 
-#if defined(CONFIG_DRM_AMD_DC_FP)
-		if (!validate_dsc_caps_on_connector(aconnector))
+#if defined(CONFIG_DRM_AMD_DC_FP) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+		if (IS_ENABLED(CONFIG_DRM_AMD_DC_FP) && !validate_dsc_caps_on_connector(aconnector))
 			memset(&aconnector->dc_sink->dsc_caps,
 			       0, sizeof(aconnector->dc_sink->dsc_caps));
 #endif
@@ -937,7 +937,7 @@ struct dsc_mst_fairness_params {
 	struct amdgpu_dm_connector *aconnector;
 };
 
-#if defined(CONFIG_DRM_AMD_DC_FP)
+#if defined(CONFIG_DRM_AMD_DC_FP) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 static uint16_t get_fec_overhead_multiplier(struct dc_link *dc_link)
 {
 	u8 link_coding_cap;
@@ -1928,7 +1928,7 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
 }
 #endif
 
-#if defined(CONFIG_DRM_AMD_DC_FP)
+#if defined(CONFIG_DRM_AMD_DC_FP) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 static bool dp_get_link_current_set_bw(struct drm_dp_aux *aux, uint32_t *cur_link_bw)
 {
 	uint32_t total_data_bw_efficiency_x10000 = 0;
@@ -1990,7 +1990,7 @@ enum dc_status dm_dp_mst_is_port_support_mode(
 	struct amdgpu_dm_connector *aconnector,
 	struct dc_stream_state *stream)
 {
-#if defined(CONFIG_DRM_AMD_DC_FP)
+#if defined(CONFIG_DRM_AMD_DC_FP) || IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 	int branch_max_throughput_mps = 0;
 	struct dc_link_settings cur_link_settings;
 	uint32_t end_to_end_bw_in_kbps = 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 064af0022fb6..36d3f0eebb50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -2058,21 +2058,6 @@ static void dm_mst_test_sideband_msg_ready_ack_write_fails(struct kunit *test)
 	dm_mst_test_free_armed_sideband_connector(aconnector);
 }
 
-#if !defined(CONFIG_DRM_AMD_DC_FP)
-/**
- * dm_mst_test_fp_guarded_public_stubs - Test FP-off public fallbacks
- * @test: KUnit test context
- *
- * When CONFIG_DRM_AMD_DC_FP is disabled, the public DSC validation helper
- * has no FP body and must return DC_OK without touching its arguments.
- */
-static void dm_mst_test_fp_guarded_public_stubs(struct kunit *test)
-{
-	KUNIT_EXPECT_EQ(test, dm_dp_mst_is_port_support_mode(NULL, NULL),
-			(enum dc_status)DC_OK);
-}
-#endif
-
 static struct kunit_case dm_mst_types_test_cases[] = {
 	/* needs_dsc_aux_workaround tests */
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_match),
@@ -2152,10 +2137,6 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	/* dm_dp_mst_connector_destroy tests */
 	KUNIT_CASE(dm_mst_test_connector_destroy_no_sink),
 	KUNIT_CASE(dm_mst_test_connector_destroy_releases_sink),
-	/* CONFIG_DRM_AMD_DC_FP disabled public paths */
-#if !defined(CONFIG_DRM_AMD_DC_FP)
-	KUNIT_CASE(dm_mst_test_fp_guarded_public_stubs),
-#endif
 	{}
 };
 
-- 
2.43.0

