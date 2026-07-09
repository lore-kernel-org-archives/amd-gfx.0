Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BCAC44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A686C10F6F7;
	Thu,  9 Jul 2026 21:02:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HaiFsoY5";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011059.outbound.protection.outlook.com [40.107.208.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E6C10F6E8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZfLl5wHzuFOql+rwN+KvveRILRaOzVadMxZgnFT/tq4RhEtcgoy7h64TxZiAgnEya7T6gR/gjDprIJYgGJ4L38DxdTjIMZYPnPw8L0wbINXh3n7VgHSThiJDwNNF1reWeFoxVmfrzWaiHi4ecMk+y6l/ToFYaSbfWKa6Q2SBaFS4jbG4kzu2+qggkQ0hGwy4lMwI78wTRk/z6fEa54U5NmVsv4dcSLi9orDzkTW/6AYlpHESbXV5x6wf5naQgzqRytB1AZ3w8Sd/99iiRzxlzQAOOQwEq1aOLAOlYVsTWI5hYTrIiBJbECj1PDUGAZtMUqXOTGIhmDM7IVIshjbqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VCDp1XOMF4be/NDPOM451Y7UXjVGrkPPs+3ieNzmLCI=;
 b=NLdYG6s90G6hAmsnsZJerTy/q4WaO8UrMGVEghTlTo77oip77b+fzPb64JezJ9LUh3wj0+uv8pTQg4Cb+/Nu1HgVQDbV5+c2vXjGkkpqj7XPl0XUIpuEmCGIoTpg2HalGXGNf4x5rcNUoIvhsHlcgVCE54A3htJCiCJuQ8e7RDR+KuNmIjP7eQez2BUCVHXDP8qepbZBF5p1g3/5W5Q/CDAhUqPpbZZ++VAsAjvTI/YkKfNj8wN2yZ9Pet+HEW39oDcH3uO9uIM0/TlCcingf7XmEJspG1VSVQpXeD2LboM+/vMBYeUPXf3ufqdkpblI3TtyeI+/Hcbwsf3KLQM2LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VCDp1XOMF4be/NDPOM451Y7UXjVGrkPPs+3ieNzmLCI=;
 b=HaiFsoY5y6WtUYrMoyHS8oeiwoJ0z6GCARSjY0AL6b3A84WdGTsrbNm+vj6Q/mBp+AFKzsCL2eVBd4vb8YX/GkYJKMcmwv1elQHlgVJr/h++jKUPBmp5RHzHO8iaYb2wNrbvqfth0Rll6k9sAWEOD0xMQyGuH+atV5uAF1jtGts=
