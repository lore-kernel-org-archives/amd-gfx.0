Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29451C982D0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9438F10EB3D;
	Wed, 16 Sep 2026 17:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vYeEe2eS";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012035.outbound.protection.outlook.com
 [40.107.200.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106FD10EB3D
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0j3fjJMAr+ruspaI/xlvHiSLNJraqXA/qHnb8GrBDZVuse20zWXtyydhdG3UYMvu5Nrp2mjfCHgKJluTe59ef6aPDK1ceh3BKMxR81vhsdw2vbEVa/Nyi9WgHWQMdzqsl390FM2WxHvdsI9Y8p42yGDoRQvqXHHudgxKsH6C9ddFMbXvXryqVeb8oM5FzLpDyQ3Dl4J9ZzbggcpHPmQIFWHR7227GeCNGG3RPlg/Irs6qy18kgY/eBA9KrbN7+dAQZ15u8DKhboz2hdBWoHaQPN7/78hU0koHV/VcNRAtHiOzJWMxcmI6UN2r0Qtky4t6xlVytBb2Wl4YfNFNb40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvxfgKVnSt/1PdCZ7ll19klu8LD2WPG8k7aL1wsPmIo=;
 b=QZt8Pkb4CJeYQEXtmr8RJveUZDWVfNznTdomKBdGEuEDQOcTZYnoc3xs8KGJzfH4lTdte8v0q05p7KWN/qa6EamE/dR468sQC2Ogc1tDb1ICclFfdJKnAVlSLtbL+UZ0ZIXazbqxFb5fp89v1LouPs0gY104ih/vQ5AeqPoccPfXpZaeLHrYE3MMSjW0GBt/+8HujDfU9ZAwZik2jIC6+O/Ugryx/WchukL7GPEcEbHbDUMZQ1bsLiQaquVO1wKPZvs5Ej0YXYqLSjcMpl7PZsM5TJBdQPE5+6nB4FoI7YnqNrfqVKxxIod+zN7N1eI06s24xl0kZDxrrowbAZ4nSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvxfgKVnSt/1PdCZ7ll19klu8LD2WPG8k7aL1wsPmIo=;
 b=vYeEe2eSDf0mUbk+N1VwwCocGdBcQhilRrwz8SlVmlZ1z1xQeOhOqZsGVxadoWxJi5wx+UKeKkVzQvrDbt83YIDdjCckA0VogOpUDkafu3dw9rwcvpQyaGh9W0Arqi481T0HdUROQagQr3YLku7cDa7FONj604FQB5/rzElWaaI=
Received: from CH0PR03CA0264.namprd03.prod.outlook.com (2603:10b6:610:e5::29)
 by DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:52:40 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::a9) by CH0PR03CA0264.outlook.office365.com
 (2603:10b6:610:e5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:40 +0000
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
Subject: [PATCH 21/64] drm/amd/display: Fold plane state check tests
Date: Wed, 16 Sep 2026 13:51:36 -0400
Message-ID: <20260916175301.368306-22-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c1c60b0-7732-477c-1088-08df141b4d34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: K4kEx2Blll1ACH81e7cOH3BuP09jhePehKYXjegNga/07s00C5qt5TWiUO8GOkNJhYd3odYBz3xRbizZ6i6YXOsQpcPPEukF4Kb5q2bTnHlrftABSeZ+8+BCRKSP2xwZ47KEqPNTFQI7GKyaPEQTJ8tu50CzORAFOV9EGOg3YAhPBu6Xxs+tzc//IDpARRpQe5J21jrzIrVrjS7p8gPEUmZvYIZSePfaheShOlgxpELpoDT8Ihe1MAdWQVuXxgI0Q/FZhkVkpPGvJTG+DCP4yovk0V55ekMni6PuG7hXOJKIpZucqHxF7q/42mqFjYU9ewO6+DXBuOKmUGmmhHZaHBmhG3Wz2pMeZW6h0MjC+BWk2YFnZ9FuGihRpNhBOmH3OzfyVZXneVSAz0bhu3seBcaDYhab+UbpKAh4xYW7G2KuZYGgFOSGJzLjo8mEgKEhqd6JzhY4aSLs3gcpcSWixatzOj+up4W39LkNfhYFLadEn3GP1Vr87JV66sDpeoQwfGZZNm7TusQMnnOlTsISt79jnLGYAf/G2TuODkfNxFLSrdLUXoFrq6JX1Acjy5AEiI2hZ+2wkrtnCOhg2xpTS4qMgrulQwqz4/1eUYZ0t+L/1eeBWx/H8Qw9oJDyxTvxEyfMIBFpNSjCMtVWi+uC/Kro3TeLNnFiXWhOXkC7wwywgtt9QmZyqDCdxHorM84+jcwoBadZc4kqQsDTXx13mw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2GangIcyKRNaDWbSdLpKMKVGnnNK8iFO/VndHKTN0gWi2DDcqj/aEreLasAao8GOwF1ctj0cHdnQo3cbdM6xvt59OHB6AiV69nor7RTEPb/TNbU1eA/7l4JFXzL1G2PjOZ2MKPm9R/A0tzQ+sI3A8ZmKUtjg1Cs7JmXtOMDB2OJED5Wd0R5ky9K64qD8ADLeqImhZNIPPxcYhL6Lm3oxtS8qoJw9SRsu0BHM3lK6BkuMb9D0wj+BZkO2rzU8QeruDkj65ri9sPw6aArggMZaAOEzKa3SwH9WgCpaYt6Cju0vHOsTQ03ipEq+N64X6kCy7RHJ9xjWoN4S9ylrIWu480qYGHPFNsHT0O0bO1OApyjtXAiEjZtG3WHAgICvDrnNS+lHgXQ6WsG7WAf03npc/Le5pPHOevXfXoSy0G9PW4Ji4IWfMsQhOpIbeYAQPo8v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:40.1284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1c60b0-7732-477c-1088-08df141b4d34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450
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
Reduce the four viewport KUnit tests for
amdgpu_dm_plane_helper_check_state() to one, and the three rejection
tests for amdgpu_dm_plane_atomic_check() to one.

[HOW]
Drive the viewport cases from a table of CRTC rectangles and display
sizes, and rebuild the atomic state between the helper-check, color
pipeline conflict and scaling-info sub-cases of the atomic check test.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 256 ++++--------------
 1 file changed, 59 insertions(+), 197 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index c3aaa2b05e95..9491ae883d3c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -550,42 +550,63 @@ static void dm_test_fill_gfx9_plane_attributes_from_modifiers(struct kunit *test
 }
 
 /**
- * dm_test_helper_check_state_viewport_reject() - Verify viewport outside screen rejects state.
+ * dm_test_helper_check_state_viewport_rejects() - Verify viewport rejections.
  * @test: KUnit test context.
  *
- * Verify if plane state is rejected when the viewport is outside display bounds.
+ * Verify if a viewport outside the display bounds, or one clipped by an edge
+ * to below the minimum pipe-split width or height, is rejected.
  */
-static void dm_test_helper_check_state_viewport_reject(struct kunit *test)
+static void dm_test_helper_check_state_viewport_rejects(struct kunit *test)
 {
-	struct drm_plane *plane;
-	struct drm_plane_state *state;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *new_crtc_state;
-	struct drm_framebuffer *fb;
+	static const struct {
+		const char *name;
+		int crtc_x;
+		int crtc_y;
+		int crtc_w;
+		int crtc_h;
+		int hdisplay;
+		int vdisplay;
+	} cases[] = {
+		{ "outside the display", 200, 0, 100, 100, 100, 100 },
+		{ "width below minimum", 0, 0, 10, 100, 1920, 1080 },
+		{ "top-clipped height", -2, -95, 100, 100, 1920, 1080 },
+		{ "bottom-clipped height", 0, 95, 100, 100, 1920, 100 },
+	};
+	unsigned int i;
 
-	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
-	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	new_crtc_state = kunit_kzalloc(test, sizeof(*new_crtc_state), GFP_KERNEL);
-	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, plane);
-	KUNIT_ASSERT_NOT_NULL(test, state);
-	KUNIT_ASSERT_NOT_NULL(test, crtc);
-	KUNIT_ASSERT_NOT_NULL(test, new_crtc_state);
-	KUNIT_ASSERT_NOT_NULL(test, fb);
+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
+		struct drm_plane *plane;
+		struct drm_plane_state *state;
+		struct drm_crtc *crtc;
+		struct drm_crtc_state *new_crtc_state;
+		struct drm_framebuffer *fb;
+		int ret;
 
-	plane->type = DRM_PLANE_TYPE_OVERLAY;
-	state->plane = plane;
-	state->fb = fb;
-	state->crtc = crtc;
-	state->crtc_x = 200;
-	state->crtc_y = 0;
-	state->crtc_w = 100;
-	state->crtc_h = 100;
-	new_crtc_state->mode.crtc_hdisplay = 100;
-	new_crtc_state->mode.crtc_vdisplay = 100;
+		plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+		state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+		crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+		new_crtc_state = kunit_kzalloc(test, sizeof(*new_crtc_state), GFP_KERNEL);
+		fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, plane);
+		KUNIT_ASSERT_NOT_NULL(test, state);
+		KUNIT_ASSERT_NOT_NULL(test, crtc);
+		KUNIT_ASSERT_NOT_NULL(test, new_crtc_state);
+		KUNIT_ASSERT_NOT_NULL(test, fb);
 
