Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2C8C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C006B10F084;
	Wed, 15 Jul 2026 13:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XZhy93Ws";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F135010F085
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQ+aJiSXQCdIR2SgMGAGW+DDQTs+ZhbkOEaAeGIqcO3e7aaH4pzBkVmCiDJg8bW4ecriw9SSimMZH4gZKFVw2cKI6/ulwda4GPOlu4KMFjumGX0bVTswmhR/oTND92+U7i4b/rRM1iWswcvLSNvUE8ZZan5+gMsY7N5QAyx3UajLv3kzCkBIE7+c1vRt7gpcXWrehS02aLb0kQOXfO1Af/7bJN2+9y+cBuQpv5I2MoEkRk8i9yTQjzYSXjcmoTm4pw3ZxViAPx2fEg/w3bDXwIs/VE6DBkFAQfnNJ3OA5V74No5RqMgfxSmShao0ZLRh5d6WALRmU8mVQKXbE79PYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIuT2x9krN3Gl8DXeuruPXQLRzVOJ18GGiQv3ymd2kU=;
 b=wLUKAZTFE8MWWEM5vzon8rcgZmUNEzPctAp8yUwLsdvQ2QJxyEGHNvQSsbqN3f6CX8zdsf/u0UdlxJzY+ejBtvi2l+VPckOCk5ue38bypqptBCLmuCRclGJS0WZRqJbE+booFHn33BJVbEGcK09OrkgtoiuTtqfFZ++lpNBhRaUASf5vVlEajZlRtyFVMfvP4eKF/tQHw/MnXLXk28g/jR0djYVU3PlpUD8B08fCp6zyJtOjR9zy9d7fFnQfRhGR0bHN6AeGO6MDiapx4VqFUqurcJxJTjJSEbNscwoEk9svHiHEiSdoqPAJxnRd4OlGba4NDWOXPaWotgQ07ETLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIuT2x9krN3Gl8DXeuruPXQLRzVOJ18GGiQv3ymd2kU=;
 b=XZhy93WsObzLKI596yN0POuYQ/N0bcA/ejftCl5TfzkAH8P/bV4MSyqixQI2y0cOvh7VVbswzoqyFa5h5Za5Xqpj8OHGML30LdBJhgbosnCqBfWeVA1XxGAOYFfMxctC2ghAAorYsVwjI6yVfue+NUQ6h8M4u1nAnG4ykCVeJ4g=
Received: from PH8P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::10)
 by BN7PPF34483F4BA.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cb) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 13:46:30 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::2b) by PH8P220CA0019.outlook.office365.com
 (2603:10b6:510:345::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:46:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:46:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:46:28 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:46:24 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 25/70] drm/amd/display: Test color mod init and 3D LUT size
Date: Wed, 15 Jul 2026 21:37:35 +0800
Message-ID: <20260715134432.1975118-26-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|BN7PPF34483F4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: 34adb9a4-140b-4f56-c5b0-08dee277792b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: TU/tylCfYi1eOo5ILGmCevONBhA3k/wMRSUdAgKe39koEtpAfiVWcMH3UW7qldCKEwOKkhYDobOnHOJxFvPnp9yKBrCrg3b/5rWPGRUprmTrodEZsUyoToSiaR2lsIZd7UVpaWgZZgZ/t9TpbS34SAWL2Y4tP93yelO/TPkVxLJrdLcp5MZ/wf7M5hKnUe6EvKEnxUHPizl3gJ1wdM/6+Ro+zmD7HC6XZTcM1iaj2CZHK/EAaDkPI0AjOeh3k1I+VinUvxLCNTgt5gRuHq5PQHmlHXK3mu+b7IkqeCbqvwQTNLgoYnKeRwlgfsIrgaluvu7Cs5ESBpH11x2P/wUtnEUbNrRRM1sanTYzzMDVI0r+joO0wYKHscT/NWPTnPGWGYhaolYN1klOSNNNmRgxpmglKMvqYed+GlC87QYZ2SQqM7J4lgN42M9QEnJ2mLn0pM1XffaZwJDSf9Yci3UJpEjXTz59lwRzabNva0E/E2fzcZBiJ03vYRFXJu5Mdi4tm24eaNICeYcTC7/f0NexfZrNq2LuIX7ocUrA2OMsnB1pATj9qtVHo8szhOvRbJEYQr3c31jltZxUjCbbwHKdLhyv6Kqq1aM+MGuCpFMIQC5QZQ7h7Vpuh8TTFYRInnsKj37u/NW4Dr+XljY/+qSYMR9cfbeCmpAJvic1t/ae+S0hp1ALNRer9di1NpVrwKuIdGv1q/ivu3o6N5S4m4DMoA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y7kvlsEHHO+FrC/E5MP1aycgJMa8co+s0xJAMWiP6Fz9MNZO0XPyjgd6bdO9b2CgVVuvFsd79Ca9fkmqLhur2UUPhZoyYlePR3xsf0+34ngWrqfBQSrkhhLjmK8vBdwr5r6PTEZppAgzRsf+Qh5H+sLw2tHDUFKrQtq494pwmsbu0KLFF/b57B5hNH/cPc4lsTAOGL0Tu5M8egs/UdzAwVjFyF9sT7/F/onABAVLl1SdKqCeqK293AV3nYiVTCpDW5J+yEs0ptb5Q04orQoWmT23H5BzkVNvs8kvfOfAY/FXFHJW71iGn9jCBLjEERoIn+P2e4hurN5/VdbKwWu9G4QCeM8Kw2v+nRSZT+1URtIn3AmRJC6O5G3vqHcuJEjQm8uYouoQAlCuhOBt1KdRd+YrCkBUJMqhMt6X2/FNFTGZdbQ0NO0EwM6GL/NK5UWF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:46:29.4196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34adb9a4-140b-4f56-c5b0-08dee277792b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF34483F4BA
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
Add KUnit coverage for amdgpu_dm_init_color_mod() and
amdgpu_dm_verify_lut3d_size().

