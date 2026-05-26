Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7085DCD5BB4
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1041910E4FB;
	Tue, 26 May 2026 07:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gTv9lIRh";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010032.outbound.protection.outlook.com [52.101.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2050610E4FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:18:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzTeX2Wa5fYgnSF6DBQXEF37JA0eZmQrSbEiEoTFhCVjjW9KHzNKzR4YqtPthTYW7mm1MaLktoTGy0ig0FAxEUYACCfwzr0Kfij9EwJ2Z2DUM1TpH4W/4rlg/Ic7/3Qkj86x01xXLWyF5Z84hrlObr087ntgbbYqYi07RlngUe5sE3PI40mGoauVjYE+k8O+k+yOBWCdg0Rak1JLzuxQqMcrlQebeX/LpLFhOKqF/eoKkKfTAdSmeAU33puUv23BFxcP1QNpMrhXaqQQcvWN4Befu+3WiIp6EhR6yqfBWCjAfTubJktsQS2hSqxsQQRZ3yHtAlG5uIraFitb9ho2dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRkGoQU+UztBGCFCOQzgpC+EW7nICN6XtKbPesbjQO0=;
 b=aQww5HJLxxWHX2Pg6Sg1/cVwJr3vccxxXJHnxhrFHMPtOLL04HyI6lJOV4TzT1GGAbn8Nqsn0OcN7Z20Sd0sDznK8fV78sQfP8KfyFjcDLiZ1I6OvIEGvsXZ/gWKB/HuOPsnsWCvvL07RnUCC61/zDV0x7bRWvSlX6tVkemyous0vuy8k3QuzMgGL0CMxBYIGYFbI38ioHUjVTO90vQjofFYgwgN+NnI2O1SchuhxkHqRUUA5Xwsfb9Y7b65x/l2+x37jTJc+oEqkz4tV3tYFN8tDjDgjNkUHrqdriOY6EyxSu8xS9XN08yytQEaaQUFQkTACXbTBi+iNENfXCPLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRkGoQU+UztBGCFCOQzgpC+EW7nICN6XtKbPesbjQO0=;
 b=gTv9lIRhzDADkBoIYjCZUdqbK8dLmk5/TF8wmRkFqRPmGQOTssKfcHwmZgaOK7BzW7rF36y9k8KLOBoeW1m8+GqlhYicwYUfqYxPpB9Z5SB7zO61k8DYBI307ZOwk9R/tPpFvUvpUtgl9shSGxZXIBzCcYSnzCArdrFp1D9IrH4=
Received: from PH8P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::19)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 07:18:00 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:510:2d8:cafe::3) by PH8P221CA0018.outlook.office365.com
 (2603:10b6:510:2d8::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:18:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:18:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:17:59 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:17:58 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:17:50 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 25/41] drm/amd/display: Add KUnit tests for amdgpu_dm_colorop
