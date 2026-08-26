Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC10C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02DB410EE51;
	Wed, 26 Aug 2026 23:26:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eqChXCKJ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010057.outbound.protection.outlook.com [52.101.201.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF57C10EE51
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:26:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PqQF68wNdvosX/2V+Ej82rz+hKCn4Ry8yUVlO3wo11nl7iS07M2a37GVuixSqcH2cviSjxW9b3Tn32YLGpMKfouvvpSxY1K8InmmdKHMR6ktjYo14SZpurahNwl2DDB6YvOxfOzxTNIwP8HAQ6UHj0lLhArMZqgm+nDOYLj2p9+bCB0GcyVqKRF9Yw+8PmentWf5xvbtPXMMKBgwzA1kYrerQBtGzpdI5boesa+v/TiMR6rFtckrvlw4I1zfaQFGnETqc24S5nj+AbrxEXYecFonSc8+bw8QN47JxV9EYEP3NqtCfrQMGH1nzLpNenOcZ5PFkbEOGZe7gn05OS+E4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XTHBJcTMzAJuZO1t/lJeGVDpuey6EaBXpdHtN0XHAk=;
 b=LHd+/tKRlYxXnkbyvUIu0/FVXPfDMbaaXYac1p6LNCS1igQ1qhZsOFVdNeXiiKmd1R76J4RfJL7XigjUM637n3cdDneI1W6e3LQ19eegH7sxbARRP9skQ/kxodoGdFOO5K79hqGtZDiBo83Xnx+Avm33za3uFhWtJH2gb42tgyf+v4AsuCauSZ/HTeRo7wcv2NoHH1Dty0fLE1R+wYGmpJtO0PDUhWT+ocoS8qm26eWTKsQ8BY9waFOUVzYBVmuFh1wS2/xj/eMeOg3WNwGD0X6aULWpNV17ENtIaW2BqKV6GIkYmTiIBTRtujlb0kte7iByVklpBB1s80g6jgBFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XTHBJcTMzAJuZO1t/lJeGVDpuey6EaBXpdHtN0XHAk=;
 b=eqChXCKJOEq7t37/iYiVO+GyGAOHZ2iffqq4vZpXG0xA/4zUkiP2SzB9MXl63+077DoILzL3bBi/3m9gimtpNJtRe6aVlpY3Xlegi/EVD7GKD30oOhGOXFRrZuHv8cEBLJ/GPKSsz07fdPyJmXpWwhPrTOnxkDiTMlyoiIJHO7c=
Received: from PH7P220CA0115.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::32)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 23:26:30 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::30) by PH7P220CA0115.outlook.office365.com
 (2603:10b6:510:32d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:26:29 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:26:23 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 32/59] drm/amd/display: Test cursor commit
Date: Wed, 26 Aug 2026 17:05:03 -0600
Message-ID: <20260826231519.881949-33-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fdea50-aa98-4126-6d1c-08df03c97530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: xPDXlW67mYNILGV1fwz7YudqWTuBJmZnBvFeqbTcS8i6qaI3PW6CjxwMFsdn1lGtfKqhQxcmDOtbRLT5nFfZQZnJsr4O9SBO2BSXewoUercExw7f6Qm4cDnFRbZsMdFEjUk41cRmxGYNjHxH+s/8TSGj6RcyIsqsNUhzZUq8r3zAqmWV9uwkXfkrdusDn1q4LKN2tfjWxRJ+9tjoyCf9Xp/iPK3oUIfBNVAMR2sAzNYnc8QPKHpnDL/CxE2XdepXL7WO2GMPSYKC+yBYbgoXQGGzwxgfOobwNqFssAn71HfjKrYnlEXZy5UzSuiOM2I5+V8Zp5hfKVK+XOeIghY9nAhKyZKY2KiUfhLVynBxzmQ0mlqI+y96R7DR1YOlEip8vS9fy0EgfAIhWgiHFbdTEPmw/Y5TkvFdbW3cEvRlLdB8N1azWvcgDPMc66KmKFgKByudFKcU4V1saFHhrMWkNXVErV4WpdUlSNhV9cUiRwXXlD91M6cjVeZeU9Zvd6ArRUD7+j0OXaOxTYa61+9ZlcXMhJzBpq4vix701MpJi0JzPY9OmvsGfLYFtSWQ2XygEFU93L+9s52WC5oRSUnTZcSRUrsU8c5xX+OqHZ3+KYTVojiiALqN6akmfa8aOZFzxLiO+qW9deirJQl5XHLiaE8u7hY1Ta7A9Uz5THaKG/9LT4IEIWdL0kOMLRTfUehNBODbwiCvNWMeqbq+EIWi1Q==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0LiN9O6eRuQf0m7GyDG8jk2J+cZFc+yiv1IViF0zERyiBA61XblilikqNKq3E+3+HWuKKfalqyF/x0eewd7d93DrfC2avUTn0/Aw+r8kyJi4x5TBEnLj+2RFYeL+/+s4c/9TK/bGduq3uKE1eKEMcLsPGyvoydx9LS3LFo2R761hFQXTm60IJcOMXOfjXOzEZS1/uBsw65nYN9BWPmXcqJEvsGu10mIONX58jF8FGJyb4h3U6heD0gvR1M1F7WFlN74nibomn5yVOjo5b+Ee2xNG6XjlAr2IKa7fyWU3IwAWZZ4n/XYsEAQ85DoPNGVwXWVmyZS1nuLeoUoBZ9RsPCONjF30x5qHlj4ZScdYcTgAQoqlXqVaoyCKyb7k+Nvohv9D93xxVfYVZFql6Jjp7qLdBbLAqwjPkt3rAluiLvdW/tv713N2Qq+4+pggoJiq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:26:29.8113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fdea50-aa98-4126-6d1c-08df03c97530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
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
Add KUnit tests for amdgpu_dm_commit_cursors() covering an empty commit,
a non-cursor plane, and a cursor update, and for amdgpu_dm_update_cursor()
covering missing framebuffers and removal of an active stream cursor.

