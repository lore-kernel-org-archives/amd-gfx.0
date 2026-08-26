Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3497CC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DB8810EE55;
	Wed, 26 Aug 2026 23:28:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xnVkDvmQ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0179010EE55
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rwg/bKgVsrbYHS4RTm62WCzSdE9MxfBQXidEZlU6+erfJ6k/uWyJkT9EELNCI6lWTgClFBQR7dg1sYO9o3ZPcQNhYCPHKqUOgwT8Jup1nWepRxpaID+81p02953eX8YxerS6kf6zn6DjxpK+XlwMCNkZ8z44LXPlJuVChvhUZOIuLVyPzY+LQZJ9wfpIQSvKHCU2dTQaVS0hH4ddjSHraUJMh0mZNESWUro/RcFkcoxkWXuTOkdaIBUzrbG/gjq7ACW4pccunZSk3YgoDWQZm5c44/3GCeOEV+cwfTkdcuOLOItF6HRn4tTLbgEq1jaYh+/KjFWjsSiNQzRWCBMTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFkgtG8VugrtrO+XqfMyYejBVXi63H9wYxWkftUPO7s=;
 b=Jdjtc4G2HqwCEGBvJhZUdzWwcwLhzZJHsInq0/zCSNfjiYALBgsxT2ZSNYOunUsNqhoED2/yQeRPh5brmHWTPMVMf1bmROGYqCsp0BnZN6M8t42dEANC944VXn/GKdHD9Rd1zR4WblTbNOUmIT8bzhS2sEp7A/e3PMmn0TbTYOVAinZPQ5zXrJlZ+b5F88mCvGavnW5kg8jlYLlf3jE31bsN/CN0QFTsnnA7ZRJMcqpNaeY/l1/OB3B0uExB7CBlS1sDxgaBusTddsgoR1EjY40amC4/mpvft5SuNp0jqQ9S7BgbXT6lUd6DjAfjsqEx8ovnZgW5wCFOPPPDTkIXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFkgtG8VugrtrO+XqfMyYejBVXi63H9wYxWkftUPO7s=;
 b=xnVkDvmQktdV8KhXG8Rdk8HnvfNLAPGyFgIrEX3LMYN3/sXAP72wcd/VtPSal5yrjkwnewO/84Sh1UYzwoYUL+1ocVFHovhQbdClqebKX3v/l9F1BQOF4+r3tMcUTX6xsQa7KBB43+UrxQu9AVEvUbwsLLb2mpgnPmYKwibo04U=
Received: from SN7PR18CA0013.namprd18.prod.outlook.com (2603:10b6:806:f3::31)
 by PH7PR12MB9066.namprd12.prod.outlook.com (2603:10b6:510:1f6::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 26 Aug
 2026 23:27:54 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::12) by SN7PR18CA0013.outlook.office365.com
 (2603:10b6:806:f3::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:27:53 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:27:48 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 36/59] drm/amd/display: Test PSR dirty rectangle filling