init_color_mod is a smoke test that the x-points distribution is set up
without crashing. The verify_lut3d_size tests build adev/DC fixtures with
and without the 3D LUT capability and confirm that correct shaper and 3D
LUT blob sizes succeed while mismatched sizes return -EINVAL.

Assisted-by: Copilot:Claude-Opus-4.8 GPT-5.5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   2 +
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 123 ++++++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index bcb2cee8c6e8..45d11990bc8e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -172,6 +172,7 @@ void amdgpu_dm_init_color_mod(void)
 {
 	setup_x_points_distribution();
 }
+EXPORT_IF_KUNIT(amdgpu_dm_init_color_mod);
 
 STATIC_IFN_KUNIT INLINE_IFN_KUNIT
 struct fixed31_32 amdgpu_dm_fixpt_from_s3132(__u64 x)
@@ -1177,6 +1178,7 @@ int amdgpu_dm_verify_lut3d_size(struct amdgpu_device *adev,
 
 	return 0;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_verify_lut3d_size);
 
 /**
  * amdgpu_dm_verify_lut_sizes - verifies if DRM luts match the hw supported sizes
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index d64c7da20f2c..e46a8454425d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -7,14 +7,17 @@
 
 #include <kunit/test.h>
 #include <linux/types.h>
+#include <drm/drm_atomic.h>
 #include <drm/drm_colorop.h>
 #include <drm/drm_property.h>
 #include <uapi/drm/drm_mode.h>
 
 #include "dc.h"
+#include "amdgpu.h"
 #include "amdgpu_mode.h"
 #include "amdgpu_dm.h"
 #include "amdgpu_dm_color.h"
+#include "amdgpu_dm_kunit_test_helpers.h"
 
 /* ---- Tests for amdgpu_dm_fixpt_from_s3132 ---- */
 
@@ -1527,6 +1530,119 @@ static void dm_test_set_colorop_in_tf_1d_curve_bypass(struct kunit *test)
 		(int)TRANSFER_FUNCTION_LINEAR);
 }
 
