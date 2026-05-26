Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E714ECD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 849A310E4F5;
	Tue, 26 May 2026 07:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aYoBg/Kx";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EB9910E4F5
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebN/wzWJwNge1BQ3WnitpA8dmiJPp/Z+8E0AeASS5ssSW5GQGC341ft3btsvxOr/Gt/zEU31a68v7QC5DdwUZbQQzIKICjpVXNuYKNTXRHtnnV547Ul1zZRXGcGgStkfUItBS2UNSnG6u16EnxiN0Yy1B78u0HKsmX7Y1Q+QPT8fQi96teU2fCUsDAIGyCuSOwNOzYxVZxinjiJN4owaL+A/zoWwwp76gTuSXVXBITyCaK7R+uft/A7c1WfcR6jRfOlQBL7AmPoj33VyPBNXwB4ezNYKR7V2iWX3kHseXe16vbpr6qxtCF0WYuMfbI5BTnTpzMpAb8q7DvND7KFJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KFNXQltPljUsH4Dt9a7/XblaGkVYQx67RohufwjehQ4=;
 b=gQiD4p/FEKgieuTwG8gkFFPKW3mGBTo6SaDu+L2qSKY9SOWZeXJl+5PH00wXCwyw3eZckg0vVQQ0QKUsSVJTrNZOfQreHReFVWgdNiXhNYIilmk4+2sjH4F3CamSE3G+88wzV/rSaKGOkh5CYZ+IiAAfxXSojKgqbR3+sQlBJHTiQ8lkkuq1Yt7uzpnC++wqPOwb9iD2FxOpSmSNewveyb3J0jTA8ebGG/Cknj4/2stn09P42fOrAVhWeB87kM04J/rUKeozVReWrdPoNZG7tLQ63z2xR821OcNdzP760tHXb6kppMElmDF3Nhc2CDqDb9JqNcORKXCd9sJ4jkPyRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KFNXQltPljUsH4Dt9a7/XblaGkVYQx67RohufwjehQ4=;
 b=aYoBg/KxISLXUf/CbBy2dtqPz3ZfAd0JelwP5HIAlckAaD+/lLKbmH0Q+/vRMiXW/qmtZcXk3d2zk0ubyfcgOkSehJj7xeciZQAZlAqPQxYcdoxZFtjsVXdtG77p+VeFnEFnJiyhRb4todjfa3raPwGa2rpaoFN+Ec42Hu5l+LU=
Received: from PH8P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::17)
 by CY3PR12MB9605.namprd12.prod.outlook.com (2603:10b6:930:103::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:17:17 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::51) by PH8P223CA0012.outlook.office365.com
 (2603:10b6:510:2db::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:17:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:17:15 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:17:15 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:17:07 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 20/41] drm/amd/display: Add KUnit tests for color LUT functions
