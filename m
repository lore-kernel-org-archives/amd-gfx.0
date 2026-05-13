Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD9ACD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C2610EEBC;
	Wed, 13 May 2026 14:33:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a3tzTAFZ";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010028.outbound.protection.outlook.com [52.101.201.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BCC10EEE5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y6lCJjcNs5+l5oKl5ofSnbMwdtDQiPVdrPKqqEEhtGUsVYwlo+alGutMB4KIBO+Ak7wd5oNhrY8Pj9GnKxG4vCiyA53D3wL1n4HrQD61hZkATCkUO0EPblbO3CP9kUaWrxdMR5rzR8RUu9MXCGzOL8WlDSb/WNaSK0CRIuc3zNGv+foABm/wmldf64x4J0OnEBIkRHNqrCcKwx207Nlc7Beerfw15NkFlvLC8R1jXcm0nnuimPSMh9qAYNwCWgHu4GK5XfXh1+WONLRcDHIFzIqVEKQmS3ZjyunipiFEDA1ThdrwjqAAf8CPUFZOSo357fR0aZA9iQMPyhliqzT92Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA7a1EHqiUCqwVCngx5GJe8C6j0KK7+BWNzzxtQWq5g=;
 b=n+oZfPkCd6yuGaMk6xet9SyCuhIB7PwlwvgHEOmska1Uh24YYGtgYtuucYKrLVUIxRYxjySEB4Hlr+BIYfAV8W8/G3BXXlJ5ypgfiV22cij+WjVgdk5wAUIAbI1EsA05X1XP0RoaKDImPBZeB62O++/U1NTMec3Rpm121DJ6ZV5yerB+7OkZrHZlz8nLQJsih3jd+hKyvypHsbUBUeaj3wMlNAX2Wzj7FzbDXfaChxJmXn/u/LxDhXVsXWS4XkRqoADhSLIiNG9TAKJKxlJPxDHXWoAqzFpzZcgz+fp/yIxJ+SfS6cvpIwlRxR7XrcSSHSY94Wh6imo/MRV9ZZvDJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA7a1EHqiUCqwVCngx5GJe8C6j0KK7+BWNzzxtQWq5g=;
 b=a3tzTAFZUaGvqE/r9Ed1xEIFMJHDxhvGobXhn+sCbt2Fqx8Wkv2+YKkEROxhsF5dMYyk2Sg2CEF1gOtyU2xRcQlh4Hds6KgDnHk2IUMXQC6eSKc1lWjPVXDWJHxDyswV9O8GzKsyyoR0tIt2VlCSGTHwnLxwiCNT4LWsf25QcP4=
Received: from CYZPR19CA0015.namprd19.prod.outlook.com (2603:10b6:930:8e::11)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 14:33:27 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:930:8e:cafe::22) by CYZPR19CA0015.outlook.office365.com
 (2603:10b6:930:8e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:21 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:21 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 11/28] drm/amd/display: Add KUnit test for ISM functions
