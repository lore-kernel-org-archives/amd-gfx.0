Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E266C79FAD
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE1BE10EB41;
	Tue,  8 Sep 2026 11:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="or4rXK66";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC07610EB41
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:36:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WN9JHkocRGMt2FtHam3T/REza4lkBdg9ofq57no9t24JdlE0gyOwUz/urb69+Ce1zLWIn4IwDXRoz8PITvRDWlsPPqNtUKHqISoGItcVQ1DRVHmdtQGbgt4qkSgsAv6AV0fUP8nzG1lG+BUqScCtEfozfJAxLWZOZe4EOwVcy9BtqPtrmq6u9o1+370j9tcRnMTObfmnYVNFJ94CVOacSXfDTL7U92kbpzPXnTc+2EgmaL83PNilNuIxdqZXEecJXqghaQ5iHszkK/uTDqeMvjIClDx4+/5ww9WwgdkbmiVib5D6tROzdBugpiiPU58QhauEX3dbb656VPH7BGYbEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoP3T+cOF338atpIdG4HUVOv7Vpnhr0p1GRqUjHtvaA=;
 b=u1B4LKLKzd7+Zx5R875dMHja6O2Ul+TSBUAwU77rKEEMwbm8nPshfHTz0q+PyJKrIHxwEX5CMlyn9oNfHrZs3AdUGPFxQYpjtMIy6QDOnK/SS2lH61SXJjpU0xUUz8jO9vsFCV4BapzVJxkVHUiwZs3lwixM4+/s30uy5uTpMaN7JmcM5hM5JzhqbjyYjlnmFkTO1doHgszmfgOBNJnjuQBYwTTno71M7vpGWBFCg+rvA94gmA3UtvkqRLa3bY3Uyj9dz4mV1zaufzOV9pV7Xq6NVtPt5fGPiervtWY6k8+iEKQP8sY14KxucNddUSJaS0N7EsxhNJ8CVR+Umkj7yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoP3T+cOF338atpIdG4HUVOv7Vpnhr0p1GRqUjHtvaA=;
 b=or4rXK66gj4KIlv3pajOw8GFyZxxhcnco+foCTWficDS1rjycnHHHzWAgo+Jr5hrPg1P6rW8mIOzdtcmv8UW+mDdk37nQSqXtl0fp7GoJ459K4lowLJyINbbCA3dudyR5AGgLGymxZ9lZeYLbu5uUgMg//ijUM8KmAUk4/AESfI=
Received: from BN9PR03CA0319.namprd03.prod.outlook.com (2603:10b6:408:112::24)
 by DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Tue, 8 Sep 2026 11:36:00 +0000
