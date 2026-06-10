Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B0FCD98C7
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC3510E88E;
	Wed, 10 Jun 2026 09:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gy66uZRb";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013042.outbound.protection.outlook.com
 [40.93.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE79A10E890
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:52:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdV4vGUvUZFTQ7Sqm+tITquFVAFqpaDJwuU9sNftIWBMw1fAGU8rlSSjPbZYqW2yxJfFWHpm9Yjb2UBR6kSxPAjoFdlrKlaNtBkMEe3SG0H6q9+++XWknsC5FunRa2lw5Jg9dxjMuenbi5z+iKhDf0JZRbSRJDhvCVdEK602XEDO3nM0T9obgc1Ynf1k7XXoakvFjIcwN0AkvkBji93ZDFrACFtfkqaNpWUgSVN0tfBlEiaolLaodH395Y9gK57w87Xgdur2qtKGH980v9p1Ft5N0lMtwYyehqstNzlnPlvAWHIKEGO+IaEFT/226lRla7hoIqJmoZTVXA1uPSBmUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86WdKN3ENcAoc+g6bUK/U23b6QgQOCvEvhrGS0mqdto=;
 b=riL0Ay4m8v0sHJm3DyVcgOpwkZj9rxBLw/O+eLgyQm2qO6EKVkWnUYIApv71Ri2pkMX90+yPz4W4TayuBFJFmM8ytN4zNYOlI1Gg75kQ6vl0NUE3yfElJd1BIGKDCdpJ6D5BDrFERIqvHQN0E/WCEswEUXkQbY/hdk/o9BuFI43ZkBCN705Efj2WroGypvz3s8CwqPq6cqzJRHYf3DgdCUE9qrKXpDat7SFihITy3wTcBPcAmkbKVXWRGYooRTn/bleawPsIkSML3Ub8LHpoe4uX+oZE5UyNSu8Md9iaraz0oPkcwc7pP/wp3nY7MYlcWcC2ny4WfmH0Oft+ATQh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86WdKN3ENcAoc+g6bUK/U23b6QgQOCvEvhrGS0mqdto=;
 b=gy66uZRbTU8ifJRYPzhZhn5tYxB9XFDUfpIGu8QmjH7UIhoX94I29bzQaXCoQB7QrADuSWgunUjMbLxKbL6VKYjpvW7Fr8gbdKkq13GvOebMHriNMSDnkcDPA5cek4XZS8p1UC8L8u03tFVecfRiGdj1QDoojieReH36SCjdMyc=
Received: from PH7P220CA0102.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::12)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 09:51:58 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:32d:cafe::1e) by PH7P220CA0102.outlook.office365.com
 (2603:10b6:510:32d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11 via Frontend Transport; Wed,
 10 Jun 2026 09:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:51:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:51:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:51:57 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:51:48 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, Chenyu
 Chen <chen-yu.chen@amd.com>
Subject: [PATCH 26/32] drm/amd/display: Add KUnit tests for amdgpu_dm_quirks
Date: Wed, 10 Jun 2026 17:45:10 +0800
Message-ID: <20260610094639.1965367-27-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 145e9a05-2867-45e8-37fa-08dec6d5e96f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: O6A+Rlll1uD7MWOHPMO7wPoWFozP3sURHWPUFlhN3CXuNU56Y9ERTo9uKfXxNpAwe5gjCSgAmM9amQax8OehE8SqRD/+7BYKeJgkSJi+qvTxExaqlrMcGs76EGmKmOwTR/0fEJ/RGukQr302PqVhzPB2LiKMlAQjRxzDgrcqMdCkZZqDluf83ZEC0nsNXJr//2jXiGvU5Bhvp2GOAB/E6hQr62uaQk8O4sgB3pNLLC4Swcj6drDRQIiAt8Jc0iinluPrhxYRzEafaSHlkxHRasbMZ8FsqzeJ5MENtPb7432KFJ06C5nrkFJVrKh8RShc7KXgXeurKlhE/KhTXlhCNu9H7yJs7IEpKHP2W+OxCGVOdCRmUNcsJO2XGZ5rUUw9howlKfv8HPZfd7t9qBZO6ubMf0Lc0IaenVIay2GlZagWHktOK13ImY8U2w8ZhSb5s/e0qt6DZwjwWjxFXjCnHsXfYnAwqbDXVYt6JbQW5OobToKr8LwDe4fHjajMuFfR02GPeedAWFePjRK8Iej7JOhA0Wo4znLeCq1S6kihXQIZmhMd6jvO6jIq+R2lheea4GEkKUYn8xye24p2GhQaFpBTNRQsuRmdf9HBF7le5tKxZBxGAXmg8umvdMZ5jM3c9v/tYp95VF5Q9yGWMuWpE8+bC7JrEU6AzpVHiIf+a3qrRokPZS/TV/mdzZuNmNa+O2cxKYbt5um7o/E1wVYUrVIppLTCT1HGkaq+noSJXBw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oESAirNHRALANsnmUnklRVhBIggVD/PWM/HTdm0X68KF0qczsYwSXiGSgtIMoLe6wZopR3VnsVg0S5dmPoH3SNXu+lYv8cAz1ACFMtO4E4Ql1bQVjJDVwpeKzqNNeMwJvUxqJvU7Qa+sjJfI8h+nYDh81cvrRL5c5T+jKfsJEVC4l/WvRHoYRBMKo3gfLctNMmEzEsV7OfF96vKIFqNLMJtrBiLUbJwZK8FHny36x085KsQNo0KW1FOrRrjDy7iYEIC8x7ykUIr9M/ZF2XcwY0d43maHcgKQIQa1HhHyU7pPhBDcIyrSPJoFLT771GELJ1F7flBIZYmPOE6OxVTPamVyoeYoKAZoiDqGmbE+N9lHEpvie6tksuyGo/+R74DkX9jUiQzCwor4+j5QGgdKkIC/lHTiHVVytme+oaxecUgo5sP4aFaAVVxECwe80uVH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:51:57.9513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 145e9a05-2867-45e8-37fa-08dec6d5e96f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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

Add KUnit test file amdgpu_dm_quirks_test.c covering retrieve_dmi_info().

Three test cases are provided:
- Verify aux_hpd_discon_quirk is reset to false even when previously true
- Verify edp0_on_dp1_quirk is reset to false even when previously true
- Verify both quirks remain false on a zero-initialised dm when no
  DMI match is found (expected in UML/KUnit environment)

Register the new test object in the tests/Makefile under
CONFIG_DRM_AMD_DC_KUNIT_TEST.

Assisted-by: Copilot:Claude-Sonnet-4.6

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  |   2 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c   | 103 ++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
index 1da07ebf9217..cf28d50c3b5e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_quirks.c
@@ -28,6 +28,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_dm.h"
+#include "amdgpu_dm_kunit_helpers.h"
 
 struct amdgpu_dm_quirks {
 	bool aux_hpd_discon;
@@ -176,3 +177,4 @@ void retrieve_dmi_info(struct amdgpu_display_manager *dm)
 		drm_info(dev, "support_edp0_on_dp1 attached\n");
 	}
 }
