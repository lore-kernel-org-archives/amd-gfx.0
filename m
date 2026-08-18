Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA48C5DF94
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9875610ECB5;
	Tue, 18 Aug 2026 20:22:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QFyy8OLG";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012005.outbound.protection.outlook.com
 [40.107.200.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB5010ECB8
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4g/QnVKyZupR3+FCmh3Tf4SGuB85LVoYtWnDo+TvTZ6Gxmhnz/+yjBgy6x6qtlJWblAsAN7osKnlIWcl3YHhUi8CdfosNm9Ty5dJaki1wRPW/C/82XSytcT9aN8+h4FXIi9qzndgP4gxUmf3o5Kz6sVXYwGQN+9kKyIJaR1O6YRO9E/0aYDmc+KVeIoUKJjcyIEPMfgKe0Dbn6oaoB38udD+mqA2DXun5bdVkV9ZEIdM0q2xaeedfJrKZA5tcBVuT//kMAmKJCv1z4sbP9qMx68zdU40icdgjdcjZIL2lHNLoSnefyTlCU/mGEeqVgecPp/K7IH70I8Nsn+kc4CdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iHJ/q8M4rG/p5z5ZNObU1S9UboA2lr+4/wf6SxZ6hg=;
 b=dfdlY6Xqs+CU43d5WOPTM//W0gO12aAeQfxJdghbD/wjshOKvkWRWRA8byBN5gOI1hBwli/XOmJMfYNlQiGjvmpN6zVPGNt97zMWcSdB2ibXNlk9qpHFPBCvfFdv1CxJRi7tATnf8OHG1IMlIwUCzemcjXIhplqVQZC20+/j7ylnkTNQW5vuMoLaHkdcLymEY43fK7Q5VjVbuIYKWS+h9vgKe8ri4lT1We8N+ii5bXzJRQVGPJJ5ahevWT1LpZCbdwBpdLOm27YgAs7Yj++2aKF3EcffanQMoDKDiuj3LbnlzmtKgXnEU/a5oH5xpuGRHCVJdD6kK8QuiDTK0/6YcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iHJ/q8M4rG/p5z5ZNObU1S9UboA2lr+4/wf6SxZ6hg=;
 b=QFyy8OLGO6PMsHfc6P1wKiT9zsiVqQ90jjQn6JlWrGIYsJUlIsM+8PJsB9slalBZDBT5pEbPm5T9/8vgV7mDY7YkHtNYTfl5vDCay48tXFpugZ+BdsWo/59Cgk4njnv2Pr9KcJONzXnH69Y06neaDCMrpc4njwFICjpDtQ9Wkl4=
Received: from CH5P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::18)
 by SA1PR12MB6703.namprd12.prod.outlook.com (2603:10b6:806:253::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 18 Aug
 2026 20:22:42 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::44) by CH5P222CA0022.outlook.office365.com
 (2603:10b6:610:1ee::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:29 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:28 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 50/82] drm/amd/display: Test framebuffer prepare and cleanup
Date: Tue, 18 Aug 2026 16:15:42 -0400
Message-ID: <20260818202139.4172592-51-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SA1PR12MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc7e333-c93e-49d7-477a-08defd667477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|376014|82310400026|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 69ypHXw/LYvC6LEmWx35PHGo6XINmSsJbs5DqXomEtxk+JaAaE5RyEX79+EuhNhWpkHPpnbLF+buPfnw3u73RqvSXBfLM7vG6HllbBKfJDrR8t64xz7VdUruxxMK/KLGVBtJlBG4lpBurjNxNmmKEGy5fng1f6hYuXQLk6NmBD5PLc6sYfFXxEAsbeRvJMc3dOQ70tvxobbf33SWbzNRHZ2OV3gvHhwT9gaFofaZ6ZQiUMASys69dVfQFN93oZ9jtSgh/5wPgyaGTVMp3qLoPfAtMiccTTiLqak2cSo5a8w7QVeSA3785qOVvK64E7L1y8/w8eenT/4uDjUT+eSNxKnkxhtMqVPx6MG3X9jjcmfPgS38Od+XF1DyG7sY0r62SX2nkYhIFrg0nMWg1cy4UUgOxZ4/qjUN00SuXi1QnYjUGIawcValRty68GHzHWnWDPeXBxMHC+xzTOYIkC5Lb9Jdr9SyVe62ijERdDVR9mOFnjDoIgt4RFRNTGVraaCJI3kT4WKcdBsOlGeBWnutJGqLWDp17tocWRYWg7OV2VnopmrfOBgHWOoYNXl4rV8VKSRytvYCj12Bu2vQTrzWCuTjr69e+33/6JSnQYuhXyeyEJ5glljoCwgpJOFVU0Y5+5eVUIN5yLima51qpmScnF9+UBpfQegS0c9qDGPNXregjwY/iB4edYaWBWDBH1huw6KZLCtdMaK8i3n1HFKGdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(376014)(82310400026)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /rW+l759qSafS4SlPF515vCgLfnKtbz+L1uEOLH1h2s2+mKnJu8KCL8wp373SoZg60iJjH7CSVLXXuf4oX9GZnMy7R1ST9wm1j8AbJiw85XTn8HP/UoQYYa9b5BqHYtvv1pvFhZeWwboORox6AmRmQ84Ys61SnBCDz25qwR8lCg4jRJvcp2u11w701M0wJMK7jCsWTRa9r9JnmMTwxBQ9VdV/s1gzPZ1BtbhgxSZaFfjYZvvuhdzV7V6S3ITWymOlZF1gh8SnaQKYUsWMNDzI5vEjThuCD/Kq7O4ZisB5rQ4ImJjVEQls0EbnNTBIMzcQmM8aucB31rZCkocffwVHRfii30KQ5K6e12jD8C5EMZ+L3dtq6Y6csjLjvZ6ChmL5bHQH3r6AZT33h7HYPNpzzZ/9Z0qmR7mZv3jAdm7QwDt9rlR+S193p8sP4mVMPlL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:41.5218 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc7e333-c93e-49d7-477a-08defd667477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6703
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
Add KUnit tests for amdgpu_dm_plane_helper_prepare_fb() and
amdgpu_dm_plane_helper_cleanup_fb() covering the early return taken when
the plane state carries no framebuffer, so no buffer object is pinned or
unpinned.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 10 +++--
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.h   |  2 +
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 40 +++++++++++++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index b736cd13baaeb..096e1a5e37ad0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1223,8 +1223,8 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_plane_fill_plane_buffer_attributes);
 