Date: Tue, 26 May 2026 15:01:43 +0800
Message-ID: <20260526071413.2181251-21-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CY3PR12MB9605:EE_
X-MS-Office365-Filtering-Correlation-Id: c58e697e-d29f-4ff2-7bfb-08debaf6d0ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|6133799003|3023799007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vg2I7kDcrOZoF5u4AOjdRjmeciB0+0C73t84doJxra58Lrqw61Cw+bzI3iEZWc1CzT9oGwjBOKatDTxVRkJvyXf9IajIgY/q1Lo3XrGAx6uTVbflP2HR/IcyxAS8licbCPS8oyJ4HAko+qUJ1FqCKOKHYhns8irdnLQHH+m3gQHfPx+1LbKjk9oV3ief6IJmhtcXqhtadgEr8NTUemSPYzUHKKV5pthVFOSd632s+GK4/kS98pRmQOsXhiBOPehgR7fNPh2g+XVT9tBzy7w4oEcRSxNylM2t90bVgrgpIFSfxBiJbPQoRXv+UY+vhZ0JWOGT5JNGqD8TF6B/jzofidRLlJf9CR4Bc69sp7oA0ikM30DnONdcSoq+Yo7r2rFyN0wVL7TXdicphi8ImOnmyCs9MJXia2UU3gLmeJWBlSsjTNT8kBEBdPQBBGlL0WcUxWef7dt+Vxozr+cR85ZmYmjdusNXHrQz8Hopz/fFIldcsM+PRulB+N5ORQKlhmOB7a3UDajhr87wr953+aQKDFsGxyFS6pDA6bYPY13xcG7IRQ15O11AnC++BlOd5EyMuEYepW0VAwefHj0XN3NjmTFYvoJNDKz91O8Uso7qR5+PMkDBrPc7ACgenPAXe4SffVRrRExDrExIfTlFOVTBFyQaz1nvdKPUiX/jnOiK/bUx2wT4Visgi84EK9yrZC41OkiSUDbzO939C7GzYbJ/1LhTPBFWiru0RWxJzZfhILo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(6133799003)(3023799007)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OdCLpSll7wRSmYAOD2/t/vIjAVcUSk9FHrqir+vuhI9Nw6qTk764h2xlDNN1je3oED5b0/aR/sUlc0040rsXFSZ50nCFDwpbWwVcnAphEXgD/BrUzRPXemLKNnEWdapVT0xt3RNAjImROLjm2DgFnoCNOn2nI7k1KvKHqYIZAAuHoDF4ImzSV1guInp2U71ColCVvatULH9Q66/4wgXNYvU6sbqhB0mIQaRAT/Aha4nB/pXzNTvAjONJ36SCjTn8XfSgLi0HwPDIvrO7/S89yQle9E7EJWt284kncu60Pi8/8of2yZQgb1865ZMXb4lpz+czL+ogK5OT5k759GQUIyjNqAx3RfED30KEvC0jeLPVuUm6UFlujzIMt4wbIbfEV2CDahil2PHBIae+POewUg8v/1cdIgYuG7afllQNtmzbieE9+9Qzjz638z5bmIb/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:17:16.3435 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c58e697e-d29f-4ff2-7bfb-08debaf6d0ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9605
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
Add KUnit tests for three color management functions in
amdgpu_dm_color.c: amdgpu_dm_verify_lut_sizes,
amdgpu_dm_atomic_lut3d, and __set_colorop_3dlut.

[How]
Export amdgpu_dm_verify_lut_sizes with EXPORT_IF_KUNIT. Change
amdgpu_dm_atomic_lut3d and __set_colorop_3dlut from static to
STATIC_IFN_KUNIT and export them with EXPORT_IF_KUNIT. Add their
prototypes to amdgpu_dm_color.h inside the KUnit guard block.

Implement 14 test cases in amdgpu_dm_color_test.c:
- 8 tests for amdgpu_dm_verify_lut_sizes covering null LUTs,
  valid and invalid degamma/gamma sizes, both valid, and priority
- 3 tests for amdgpu_dm_atomic_lut3d covering zero size clearing
  initialized state, nonzero setting state bits and mode flags,
  and LUT data forwarding to tetrahedral_17
- 3 tests for __set_colorop_3dlut covering zero size returning
  -EINVAL and clearing initialized state, nonzero returning 0
  and setting state bits, and 32-bit LUT data forwarding to
  tetrahedral_17

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  15 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |   7 +
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 342 ++++++++++++++++++
 3 files changed, 358 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index a47790f7cf5e..bb4f85c7033e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1044,9 +1044,9 @@ EXPORT_IF_KUNIT(__drm_3dlut32_to_dc_3dlut);
  * Map user 3D LUT data to DC 3D LUT and all necessary bits to program it
  * on DCN accordingly.
  */