Received: from MN0PR04CA0025.namprd04.prod.outlook.com (2603:10b6:208:52d::24)
 by IA1PR12MB9062.namprd12.prod.outlook.com (2603:10b6:208:3aa::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 9 Jul
 2026 21:02:33 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:52d:cafe::9d) by MN0PR04CA0025.outlook.office365.com
 (2603:10b6:208:52d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Thu, 9
 Jul 2026 21:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:33 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:15 -0500
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
Subject: [PATCH 52/80] drm/amd/display: Test helper_check_state rejects
Date: Thu, 9 Jul 2026 16:48:20 -0400
Message-ID: <20260709205936.5719-53-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|IA1PR12MB9062:EE_
X-MS-Office365-Filtering-Correlation-Id: 21fdcf83-3523-4f74-d911-08deddfd657e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|36860700016|1800799024|22082099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: WHC9yl4zrB2j02Uc/1UU1NFxts30ylb7RzZbRFd+bNhoCaJMDL+BeFErHo3SoOX6fs2D2g1Dkk3k1AYAY1aFSULFx+zgjFbIXqFNowMzDeOSF/G9rk92o70MqGH1CUSFMYoAZ1VcjkoIPwTh3N8HMMwtQucqGrt0zzMSsYweSTT1sY5TQW2qqKAWz8s/uLWqfbArW+3PIZRlzN6h0XSQnbJ3Ckr2eYNyrbgaQO+oUOmzNmBSD3Nqm31s2EuuI/LPecEatfsq4S9AcOQshvsOyMWp4gc6dVRQVye8VVDYgVdbtX+ea6mA2Hz8s+CLAn5DpckXPbAFc7sGtfHd8jN5LkEH8o5RYphMlwS9iRwp6LE0bE3//KA/HPP2YUbXJSXweIwgS9gKfdNRcfVAWmxMHy+5elU9KtA3t8CQa/6nI6QemD8/YWxyGl7VXE3FnCSit7TG+618gqJYqyXOdTVGZNoTCwTuZTUxrOy8sL8RuY8x7GFcK5STS8sp2y0ZGvaztICBcrcjyZ3Nrg4ZwkMpsElCvFT3TXv/O0cyY31UfrhZHWZl6kOmoUXxbtBOQN0rESzCZITXdekNlS5yjkauaHp2iVjTJGywo5f3fanzkePMBeP/iyaFUA3ppOCmp4+0nfbAojHK8JNi8XHH0c+gzeEJh45hGr4PDtT6kPzYS5ZxCS8lCetpTbln+8SOGJodgjmf3tPw+NSWsgSLhG39DQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099006)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bWJrCFXvNd5ivvgXXo86sZjx/dqrjCfYGT6VuJ2cIJow3xaIFwYUpUIBOouVaiHZyLzIhAfnQKxAf/M41jbFhiJcZjsJmiKG4xRLnnWkvM1NaSk728sYtyufQh4ieWvnuB5E/lqwlVKbM34vXSedHGb9fXjqVCS+BIActHKzMWrpa2u7cWNpV8d1dPIpB/rfzWIQ/8GWbhZC7TKmfV5oGNJeQznagIsmseXNKWZthcnGfc1DvOGDRwUjNwWVJl2GtpMsEiF8JtN0y1/lZV8QmzCoZ4+voK3TBNKl/ofr1uxxM+zuSg71+HJ9oNQq6PRVkUdREir8VB9OGSJ6ytil+4DjNRQP6SCLj/+Wnwt0Sin5b5nO+R3cMpq7zvgLwgMTh3L4zR65hrA/WTGWQqSXLNX7mZy9jG3dI7WiFGCLQuRRbVb8h8K/fimid2xzvTeZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:33.2116 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21fdcf83-3523-4f74-d911-08deddfd657e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9062
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
Add KUnit tests for amdgpu_dm_plane_helper_check_state() covering the
small viewport width, small viewport height, bottom-edge clipping and
scaling-caps rejection paths.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 188 ++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index e1841a30fc32..f36c5c139554 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -2382,6 +2382,190 @@ static void dm_test_get_min_max_dc_plane_scaling_fp16(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, max_upscale, 2000);
 }
 