+EXPORT_IF_KUNIT(retrieve_dmi_info);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index a067332f9f41..168ad064e7cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -30,3 +30,4 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crtc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_services_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_helpers_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_quirks_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
new file mode 100644
index 000000000000..a09f31ee0a2a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_quirks_test.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_quirks.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+
+#include "dc.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+
+/* Tests for retrieve_dmi_info() */
+
+/*
+ * Verify that retrieve_dmi_info() always initialises aux_hpd_discon_quirk to
+ * false, even when the caller had previously set it to true.
+ */
+/**
+ * dm_test_quirks_aux_hpd_discon_reset - Test Quirks aux hpd discon reset
+ * @test: The KUnit test context
+ */
+static void dm_test_quirks_aux_hpd_discon_reset(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+
+	dm->aux_hpd_discon_quirk = true;
+
+	retrieve_dmi_info(dm);
+
+	/*
+	 * In a KUnit / UML environment no real DMI table is present, so
+	 * dmi_check_system() returns 0 and retrieve_dmi_info() leaves the
+	 * quirk at its initialised-to-false value.
+	 */
+	KUNIT_EXPECT_FALSE(test, dm->aux_hpd_discon_quirk);
+}
+
+/*
+ * Verify that retrieve_dmi_info() always initialises edp0_on_dp1_quirk to
+ * false, even when the caller had previously set it to true.
+ */
+/**
+ * dm_test_quirks_edp0_on_dp1_reset - Test Quirks edp0 on dp1 reset
+ * @test: The KUnit test context
+ */
+static void dm_test_quirks_edp0_on_dp1_reset(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+
+	dm->edp0_on_dp1_quirk = true;
+
+	retrieve_dmi_info(dm);
+
+	KUNIT_EXPECT_FALSE(test, dm->edp0_on_dp1_quirk);
+}
+
+/*
+ * Verify that when no DMI match is found both quirks remain false after a
+ * fresh (zero-initialised) dm is passed to retrieve_dmi_info().
+ */
+/**
+ * dm_test_quirks_no_dmi_match_both_false - Test Quirks no dmi match both false
+ * @test: The KUnit test context
+ */
+static void dm_test_quirks_no_dmi_match_both_false(struct kunit *test)
+{
+	struct amdgpu_display_manager *dm;
+
+	dm = kunit_kzalloc(test, sizeof(*dm), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dm);
+
+	retrieve_dmi_info(dm);
+
+	KUNIT_EXPECT_FALSE(test, dm->aux_hpd_discon_quirk);
+	KUNIT_EXPECT_FALSE(test, dm->edp0_on_dp1_quirk);
+}
+
+static struct kunit_case amdgpu_dm_quirks_tests[] = {
+	/* retrieve_dmi_info */
+	KUNIT_CASE(dm_test_quirks_aux_hpd_discon_reset),
+	KUNIT_CASE(dm_test_quirks_edp0_on_dp1_reset),
+	KUNIT_CASE(dm_test_quirks_no_dmi_match_both_false),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_quirks_test_suite = {
+	.name = "amdgpu_dm_quirks",
+	.test_cases = amdgpu_dm_quirks_tests,
+};
+
+kunit_test_suite(amdgpu_dm_quirks_test_suite);
+
+MODULE_AUTHOR("AMD");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_quirks");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.43.0

