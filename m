Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C9EC61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC2210EE54;
	Wed, 26 Aug 2026 23:27:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z3IlEImS";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012033.outbound.protection.outlook.com [40.107.209.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA2610EE54
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:27:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8F2djShYfhm9w8f/Q62rJL613yTFOiSy95VJ7D5ZjofK0+PjmUZDgvboz5GaU9I9GGs2ZOwXCkUjSy03CoXDpUoWfRFCPFUltFum3CeknHy1xbyhVgd1qv6UHiD25MfaosKhM97VJRNwDfoXSIHE4Ker71f+Gls0cwk22xdFuVLEjkpPC8cZ6xYHEyRoIElpCm80bLPy3x43FpyLH1TSqSlApbRPvG1XDgAgAA1ptzboHDsnrzKeH4wWSeiNKxAN1gypeQWmxYc7erSwBIm4TCTioTWLlirJUfOtV/E1q9OuYQDWCRBibjXfRh6kzocEvTVULAVARersT1xwgzMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZB+eZ7net1nxsQrIN+hCcvUV5T/AOQBeHqB4CpolNV0=;
 b=o3iy3pHg7uQkbVmwouVfzF/R9mZonMS8b8JXNG9sF0o2Ip7qFcBdixV/JcnnBpO0rD0on4a8DTDx8ePUonAGcphQq++k/yFTWqvLDR5mz0cj1uBWqobyYj0Gsa3k4wBa0l84PN/D2h6kd9N85PKdJP8+6P2MqWHHI0F0XWQZ+T9xvqAhtOYBU4JhiyDct9Kt2pS5qZZKN+9l8Lv7MkRyb810WxRPSaF7+DhtrKQdm9rcPsI9+ZGjifIRpR3ozf0//iKh+wrQD7gedz8uy5px3mS+qqUFFDortLBFyS/9v/pUJjxXuKUaX1RJNop+rSh6ZSapm/lziz1z886kmVSh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZB+eZ7net1nxsQrIN+hCcvUV5T/AOQBeHqB4CpolNV0=;
 b=z3IlEImSMCAvrwM1Zvnj3blD2RR+6RlT7arrZ2Y+r+FhJ8/5qDz9lNdybVNgqTwgRhZ/HIyHfhNo64la7XKXnfAgrGifd987FJ4FUkxrFtnHpOmUWo7J3x8BlsvkU7dwMo175TIyUjoHpHyimTbZX7pDceMnkwFkylGh01GA5Oo=
Received: from SN7PR04CA0227.namprd04.prod.outlook.com (2603:10b6:806:127::22)
 by DM4PR12MB6181.namprd12.prod.outlook.com (2603:10b6:8:a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:27:36 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:127:cafe::70) by SN7PR04CA0227.outlook.office365.com
 (2603:10b6:806:127::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.8 via Frontend Transport; Wed, 26
 Aug 2026 23:27:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:27:35 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:27:30 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 35/59] drm/amd/display: Test CRTC memory domain change
 detection
