Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2222DCD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1AEC10EEE9;
	Wed, 13 May 2026 14:33:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WwZL9xwL";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3954710EED6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=louldZAevx692TTdxbMdn9/E9O95bIPfF9pkK/bp/0kUKY9STeIYaaApG70qfvxyCNQkhfh9gfupUaf9U4HdaguM45wruzx/InRRr8mrjOPjXPlG/GvPmpRvO91lSEv9EkM9Vy3IGj4azmyaOhYISdDFioPF1jpbIxlzMyy+U0JsqkRZ9HDQDR4h/rlCkLT+8VTzYH/jWctOgZWIJBSrrCi+Ewjlz+ZeKfe4lHq6lEHb9LScR+s54uiQmXVbr6fulBAKZy3nF2lkQ0vq9eUdqaN9a1xeHm3eqZbf/23MEs0gMHB6lnx79qT9Q0UCbkCVU41D+Xk+4MlfC2IdcVzpMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vU6iX0n7ZX1mzzOtPesDjGCgHhpY4BuO41BIu+O+xVk=;
 b=OK+FAwOfaVMMu1WoVfap+fEvxW+gLG2ysGnAGNlqKXj8yW3zU51t8Q4B+SQQY3t4vaIPnM2l0wXHXeumyTmUlTP5eMA+Q0sutm0neF76vbKbLHNxx44S+WRpUVgZlcqIT6ol8U4Tv81u77TA+cWPfqJC0XfxTNSuIEAMd1+0GoCs/r4Wf3d2VG0OncqMut6b/NvIBqfeqpU1NiHBDk1j7q4H2Wr+DCWOc0pr7j+m9PBLENkq7ic7VMj/Prxaq6q5kZrS50zdsIFl0YumQ5zPfopTBhmZe5CK3ps8171wSafZk/ox5F1KOvPpT4O32qIDerdefvnDqXGGuq75m5RfNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vU6iX0n7ZX1mzzOtPesDjGCgHhpY4BuO41BIu+O+xVk=;
 b=WwZL9xwL5LnKPk2iJbB3pKOy1Mu5YAWcoi9X1ch143OM5SVkwiAT8AUYBWSCvZYMSy0O3xdjTmqPMQS80zRCHAwmoWSrkmBJyJmyqJkNxNFc6BU/+Ae9tU+c7JlhAciYvNeTJRdJM5s3YCI3V7quO11/yCaW53PyAJhGf2ojzZA=
Received: from BY5PR13CA0031.namprd13.prod.outlook.com (2603:10b6:a03:180::44)
 by DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 14:33:28 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:180:cafe::86) by BY5PR13CA0031.outlook.office365.com
 (2603:10b6:a03:180::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 14:33:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 09:33:19 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 09:33:19 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:18 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 07/28] drm/amd/display: Add KUnit test for colorop TF bitmasks
