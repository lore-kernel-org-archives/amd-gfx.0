Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D0DC44501
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58E0110F6DF;
	Thu,  9 Jul 2026 21:02:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nbTNW5wI";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012007.outbound.protection.outlook.com [52.101.43.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91EFE10F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvIh+r7RLcpRJaeWLH2b5W9UyjIE7RPhlKZQ/P9xkp4aonvv0L9EFFpOTNrvpAgtrpJHmj6bsgQiwhMI1Tk4Q3ZwAXvnLy+U8PsyVpP9wVzbNFuBnv9i81NIoHLz88KBQfa7smEftBE0SDk5xRk5wpq+lz+GYh7rIf9G7tyROUzwYZ1S+lh8Yp6B6KUKir6y8orRXe+pPOVrsCusDMAQQbUdWr16y/7cVEqaqeYBv1bcLuh3n/qG0K88E/DMdgkGpQLkHpGmImW5KqBy1Bf+VD7y/L5/D7HVB1uLgERVzINZD87dqc9mX349qkCnNe4QDt39cBr2ZpKIEv/4M+8uRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbxa+dALE9Qt71VZp5hbWwWAAuIRPg9QG5Jzuz6PSYk=;
 b=FaftSjc+skqSEObB9qOOZul13zceKXGyH33mayM41BerKQW7y6Ce0U20VREdS+k+4irNnq4BsLARk3g2TSXmBrhvn3MlyST/YSEQOklvbR6hqOulPHwMarO/S8/d3Xp2l+MkMFVbp2f22sYVLFNu9aOBuj77qrNj3efEbVFYLae3IhIkXcRyk01iMzOTTX6NPoFsO7J9zLYAEXQ2cjD8aOenWtA3IDsf2DcotzcgbgnlmXMBaSj1lM8bLrYWIN2yuic0ksFFTgD2pikC/DiyJRwzZULG5/9dm/SOPkctI5EYMPLGNaCy+jn7ZxZvQWyrn68Y2HUVRkwd/QiL6EmuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbxa+dALE9Qt71VZp5hbWwWAAuIRPg9QG5Jzuz6PSYk=;
 b=nbTNW5wI155LlGbHt9XrUufeEVYRN/HQY7kjMjkE4Zgfn/m8PcSt+sezUJPZrNZkKIbfILWHhE/R/lgShlyv5srZCwkqWeMsBs77MnedkiLYehWmAydD5m08xJpRuZ6vKSA1zp3QL4GrSfmWjNJIbEk0u5QhyAWTKc6c6Y6C+C0=
Received: from BL1P223CA0033.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::8)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 21:02:28 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::18) by BL1P223CA0033.outlook.office365.com
 (2603:10b6:208:5b6::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:28 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:08 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 43/80] drm/amd/display: Add FBC init tests for connector