+/**
+ * dm_test_helper_check_state_small_viewport_width() - Verify width rejection.
+ * @test: KUnit test context.
+ *
+ * Verify if a viewport width below the minimum pipe-split width is rejected.
+ */
+static void dm_test_helper_check_state_small_viewport_width(struct kunit *test)
+{
+	struct drm_plane *plane;
+	struct drm_plane_state *state;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_framebuffer *fb;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	new_crtc_state = kunit_kzalloc(test, sizeof(*new_crtc_state), GFP_KERNEL);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, new_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	plane->type = DRM_PLANE_TYPE_OVERLAY;
+	state->plane = plane;
+	state->fb = fb;
+	state->crtc = crtc;
+	state->crtc_x = 0;
+	state->crtc_y = 0;
+	state->crtc_w = 10;
+	state->crtc_h = 100;
+	new_crtc_state->mode.crtc_hdisplay = 1920;
+	new_crtc_state->mode.crtc_vdisplay = 1080;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_helper_check_state(state, new_crtc_state),
+			-EINVAL);
+}
+
+/**
+ * dm_test_helper_check_state_small_viewport_height() - Verify height rejection.
+ * @test: KUnit test context.
+ *
+ * Verify if a negative-offset viewport with a too-small height is rejected.
+ */
+static void dm_test_helper_check_state_small_viewport_height(struct kunit *test)
+{
+	struct drm_plane *plane;
+	struct drm_plane_state *state;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_framebuffer *fb;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	new_crtc_state = kunit_kzalloc(test, sizeof(*new_crtc_state), GFP_KERNEL);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, new_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	plane->type = DRM_PLANE_TYPE_OVERLAY;
+	state->plane = plane;
+	state->fb = fb;
+	state->crtc = crtc;
+	state->crtc_x = -2;
+	state->crtc_y = -95;
+	state->crtc_w = 100;
+	state->crtc_h = 100;
+	new_crtc_state->mode.crtc_hdisplay = 1920;
+	new_crtc_state->mode.crtc_vdisplay = 1080;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_helper_check_state(state, new_crtc_state),
+			-EINVAL);
+}
+
+/**
+ * dm_test_helper_check_state_bottom_clipped_height() - Verify bottom clipping.
+ * @test: KUnit test context.
+ *
+ * Verify if a viewport clipped by the bottom edge to below the minimum height
+ * is rejected.
+ */
+static void dm_test_helper_check_state_bottom_clipped_height(struct kunit *test)
+{
+	struct drm_plane *plane;
+	struct drm_plane_state *state;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_framebuffer *fb;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	new_crtc_state = kunit_kzalloc(test, sizeof(*new_crtc_state), GFP_KERNEL);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, new_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	plane->type = DRM_PLANE_TYPE_OVERLAY;
+	state->plane = plane;
+	state->fb = fb;
+	state->crtc = crtc;
+	state->crtc_x = 0;
+	state->crtc_y = 95;
+	state->crtc_w = 100;
+	state->crtc_h = 100;
+	new_crtc_state->mode.crtc_hdisplay = 1920;
+	new_crtc_state->mode.crtc_vdisplay = 100;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_helper_check_state(state, new_crtc_state),
+			-EINVAL);
+}
+
+/**
+ * dm_test_helper_check_state_scaling_caps() - Verify DC scaling caps are applied.
+ * @test: KUnit test context.
+ *
+ * Verify if helper_check_state converts DC plane scaling caps to DRM scale
+ * limits and rejects scaling outside those limits.
+ */
+static void dm_test_helper_check_state_scaling_caps(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc *dc;
+	struct drm_plane *plane;
+	struct drm_plane_state *state;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_crtc_state;
+	struct drm_framebuffer *fb;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	crtc = kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
+	new_crtc_state = kunit_kzalloc(test, sizeof(*new_crtc_state), GFP_KERNEL);
+	fb = kunit_kzalloc(test, sizeof(*fb), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+	KUNIT_ASSERT_NOT_NULL(test, new_crtc_state);
+	KUNIT_ASSERT_NOT_NULL(test, fb);
+
+	adev->dm.dc = dc;
+	dc->caps.planes[0].max_upscale_factor.argb8888 = 1;
+	dc->caps.planes[0].max_downscale_factor.argb8888 = 1;
+
+	plane->type = DRM_PLANE_TYPE_OVERLAY;
+	plane->dev = &adev->ddev;
+	crtc->dev = &adev->ddev;
+	fb->width = 100;
+	fb->height = 100;
+	fb->format = drm_format_info(DRM_FORMAT_XRGB8888);
+	KUNIT_ASSERT_NOT_NULL(test, fb->format);
+
+	state->plane = plane;
+	state->fb = fb;
+	state->crtc = crtc;
+	state->src_w = 100 << 16;
+	state->src_h = 100 << 16;
+	state->crtc_w = 200;
+	state->crtc_h = 200;
+	new_crtc_state->crtc = crtc;
+	new_crtc_state->mode.crtc_hdisplay = 1920;
+	new_crtc_state->mode.crtc_vdisplay = 1080;
+
+	KUNIT_EXPECT_EQ(test,
+			amdgpu_dm_plane_helper_check_state(state, new_crtc_state),
+			-ERANGE);
+}
+
 /**
  * dm_test_fill_dc_scaling_info_nv12_dcn1x() - Verify NV12 DCN1x rejection.
  * @test: KUnit test context.
@@ -2602,6 +2786,10 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_fill_gfx9_plane_attributes_dcc_gfx9_unconstrained),
 	/* amdgpu_dm_plane_helper_check_state() */
 	KUNIT_CASE(dm_test_helper_check_state_viewport_reject),
+	KUNIT_CASE(dm_test_helper_check_state_small_viewport_width),
+	KUNIT_CASE(dm_test_helper_check_state_small_viewport_height),
+	KUNIT_CASE(dm_test_helper_check_state_bottom_clipped_height),
+	KUNIT_CASE(dm_test_helper_check_state_scaling_caps),
 	/* amdgpu_dm_plane_add_modifier() */
 	KUNIT_CASE(dm_test_add_modifier_appends_value),
 	KUNIT_CASE(dm_test_add_modifier_grows_capacity),
-- 
2.55.0