Date: Wed, 13 May 2026 10:29:29 -0400
Message-ID: <20260513143213.1852892-9-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|DS7PR12MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 630b78d8-65bb-4b21-d046-08deb0fc988c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z6beh7xbH4KT5TYdzBuKGXfkiwx32doaatxxfqw5OWq4PfCVbMXelzEltD9XyFapr+kQSAeo/WJmaXeflIIa2EYWW84VrUGRWMa5tifLSmQ1WeDoeHe5o7Fudu0KbzQomeoRGV8G2zDiegBaiFmmw7Zj99Qvpz4IOoHqM1JDllzYfWjZThMQYQUVURs4YbJVKr60Q+OKrhS+lQCcSDvGUcCZFL9vsN8fBEiYAWl2/m/6SenEL07Jq2TvbiBKFIsd2awto2aYyWxlQGKxJLP6hz6KK4r2kEHXA18d7lVNh8DQAug+UgcHEW7wEi89NkVK65s9nn9Ss2uAKR/i6AIgPZSci6hAYJrDAHxezL8+NYwxPTdB/j7dRa1ioW31mWpImnSCRiqJiwQDMv46EC19UK8IX1U5l29mQLC+CmvOdKzL3wE2pl92WYkazsK7xg1ta0DpPOPls0B4qu5V7poVRUlV/maiVaDhydHIA20nm0mGiJlN3iiC5IgvdUj4YhoVl7SDcZZyPXTp8Vq/0UFpbHAbke6I2YBOzov0/uQXlcHFG3PufQWG3cCtCgdzVAEdsAtVxocmC/rVOYv/KQNWCN6rfUzEjlj+ctzD2Zvn9CSf7ABsOh+hmLO90vXQXICzE/y5GPLpHt3Jq46LFDJJlw2fGWc7o7gkaanwOaeo0A9ww+oXLVP5FOfBhEFmCLUR842irhaSj5qG6ll6rkV8uni9485vlaRD5VABQkdQryI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h62+aM+kLTH3bhjzgkzcBGYMWFRKpB0MqT/fYN/nW0midpyUvfYOgK8gZ2qEmB8COwgiNXyAlApdUpHzdiIl/1ds12JhPPUv4orzJeKd/AWmjymR108wzxVgmN6OfjFWHWghOYG0DMNEAMCYQUP2CFpShCoBFQbX9Q0HF0wxrOM2fLkvl2byIXIe2NMbJpL/VlpjE+oXHvhnDjIT3lA5H/C4rrfQwGQi93xHtsGw3t7Gf5M3oCfh5Kz9D5b0gKXKFYP9o6/sfXKZrPNPPs8mx8lY0VJCMRBb6CI8Pnf/lRSdNiCwc5gROMAspbZ0UUzEB20u7S+sJ1p7v02zT4NWyJ3fs+Te3bj5b3aNNm+kRAPVGnqEF5XzOLzKGOm+4hoT8AVwh8bHKYDqCD6vOdCn6caj785YI+hdYnLZ4fGbCWAVsNrrBUbp4uXmkVvBBcKN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:26.9703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 630b78d8-65bb-4b21-d046-08deb0fc988c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5984
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

Add KUnit tests that verify the three supported transfer
function bitmask constants exported by amdgpu_dm_colorop.c:
amdgpu_dm_supported_degam_tfs, amdgpu_dm_supported_shaper_tfs,
and amdgpu_dm_supported_blnd_tfs.

Each bitmask is tested for presence of each expected curve
flag and absence of any unexpected bits.  A cross-check
confirms that degam and blnd bitmasks are identical.