Date: Thu, 9 Jul 2026 16:48:11 -0400
Message-ID: <20260709205936.5719-44-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 0454c62a-0cd3-4b3c-d6a6-08deddfd626c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JlUZPuG2QP7tUTUWmWSGBWr3tTUJuLFGJH9/6rtiH4REs7zok6vFsK8PfWO5NJQSA+5YdeBDSO5QKrYBFIkDDlwMO5nOARmoM5Cwrobmx9XNuw0sBVuGJM57c0YolAmYcNwS+CkvJ4GAOByxTM3dWNa0bbz96wCloMNDBVUkwb4GJLOJ9tNXhOB083I5Wx1P8PowJJcLwRrL18WqCtGrXfvlPHNAN0jlb1s95qTM3hjQi9mdM7zr1jXJHQx9D+Fm2Ip5vk0Xl3g/lvbZ3kv09pZGOBAepUVkTsAby31cFpBT83kRfomhyVvzfxVECaQKuV31SSLu6n5Nxi5Q3CgUnR+FnW0fxWiuWotquAnfjffdHYIp6n+x2vXOQCMUdmyIKTifGvNgKPs7T9uEuI45oXR4X3yng5PpTW6Pvj3y2DZQv58dtakfYb7xJ2+6VYxpqN/UNc98aFbEafxN5hzB4UG0vqb5htissvKspPF4FPFzYj9hMUnDDJUPhv6PARFxIdzHkmK/x1QLqI/6Vw23mq9n8NhE4PUSfyJEvm6v84hRLZD3kGiH3D9J7UTaLrzjY41QGtKAmkEcaFvEEXLmgszaa9yKQruUwfngcucjYEmt0pN2ZnF1BzYYqWQIbcN5FwKtxOmjJ2ZUtKb8Ih9uGvarWmb21eE7pc/ZFfMQJ4/g5S43euHZmi1eL+5uWW5U+iuLy+MuQiQGm6ZJBvisXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m1S5AgM4471Zj8lJ4hlJHMKVUHm/PA+ci5v7OFbpODwYsGrbEQv93KMCKRM9sXF1tWvy1Q5uy2wzrvIj8kZBZbemiKy6HwwT9EszCgRdVr65IujIeeHyR912MRFPdmkC4Yw7eApNm7LXGpK7r6G/vCoPHb8pmC89YqQs3SWkP+lmXpmWiOFmBsROsNucvSXXrk+QwUdwb8a2eqwLDUh5TrNtf5qChI1GfeR5/K+8NkzINHOo4+YmEQI5tUmm5RCOD+cIjyPYqcs3mQLdiFEjZHAffpU3CJS5Nlm3zOnWLOHVmlZtCZft7JmUv2k/FHHfUZlTCHUBlsgO8P4GjSpktjlbHOZsjMHmyBzTRcqzf5gjwhJRqAW0S4Bsm4Qltp4e5G9UVLy59yQg4uDBbvc3UCX/QzZQajpFHdgwvbhmGwEidyOB9dQDxn+XWb5nf9V7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:28.0500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0454c62a-0cd3-4b3c-d6a6-08deddfd626c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Add KUnit coverage for amdgpu_dm_fbc_init() on the
amdgpu_dm_connector tests:

- No FBC present
- Non-eDP link
- Buffer already allocated

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   1 +
 .../tests/amdgpu_dm_connector_test.c          | 112 ++++++++++++++++++
 3 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 4ae58d5c5264..e018cf639909 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -255,7 +255,7 @@ EXPORT_IF_KUNIT(update_subconnector_property);
 
 static int amdgpu_dm_connector_get_modes(struct drm_connector *connector);
 
-static void amdgpu_dm_fbc_init(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_fbc_init(struct drm_connector *connector)
 {
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct dm_compressor_info *compressor = &adev->dm.compressor;
@@ -293,6 +293,7 @@ static void amdgpu_dm_fbc_init(struct drm_connector *connector)
 	}
 
 }
+EXPORT_IF_KUNIT(amdgpu_dm_fbc_init);
 
 
 int amdgpu_dm_detect_mst_link_for_all_connectors(struct drm_device *dev)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index 10fe0bf48c02..707308c02820 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -148,6 +148,7 @@ int amdgpu_dm_encoder_init(struct drm_device *dev,
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 enum drm_mode_subconnector get_subconnector_type(struct dc_link *link);
 void update_subconnector_property(struct amdgpu_dm_connector *aconnector);
+void amdgpu_dm_fbc_init(struct drm_connector *connector);
 enum display_content_type
 get_output_content_type(const struct drm_connector_state *connector_state);
 bool adjust_colour_depth_from_display_info(struct dc_crtc_timing *timing_out,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 782a22e4f074..aa274f5e4b84 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -2665,6 +2665,113 @@ static void dm_test_update_subconnector_non_dp_noop(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)val, (int)DRM_MODE_SUBCONNECTOR_VGA);
 }
 
