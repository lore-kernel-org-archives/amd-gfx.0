Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A789C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC0410E44E;
	Wed,  2 Sep 2026 05:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cQdFfwqz";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C62F10E44F
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QxbHtehrUBxNyt4qXYOBejrriLIAxsYpLHM/iJXkHXwDHNgqKyojCZcFAvrYTnZAGGwV7FcWzaRFz0ViYwb5Hr6HrKS7C6QgL8LD7FsH+DDnuyreKnMXdNCE42y3SRCXcxEc/tT1lG7yhF0zq3DCO45PAC71spDAN+dxt4NxQJgjkWWWEKvh9trDlAPnQrBhPb5fbBnQ8XVV23PwceX31l26t9ifU1Y04tXBMkuLEwYVOCv8MegKQDM+MyNZHJBYC6eGjBS3wTnV6uNtl6kgAR9wn8XoeAnqK+othKSeqBVpNL6O2KBOV88lGy4ZzSZfNurScZInU+68WEhX3lA4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dpfj1PWZ5g6qVacNLsiygXm2L/PxP/RNFitWIFdGf/c=;
 b=SMiY1whVPJOX96eWVRuT96V8OxSWTuF8mVMnIbkK8jNePBt6GcETKwpoKq9H/2EnzywB7xwflAlkswKcEYeg1b66ww+iimCMiv1PUgaWw2bcky+dDH4RciCpTZ2Uhz8YylPZ2bGXarFcTyz4OQYVYiYahmOtY+AfTc6RTxmq8VGKyNC55WqWWDOWVq+Vs3+2OQgx78BJjKl077GfsFZ3TvJpsFAcHzJIbFh1xCuKV9Ina3yUUHPNuPY5pSAhLxrlPwq6SenQ/C58pUpGSMiRwZD230qrPUGxxSa7nDDLRh+fjGopIAVRXOTf1yjr7MzHu7AMvldU+8/Q8249xxrBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dpfj1PWZ5g6qVacNLsiygXm2L/PxP/RNFitWIFdGf/c=;
 b=cQdFfwqzxqOmoz8xMeG3bMqmTzbZIBQVbZwl0zCi1JDozOPSX0FLSgXWsrPowfEUbmGdxc30G4X4rd2LrWnxZQw1RHqIO4WWDEDOAYOidNa1BS5GppxnbiGQQ41IEj7mEq7/BS3oRArWjEDPZh4N4x/CI9Xf7WKtaYCFV2gpvGs=
Received: from BN9PR03CA0286.namprd03.prod.outlook.com (2603:10b6:408:f5::21)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:06:05 +0000
Received: from BN1PEPF0001854C.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::aa) by BN9PR03CA0286.outlook.office365.com
 (2603:10b6:408:f5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 05:06:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0001854C.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:06:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:06:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:06:01 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:05:53 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 11/40] drm/amd/display: Test atomic validation guards