Date: Tue, 26 May 2026 15:01:48 +0800
Message-ID: <20260526071413.2181251-26-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 455d516b-20b2-4095-e4d4-08debaf6eb49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZGYxEXkc2mjpyNRfkIs4G188zuv9p/8mUguy6/dlgDdnFRWRXzSAiNt/8w10cD0Y39CHAktdZ2bmpPH7m4z3/QXVyTbVwBA0cOQJnbX6yUX9NsP8NKJmwo3p93hdsYxRjO3XrUlIssD4Axejuky47WdDhO7T+OnI/JRDQFifapTgSQb6ILynvtey9JG/vS/Oa3zMA5zh8QNueSJ/qcOfTg/J2M8w7mZSSW8Pd/Ts0/a6Pw0dtE08lmsVH9q59PBGj11uthxvA8Pa0fxjI288pcl/7L/YuVhhld+RTjcnQKWP7h+eBRyZ47sUWVMexjOMdvwCTgJUk1aGHRi7MKSoPZ2fGb/VmN7WDQWoBAnae3kqy200XA6Z+R70UEPbFVjxG822LCCebJ+hxtyxLySxdpUlXXzI+oKzlhO+cSR5hy3HiyUj0DIPx98uMUzt00+rTDHWDNR6iWaBP5RSjMXaUlskf65N90mb8zq+BUAjMV4w5hnucXSibVYZKuLf7sILRq2b4lNMmIfa3/qMx6E4d8yjUw/wW2b/+B854dfxC2kmrz+gYWsQUO/JCGxZGuCUAFP5jSIgcuMGahgmas6EbXD8spt/74Crlaggn5AzwYOy9OUogrA9YNy3FIS8fchf1kkV7/z/Yxpj1b/a8ViiE2qaYCCGtik95HuEyJ+cmwXrPwMOwWngMsNAQwxeOWkIqqcV5QlP2U5id3BxmusQ9GnBlxxzOC2Iyv3Sb/+ibWQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(11063799006)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OLU4NEx37y8SDQM5Jpxcc1DwCfurPSw4Z3mZuG4/qaJH8zu3aZEJZnQgc7SuXwVbZqYST+UbHWxmKky98INeeLalV/n5PN98ecIXI25xupj49hzU6BPny5DK5QhGLyFEDHODzI2a/4lSJwAlZbVZoeU9LKXyC7lQQI140evBDw1lICWq66oSdpHiWUrbTHCaHm0NkzWNaTmLlZ/g29oXziJAUyv9oDp3pMuMMRXxERbWZGNehV5mp/d9yEr6zn0LW0h8w5OXj6bPkTIzedtn3EgxxKbSBlMBhhNVz6sx0KuWtFhxHh2gVmAvQu6WpvBgA+u24PRXQfNw6UJfdtbRY6+YpGoVFC4Po/+8Byj14BkKTkSAP5OKXNRtazoSq0Ohb7379NsnWdSdelrtmbl4wpvbNiQAF751xYAfKxxYLzKZTa6wUgplsel0d27WtFzq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:18:00.4776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 455d516b-20b2-4095-e4d4-08debaf6eb49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918
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

[Why & How]
Add a KUnit pipeline test for amdgpu_dm_build_default_pipeline().

The pipeline test uses a mock drm_device (via DRM KUnit helpers),
calls amdgpu_dm_build_default_pipeline() with hw_3d_lut=true, then
walks the returned colorop chain asserting the correct type sequence
(degam_tf, mult, ctm, shaper_tf, shaper_lut, 3dlut, blnd_tf,
blnd_lut), that every op carries bypass_property, and that the
chain length is exactly eight. A kunit cleanup action calls
drm_colorop_pipeline_destroy() before the device is torn down.

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig           |  2 +-
 .../amd/display/amdgpu_dm/tests/.kunitconfig  |  2 +
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 78 +++++++++++++++++++
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 38323e574c6b..1727d25646cc 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -58,7 +58,7 @@ config DRM_AMD_SECURE_DISPLAY
 
 config DRM_AMD_DC_KUNIT_TEST
 	tristate "KUnit tests for the AMD DC display driver" if !KUNIT_ALL_TESTS
-	depends on DRM_AMD_DC && KUNIT && DEBUG_FS
+	depends on DRM_AMD_DC && KUNIT && DEBUG_FS && DRM_KUNIT_TEST_HELPERS
 	default KUNIT_ALL_TESTS
 	help
 	  This option enables KUnit tests for the AMD Display Core driver.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
index a0949d3c4e6f..bd1bf8d959f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig
@@ -6,6 +6,8 @@ CONFIG_DRM_AMD_DC=y
 CONFIG_DEBUG_FS=y
 CONFIG_DRM_AMD_DC_KUNIT_TEST=y
 CONFIG_FW_LOADER=y
+CONFIG_DRM_KUNIT_TEST=y
+CONFIG_DRM_KUNIT_TEST_HELPERS=y
 CONFIG_DRM_KMS_HELPER=y
 CONFIG_DRM_TTM=y
 CONFIG_HWMON=y
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
index 4245ebd3725b..fa270ff28c6a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -7,6 +7,7 @@
 
 #include <kunit/test.h>
 #include <drm/drm_colorop.h>
