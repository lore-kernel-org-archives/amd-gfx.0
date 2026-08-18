Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76574C5DF9D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11D410ECE2;
	Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OK+SHw3P";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010005.outbound.protection.outlook.com
 [52.101.193.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C992510ECAD
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNtaRw0v6r/ywsVqA8x/V898qGvQFQ5rAU6VjoU6Z/AD7nWMiRD7rK8wm7Yl763peoEv8B9baNCUDTsOuLk6pz+CLNUAgJxL3byaszwkM/84Ig+2iBTTQ6+9pVyfW1gkRtQWdPyA+CqEN/tYkDMnubqwVAQubhsb5lPuvsRQC8Ei0cFR7wNq03l/2UfOCpo6LdtfLd3n2WQe2+JR+/e4C/D7wg3eaarySpsZJZ7P/IyYGo7dNZ3/HfKLFYmex+Turz61haorDJiQrhcSH2XHmNwGlAHVTL4FHiZ49DYgFa1N/vZhmy6D/xG5zYTDfCpi8gp4ApHYBLatyaKxxDYQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9AwodAmc0sles7odurvsysMCnRdWHRDRFXwUecqu8pk=;
 b=c3kslE2Q1JZJnxuNwq0/69fGTLpVQa49XKzubuwUmpaAx2e/Mv3NhNVVJnc3QJqFrbkZ9m9KWSAOgYfVTn6EUM0SebcC0AUFmYT54q7w/TtFsgfbOCZAAE09s5P00ZTLdyvdFXJoWeSQ6YUSRE6QFWoUTVQiBG94Zf5/ylCnGAH5RBgEOUhJmpeC7q0COSrGk53yWOpPvo7SgH1fVVZg9Zm/hCf35DnLaYIfRcrvyeX3icsEJ+BSVCMhloX/t7lCvEZ5eaMAHIQ7WnyIdNMCXiipYyRSdcGMPXhGDzvNoiVHyA8GjUsK7EGZgDTu75vgyppqgI5UrnEPA6fUqpa0hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9AwodAmc0sles7odurvsysMCnRdWHRDRFXwUecqu8pk=;
 b=OK+SHw3PY8icZ+zilM0ejCzSP6lYMYW+jMSg6IGSdhnB4zJLNDhV3BlrHh+0/W3A5isy8xL3F2Pd8Wk1Ucn+S0VL+alXFZQhI8ESix7UmLxsDt1QHJnKo8krA9QwD4arXOv+1QkANvvJ1vTb3eDsOddh5zGIiDzKwlMVAICxRMc=
Received: from BN9PR03CA0344.namprd03.prod.outlook.com (2603:10b6:408:f6::19)
 by CY5PR12MB6156.namprd12.prod.outlook.com (2603:10b6:930:24::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:42 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::6b) by BN9PR03CA0344.outlook.office365.com
 (2603:10b6:408:f6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:30 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:30 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:29 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 51/82] drm/amd/display: Test cursor update and async plane
 update
Date: Tue, 18 Aug 2026 16:15:43 -0400
Message-ID: <20260818202139.4172592-52-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CY5PR12MB6156:EE_
X-MS-Office365-Filtering-Correlation-Id: 741d0d71-56a2-45c6-0678-08defd667518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|56012099006|10067099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: M+QqEAEnTv0GwGvmZsVmIqtYYslY5Mowym4neWc+E7lWsK4SkBy5Bovtwm1vuPANZo4LkBZULXVBpyI7OoddKv6PD9f20HSI5/xBG3rUx14W2y8U2G/XtYweWaUMD+2IV4RTjs0B3dB+vLTgYJK8sHm7C8MVxHeYySVuC2TfglpCN/GRLJyWG2L6dKBJ/BGVQlL9kGhd15gVcTaIOHRaAkoB41GgDEnntEwqTsmd3LZx2n7BWBPaod/1Eh2bq2UaW0WF3YRgvn71aO/j5V9pylmELoUji23ZeHwLmxQdqtL+6CRgyCEJGUcijBiVMT6Sn7Rp6xR60idFcb7mZ91blDlfKkqzkH0LDSqFLNF3SGoqAXBtRCQPJ2xx2WFEvyv1YV6qgRELNI7kA0tAR2A2JSd9QqMrhWMGD5m2WXgScDJvCivic9zbn29aJ+Y0tgiY1sjYIrjjjBd15fpRAKJ/602Todpc6bMno0IKbKUfEtBD+lq3l7MSblbhJAZ9Znly8z7S4YCWLhq4nlMqk50trji9RKl4rr3Zq4IGYwXneLqFdsRAkayYOeswNWhk00OxC1IfdjlOnyuW7vHyAiPayI/fhFt/KERuR/Mb4SyIW/A6YvULoOvpXqp5rLKR81XUN4g7ZYuICezhXIM0frZJ/SnT69eipQS9yD4dbbvPMR6hK1nBn2vPvaBMHaxgWigErBdrpdM3fF9VyuMsT9f7+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9hL7ZUpt0M0O5wcvJQPuur3PhIERywc8y+Wvip/vjmsF1c1/kmTO2QFpNboWjPS9fkUSaTziRDDHAgVvUvzzd6aE3uWkW9Z7lSkXFBO7v5WJV+kDJekTrj1TzoOLv9RKsepBDrL6lq7FH2apnM8ELKD0X+b1JETuX9OoGQvsheuPcrUWw4GWeNGKdniI0W3I3yjDAtjpf8CcerYvxx35FFJG20eIltBTirmi2BYTxwCvs+K+vmwpbWxHjb0KjW8nqDbixYVasPqNXKR8SIvckI775XMeziLPcoOMjcP3pk9f0QCIIc7x5FmR7xQss12bLRNIAYDurpJdF5e8FzkwpxvNvJfsgDuhYJKvuFWTNF3nkGmJlhdJHKJJa+EgDlQJRu7ZXCdhlmyP8b43vE750I3IePEDSZt/hkfn2BvWIzCJrhToS8KdJNtV/2VRA6wn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:42.5755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 741d0d71-56a2-45c6-0678-08defd667518
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6156
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
Add KUnit tests for amdgpu_dm_plane_handle_cursor_update() and
amdgpu_dm_plane_atomic_async_update() covering the return taken when the
cursor plane has no framebuffer, and the copy of the new position and
size into the plane state ahead of the cursor update.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  6 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 90 +++++++++++++++++++
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 096e1a5e37ad0..0a5a7347238ec 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1738,9 +1738,10 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
 		mutex_unlock(&adev->dm.dc_lock);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_handle_cursor_update);
 