Date: Wed, 2 Sep 2026 12:58:33 +0800
Message-ID: <20260902050411.3473916-12-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854C:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 15248769-3990-429f-85c4-08df08afe3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: jC8SJxITH9RapKdaPwc4w0qDfdSE/Ps2WRFO32LNHXMr4mW5ahunSKQHu39WOISki7ZXVN1rSmglzBIAYWYYq5iwemjtZ+yDB56f0yMkb9doviHu+nZoOfKrO6vJlJ5lto+s0cx5D2Ha75QD2NlOYAev7uuC3SrVV1WxzkHod6bPiEZ89bwiBMrE6bKKbEeG1wbbIpghkhPwdfkS8gm28i8U+eHWRlsBs9XuVO2jV0hG/UekG9EOaxSHJTs/CCrV59ZOfiC8PpSnqOo/fDvsMhy0QlsmFOA//vmYLTB6FOp4qU2BZ4eVnz27k2h2WFsqq8KmVwO9VjNLNKkjYYilBQ1KHLhmBwhEZMQlyCtwFQzNViBkcEWKhsLSGVBZr/CvHnsELveAEDI5xtMHIEG3ftigYptT0WWB/21Ddweh9vszZnaBh6SpuyqLNef3Md4aGIVDU+hLV2R4LQCYaJUkxlCpxDy/6sEfmycxnDY4L6nhc5wGoT0Y4IvAi7x2FNyw8dGIEW1vHnbCokAd0nF1iZ/dp3q7yD4S1s4BUAgCqmq6frnwZWJN3hy+LUV0JpTcEkQ7y6iltqR7Dce+8NAcpr0K02zJPASAcWb+VziR8+2qAOeHXFG4ImdvhAJ+CVzOmqtCwXaFKUgVIV44bCPbVs8qoUSNWsJbJUiiARK164zOGEDXMxrohnzsHicvWMuaZWHTEnIYPToI0U8eK3EtMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZoEs1kWFVJ16ReJzhUAgo4NLzjOKgGd3qwIoFzBiQcDomXSzofiohYUTVal8iLMWBmPYaFi6CPHYSzWCVtw53Mnq4zl063SpUirB7ecCB1xDaQ+tXwfSx04gXPD3WbHUcpDXFrdjLaaDCjizp4n9RMC6LXGDj29rrSNbMb3lKdnK24vvsDB+HSEP1B6I0ZpTDxNBuTjjF7CXoR0ztR35jI40iPttqv0j0sTjuCyUjQuP0FdGSc8CwXAuMlfyj2pqSiVHjPpBsb6tVslrLMm+IFjrwOghgC5APUBp6WErXLSodwcBRc7HOXkcDJdBOe+t9KWM0d5SJIK+UGoRFWvvrx85+hMyCg3vqapiTeJehRSjfhpEdBhoqfD/LMJCjn2biyPuKqkFMUVNVIj1oeKtlP5NPaLYosT4PzK8vi8KrwQO9jhmK++EQtpuPFlnd5NR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:06:04.4034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15248769-3990-429f-85c4-08df08afe3d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0001854C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
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

[Why]
Add KUnit tests for an empty amdgpu_dm_atomic_check(), an unchanged
CRTC update, and a detached plane update.

[How]
Use standard DRM KUnit objects and existing state fixtures so each
helper reaches its software-only early return without DC hardware
programming.

Assisted-by: Copilot:Claude-Opus-5 GPT-5.6 Sol
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 40 +++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 17 +++++
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 76 +++++++++++++++++++
 3 files changed, 116 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d94d18e884ef..9f64bea15ea1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -145,8 +145,10 @@ STATIC_IFN_KUNIT int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *sta
 static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state);
 STATIC_IFN_KUNIT void dm_enable_per_frame_crtc_master_sync(struct dc_state *context);
 
+#if !IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_commit *state);
+#endif
 
 static inline void amdgpu_dm_exit_ips_for_hw_access(struct dc *dc)
 {
@@ -5428,13 +5430,13 @@ STATIC_IFN_KUNIT int do_aquire_global_lock(struct drm_device *dev,
 }
 EXPORT_IF_KUNIT(do_aquire_global_lock);
 
-static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
-			 struct drm_atomic_commit *state,
-			 struct drm_crtc *crtc,
-			 struct drm_crtc_state *old_crtc_state,
-			 struct drm_crtc_state *new_crtc_state,
-			 bool enable,
-			 bool *lock_and_validation_needed)
+STATIC_IFN_KUNIT int dm_update_crtc_state(struct amdgpu_display_manager *dm,
+					  struct drm_atomic_commit *state,
+					  struct drm_crtc *crtc,
+					  struct drm_crtc_state *old_crtc_state,
+					  struct drm_crtc_state *new_crtc_state,
+					  bool enable,
+					  bool *lock_and_validation_needed)
 {
 	struct dm_atomic_state *dm_state = NULL;
 	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
@@ -5703,6 +5705,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 		dc_stream_release(new_stream);
 	return ret;
 }