+#include <drm/drm_kunit_helpers.h>
 
 #include "amdgpu_dm_colorop.h"
 
@@ -125,6 +126,81 @@ static void dm_test_degam_and_blnd_tfs_match(struct kunit *test)
 			amdgpu_dm_supported_blnd_tfs);
 }
 
+/* Tests for amdgpu_dm_initialize_default_pipeline */
+
+static void kunit_colorop_pipeline_destroy(void *drm)
+{
+	drm_colorop_pipeline_destroy((struct drm_device *)drm);
+}
+
+/**
+ * dm_test_initialize_default_pipeline() - Verify amdgpu_dm_build_default_pipeline()
+ *   produces the expected colorop chain with all ops bypassable.
+ * @test: KUnit test context.
+ */
+static void dm_test_initialize_default_pipeline(struct kunit *test)
+{
+	static const enum drm_colorop_type expected[] = {
+		DRM_COLOROP_1D_CURVE,	/* degam TF */
+		DRM_COLOROP_MULTIPLIER,
+		DRM_COLOROP_CTM_3X4,
+		DRM_COLOROP_1D_CURVE,	/* shaper TF */
+		DRM_COLOROP_1D_LUT,	/* shaper LUT */
+		DRM_COLOROP_3D_LUT,
+		DRM_COLOROP_1D_CURVE,	/* blnd TF */
+		DRM_COLOROP_1D_LUT,	/* blnd LUT */
+	};
+	struct device *dev;
+	struct drm_device *drm;
+	struct drm_plane *plane;
+	struct drm_prop_enum_list list = {};
+	struct drm_colorop *op, *first = NULL;
+	int i = 0;
+	int ret;
+
+	dev = drm_kunit_helper_alloc_device(test);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	/*
+	 * Allocate a plain drm_device (not an amdgpu_device) — sufficient
+	 * because amdgpu_dm_build_default_pipeline() only needs the DRM
+	 * mode-config infrastructure, not the amdgpu device wrapper.
+	 */
+	drm = __drm_kunit_helper_alloc_drm_device(test, dev,
+						   sizeof(*drm), 0, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, drm);
+
+	plane = drm_kunit_helper_create_primary_plane(test, drm,
+						       NULL, NULL, NULL, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, plane);
+
+	/*
+	 * Destroy the pipeline before the DRM device is cleaned up so
+	 * that the colorop objects (kzalloc'd inside the function) are
+	 * freed while the device is still valid.
+	 */
+	kunit_add_action(test, kunit_colorop_pipeline_destroy, drm);
+
+	ret = amdgpu_dm_build_default_pipeline(drm, plane, true, &list);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	kfree(list.name);
+
+	drm_for_each_colorop(op, drm) {
+		if (op->base.id == (uint32_t)list.type) {
+			first = op;
+			break;
+		}
+	}
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, first);
+
+	for (op = first; op; op = op->next, i++) {
+		KUNIT_ASSERT_LT(test, i, (int)ARRAY_SIZE(expected));
+		KUNIT_EXPECT_EQ(test, op->type, expected[i]);
+		KUNIT_EXPECT_NOT_NULL(test, op->bypass_property);
+	}
+	KUNIT_EXPECT_EQ(test, i, (int)ARRAY_SIZE(expected));
+}
+
 static struct kunit_case dm_colorop_test_cases[] = {
 	/* degam TFs */
 	KUNIT_CASE(dm_test_supported_degam_tfs_has_srgb_eotf),
@@ -146,6 +222,8 @@ static struct kunit_case dm_colorop_test_cases[] = {
 	KUNIT_CASE(dm_test_supported_blnd_tfs_no_extra_bits),
 	/* cross-check */
 	KUNIT_CASE(dm_test_degam_and_blnd_tfs_match),
+	/* amdgpu_dm_initialize_default_pipeline */
+	KUNIT_CASE(dm_test_initialize_default_pipeline),
 	{}
 };
 
-- 
2.43.0