-	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_helper_check_state(state, new_crtc_state), -EINVAL);
+		plane->type = DRM_PLANE_TYPE_OVERLAY;
+		state->plane = plane;
+		state->fb = fb;
+		state->crtc = crtc;
+		state->crtc_x = cases[i].crtc_x;
+		state->crtc_y = cases[i].crtc_y;
+		state->crtc_w = cases[i].crtc_w;
+		state->crtc_h = cases[i].crtc_h;
+		new_crtc_state->mode.crtc_hdisplay = cases[i].hdisplay;
+		new_crtc_state->mode.crtc_vdisplay = cases[i].vdisplay;
+
+		ret = amdgpu_dm_plane_helper_check_state(state, new_crtc_state);
+		KUNIT_EXPECT_EQ_MSG(test, ret, -EINVAL, "%s", cases[i].name);
+	}
 }
 
 /**
@@ -1733,130 +1754,6 @@ static void dm_test_fill_plane_buffer_attributes_gfx12(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)tiling_info.gfxversion, (int)DcGfxAddr3);
 }
 
-/**
- * dm_test_helper_check_state_small_viewport_width() - Verify width rejection.
- * @test: KUnit test context.
- *
- * Verify if a viewport width below the minimum pipe-split width is rejected.
- */
-static void dm_test_helper_check_state_small_viewport_width(struct kunit *test)
-{
-	struct drm_plane *plane;
-	struct drm_plane_state *state;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *new_crtc_state;
-	struct drm_framebuffer *fb;
-
-	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
-	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	new_crtc_state = kunit_kzalloc(test, sizeof(*new_crtc_state), GFP_KERNEL);
-	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, plane);
-	KUNIT_ASSERT_NOT_NULL(test, state);
-	KUNIT_ASSERT_NOT_NULL(test, crtc);
-	KUNIT_ASSERT_NOT_NULL(test, new_crtc_state);
-	KUNIT_ASSERT_NOT_NULL(test, fb);
-
-	plane->type = DRM_PLANE_TYPE_OVERLAY;
-	state->plane = plane;
-	state->fb = fb;
-	state->crtc = crtc;
-	state->crtc_x = 0;
-	state->crtc_y = 0;
-	state->crtc_w = 10;
-	state->crtc_h = 100;
-	new_crtc_state->mode.crtc_hdisplay = 1920;
-	new_crtc_state->mode.crtc_vdisplay = 1080;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_helper_check_state(state, new_crtc_state),
-			-EINVAL);
-}
-
-/**
- * dm_test_helper_check_state_small_viewport_height() - Verify height rejection.
- * @test: KUnit test context.
- *
- * Verify if a negative-offset viewport with a too-small height is rejected.
- */
-static void dm_test_helper_check_state_small_viewport_height(struct kunit *test)
-{
-	struct drm_plane *plane;
-	struct drm_plane_state *state;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *new_crtc_state;
-	struct drm_framebuffer *fb;
-
-	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
-	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	new_crtc_state = kunit_kzalloc(test, sizeof(*new_crtc_state), GFP_KERNEL);
-	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, plane);
-	KUNIT_ASSERT_NOT_NULL(test, state);
-	KUNIT_ASSERT_NOT_NULL(test, crtc);
-	KUNIT_ASSERT_NOT_NULL(test, new_crtc_state);
-	KUNIT_ASSERT_NOT_NULL(test, fb);
-
-	plane->type = DRM_PLANE_TYPE_OVERLAY;
-	state->plane = plane;
-	state->fb = fb;
-	state->crtc = crtc;
-	state->crtc_x = -2;
-	state->crtc_y = -95;
-	state->crtc_w = 100;
-	state->crtc_h = 100;
-	new_crtc_state->mode.crtc_hdisplay = 1920;
-	new_crtc_state->mode.crtc_vdisplay = 1080;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_helper_check_state(state, new_crtc_state),
-			-EINVAL);
-}
-
-/**
- * dm_test_helper_check_state_bottom_clipped_height() - Verify bottom clipping.
- * @test: KUnit test context.
- *
- * Verify if a viewport clipped by the bottom edge to below the minimum height
- * is rejected.
- */
-static void dm_test_helper_check_state_bottom_clipped_height(struct kunit *test)
-{
-	struct drm_plane *plane;
-	struct drm_plane_state *state;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *new_crtc_state;
-	struct drm_framebuffer *fb;
-
-	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
-	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
-	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
-	new_crtc_state = kunit_kzalloc(test, sizeof(*new_crtc_state), GFP_KERNEL);
-	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, plane);
-	KUNIT_ASSERT_NOT_NULL(test, state);
-	KUNIT_ASSERT_NOT_NULL(test, crtc);
-	KUNIT_ASSERT_NOT_NULL(test, new_crtc_state);
-	KUNIT_ASSERT_NOT_NULL(test, fb);
-
-	plane->type = DRM_PLANE_TYPE_OVERLAY;
-	state->plane = plane;
-	state->fb = fb;
-	state->crtc = crtc;
-	state->crtc_x = 0;
-	state->crtc_y = 95;
-	state->crtc_w = 100;
-	state->crtc_h = 100;
-	new_crtc_state->mode.crtc_hdisplay = 1920;
-	new_crtc_state->mode.crtc_vdisplay = 100;
-
-	KUNIT_EXPECT_EQ(test,
-			amdgpu_dm_plane_helper_check_state(state, new_crtc_state),
-			-EINVAL);
-}
-
 /**
  * dm_test_helper_check_state_scaling_caps() - Verify DC scaling caps are applied.
  * @test: KUnit test context.
@@ -2274,43 +2171,29 @@ static void dm_test_atomic_check_missing_crtc_state(struct kunit *test)
 }
 
 /**
- * dm_test_atomic_check_helper_failure() - Verify helper-check failures return.
+ * dm_test_atomic_check_rejects() - Verify the checks before DC validation.
  * @test: KUnit test context.
  *
  * Verify if atomic_check returns before DC validation when the DRM helper state
- * validation rejects the plane.
+ * validation rejects the plane, when both the plane COLOR_PIPELINE and the CRTC
+ * DEGAMMA_LUT are in use, and when filling the scaling info fails.
  */