[HOW]
Reuse the single-plane commit fixture. The disable path uses the real
state-only DC cursor position setter without hardware programming.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6-Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  10 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   5 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 140 ++++++++++++++++++
 3 files changed, 151 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9d233b18f2df..08f2cc7fec68 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3587,7 +3587,7 @@ static void remove_stream(struct amdgpu_device *adev,
 	acrtc->enabled = false;
 }
 
-static void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state)
 {
 	struct drm_plane *plane;
 	struct drm_plane_state *old_plane_state;
@@ -3601,6 +3601,7 @@ static void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state)
 		if (plane->type == DRM_PLANE_TYPE_CURSOR)
 			amdgpu_dm_plane_handle_cursor_update(plane, old_plane_state);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_commit_cursors);
 
 static inline uint32_t get_mem_type(struct drm_framebuffer *fb)
 {
@@ -3609,9 +3610,9 @@ static inline uint32_t get_mem_type(struct drm_framebuffer *fb)
 	return abo->tbo.resource ? abo->tbo.resource->mem_type : 0;
 }
 
-static void amdgpu_dm_update_cursor(struct drm_plane *plane,
-				    struct drm_plane_state *old_plane_state,
-				    struct dc_stream_update *update)
+STATIC_IFN_KUNIT void amdgpu_dm_update_cursor(struct drm_plane *plane,
+					      struct drm_plane_state *old_plane_state,
+					      struct dc_stream_update *update)
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
@@ -3680,6 +3681,7 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
 		update->cursor_position = &crtc_state->stream->cursor_position;
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_update_cursor);
 
 static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
 					  struct amdgpu_crtc *acrtc_attach,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index a48154ea62ae..ed2341b387d9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -86,6 +86,7 @@ struct dc;
 struct amdgpu_bo;
 struct dmub_srv;
 struct dc_plane_state;
+struct dc_stream_update;
 struct dmub_notification;
 struct dmub_cmd_fused_request;
 
@@ -1171,6 +1172,10 @@ struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_commit *state)
 struct drm_private_state *dm_atomic_duplicate_state(struct drm_private_obj *obj);
 void dm_atomic_destroy_state(struct drm_private_obj *obj,
 			     struct drm_private_state *state);
+void amdgpu_dm_commit_cursors(struct drm_atomic_commit *state);
+void amdgpu_dm_update_cursor(struct drm_plane *plane,
+			     struct drm_plane_state *old_plane_state,
+			     struct dc_stream_update *update);
 int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
 			       struct drm_crtc *crtc);
 int dm_plane_layer_index_cmp(const void *a, const void *b);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 2afa73a07ebd..a2671ad90bfe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -1418,6 +1418,140 @@ static void dm_test_add_affected_mst_dsc_crtcs_disabled(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, add_affected_mst_dsc_crtcs(state, crtc), 0);
 }
 
