Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413AAC88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB1010E970;
	Wed, 16 Sep 2026 17:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5b1vY3Wp";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAF3810E973
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbkRZ3l3vfPnipSQ5CmbmZ4UAPPIcohMZT02WN6MoegqXW1xf+SGQOSgwSM4MF/rNEnwqSpWcqBxRVfKQbYL2Xuk31i1M73cYWT5w41ziheUwMaC8Y1wDqSH8QUza01zuXTcZVCM0rOJzFad4iwGHluMg/i7dZb2f0wUoheCvcDwLMaXDl+TGkqBmFQMNAdmuFqMnrEBmrjl9hQlLKMeCU8Y4pgL7p2q+QhTWtNJTEkYmYuGQ+OP2CTDevDz44kO1g4w+350OufhxSPQuWI+u2Y3rpWzaePPkyEpK3xo5aN/r2UeLsVO0SeGtL0SU/hoUUcdKtGVw/JSbhFqc9YDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmLWM+pruBYG/ePjdKJyPVhz3fB1Z0nCV/p9MxNIGN8=;
 b=gJH2zO+7P6ve2D2yeRZ71vWTU9lae1Iy3c+IsUYTdMhIRKSYNJ4N9IFb2RCXx2S15WdDUSTldnYOBXc3Y4RLGrW5U6fcYajd3Kfdb9v0hTcLc65q40+ZT1bMAXlY5e1kqRfu7W/QowroF8McMVN2CjcEqoUIEKcq/lSSQWOXgA8MlyxPvVMDjEw7+ht/Q1+FwXVQoQf+9t/Vi5zX1nOCJvJ6jWcDJzycGRCEszx9VKP1bKGJGK9w4fLB2z1Is2MqP7FWqNQ8LfehUzEvwLvzoFgQshggWTbangOXqxTLCftNpAL/5bCOUJ7KUXW/sAKP4hL5YMHWA9/1RxRBV/SbDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmLWM+pruBYG/ePjdKJyPVhz3fB1Z0nCV/p9MxNIGN8=;
 b=5b1vY3WpXEsvdmHgcFMDpkZFlsP7j2sSFVEyP75cGrDuRnREmZfOmjSFWk67YxelPLVE4xSlctZHjKwizcNjkC9NUzvLxk3uLx9BrxiAkR3yVwqGxCXhs4GA8Cmargi9grBFstQ+0OFz0dh2ghvSOT5N5SZflKSJSXxD2asMkSo=
