Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EADE6C61DBE
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:28:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4793F10EE56;
	Wed, 26 Aug 2026 23:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vGA/YKqR";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011047.outbound.protection.outlook.com [52.101.62.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA1D610EE56
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:28:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URR9lL3vZjulJab5EKbJjHTKEeMpVA4ECe7Uwt5B6p1c8RukzGwxjZ+dUA7QH6b4eE4RBljPuY4p6QXVj3kSZjPaigr/kpU1xNoQDTuo45gxOBgGf97CyPFFCbX+thrFNDrvyzpLdxcivbd1dCRsR8ZQjhi8qBK1uxXleKlTnd1ACv/XroL66KJc+2K1oOwLQiMQrcLxzqdniqtnRwUmIHe/frcxU3nd02GIUbtYMjJP/G7fpfcCGSrF6lyzb/jd+BHazlQZEYo0Su+kn4hceihuekMg3DKu1HeL18OwB/bYkinYJwJM90a/gACmuEYvn7fyQFvNbygcUaeSCx9RPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVa+/71oiHqVlHoERwaXrfk4dh2lLVJQ5T1esrLHdE8=;
 b=eFEgLo/3eAbv2uze0UgpJSIL2Uu4a0OfREezywHVezIDiFgsozemAA2aryUQdBFrOTMdITC5+nId1GUFlTfunUD6Y8m4fMsVjjHz2MBZTqtFlAHJC8TU5AmHKqs0eMa4vY0UZnEb00vm5N6ztdajv1VYusUb+W1ZorGx5uVDfhLz04X5Rdsc733bqEtXPe7t5tohYVZpI+nU5Rb3qfEKWAKyzqSCJvPe8TcN2ZBf8JpOLiMohFyTbQWukRbV5O544cAK2wQcZlOSKrNyggR8zd1MmjVxkGq9dS5AE4KV1GmflrN5bRg/wn44b+95SsAagJLwbNLE7yqpSLXEE4zJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVa+/71oiHqVlHoERwaXrfk4dh2lLVJQ5T1esrLHdE8=;
 b=vGA/YKqR/bxfTX5YkMEEFi8kgAQZUJVjfzJey9rCmUsERu5L5+FAWzIAPQAz9E73dm2RcsfQ4Zny1nVcoVm76mHE2tzdECzjzCImwNUaiO3RYw6gwKQX5/lfv9PK1HriAcEDrIs526hczRCd438d1GJ88hsMF8T5YRbkcyJiC0o=
Received: from SN7PR18CA0028.namprd18.prod.outlook.com (2603:10b6:806:f3::11)
 by IA0PR12MB7529.namprd12.prod.outlook.com (2603:10b6:208:431::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Wed, 26 Aug
 2026 23:28:14 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:f3:cafe::90) by SN7PR18CA0028.outlook.office365.com
 (2603:10b6:806:f3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.7 via Frontend Transport; Wed, 26
 Aug 2026 23:28:13 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:28:13 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:28:06 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 37/59] drm/amd/display: Test plane reset decision