-static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
-					     struct drm_plane_state *new_state)
+STATIC_IFN_KUNIT int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
+						       struct drm_plane_state *new_state)
 {
 	struct amdgpu_framebuffer *afb;
 	struct drm_gem_object *obj;
@@ -1321,9 +1321,10 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	amdgpu_bo_unreserve(rbo);
 	return r;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_helper_prepare_fb);
 
-static void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane,
-					      struct drm_plane_state *old_state)
+STATIC_IFN_KUNIT void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane,
+							struct drm_plane_state *old_state)
 {
 	struct amdgpu_bo *rbo;
 	int r;
@@ -1342,6 +1343,7 @@ static void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane,
 	amdgpu_bo_unreserve(rbo);
 	amdgpu_bo_unref(&rbo);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_plane_helper_cleanup_fb);
 
 STATIC_IFN_KUNIT void amdgpu_dm_plane_get_min_max_dc_plane_scaling(struct drm_device *dev,
 								   struct drm_framebuffer *fb,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
index b396b3ea78bae..d8ebe48abc9fa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.h
@@ -134,5 +134,7 @@ u64 amdgpu_dm_plane_calc_gfx6_mod(const struct amdgpu_device *adev, const u32 bp
 				  const enum array_mode_values arr);
 bool amdgpu_dm_plane_gfx6_format_mod_supported(const struct amdgpu_device *adev, const u32 bpp,
 					       const u64 modifier);
+int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane, struct drm_plane_state *new_state);
+void amdgpu_dm_plane_helper_cleanup_fb(struct drm_plane *plane, struct drm_plane_state *old_state);
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
index a0e7d012ccbab..7b3f0759cc1f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_plane_test.c
@@ -3559,6 +3559,42 @@ static void dm_test_format_mod_supported_gfx6(struct kunit *test)
 								listed_mod));
 }
 
+/**
+ * dm_test_helper_prepare_fb_no_fb() - Verify prepare_fb without a framebuffer.
+ * @test: KUnit test context.
+ *
+ * Verify if prepare_fb succeeds without touching any buffer object when the new
+ * plane state has no framebuffer bound.
+ */
+static void dm_test_helper_prepare_fb_no_fb(struct kunit *test)
+{
+	struct drm_plane_state state = {0};
+	struct drm_plane *plane;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_plane_helper_prepare_fb(plane, &state), 0);
+}
+
+/**
+ * dm_test_helper_cleanup_fb_no_fb() - Verify cleanup_fb without a framebuffer.
+ * @test: KUnit test context.
+ *
+ * Verify if cleanup_fb returns without unpinning anything when the old plane
+ * state has no framebuffer bound.
+ */
+static void dm_test_helper_cleanup_fb_no_fb(struct kunit *test)
+{
+	struct drm_plane_state state = {0};
+	struct drm_plane *plane;
+
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+
+	amdgpu_dm_plane_helper_cleanup_fb(plane, &state);
+}
+
 static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	/* amdgpu_dm_plane_is_video_format() */
 	KUNIT_CASE(dm_test_plane_is_video_format_known_video),
@@ -3624,6 +3660,10 @@ static struct kunit_case amdgpu_dm_plane_test_cases[] = {
 	KUNIT_CASE(dm_test_helper_check_state_small_viewport_height),
 	KUNIT_CASE(dm_test_helper_check_state_bottom_clipped_height),
 	KUNIT_CASE(dm_test_helper_check_state_scaling_caps),
+	/* amdgpu_dm_plane_helper_prepare_fb() */
+	KUNIT_CASE(dm_test_helper_prepare_fb_no_fb),
+	/* amdgpu_dm_plane_helper_cleanup_fb() */
+	KUNIT_CASE(dm_test_helper_cleanup_fb_no_fb),
 	/* amdgpu_dm_plane_atomic_async_check() */
 	KUNIT_CASE(dm_test_atomic_async_check_rejects),
 	KUNIT_CASE(dm_test_atomic_async_check_overlay_cursor),
-- 
2.43.0