Received: from CH0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:610:e5::20)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:35 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::67) by CH0PR03CA0255.outlook.office365.com
 (2603:10b6:610:e5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:34 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:22 -0500
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
Subject: [PATCH 12/64] drm/amd/display: Fold blending tests into two cases
Date: Wed, 16 Sep 2026 13:51:27 -0400
Message-ID: <20260916175301.368306-13-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 077b738f-a55e-40da-3941-08df141b49ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|3023799007|18002099003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: CsXc1G6VXAu9525q0PVSwU+xQhfeaU3sYH3lW2dRjxogoLyxF4BdDmxNN9q1Nk/tWcll5w03LA3UCiudR6m0vfrzclBqo/Nc77Z8rpWjpm0yWtA747zl6VhiEhn7jE/QpiGF0ZEHQ/bRntqRzn2wkBACbthsm14FGAh86Btp9fq0N3utDVwFn35UN+kybZFHsyNMgIitTsZPnk16Q6XTNbA6H8PouW4hUoHv0P+z3Z1O9dNUmeMLDej8dGQr6QD9SzhDGpnHw4ZwNdZwIfPwYG32q/eDs2KgG57tF6ISPvpafKdwIP9xRNcX4SmBXWDncZizcSAOfEKtChsssv5mUuJZBRTzIUaedWC2YxdpXMmfKMihVaCwOmVASjUS7STuuRFYWaxE2OAwmso3DgUqR5ETLNN/BUqWzxRhz23xMwyjsaljS5oYlYJHgd1h8aj2xtZuFWUx7J2QKnUTVa1OQ3fKkewMdkzUnfP157lmCOf5HLaBQ/lbd38ItPvDvSi13T6esiCYnUOyfxRCxXXInu9ThmzTkysLvd3dXq+Hhz3dOKeJJwEGk5dw9V99rHldgrWf/5WXwZiHTpQ4HpD8Eg2uBzQKO8HD9nXOEfxLd3tI6Wla0Uk4P3J3JbZl11uyks6AW6ZlvNvywtN8PGz/fx3+q1KQ2BS3qFVqs6wqXrsimltTmflPBcDHFOA3LOpaa9msc5wQewEsDkwH9p5tSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(3023799007)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: o4tNVAnlNI+epECADqI9xKcPAffQlZ37ZYC3SQitK1SQ4LwaizqEo1sWUEdRrkFEoh46jFvp2fnoz+36R507L7ga3DQSEANKsCkJuMABHITE0mizdyiN5r/QLdqlIoMMKLl4IRaQbr3OWtktkg3u+mm6j/VMUEOjmIJG+ijqYnu7WBVzMgv0iBH3b88FALxj/jhiYUi437Ub+VzeN4hW2Vv5WZASAP5sRYzD90BpQmzu5Wo7PlOGTNVOk6wO0ENanwRSVSxINGrFwQ+HtAY2t9ULOAYRR0RyRiq19KVZHamUhixyDql83L8BUsAACZv6JwaqWFNxl+QJ6G9mjvtgNwhvrXXnrvYpYznhiIl6wQpIYwgGdUFGNxhIfBqh5ASgF8sDTml+7RHxqu7+P7YWJVCVGt+RaXW1bm9vrZ9QkBAqsgulz9NFM749Zinc1NZE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:34.7720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 077b738f-a55e-40da-3941-08df141b49ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
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
Reduce the five KUnit tests for
amdgpu_dm_plane_fill_blending_from_plane_state() to two, keeping every
covered path.

[HOW]
Turn the opaque, premultiplied and coverage cases into one table-driven
test over the pixel blend mode, and fold the DCN 4.2 case into the
global alpha test as a second table row selecting the DCE IP version.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 251 +++++++-----------
 1 file changed, 89 insertions(+), 162 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 9f9d99e1b47a..f60bb6239e53 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -117,142 +117,111 @@ static void dm_test_plane_is_video_format_known_video(struct kunit *test)
 }
 
 /**
- * dm_test_fill_blending_defaults() - Verify default blending output values.
+ * dm_test_fill_blending_pixel_blend_modes() - Verify per-pixel blending modes.
  * @test: KUnit test context.
  *
- * Verify if default blending output values are used for opaque alpha and no
- * per-pixel blending.
+ * Verify if opaque alpha keeps the default outputs, and if the premultiplied
+ * and coverage modes enable per-pixel alpha for an alpha-capable format.
  */