Date: Wed, 26 Aug 2026 17:05:06 -0600
Message-ID: <20260826231519.881949-36-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DM4PR12MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd84d29-13a4-4f53-baa0-08df03c99c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: wpsJ7zSbeev+EDV9dcYoIJoii1dJmVCueL2/OxYaxCpqTbJNejSlZqH1TCqsGbhZYq1SznjtETD1Q3Eo1O6sNHSdcRtRpjEo0UBHvuguYuvsUZta0XFCxFsu4+Kh0UqjtJoFIZpA5ISMHgnczN8VxRMyIUCvMNakFl/m6ue0wGC3zd+Le3fA7f9n2lZZcsxWA8TLggGBQ9mXqSLJN88j9con01bKeFzRR30askd8jKF17tBU7WCpeC36228tZXwez3795ngnq5IABXH4CKo2gt21DiO0+rWFK2IykzyAgEYYk5BAdV5WVvHBZz/CBKRSva0PQ14I6NS4iRe1J74l7G26l9KQ68g3g13yhr+6ELLV5WABVSbsOAfmS0BwSwR6bQ9wjSqUPTbsg8tXtflGEff7jvpfoue6WHppNkRQ3wLzNy94MJq27ubvp3hW7VwbIgr2bgL7ZZMG5MoGl1cjxXOuGDOfjInnkeoYhXzmdZsKMgeE9g4KHpIwuR8WyUd8qFnj6BBGI7+O44HA9sMTE+75z1f9RhQzpNrtsNyhJQFjvAbqkPhRwWxMQBvtmgWeZuQpAIBoSsCoDxQ8506pZ4g5pNUgXkl/n0C/gD2VSiXzs7rFjs7UpqHqREft1ZWDHwVTywUbdzBHJRdmKCM8UxA7J2TWvlpaDx9H2FmoXe5/q3MvkXd8gBOx6L96x4JcA2qHpn76y/jFcCvlpCgD/w==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EDrPcu+Ih2dGyqO6P+ell7FiNO5abesHgB9Xx6oo6ypU01apnwEoEr2aQTE39oFH9AMXwQ4bCAC5G4XM/qNK1v2+p0cHznX9jRJ10wAQOK7EawtQUx0Ch4Bd4b0Xi8ONeqq22L+ak+abYgZxXnxveLYNlwuD7q/2xj5WZq9br1f9YuCBqVU5EgHAn4S7J7ULj5YOrs9JfgvCkQuY6b+ondS2VSvOwHCPTD2gcMr+RbaH1ibfgGTFZuQ0wQISKNpjCKCITS4zlfrpLdlorsL2+gNo4AE3MkI1cM7v6xVYyF3XKHKC/F1fojB63l+hUQL1HFfD2lCwFNxybt0X8JNUQRFHCvlcZoXxN6EO0HrKUZtffRgFP4Gp3PsQBSwGOwAuRwmqW4RMszjRGQ5tITc+nqhIQ1a9Mz4Is9H4HKeP2KUczlPRQ2RNE7NyeR6qh5tl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:27:35.6076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd84d29-13a4-4f53-baa0-08df03c99c63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6181
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
Add KUnit tests for amdgpu_dm_crtc_mem_type_changed() covering an empty
plane mask, a plane missing one of its states, framebuffers in the same
memory domain, and a framebuffer migrated between domains.

[HOW]
Back the framebuffers with fake buffer objects carrying a TTM resource, so
get_mem_type() resolves a memory domain without a live TTM device.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   7 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 138 ++++++++++++++++++
 3 files changed, 145 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4650b5f09c08..70f50fa17366 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6044,9 +6044,9 @@ STATIC_IFN_KUNIT int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(add_affected_mst_dsc_crtcs);
 
