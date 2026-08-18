Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24ABC5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4676110EC7B;
	Tue, 18 Aug 2026 20:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sT6DUYut";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21EA10EC7B
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:21:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbozC/qXfhyzoSkfQD9klfse+jdroO390lTFoQBxYey2snQ5TOAxzyC1kJK8cbsUpjwWCJw5tkESKW25PppmJbdDNPj/pfQ1upq4RytKc5hpszli04LddcyZ8kv9LgP0Azixith5NuGUFrr1bQ6U3YpsXkz2XN7QQOvtCsjr8WHwbxJ6BbimOC/XOuxruQwhNnGVFkh5rX0wL1FYTyASWFI+ZIiPXdskJCeV5zWbYAz9Nep469fbJQ97AuLVpHE6WGySC/lyPhZCovCesEj03mnHly9BhJKTzwoUC6MSUneRmtTCw/ywg0vvxVdI1y+dIWSv7lBYpWHVC2Jw720Kmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FXTLlmCS9S/hZDfMQOOhRDuCGXRM4uETVjy1gq+LiTw=;
 b=ly3+gWZ9IquXrUarZpmwsqk7Oorjw1KfDH2cIfouDRs2iTtlpkrGjtzVdNOaj5GlocEATfUGYZ1Wg/1UVn8fpmB+R8hqIvwpod2CDrNjyALpN9RyR7Svien287LVcL4gPe5ccZHSyGf2TAkqjOswjMbtfXbOGh0DrPa/uucrtgfcKfumH/5eoOL/U3aq3B8gMt314jUmcO7v0eeG5UF/qJXtyCHutR7ZHbILfVpILeOOVpiqchxBYZ/nMMIr23v15+TVcYx7Ev1ayEnv6WIL/zvQ6rECJF9pFrVfbOLVxQGGj6IqgPBRaSqvj+xbreOb7frXbcTf1R/XQUUgcfVeLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FXTLlmCS9S/hZDfMQOOhRDuCGXRM4uETVjy1gq+LiTw=;
 b=sT6DUYutL4dyUZ5pawfkf0HdWE7qixuQpLfeJydGj1EvFLzD/BtfEmbp5FE9Nn/LFTJEW29IJSdF8Hir4c+HL7vGVDp+DLtqxik3TOlZJ4VPJc8LtTMdqWEs1H6kLU7TP55NBYsFL8QaTGF9vUJF5wN4y/JIO6/eAcxfrPGMID8=
Received: from BN9PR03CA0347.namprd03.prod.outlook.com (2603:10b6:408:f6::22)
 by DS7PR12MB8345.namprd12.prod.outlook.com (2603:10b6:8:d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:21:50 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:408:f6:cafe::3a) by BN9PR03CA0347.outlook.office365.com
 (2603:10b6:408:f6::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:21:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:21:49 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:49 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:21:48 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 01/82] drm/amd/display: Fall back to overlay cursor on dcn4x
 when top plane doesn't fill CRTC