+EXPORT_IF_KUNIT(dm_update_crtc_state);
 
 STATIC_IFN_KUNIT bool should_reset_plane(struct drm_atomic_commit *state,
 					 struct drm_plane *plane,
@@ -5869,14 +5872,15 @@ STATIC_IFN_KUNIT bool should_reset_plane(struct drm_atomic_commit *state,
 }
 EXPORT_IF_KUNIT(should_reset_plane);
 
-static int dm_update_plane_state(struct dc *dc,
-				 struct drm_atomic_commit *state,
-				 struct drm_plane *plane,
-				 struct drm_plane_state *old_plane_state,
-				 struct drm_plane_state *new_plane_state,
-				 bool enable,
-				 bool *lock_and_validation_needed,
-				 bool *is_top_most_overlay)
+STATIC_IFN_KUNIT int
+dm_update_plane_state(struct dc *dc,
+		      struct drm_atomic_commit *state,
+		      struct drm_plane *plane,
+		      struct drm_plane_state *old_plane_state,
+		      struct drm_plane_state *new_plane_state,
+		      bool enable,
+		      bool *lock_and_validation_needed,
+		      bool *is_top_most_overlay)
 {
 
 	struct dm_atomic_state *dm_state = NULL;
@@ -6040,6 +6044,7 @@ static int dm_update_plane_state(struct dc *dc,
 
 	return ret;
 }
+EXPORT_IF_KUNIT(dm_update_plane_state);
 
 /*
  * The normalized_zpos value cannot be used by this iterator directly. It's only
@@ -6166,8 +6171,8 @@ EXPORT_IF_KUNIT(amdgpu_dm_crtc_mem_type_changed);
  *
  * Return: -Error code if validation failed.
  */
-static int amdgpu_dm_atomic_check(struct drm_device *dev,
-				  struct drm_atomic_commit *state)
+STATIC_IFN_KUNIT int amdgpu_dm_atomic_check(struct drm_device *dev,
+					    struct drm_atomic_commit *state)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct dm_atomic_state *dm_state = NULL;
@@ -6678,6 +6683,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 
 	return ret;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_atomic_check);
 
 void amdgpu_dm_trigger_timing_sync(struct drm_device *dev)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3c63dfcc2343..c99a84bb040e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1208,6 +1208,23 @@ void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state);
 int amdgpu_dm_atomic_setup_commit(struct drm_atomic_commit *state);
 int do_aquire_global_lock(struct drm_device *dev,
 			  struct drm_atomic_commit *state);
+int dm_update_crtc_state(struct amdgpu_display_manager *dm,
+			 struct drm_atomic_commit *state,
+			 struct drm_crtc *crtc,
+			 struct drm_crtc_state *old_crtc_state,
+			 struct drm_crtc_state *new_crtc_state,
+			 bool enable,
+			 bool *lock_and_validation_needed);
+int dm_update_plane_state(struct dc *dc,
+			  struct drm_atomic_commit *state,
+			  struct drm_plane *plane,
+			  struct drm_plane_state *old_plane_state,
+			  struct drm_plane_state *new_plane_state,
+			  bool enable,
+			  bool *lock_and_validation_needed,
+			  bool *is_top_most_overlay);
+int amdgpu_dm_atomic_check(struct drm_device *dev,
+			   struct drm_atomic_commit *state);
 void amdgpu_dm_mod_power_update_streams(struct drm_atomic_commit *state,
 					struct amdgpu_display_manager *dm);
 void amdgpu_dm_mod_power_setup_streams(struct drm_atomic_commit *state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 3209608a41b8..6335fc23e977 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -2990,6 +2990,21 @@ static void dm_test_atomic_setup_commit_empty(struct kunit *test)
 			0);
 }
 