-static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
-					    struct drm_atomic_commit *state,
-					    struct drm_crtc_state *crtc_state)
+STATIC_IFN_KUNIT bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
+						      struct drm_atomic_commit *state,
+						      struct drm_crtc_state *crtc_state)
 {
 	struct drm_plane *plane;
 	struct drm_plane_state *new_plane_state, *old_plane_state;
@@ -6065,6 +6065,7 @@ static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 
 	return false;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_crtc_mem_type_changed);
 
 /**
  * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c22266f534e3..ca19977cf788 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1186,6 +1186,9 @@ void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *acrtc,
 					 bool pflip_update, bool cursor_update);
 int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
 			       struct drm_crtc *crtc);
+bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
+				     struct drm_atomic_commit *state,
+				     struct drm_crtc_state *crtc_state);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
 int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
 				const enum surface_pixel_format format,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 845638fed223..0c57b3cc47fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1804,6 +1804,139 @@ static void dm_test_update_pflip_irq_state_dce(struct kunit *test)
 			(int)AMDGPU_IRQ_STATE_DISABLE);
 }
 
+/* Tests for amdgpu_dm_crtc_mem_type_changed() */
+
+struct dm_test_mem_type_ctx {
+	struct amdgpu_device *adev;
+	struct drm_atomic_commit *state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_plane *plane;
+	struct drm_plane_state *old_plane_state;
+	struct drm_plane_state *new_plane_state;
+};
+
+/*
+ * Register a single plane on the CRTC's plane mask. get_mem_type() walks
+ * fb->obj[0] back to an amdgpu_bo, so the framebuffers are backed by fake
+ * buffer objects with a TTM resource instead of a live TTM device.
+ */
+static struct drm_framebuffer *dm_test_alloc_fb(struct kunit *test,
+						u32 mem_type)
+{
+	struct drm_framebuffer *fb;
+	struct ttm_resource *res;
+	struct amdgpu_bo *abo;
+
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+	abo = kunit_kzalloc(test, sizeof(*abo), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, abo);
+	res = kunit_kzalloc(test, sizeof(*res), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, res);
+
+	res->mem_type = mem_type;
+	abo->tbo.resource = res;
+	fb->obj[0] = &abo->tbo.base;
+
+	return fb;
+}
+
+static struct dm_test_mem_type_ctx *dm_test_mem_type_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_mem_type_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->adev = dm_kunit_alloc_adev(test);
+	ctx->state = dm_test_alloc_commit(test, ctx->adev);
+	ctx->crtc_state = kunit_kzalloc(test, sizeof(*ctx->crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_state);
+	ctx->plane = drm_kunit_helper_create_primary_plane(test, &ctx->adev->ddev,
+							   NULL, NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->plane);
+	ctx->old_plane_state = kunit_kzalloc(test, sizeof(*ctx->old_plane_state),
+					     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->old_plane_state);
+	ctx->new_plane_state = kunit_kzalloc(test, sizeof(*ctx->new_plane_state),
+					     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->new_plane_state);
+	ctx->state->planes = kunit_kcalloc(test, ctx->plane->index + 1,
+					   sizeof(*ctx->state->planes), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state->planes);
+
+	ctx->crtc_state->plane_mask = drm_plane_mask(ctx->plane);
+	ctx->state->planes[ctx->plane->index].ptr = ctx->plane;
+
+	return ctx;
+}
+
+/**
+ * dm_test_mem_type_changed_no_planes - Test an empty plane mask reports no change
+ * @test: The KUnit test context
+ */
+static void dm_test_mem_type_changed_no_planes(struct kunit *test)
+{
+	struct dm_test_mem_type_ctx *ctx = dm_test_mem_type_ctx_alloc(test);
+
+	ctx->crtc_state->plane_mask = 0;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_crtc_mem_type_changed(&ctx->adev->ddev,
+								ctx->state,
+								ctx->crtc_state));
+}
+
+/**
+ * dm_test_mem_type_changed_missing_state - Test a plane without both states is skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_mem_type_changed_missing_state(struct kunit *test)
+{
+	struct dm_test_mem_type_ctx *ctx = dm_test_mem_type_ctx_alloc(test);
+
+	ctx->state->planes[ctx->plane->index].new_state = ctx->new_plane_state;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_crtc_mem_type_changed(&ctx->adev->ddev,
+								ctx->state,
+								ctx->crtc_state));
+}
+
+/**
+ * dm_test_mem_type_changed_same_domain - Test identical memory domains report no change
+ * @test: The KUnit test context
+ */
+static void dm_test_mem_type_changed_same_domain(struct kunit *test)
+{
+	struct dm_test_mem_type_ctx *ctx = dm_test_mem_type_ctx_alloc(test);
+
+	ctx->old_plane_state->fb = dm_test_alloc_fb(test, TTM_PL_VRAM);
+	ctx->new_plane_state->fb = dm_test_alloc_fb(test, TTM_PL_VRAM);
+	ctx->state->planes[ctx->plane->index].old_state = ctx->old_plane_state;
+	ctx->state->planes[ctx->plane->index].new_state = ctx->new_plane_state;
+
+	KUNIT_EXPECT_FALSE(test, amdgpu_dm_crtc_mem_type_changed(&ctx->adev->ddev,
+								ctx->state,
+								ctx->crtc_state));
+}
+
+/**
+ * dm_test_mem_type_changed_different_domain - Test a domain migration is detected
+ * @test: The KUnit test context
+ */
+static void dm_test_mem_type_changed_different_domain(struct kunit *test)
+{
+	struct dm_test_mem_type_ctx *ctx = dm_test_mem_type_ctx_alloc(test);
+
+	ctx->old_plane_state->fb = dm_test_alloc_fb(test, TTM_PL_TT);
+	ctx->new_plane_state->fb = dm_test_alloc_fb(test, TTM_PL_VRAM);
+	ctx->state->planes[ctx->plane->index].old_state = ctx->old_plane_state;
+	ctx->state->planes[ctx->plane->index].new_state = ctx->new_plane_state;
+
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_crtc_mem_type_changed(&ctx->adev->ddev,
+							       ctx->state,
+							       ctx->crtc_state));
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -1900,6 +2033,11 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	/* dm_update_pflip_irq_state */
 	KUNIT_CASE(dm_test_update_pflip_irq_state_dcn),
 	KUNIT_CASE(dm_test_update_pflip_irq_state_dce),
+	/* amdgpu_dm_crtc_mem_type_changed */
+	KUNIT_CASE(dm_test_mem_type_changed_no_planes),
+	KUNIT_CASE(dm_test_mem_type_changed_missing_state),
+	KUNIT_CASE(dm_test_mem_type_changed_same_domain),
+	KUNIT_CASE(dm_test_mem_type_changed_different_domain),
 	{}
 };
 
-- 
2.43.0

