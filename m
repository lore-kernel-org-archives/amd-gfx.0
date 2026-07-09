Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4721AC44509
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB0A10F6F0;
	Thu,  9 Jul 2026 21:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5U3gDTVd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5471610F6EA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6cZN5sd8/BUp/tkFTY50AQKbZLsp6UseOTRj1xXbgeiV+S5xTcLtrFyUJ3rcJ+aapII6ELE+S8vK5Y/n2XsHyd2SbwZwLU1FCxELr9MWF23SI1+JvYZXRMU1TnKdlS/gUGPqB9+rdJVmdexAKB860L5cRHbCBkQzsQxbRdZJT0Bntgm+h+hifhty05Ou/Fxf/iuX+u5CwKJoHCCMCNiSy1uscbWbbfTM1c12xczGufe3pgiw/I2W0ikAu1Bmf+KtzjDIyhUHoGXpLCc4l/F3r6aFMJmyV8yja08C51vNlKIy5y2VAS6GCco48X359dy7ld5OaRUfUaUlOYJRMTY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BQH54rTH2d+UGzhjYxtOEfR2I2ss/6FEsAWW1cP/zU=;
 b=rqmtGwzzgxZ/rzQvN2kgbyafcIqthUs18wvIs3Lw417GsmO2xem2BtuaXe6Q6GAKnw56YyzMrIHGAH1WDKqcXr/hMFBaTlkaNLbkZWgUEwQojlgdVc2Gk3/D/ExNlHiyidJVi1h7jUu41etmLQ0CniVFal9MI2RSLjNHgd0DRa4PWA7E9lLpMNVDshDm6nWSiQLowu15lWupoVIS2iKOvN+ax+ziFK2ecn/RQERSTfcVSzuJm3yUYEfNUrTC/KI83KnyusTJ+GN6zHhUsUZ+RuOEwfty8HuUmsqVSuwKf2tWTtVbo5h2AWUDa4rDW4P4XKnsm3/xOjejurO6sOif9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BQH54rTH2d+UGzhjYxtOEfR2I2ss/6FEsAWW1cP/zU=;
 b=5U3gDTVdvgyOjul8Y2LdWIFqXLPISjLFGppPYTScBN2Q6Yce76dXESHTFekUAtTHNJE0u2SYcBivvTJlEAtzVBtnocGbpS3aYCdRMRIC9Q9M2ilqh5F+VN2AKRiYDZkbxuNjLCwlB4RgPejvNU7HIuERKn4zwAbEOb0hQQMRYUs=