Date: Wed, 13 May 2026 10:29:33 -0400
Message-ID: <20260513143213.1852892-13-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c50ae5f-342b-4066-10d7-08deb0fc974c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Ml0bDnBJ05NvcKTSQsoDAMFqFsFX/hGHKmo2U1zy86eOKkwcIlBdjoAkj74g2yqWB8sbT2VUnLP2D0m0CPEDJwM+BtibQXxSBgtP4c5/O8t5S4us7R3IgRe3EAs2QXV9rR5MQ6z0zzGeIk+ySZuR01/mVi2i40NQbGsmh5nyLuf7REfKKhbAbewPT4JrFq04qiaMKN043GZuoCgkVltM6TJblock7My1oZn41rd2k+ZsGuv/FCpHw6OvhfbbesWSKtNuVsbJe19aiTK2UbHhNzFwoKfouydtGy9HPV1oNi88XxRIE1rP89LJpzGQJuCW8EZOoXQbkfvUnLQfD3KkbaQsOWPt0Fu+6AXysi459vug7jF/KqWhpVcxFyPdWfN37UBkC4Msunlb4Qc4WbU3KL01kKQ0uf6+mQgXy6p7CIBotAN5A3HI7ULlVZDcoRpWHFEbA3VJKG6KVzYPqaewdN/zKKSJC6CnpV/RW1n3wYTW81aVfowOZ5dhvTscwIBfcnBsfUlQBTXgR95eWIPyZdPLWO2pcAKo8yTFeLfEvzz1Ey9CH2tv5s1oCAoGqrbpkAQwAVYXzG2RdSG3/ySr3kzfgClJlN8qkanmIFabLhoFHRlJCnrffdcXWJlSny5r/4MYMvivy5HwZYWkVX0j/BlPDN17PbqN2TjRZ1NDmaqNnY+peviEGqwvMSURQWMMramlhaP2Li3rxl7o2lsacsZsLuHWxjsCdZJFTUXMUmQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sEJOKsFYZeW8PlzXMYcvVAWHOJ3FIuOJvkGV8v8DHFf+olJNeEzlrK8OULFJ6Q0wNNBTCsqZUP//lTdZCOlUj9QpUu2243k4HGH6DqoJKC0d6SAhbnPusZT5Z/Tz7et5cYwE4ZF3Ezz5i84DSluDNyueqgRx+C0Lwz1KIWa6GaMLnala/hxzT858hTywzjPbThRnYV5fpmPfrQGj2aa/0LeRxYPN5Um3/n5y+jVq20dYrZJMeCGUFEukB3O0czQh4aTvFJFqcsyBfyyXRYkxGSbS0JZ620M05AEGtNJDG1vwH10WpfKBefxMt9MI/htfTV4qNlQG2yruANttjjvSxRa7OV2abK379o0aAM5PMqbZB2lHr/Z6gs68u11KqewYGs/X8+NPMc35UJOBjRSzrp96kT7+vcZx2vDV+xTGlVOZHLTRppBShLPnJiaR2+ON
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:24.9491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c50ae5f-342b-4066-10d7-08deb0fc974c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862
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

Add KUnit tests for three static functions in amdgpu_dm_ism.c:
dm_ism_next_state, dm_ism_get_sso_delay, and
dm_ism_get_idle_allow_delay.

The 32 test cases cover the full FSM transition table,
SSO delay calculation with various timings, and
hysteresis-based idle allow delay including circular
buffer wraparound and old history cutoff logic.

Conditionally remove static linkage and export the three
functions under CONFIG_DRM_AMD_DC_KUNIT_TEST so the test
module can call them.

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |  20 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |  10 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      | 636 ++++++++++++++++++
 4 files changed, 661 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
index d03ea3bafd46..bc7db5e759d1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
@@ -32,6 +32,8 @@
 #include "amdgpu_dm_ism.h"
 #include "amdgpu_dm_crtc.h"
 #include "amdgpu_dm_trace.h"
+#include "amdgpu_dm_kunit_helpers.h"
+
 
 /**
  * dm_ism_next_state - Get next state based on current state and event
@@ -42,9 +44,10 @@
  * This function defines the idle state management FSM. Invalid transitions
  * are ignored and will not progress the FSM.
  */