-static void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut3d,
-				   uint32_t drm_lut3d_size,
-				   struct dc_3dlut *lut)
+STATIC_IFN_KUNIT void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut3d,
+				     uint32_t drm_lut3d_size,
+				     struct dc_3dlut *lut)
 {
 	if (!drm_lut3d_size) {
 		lut->state.bits.initialized = 0;
@@ -1062,6 +1062,7 @@ static void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut3d,
 					MAX_COLOR_3DLUT_BITDEPTH);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_atomic_lut3d);
 
 static int amdgpu_dm_atomic_shaper_lut(const struct drm_color_lut *shaper_lut,
 				       bool has_rom,
@@ -1198,6 +1199,7 @@ int amdgpu_dm_verify_lut_sizes(const struct drm_crtc_state *crtc_state)
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_verify_lut_sizes);
 
 /**
  * amdgpu_dm_check_crtc_color_mgmt: Check if DRM color props are programmable by DC.
@@ -1705,9 +1707,9 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
  * Returns:
  * 0 on success. -EINVAL if drm_lut3d_size is zero.
  */
-static int __set_colorop_3dlut(const struct drm_color_lut32 *drm_lut3d,
-				uint32_t drm_lut3d_size,
-				struct dc_3dlut *lut)
+STATIC_IFN_KUNIT int __set_colorop_3dlut(const struct drm_color_lut32 *drm_lut3d,
+					 uint32_t drm_lut3d_size,
+					 struct dc_3dlut *lut)
 {
 	if (!drm_lut3d_size) {
 		lut->state.bits.initialized = 0;
@@ -1724,6 +1726,7 @@ static int __set_colorop_3dlut(const struct drm_color_lut32 *drm_lut3d,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(__set_colorop_3dlut);
 
 static int
 __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
index 19d3a13572f5..6f4e97fe6694 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
@@ -84,6 +84,13 @@ void __drm_3dlut32_to_dc_3dlut(const struct drm_color_lut32 *lut,
 				struct tetrahedral_params *params,
 				bool use_tetrahedral_9,
 				int bit_depth);
+struct dc_3dlut;
+void amdgpu_dm_atomic_lut3d(const struct drm_color_lut *drm_lut3d,
+			     uint32_t drm_lut3d_size,
+			     struct dc_3dlut *lut);
+int __set_colorop_3dlut(const struct drm_color_lut32 *drm_lut3d,
+			uint32_t drm_lut3d_size,
+			struct dc_3dlut *lut);
 #endif
 
 #endif /* __AMDGPU_DM_COLOR_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index 377fa4342ca1..56eea0f5a75d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -991,6 +991,331 @@ static void dm_test_3dlut32_to_dc_3dlut_green_blue(struct kunit *test)
 			drm_color_lut32_extract(600000, 12));
 }
 
+/* ---- Tests for amdgpu_dm_verify_lut_sizes ---- */
+
+/**
+ * dm_test_make_lut_blob - Allocate a fake drm_property_blob for testing
+ * @test: KUnit test context
+ * @num_entries: number of LUT entries the blob will report
+ *
+ * Allocates a fake blob whose drm_color_lut_size() returns exactly
+ * @num_entries.  The data pointer is non-NULL so that
+ * __extract_blob_lut() returns a non-NULL lut pointer and the size
+ * check inside amdgpu_dm_verify_lut_sizes() is actually exercised.
+ *
+ * Return: pointer to the allocated blob
+ */
+static struct drm_property_blob *
+dm_test_make_lut_blob(struct kunit *test, uint32_t num_entries)
+{
+	struct drm_property_blob *blob;
+
+	blob = kunit_kzalloc(test, sizeof(*blob), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob);
+
+	blob->length = num_entries * sizeof(struct drm_color_lut);
+	blob->data = kunit_kcalloc(test, num_entries,
+				   sizeof(struct drm_color_lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, blob->data);
+
+	return blob;
+}
+
+/**
+ * dm_test_verify_lut_sizes_null_luts - Both LUTs absent: must succeed
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut_sizes_null_luts(struct kunit *test)
+{
+	struct drm_crtc_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	/* degamma_lut and gamma_lut are NULL (zeroed allocation) */
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut_sizes(state), 0);
+}
+
+/**
+ * dm_test_verify_lut_sizes_valid_degamma - Degamma LUT with the correct atomic size: must succeed
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut_sizes_valid_degamma(struct kunit *test)
+{
+	struct drm_crtc_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	state->degamma_lut = dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut_sizes(state), 0);
+}
+
+/**
+ * dm_test_verify_lut_sizes_invalid_degamma - Degamma LUT with a wrong size: must return -EINVAL
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut_sizes_invalid_degamma(struct kunit *test)
+{
+	struct drm_crtc_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	/* Use an arbitrary size that is neither atomic nor legacy */
+	state->degamma_lut = dm_test_make_lut_blob(test, 128);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut_sizes(state), -EINVAL);
+}
+
+/**
+ * dm_test_verify_lut_sizes_valid_gamma_atomic - Gamma LUT with correct atomic size: must succeed
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut_sizes_valid_gamma_atomic(struct kunit *test)
+{
+	struct drm_crtc_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	state->gamma_lut = dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut_sizes(state), 0);
+}
+
+/**
+ * dm_test_verify_lut_sizes_valid_gamma_legacy - Gamma LUT with legacy 256-entry size: must succeed
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut_sizes_valid_gamma_legacy(struct kunit *test)
+{
+	struct drm_crtc_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	state->gamma_lut = dm_test_make_lut_blob(test, MAX_COLOR_LEGACY_LUT_ENTRIES);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut_sizes(state), 0);
+}
+
+/**
+ * dm_test_verify_lut_sizes_invalid_gamma - Size is neither atomic nor legacy: must return -EINVAL
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut_sizes_invalid_gamma(struct kunit *test)
+{
+	struct drm_crtc_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	state->gamma_lut = dm_test_make_lut_blob(test, 128);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut_sizes(state), -EINVAL);
+}
+
+/**
+ * dm_test_verify_lut_sizes_both_valid - Both LUTs set to valid sizes: must succeed
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut_sizes_both_valid(struct kunit *test)
+{
+	struct drm_crtc_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	state->degamma_lut = dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+	state->gamma_lut   = dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut_sizes(state), 0);
+}
+
+/**
+ * dm_test_verify_lut_sizes_invalid_degamma_valid_gamma - Bad degamma overrides valid gamma: -EINVAL
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut_sizes_invalid_degamma_valid_gamma(struct kunit *test)
+{
+	struct drm_crtc_state *state;
+
+	state = kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, state);
+
+	state->degamma_lut = dm_test_make_lut_blob(test, 128);
+	state->gamma_lut   = dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut_sizes(state), -EINVAL);
+}
+
+/* ---- Tests for amdgpu_dm_atomic_lut3d ---- */
+
+/**
+ * dm_test_atomic_lut3d_zero_size - Zero LUT size: initialized must be cleared, no LUT data written
+ * @test: KUnit test context
+ */
+static void dm_test_atomic_lut3d_zero_size(struct kunit *test)
+{
+	struct dc_3dlut *lut;
+	u32 initialized;
+
+	lut = kunit_kzalloc(test, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	/* Pre-set initialized so we can confirm it is cleared */
+	lut->state.bits.initialized = 1;
+
+	amdgpu_dm_atomic_lut3d(NULL, 0, lut);
+
+	/* Copy bit-field: typeof cannot be applied to a bit-field */
+	initialized = lut->state.bits.initialized;
+	KUNIT_EXPECT_EQ(test, initialized, 0U);
+}
+
+/**
+ * dm_test_atomic_lut3d_nonzero_state_bits - Non-zero size: state bits and mode flags must be set
+ * @test: KUnit test context
+ */
+static void dm_test_atomic_lut3d_nonzero_state_bits(struct kunit *test)
+{
+	const uint32_t lut3d_size = 5;
+	struct drm_color_lut *lut_data;
+	struct dc_3dlut *lut;
+	u32 initialized;
+
+	lut_data = kunit_kcalloc(test, lut3d_size, sizeof(*lut_data), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut_data);
+
+	lut = kunit_kzalloc(test, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	amdgpu_dm_atomic_lut3d(lut_data, lut3d_size, lut);
+
+	/* Copy bit-field: typeof cannot be applied to a bit-field */
+	initialized = lut->state.bits.initialized;
+	KUNIT_EXPECT_EQ(test, initialized, 1U);
+	KUNIT_EXPECT_FALSE(test, lut->lut_3d.use_tetrahedral_9);
+	KUNIT_EXPECT_TRUE(test, lut->lut_3d.use_12bits);
+}
+
+/**
+ * dm_test_atomic_lut3d_data_forwarded - Non-zero size: LUT data forwarded to tetrahedral_17
+ * @test: KUnit test context
+ */
+static void dm_test_atomic_lut3d_data_forwarded(struct kunit *test)
+{
+	const uint32_t lut3d_size = 5;
+	struct drm_color_lut *lut_data;
+	struct dc_3dlut *lut;
+
+	lut_data = kunit_kcalloc(test, lut3d_size, sizeof(*lut_data), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut_data);
+
+	lut = kunit_kzalloc(test, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	lut_data[0].red   = 0xFFFF;
+	lut_data[0].green = 0x8000;
+	lut_data[0].blue  = 0x4000;
+
+	amdgpu_dm_atomic_lut3d(lut_data, lut3d_size, lut);
+
+	/*
+	 * use_tetrahedral_9 == false → data goes into tetrahedral_17.
+	 * lut[0] maps to lut0[0] (first element of the first group).
+	 */
+	KUNIT_EXPECT_EQ(test, lut->lut_3d.tetrahedral_17.lut0[0].red,
+			drm_color_lut_extract(0xFFFF, MAX_COLOR_3DLUT_BITDEPTH));
+	KUNIT_EXPECT_EQ(test, lut->lut_3d.tetrahedral_17.lut0[0].green,
+			drm_color_lut_extract(0x8000, MAX_COLOR_3DLUT_BITDEPTH));
+	KUNIT_EXPECT_EQ(test, lut->lut_3d.tetrahedral_17.lut0[0].blue,
+			drm_color_lut_extract(0x4000, MAX_COLOR_3DLUT_BITDEPTH));
+}
+
+/* ---- Tests for __set_colorop_3dlut ---- */
+
+/**
+ * dm_test_set_colorop_3dlut_zero_size - Zero LUT size: must return -EINVAL and clear initialized
+ * @test: KUnit test context
+ */
+static void dm_test_set_colorop_3dlut_zero_size(struct kunit *test)
+{
+	struct dc_3dlut *lut;
+	u32 initialized;
+
+	lut = kunit_kzalloc(test, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	lut->state.bits.initialized = 1;
+
+	KUNIT_EXPECT_EQ(test, __set_colorop_3dlut(NULL, 0, lut), -EINVAL);
+	/* Copy bit-field: typeof cannot be applied to a bit-field */
+	initialized = lut->state.bits.initialized;
+	KUNIT_EXPECT_EQ(test, initialized, 0U);
+}
+
+/**
+ * dm_test_set_colorop_3dlut_nonzero_state_bits - Non-zero size: must return 0 and set state bits
+ * @test: KUnit test context
+ */
+static void dm_test_set_colorop_3dlut_nonzero_state_bits(struct kunit *test)
+{
+	const uint32_t lut3d_size = 5;
+	struct drm_color_lut32 *lut_data;
+	struct dc_3dlut *lut;
+	u32 initialized;
+
+	lut_data = kunit_kcalloc(test, lut3d_size, sizeof(*lut_data), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut_data);
+
+	lut = kunit_kzalloc(test, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	KUNIT_EXPECT_EQ(test, __set_colorop_3dlut(lut_data, lut3d_size, lut), 0);
+	/* Copy bit-field: typeof cannot be applied to a bit-field */
+	initialized = lut->state.bits.initialized;
+	KUNIT_EXPECT_EQ(test, initialized, 1U);
+	KUNIT_EXPECT_FALSE(test, lut->lut_3d.use_tetrahedral_9);
+	KUNIT_EXPECT_TRUE(test, lut->lut_3d.use_12bits);
+}
+
+/**
+ * dm_test_set_colorop_3dlut_data_forwarded - Non-zero size: 32-bit data forwarded to tetrahedral_17
+ * @test: KUnit test context
+ */
+static void dm_test_set_colorop_3dlut_data_forwarded(struct kunit *test)
+{
+	const uint32_t lut3d_size = 5;
+	struct drm_color_lut32 *lut_data;
+	struct dc_3dlut *lut;
+
+	lut_data = kunit_kcalloc(test, lut3d_size, sizeof(*lut_data), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut_data);
+
+	lut = kunit_kzalloc(test, sizeof(*lut), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, lut);
+
+	lut_data[0].red   = 0xFFFFFFFF;
+	lut_data[0].green = 0x80000000;
+	lut_data[0].blue  = 0x40000000;
+
+	KUNIT_EXPECT_EQ(test, __set_colorop_3dlut(lut_data, lut3d_size, lut), 0);
+
+	/*
+	 * use_tetrahedral_9 == false → data goes into tetrahedral_17.
+	 * lut[0] maps to lut0[0].  Bit depth used by __set_colorop_3dlut is 12.
+	 */
+	KUNIT_EXPECT_EQ(test, lut->lut_3d.tetrahedral_17.lut0[0].red,
+			drm_color_lut32_extract(0xFFFFFFFF, 12));
+	KUNIT_EXPECT_EQ(test, lut->lut_3d.tetrahedral_17.lut0[0].green,
+			drm_color_lut32_extract(0x80000000, 12));
+	KUNIT_EXPECT_EQ(test, lut->lut_3d.tetrahedral_17.lut0[0].blue,
+			drm_color_lut32_extract(0x40000000, 12));
+}
+
 static struct kunit_case dm_color_test_cases[] = {
 	/* amdgpu_dm_fixpt_from_s3132 */
 	KUNIT_CASE(dm_test_fixpt_from_s3132_zero),
@@ -1056,6 +1381,23 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_3dlut32_to_dc_3dlut_distribution),
 	KUNIT_CASE(dm_test_3dlut32_to_dc_3dlut_tetrahedral_17),
 	KUNIT_CASE(dm_test_3dlut32_to_dc_3dlut_green_blue),
+	/* amdgpu_dm_verify_lut_sizes */
+	KUNIT_CASE(dm_test_verify_lut_sizes_null_luts),
+	KUNIT_CASE(dm_test_verify_lut_sizes_valid_degamma),
+	KUNIT_CASE(dm_test_verify_lut_sizes_invalid_degamma),
+	KUNIT_CASE(dm_test_verify_lut_sizes_valid_gamma_atomic),
+	KUNIT_CASE(dm_test_verify_lut_sizes_valid_gamma_legacy),
+	KUNIT_CASE(dm_test_verify_lut_sizes_invalid_gamma),
+	KUNIT_CASE(dm_test_verify_lut_sizes_both_valid),
+	KUNIT_CASE(dm_test_verify_lut_sizes_invalid_degamma_valid_gamma),
+	/* amdgpu_dm_atomic_lut3d */
+	KUNIT_CASE(dm_test_atomic_lut3d_zero_size),
+	KUNIT_CASE(dm_test_atomic_lut3d_nonzero_state_bits),
+	KUNIT_CASE(dm_test_atomic_lut3d_data_forwarded),
+	/* __set_colorop_3dlut */
+	KUNIT_CASE(dm_test_set_colorop_3dlut_zero_size),
+	KUNIT_CASE(dm_test_set_colorop_3dlut_nonzero_state_bits),
+	KUNIT_CASE(dm_test_set_colorop_3dlut_data_forwarded),
 	{}
 };
 
-- 
2.43.0