Received: from MN0PR04CA0017.namprd04.prod.outlook.com (2603:10b6:208:52d::10)
 by PH7PR12MB6441.namprd12.prod.outlook.com (2603:10b6:510:1fb::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:29 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::13) by MN0PR04CA0017.outlook.office365.com
 (2603:10b6:208:52d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:28 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:09 -0500
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
Subject: [PATCH 44/80] drm/amd/display: Test format info and blending
Date: Thu, 9 Jul 2026 16:48:12 -0400
Message-ID: <20260709205936.5719-45-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|PH7PR12MB6441:EE_
X-MS-Office365-Filtering-Correlation-Id: 594ff702-f50f-4168-8a00-08deddfd62f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jvXcfP4jaxfP/JT/iItvM3GMfNPJPbB1bCfEulCCA1PSIqqmOZJW0DC6MRV86BjEsjY/N1IjxTPkqbSd0tmMT6nLWhXLLkdgj+GswBud8wzRbskhMvpcKu/y0ENM94EjOOHXtFkk5GESKL6q9mh3yOUqZvH5POaONtSP91QHA7hIU8teGx5fQVQ2uqfFGbFRIu7uYjMjuYsYD3QwKdlFXR7R/fVB9UyeZiTc95mcMpxVEci+de9p+p4ITOtaG8AVs1bMhnk3f6ULZ+mPOgk7/fohnXLZc/0z4Aaf/hP0vAoEq4t/+s1qgmGsDe2RX5zNKtRwxqR9DzySY7TRGCpsLdvL3TSarl1fLb8FcDfiXGao03fCiOzbAEWyhYft6LzMafByBhjDTT9WGqiNUJb4M8p0kLsAS+URo+2OjlsKcf2Cw+sr5IJc9e2LZiX5mwOJx9vbjts4knvoJwL5iZSS18nfFDHd89eJB1QJeA2Dx0NA5sfQ0dyYd656OEO1d3SiVbUmWYDAs7qAIjzfswKWS6T3ZkkIMpVzeL1f/ZfMlJy6BvKRH3pTvPo0YUfaHlekaR5CpN4Gfr9I0WiW7McEhKaNZ7DCd5HGdAJ/fmBaNJWvbzsSOBvPKNrgkIrnykGHi51wfOQ1m2nH43uv6zO+YVLSs/wLO9ZaRTFc5WInOoGR3iu2zdMM6tPENAW7PaAru6pQ7zw1grS2MVv/xKR4BQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2CIZcWTVypRrLnwcJzQOukQ5rJx2SIB7pwpK1GEyhThe8R+XIHeIE9pVEpy2/y/ai59+BeczNfhauqeeQilupvnnw/hnTE+cnI7tlbQVMgZrnO1UwiOfYgmAE5gv4YCRvnwAvWKGDrT4EylsANq2NiylU4/PUXQQNaUfnV++iEHXHME+dX6em17jGy94WdihEt7CZ8VFIGg6sAuwOn4KtZpc67TrZsd+0iuwOpJOFZciGBr6+YpKXgwzDOMYCouY3Sq2RKM9USFc/lyEJyxI73jcHPdIzDHd8vU04yLEDkW8JfFQQ8aA0nbsLksC44VRWeU+c3oNqjWXLHYM993W7515fJOWIkhq2VWTSxOQrSe0aT7Me7JNWPvN/0rGoxm9tjFDQvNTAeBYe/Wt9rsP+VQ8NJ42PIdmJhDV1HoQQWSGCrZGHRuqew3ylLZ74Lrc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:28.9405 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 594ff702-f50f-4168-8a00-08deddfd62f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6441
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
Add KUnit coverage for amdgpu_dm_plane_get_format_info(), the overlay
universal-plane path of get_plane_formats(), the D-swizzle rejection
path of format_mod_supported(), and the DCN4.2 variant of
fill_blending_from_plane_state().

These exercise format-query and blending code paths that the existing
suite did not cover.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 141 +++++++++++++++++-
 1 file changed, 134 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 46c9af432e37..512c51e60559 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -5,13 +5,16 @@
  * Copyright 2026 Advanced Micro Devices, Inc.
  */
 
- #include <kunit/test.h>
- #include <drm/drm_blend.h>
- #include "link_enc_cfg.h"
- #include "amdgpu_dm_plane.h"
- #include <drm/amdgpu_drm.h>
- #include <drm/drm_plane.h>
-
+#include <kunit/test.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_blend.h>
+#include "link_enc_cfg.h"
+#include "amdgpu_dm_plane.h"
+#include "amdgpu_rlc.h"
+#include "gc/gc_11_0_0_offset.h"
+#include "gc/gc_11_0_0_sh_mask.h"
+#include <drm/amdgpu_drm.h>
+#include <drm/drm_plane.h>
 
 struct dm_test_dcc_cap_ctx {
 	bool callback_ret;
@@ -1162,19 +1165,142 @@ static void dm_test_fill_gfx9_tiling_info_from_modifier_nv(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, tiling_info.gfx9.shaderEnable, 1U);
 }
 
+/**
+ * dm_test_get_format_info() - Verify modifier-based format info lookup.
+ * @test: KUnit test context.
+ *
+ * Verify if non-AMD modifiers return NULL and AMD DCC modifiers resolve a
+ * dedicated format info structure.
+ */
+static void dm_test_get_format_info(struct kunit *test)
+{
+	u64 dcc_mod = AMD_FMT_MOD |
+		      AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9) |
+		      AMD_FMT_MOD_SET(DCC, 1);
+	const struct drm_format_info *format_info;
+
+	KUNIT_EXPECT_PTR_EQ(test,
+			    (void *)amdgpu_dm_plane_get_format_info(DRM_FORMAT_XRGB8888,
+								    DRM_FORMAT_MOD_LINEAR),
+			    NULL);
+	format_info = amdgpu_dm_plane_get_format_info(DRM_FORMAT_XRGB8888, dcc_mod);
+	KUNIT_EXPECT_NOT_NULL(test, format_info);
+}
+
+/**
+ * dm_test_fill_blending_global_alpha_dcn42() - Verify DCN 4.2 alpha scaling.
+ * @test: KUnit test context.
+ *
+ * Verify if DCN 4.2 scales the 16-bit DRM alpha down by 4 bits instead of 8.
+ */
+static void dm_test_fill_blending_global_alpha_dcn42(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_plane *plane;
+	struct drm_plane_state *state;
+	bool per_pixel_alpha;
+	bool pre_multiplied_alpha;
+	bool global_alpha;
+	int global_alpha_value;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
+	plane->dev = &adev->ddev;
+	state->plane = plane;
+	state->pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
+	state->alpha = 0x8000;
+
+	amdgpu_dm_plane_fill_blending_from_plane_state(state,
+						       &per_pixel_alpha,
+						       &pre_multiplied_alpha,
+						       &global_alpha,
+						       &global_alpha_value);
+
+	KUNIT_EXPECT_TRUE(test, global_alpha);
+	KUNIT_EXPECT_EQ(test, global_alpha_value, 0x800);
+}
+
+/**
+ * dm_test_get_plane_formats_overlay_universal_cap() - Verify universal overlay.
+ * @test: KUnit test context.
+ *
+ * Verify if an overlay plane with a DCN universal plane cap reports the RGB
+ * format list instead of the overlay-only list.
+ */
+static void dm_test_get_plane_formats_overlay_universal_cap(struct kunit *test)
+{
+	struct drm_plane *plane;
+	struct dc_plane_cap *cap;
+	u32 formats[32] = {0};
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	cap = kunit_kzalloc(test, sizeof(*cap), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, cap);
+
+	plane->type = DRM_PLANE_TYPE_OVERLAY;
+	cap->type = DC_PLANE_TYPE_DCN_UNIVERSAL;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_get_plane_formats(plane, cap, formats, 32),
+			14);
+}
+
+/**
+ * dm_test_format_mod_supported_d_swizzle_reject() - Verify D swizzle rejection.
+ * @test: KUnit test context.
+ *
+ * Verify if a D micro-swizzle modifier is rejected for formats narrower than
+ * 8 bytes per pixel.
+ */
+static void dm_test_format_mod_supported_d_swizzle_reject(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_plane *plane;
+	u64 listed_mod;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+
+	adev->family = AMDGPU_FAMILY_RV;
+	plane->dev = &adev->ddev;
+
+	listed_mod = AMD_FMT_MOD |
+		     AMD_FMT_MOD_SET(TILE, AMD_FMT_MOD_TILE_GFX9_64K_D) |
+		     AMD_FMT_MOD_SET(TILE_VERSION, AMD_FMT_MOD_TILE_VER_GFX9);
+	plane->modifiers = &listed_mod;
+	plane->modifier_count = 1;
+
+	KUNIT_EXPECT_FALSE(test,
+			   amdgpu_dm_plane_format_mod_supported(plane, DRM_FORMAT_XRGB8888,
+								listed_mod));
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
+	/* amdgpu_dm_plane_get_format_info() */
+	KUNIT_CASE(dm_test_get_format_info),
 	/* amdgpu_dm_plane_fill_blending_from_plane_state() */
 	KUNIT_CASE(dm_test_fill_blending_defaults),
 	KUNIT_CASE(dm_test_fill_blending_premulti_alpha_format),
 	KUNIT_CASE(dm_test_fill_blending_coverage_alpha_format),
 	KUNIT_CASE(dm_test_fill_blending_global_alpha),
+	KUNIT_CASE(dm_test_fill_blending_global_alpha_dcn42),
 	/* amdgpu_dm_plane_modifier_* helpers() */
 	KUNIT_CASE(dm_test_modifier_has_dcc),
 	KUNIT_CASE(dm_test_modifier_gfx9_swizzle_mode),
 	/* amdgpu_dm_plane_get_plane_formats() */
 	KUNIT_CASE(dm_test_get_plane_formats),
+	KUNIT_CASE(dm_test_get_plane_formats_overlay_universal_cap),
 	/* amdgpu_dm_plane_get_plane_modifiers() */
 	KUNIT_CASE(dm_test_get_plane_modifiers),
 	/* amdgpu_dm_plane_fill_dc_scaling_info() */
@@ -1187,6 +1313,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_get_cursor_position),
 	/* amdgpu_dm_plane_format_mod_supported() */
 	KUNIT_CASE(dm_test_format_mod_supported),
+	KUNIT_CASE(dm_test_format_mod_supported_d_swizzle_reject),
 	/* amdgpu_dm_plane_fill_gfx12_plane_attributes_from_modifiers() */
 	KUNIT_CASE(dm_test_fill_gfx12_plane_attributes_from_modifiers),
 	/* amdgpu_dm_plane_fill_gfx9_plane_attributes_from_modifiers() */
-- 
2.55.0