-static bool dm_ism_next_state(enum amdgpu_dm_ism_state current_state,
-			      enum amdgpu_dm_ism_event event,
-			      enum amdgpu_dm_ism_state *next_state)
+STATIC_IFN_KUNIT
+bool dm_ism_next_state(enum amdgpu_dm_ism_state current_state,
+		       enum amdgpu_dm_ism_event event,
+		       enum amdgpu_dm_ism_state *next_state)
 {
 	switch (STATE_EVENT(current_state, event)) {
 	case STATE_EVENT(DM_ISM_STATE_FULL_POWER_RUNNING,
@@ -125,8 +128,10 @@ static bool dm_ism_next_state(enum amdgpu_dm_ism_state current_state,
 	}
 	return true;
 }
+EXPORT_IF_KUNIT(dm_ism_next_state);
 
-static uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
+STATIC_IFN_KUNIT
+uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
 				     const struct dc_stream_state *stream)
 {
 	const struct amdgpu_dm_ism_config *config = &ism->config;
@@ -148,6 +153,7 @@ static uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
 
 	return sso_delay_ns;
 }
+EXPORT_IF_KUNIT(dm_ism_get_sso_delay);
 
 /**
  * dm_ism_get_idle_allow_delay - Calculate hysteresis-based idle allow delay
@@ -157,8 +163,9 @@ static uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
  * Calculates the delay before allowing idle optimizations based on recent
  * idle history and the current stream timing.
  */
-static uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
-					    const struct dc_stream_state *stream)
+STATIC_IFN_KUNIT
+uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
+				     const struct dc_stream_state *stream)
 {
 	const struct amdgpu_dm_ism_config *config = &ism->config;
 	uint32_t v_total, h_total;
@@ -217,6 +224,7 @@ static uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
 
 	return ret_ns;
 }