amdgpu_dm_initialize_default_pipeline() is not tested
because it needs a fully initialised drm_plane backed by
an amdgpu_device with DC color caps.

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  | 161 ++++++++++++++++++
 2 files changed, 162 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 9669ea79a666..e300bcf39835 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -10,3 +10,4 @@ ccflags-y += -I$(src)/../../dc
 
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_hdcp_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_colorop_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
new file mode 100644
index 000000000000..8bdebcaf42b2
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_colorop.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+#include <drm/drm_colorop.h>
+
+#include "amdgpu_dm_colorop.h"
+
+/* Tests for amdgpu_dm_supported_degam_tfs */
+
+static void dm_test_supported_degam_tfs_has_srgb_eotf(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_degam_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF));
+}
+
+static void dm_test_supported_degam_tfs_has_pq125_eotf(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_degam_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF));
+}
+
+static void dm_test_supported_degam_tfs_has_bt2020_inv_oetf(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_degam_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF));
+}
+
+static void dm_test_supported_degam_tfs_has_gamma22_inv(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_degam_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV));
+}
+
+static void dm_test_supported_degam_tfs_no_extra_bits(struct kunit *test)
+{
+	u64 expected = BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
+		       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
+		       BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_supported_degam_tfs, expected);
+}
+
+/* Tests for amdgpu_dm_supported_shaper_tfs */
+
+static void dm_test_supported_shaper_tfs_has_srgb_inv_eotf(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_shaper_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF));
+}
+
+static void dm_test_supported_shaper_tfs_has_pq125_inv_eotf(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_shaper_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF));
+}
+
+static void dm_test_supported_shaper_tfs_has_bt2020_oetf(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_shaper_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF));
+}
+
+static void dm_test_supported_shaper_tfs_has_gamma22(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_shaper_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22));
+}
+
+static void dm_test_supported_degam_tfs_no_extra_bits(struct kunit *test)
+{
+	u64 expected = BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
+		       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
+		       BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_supported_shaper_tfs, expected);
+}
+
+/* Tests for amdgpu_dm_supported_blnd_tfs */
+
+static void dm_test_supported_blnd_tfs_has_srgb_eotf(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_blnd_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF));
+}
+
+static void dm_test_supported_blnd_tfs_has_pq125_eotf(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_blnd_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF));
+}
+
+static void dm_test_supported_blnd_tfs_has_bt2020_inv_oetf(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_blnd_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF));
+}
+
+static void dm_test_supported_blnd_tfs_has_gamma22_inv(struct kunit *test)
+{
+	KUNIT_EXPECT_TRUE(test, amdgpu_dm_supported_blnd_tfs &
+			  BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV));
+}
+
+static void dm_test_supported_blnd_tfs_no_extra_bits(struct kunit *test)
+{
+	u64 expected = BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
+		       BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
+		       BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
+		       BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
+
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_supported_blnd_tfs, expected);
+}
+
+/* degam and blnd should support the same set of EOTF curves */
+static void dm_test_degam_and_blnd_tfs_match(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test, amdgpu_dm_supported_degam_tfs,
+			amdgpu_dm_supported_blnd_tfs);
+}
+
+static struct kunit_case dm_colorop_test_cases[] = {
+	/* degam TFs */
+	KUNIT_CASE(dm_test_supported_degam_tfs_has_srgb_eotf),
+	KUNIT_CASE(dm_test_supported_degam_tfs_has_pq125_eotf),
+	KUNIT_CASE(dm_test_supported_degam_tfs_has_bt2020_inv_oetf),
+	KUNIT_CASE(dm_test_supported_degam_tfs_has_gamma22_inv),
+	KUNIT_CASE(dm_test_supported_degam_tfs_no_extra_bits),
+	/* shaper TFs */
+	KUNIT_CASE(dm_test_supported_shaper_tfs_has_srgb_inv_eotf),
+	KUNIT_CASE(dm_test_supported_shaper_tfs_has_pq125_inv_eotf),
+	KUNIT_CASE(dm_test_supported_shaper_tfs_has_bt2020_oetf),
+	KUNIT_CASE(dm_test_supported_shaper_tfs_has_gamma22),
+	KUNIT_CASE(dm_test_supported_shaper_tfs_no_extra_bits),
+	/* blnd TFs */
+	KUNIT_CASE(dm_test_supported_blnd_tfs_has_srgb_eotf),
+	KUNIT_CASE(dm_test_supported_blnd_tfs_has_pq125_eotf),
+	KUNIT_CASE(dm_test_supported_blnd_tfs_has_bt2020_inv_oetf),
+	KUNIT_CASE(dm_test_supported_blnd_tfs_has_gamma22_inv),
+	KUNIT_CASE(dm_test_supported_blnd_tfs_no_extra_bits),
+	/* cross-check */
+	KUNIT_CASE(dm_test_degam_and_blnd_tfs_match),
+	{}
+};
+
+static struct kunit_suite dm_colorop_test_suite = {
+	.name = "amdgpu_dm_colorop",
+	.test_cases = dm_colorop_test_cases,
+};
+
+kunit_test_suite(dm_colorop_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_colorop");
+MODULE_AUTHOR("AMD");
-- 
2.43.0