-static void dm_test_atomic_check_helper_failure(struct kunit *test)
+static void dm_test_atomic_check_rejects(struct kunit *test)
 {
 	struct drm_atomic_commit *state;
 	struct drm_plane *plane;
 	struct dm_plane_state *dm_plane_state;
 	struct drm_crtc_state *new_crtc_state;
 	struct drm_framebuffer *fb;
+	struct amdgpu_device *adev;
+	void *color_pipeline;
+	void *degamma_lut;
 
 	dm_test_init_atomic_check_state(test, &state, &plane, &dm_plane_state,
 					&new_crtc_state, &fb);
 	dm_plane_state->base.crtc_w = 10;
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_atomic_check(plane, state), -EINVAL);
-}
-
-/**
- * dm_test_atomic_check_color_pipeline_conflict() - Verify color conflict rejection.
- * @test: KUnit test context.
- *
- * Verify if atomic_check rejects use of both plane COLOR_PIPELINE and CRTC
- * DEGAMMA_LUT before DC validation.
- */
-static void dm_test_atomic_check_color_pipeline_conflict(struct kunit *test)
-{
-	struct drm_atomic_commit *state;
-	struct drm_plane *plane;
-	struct dm_plane_state *dm_plane_state;
-	struct drm_crtc_state *new_crtc_state;
-	struct drm_framebuffer *fb;
-	void *color_pipeline;
-	void *degamma_lut;
 
 	dm_test_init_atomic_check_state(test, &state, &plane, &dm_plane_state,
 					&new_crtc_state, &fb);
@@ -2323,22 +2206,6 @@ static void dm_test_atomic_check_color_pipeline_conflict(struct kunit *test)
 	new_crtc_state->degamma_lut = degamma_lut;
 
 	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_atomic_check(plane, state), -EINVAL);