+EXPORT_IF_KUNIT(dm_ism_get_idle_allow_delay);
 
 /**
  * dm_ism_insert_record - Insert a record into the circular history buffer
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
index fde0ddc8d4e4..4df6a82972a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h
@@ -148,4 +148,14 @@ void amdgpu_dm_ism_commit_event(struct amdgpu_dm_ism *ism,
 void amdgpu_dm_ism_disable(struct amdgpu_display_manager *dm);
 void amdgpu_dm_ism_enable(struct amdgpu_display_manager *dm);
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+bool dm_ism_next_state(enum amdgpu_dm_ism_state current_state,
+		       enum amdgpu_dm_ism_event event,
+		       enum amdgpu_dm_ism_state *next_state);
+uint64_t dm_ism_get_sso_delay(const struct amdgpu_dm_ism *ism,
+			      const struct dc_stream_state *stream);
+uint64_t dm_ism_get_idle_allow_delay(const struct amdgpu_dm_ism *ism,
+				     const struct dc_stream_state *stream);
+#endif
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index 7d9c983f4995..768f9bbc50e1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_color_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_colorop_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_psr_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_replay_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_ism_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
new file mode 100644
index 000000000000..e761105e1995
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_ism_test.c
@@ -0,0 +1,636 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_ism.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+
+#include "dc.h"
+#include "amdgpu_dm_ism.h"
+
+/*
+ * Helper: allocate and zero-initialise a dc_stream_state for timing tests.
+ * Only the timing sub-struct is accessed by the functions under test.
+ */
+static struct dc_stream_state *alloc_test_stream(struct kunit *test)
+{
+	struct dc_stream_state *stream;
+
+	stream = kunit_kzalloc(test, sizeof(*stream), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stream);
+
+	return stream;
+}
+
+/*
+ * Helper: allocate and zero-initialise an ISM instance.
+ */
+static struct amdgpu_dm_ism *alloc_test_ism(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism;
+
+	ism = kunit_kzalloc(test, sizeof(*ism), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ism);
+
+	return ism;
+}
+
+/* ===== Tests for dm_ism_next_state — FULL_POWER_RUNNING transitions ===== */
+
+static void dm_test_ism_next_state_running_enter_idle(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_FULL_POWER_RUNNING,
+			       DM_ISM_EVENT_ENTER_IDLE_REQUESTED, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_HYSTERESIS_WAITING);
+}
+
+static void dm_test_ism_next_state_running_begin_cursor(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_FULL_POWER_RUNNING,
+			       DM_ISM_EVENT_BEGIN_CURSOR_UPDATE, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_FULL_POWER_BUSY);
+}
+
+static void dm_test_ism_next_state_running_invalid(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next = DM_ISM_NUM_STATES;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_FULL_POWER_RUNNING,
+			       DM_ISM_EVENT_EXIT_IDLE_REQUESTED, &next);
+	KUNIT_EXPECT_FALSE(test, ok);
+	/* next should remain untouched on invalid transition */
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_NUM_STATES);
+}
+
+/* ===== Tests for dm_ism_next_state — FULL_POWER_BUSY transitions ===== */
+
+static void dm_test_ism_next_state_busy_enter_idle(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_FULL_POWER_BUSY,
+			       DM_ISM_EVENT_ENTER_IDLE_REQUESTED, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_HYSTERESIS_BUSY);
+}
+
+static void dm_test_ism_next_state_busy_end_cursor(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_FULL_POWER_BUSY,
+			       DM_ISM_EVENT_END_CURSOR_UPDATE, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_FULL_POWER_RUNNING);
+}
+
+/* ===== Tests for dm_ism_next_state — HYSTERESIS_WAITING transitions ===== */
+
+static void dm_test_ism_next_state_hyst_wait_exit_idle(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_HYSTERESIS_WAITING,
+			       DM_ISM_EVENT_EXIT_IDLE_REQUESTED, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_TIMER_ABORTED);
+}
+
+static void dm_test_ism_next_state_hyst_wait_begin_cursor(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_HYSTERESIS_WAITING,
+			       DM_ISM_EVENT_BEGIN_CURSOR_UPDATE, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_HYSTERESIS_BUSY);
+}
+
+static void dm_test_ism_next_state_hyst_wait_timer(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_HYSTERESIS_WAITING,
+			       DM_ISM_EVENT_TIMER_ELAPSED, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_OPTIMIZED_IDLE);
+}
+
+static void dm_test_ism_next_state_hyst_wait_immediate(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_HYSTERESIS_WAITING,
+			       DM_ISM_EVENT_IMMEDIATE, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_OPTIMIZED_IDLE);
+}
+
+/* ===== Tests for dm_ism_next_state — HYSTERESIS_BUSY transitions ===== */
+
+static void dm_test_ism_next_state_hyst_busy_exit_idle(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_HYSTERESIS_BUSY,
+			       DM_ISM_EVENT_EXIT_IDLE_REQUESTED, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_FULL_POWER_BUSY);
+}
+
+static void dm_test_ism_next_state_hyst_busy_end_cursor(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_HYSTERESIS_BUSY,
+			       DM_ISM_EVENT_END_CURSOR_UPDATE, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_HYSTERESIS_WAITING);
+}
+
+/* ===== Tests for dm_ism_next_state — OPTIMIZED_IDLE transitions ===== */
+
+static void dm_test_ism_next_state_opt_idle_exit(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_OPTIMIZED_IDLE,
+			       DM_ISM_EVENT_EXIT_IDLE_REQUESTED, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_FULL_POWER_RUNNING);
+}
+
+static void dm_test_ism_next_state_opt_idle_begin_cursor(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_OPTIMIZED_IDLE,
+			       DM_ISM_EVENT_BEGIN_CURSOR_UPDATE, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_HYSTERESIS_BUSY);
+}
+
+static void dm_test_ism_next_state_opt_idle_sso_timer(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_OPTIMIZED_IDLE,
+			       DM_ISM_EVENT_SSO_TIMER_ELAPSED, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_OPTIMIZED_IDLE_SSO);
+}
+
+static void dm_test_ism_next_state_opt_idle_immediate(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_OPTIMIZED_IDLE,
+			       DM_ISM_EVENT_IMMEDIATE, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_OPTIMIZED_IDLE_SSO);
+}
+
+/* ===== Tests for dm_ism_next_state — OPTIMIZED_IDLE_SSO transitions ===== */
+
+static void dm_test_ism_next_state_opt_idle_sso_exit(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_OPTIMIZED_IDLE_SSO,
+			       DM_ISM_EVENT_EXIT_IDLE_REQUESTED, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_FULL_POWER_RUNNING);
+}
+
+static void dm_test_ism_next_state_opt_idle_sso_cursor(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_OPTIMIZED_IDLE_SSO,
+			       DM_ISM_EVENT_BEGIN_CURSOR_UPDATE, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_HYSTERESIS_BUSY);
+}
+
+/* ===== Tests for dm_ism_next_state — TIMER_ABORTED transitions ===== */
+
+static void dm_test_ism_next_state_aborted_immediate(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_TIMER_ABORTED,
+			       DM_ISM_EVENT_IMMEDIATE, &next);
+	KUNIT_EXPECT_TRUE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_STATE_FULL_POWER_RUNNING);
+}
+
+static void dm_test_ism_next_state_aborted_invalid(struct kunit *test)
+{
+	enum amdgpu_dm_ism_state next = DM_ISM_NUM_STATES;
+	bool ok;
+
+	ok = dm_ism_next_state(DM_ISM_STATE_TIMER_ABORTED,
+			       DM_ISM_EVENT_ENTER_IDLE_REQUESTED, &next);
+	KUNIT_EXPECT_FALSE(test, ok);
+	KUNIT_EXPECT_EQ(test, (int)next, (int)DM_ISM_NUM_STATES);
+}
+
+/* ===== Tests for dm_ism_get_sso_delay ===== */
+
+static void dm_test_ism_sso_delay_null_stream(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+
+	ism->config.sso_num_frames = 5;
+
+	KUNIT_EXPECT_EQ(test, dm_ism_get_sso_delay(ism, NULL), (uint64_t)0);
+}
+
+static void dm_test_ism_sso_delay_zero_frames(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+	ism->config.sso_num_frames = 0;
+
+	KUNIT_EXPECT_EQ(test, dm_ism_get_sso_delay(ism, stream), (uint64_t)0);
+}
+
+static void dm_test_ism_sso_delay_1080p60_3frames(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+	uint64_t expected_one_frame_ns, expected;
+
+	/*
+	 * 1080p@60Hz: v_total=1125, h_total=2200, pix_clk=148.5MHz
+	 * pix_clk_100hz = 1485000
+	 * one_frame_ns = (1125 * 2200 * 10000000) / 1485000 = 16666666 ns
+	 */
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+	ism->config.sso_num_frames = 3;
+
+	expected_one_frame_ns = div64_u64((uint64_t)1125 * 2200 * 10000000ULL,
+					  1485000);
+	expected = 3 * expected_one_frame_ns;
+
+	KUNIT_EXPECT_EQ(test, dm_ism_get_sso_delay(ism, stream), expected);
+}
+
+static void dm_test_ism_sso_delay_4k60_1frame(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+	uint64_t expected_one_frame_ns;
+
+	/*
+	 * 4K@60Hz: v_total=2250, h_total=4400, pix_clk=594MHz
+	 * pix_clk_100hz = 5940000
+	 */
+	stream->timing.v_total = 2250;
+	stream->timing.h_total = 4400;
+	stream->timing.pix_clk_100hz = 5940000;
+	ism->config.sso_num_frames = 1;
+
+	expected_one_frame_ns = div64_u64((uint64_t)2250 * 4400 * 10000000ULL,
+					  5940000);
+
+	KUNIT_EXPECT_EQ(test, dm_ism_get_sso_delay(ism, stream),
+			expected_one_frame_ns);
+}
+
+/* ===== Tests for dm_ism_get_idle_allow_delay ===== */
+
+static void dm_test_ism_idle_delay_null_stream(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+
+	ism->config.filter_num_frames = 5;
+	ism->config.filter_entry_count = 3;
+	ism->config.activation_num_delay_frames = 10;
+
+	KUNIT_EXPECT_EQ(test, dm_ism_get_idle_allow_delay(ism, NULL),
+			(uint64_t)0);
+}
+
+static void dm_test_ism_idle_delay_zero_filter_frames(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+	ism->config.filter_num_frames = 0;
+
+	KUNIT_EXPECT_EQ(test, dm_ism_get_idle_allow_delay(ism, stream),
+			(uint64_t)0);
+}
+
+static void dm_test_ism_idle_delay_zero_entry_count(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+	ism->config.filter_num_frames = 5;
+	ism->config.filter_entry_count = 0;
+
+	KUNIT_EXPECT_EQ(test, dm_ism_get_idle_allow_delay(ism, stream),
+			(uint64_t)0);
+}
+
+static void dm_test_ism_idle_delay_zero_delay_frames(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+	ism->config.filter_num_frames = 5;
+	ism->config.filter_entry_count = 3;
+	ism->config.activation_num_delay_frames = 0;
+
+	KUNIT_EXPECT_EQ(test, dm_ism_get_idle_allow_delay(ism, stream),
+			(uint64_t)0);
+}
+
+static void dm_test_ism_idle_delay_no_short_idles(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+	uint64_t one_frame_ns;
+
+	/*
+	 * All history records have long durations (well above the
+	 * short_idle_ns threshold), so no delay should be applied.
+	 */
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+
+	one_frame_ns = div64_u64((uint64_t)1125 * 2200 * 10000000ULL,
+				 1485000);
+
+	ism->config.filter_num_frames = 5;
+	ism->config.filter_entry_count = 3;
+	ism->config.activation_num_delay_frames = 10;
+	ism->config.filter_history_size = 8;
+	ism->config.filter_old_history_threshold = 0;
+
+	/* Fill history with long idle durations */
+	for (int i = 0; i < 8; i++) {
+		ism->records[i].duration_ns = one_frame_ns * 100;
+		ism->records[i].timestamp_ns = 0;
+	}
+	ism->next_record_idx = 8;
+
+	KUNIT_EXPECT_EQ(test, dm_ism_get_idle_allow_delay(ism, stream),
+			(uint64_t)0);
+}
+
+static void dm_test_ism_idle_delay_enough_short_idles(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+	uint64_t one_frame_ns, expected;
+
+	/*
+	 * Fill history with short idle durations that meet the threshold.
+	 * filter_entry_count=3, so 3 short idles should trigger the delay.
+	 */
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+
+	one_frame_ns = div64_u64((uint64_t)1125 * 2200 * 10000000ULL,
+				 1485000);
+
+	ism->config.filter_num_frames = 5;
+	ism->config.filter_entry_count = 3;
+	ism->config.activation_num_delay_frames = 10;
+	ism->config.filter_history_size = 8;
+	ism->config.filter_old_history_threshold = 0;
+
+	/* Fill history with short idle durations (1 frame each) */
+	for (int i = 0; i < 8; i++) {
+		ism->records[i].duration_ns = one_frame_ns;
+		ism->records[i].timestamp_ns = 0;
+	}
+	ism->next_record_idx = 8;
+
+	expected = 10 * one_frame_ns;
+	KUNIT_EXPECT_EQ(test, dm_ism_get_idle_allow_delay(ism, stream),
+			expected);
+}
+
+static void dm_test_ism_idle_delay_wraps_around_buffer(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+	uint64_t one_frame_ns, expected;
+
+	/*
+	 * Test the circular buffer wraparound: next_record_idx at 2 means
+	 * the most recent records are at indices 1, 0, 15, 14, ...
+	 */
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+
+	one_frame_ns = div64_u64((uint64_t)1125 * 2200 * 10000000ULL,
+				 1485000);
+
+	ism->config.filter_num_frames = 5;
+	ism->config.filter_entry_count = 3;
+	ism->config.activation_num_delay_frames = 10;
+	ism->config.filter_history_size = 8;
+	ism->config.filter_old_history_threshold = 0;
+
+	/* Fill entire buffer with short idles */
+	for (int i = 0; i < AMDGPU_DM_IDLE_HIST_LEN; i++) {
+		ism->records[i].duration_ns = one_frame_ns;
+		ism->records[i].timestamp_ns = 0;
+	}
+	/* Position next_record_idx at 2 to test wraparound */
+	ism->next_record_idx = 2;
+
+	expected = 10 * one_frame_ns;
+	KUNIT_EXPECT_EQ(test, dm_ism_get_idle_allow_delay(ism, stream),
+			expected);
+}
+
+static void dm_test_ism_idle_delay_old_history_cutoff(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+	uint64_t one_frame_ns;
+
+	/*
+	 * Test old_history_threshold: only recent entries within the
+	 * threshold should be counted. Set up 2 recent short idles but
+	 * require 3 — older entries are outside the threshold.
+	 */
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+
+	one_frame_ns = div64_u64((uint64_t)1125 * 2200 * 10000000ULL,
+				 1485000);
+
+	ism->config.filter_num_frames = 5;
+	ism->config.filter_entry_count = 3;
+	ism->config.activation_num_delay_frames = 10;
+	ism->config.filter_history_size = 8;
+	/* Threshold: entries older than 20 frames are ignored */
+	ism->config.filter_old_history_threshold = 20;
+
+	ism->last_idle_timestamp_ns = one_frame_ns * 100;
+
+	/* 2 recent short idles (within threshold) */
+	ism->records[6].duration_ns = one_frame_ns;
+	ism->records[6].timestamp_ns = one_frame_ns * 95;
+	ism->records[7].duration_ns = one_frame_ns;
+	ism->records[7].timestamp_ns = one_frame_ns * 98;
+
+	/* Older entries outside the threshold with long durations */
+	for (int i = 0; i < 6; i++) {
+		ism->records[i].duration_ns = one_frame_ns * 100;
+		ism->records[i].timestamp_ns = one_frame_ns * 10;
+	}
+	ism->next_record_idx = 8;
+
+	/*
+	 * Only 2 short idles within threshold, but 3 required —
+	 * should return 0 (no delay).
+	 */
+	KUNIT_EXPECT_EQ(test, dm_ism_get_idle_allow_delay(ism, stream),
+			(uint64_t)0);
+}
+
+static void dm_test_ism_idle_delay_mixed_durations(struct kunit *test)
+{
+	struct amdgpu_dm_ism *ism = alloc_test_ism(test);
+	struct dc_stream_state *stream = alloc_test_stream(test);
+	uint64_t one_frame_ns;
+
+	/*
+	 * Mix of short and long idle durations. Only 2 short idles
+	 * in 8 entries, but filter_entry_count=3, so no delay.
+	 */
+	stream->timing.v_total = 1125;
+	stream->timing.h_total = 2200;
+	stream->timing.pix_clk_100hz = 1485000;
+
+	one_frame_ns = div64_u64((uint64_t)1125 * 2200 * 10000000ULL,
+				 1485000);
+
+	ism->config.filter_num_frames = 5;
+	ism->config.filter_entry_count = 3;
+	ism->config.activation_num_delay_frames = 10;
+	ism->config.filter_history_size = 8;
+	ism->config.filter_old_history_threshold = 0;
+
+	/* 2 short idles, 6 long idles */
+	for (int i = 0; i < 8; i++) {
+		if (i == 6 || i == 7)
+			ism->records[i].duration_ns = one_frame_ns;
+		else
+			ism->records[i].duration_ns = one_frame_ns * 100;
+		ism->records[i].timestamp_ns = 0;
+	}
+	ism->next_record_idx = 8;
+
+	KUNIT_EXPECT_EQ(test, dm_ism_get_idle_allow_delay(ism, stream),
+			(uint64_t)0);
+}
+
+static struct kunit_case dm_ism_test_cases[] = {
+	/* dm_ism_next_state — FULL_POWER_RUNNING */
+	KUNIT_CASE(dm_test_ism_next_state_running_enter_idle),
+	KUNIT_CASE(dm_test_ism_next_state_running_begin_cursor),
+	KUNIT_CASE(dm_test_ism_next_state_running_invalid),
+	/* dm_ism_next_state — FULL_POWER_BUSY */
+	KUNIT_CASE(dm_test_ism_next_state_busy_enter_idle),
+	KUNIT_CASE(dm_test_ism_next_state_busy_end_cursor),
+	/* dm_ism_next_state — HYSTERESIS_WAITING */
+	KUNIT_CASE(dm_test_ism_next_state_hyst_wait_exit_idle),
+	KUNIT_CASE(dm_test_ism_next_state_hyst_wait_begin_cursor),
+	KUNIT_CASE(dm_test_ism_next_state_hyst_wait_timer),
+	KUNIT_CASE(dm_test_ism_next_state_hyst_wait_immediate),
+	/* dm_ism_next_state — HYSTERESIS_BUSY */
+	KUNIT_CASE(dm_test_ism_next_state_hyst_busy_exit_idle),
+	KUNIT_CASE(dm_test_ism_next_state_hyst_busy_end_cursor),
+	/* dm_ism_next_state — OPTIMIZED_IDLE */
+	KUNIT_CASE(dm_test_ism_next_state_opt_idle_exit),
+	KUNIT_CASE(dm_test_ism_next_state_opt_idle_begin_cursor),
+	KUNIT_CASE(dm_test_ism_next_state_opt_idle_sso_timer),
+	KUNIT_CASE(dm_test_ism_next_state_opt_idle_immediate),
+	/* dm_ism_next_state — OPTIMIZED_IDLE_SSO */
+	KUNIT_CASE(dm_test_ism_next_state_opt_idle_sso_exit),
+	KUNIT_CASE(dm_test_ism_next_state_opt_idle_sso_cursor),
+	/* dm_ism_next_state — TIMER_ABORTED */
+	KUNIT_CASE(dm_test_ism_next_state_aborted_immediate),
+	KUNIT_CASE(dm_test_ism_next_state_aborted_invalid),
+	/* dm_ism_get_sso_delay */
+	KUNIT_CASE(dm_test_ism_sso_delay_null_stream),
+	KUNIT_CASE(dm_test_ism_sso_delay_zero_frames),
+	KUNIT_CASE(dm_test_ism_sso_delay_1080p60_3frames),
+	KUNIT_CASE(dm_test_ism_sso_delay_4k60_1frame),
+	/* dm_ism_get_idle_allow_delay */
+	KUNIT_CASE(dm_test_ism_idle_delay_null_stream),
+	KUNIT_CASE(dm_test_ism_idle_delay_zero_filter_frames),
+	KUNIT_CASE(dm_test_ism_idle_delay_zero_entry_count),
+	KUNIT_CASE(dm_test_ism_idle_delay_zero_delay_frames),
+	KUNIT_CASE(dm_test_ism_idle_delay_no_short_idles),
+	KUNIT_CASE(dm_test_ism_idle_delay_enough_short_idles),
+	KUNIT_CASE(dm_test_ism_idle_delay_wraps_around_buffer),
+	KUNIT_CASE(dm_test_ism_idle_delay_old_history_cutoff),
+	KUNIT_CASE(dm_test_ism_idle_delay_mixed_durations),
+	{}
+};
+
+static struct kunit_suite dm_ism_test_suite = {
+	.name = "amdgpu_dm_ism",
+	.test_cases = dm_ism_test_cases,
+};
+
+kunit_test_suite(dm_ism_test_suite);
+
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_ism");
+MODULE_AUTHOR("AMD");
-- 
2.43.0