-static void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
-						struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
+							  struct drm_atomic_commit *state)
 {
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state,
 									   plane);
@@ -1762,6 +1763,7 @@ static void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane,
 
 	amdgpu_dm_plane_handle_cursor_update(plane, old_state);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_atomic_async_update);
 
 STATIC_IFN_KUNIT void amdgpu_dm_plane_panic_flush(struct drm_plane *plane)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index d8ebe48abc9fa..18b500585bedd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -136,5 +136,6 @@ bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgpu_device *adev,
 					       const u64 modifier);
 int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane, struct drm_plane_state *new_state);
 void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane, struct drm_plane_state *old_state);
+void amdgpu_dm_plane_atomic_async_update(struct drm_plane *plane, struct drm_atomic_commit *state);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index 7b3f0759cc1f9..1b39f41c8414b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3595,6 +3595,92 @@ static void dm_test_helper_cleanup_fb_no_fb(struct kunit *test)
 	amdgpu_dm_plane_helper_cleanup_fb(plane, &state);
 }
 
+/**
+ * dm_test_handle_cursor_update_no_fb() - Verify cursor update without framebuffers.
+ * @test: KUnit test context.
+ *
+ * Verify if the cursor update returns early, without touching the CRTC, when
+ * neither the new nor the old plane state has a framebuffer bound.
+ */
+static void dm_test_handle_cursor_update_no_fb(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_plane_state old_state = {0};
+	struct drm_plane_state state = {0};
+	struct drm_plane *plane;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+
+	plane->dev = &adev->ddev;
+	plane->state = &state;
+
+	amdgpu_dm_plane_handle_cursor_update(plane, &old_state);
+}
+
+/**
+ * dm_test_atomic_async_update_copies_state() - Verify async cursor state copy.
+ * @test: KUnit test context.
+ *
+ * Verify if the async update swaps the framebuffer and copies the source and
+ * CRTC rectangles from the new state into the current plane state.
+ */
+static void dm_test_atomic_async_update_copies_state(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct drm_atomic_commit *state;
+	struct __drm_planes_state *planes;
+	struct drm_plane_state *cur_state;
+	struct drm_plane_state *new_state;
+	struct drm_plane_state *old_state;
+	struct amdgpu_framebuffer *afb;
+	struct drm_plane *plane;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	planes = kunit_kzalloc(test, sizeof(*planes), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	cur_state = kunit_kzalloc(test, sizeof(*cur_state), GFP_KERNEL);
+	new_state = kunit_kzalloc(test, sizeof(*new_state), GFP_KERNEL);
+	old_state = kunit_kzalloc(test, sizeof(*old_state), GFP_KERNEL);
+	afb = kunit_kzalloc(test, sizeof(*afb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, planes);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, cur_state);
+	KUNIT_ASSERT_NOT_NULL(test, new_state);
+	KUNIT_ASSERT_NOT_NULL(test, old_state);
+	KUNIT_ASSERT_NOT_NULL(test, afb);
+
+	plane->dev = &adev->ddev;
+	plane->index = 0;
+	plane->state = cur_state;
+	cur_state->fb = &afb->base;
+	new_state->src_x = 1 << 16;
+	new_state->src_y = 2 << 16;
+	new_state->src_w = 64 << 16;
+	new_state->src_h = 64 << 16;
+	new_state->crtc_x = 10;
+	new_state->crtc_y = 20;
+	new_state->crtc_w = 64;
+	new_state->crtc_h = 64;
+	state->planes = planes;
+	state->planes[0].new_state = new_state;
+	state->planes[0].old_state = old_state;
+
+	amdgpu_dm_plane_atomic_async_update(plane, state);
+
+	KUNIT_EXPECT_PTR_EQ(test, cur_state->fb, NULL);
+	KUNIT_EXPECT_PTR_EQ(test, new_state->fb, &afb->base);
+	KUNIT_EXPECT_EQ(test, cur_state->src_x, 1U << 16);
+	KUNIT_EXPECT_EQ(test, cur_state->src_h, 64U << 16);
+	KUNIT_EXPECT_EQ(test, cur_state->crtc_x, 10);
+	KUNIT_EXPECT_EQ(test, cur_state->crtc_h, 64U);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3664,6 +3750,10 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_helper_prepare_fb_no_fb),
 	/* amdgpu_dm_plane_helper_cleanup_fb() */
 	KUNIT_CASE(dm_test_helper_cleanup_fb_no_fb),
+	/* amdgpu_dm_plane_handle_cursor_update() */
+	KUNIT_CASE(dm_test_handle_cursor_update_no_fb),
+	/* amdgpu_dm_plane_atomic_async_update() */
+	KUNIT_CASE(dm_test_atomic_async_update_copies_state),
 	/* amdgpu_dm_plane_atomic_async_check() */
 	KUNIT_CASE(dm_test_atomic_async_check_rejects),
 	KUNIT_CASE(dm_test_atomic_async_check_overlay_cursor),
-- 
2.43.0