Date: Wed, 26 Aug 2026 17:05:08 -0600
Message-ID: <20260826231519.881949-38-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|IA0PR12MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 208517e2-ec51-462a-5d47-08df03c9b31c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nw5zsuIfJTAnnh+NiVI7DGJO5xrF+q4pw18Y2ysWy8ulE773HlrXKUDTvRD993tmU3yTLHYoe8k9y/7Y4r3ehh0cQJQh0A8cYQI6F2VWk3SpBfjAZSsdmutMMVkhUghm6b3VWW2I2TI6HDsvc7Wcnbwku3YyP9xSNXQMPmAB+QK5iLNFSUF16lG0yCd7dw8tDWit7uMzop91bFBlVMig5X5QPlnQ7dKx8fY6zGwaFI0qkZJ4xBO/x7ZJXvzRPyP74nxYJqnjHz8Zd3fQdDIMtURCYT76rF0BAZ9dDA1Q8rLX6m3bPGitRkRcJ/zFK/fAm531x1TN1hnrUsVm6RFWynf6BjYudKwLTst//czB7UJc7hvHRqYBl9iae64JISgdYj60Yk4EDNPWgVZVQ3jrSxfowl6bByvSgRn+MBOHzpBsbAhSog2h9Kxwk1Wa3lwlhePTBhGvAf81KhhGtsNRQtR6KjYYIxZogJwqY3Q3M/YhP9icTFXIvksxVkyva3614P4BfgTS4kdp0rX0pUlKh+ybKujzy9TJiVeQSJ7E8Xo1+gTm1eyjuheGS2kCfewBarLWM0VceKPqkPNg9e/+QgZJffkGi6BEBafISXAcT8O1GXF3shXM2k+nssrxF0GgCW5dm7f7qgwH+3v+I0jEe+MZpILnEmAY31sxpmtoxt+wGq+3514I/mAO8uLUSTkQFQ1OX2m1OSKzt796uayhGA==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6ABYLx8I0r5zGhPSZ2K+ZJBiRenlClnIERMkWnqF8+TpZiQ7SecLmvSe5tP3I9drrSAa4evV28v4wWSNfE+AF2yoGk0XBsN2QdwVHkWYxDLlZzfurYoHSvjcKxTzdDbvEQcwrt31cEUqVFBdkNlR/5qLNRn7EFUBwCEui+6uYLv9kEDNczNJxpwR/g3gzhUKWjricFe3gE8atBbh7tjT9mvUHSBmU32Iz4UmT3t8l91D3Bo3X07V1bIuNc9vt2DZ1p3X3/0OpYKe7DuqsF+YLU/Ex6TiC46n78BhpcfmcpxsjBASJzAAqzujFVwHAP7PrHSb7fIYkiNNxlDk1dRspuxQe2HwQbhH5zcrsiAt1h+ieYB9jROZx9uhgbRthhp7mVo2Z9uxzHGpTDZ3bOsmzAfodfOyXASGzNZGH08azIyIhyhqfEAiBUXwfCgrK7UN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:28:13.6972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 208517e2-ec51-462a-5d47-08df03c9b31c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7529
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
Add KUnit tests for should_reset_plane() covering the pre-DCN3.2 modeset
hack, a writeback commit, a plane moved between CRTCs, a plane outside the
context, a missing new CRTC state, a cursor mode switch, color management,
z-order, modeset, and the fast update baseline.

Also cover the cross-plane loop: cursor planes and planes on other CRTCs
are skipped, while a moved plane, source or destination size, rotation,
blend mode, alpha, colorspace, transfer function, pixel format and
modifier changes each force a reset, and a plane missing one framebuffer
is skipped.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 509 ++++++++++++++++++
 3 files changed, 518 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 17425791e0ee..8db18d7cf49f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5632,10 +5632,10 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	return ret;
 }
 
-static bool should_reset_plane(struct drm_atomic_commit *state,
-			       struct drm_plane *plane,
-			       struct drm_plane_state *old_plane_state,
-			       struct drm_plane_state *new_plane_state)
+STATIC_IFN_KUNIT bool should_reset_plane(struct drm_atomic_commit *state,
+					 struct drm_plane *plane,
+					 struct drm_plane_state *old_plane_state,
+					 struct drm_plane_state *new_plane_state)
 {
 	struct drm_plane *other;
 	struct drm_plane_state *old_other_state, *new_other_state;
@@ -5795,6 +5795,7 @@ static bool should_reset_plane(struct drm_atomic_commit *state,
 
 	return false;
 }
+EXPORT_IF_KUNIT(should_reset_plane);
 
 static int dm_update_plane_state(struct dc *dc,
 				 struct drm_atomic_commit *state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2e3ad13b773a..0151913336b7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1192,6 +1192,10 @@ void dm_arm_vblank_event(struct amdgpu_crtc *acrtc,
 void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *acrtc,
 					 struct dm_crtc_state *acrtc_state,
 					 bool pflip_update, bool cursor_update);
+bool should_reset_plane(struct drm_atomic_commit *state,
+			struct drm_plane *plane,
+			struct drm_plane_state *old_plane_state,
+			struct drm_plane_state *new_plane_state);
 int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
 			       struct drm_crtc *crtc);
 bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index f5f2b063b355..799cd3867a77 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -2274,6 +2274,491 @@ static void dm_test_dirty_rects_mpo_overflow_ffu(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ctx->flip_addrs->dirty_rects[0].width, 1920);
 }
 