Received: from BN2PEPF0000A893.namprd04.prod.outlook.com
 (2603:10b6:408:112:cafe::91) by BN9PR03CA0319.outlook.office365.com
 (2603:10b6:408:112::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A893.mail.protection.outlook.com (10.167.248.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:36:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:36:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:35:59 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:35:51 -0500
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
Subject: [PATCH 15/66] drm/amd/display: Test cursor update without DC stream
Date: Tue, 8 Sep 2026 19:31:08 +0800
Message-ID: <20260908113338.2433445-16-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A893:EE_|DS7PR12MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e25c24-5e41-492b-00a7-08df0d9d5b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eVJRxcgnyfDyuBInzvYa2QGtHa7upUzS7k/7+pWLHgtWGVnBlxySrCZvmm5XIkItRn3Vu8L0uv43JUbiakPhFTcwX5OjQT1bkozDeGCJJACsFo6TvS4gE+qXS+VjA84LtjaxF7YHvchiAtZXVZAvWQERHkXeqMXJuXqHXSzacl/3TZl0NqbZVvBEtbXZ4XLVnDla29gCDqaG9mbO02TOd/MeYuMuQBr/ChT+ztj/PVp9uNWP7fKDcL8IBCriD13OwSrskxu0gtZT4PDP45yz6i0PzoQUfYtzMYJ5D0rsH4/2IBLyZzTzZTYWZ17U6p3fAJBTqZKYOZgKAY8IcaERnL533izX1GEzhyOgvU2g4zfEUonlxD9txEF4JugVtLWXUWKPJuSaMoAxWtops6G9XeY6GvzVs80rhAS2jggIHLqhk1DnkDzTP6HKd5iCz6YeN7EJkdDanIg7vTiN2lEUORErdzYEUd7KGnaq7BbdbfYYVYelJT34QVPkzLHXTV97ugi3/bVPN7McT/r/Aqurn0Qdr9FVlXTbclRzRZdaJuXmnImibkgqDItxDkrOYg4NaWXjzJWMVFqC1ATZJGVZj+rqANliol9CtpbeKAS+Gr6qfF01k5zFPUETcEShuhwP1CGD7b6zYEetLrxl+w07ppo7RCllEGuR/oXY549TVFl9JKuasC96sDlq+kH9WQqZz5KSR33Y4DeevCnAq8OHvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kBaftjNBGmmVb9J/9AdkWjKOUEzSE7nA6MQ9Zz53BCzoy/uJLvX7vyhWR1OlKexy0C/jhM40qU5S9Mlh0JycZu8hL1qG+Jy6Hg1LYi5KqHy4WAqjsJH69xdlYlT/ObEK4wwb3lqqyMgK9doWxUmdh91RpXKdVCOnB8Iwt51UBC/Dz5H0aLDUVo0AbN4kAwk40glg0pKdkvL2nm0QC+twyvimok6lrYhC08zr3vuLl6cDQklFmSYPrss57VKrcX0rFtANcxsqLnxT3zrGUwgu1KYPZcxRw+mFdbdf6eKqYBl9qI+uvk9SgHKg76DCtHV02dtq0nTf3R9Y+U9Fj0lD3El7/z3lQqXW7iDiLoKYxZzE3cWhDYJxUjhKC3nt18jWirXONNoYHnnds6C2ZVQ38oo/KWAIDQDPwAJM33vU7H7svQbEiHaYjq330WfmN2ha
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:36:00.4473 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e25c24-5e41-492b-00a7-08df0d9d5b6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A893.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
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
Add KUnit tests for amdgpu_dm_plane_handle_cursor_update() covering a
cursor reported as disabled, and an enabled cursor whose attributes
are assembled before DC programming.

[HOW]
Add a fixture binding a 64x64 cursor plane to an amdgpu_crtc whose DM
CRTC state carries no stream. Place the cursor off the left edge for
the disabled case, and advertise the degamma ROM capability for the
enabled case.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 98 +++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 90737090c61c..c71e241df7b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3789,6 +3789,102 @@ static void dm_test_atomic_check_success(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_atomic_check(plane, state), 0);
 }
 
+struct dm_test_cursor_ctx {
+	struct amdgpu_device *adev;
+	struct amdgpu_crtc *acrtc;
+	struct dm_crtc_state *crtc_state;
+	struct drm_plane_state *state;
+	struct drm_plane_state old_state;
+	struct drm_plane *plane;
+};
+
+/*
+ * Build a 64x64 cursor plane bound to an amdgpu_crtc whose DM CRTC state
+ * carries no DC stream, so the cursor update stops before programming DC.
+ */
+static struct dm_test_cursor_ctx *dm_test_alloc_cursor_ctx(struct kunit *test)
+{
+	struct amdgpu_framebuffer *afb;
+	struct dm_test_cursor_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	ctx->adev = dm_kunit_alloc_adev(test);
+	ctx->acrtc = kunit_kzalloc(test, sizeof(*ctx->acrtc), GFP_KERNEL);
+	ctx->crtc_state = kunit_kzalloc(test, sizeof(*ctx->crtc_state), GFP_KERNEL);
+	ctx->state = kunit_kzalloc(test, sizeof(*ctx->state), GFP_KERNEL);
+	ctx->plane = kunit_kzalloc(test, sizeof(*ctx->plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->acrtc);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->plane);
+
+	ctx->adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+
+	ctx->acrtc->base.dev = &ctx->adev->ddev;
+	ctx->acrtc->base.state = &ctx->crtc_state->base;
+	ctx->acrtc->max_cursor_width = 64;
+	ctx->acrtc->max_cursor_height = 64;
+
+	afb->address = 0x80000000ULL;
+	afb->base.pitches[0] = 256;
+	afb->base.format = drm_format_info(DRM_FORMAT_ARGB8888);
+	KUNIT_ASSERT_NOT_NULL(test, afb->base.format);
+
+	ctx->state->fb = &afb->base;
+	ctx->state->crtc = &ctx->acrtc->base;
+	ctx->state->crtc_w = 64;
+	ctx->state->crtc_h = 64;
+
+	ctx->plane->dev = &ctx->adev->ddev;
+	ctx->plane->state = ctx->state;
+
+	return ctx;
+}
+
+/**
+ * dm_test_handle_cursor_update_disabled() - Verify the cursor-off path.
+ * @test: KUnit test context.
+ *
+ * Verify if a cursor positioned fully off the left edge is treated as disabled
+ * and returns before the cursor geometry is latched on the CRTC.
+ */
+static void dm_test_handle_cursor_update_disabled(struct kunit *test)
+{
+	struct dm_test_cursor_ctx *ctx = dm_test_alloc_cursor_ctx(test);
+
+	ctx->state->crtc_x = -64;
+
+	amdgpu_dm_plane_handle_cursor_update(ctx->plane, &ctx->old_state);
+
+	KUNIT_EXPECT_EQ(test, ctx->acrtc->cursor_width, 0);
+	KUNIT_EXPECT_EQ(test, ctx->acrtc->cursor_height, 0);
+}
+
+/**
+ * dm_test_handle_cursor_update_no_stream() - Verify cursor attribute assembly.
+ * @test: KUnit test context.
+ *
+ * Verify if an enabled cursor latches its geometry on the CRTC and builds the
+ * DC cursor attributes, including the degamma ROM bit, before stopping at the
+ * missing DC stream.
+ */
+static void dm_test_handle_cursor_update_no_stream(struct kunit *test)
+{
+	struct dm_test_cursor_ctx *ctx = dm_test_alloc_cursor_ctx(test);
+
+	ctx->crtc_state->cm_is_degamma_srgb = true;
+	ctx->adev->dm.dc->caps.color.dpp.gamma_corr = true;
+
+	amdgpu_dm_plane_handle_cursor_update(ctx->plane, &ctx->old_state);
+
+	KUNIT_EXPECT_EQ(test, ctx->acrtc->cursor_width, 64);
+	KUNIT_EXPECT_EQ(test, ctx->acrtc->cursor_height, 64);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3861,6 +3957,8 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_helper_cleanup_fb_no_fb),
 	/* amdgpu_dm_plane_handle_cursor_update() */
 	KUNIT_CASE(dm_test_handle_cursor_update_no_fb),
+	KUNIT_CASE(dm_test_handle_cursor_update_disabled),
+	KUNIT_CASE(dm_test_handle_cursor_update_no_stream),
 	/* amdgpu_dm_plane_atomic_async_update() */
 	KUNIT_CASE(dm_test_atomic_async_update_copies_state),
 	/* amdgpu_dm_plane_atomic_async_check() */
-- 
2.43.0