+/* Tests for amdgpu_dm_fbc_init() */
+
+/*
+ * Build an amdgpu_dm_connector wired to a kunit-allocated amdgpu_device so
+ * that drm_to_adev() and to_amdgpu_dm_connector() resolve correctly, with a
+ * dc, dc_link and an empty modes list ready for amdgpu_dm_fbc_init().
+ */
+struct dm_test_fbc_ctx {
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_connector *aconnector;
+	struct dc *dc;
+	struct dc_link *link;
+};
+
+static struct dm_test_fbc_ctx *dm_test_fbc_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_fbc_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->adev = kunit_kzalloc(test, sizeof(*ctx->adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->adev);
+	ctx->aconnector = kunit_kzalloc(test, sizeof(*ctx->aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aconnector);
+	ctx->dc = kunit_kzalloc(test, sizeof(*ctx->dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc);
+	ctx->link = kunit_kzalloc(test, sizeof(*ctx->link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->link);
+
+	ctx->aconnector->base.dev = &ctx->adev->ddev;
+	INIT_LIST_HEAD(&ctx->aconnector->base.modes);
+	ctx->adev->dm.dc = ctx->dc;
+	ctx->aconnector->dc_link = ctx->link;
+
+	/* Default to the fully-enabled path so each test only flips one knob */
+	ctx->link->connector_signal = SIGNAL_TYPE_EDP;
+	ctx->dc->fbc_compressor =
+		(struct compressor *)kunit_kzalloc(test, sizeof(void *), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc->fbc_compressor);
+
+	return ctx;
+}
+
+/**
+ * dm_test_fbc_init_no_compressor - Test fbc_init is a no-op without a compressor
+ * @test: The KUnit test context
+ */
+static void dm_test_fbc_init_no_compressor(struct kunit *test)
+{
+	struct dm_test_fbc_ctx *ctx = dm_test_fbc_ctx_alloc(test);
+
+	ctx->dc->fbc_compressor = NULL;
+
+	amdgpu_dm_fbc_init(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_NULL(test, ctx->adev->dm.compressor.bo_ptr);
+}
+
+/**
+ * dm_test_fbc_init_non_edp - Test fbc_init is a no-op for non-eDP links
+ * @test: The KUnit test context
+ */
+static void dm_test_fbc_init_non_edp(struct kunit *test)
+{
+	struct dm_test_fbc_ctx *ctx = dm_test_fbc_ctx_alloc(test);
+
+	ctx->link->connector_signal = SIGNAL_TYPE_DISPLAY_PORT;
+
+	amdgpu_dm_fbc_init(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_NULL(test, ctx->adev->dm.compressor.bo_ptr);
+}
+
+/**
+ * dm_test_fbc_init_already_allocated - Test fbc_init keeps an existing buffer
+ * @test: The KUnit test context
+ */
+static void dm_test_fbc_init_already_allocated(struct kunit *test)
+{
+	struct dm_test_fbc_ctx *ctx = dm_test_fbc_ctx_alloc(test);
+	struct amdgpu_bo *existing;
+
+	existing = kunit_kzalloc(test, sizeof(void *), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, existing);
+	ctx->adev->dm.compressor.bo_ptr = existing;
+
+	amdgpu_dm_fbc_init(&ctx->aconnector->base);
+
+	/* Buffer already present → left untouched, no reallocation */
+	KUNIT_EXPECT_PTR_EQ(test, ctx->adev->dm.compressor.bo_ptr, existing);
+}
+
+/**
+ * dm_test_fbc_init_no_modes - Test fbc_init skips allocation with no modes
+ * @test: The KUnit test context
+ */
+static void dm_test_fbc_init_no_modes(struct kunit *test)
+{
+	struct dm_test_fbc_ctx *ctx = dm_test_fbc_ctx_alloc(test);
+
+	/* All prerequisites met but the modes list is empty → max_size 0 */
+	amdgpu_dm_fbc_init(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_NULL(test, ctx->adev->dm.compressor.bo_ptr);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -2822,6 +2929,11 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	KUNIT_CASE(dm_test_set_panel_type_did_lcd),
 	KUNIT_CASE(dm_test_set_panel_type_vendor_lum_heuristic),
 	KUNIT_CASE(dm_test_set_panel_type_defaults_to_lcd),
+	/* amdgpu_dm_fbc_init */
+	KUNIT_CASE(dm_test_fbc_init_no_compressor),
+	KUNIT_CASE(dm_test_fbc_init_non_edp),
+	KUNIT_CASE(dm_test_fbc_init_already_allocated),
+	KUNIT_CASE(dm_test_fbc_init_no_modes),
 	{}
 };
 
-- 
2.55.0