-static void dm_test_fill_blending_defaults(struct kunit *test)
-{
-	struct drm_plane_state state = { 0 };
-	bool per_pixel_alpha;
-	bool pre_multiplied_alpha;
-	bool global_alpha;
-	int global_alpha_value;
-
-	state.pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
-	state.alpha = 0xffff;
-
-	amdgpu_dm_plane_fill_blending_from_plane_state(&state,
-						       &per_pixel_alpha,
-						       &pre_multiplied_alpha,
-						       &global_alpha,
-						       &global_alpha_value);
-
-	KUNIT_EXPECT_FALSE(test, per_pixel_alpha);
-	KUNIT_EXPECT_TRUE(test, pre_multiplied_alpha);
-	KUNIT_EXPECT_FALSE(test, global_alpha);
-	KUNIT_EXPECT_EQ(test, global_alpha_value, 0xff);
-}
-
-/**
- * dm_test_fill_blending_premulti_alpha_format() - Verify premultiplied alpha path.
- * @test: KUnit test context.
- *
- * Verify if premultiplied mode enables per-pixel alpha for ARGB8888.
- */
-static void dm_test_fill_blending_premulti_alpha_format(struct kunit *test)
-{
-	struct drm_plane_state state = { 0 };
-	struct drm_framebuffer fb = { 0 };
-	bool per_pixel_alpha;
-	bool pre_multiplied_alpha;
-	bool global_alpha;
-	int global_alpha_value;
-
-	fb.format = drm_format_info(DRM_FORMAT_ARGB8888);
-	KUNIT_ASSERT_NOT_NULL(test, fb.format);
-
-	state.fb = &fb;
-	state.pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
-	state.alpha = 0xffff;
-
-	amdgpu_dm_plane_fill_blending_from_plane_state(&state,
-						       &per_pixel_alpha,
-						       &pre_multiplied_alpha,
-						       &global_alpha,
-						       &global_alpha_value);
-
-	KUNIT_EXPECT_TRUE(test, per_pixel_alpha);
-	KUNIT_EXPECT_TRUE(test, pre_multiplied_alpha);
-	KUNIT_EXPECT_FALSE(test, global_alpha);
-	KUNIT_EXPECT_EQ(test, global_alpha_value, 0xff);
-}
-
-/**
- * dm_test_fill_blending_coverage_alpha_format() - Verify coverage mode behavior.
- * @test: KUnit test context.
- *
- * Verify if coverage mode sets per-pixel alpha and disables
- * pre_multiplied_alpha for ARGB8888.
- */
-static void dm_test_fill_blending_coverage_alpha_format(struct kunit *test)
-{
-	struct drm_plane_state state = { 0 };
+static void dm_test_fill_blending_pixel_blend_modes(struct kunit *test)
+{
+	static const struct {
+		const char *name;
+		unsigned int blend_mode;
+		bool with_fb;
+		bool per_pixel_alpha;
+		bool pre_multiplied_alpha;
+	} cases[] = {
+		{ "defaults", DRM_MODE_BLEND_PIXEL_NONE, false, false, true },
+		{ "premultiplied", DRM_MODE_BLEND_PREMULTI, true, true, true },
+		{ "coverage", DRM_MODE_BLEND_COVERAGE, true, true, false },
+	};
 	struct drm_framebuffer fb = { 0 };
-	bool per_pixel_alpha;
-	bool pre_multiplied_alpha;
-	bool global_alpha;
-	int global_alpha_value;
+	unsigned int i;
 
 	fb.format = drm_format_info(DRM_FORMAT_ARGB8888);
 	KUNIT_ASSERT_NOT_NULL(test, fb.format);
 
-	state.fb = &fb;
-	state.pixel_blend_mode = DRM_MODE_BLEND_COVERAGE;
-	state.alpha = 0xffff;
-
-	amdgpu_dm_plane_fill_blending_from_plane_state(&state,
-						       &per_pixel_alpha,
-						       &pre_multiplied_alpha,
-						       &global_alpha,
-						       &global_alpha_value);
-
-	KUNIT_EXPECT_TRUE(test, per_pixel_alpha);
-	KUNIT_EXPECT_FALSE(test, pre_multiplied_alpha);
-	KUNIT_EXPECT_FALSE(test, global_alpha);
-	KUNIT_EXPECT_EQ(test, global_alpha_value, 0xff);
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct drm_plane_state state = { 0 };
+		bool per_pixel_alpha;
+		bool pre_multiplied_alpha;
+		bool global_alpha;
+		int global_alpha_value;
+
+		if (cases[i].with_fb)
+			state.fb = &fb;
+		state.pixel_blend_mode = cases[i].blend_mode;
+		state.alpha = 0xffff;
+
+		amdgpu_dm_plane_fill_blending_from_plane_state(&state,
+							       &per_pixel_alpha,
+							       &pre_multiplied_alpha,
+							       &global_alpha,
+							       &global_alpha_value);
+
+		KUNIT_EXPECT_EQ_MSG(test, per_pixel_alpha, cases[i].per_pixel_alpha,
+				    "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, pre_multiplied_alpha, cases[i].pre_multiplied_alpha,
+				    "%s", cases[i].name);
+		KUNIT_EXPECT_FALSE_MSG(test, global_alpha, "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, global_alpha_value, 0xff, "%s", cases[i].name);
+	}
 }
 
 /**
- * dm_test_fill_blending_global_alpha() - Verify global alpha conversion to 8 bits.
+ * dm_test_fill_blending_global_alpha() - Verify global alpha down-scaling.
  * @test: KUnit test context.
  *
- * Verify if global alpha is enabled and converted from 16-bit to 8-bit.
+ * Verify if global alpha is enabled and the 16-bit DRM alpha is scaled down to
+ * the 8-bit hardware field, or to the 12-bit field used by DCN 4.2.
  */
 static void dm_test_fill_blending_global_alpha(struct kunit *test)
 {
-	struct amdgpu_device *adev;
-	struct drm_plane *plane;
-	struct drm_plane_state *state;
-	bool per_pixel_alpha;
-	bool pre_multiplied_alpha;
-	bool global_alpha;
-	int global_alpha_value;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
-	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, plane);
-	KUNIT_ASSERT_NOT_NULL(test, state);
+	static const struct {
+		const char *name;
+		u32 dce_version;
+		int expected;
+	} cases[] = {
+		{ "8-bit field", IP_VERSION(4, 0, 0), 0x80 },
+		{ "DCN 4.2 12-bit field", IP_VERSION(4, 2, 0), 0x800 },
+	};
+	unsigned int i;
 
-	plane->dev = &adev->ddev;
-	state->plane = plane;
-	state->pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
-	state->alpha = 0x8000;
-
-	amdgpu_dm_plane_fill_blending_from_plane_state(state,
-						       &per_pixel_alpha,
-						       &pre_multiplied_alpha,
-						       &global_alpha,
-						       &global_alpha_value);
-
-	KUNIT_EXPECT_FALSE(test, per_pixel_alpha);
-	KUNIT_EXPECT_TRUE(test, pre_multiplied_alpha);
-	KUNIT_EXPECT_TRUE(test, global_alpha);
-	KUNIT_EXPECT_EQ(test, global_alpha_value, 0x80);
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct amdgpu_device *adev;
+		struct drm_plane *plane;
+		struct drm_plane_state *state;
+		bool per_pixel_alpha;
+		bool pre_multiplied_alpha;
+		bool global_alpha;
+		int global_alpha_value;
+
+		adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+		plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+		state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, adev);
+		KUNIT_ASSERT_NOT_NULL(test, plane);
+		KUNIT_ASSERT_NOT_NULL(test, state);
+
+		adev->ip_versions[DCE_HWIP][0] = cases[i].dce_version;
+		plane->dev = &adev->ddev;
+		state->plane = plane;
+		state->pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
+		state->alpha = 0x8000;
+
+		amdgpu_dm_plane_fill_blending_from_plane_state(state,
+							       &per_pixel_alpha,
+							       &pre_multiplied_alpha,
+							       &global_alpha,
+							       &global_alpha_value);
+
+		KUNIT_EXPECT_FALSE_MSG(test, per_pixel_alpha, "%s", cases[i].name);
+		KUNIT_EXPECT_TRUE_MSG(test, pre_multiplied_alpha, "%s", cases[i].name);
+		KUNIT_EXPECT_TRUE_MSG(test, global_alpha, "%s", cases[i].name);
+		KUNIT_EXPECT_EQ_MSG(test, global_alpha_value, cases[i].expected,
+				    "%s", cases[i].name);
+	}
 }
 
 /**
@@ -1157,45 +1126,6 @@ static void dm_test_get_format_info(struct kunit *test)
 	KUNIT_EXPECT_NOT_NULL(test, format_info);
 }
 
-/**
- * dm_test_fill_blending_global_alpha_dcn42() - Verify DCN 4.2 alpha scaling.
- * @test: KUnit test context.
- *
- * Verify if DCN 4.2 scales the 16-bit DRM alpha down by 4 bits instead of 8.
- */
-static void dm_test_fill_blending_global_alpha_dcn42(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct drm_plane *plane;
-	struct drm_plane_state *state;
-	bool per_pixel_alpha;
-	bool pre_multiplied_alpha;
-	bool global_alpha;
-	int global_alpha_value;
-
-	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
-	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
-	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, adev);
-	KUNIT_ASSERT_NOT_NULL(test, plane);
-	KUNIT_ASSERT_NOT_NULL(test, state);
-
-	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 2, 0);
-	plane->dev = &adev->ddev;
-	state->plane = plane;
-	state->pixel_blend_mode = DRM_MODE_BLEND_PIXEL_NONE;
-	state->alpha = 0x8000;
-
-	amdgpu_dm_plane_fill_blending_from_plane_state(state,
-						       &per_pixel_alpha,
-						       &pre_multiplied_alpha,
-						       &global_alpha,
-						       &global_alpha_value);
-
-	KUNIT_EXPECT_TRUE(test, global_alpha);
-	KUNIT_EXPECT_EQ(test, global_alpha_value, 0x800);
-}
-
 /* Modifier lists are terminated by DRM_FORMAT_MOD_INVALID, which is not counted. */
 static int dm_test_mods_count(const u64 *mods)
 {
@@ -4031,11 +3961,8 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_get_format_info() */
 	KUNIT_CASE(dm_test_get_format_info),
 	/* amdgpu_dm_plane_fill_blending_from_plane_state() */
-	KUNIT_CASE(dm_test_fill_blending_defaults),
-	KUNIT_CASE(dm_test_fill_blending_premulti_alpha_format),
-	KUNIT_CASE(dm_test_fill_blending_coverage_alpha_format),
+	KUNIT_CASE(dm_test_fill_blending_pixel_blend_modes),
 	KUNIT_CASE(dm_test_fill_blending_global_alpha),
-	KUNIT_CASE(dm_test_fill_blending_global_alpha_dcn42),
 	/* amdgpu_dm_plane_modifier_* helpers() */
 	KUNIT_CASE(dm_test_modifier_has_dcc),
 	KUNIT_CASE(dm_test_modifier_gfx9_swizzle_mode),
-- 
2.55.0

