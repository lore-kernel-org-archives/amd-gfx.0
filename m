Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540FAC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:34:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FD010EE66;
	Wed, 26 Aug 2026 23:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W4OoRzwE";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAEE410EE66
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:34:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frpS7bvlL07pEujqXTvvpEpji3OWy6M21P7KSIohoIDCU46Yt/m1KLapsFfC2GjDMvt4yxDPJ7f2n0XUWv3i1Kb/4cIJNVQX22SNiPj0n0+GES51K/rmf2rFzn+6/GvDHMMGMENf0i6HMRol6ZfO2x//5F7EsLpFdsR7JoUS53KpapjQBXqK1DKshlaEuUnCMnZYE4+nLJStV9TG5r8e689z5XLha93gOEoJOL+oCkx68KGD6VpZWkP+daeNHzcbDgtrDTeMn3NsZwJ2TutLbh8cdKDOA4VC0lea3d3zvD0beXlB9UgF3dCz6lE/SDtSra/4qopFsRfHl8IKtGIlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jug4p2v3NcNI3Q13+eyTf6R+bd136iMVzzAgLlL+SBQ=;
 b=HHtQJhd6Hv91y02UgjhvqIwjnkY4ONSBBY3i543alTcssRMtI3NWkRM7HQT/2WpvZgvZjHNq5oJ7aeAQlrU0jU0I5uzHfZp50Fgf4UglYHTGh15+o7YH7vjYnCCs1OY8mpBHG+3WdBBbF1PeXjQTKv+oOsxBqdzTJyuruNoWMOzF8mB6ScoOaidv2hsCLSfq9GttqiHM16IhWdw5ErXZ4a/qLsfgHJITE4XhlEhAHsQRAf7BBcBuHisWhNK8vWRCq1HcRzgGNyRsjYu/QcLoLSuYFoipKDYzmv56F1HrSnxurQOhJXsfuUUcJO7tWdCYDaSAXLvP6m/1lEQfRo8Kgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jug4p2v3NcNI3Q13+eyTf6R+bd136iMVzzAgLlL+SBQ=;
 b=W4OoRzwE7wrHH9HKPgmZ5hQ9LVoHyeRpsRS7T3oSYpvdGeStcx9fy/v+2uNstku9/V9GOAO+8wCDwhNrLK2ihTfgHInNZNpCqCoyotrHvCgTxhB4LS5FKYZ48a83VzTaHF3/zQuqNjEe0WD7u91RRQqNtaoiCEy5OKTpzuP4t4U=
Received: from SA0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:806:130::29)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Wed, 26 Aug
 2026 23:34:03 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:130:cafe::32) by SA0PR13CA0024.outlook.office365.com
 (2603:10b6:806:130::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.7 via Frontend Transport; Wed, 26
 Aug 2026 23:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:34:02 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:33:58 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 54/59] drm/amd/display: Test DC plane attributes
Date: Wed, 26 Aug 2026 17:05:25 -0600
Message-ID: <20260826231519.881949-55-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: eca9d293-9e4f-4993-1cce-08df03ca8341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|82310400026|376014|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yVxL40wOLKsGQFjhyMHtA6sAGKnQbBbHEM7zyJo+2ID+R0oWkU9W5ErgqCmzTePNe/ApXpk1RZqUcA62KWVwQVj+ZoQpow4aKeDDz2Jzkiiswg25KFvt81MRS/aAeiAgGP9vJdfRbN+A1GwmcrV01Kees6QsX2OqIOdxKdXoUe8IMpPLLoiGpzfdiqml68kmdFqLCWPUoXzepPv8AQHJ13svgKv3d71p80ny0X6ky0NQOLfYUNTuPbh6eo1ShOEdDNMNp2AAYORPev76Qts3Njmh58aeebF6M79Xo1GbGfVjfdD5FJFLmoVK3WP1vNY5Eafeft6M9DZscoCNmsgxKeNa8xGEUxr/NvAhvVQRux4Cj/hmTy2AtOJGtSC0nO7/3XiUE0fsEUtzC8e+2e/uCnJsvKL/NphhOI1MtLFEyqc4FfqbIEMD+SJFJMvrufS4eTfa5KWTIfZY0FZ7lPS0vfIiURLpPgNrVa3mUGXQWV2PsG7kz2yGq7gV/iB7jA4LXbidVHktO8RexgInnj2cv8XcIfr4MNfJCLCHe4nxSDn9czd87m0uEoah/YbYvfjp2BdRButAHmvdFi2sGIP6UfWSnn9cyX9NYakm/cSlPf4Xh36EGO2+/w8g9ZlBAfaMt00O7MQHSMBvrW56d7qHNv2UEVOOxwb6yASJSRYihBBPw2jHKUFq78JkvX/KR25ryJmEBa6zToQ89WoXvQjHag==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /QqynEWhmtbLUvwD3UXvHmmaMfr8IH+uBLU1rnxBNIwWlh3XNJvfd3XClvKniH1AVXaJwZUiqpqrd/Nuko/S9Evz5Q+pwckM52twu9dqs8QyqZBrrbkq8sQ78S1PKMft7PhzNVEDTWaMZ+8xAKHxpfWctpIHN5N/Qb2G6bvNaC8btbMhdWjH9++mW72MGKmSyRIyTK7yPzQAwlR2XyeIUMweHEoQBnxSl8dwYmSSewjtEiOqEhoiIZteDP0r5igzXeqPzuhkKvUxQm+jgmiMrrdyWxNi129NFZb2sHLGJTIXb1e3Pgii4dxyJWrdaJ4iuDKQ9ae9fOANw1Ea8yZnIzEwQ6TNbgX/p2tzMat3JwjJ9E7OzOy8JJ8C3G5NXGs/EN61+SSmdC6V7Rvbr7JFVR3apgUAwBjsAiVK1i7HZG1DVmHE4KPdey47iSeqJ37J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:34:02.9339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eca9d293-9e4f-4993-1cce-08df03ca8341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
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
Add KUnit tests for fill_dc_plane_attributes(), covering the copy of the
plane info into the DC plane state and the scaling, pixel format and 3D
LUT rejection paths.