Date: Tue, 18 Aug 2026 16:14:53 -0400
Message-ID: <20260818202139.4172592-2-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|DS7PR12MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: e92c1943-3226-4b20-da70-08defd665599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|3023799007|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: RhjHjtAjtDp9CUec5V4IXEsVK0XdJp1K/FkXhLwRu+L/AFLt8ss2I6dI9THlWIp7DakR+yA2V2U8ferhuDsMyfBGbw7d19god+scOL/M0jtAvWACg119FZvpqGutsgOsfUoM6L4J104WMqFmy/Au0aQP2MYy3RxP8xPncVrVd9nf6t54JFOR4L0pmWUFwIYR3UU14ywwuyXnf6+t3ceoey6vykojHKmRrROIIZpPwHegizJu+gWqkFdJ46rtx6IAjnXrmB9OZ2MivHO5QEuyKJvMmlQCPemFlGD1bAYly1+RgYVyjbZwD3uSFaFQQHeKl9ZwHvCiHmquQ/vNrGIOxTXNuw9rjLJp9VzQs2zgUmG9JnOle0Repk6kQC8RdgJlurhT1puWY7JC20m6NHDhoR/skADLSop5uWjJDCwrbfwKuJuplC0XCvSyJWNyv3cVD9aex9DP8tX2AsDaSVGC0H1PvEj2xcrKhG7SDtLjre5Q5Ug7+uMjCQQh8If9UQKS1lraCYz9QCcTUvczUW/ove5F1fDX8bolJ+UO7Hwwcc+TwjvoGyCQZ4tnJwOeulw5vi66m6En9048l/q1nJL7jXGW9vyvqAmdXrAoVFA/wb23ASdcdw+b9pVbk7rrXm8yB3KAX++rIffSTdFNRxjSIXqBn88MBDQAIUMykG5fiSfXpjmwq52DLB19SdEdQURL
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TVvSuhCIG8pUiFPDECcXE68N5gO4rogFPHQSji9g/B64RTuf3RUKEuUrKfV3kij6L8w30AhOD+8bM3qEiuYpqVJHUJYJnA0hfUQavgX5pBfkCO6blI9nsXarsM8sPqkmZFYMLlP8re+PLcDpDEYGnhm3vfGPcYwUTqqvZGv+fCL1INdkj6WhkfMWHMbJZ5vbuQc9obqacSyzbYHclt/AJ7HpcFoCq0HYUJZKk78DDCXhH/OlK+7/cCmQi8/lKakQDD8NaxAofHpjNPD23cVODY9RxDpa1oZ8q5ptc/uDjKfxE0kCoACw3r0uj474YWhIEFpcM/d5xRgEIcjQBjvx/gJ84gVx1QAII0KmCrnpZknY9VbQwY4RnI28mq7MtX5eCcSlVnUbcMPNqFvg0SYlpGb58lkqX6sF4oHjN1R6GTMHDqhb4/1HMACDNFFcFsNu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:21:49.7392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e92c1943-3226-4b20-da70-08defd665599
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8345
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

From: James Lin <PingLei.Lin@amd.com>

[why]
amdgpu_dm_crtc_get_cursor_mode() returns DM_CURSOR_NATIVE_MODE early and
unconditionally for dcn4.x. That early return was added because these
ASICs no longer have the cursor-on-scaled-plane or cursor-on-yuv-plane
restrictions of older DCN, so native cursor is fine in those cases.
However, it also bypasses the "does the top plane fill the CRTC?" (hole)
evaluation further down. When the top/primary plane does not cover the
whole CRTC, the cursor must fall back to an overlay plane so it is
composited over the uncovered region; keeping the native cursor there
produces an incorrect result. As a consequence
igt@amdgpu/amd_cursor_overlay@non-full, which verifies exactly this
native->overlay fallback, fails on dcn42.

[how]
Change unconditional early return with a skip_fmt_scale_restrictions flag.
For dcn4.x keep skipping the YUV / active-color-pipeline / different-scale
overlay triggers (genuinely unnecessary on this hardware), but fall
through to the existing entire_crtc_covered check so a top plane that does
not fill the CRTC still selects DM_CURSOR_OVERLAY_MODE. Native mode is
still chosen when the plane covers the whole CRTC.

Update the amdgpu_dm_cursor KUnit tests accordingly: exercise the dcn4x
path with a full atomic state fixture (full coverage -> native) and add a
dcn4x hole case (top plane does not fill the CRTC -> overlay).

Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: James Lin <PingLei.Lin@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  | 28 ++++++++--------
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 32 +++++++++++++------
 2 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
index 9534848ed240c..c41fce07b8fa8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
@@ -87,12 +87,8 @@ STATIC_IFN_KUNIT int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 	 * check tiling flags when the FB doesn't have a modifier.
 	 */
 	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
-#if defined(CONFIG_DRM_AMD_DC_DCN6_0) || defined(CONFIG_DRM_AMD_DC_DCN5_0)
 		if (adev->family == AMDGPU_FAMILY_GC_12_0_0
 		    || adev->family == AMDGPU_FAMILY_GC_13_0_1) {
-#else
-		if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
-#endif
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, GFX12_SWIZZLE_MODE) == 0;
 		} else if (adev->family >= AMDGPU_FAMILY_AI) {
 			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
@@ -289,6 +285,7 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	int underlying_scale_w, underlying_scale_h;
 	int cursor_scale_w, cursor_scale_h;
 	int i;
+	bool skip_fmt_scale_restrictions = false;
 
 	/* Overlay cursor not supported on HW before DCN
 	 * DCN401/420 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
@@ -300,15 +297,17 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	 */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
-#if defined(CONFIG_DRM_AMD_DC_DCN6_0)
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
 	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0) ||