+/* Tests for amdgpu_dm_commit_cursors() */
+
+/**
+ * dm_test_commit_cursors_no_planes - Test an empty plane set is a no-op
+ * @test: The KUnit test context
+ */
+static void dm_test_commit_cursors_no_planes(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	amdgpu_dm_commit_cursors(dm_test_alloc_commit(test, adev));
+}
+
+/*
+ * Build a commit holding a single plane of @type with empty old and new plane
+ * states.
+ */
+static struct drm_atomic_commit *
+dm_test_commit_with_plane(struct kunit *test, struct amdgpu_device *adev,
+			  enum drm_plane_type type)
+{
+	struct drm_atomic_commit *state = dm_test_alloc_commit(test, adev);
+	struct drm_plane_state *old_state, *new_state;
+	struct drm_plane *plane;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
+	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_state);
+	state->planes = kunit_kzalloc(test, sizeof(*state->planes), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state->planes);
+
+	plane->type = type;
+	plane->dev = &adev->ddev;
+	plane->state = new_state;
+	adev->ddev.mode_config.num_total_plane = 1;
+	state->planes[0].ptr = plane;
+	state->planes[0].old_state = old_state;
+
+	return state;
+}
+
+/**
+ * dm_test_commit_cursors_skips_non_cursor - Test non-cursor planes are skipped
+ * @test: The KUnit test context
+ */
+static void dm_test_commit_cursors_skips_non_cursor(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	amdgpu_dm_commit_cursors(dm_test_commit_with_plane(test, adev,
+							   DRM_PLANE_TYPE_PRIMARY));
+}
+
+/**
+ * dm_test_commit_cursors_updates_cursor - Test cursor planes reach the cursor update
+ * @test: The KUnit test context
+ */
+static void dm_test_commit_cursors_updates_cursor(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	amdgpu_dm_commit_cursors(dm_test_commit_with_plane(test, adev,
+							   DRM_PLANE_TYPE_CURSOR));
+}
+
+/**
+ * dm_test_update_cursor_no_framebuffer - Test missing framebuffers leave the update untouched
+ * @test: The KUnit test context
+ */
+static void dm_test_update_cursor_no_framebuffer(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct dc_stream_update *update;
+	struct drm_plane *plane;
+
+	state = dm_test_commit_with_plane(test, adev, DRM_PLANE_TYPE_CURSOR);
+	plane = state->planes[0].ptr;
+	update = kunit_kzalloc(test, sizeof(*update), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, update);
+
+	update->cursor_attributes = (void *)1;
+	update->cursor_position = (void *)1;
+
+	amdgpu_dm_update_cursor(plane, state->planes[0].old_state, update);
+
+	KUNIT_EXPECT_PTR_EQ(test, update->cursor_attributes, (void *)1);
+	KUNIT_EXPECT_PTR_EQ(test, update->cursor_position, (void *)1);
+}
+
+/**
+ * dm_test_update_cursor_disables_stream - Test removing the framebuffer disables the cursor
+ * @test: The KUnit test context
+ */
+static void dm_test_update_cursor_disables_stream(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state;
+	struct dc_stream_update *update;
+	struct drm_plane_state *old_plane_state;
+	struct dm_crtc_state *crtc_state;
+	struct amdgpu_framebuffer *afb;
+	struct amdgpu_crtc *acrtc;
+	struct drm_plane *plane;
+
+	state = dm_test_commit_with_plane(test, adev, DRM_PLANE_TYPE_CURSOR);
+	plane = state->planes[0].ptr;
+	old_plane_state = state->planes[0].old_state;
+	crtc_state = kunit_kzalloc(test, sizeof(*crtc_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, acrtc);
+	update = kunit_kzalloc(test, sizeof(*update), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, update);
+
+	old_plane_state->fb = &afb->base;
+	old_plane_state->crtc = &acrtc->base;
+	acrtc->base.state = &crtc_state->base;
+	crtc_state->stream = dm_kunit_alloc_stream(test, NULL);
+	crtc_state->stream->cursor_position.enable = true;
+
+	amdgpu_dm_update_cursor(plane, old_plane_state, update);
+
+	KUNIT_EXPECT_FALSE(test, crtc_state->stream->cursor_position.enable);
+	KUNIT_EXPECT_PTR_EQ(test, update->cursor_position,
+			    &crtc_state->stream->cursor_position);
+	KUNIT_EXPECT_NULL(test, update->cursor_attributes);
+}
+
 static struct kunit_case amdgpu_dm_tests[] = {
 	/* Simple DM callbacks */
 	KUNIT_CASE(dm_test_wait_for_idle),
@@ -1497,6 +1631,12 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_add_affected_mst_dsc_crtcs_not_mst),
 	KUNIT_CASE(dm_test_add_affected_mst_dsc_crtcs_other_crtc),
 	KUNIT_CASE(dm_test_add_affected_mst_dsc_crtcs_disabled),
+	/* amdgpu_dm_commit_cursors */
+	KUNIT_CASE(dm_test_commit_cursors_no_planes),
+	KUNIT_CASE(dm_test_commit_cursors_skips_non_cursor),
+	KUNIT_CASE(dm_test_commit_cursors_updates_cursor),
+	KUNIT_CASE(dm_test_update_cursor_no_framebuffer),
+	KUNIT_CASE(dm_test_update_cursor_disables_stream),
 	{}
 };
 
-- 
2.43.0