+/**
+ * dm_test_atomic_check_empty - Test an empty atomic commit needs no DC validation
+ * @test: The KUnit test context
+ */
+static void dm_test_atomic_check_empty(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct drm_atomic_commit *state = dm_test_alloc_commit(test, adev);
+
+	adev->dm.dc = dm_kunit_alloc_dc_with_ctx(test);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_atomic_check(&adev->ddev, state), 0);
+	KUNIT_EXPECT_EQ(test, state->num_private_objs, 0U);
+}
+
 /*
  * A commit with one connector of @type bound to a CRTC that keeps its stream.
  * The content protection state is unchanged, so amdgpu_dm_update_hdcp() walks
@@ -3172,6 +3187,64 @@ static void dm_test_aquire_global_lock_waits_commit(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ret, 0);
 }
 
+/**
+ * dm_test_update_crtc_state_unchanged - Test unchanged state needs no validation
+ * @test: The KUnit test context
+ */
+static void dm_test_update_crtc_state_unchanged(struct kunit *test)
+{
+	struct dm_test_reset_plane_ctx *ctx = dm_test_reset_plane_ctx_alloc(test);
+	bool lock_and_validation_needed = false;
+
+	ctx->adev->dm.adev = ctx->adev;
+	KUNIT_EXPECT_EQ(test,
+			dm_update_crtc_state(&ctx->adev->dm, ctx->state, ctx->crtc,
+					     &ctx->old_crtc_state->base,
+					     &ctx->new_crtc_state->base, true,
+					     &lock_and_validation_needed),
+			0);
+	KUNIT_EXPECT_FALSE(test, lock_and_validation_needed);
+	KUNIT_EXPECT_NULL(test, ctx->new_crtc_state->stream);
+}
+
+/**
+ * dm_test_update_plane_state_detached - Test a detached plane needs no DC update
+ * @test: The KUnit test context
+ */
+static void dm_test_update_plane_state_detached(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+	struct dm_plane_state *old_plane_state;
+	struct dm_plane_state *new_plane_state;
+	struct drm_plane *plane;
+	bool lock_and_validation_needed = false;
+	bool is_top_most_overlay = true;
+
+	old_plane_state = kunit_kzalloc(test, sizeof(*old_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, old_plane_state);
+	new_plane_state = kunit_kzalloc(test, sizeof(*new_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, new_plane_state);
+	plane = kunit_kzalloc(test, sizeof(*plane), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, plane);
+	adev->reset_domain = kunit_kzalloc(test, sizeof(*adev->reset_domain), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->reset_domain);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 2, 0);
+	plane->dev = &adev->ddev;
+	plane->type = DRM_PLANE_TYPE_PRIMARY;
+
+	KUNIT_EXPECT_EQ(test,
+			dm_update_plane_state(NULL, dm_test_alloc_commit(test, adev), plane,
+					      &old_plane_state->base,
+					      &new_plane_state->base, false,
+					      &lock_and_validation_needed,
+					      &is_top_most_overlay),
+			0);
+	KUNIT_EXPECT_FALSE(test, lock_and_validation_needed);
+	KUNIT_EXPECT_TRUE(test, is_top_most_overlay);
+	KUNIT_EXPECT_NULL(test, new_plane_state->dc_state);
+}
+
 /**
  * dm_test_mod_power_update_streams_empty - Test an empty commit updates no streams
  * @test: The KUnit test context
@@ -5251,9 +5324,12 @@ static struct kunit_case amdgpu_dm_tests[] = {
 	KUNIT_CASE(dm_test_atomic_setup_commit_color_mgmt),
 	KUNIT_CASE(dm_test_atomic_setup_commit_modeset),
 	KUNIT_CASE(dm_test_atomic_setup_commit_bad_lut),
+	KUNIT_CASE(dm_test_atomic_check_empty),
 	KUNIT_CASE(dm_test_aquire_global_lock_no_crtc),
 	KUNIT_CASE(dm_test_aquire_global_lock_no_commit),
 	KUNIT_CASE(dm_test_aquire_global_lock_waits_commit),
+	KUNIT_CASE(dm_test_update_crtc_state_unchanged),
+	KUNIT_CASE(dm_test_update_plane_state_detached),
 	KUNIT_CASE(dm_test_mod_power_update_streams_empty),
 	KUNIT_CASE(dm_test_mod_power_update_streams_no_modeset),
 	KUNIT_CASE(dm_test_mod_power_update_streams_enable),
-- 
2.43.0