-#else
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
-#endif
 	    !dm_crtc_state->base.enable) {
-		*cursor_mode = DM_CURSOR_NATIVE_MODE;
-		return 0;
+		/*
+		 * Newer DCN has no cursor-on-scaled/yuv-plane restriction, so
+		 * skip those overlay triggers below. A plane that does not fill
+		 * the CRTC still needs overlay mode so the cursor renders over
+		 * the hole, so fall through to the coverage check instead of
+		 * unconditionally forcing native mode here.
+		 */
+		skip_fmt_scale_restrictions = true;
 	}
 
 	/* Init cursor_mode to be the same as current */
@@ -407,13 +406,15 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 			continue;
 
 		/* Underlying plane is YUV format - use overlay cursor */
-		if (amdgpu_dm_plane_is_video_format(plane_state->fb->format->format)) {
+		if (!skip_fmt_scale_restrictions &&
+		    amdgpu_dm_plane_is_video_format(plane_state->fb->format->format)) {
 			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
 			return 0;
 		}
 
 		/* Underlying plane has an active color pipeline - cursor would be transformed */
-		if (dm_plane_color_pipeline_active(state, plane, false)) {
+		if (!skip_fmt_scale_restrictions &&
+		    dm_plane_color_pipeline_active(state, plane, false)) {
 			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
 			return 0;
 		}
@@ -424,7 +425,8 @@ int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 				   &cursor_scale_w, &cursor_scale_h);
 
 		/* Underlying plane has different scale - use overlay cursor */
-		if (cursor_scale_w != underlying_scale_w &&
+		if (!skip_fmt_scale_restrictions &&
+		    cursor_scale_w != underlying_scale_w &&
 		    cursor_scale_h != underlying_scale_h) {
 			*cursor_mode = DM_CURSOR_OVERLAY_MODE;
 			return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
index efd16575896ec..9026c6ce73363 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
@@ -521,25 +521,38 @@ static void dm_test_crtc_get_cursor_mode_disabled_crtc(struct kunit *test)
 }
 
 /**
- * dm_test_crtc_get_cursor_mode_new_hardware - Test new hardware always uses native mode
+ * dm_test_crtc_get_cursor_mode_new_hardware - Test dcn4x uses native cursor when the top plane fills the CRTC
  * @test: The KUnit test context
  */
 static void dm_test_crtc_get_cursor_mode_new_hardware(struct kunit *test)
 {
-	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	struct dm_crtc_state *dm_crtc_state;
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
 	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_OVERLAY_MODE;
-	int ret;
 
-	dm_crtc_state = kunit_kzalloc(test, sizeof(*dm_crtc_state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
-	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
+	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
 
-	ret = amdgpu_dm_crtc_get_cursor_mode(adev, NULL, dm_crtc_state, &cursor_mode);
-	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
 	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_NATIVE_MODE);
 }
 
+/**
+ * dm_test_crtc_get_cursor_mode_new_hardware_hole - Test dcn4x falls back to
+ * overlay cursor when the top plane does not fill the CRTC
+ * @test: The KUnit test context
+ */
+static void dm_test_crtc_get_cursor_mode_new_hardware_hole(struct kunit *test)
+{
+	struct dm_cursor_mode_fixture fixture = dm_test_alloc_cursor_mode_fixture(test);
+	enum amdgpu_dm_cursor_mode cursor_mode = DM_CURSOR_NATIVE_MODE;
+
+	fixture.adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
+	fixture.old_primary_state->crtc_w = 1280;
+	fixture.primary_state->crtc_w = 1280;
+
+	KUNIT_EXPECT_EQ(test, dm_test_get_cursor_mode(&fixture, &cursor_mode), 0);
+	KUNIT_EXPECT_EQ(test, cursor_mode, DM_CURSOR_OVERLAY_MODE);
+}
+
 /**
  * dm_test_crtc_get_cursor_mode_no_change - Test unchanged atomic state preserves cursor mode
  * @test: The KUnit test context
@@ -948,6 +961,7 @@ static struct kunit_case amdgpu_dm_cursor_tests[] = {
 	/* amdgpu_dm_crtc_get_cursor_mode */
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_disabled_crtc),
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_new_hardware),
+	KUNIT_CASE(dm_test_crtc_get_cursor_mode_new_hardware_hole),
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_no_change),
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_disabled_cursor),
 	KUNIT_CASE(dm_test_crtc_get_cursor_mode_yuv_plane),
-- 
2.43.0