Date: Wed, 26 Aug 2026 17:05:07 -0600
Message-ID: <20260826231519.881949-37-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH7PR12MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: c07cae2d-a8a5-412b-dda7-08df03c9a730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|5023799004|11063799006|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Fh6OQ97K+QG+UlKUTtkMfOWytVlrDZWcIYloA5N1CFwX6OGE6hhKEbWY79C+5EtmwPB/v2N2Yw6v2tInytdumlQoeafuKxQT00UP373FdpvnfvwYX+d+sxrIJcaf1jwjkGUehAcL0cKIXQmoTDvwcloWArrGW8qY0fcWKUvpFI/gZijbh7QYjxAXljxfBQAOwTBlUrQcgb2ApwFMNQX+JCOBkiY3mjw/deczcF7Dw2WNJVYDHLpAXUGjOSpoQw1PTSsXi82Wz0/2hqY8rfgJxVE+WMxHMipfavtb817sZMH3z2m0piwOgNZVOHRbu7yhvKxNAQBpPnvu58miAhi/JQhuaJOZisJ+X/+P4kkIQc5CQ1gKtNtg0x5RF0kNwVg768N5OSGFXq9ry+WXTHI5o8J4msfBU9vhGa3X+/rZ4op9zoG5rRLa7ksDdihg7ngP1NEnOG92GFh4G/G5Y6cHX+cQchP27qWSWdhlFoHa+/f7w91ibJCrT9FCxjg3V+UL9NjTh9Q3HEaQAmETzf3iDAWZLrnauf4ouosC677IBYolhs80YBW33Zs7SK2evT+oXoOt0N3JABW5f2eqxgX7PiZ10OqkGmf+UH1XEJzX8TDyPsD4Yt5YFzJM08jvLTxn7gcOCLAo6i6U/jF632CeUUZWLO+tORSaL8KbvsfxF6cahuaovNumUDNSn5Co/FkmeJfbNGlg8R4u9OuGjR+7IQ==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(5023799004)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lAfteYYeSfPer6sB4hNQb3CuhDWDhjZhfwxHZPBoMu0EfhgrrfA9VoObAInEwC5LtJpHSjvQpyjQ3Iq/LZIwVjKj+Pjtn/VgjOHnw2xPxrp4SXmIVowgyJh8lmdjtTeULQAdJUqcNh8KR4yUxm5xNVLGvd4KVSrpBFUdbHDYlSzaZBb4cK5BDgBF9PWk//UT5P/IYsZzLxWocwipWeOYaRe3S+GYR1pBadZ+ZvJUoPtoBRp9CshQF7mByYgP765I7YO+pJmG9gKY4OtuaCVEQmmBwap6trhteU4lf68O6jVEV5MNYW5j5X3rba4hU8gK1SaAG/i5byNZoq03J2FvC1DcWNtKKzDopuK9h8pNq5Ac7pYrQP0dka6oF4cK6RmEYoAIaGUgNkCoYK1GcB1CbcZc0ZRtOb5OsUNmy29NvpXa8RkJmtETOp2iok2THCty
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:27:53.6942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c07cae2d-a8a5-412b-dda7-08df03c9a730
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9066
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

[WHAT]
Add KUnit tests for fill_dc_dirty_rects() covering the cursor plane
bypass, the full frame update fallbacks taken on rotation, on a
damage-unaware client, on ignored damage clips, on exceeding
DC_MAX_DIRTY_RECTS and on PSR SU in auto damage mode, the verbatim copy of
damage clips, and the MPO paths for a moved plane, a flipped plane, stable
clips and clips that overflow together with the bounding boxes.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  15 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   8 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 349 ++++++++++++++++++
 3 files changed, 365 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 70f50fa17366..17425791e0ee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3147,13 +3147,13 @@ static inline void fill_dc_dirty_rect(struct drm_plane *plane,
  * implicitly provide damage clips without any client support via the plane
  * bounds.
  */
-static void fill_dc_dirty_rects(struct drm_plane *plane,
-				struct drm_plane_state *old_plane_state,
-				struct drm_plane_state *new_plane_state,
-				struct drm_crtc_state *crtc_state,
-				struct dc_flip_addrs *flip_addrs,
-				bool is_psr_su,
-				bool *dirty_regions_changed)
+STATIC_IFN_KUNIT void fill_dc_dirty_rects(struct drm_plane *plane,
+					  struct drm_plane_state *old_plane_state,
+					  struct drm_plane_state *new_plane_state,
+					  struct drm_crtc_state *crtc_state,
+					  struct dc_flip_addrs *flip_addrs,
+					  bool is_psr_su,
+					  bool *dirty_regions_changed)
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
 	struct rect *dirty_rects = flip_addrs->dirty_rects;
@@ -3259,6 +3259,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 			   dm_crtc_state->base.mode.crtc_vdisplay,
 			   &flip_addrs->dirty_rect_count, true);
 }
+EXPORT_IF_KUNIT(fill_dc_dirty_rects);
 
 static int dm_update_mst_vcpi_slots_for_dsc(struct drm_atomic_commit *state,
 					    struct dc_state *dc_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index ca19977cf788..2e3ad13b773a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1172,6 +1172,14 @@ struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_commit *state)
 struct drm_private_state *dm_atomic_duplicate_state(struct drm_private_obj *obj);
 void dm_atomic_destroy_state(struct drm_private_obj *obj,
 			     struct drm_private_state *state);
+struct dc_flip_addrs;
+void fill_dc_dirty_rects(struct drm_plane *plane,
+			 struct drm_plane_state *old_plane_state,
+			 struct drm_plane_state *new_plane_state,
+			 struct drm_crtc_state *crtc_state,
+			 struct dc_flip_addrs *flip_addrs,
+			 bool is_psr_su,
+			 bool *dirty_regions_changed);
 void dm_update_pflip_irq_state(struct amdgpu_device *adev,
 			       struct amdgpu_crtc *acrtc);
 void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 0c57b3cc47fe..f5f2b063b355 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1937,6 +1937,343 @@ static void dm_test_mem_type_changed_different_domain(struct kunit *test)
 							       ctx->crtc_state));
 }
 