+/* Tests for should_reset_plane() */
+
+struct dm_test_reset_plane_ctx {
+	struct amdgpu_device *adev;
+	struct drm_atomic_commit *state;
+	struct drm_crtc *crtc;
+	struct drm_plane *plane;
+	struct drm_plane_state *old_plane_state;
+	struct drm_plane_state *new_plane_state;
+	struct dm_crtc_state *old_crtc_state;
+	struct dm_crtc_state *new_crtc_state;
+	struct drm_plane *other;
+	struct dm_plane_state *other_old;
+	struct dm_plane_state *other_new;
+};
+
+/*
+ * Build a fast-update baseline: a DCN 3.2 device with one plane bound to an
+ * unchanged CRTC, so should_reset_plane() runs to the end and returns false.
+ */
+static struct dm_test_reset_plane_ctx *
+dm_test_reset_plane_ctx_alloc(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->adev = dm_kunit_alloc_adev(test);
+	ctx->adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 2, 0);
+	ctx->adev->reset_domain = kunit_kzalloc(test,
+						sizeof(*ctx->adev->reset_domain),
+						GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->adev->reset_domain);
+
+	ctx->state = dm_test_alloc_commit(test, ctx->adev);
+	ctx->crtc = kunit_kzalloc(test, sizeof(*ctx->crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->crtc);
+	ctx->plane = kunit_kzalloc(test, sizeof(*ctx->plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->plane);
+	ctx->old_plane_state = kunit_kzalloc(test, sizeof(*ctx->old_plane_state),
+					     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->old_plane_state);
+	ctx->new_plane_state = kunit_kzalloc(test, sizeof(*ctx->new_plane_state),
+					     GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->new_plane_state);
+	ctx->old_crtc_state = kunit_kzalloc(test, sizeof(*ctx->old_crtc_state),
+					    GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->old_crtc_state);
+	ctx->new_crtc_state = kunit_kzalloc(test, sizeof(*ctx->new_crtc_state),
+					    GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->new_crtc_state);
+	ctx->state->crtcs = kunit_kzalloc(test, sizeof(*ctx->state->crtcs),
+					  GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state->crtcs);
+
+	ctx->plane->dev = &ctx->adev->ddev;
+	ctx->plane->type = DRM_PLANE_TYPE_PRIMARY;
+	ctx->old_plane_state->crtc = ctx->crtc;
+	ctx->new_plane_state->crtc = ctx->crtc;
+	ctx->state->crtcs[0].ptr = ctx->crtc;
+	ctx->state->crtcs[0].old_state = &ctx->old_crtc_state->base;
+	ctx->state->crtcs[0].new_state = &ctx->new_crtc_state->base;
+
+	return ctx;
+}
+
+static bool dm_test_should_reset_plane(struct dm_test_reset_plane_ctx *ctx)
+{
+	return should_reset_plane(ctx->state, ctx->plane, ctx->old_plane_state,
+				  ctx->new_plane_state);
+}
+
+/**
+ * dm_test_reset_plane_pre_dcn32_modeset - Test pre-DCN3.2 modesets always reset
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_pre_dcn32_modeset(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	ctx->adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 1, 2);
+	ctx->state->allow_modeset = true;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/*
+ * Add a connector of @type to the commit so should_reset_plane() walks its
+ * writeback check.
+ */
+static struct drm_connector_state *
+dm_test_reset_plane_add_connector(struct kunit *test,
+				  struct dm_test_reset_plane_ctx *ctx, int type)
+{
+	struct drm_connector_state *conn_state;
+	struct drm_connector *connector;
+
+	connector = kunit_kzalloc(test, sizeof(*connector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, connector);
+	conn_state = kunit_kzalloc(test, sizeof(*conn_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state);
+	ctx->state->connectors = kunit_kzalloc(test,
+					       sizeof(*ctx->state->connectors),
+					       GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state->connectors);
+
+	connector->connector_type = type;
+	ctx->state->num_connector = 1;
+	ctx->state->connectors[0].ptr = connector;
+	ctx->state->connectors[0].new_state = conn_state;
+
+	return conn_state;
+}
+
+/**
+ * dm_test_reset_plane_writeback_job - Test a writeback commit resets planes
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_writeback_job(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+	struct drm_connector_state *conn_state;
+
+	conn_state = dm_test_reset_plane_add_connector(test, ctx,
+						       DRM_MODE_CONNECTOR_WRITEBACK);
+	conn_state->writeback_job = kunit_kzalloc(test,
+						  sizeof(*conn_state->writeback_job),
+						  GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, conn_state->writeback_job);
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_crtc_changed - Test moving a plane between CRTCs resets it
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_crtc_changed(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	ctx->old_plane_state->crtc = NULL;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_not_in_context - Test a plane outside the context is not reset
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_not_in_context(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	ctx->old_plane_state->crtc = NULL;
+	ctx->new_plane_state->crtc = NULL;
+
+	KUNIT_EXPECT_FALSE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_no_new_crtc_state - Test a missing new CRTC state resets the plane
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_no_new_crtc_state(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	ctx->state->crtcs[0].new_state = NULL;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_cursor_mode_changed - Test a cursor mode switch resets the plane
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_cursor_mode_changed(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	ctx->plane->type = DRM_PLANE_TYPE_CURSOR;
+	ctx->old_crtc_state->cursor_mode = DM_CURSOR_NATIVE_MODE;
+	ctx->new_crtc_state->cursor_mode = DM_CURSOR_OVERLAY_MODE;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_color_mgmt_changed - Test a degamma change resets the plane
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_color_mgmt_changed(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	ctx->new_crtc_state->base.color_mgmt_changed = true;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_zpos_changed - Test a z-order change resets the plane
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_zpos_changed(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	ctx->old_plane_state->normalized_zpos = 0;
+	ctx->new_plane_state->normalized_zpos = 1;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_modeset - Test a CRTC modeset resets the plane
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_modeset(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	ctx->new_crtc_state->base.mode_changed = true;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_fast_update - Test an unchanged plane stays on the fast path
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_fast_update(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	KUNIT_EXPECT_FALSE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_skips_non_writeback - Test non-writeback connectors are skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_skips_non_writeback(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_connector(test, ctx,
+					  DRM_MODE_CONNECTOR_DisplayPort);
+
+	KUNIT_EXPECT_FALSE(test, dm_test_should_reset_plane(ctx));
+}
+
+/*
+ * Add a second plane to the commit so should_reset_plane() walks its
+ * cross-plane loop. Both states start identical and bound to the same CRTC, so
+ * each test only has to perturb the one field it cares about.
+ */
+static void dm_test_reset_plane_add_other(struct kunit *test,
+					  struct dm_test_reset_plane_ctx *ctx)
+{
+	ctx->other = kunit_kzalloc(test, sizeof(*ctx->other), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->other);
+	ctx->other_old = kunit_kzalloc(test, sizeof(*ctx->other_old), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->other_old);
+	ctx->other_new = kunit_kzalloc(test, sizeof(*ctx->other_new), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->other_new);
+	ctx->state->planes = kunit_kzalloc(test, sizeof(*ctx->state->planes),
+					   GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->state->planes);
+
+	ctx->other->type = DRM_PLANE_TYPE_PRIMARY;
+	ctx->other_old->base.crtc = ctx->crtc;
+	ctx->other_new->base.crtc = ctx->crtc;
+
+	ctx->adev->ddev.mode_config.num_total_plane = 1;
+	ctx->state->planes[0].ptr = ctx->other;
+	ctx->state->planes[0].old_state = &ctx->other_old->base;
+	ctx->state->planes[0].new_state = &ctx->other_new->base;
+}
+
+/**
+ * dm_test_reset_plane_other_cursor_skipped - Test other cursor planes are ignored
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_cursor_skipped(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_other(test, ctx);
+	ctx->other->type = DRM_PLANE_TYPE_CURSOR;
+	ctx->other_new->base.rotation = DRM_MODE_ROTATE_90;
+
+	KUNIT_EXPECT_FALSE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_other_crtc_skipped - Test planes on other CRTCs are ignored
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_crtc_skipped(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_other(test, ctx);
+	ctx->other_old->base.crtc = NULL;
+	ctx->other_new->base.crtc = NULL;
+	ctx->other_new->base.rotation = DRM_MODE_ROTATE_90;
+
+	KUNIT_EXPECT_FALSE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_other_crtc_moved - Test moving another plane forces a reset
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_crtc_moved(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_other(test, ctx);
+	ctx->other_old->base.crtc = NULL;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_other_scaling - Test src/dst size changes force a reset
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_scaling(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_other(test, ctx);
+	ctx->other_new->base.src_w = 1 << 16;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_other_rotation - Test rotation changes force a reset
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_rotation(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_other(test, ctx);
+	ctx->other_new->base.rotation = DRM_MODE_ROTATE_180;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_other_blending - Test blend mode changes force a reset
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_blending(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_other(test, ctx);
+	ctx->other_new->base.pixel_blend_mode = DRM_MODE_BLEND_COVERAGE;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_other_alpha - Test alpha changes force a reset
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_alpha(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_other(test, ctx);
+	ctx->other_new->base.alpha = DRM_BLEND_ALPHA_OPAQUE;
+	ctx->other_old->base.alpha = DRM_BLEND_ALPHA_OPAQUE / 2;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_other_colorspace - Test colorspace changes force a reset
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_colorspace(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_other(test, ctx);
+	ctx->other_new->base.color_encoding = DRM_COLOR_YCBCR_BT2020;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_other_hdr_mult - Test transfer function changes force a reset
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_hdr_mult(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_other(test, ctx);
+	ctx->other_new->hdr_mult = 1;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_other_no_fb - Test planes without framebuffers are skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_no_fb(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_other(test, ctx);
+	ctx->other_new->base.fb = kunit_kzalloc(test,
+						sizeof(*ctx->other_new->base.fb),
+						GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->other_new->base.fb);
+
+	KUNIT_EXPECT_FALSE(test, dm_test_should_reset_plane(ctx));
+}
+
+/*
+ * Give the second plane a matching pair of framebuffers. should_reset_plane()
+ * casts them to amdgpu_framebuffer, so both are allocated as such.
+ */
+static void dm_test_reset_plane_add_other_fbs(struct kunit *test,
+					      struct dm_test_reset_plane_ctx *ctx)
+{
+	struct amdgpu_framebuffer *old_afb, *new_afb;
+	struct drm_format_info *format;
+
+	format = kunit_kzalloc(test, sizeof(*format), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, format);
+	old_afb = kunit_kzalloc(test, sizeof(*old_afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_afb);
+	new_afb = kunit_kzalloc(test, sizeof(*new_afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_afb);
+
+	old_afb->base.format = format;
+	new_afb->base.format = format;
+	ctx->other_old->base.fb = &old_afb->base;
+	ctx->other_new->base.fb = &new_afb->base;
+}
+
+/**
+ * dm_test_reset_plane_other_format - Test pixel format changes force a reset
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_format(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+	struct drm_format_info *new_format;
+
+	dm_test_reset_plane_add_other(test, ctx);
+	dm_test_reset_plane_add_other_fbs(test, ctx);
+	new_format = kunit_kzalloc(test, sizeof(*new_format), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_format);
+	ctx->other_new->base.fb->format = new_format;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
+/**
+ * dm_test_reset_plane_other_modifier - Test tiling/DCC changes force a reset
+ * @test: The KUnit test context
+ */
+static void dm_test_reset_plane_other_modifier(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+
+	dm_test_reset_plane_add_other(test, ctx);
+	dm_test_reset_plane_add_other_fbs(test, ctx);
+	ctx->other_new->base.fb->modifier = 1;
+
+	KUNIT_EXPECT_TRUE(test, dm_test_should_reset_plane(ctx));
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -2387,6 +2872,30 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_dirty_rects_psr_su_ffu),
 	KUNIT_CASE(dm_test_dirty_rects_mpo_clips),
 	KUNIT_CASE(dm_test_dirty_rects_mpo_overflow_ffu),
+	/* should_reset_plane */
+	KUNIT_CASE(dm_test_reset_plane_pre_dcn32_modeset),
+	KUNIT_CASE(dm_test_reset_plane_writeback_job),
+	KUNIT_CASE(dm_test_reset_plane_crtc_changed),
+	KUNIT_CASE(dm_test_reset_plane_not_in_context),
+	KUNIT_CASE(dm_test_reset_plane_no_new_crtc_state),
+	KUNIT_CASE(dm_test_reset_plane_cursor_mode_changed),
+	KUNIT_CASE(dm_test_reset_plane_color_mgmt_changed),
+	KUNIT_CASE(dm_test_reset_plane_zpos_changed),
+	KUNIT_CASE(dm_test_reset_plane_modeset),
+	KUNIT_CASE(dm_test_reset_plane_fast_update),
+	KUNIT_CASE(dm_test_reset_plane_skips_non_writeback),
+	KUNIT_CASE(dm_test_reset_plane_other_cursor_skipped),
+	KUNIT_CASE(dm_test_reset_plane_other_crtc_skipped),
+	KUNIT_CASE(dm_test_reset_plane_other_crtc_moved),
+	KUNIT_CASE(dm_test_reset_plane_other_scaling),
+	KUNIT_CASE(dm_test_reset_plane_other_rotation),
+	KUNIT_CASE(dm_test_reset_plane_other_blending),
+	KUNIT_CASE(dm_test_reset_plane_other_alpha),
+	KUNIT_CASE(dm_test_reset_plane_other_colorspace),
+	KUNIT_CASE(dm_test_reset_plane_other_hdr_mult),
+	KUNIT_CASE(dm_test_reset_plane_other_no_fb),
+	KUNIT_CASE(dm_test_reset_plane_other_format),
+	KUNIT_CASE(dm_test_reset_plane_other_modifier),
 	{}
 };
 
-- 
2.43.0

