Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B50CD4851
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DCD310EED2;
	Wed, 13 May 2026 14:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dnD8sGRu";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010017.outbound.protection.outlook.com [52.101.46.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4820A10EED1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q7KF5Q+/Pdj3259LaZKjYp8ww3zbNnYGSAqjsuD/x3Jmg66yFPRfSQwIwpmTQRb/46WTWoDaOAKPHk8+H4RWg/kcNwsjPf4MwNMV8j+zVfAi/TLXNm5epJBH9daCzySYmnixLHdfBMTxYTJhOJ1iPcR54pzOiwQPgJ27L8M6TIxWE/ODh7ZZ7dNA8JVj8GezEUHhcHfER1ZKdbba9Hy/wUHTAV8RX9f6FQFokOHQOnvaYQhgsEmxOwXg1HSSSrL5xnDuH6hz/54pCF/HKNcc58EDH5IOFqmTbny9Yowwy+ZLn3TBf72QxMTLWopzf5OMkSWv+uaknAVI/Lpjdc4Bhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSk4u+pr81F5lh6JVkQZ8czeQsJqtDT1JI/b3GEt2lA=;
 b=gd0B3FPyke/Xwevi04/ELSRgbFBjGh7uK/YqTC/oLyhS8LdWTvCX4bB1h3zYIQuA90N8FIxwbX32iYWicZiv21GqgZWEVQR+udwffx95UGIGAiW0apcSeheWQf1R0lP9crgyZu+okrnLF06hwm8uKUvPZ9U2MQMQlc/pdbSdr7kDWJUhBlLa5vNP+rVMFFKOnkTqMd+azL0ZgNnXH0DK7p9n4eQh/V96VF2Jz70O+VoDjFJ7J1HJ6KihcghM4aGK7GOPV+36J1G02PY38xeB98P1416MLnwH/+pVJ1wt41imocAr+eTL96l9ToPiMa7TzOQNDd+dJZ7XqZs5maIMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSk4u+pr81F5lh6JVkQZ8czeQsJqtDT1JI/b3GEt2lA=;
 b=dnD8sGRu9N0/KUNls/VqOAa9h42BLEO3cKMMy5dHmCh4PT7yKt/icK6oI9Bzs8jEvr905SQy4tSrqre3fBbExmxL/zMCZP7eIiAQqFqfUCeZe7EEP2o8+2FPVqYMZRq4d/Oi/FgnJW/chqV1fnNuVaWhBSCHXWjyp5SRaC/sAYk=