+/* Tests for fill_dc_dirty_rects() */
+
+struct dm_test_dirty_ctx {
+	struct amdgpu_device *adev;
+	struct drm_plane *plane;
+	struct drm_plane_state *old_plane_state;
+	struct drm_plane_state *new_plane_state;
+	struct dm_crtc_state *crtc_state;
+	struct dc_flip_addrs *flip_addrs;
+	bool dirty_regions_changed;
+};
+
+static struct dm_test_dirty_ctx *dm_test_dirty_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->adev = dm_kunit_alloc_adev(test);
+	ctx->plane = drm_kunit_helper_create_primary_plane(test, &ctx->adev->ddev,
+							   NULL, NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->plane);
+	drm_plane_enable_fb_damage_clips(ctx->plane);
+	ctx->old_plane_state = kunit_kzalloc(test, sizeof(*ctx->old_plane_state),
+					     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->old_plane_state);
+	ctx->new_plane_state = kunit_kzalloc(test, sizeof(*ctx->new_plane_state),
+					     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->new_plane_state);
+	ctx->crtc_state = kunit_kzalloc(test, sizeof(*ctx->crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_state);
+	ctx->flip_addrs = kunit_kzalloc(test, sizeof(*ctx->flip_addrs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->flip_addrs);
+
+	ctx->plane->type = DRM_PLANE_TYPE_PRIMARY;
+	ctx->new_plane_state->plane = ctx->plane;
+	ctx->new_plane_state->rotation = DRM_MODE_ROTATE_0;
+	ctx->old_plane_state->plane = ctx->plane;
+	ctx->crtc_state->base.mode.crtc_hdisplay = 1920;
+	ctx->crtc_state->base.mode.crtc_vdisplay = 1080;
+
+	return ctx;
+}
+
+static void dm_test_fill_dirty_rects(struct dm_test_dirty_ctx *ctx, bool is_psr_su)
+{
+	fill_dc_dirty_rects(ctx->plane, ctx->old_plane_state,
+			    ctx->new_plane_state, &ctx->crtc_state->base,
+			    ctx->flip_addrs, is_psr_su,
+			    &ctx->dirty_regions_changed);
+}
+
+/*
+ * Attach @count damage clips to the new plane state. The blob is only ever
+ * read through drm_plane_get_damage_clips(), so a bare blob is enough.
+ */
+static struct drm_mode_rect *dm_test_add_damage_clips(struct kunit *test,
+						      struct drm_plane_state *state,
+						      unsigned int count)
+{
+	struct drm_property_blob *blob;
+	struct drm_mode_rect *clips;
+
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+	clips = kunit_kcalloc(test, count, sizeof(*clips), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, clips);
+
+	blob->length = count * sizeof(*clips);
+	blob->data = clips;
+	state->fb_damage_clips = blob;
+
+	return clips;
+}
+
+/**
+ * dm_test_dirty_rects_cursor_plane - Test cursor planes are left to their own path
+ * @test: The KUnit test context
+ */
+static void dm_test_dirty_rects_cursor_plane(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx = dm_test_dirty_ctx_alloc(test);
+
+	ctx->plane->type = DRM_PLANE_TYPE_CURSOR;
+
+	dm_test_fill_dirty_rects(ctx, true);
+
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rect_count, 0U);
+}
+
+/**
+ * dm_test_dirty_rects_rotation_ffu - Test a rotated plane falls back to full frame update
+ * @test: The KUnit test context
+ */
+static void dm_test_dirty_rects_rotation_ffu(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx = dm_test_dirty_ctx_alloc(test);
+
+	ctx->new_plane_state->rotation = DRM_MODE_ROTATE_90;
+
+	dm_test_fill_dirty_rects(ctx, true);
+
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rect_count, 1U);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].x, 0);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].y, 0);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].width, 1920);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].height, 1080);
+}
+
+/**
+ * dm_test_dirty_rects_no_clips_ffu - Test a damage-unaware client gets a full frame update
+ * @test: The KUnit test context
+ */
+static void dm_test_dirty_rects_no_clips_ffu(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx = dm_test_dirty_ctx_alloc(test);
+
+	dm_test_fill_dirty_rects(ctx, true);
+
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rect_count, 1U);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].width, 1920);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].height, 1080);
+}
+
+/**
+ * dm_test_dirty_rects_ignored_damage_clips - Test ignored damage clips force a full update
+ * @test: The KUnit test context
+ */
+static void dm_test_dirty_rects_ignored_damage_clips(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx = dm_test_dirty_ctx_alloc(test);
+
+	dm_test_add_damage_clips(test, ctx->new_plane_state, 1);
+	ctx->new_plane_state->ignore_damage_clips = true;
+
+	dm_test_fill_dirty_rects(ctx, true);
+
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rect_count, 1U);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].width, 1920);
+}
+
+/**
+ * dm_test_dirty_rects_too_many_clips_ffu - Test exceeding DC_MAX_DIRTY_RECTS falls back
+ * @test: The KUnit test context
+ */
+static void dm_test_dirty_rects_too_many_clips_ffu(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx = dm_test_dirty_ctx_alloc(test);
+
+	dm_test_add_damage_clips(test, ctx->new_plane_state,
+				 DC_MAX_DIRTY_RECTS + 1);
+
+	dm_test_fill_dirty_rects(ctx, false);
+
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rect_count, 1U);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].width, 1920);
+}
+
+/**
+ * dm_test_dirty_rects_damage_clips - Test damage clips are copied verbatim
+ * @test: The KUnit test context
+ */
+static void dm_test_dirty_rects_damage_clips(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx = dm_test_dirty_ctx_alloc(test);
+	struct drm_mode_rect *clips;
+
+	clips = dm_test_add_damage_clips(test, ctx->new_plane_state, 2);
+	clips[0].x1 = 10;
+	clips[0].y1 = 20;
+	clips[0].x2 = 40;
+	clips[0].y2 = 60;
+	clips[1].x1 = 100;
+	clips[1].y1 = 200;
+	clips[1].x2 = 150;
+	clips[1].y2 = 260;
+
+	dm_test_fill_dirty_rects(ctx, false);
+
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rect_count, 2U);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].x, 10);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].y, 20);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].width, 30);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].height, 40);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[1].x, 100);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[1].width, 50);
+	KUNIT_EXPECT_FALSE(test, ctx->dirty_regions_changed);
+}
+
+/**
+ * dm_test_dirty_rects_mpo_bb_changed - Test MPO adds both plane bounding boxes
+ * @test: The KUnit test context
+ */
+static void dm_test_dirty_rects_mpo_bb_changed(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx = dm_test_dirty_ctx_alloc(test);
+	struct drm_framebuffer *fb;
+
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	ctx->crtc_state->mpo_requested = true;
+	ctx->old_plane_state->fb = fb;
+	ctx->new_plane_state->fb = fb;
+	ctx->old_plane_state->crtc_x = 0;
+	ctx->old_plane_state->crtc_y = 0;
+	ctx->old_plane_state->crtc_w = 640;
+	ctx->old_plane_state->crtc_h = 480;
+	ctx->new_plane_state->crtc_x = 100;
+	ctx->new_plane_state->crtc_y = 50;
+	ctx->new_plane_state->crtc_w = 800;
+	ctx->new_plane_state->crtc_h = 600;
+
+	dm_test_fill_dirty_rects(ctx, true);
+
+	KUNIT_EXPECT_TRUE(test, ctx->dirty_regions_changed);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rect_count, 2U);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].x, 100);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].width, 800);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[1].x, 0);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[1].width, 640);
+}
+
+/**
+ * dm_test_dirty_rects_mpo_fb_changed - Test MPO flips add the new plane bounding box
+ * @test: The KUnit test context
+ */
+static void dm_test_dirty_rects_mpo_fb_changed(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx = dm_test_dirty_ctx_alloc(test);
+	struct drm_framebuffer *old_fb;
+	struct drm_framebuffer *new_fb;
+
+	old_fb = kunit_kzalloc(test, sizeof(*old_fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_fb);
+	new_fb = kunit_kzalloc(test, sizeof(*new_fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_fb);
+
+	old_fb->base.id = 1;
+	new_fb->base.id = 2;
+	ctx->crtc_state->mpo_requested = true;
+	ctx->old_plane_state->fb = old_fb;
+	ctx->new_plane_state->fb = new_fb;
+	ctx->new_plane_state->crtc_w = 800;
+	ctx->new_plane_state->crtc_h = 600;
+	ctx->old_plane_state->crtc_w = 800;
+	ctx->old_plane_state->crtc_h = 600;
+
+	dm_test_fill_dirty_rects(ctx, true);
+
+	KUNIT_EXPECT_FALSE(test, ctx->dirty_regions_changed);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rect_count, 1U);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].width, 800);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].height, 600);
+}
+
+/**
+ * dm_test_dirty_rects_psr_su_ffu - Test PSR SU ignores clips in auto damage mode
+ * @test: The KUnit test context
+ */
+static void dm_test_dirty_rects_psr_su_ffu(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx = dm_test_dirty_ctx_alloc(test);
+
+	dm_test_add_damage_clips(test, ctx->new_plane_state, 1);
+
+	dm_test_fill_dirty_rects(ctx, true);
+
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rect_count, 1U);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].width, 1920);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].height, 1080);
+}
+
+/**
+ * dm_test_dirty_rects_mpo_clips - Test MPO copies damage clips when the box is stable
+ * @test: The KUnit test context
+ */
+static void dm_test_dirty_rects_mpo_clips(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx = dm_test_dirty_ctx_alloc(test);
+	struct drm_mode_rect *clips;
+	struct drm_framebuffer *fb;
+
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	clips = dm_test_add_damage_clips(test, ctx->new_plane_state, 2);
+	clips[0].x1 = 5;
+	clips[0].y1 = 6;
+	clips[0].x2 = 25;
+	clips[0].y2 = 36;
+	clips[1].x1 = 50;
+	clips[1].y1 = 60;
+	clips[1].x2 = 90;
+	clips[1].y2 = 110;
+
+	ctx->crtc_state->mpo_requested = true;
+	ctx->old_plane_state->fb = fb;
+	ctx->new_plane_state->fb = fb;
+
+	dm_test_fill_dirty_rects(ctx, false);
+
+	KUNIT_EXPECT_FALSE(test, ctx->dirty_regions_changed);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rect_count, 2U);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].x, 5);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].width, 20);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[1].x, 50);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[1].height, 50);
+}
+
+/**
+ * dm_test_dirty_rects_mpo_overflow_ffu - Test MPO falls back when clips plus boxes overflow
+ * @test: The KUnit test context
+ */
+static void dm_test_dirty_rects_mpo_overflow_ffu(struct kunit *test)
+{
+	struct dm_test_dirty_ctx *ctx = dm_test_dirty_ctx_alloc(test);
+	struct drm_framebuffer *fb;
+
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	dm_test_add_damage_clips(test, ctx->new_plane_state, 2);
+
+	ctx->crtc_state->mpo_requested = true;
+	ctx->old_plane_state->fb = fb;
+	ctx->new_plane_state->fb = fb;
+	ctx->new_plane_state->crtc_x = 100;
+
+	dm_test_fill_dirty_rects(ctx, false);
+
+	KUNIT_EXPECT_TRUE(test, ctx->dirty_regions_changed);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rect_count, 1U);
+	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].width, 1920);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -2038,6 +2375,18 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_mem_type_changed_missing_state),
 	KUNIT_CASE(dm_test_mem_type_changed_same_domain),
 	KUNIT_CASE(dm_test_mem_type_changed_different_domain),
+	/* fill_dc_dirty_rects */
+	KUNIT_CASE(dm_test_dirty_rects_cursor_plane),
+	KUNIT_CASE(dm_test_dirty_rects_rotation_ffu),
+	KUNIT_CASE(dm_test_dirty_rects_no_clips_ffu),
+	KUNIT_CASE(dm_test_dirty_rects_ignored_damage_clips),
+	KUNIT_CASE(dm_test_dirty_rects_too_many_clips_ffu),
+	KUNIT_CASE(dm_test_dirty_rects_damage_clips),
+	KUNIT_CASE(dm_test_dirty_rects_mpo_bb_changed),
+	KUNIT_CASE(dm_test_dirty_rects_mpo_fb_changed),
+	KUNIT_CASE(dm_test_dirty_rects_psr_su_ffu),
+	KUNIT_CASE(dm_test_dirty_rects_mpo_clips),
+	KUNIT_CASE(dm_test_dirty_rects_mpo_overflow_ffu),
 	{}
 };
 
-- 
2.43.0