[HOW]
Reuse the plane info fixture and add a CRTC state complete enough for
the colour management update. A scaling factor of 1 in the plane caps
means no scaling, which matches the 1:1 geometry of the fixture.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 126 ++++++++++++++++++
 3 files changed, 134 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8a87677b46b8..a97caf7e1d33 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3074,10 +3074,10 @@ fill_dc_plane_info_and_addr(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(fill_dc_plane_info_and_addr);
 
-static int fill_dc_plane_attributes(struct amdgpu_device *adev,
-				    struct dc_plane_state *dc_plane_state,
-				    struct drm_plane_state *plane_state,
-				    struct drm_crtc_state *crtc_state)
+STATIC_IFN_KUNIT int fill_dc_plane_attributes(struct amdgpu_device *adev,
+					      struct dc_plane_state *dc_plane_state,
+					      struct drm_plane_state *plane_state,
+					      struct drm_crtc_state *crtc_state)
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
 	struct amdgpu_framebuffer *afb = (struct amdgpu_framebuffer *)plane_state->fb;
@@ -3130,6 +3130,7 @@ static int fill_dc_plane_attributes(struct amdgpu_device *adev,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(fill_dc_plane_attributes);
 
 static inline void fill_dc_dirty_rect(struct drm_plane *plane,
 				      struct rect *dirty_rect, int32_t x,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 09ecca519b3b..b1db78e79015 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1268,6 +1268,9 @@ int amdgpu_dm_mode_config_init(struct amdgpu_device *adev);
 int initialize_plane(struct amdgpu_display_manager *dm, struct amdgpu_mode_info *mode_info,
 		     int plane_id, enum drm_plane_type plane_type,
 		     const struct dc_plane_cap *plane_cap);
+int fill_dc_plane_attributes(struct amdgpu_device *adev, struct dc_plane_state *dc_plane_state,
+			     struct drm_plane_state *plane_state,
+			     struct drm_crtc_state *crtc_state);
 #endif
 
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 0fe19a66e6f9..f8c540a6cdee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -3964,6 +3964,127 @@ static void dm_test_early_init_unsupported_version(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, adev->dc_enabled);
 }
 
+/* Tests for fill_dc_plane_attributes() */
+
+struct dm_test_plane_attr_ctx {
+	struct amdgpu_device *adev;
+	struct dm_crtc_state *crtc_state;
+	struct dm_test_plane_info_ctx *plane;
+	struct dc_plane_state *dc_plane;
+};
+
+/*
+ * A DC plane, plus a CRTC state complete enough for the colour management
+ * update at the end of fill_dc_plane_attributes(). A scaling factor of 1 in the
+ * plane caps means "no scaling", which is what the 1:1 geometry of the plane
+ * info context needs.
+ */
+static struct dm_test_plane_attr_ctx *
+dm_test_plane_attr_ctx_alloc(struct kunit *test, u32 drm_format)
+{
+	struct dm_test_plane_attr_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->crtc_state = kunit_kzalloc(test, sizeof(*ctx->crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_state);
+	ctx->dc_plane = kunit_kzalloc(test, sizeof(*ctx->dc_plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dc_plane);
+
+	ctx->adev = dm_kunit_alloc_adev(test);
+	ctx->adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+	ctx->adev->dm.dc->caps.planes[0].max_upscale_factor.argb8888 = 1;
+	ctx->adev->dm.dc->caps.planes[0].max_downscale_factor.argb8888 = 1;
+
+	ctx->crtc_state->stream = dm_kunit_alloc_stream(test, NULL);
+	/* Colour management resolves the device through the commit backpointer. */
+	ctx->crtc_state->base.state = dm_test_alloc_commit(test, ctx->adev);
+	ctx->plane = dm_test_plane_info_ctx_alloc(test, ctx->adev, drm_format);
+
+	return ctx;
+}
+
+static int dm_test_fill_plane_attr(struct dm_test_plane_attr_ctx *ctx)
+{
+	return fill_dc_plane_attributes(ctx->adev, ctx->dc_plane,
+					ctx->plane->plane_state, &ctx->crtc_state->base);
+}
+
+/**
+ * dm_test_plane_attributes_success - Test plane info is copied into the DC plane
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_attributes_success(struct kunit *test)
+{
+	struct dm_test_plane_attr_ctx *ctx;
+
+	ctx = dm_test_plane_attr_ctx_alloc(test, DRM_FORMAT_ARGB8888);
+	ctx->plane->plane_state->normalized_zpos = 2;
+
+	KUNIT_EXPECT_EQ(test, dm_test_fill_plane_attr(ctx), 0);
+	KUNIT_EXPECT_EQ(test, (int)ctx->dc_plane->format,
+			(int)SURFACE_PIXEL_FORMAT_GRPH_ARGB8888);
+	KUNIT_EXPECT_EQ(test, (int)ctx->dc_plane->color_space, (int)COLOR_SPACE_SRGB);
+	KUNIT_EXPECT_EQ(test, (int)ctx->dc_plane->rotation, (int)ROTATION_ANGLE_0);
+	KUNIT_EXPECT_EQ(test, ctx->dc_plane->src_rect.width, 1920U);
+	KUNIT_EXPECT_EQ(test, ctx->dc_plane->dst_rect.width, 1920U);
+	KUNIT_EXPECT_EQ(test, ctx->dc_plane->layer_index, 2);
+	KUNIT_EXPECT_TRUE(test, ctx->dc_plane->visible);
+	KUNIT_EXPECT_TRUE(test, ctx->dc_plane->flip_int_enabled);
+}
+
+/**
+ * dm_test_plane_attributes_bad_scaling - Test an empty source rectangle is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_attributes_bad_scaling(struct kunit *test)
+{
+	struct dm_test_plane_attr_ctx *ctx;
+
+	ctx = dm_test_plane_attr_ctx_alloc(test, DRM_FORMAT_ARGB8888);
+	ctx->plane->plane_state->src_w = 0;
+
+	KUNIT_EXPECT_EQ(test, dm_test_fill_plane_attr(ctx), -EINVAL);
+}
+
+/**
+ * dm_test_plane_attributes_bad_format - Test an unsupported format is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_attributes_bad_format(struct kunit *test)
+{
+	struct dm_test_plane_attr_ctx *ctx;
+
+	ctx = dm_test_plane_attr_ctx_alloc(test, DRM_FORMAT_YUYV);
+
+	KUNIT_EXPECT_EQ(test, dm_test_fill_plane_attr(ctx), -EINVAL);
+}
+
+/**
+ * dm_test_plane_attributes_bad_color_mgmt - Test a bad 3D LUT is rejected
+ * @test: The KUnit test context
+ */
+static void dm_test_plane_attributes_bad_color_mgmt(struct kunit *test)
+{
+	struct dm_test_plane_attr_ctx *ctx;
+	struct drm_property_blob *blob;
+	struct drm_color_lut *lut;
+
+	ctx = dm_test_plane_attr_ctx_alloc(test, DRM_FORMAT_ARGB8888);
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+	lut = kunit_kcalloc(test, 16, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	/* A 3D LUT that is not a perfect cube fails validation. */
+	blob->data = lut;
+	blob->length = 16 * sizeof(*lut);
+	ctx->adev->dm.dc->caps.color.dpp.hw_3d_lut = true;
+	ctx->plane->dm_plane_state->lut3d = blob;
+
+	KUNIT_EXPECT_EQ(test, dm_test_fill_plane_attr(ctx), -EINVAL);
+}
+
 /* Tests for load_dmcu_fw() */
 
 /**
@@ -4505,6 +4626,11 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_early_init_legacy_asics),
 	KUNIT_CASE(dm_test_early_init_dcn_versions),
 	KUNIT_CASE(dm_test_early_init_unsupported_version),
+	/* fill_dc_plane_attributes */
+	KUNIT_CASE(dm_test_plane_attributes_success),
+	KUNIT_CASE(dm_test_plane_attributes_bad_scaling),
+	KUNIT_CASE(dm_test_plane_attributes_bad_format),
+	KUNIT_CASE(dm_test_plane_attributes_bad_color_mgmt),
 	/* load_dmcu_fw */
 	KUNIT_CASE(dm_test_load_dmcu_fw_no_dmcu),
 	KUNIT_CASE(dm_test_load_dmcu_fw_dcn),
-- 
2.43.0