Received: from BY5PR13CA0007.namprd13.prod.outlook.com (2603:10b6:a03:180::20)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:30 +0000
Received: from MWH0EPF000C6194.namprd02.prod.outlook.com
 (2603:10b6:a03:180:cafe::59) by BY5PR13CA0007.outlook.office365.com
 (2603:10b6:a03:180::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 14:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6194.mail.protection.outlook.com (10.167.249.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Wed, 13 May
 2026 09:33:20 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 May
 2026 09:33:20 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:20 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 09/28] drm/amd/display: Add KUnit test for PSR function
Date: Wed, 13 May 2026 10:29:31 -0400
Message-ID: <20260513143213.1852892-11-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: IVAN.LIPSKI@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6194:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: e32fdd2f-b802-4394-f643-08deb0fc9a90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|22082099003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: 0RrO/PbYhRg/TTGY+0IqRzouCh4lKNYJcJihjSque16CAr/zG6wZ49wYqnor4K54iRAwUjnByKkPPLgUjf87gL2te8dM7E4IR61MCQAZfoCsQcfe1K5iRGQCAh4Hsa15Np1kzD5BP5hjzDsXBJModxhV9LpW5Gd1pfYHRj5sK8hM56603qI9jWYHU2D9OTY8uubQ1jCB3Mj+7IaFu5ncpKR5LhZFGYxa8ZPYuGNptVj2yQ2ZZmyzEQ4Xldr3528obqdrOWf5Ih2G4v9XsyVhfFIRNoDxeKpcP/IRX7ild53vkkvUYX/oU9vQ0zfO7uz6p4hGQNgExx3E83F5wEHtk0GWWQLSb1Svi1qJJNM52KRbKOtlRw3YMx29brgIruyv1jf7tOJiqIJEEQfGX9aqf1fipBBB/s8onaIWLENiN/bIPRrKU23rwJzMsn6LEdClxCJUdiFQNfQByl2uZG6d9/H30yu+c4+Ivtl+eUhIhr9wKlWnb8AYwoim0cvunQs5KVm+HtSxhG09N1XSJziVwKqoR7R5b8VNXcKyLS09DGUCaw2/2s1HWWG5DF8bnYdn/cfhGrJADFLvdq8iuIbnU8ixHidrnLjOKZzEwP/igw8rL1seVNtZZ5MBju7O5HYSK9OZgvNkgtQG0G68jdVNvnjcZ6BhmHXswLGYIw5lrEIp96flSqw91cRfwwkSBcfeQ4PCNknqNCFtvuUDzKe67Gy8ry17gpUI/zO96Cf4PLo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LKq9OQfbDkIRbbWbW3IztP8RAvAPLdgrxI/jkt28ScHYvbn/hgoaDESSFgDRQF0xSFCs1RRVPtFAGte2B334hCYPaR1VaxDNFbloD9+POL/VUkai+P/W0sezTZEn5u6e0BWkMtd7Mzi7KQYKw0aYaXu9Zc9emGw8e5gIBX9M3HpItMdwiYXgpoL12W2seQu9Kgu8FGYr+xZ8HQ681WSFmdGDFSBiUPE0dmVOxIl9hhOPZ644PkIkbsAtCVZdQ4N/S5yysv8A2/2GRrTdmI7Eu94BrP7lpyXiZ6/5pvct3Ysvx1TOSmfz76+7HQizqoROdQpTS+u7J1P5N3rHjw0iAJiAM5vn9YdEaqsmETOtbMk3oHzM3ut02X5g1FNdMIc0fnxw7Ae5/ijd0vkkl4+Gn6gg0DF+jHTJA5+b5UI9kKwIYu10Unzpw2Qdx5e6nfYK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:30.2929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e32fdd2f-b802-4394-f643-08deb0fc9a90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6194.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
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

Add KUnit tests for amdgpu_dm_psr_fill_caps() which
validates PSR capability population from DPCD data.

Export amdgpu_dm_psr_fill_caps() conditionally when
CONFIG_DRM_AMD_DC_KUNIT_TEST is enabled, following the
existing pattern used by CRC and HDCP test files.

The test covers PSR version mapping, RFB setup time
calculation, link training flag, DPCD field passthrough,
rate control caps, and power optimization flags.

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |   5 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      | 255 ++++++++++++++++++
 4 files changed, 266 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index dc5913a6456e..4b823bba4392 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -29,6 +29,8 @@
 #include "dc.h"
 #include "amdgpu_dm.h"
 #include "modules/power/power_helpers.h"
+#include "amdgpu_dm_kunit_helpers.h"
+
 
 static bool link_supports_psrsu(struct dc_link *link)
 {
@@ -58,7 +60,8 @@ static bool link_supports_psrsu(struct dc_link *link)
 	return false;
 }
 
-static void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps)
+STATIC_IFN_KUNIT
+void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps)
 {
 	struct dpcd_caps *dpcd_caps = &link->dpcd_caps;
 	unsigned int power_opts = 0;
@@ -86,6 +89,7 @@ static void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps)
 	caps->rate_control_caps = 0; /* TODO: read in rc caps from aux */
 	caps->psr_power_opt_flag = power_opts;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_psr_fill_caps);
 
 /*
  * amdgpu_dm_set_psr_caps() - set link psr capabilities
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
index 16d535806ad6..1a41d9b99eb4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
@@ -39,4 +39,9 @@ bool amdgpu_dm_psr_is_active_allowed(struct amdgpu_display_manager *dm);
 bool amdgpu_dm_psr_set_event(struct amdgpu_display_manager *dm,
 		struct dc_stream_state *stream, bool set_event,	enum psr_event event,
 		bool wait_for_disable);
+
+#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
+void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps);
+#endif
+
 #endif /* AMDGPU_DM_AMDGPU_DM_PSR_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 2b442353beae..f29b5c0dac8e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crc_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_hdcp_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_color_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_colorop_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_psr_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
new file mode 100644
index 000000000000..61a4167898cb
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_psr_test.c
@@ -0,0 +1,255 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_psr.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+
+#include "dc.h"
+
+/* Extern declaration for the function under test */
+extern void amdgpu_dm_psr_fill_caps(struct dc_link *link,
+				     struct psr_caps *caps);
+
+/*
+ * Helper: allocate and zero-initialise a dc_link sufficient for
+ * amdgpu_dm_psr_fill_caps() testing.  The function only accesses
+ * embedded members (dpcd_caps, psr_settings) so no pointer fields
+ * need to be wired up.
+ */
+static struct dc_link *alloc_test_link(struct kunit *test)
+{
+	struct dc_link *link;
+
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+
+	return link;
+}
+
+/* Tests for amdgpu_dm_psr_fill_caps() — PSR version mapping */
+
+static void dm_test_psr_fill_caps_version_1(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	link->psr_settings.psr_version = DC_PSR_VERSION_1;
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	KUNIT_EXPECT_EQ(test, (int)caps.psr_version, 1);
+}
+
+static void dm_test_psr_fill_caps_version_su1(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	link->psr_settings.psr_version = DC_PSR_VERSION_SU_1;
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	KUNIT_EXPECT_EQ(test, (int)caps.psr_version, 2);
+}
+
+static void dm_test_psr_fill_caps_version_unsupported(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	link->psr_settings.psr_version = DC_PSR_VERSION_UNSUPPORTED;
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	/*
+	 * Neither DC_PSR_VERSION_1 nor DC_PSR_VERSION_SU_1,
+	 * so psr_version stays at its zero-initialised value.
+	 */
+	KUNIT_EXPECT_EQ(test, (int)caps.psr_version, 0);
+}
+
+/* Tests for amdgpu_dm_psr_fill_caps() — RFB setup time */
+
+static void dm_test_psr_fill_caps_setup_time_zero(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	/* PSR_SETUP_TIME = 0 → (6 - 0) * 55 = 330 */
+	link->dpcd_caps.psr_info.psr_dpcd_caps.bits.PSR_SETUP_TIME = 0;
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	KUNIT_EXPECT_EQ(test, caps.psr_rfb_setup_time, 330U);
+}
+
+static void dm_test_psr_fill_caps_setup_time_mid(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	/* PSR_SETUP_TIME = 3 → (6 - 3) * 55 = 165 */
+	link->dpcd_caps.psr_info.psr_dpcd_caps.bits.PSR_SETUP_TIME = 3;
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	KUNIT_EXPECT_EQ(test, caps.psr_rfb_setup_time, 165U);
+}
+
+static void dm_test_psr_fill_caps_setup_time_max(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	/* PSR_SETUP_TIME = 6 → (6 - 6) * 55 = 0 */
+	link->dpcd_caps.psr_info.psr_dpcd_caps.bits.PSR_SETUP_TIME = 6;
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	KUNIT_EXPECT_EQ(test, caps.psr_rfb_setup_time, 0U);
+}
+
+/* Tests for amdgpu_dm_psr_fill_caps() — link training flag */
+
+static void dm_test_psr_fill_caps_link_training_required(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	link->dpcd_caps.psr_info.psr_dpcd_caps.bits.LINK_TRAINING_ON_EXIT_NOT_REQUIRED = 0;
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	KUNIT_EXPECT_TRUE(test, caps.psr_exit_link_training_required);
+}
+
+static void dm_test_psr_fill_caps_link_training_not_required(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+	link->dpcd_caps.psr_info.psr_dpcd_caps.bits.LINK_TRAINING_ON_EXIT_NOT_REQUIRED = 1;
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	KUNIT_EXPECT_FALSE(test, caps.psr_exit_link_training_required);
+}
+
+/* Tests for amdgpu_dm_psr_fill_caps() — DPCD field passthrough */
+
+static void dm_test_psr_fill_caps_dpcd_fields(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+
+	link->dpcd_caps.edp_rev = 0x14;
+	link->dpcd_caps.psr_info.psr_version = 2;
+	link->dpcd_caps.psr_info.psr_dpcd_caps.bits.SU_GRANULARITY_REQUIRED = 1;
+	link->dpcd_caps.psr_info.psr_dpcd_caps.bits.Y_COORDINATE_REQUIRED = 1;
+	link->dpcd_caps.psr_info.psr2_su_y_granularity_cap = 4;
+	link->dpcd_caps.alpm_caps.bits.AUX_WAKE_ALPM_CAP = 1;
+	link->dpcd_caps.alpm_caps.bits.PM_STATE_2A_SUPPORT = 1;
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	KUNIT_EXPECT_EQ(test, (int)caps.edp_revision, 0x14);
+	KUNIT_EXPECT_EQ(test, (int)caps.support_ver, 2);
+	KUNIT_EXPECT_TRUE(test, caps.su_granularity_required);
+	KUNIT_EXPECT_TRUE(test, caps.y_coordinate_required);
+	KUNIT_EXPECT_EQ(test, (int)caps.su_y_granularity, 4);
+	KUNIT_EXPECT_TRUE(test, caps.alpm_cap);
+	KUNIT_EXPECT_TRUE(test, caps.standby_support);
+}
+
+static void dm_test_psr_fill_caps_dpcd_fields_unset(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	memset(&caps, 0xFF, sizeof(caps));
+
+	/* All dpcd_caps fields are zero from kzalloc */
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	KUNIT_EXPECT_EQ(test, (int)caps.edp_revision, 0);
+	KUNIT_EXPECT_EQ(test, (int)caps.support_ver, 0);
+	KUNIT_EXPECT_FALSE(test, caps.su_granularity_required);
+	KUNIT_EXPECT_FALSE(test, caps.y_coordinate_required);
+	KUNIT_EXPECT_EQ(test, (int)caps.su_y_granularity, 0);
+	KUNIT_EXPECT_FALSE(test, caps.alpm_cap);
+	KUNIT_EXPECT_FALSE(test, caps.standby_support);
+}
+
+/* Tests for amdgpu_dm_psr_fill_caps() — rate control and power opts */
+
+static void dm_test_psr_fill_caps_rate_control_always_zero(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	/* Pre-fill caps with non-zero to verify overwrite */
+	memset(&caps, 0xFF, sizeof(caps));
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	KUNIT_EXPECT_EQ(test, (int)caps.rate_control_caps, 0);
+}
+
+static void dm_test_psr_fill_caps_power_opts_z10_always_set(struct kunit *test)
+{
+	struct dc_link *link = alloc_test_link(test);
+	struct psr_caps caps;
+
+	memset(&caps, 0, sizeof(caps));
+
+	amdgpu_dm_psr_fill_caps(link, &caps);
+
+	/*
+	 * psr_power_opt_z10_static_screen is always added to power_opts
+	 * regardless of amdgpu_dc_feature_mask.
+	 */
+	KUNIT_EXPECT_TRUE(test,
+			  (caps.psr_power_opt_flag &
+			   psr_power_opt_z10_static_screen) != 0);
+}
+/* End of tests for amdgpu_dm_psr_fill_caps() */
+
+static struct kunit_case dm_psr_test_cases[] = {
+	KUNIT_CASE(dm_test_psr_fill_caps_version_1),
+	KUNIT_CASE(dm_test_psr_fill_caps_version_su1),
+	KUNIT_CASE(dm_test_psr_fill_caps_version_unsupported),
+	KUNIT_CASE(dm_test_psr_fill_caps_setup_time_zero),
+	KUNIT_CASE(dm_test_psr_fill_caps_setup_time_mid),
+	KUNIT_CASE(dm_test_psr_fill_caps_setup_time_max),
+	KUNIT_CASE(dm_test_psr_fill_caps_link_training_required),
+	KUNIT_CASE(dm_test_psr_fill_caps_link_training_not_required),
+	KUNIT_CASE(dm_test_psr_fill_caps_dpcd_fields),
+	KUNIT_CASE(dm_test_psr_fill_caps_dpcd_fields_unset),
+	KUNIT_CASE(dm_test_psr_fill_caps_rate_control_always_zero),
+	KUNIT_CASE(dm_test_psr_fill_caps_power_opts_z10_always_set),
+	{}
+};
+
+static struct kunit_suite dm_psr_test_suite = {
+	.name = "amdgpu_dm_psr",
+	.test_cases = dm_psr_test_cases,
+};
+
+kunit_test_suite(dm_psr_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_psr");
+MODULE_AUTHOR("AMD");
-- 
2.43.0