-}
-
-/**
- * dm_test_atomic_check_scaling_failure() - Verify scaling-info failures return.
- * @test: KUnit test context.
- *
- * Verify if atomic_check returns the scaling-info error before DC validation.
- */
-static void dm_test_atomic_check_scaling_failure(struct kunit *test)
-{
-	struct amdgpu_device *adev;
-	struct drm_atomic_commit *state;
-	struct drm_plane *plane;
-	struct dm_plane_state *dm_plane_state;
-	struct drm_crtc_state *new_crtc_state;
-	struct drm_framebuffer *fb;
 
 	adev = dm_test_init_atomic_check_state(test, &state, &plane, &dm_plane_state,
 					       &new_crtc_state, &fb);
@@ -3425,10 +3292,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_validate_fails),
 	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_ind_blk),
 	/* amdgpu_dm_plane_helper_check_state() */
-	KUNIT_CASE(dm_test_helper_check_state_viewport_reject),
-	KUNIT_CASE(dm_test_helper_check_state_small_viewport_width),
-	KUNIT_CASE(dm_test_helper_check_state_small_viewport_height),
-	KUNIT_CASE(dm_test_helper_check_state_bottom_clipped_height),
+	KUNIT_CASE(dm_test_helper_check_state_viewport_rejects),
 	KUNIT_CASE(dm_test_helper_check_state_scaling_caps),
 	/* amdgpu_dm_plane_helper_prepare_fb() */
 	KUNIT_CASE(dm_test_helper_prepare_fb_no_fb),
@@ -3446,9 +3310,7 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_atomic_check() */
 	KUNIT_CASE(dm_test_atomic_check_no_dc_state),
 	KUNIT_CASE(dm_test_atomic_check_missing_crtc_state),
-	KUNIT_CASE(dm_test_atomic_check_helper_failure),
-	KUNIT_CASE(dm_test_atomic_check_color_pipeline_conflict),
-	KUNIT_CASE(dm_test_atomic_check_scaling_failure),
+	KUNIT_CASE(dm_test_atomic_check_rejects),
 	KUNIT_CASE(dm_test_atomic_check_success),
 	/* amdgpu_dm_plane_panic_flush() */
 	KUNIT_CASE(dm_test_panic_flush_no_dc_state),
-- 
2.55.0

