Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A881C982D0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108D210ECBE;
	Wed, 16 Sep 2026 17:53:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A/VbNJti";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012022.outbound.protection.outlook.com
 [40.93.195.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D69F10E80C
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNiMYltN6l10DUUg9ddrNT1IuyEyAdTXDsfh5ahGXAEcqj+rZN2q0es/xagXGLf6rCiwSgBWTVrWyPysswgpvKMzVlGFwusnugsgMGrdmcq1YVWH4v6kbdWb31PQCYRtHTyKCmrwkiTnEzuhKCK607jmMLVyiWX4Z8tMIRFenq5eLTjJEYlB2ZL57x7eRllnRP+AOwLjie3yY0lnaed5h8HBPYI2HuihTghRNj2blW3dxgista0DJmcCiUvDQkwRrWVDBDPdLWs7c4mT4dCP6ygIa0mHy6zp4+/abjh7IlHEdbDfhswAQDq7QUnRUp1oHML4upK7ld2F6+1V27oKBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWClDwuRpn6WwpNYBAvkOm79V6WizzRvYKErMuqqcD8=;
 b=CRfJIHmb/yhnf/I0GxBQhQyfYAEETutHXrhBFm/ZmqIqODMg/3uCt/mpVxJHbPSHXzBq/+atVuKFM5zx7ZZoIkQFTkVEXUeqgjRKTD8onV+SSw2bf/4GFYj3XpTuHiMjL54JtVtpNuRVwjcNR6EZ4MjEjwkXTo4ZMhWNLNYZt9+AVoQKRmjj0wlpsyxYZznC60q1/s2ZPHHRWkNRElidA25mkZGjr/5aup3fVd7Nam+jp5KDCRuSg+Fk+lO1/ZE+57VAUodyxN55luUYSepxHUs4aDCH4Lh7G8a0aMg20MrLdwDriqFt+Lt37WYTeT245BhIF2lkK2Y0qb0hbsXe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWClDwuRpn6WwpNYBAvkOm79V6WizzRvYKErMuqqcD8=;
 b=A/VbNJti3uSyHWPGEBJBWl6aSJPleRUiCBcVbuyrk7TIxUoE73VbtYbVQbJxZmQDGtgLcVolNA9RtQZRuXWxNTMA0QTDCYqzlgHJR2pJINTDq9IPDzctw4Xu6qVEEd+vs3BcKNJM8fO5gAgZ6B5DPFhSRGm+yJA7xeTG1pP+oV4=
Received: from CH0PR03CA0241.namprd03.prod.outlook.com (2603:10b6:610:e5::6)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Wed, 16 Sep 2026 17:52:39 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::17) by CH0PR03CA0241.outlook.office365.com
 (2603:10b6:610:e5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:39 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:29 -0500
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
Subject: [PATCH 20/64] drm/amd/display: Fold plane scaling and cursor tests
Date: Wed, 16 Sep 2026 13:51:35 -0400
Message-ID: <20260916175301.368306-21-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: b0d3b72c-8678-460d-6656-08df141b4cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wGKjnU9IU/Ctchp0iiFRTPTGdfJkLBNfpYB5mzUcpUf4pE3tX2pXMdCZt3ehsUw3Njd674Cp888Iw1NuEQZeVgimfdL/0axjJ6c+K3myIjdNDHNijFTaFYu+7Le0HOcb9pUfk/xDtdPtIY1yH6v2UONYtuFXi9XX+CYRUsnmIDEv2jPCB28W6xt/D8yBQ5qFMO/P1B46jX5obQuQRc7DKatzfwAP/OCCmCLkZS/6pap9zwSyIWuQw3HNcuxUfLtaWBLMLhqHeaCFhbqxlRqm6Vz8M74DdkLlEP8nI1+nCUkSyxhL89x7fad27V0pEU5ZvB4FIpTWmH4oUIcQvi1/D/JQUXCt/zmWim0a2LWPffbiZ+SRjUAxN7ZbfzSl9jBEftugABipb0h5euoZ0ptZm33rfafv/N+Oonxm2RwRPqMlsGkYFZaN2vaO7T15i+/KSxwhNs2rVX6Fxr9xRK7bq94odzzOZ0nxW5fbHbST+loZLcBdtzoOtDhnmFQWMEj/sA3eszw3gfoMqhlAuALrnuzbXGKtv/vtMMJ/gde8v4+uhuBSEuEPhYuKu1TmeXDObupuRAL/A3DMmBEdpBSmr0ltE928rj3CEKa+sR0sOmW2RiqkVgE7DNzmcWLv2DmtBgECRHGqCl1/7DycDyAsIeAALd3gtxM0VAXiUKnzrRvufV4PX5sPuz2eaI4uDdWijEzJfVA9L10nNePTHVQghA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eSx/Pp+RcanGPxIBuzkUvvuoXh7ztNwJ5xPBO8BhEvlXmuJJYfIFoTpebiLk+DTR16VqK2l9jUDeePGEgOXZEQX5Scoau1+1eCKj4DBVjjqhtowXC7dRwr20ujtqtzGFXW4Yyd7y1P2oABYHgQWHQQTY5v8JDaZiDVnJU/c14YjmCVs2TTOBxQgKpK4KGqWpItEVigSL6fx6QJwLP6ezFTOUB73TBj3wfAN2LRMOURSKm5Vcunt0q77NSylklbs0Q1OV9eW8OicCwewJ/H5jU/HLMYfmmhgjWCYScSqaOyKe5TiLvSoVHBkUIx7vxWA+o0U23VO7cL8Zao/kjhC5Od5IilmRZd5gl99/wRktQcuTuRR6ba3xasJhUWbsAFBoexH3GTZQUXq5jqg2bJEyikhM9g1nJdaB06ATRoim/g6f/aha+CjEmKHsPXg7jz1j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:39.6781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0d3b72c-8678-460d-6656-08df141b4cef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
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
Reduce the two KUnit tests for
amdgpu_dm_plane_get_min_max_dc_plane_scaling() to one, and the two for
amdgpu_dm_plane_get_cursor_position() to one.

[HOW]
Populate the fp16 scaling caps alongside the NV12 and ARGB8888 ones and
query all three formats from one device, and append the oversized cursor
rejection to the existing clipping test.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 93 ++++---------------
 1 file changed, 17 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 0d0a3199b464..c3aaa2b05e95 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -352,7 +352,8 @@ static void dm_test_fill_dc_scaling_info(struct kunit *test)
  * dm_test_get_min_max_dc_plane_scaling() - Verify format-specific cap selection and 1->1000 conversion.
  * @test: KUnit test context.
  *
- * Verify if min/max scaling values are correct for NV12 and XRGB8888 formats.
+ * Verify if min/max scaling values are correct for the NV12, XRGB8888 and fp16
+ * caps.
  */
 static void dm_test_get_min_max_dc_plane_scaling(struct kunit *test)
 {
@@ -374,6 +375,8 @@ static void dm_test_get_min_max_dc_plane_scaling(struct kunit *test)
 	dc->caps.planes[0].max_downscale_factor.nv12 = 1;
 	dc->caps.planes[0].max_upscale_factor.argb8888 = 1600;
 	dc->caps.planes[0].max_downscale_factor.argb8888 = 250;
+	dc->caps.planes[0].max_upscale_factor.fp16 = 2000;
+	dc->caps.planes[0].max_downscale_factor.fp16 = 500;
 
 	fb->format = drm_format_info(DRM_FORMAT_NV12);
 	KUNIT_ASSERT_NOT_NULL(test, fb->format);
@@ -386,13 +389,20 @@ static void dm_test_get_min_max_dc_plane_scaling(struct kunit *test)
 	amdgpu_dm_plane_get_min_max_dc_plane_scaling(&adev->ddev, fb, &min_downscale, &max_upscale);
 	KUNIT_EXPECT_EQ(test, min_downscale, 250);
 	KUNIT_EXPECT_EQ(test, max_upscale, 1600);
+
+	fb->format = drm_format_info(DRM_FORMAT_ARGB16161616F);
+	KUNIT_ASSERT_NOT_NULL(test, fb->format);
+	amdgpu_dm_plane_get_min_max_dc_plane_scaling(&adev->ddev, fb, &min_downscale, &max_upscale);
+	KUNIT_EXPECT_EQ(test, min_downscale, 500);
+	KUNIT_EXPECT_EQ(test, max_upscale, 2000);
 }
 
 /**
  * dm_test_get_cursor_position() - Verify cursor clipping and off-screen handling.
  * @test: KUnit test context.
  *
- * Verify if cursor clipping, hotspot adjustment, and off-screen disable behavior work.
+ * Verify if cursor clipping, hotspot adjustment, off-screen disable behavior
+ * and the oversized-cursor rejection work.
  */
 static void dm_test_get_cursor_position(struct kunit *test)
 {
@@ -443,6 +453,11 @@ static void dm_test_get_cursor_position(struct kunit *test)
 			amdgpu_dm_plane_get_cursor_position(plane, &amdgpu_crtc->base, &position),
 			0);
 	KUNIT_EXPECT_FALSE(test, position.enable);
+
+	state->crtc_w = 128;
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_get_cursor_position(plane, &amdgpu_crtc->base, &position),
+			-EINVAL);
 }
 
 /**
@@ -1718,39 +1733,6 @@ static void dm_test_fill_plane_buffer_attributes_gfx12(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxAddr3);
 }
 
-/**
- * dm_test_get_min_max_dc_plane_scaling_fp16() - Verify fp16 cap selection.
- * @test: KUnit test context.
- *
- * Verify if 64bpp fp16 formats use the fp16 scaling caps.
- */
-static void dm_test_get_min_max_dc_plane_scaling_fp16(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct dc *dc;
-	struct drm_framebuffer *fb;
-	int min_downscale = 0;
-	int max_upscale = 0;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, dc);
-	KUNIT_ASSERT_NOT_NULL(test, fb);
-
-	adev->dm.dc = dc;
-	dc->caps.planes[0].max_upscale_factor.fp16 = 2000;
-	dc->caps.planes[0].max_downscale_factor.fp16 = 500;
-
-	fb->format = drm_format_info(DRM_FORMAT_ARGB16161616F);
-	KUNIT_ASSERT_NOT_NULL(test, fb->format);
-	amdgpu_dm_plane_get_min_max_dc_plane_scaling(&adev->ddev, fb,
-						     &min_downscale, &max_upscale);
-	KUNIT_EXPECT_EQ(test, min_downscale, 500);
-	KUNIT_EXPECT_EQ(test, max_upscale, 2000);
-}
-
 /**
  * dm_test_helper_check_state_small_viewport_width() - Verify width rejection.
  * @test: KUnit test context.
@@ -2024,45 +2006,6 @@ static void dm_test_fill_dc_scaling_info_plane_caps(struct kunit *test)
 			0);
 }
 
-/**
- * dm_test_get_cursor_position_bad_size() - Verify oversized cursor rejection.
- * @test: KUnit test context.
- *
- * Verify if a cursor larger than the CRTC maximum is rejected.
- */
-static void dm_test_get_cursor_position_bad_size(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct amdgpu_crtc *amdgpu_crtc;
-	struct drm_plane *plane;
-	struct drm_plane_state *state;
-	struct drm_framebuffer *fb;
-	struct dc_cursor_position position = {0};
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	amdgpu_crtc = kunit_kzalloc(test, sizeof(*amdgpu_crtc), GFP_KERNEL);
-	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
-	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, amdgpu_crtc);
-	KUNIT_ASSERT_NOT_NULL(test, plane);
-	KUNIT_ASSERT_NOT_NULL(test, state);
-	KUNIT_ASSERT_NOT_NULL(test, fb);
-
-	amdgpu_crtc->max_cursor_width = 64;
-	amdgpu_crtc->max_cursor_height = 64;
-	plane->dev = &adev->ddev;
-	plane->state = state;
-	state->fb = fb;
-	state->crtc_w = 128;
-	state->crtc_h = 32;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_get_cursor_position(plane, &amdgpu_crtc->base, &position),
-			-EINVAL);
-}
-
 /**
  * dm_test_format_mod_supported_d_swizzle_reject() - Verify D swizzle rejection.
  * @test: KUnit test context.
@@ -3463,14 +3406,12 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_fill_dc_scaling_info_plane_caps),
 	/* amdgpu_dm_plane_get_min_max_dc_plane_scaling() */
 	KUNIT_CASE(dm_test_get_min_max_dc_plane_scaling),
-	KUNIT_CASE(dm_test_get_min_max_dc_plane_scaling_fp16),
 	/* amdgpu_dm_plane_fill_plane_buffer_attributes() */
 	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_video),
 	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_gfx12),
 	KUNIT_CASE(dm_test_fill_plane_buffer_attributes_gfx6),
 	/* amdgpu_dm_plane_get_cursor_position() */
 	KUNIT_CASE(dm_test_get_cursor_position),
-	KUNIT_CASE(dm_test_get_cursor_position_bad_size),
 	/* amdgpu_dm_plane_format_mod_supported() */
 	KUNIT_CASE(dm_test_format_mod_supported),
 	KUNIT_CASE(dm_test_format_mod_supported_d_swizzle_reject),
-- 
2.55.0