+/* ---- Tests for amdgpu_dm_init_color_mod ---- */
+
+/**
+ * dm_test_init_color_mod - Smoke test: must initialize x-points without crashing
+ * @test: KUnit test context
+ */
+static void dm_test_init_color_mod(struct kunit *test)
+{
+	amdgpu_dm_init_color_mod();
+	KUNIT_SUCCEED(test);
+}
+
+/* ---- Tests for amdgpu_dm_verify_lut3d_size ---- */
+
+/**
+ * dm_test_verify_lut3d_alloc_plane - Allocate a dm_plane_state for lut3d tests
+ * @test: KUnit test context
+ *
+ * Returns: a drm_plane_state pointer embedded in a zeroed dm_plane_state.
+ */
+static struct drm_plane_state *
+dm_test_verify_lut3d_alloc_plane(struct kunit *test)
+{
+	struct dm_plane_state *dm_plane_state;
+
+	dm_plane_state = kunit_kzalloc(test, sizeof(*dm_plane_state), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_plane_state);
+
+	return &dm_plane_state->base;
+}
+
+/**
+ * dm_test_verify_lut3d_alloc_adev - Allocate adev with a DC and given 3D LUT cap
+ * @test: KUnit test context
+ * @has_3dlut: value to program into caps.color.dpp.hw_3d_lut
+ *
+ * Returns: an amdgpu_device with adev->dm.dc allocated.
+ */
+static struct amdgpu_device *
+dm_test_verify_lut3d_alloc_adev(struct kunit *test, bool has_3dlut)
+{
+	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
+
+	adev->dm.dc = kunit_kzalloc(test, sizeof(*adev->dm.dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev->dm.dc);
+	adev->dm.dc->caps.color.dpp.hw_3d_lut = has_3dlut;
+
+	return adev;
+}
+
+/**
+ * dm_test_verify_lut3d_no_luts - No shaper/3D LUT blobs: must succeed
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut3d_no_luts(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_verify_lut3d_alloc_adev(test, false);
+	struct drm_plane_state *plane_state = dm_test_verify_lut3d_alloc_plane(test);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut3d_size(adev, plane_state), 0);
+}
+
+/**
+ * dm_test_verify_lut3d_bad_shaper - Shaper LUT with wrong size: must return -EINVAL
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut3d_bad_shaper(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_verify_lut3d_alloc_adev(test, true);
+	struct drm_plane_state *plane_state = dm_test_verify_lut3d_alloc_plane(test);
+	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane_state);
+
+	/* has_3dlut => expected shaper size is MAX_COLOR_LUT_ENTRIES */
+	dm_plane_state->shaper_lut = dm_test_make_lut_blob(test, 128);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut3d_size(adev, plane_state), -EINVAL);
+}
+
+/**
+ * dm_test_verify_lut3d_bad_lut3d - 3D LUT with wrong size: must return -EINVAL
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut3d_bad_lut3d(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_verify_lut3d_alloc_adev(test, true);
+	struct drm_plane_state *plane_state = dm_test_verify_lut3d_alloc_plane(test);
+	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane_state);
+
+	/* Valid shaper, but wrong 3D LUT size */
+	dm_plane_state->shaper_lut = dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+	dm_plane_state->lut3d = dm_test_make_lut_blob(test, 128);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut3d_size(adev, plane_state), -EINVAL);
+}
+
+/**
+ * dm_test_verify_lut3d_valid - Correct shaper and 3D LUT sizes: must succeed
+ * @test: KUnit test context
+ */
+static void dm_test_verify_lut3d_valid(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_verify_lut3d_alloc_adev(test, true);
+	struct drm_plane_state *plane_state = dm_test_verify_lut3d_alloc_plane(test);
+	struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane_state);
+	const uint32_t lut3d_entries =
+		MAX_COLOR_3DLUT_SIZE * MAX_COLOR_3DLUT_SIZE * MAX_COLOR_3DLUT_SIZE;
+
+	dm_plane_state->shaper_lut = dm_test_make_lut_blob(test, MAX_COLOR_LUT_ENTRIES);
+	dm_plane_state->lut3d = dm_test_make_lut_blob(test, lut3d_entries);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_verify_lut3d_size(adev, plane_state), 0);
+}
+
 static struct kunit_case dm_color_test_cases[] = {
 	/* amdgpu_dm_fixpt_from_s3132 */
 	KUNIT_CASE(dm_test_fixpt_from_s3132_zero),
@@ -1624,6 +1740,13 @@ static struct kunit_case dm_color_test_cases[] = {
 	KUNIT_CASE(dm_test_set_colorop_in_tf_1d_curve_invalid_type),
 	KUNIT_CASE(dm_test_set_colorop_in_tf_1d_curve_unsupported_curve),
 	KUNIT_CASE(dm_test_set_colorop_in_tf_1d_curve_bypass),
+	/* amdgpu_dm_init_color_mod */
+	KUNIT_CASE(dm_test_init_color_mod),
+	/* amdgpu_dm_verify_lut3d_size */
+	KUNIT_CASE(dm_test_verify_lut3d_no_luts),
+	KUNIT_CASE(dm_test_verify_lut3d_bad_shaper),
+	KUNIT_CASE(dm_test_verify_lut3d_bad_lut3d),
+	KUNIT_CASE(dm_test_verify_lut3d_valid),
 	{}
 };
 
-- 
2.43.0

