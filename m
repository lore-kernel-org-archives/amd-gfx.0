Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F8FCD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:51:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9143B10E888;
	Wed, 10 Jun 2026 09:51:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VLuLS3m7";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7634610E888
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qkGeGPBlmc1Tzg12LxisrZNGz8SU5BLK/WzkGj+XP2fz9vMzifdMfms77tEJHWpYvxtf4vbYjp2gTmLXNFh8f7I7BlpDocNJYY6REvtSINzK5nJ8aAhtomlVOV2ry71fPOFwPLNFSNdX/XAK2wVtVdtMHxnMWNrRZ61kkzFW1/SHJPcPLfedR58hqHIeJJi/TpEDLHBukyssufvsIvQaLCB6Wk9TU676vwxiC6KT1y8x9PuZm9y2jUSTdieGrnLdnkUUr/q4TnSxw+46e1US7kTYkpfCMrFoUd6KYryTxNYUW6XTqBGzFmsiH3AIAGRCUByc2To/+3YCcA20rS7auw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+mxR64BXgY/JuCzLbZ5fv0g5LQvSaHDNoebAxJ1KuK4=;
 b=KHZYWhmeTjrOvkCpfq413TIfgFEiFTVLatUIpWRU+iQ15HRE964FOk66VrGwLo+3WB12Nc1A+LbJP1kH50bQBoOv+1Mh7ZyUO3w2hmVlaaWp7ntHwEG4Xt1IcwHJlNcL/kChi/u8IghXAjPGTSzT0ZddaKq595p+0hAkDLf7u/tyl6xA+ga1k2SlE+B8jBRMcUiEFhWF9FubhGO2tg/94wMgOCEAuiH8TgphjtQNkA78ZMDtCAKohJoi6176pfP3feXJvYrmQxIYvAMC+3odRlWM4p84emHKnXmz23jOzanZRYeOTaXZVHRdtiY3EuCZXI7maSqABP1iVNKZzMaUgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mxR64BXgY/JuCzLbZ5fv0g5LQvSaHDNoebAxJ1KuK4=;
 b=VLuLS3m7u8yx0J7eKIQRVwmd4j9JRL0DRQjCP8NMtA8WQrfLAyRw7qNcc1T9FqidWx18oPFAEP5cxLHQM9EKlyRIPO4PDTxEgsXN7fyqQYh53K0x0p2DFzHlaZKA07awUbPcEZOWV5WXx+6AUHW+T5f81a8bqL8q0COqiWroyl4=
Received: from PH8P223CA0023.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::11)
 by CH1PR12MB9576.namprd12.prod.outlook.com (2603:10b6:610:2ad::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 09:51:40 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:2db:cafe::7b) by PH8P223CA0023.outlook.office365.com
 (2603:10b6:510:2db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.12 via Frontend Transport; Wed,
 10 Jun 2026 09:51:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:51:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:51:39 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:51:31 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 24/32] drm/amd/display: Add KUnit tests for amdgpu_dm_services
Date: Wed, 10 Jun 2026 17:45:08 +0800
Message-ID: <20260610094639.1965367-25-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|CH1PR12MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c468ee-d94c-4fb9-d9b8-08dec6d5deca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|3023799007|18002099003|22082099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: mUiJCqyvvHbtgfNyr/ErnjzhPyuwXaHFYAgsHO7WMWe+ydqUZntpwGyTIkuY/mCmMrwIHpoyPKBUn+mbrAhjbjqnwg9fV6yvDhbCii4NIozSZN9LnbcM2XYijV9jYGq65puf9TB6azaZ/WC7T2E3Xbp5+gY7NpA9xPuxR4LgGhxN93qvLw5csf6VuVRjjl/rivLb9Mv2lUVGHaN+nhvgRX3ykG4TC0ApqFRhQTTKnWr77bMcsZhh+OGjqeXBUBGUczDFrQbBLpUnES2ilxqQ9Id6wGdunHucHxOXHD5MJ3WJTThw31gokm0dJmD7iDcVb+Zm1t6n5zfbDrjb8YlprjJ3TQCJw+RE/7CCEt2JEFnKp2ZW3b/Oxik9x7FgRcKaW1iEV3DvMQ5BmNmmgmqVzgud9xEgvxYpMfZSoHY10xvdGgwkEELkFqzT03uipqwcqn31tthpWjZm5iCe16o7QsEalDU9i0uXuUCx4xpzin5VvdzF9/X7hz1CkF+fPEQgH+PBinFE5m4SF6/oexfXPGPLsg+6yMfk777HzvEU7Y5RjbuhbDnOPiWLzLpCJyCIKKms5d79MAVNJcYYwo20CtKWfjzUmIlPOxDjkUj34BclRYPLY5y9JQrfj1hE0hKejAtWhGcLeSmx7y6Lams72COBKxYcZFFDDsxDztmQR2/u2OE8pvfrvCsmt9FIPAyUe7MsMiX4C0elklBJ/swQmgU0KSTJWhcQPTH7xg3m+8g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(3023799007)(18002099003)(22082099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WnZ8dmbWzxiOPt3PX0Y456E78S5iItSChJX9VaxP7Pk9QHZs8kQ/XPoSzbNWKp/na5qLDtwqDH9hj24RUyOczvqyRHylov9qH75fkUlm0m9G0loSrRWoqWteekJQnE43oUTFoGvpVS9XFoanLpUZ4MZcsU5uLu14Dt5x7c3QhdILWTkEnMc1nLKlVg5EzEt8xT5JphJwIOJzGuQfjtxJQ/05hoAsSe8vAj/wPW4G1DiXPY4uzq3fNplyLfXp5vIdjqgCJ7HD6sKC49GBAJ9wVjywPbFg9GHLwTh6zidTO2/W5m1QYLNB+bYNviGiJv119wwXDRaMKmTjpBtOO+lEpEgUX9HnGKtdErs7adkxGIc+40R6ZZEZgwL/88Tlyhldg2AAxO2XqHtN5NoyrUUQdyreYTo3LiW4SYni8GE55834Qlfz67OvpFgtMDlrz+mx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:51:40.0714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c468ee-d94c-4fb9-d9b8-08dec6d5deca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9576
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

Add amdgpu_dm_services_test.c with KUnit coverage for five
functions in amdgpu_dm_services.c:

- dm_get_elapse_time_in_ns(): four arithmetic cases covering
  zero delta, positive delta, ULLONG_MAX span, and unsigned
  wraparound.
- dm_perf_trace_timestamp(): one case verifying the function
  dereferences ctx->perf_trace safely (the tracepoint is a
  no-op without an attached probe).
- dm_trace_smu_enter(): two cases for the empty stub with NULL
  ctx and with non-zero parameters.
- dm_trace_smu_exit(): three cases for the empty stub covering
  success, failure, and a non-zero response value.
- dm_query_extended_brightness_caps(): four guard-clause cases
  (NULL ctx, NULL caps, NULL ctx->driver_context, NULL ctx with
  LCD2) plus two success cases covering the LCD1 slot with
  luminance data copy and a non-LCD1 display using the second
  backlight slot with zero data points.

Assisted-by: Copilot:Claude-Opus-4.8

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   6 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c | 313 ++++++++++++++++++
 3 files changed, 320 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 0fdcf70256cc..6c0464754ed8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -36,6 +36,7 @@
 #include "amdgpu_dm_irq.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_dm_trace.h"
+#include "amdgpu_dm_kunit_helpers.h"
 
 	unsigned long long
 	dm_get_elapse_time_in_ns(struct dc_context *ctx,
@@ -44,6 +45,7 @@
 {
 	return current_time_stamp - last_time_stamp;
 }
+EXPORT_IF_KUNIT(dm_get_elapse_time_in_ns);
 
 void dm_perf_trace_timestamp(const char *func_name, unsigned int line, struct dc_context *ctx)
 {
@@ -53,14 +55,17 @@ void dm_perf_trace_timestamp(const char *func_name, unsigned int line, struct dc
 				    &ctx->perf_trace->last_entry_write,
 				    func_name, line);
 }
+EXPORT_IF_KUNIT(dm_perf_trace_timestamp);
 
 void dm_trace_smu_enter(uint32_t msg_id, uint32_t param_in, unsigned int delay, struct dc_context *ctx)
 {
 }
+EXPORT_IF_KUNIT(dm_trace_smu_enter);
 
 void dm_trace_smu_exit(bool success, uint32_t response, struct dc_context *ctx)
 {
 }
+EXPORT_IF_KUNIT(dm_trace_smu_exit);
 
 /**** power component interfaces ****/
 
@@ -90,3 +95,4 @@ bool dm_query_extended_brightness_caps(struct dc_context *ctx,
 			sizeof(struct dm_bl_data_point) * pCaps->num_data_points);
 	return true;
 }
+EXPORT_IF_KUNIT(dm_query_extended_brightness_caps);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
index cde8f7748bc5..364b4f3c783f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_mst_types_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_pp_smu_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_test.o
 obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_crtc_test.o
+obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) += amdgpu_dm_services_test.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
new file mode 100644
index 000000000000..e48bac7fb024
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * KUnit tests for amdgpu_dm_services.c
+ *
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <kunit/test.h>
+
+#include "dc.h"
+#include "amdgpu.h"
+#include "amdgpu_mode.h"
+#include "amdgpu_dm.h"
+#include "dm_services.h"
+#include "dm_services_types.h"
+
+/* Tests for dm_get_elapse_time_in_ns() */
+
+/**
+ * dm_test_get_elapse_time_zero_delta - Test Get elapse time zero delta
+ * @test: The KUnit test context
+ */
+static void dm_test_get_elapse_time_zero_delta(struct kunit *test)
+{
+	unsigned long long ts = 1000000ULL;
+
+	KUNIT_EXPECT_EQ(test, dm_get_elapse_time_in_ns(NULL, ts, ts), 0ULL);
+}
+
+/**
+ * dm_test_get_elapse_time_positive_delta - Test Get elapse time positive delta
+ * @test: The KUnit test context
+ */
+static void dm_test_get_elapse_time_positive_delta(struct kunit *test)
+{
+	unsigned long long current_ts = 5000000ULL;
+	unsigned long long last_ts = 1000000ULL;
+
+	KUNIT_EXPECT_EQ(test, dm_get_elapse_time_in_ns(NULL, current_ts, last_ts),
+			4000000ULL);
+}
+
+/**
+ * dm_test_get_elapse_time_large_delta - Test Get elapse time large delta
+ * @test: The KUnit test context
+ */
+static void dm_test_get_elapse_time_large_delta(struct kunit *test)
+{
+	unsigned long long current_ts = ULLONG_MAX;
+	unsigned long long last_ts = 0ULL;
+
+	KUNIT_EXPECT_EQ(test, dm_get_elapse_time_in_ns(NULL, current_ts, last_ts),
+			ULLONG_MAX);
+}
+
+/**
+ * dm_test_get_elapse_time_wraparound - Test Get elapse time wraparound
+ * @test: The KUnit test context
+ */
+static void dm_test_get_elapse_time_wraparound(struct kunit *test)
+{
+	/* Unsigned wraparound: result = ULLONG_MAX - last + current + 1 */
+	unsigned long long current_ts = 5ULL;
+	unsigned long long last_ts = ULLONG_MAX - 4ULL;
+
+	KUNIT_EXPECT_EQ(test, dm_get_elapse_time_in_ns(NULL, current_ts, last_ts),
+			10ULL);
+}
+
+/* Tests for dm_perf_trace_timestamp() */
+
+/**
+ * dm_test_perf_trace_timestamp_basic - Test Perf trace timestamp basic
+ * @test: The KUnit test context
+ *
+ * The tracepoint is a no-op without an attached probe, so this verifies the
+ * function dereferences ctx->perf_trace safely and does not crash.
+ */
+static void dm_test_perf_trace_timestamp_basic(struct kunit *test)
+{
+	struct dc_context *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	ctx->perf_trace = kunit_kzalloc(test, sizeof(*ctx->perf_trace), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->perf_trace);
+
+	ctx->perf_trace->read_count = 10;
+	ctx->perf_trace->write_count = 20;
+
+	dm_perf_trace_timestamp(__func__, __LINE__, ctx);
+}
+
+/* Tests for dm_trace_smu_enter() */
+
+/**
+ * dm_test_trace_smu_enter_null_ctx - Test Trace smu enter null ctx
+ * @test: The KUnit test context
+ */
+static void dm_test_trace_smu_enter_null_ctx(struct kunit *test)
+{
+	/* Empty stub — must not crash with NULL ctx */
+	dm_trace_smu_enter(0, 0, 0, NULL);
+}
+
+/**
+ * dm_test_trace_smu_enter_with_params - Test Trace smu enter with params
+ * @test: The KUnit test context
+ */
+static void dm_test_trace_smu_enter_with_params(struct kunit *test)
+{
+	/* Exercise non-zero msg_id, param_in, and delay */
+	dm_trace_smu_enter(0xFF, 0x12345678, 1000, NULL);
+}
+
+/* Tests for dm_trace_smu_exit() */
+
+/**
+ * dm_test_trace_smu_exit_success_null_ctx - Test Trace smu exit success null ctx
+ * @test: The KUnit test context
+ */
+static void dm_test_trace_smu_exit_success_null_ctx(struct kunit *test)
+{
+	/* Empty stub — must not crash on success path with NULL ctx */
+	dm_trace_smu_exit(true, 0x0, NULL);
+}
+
+/**
+ * dm_test_trace_smu_exit_failure_null_ctx - Test Trace smu exit failure null ctx
+ * @test: The KUnit test context
+ */
+static void dm_test_trace_smu_exit_failure_null_ctx(struct kunit *test)
+{
+	/* Empty stub — must not crash on failure path with NULL ctx */
+	dm_trace_smu_exit(false, 0x0, NULL);
+}
+
+/**
+ * dm_test_trace_smu_exit_with_response - Test Trace smu exit with response
+ * @test: The KUnit test context
+ */
+static void dm_test_trace_smu_exit_with_response(struct kunit *test)
+{
+	/* Exercise non-zero response value */
+	dm_trace_smu_exit(true, 0xDEADBEEF, NULL);
+}
+
+/* Tests for dm_query_extended_brightness_caps() */
+
+/**
+ * dm_test_query_brightness_caps_null_ctx - Test Query brightness caps null ctx
+ * @test: The KUnit test context
+ */
+static void dm_test_query_brightness_caps_null_ctx(struct kunit *test)
+{
+	struct dm_acpi_atif_backlight_caps caps = {};
+
+	KUNIT_EXPECT_FALSE(test,
+			   dm_query_extended_brightness_caps(NULL, AcpiDisplayType_LCD1, &caps));
+}
+
+/**
+ * dm_test_query_brightness_caps_null_caps - Test Query brightness caps null caps
+ * @test: The KUnit test context
+ */
+static void dm_test_query_brightness_caps_null_caps(struct kunit *test)
+{
+	struct dc_context ctx = {};
+
+	ctx.driver_context = (void *)0x1; /* non-NULL sentinel */
+
+	KUNIT_EXPECT_FALSE(test,
+			   dm_query_extended_brightness_caps(&ctx, AcpiDisplayType_LCD1, NULL));
+}
+
+/**
+ * dm_test_query_brightness_caps_null_driver_ctx - Test Query brightness caps null driver ctx
+ * @test: The KUnit test context
+ */
+static void dm_test_query_brightness_caps_null_driver_ctx(struct kunit *test)
+{
+	struct dc_context ctx = {};
+	struct dm_acpi_atif_backlight_caps caps = {};
+
+	ctx.driver_context = NULL;
+
+	KUNIT_EXPECT_FALSE(test,
+			   dm_query_extended_brightness_caps(&ctx, AcpiDisplayType_LCD1, &caps));
+}
+
+/**
+ * dm_test_query_brightness_caps_lcd2_null_ctx - Test Query brightness caps lcd2 null ctx
+ * @test: The KUnit test context
+ */
+static void dm_test_query_brightness_caps_lcd2_null_ctx(struct kunit *test)
+{
+	struct dm_acpi_atif_backlight_caps caps = {};
+
+	KUNIT_EXPECT_FALSE(test,
+			   dm_query_extended_brightness_caps(NULL, AcpiDisplayType_LCD2, &caps));
+}
+
+/**
+ * dm_test_query_brightness_caps_lcd1_success - Test Query brightness caps lcd1 success
+ * @test: The KUnit test context
+ */
+static void dm_test_query_brightness_caps_lcd1_success(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_backlight_caps *source_caps;
+	struct dc_context ctx = {};
+	struct dm_acpi_atif_backlight_caps caps = {};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	source_caps = &adev->dm.backlight_caps[0];
+	source_caps->caps_valid = true;
+	source_caps->min_input_signal = 12;
+	source_caps->max_input_signal = 240;
+	source_caps->ac_level = 80;
+	source_caps->dc_level = 40;
+	source_caps->data_points = 2;
+	source_caps->luminance_data[0].luminance = 10;
+	source_caps->luminance_data[0].input_signal = 22;
+	source_caps->luminance_data[1].luminance = 90;
+	source_caps->luminance_data[1].input_signal = 200;
+	ctx.driver_context = adev;
+
+	KUNIT_EXPECT_TRUE(test,
+			  dm_query_extended_brightness_caps(&ctx, AcpiDisplayType_LCD1, &caps));
+	KUNIT_EXPECT_EQ(test, caps.num_data_points, 2);
+	KUNIT_EXPECT_EQ(test, caps.max_input_signal, 240);
+	KUNIT_EXPECT_EQ(test, caps.min_input_signal, 12);
+	KUNIT_EXPECT_EQ(test, caps.ac_level_percentage, 80);
+	KUNIT_EXPECT_EQ(test, caps.dc_level_percentage, 40);
+	KUNIT_EXPECT_EQ(test, caps.data_points[0].luminance, 10);
+	KUNIT_EXPECT_EQ(test, caps.data_points[0].signal_level, 22);
+	KUNIT_EXPECT_EQ(test, caps.data_points[1].luminance, 90);
+	KUNIT_EXPECT_EQ(test, caps.data_points[1].signal_level, 200);
+}
+
+/**
+ * dm_test_query_brightness_caps_non_lcd1_uses_second_slot - Test Query brightness caps non lcd1 uses second slot
+ * @test: The KUnit test context
+ */
+static void dm_test_query_brightness_caps_non_lcd1_uses_second_slot(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct amdgpu_dm_backlight_caps *source_caps;
+	struct dc_context ctx = {};
+	struct dm_acpi_atif_backlight_caps caps = {};
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+
+	adev->dm.backlight_caps[0].caps_valid = true;
+	adev->dm.backlight_caps[0].min_input_signal = 1;
+	adev->dm.backlight_caps[0].max_input_signal = 2;
+	source_caps = &adev->dm.backlight_caps[1];
+	source_caps->caps_valid = true;
+	source_caps->min_input_signal = 33;
+	source_caps->max_input_signal = 199;
+	source_caps->ac_level = 70;
+	source_caps->dc_level = 30;
+	source_caps->data_points = 0;
+	ctx.driver_context = adev;
+
+	KUNIT_EXPECT_TRUE(test,
+			  dm_query_extended_brightness_caps(&ctx, AcpiDisplayType_DFP1, &caps));
+	KUNIT_EXPECT_EQ(test, caps.num_data_points, 0);
+	KUNIT_EXPECT_EQ(test, caps.max_input_signal, 199);
+	KUNIT_EXPECT_EQ(test, caps.min_input_signal, 33);
+	KUNIT_EXPECT_EQ(test, caps.ac_level_percentage, 70);
+	KUNIT_EXPECT_EQ(test, caps.dc_level_percentage, 30);
+	KUNIT_EXPECT_EQ(test, caps.data_points[0].luminance, 0);
+	KUNIT_EXPECT_EQ(test, caps.data_points[0].signal_level, 0);
+}
+
+static struct kunit_case amdgpu_dm_services_test_cases[] = {
+	/* dm_get_elapse_time_in_ns */
+	KUNIT_CASE(dm_test_get_elapse_time_zero_delta),
+	KUNIT_CASE(dm_test_get_elapse_time_positive_delta),
+	KUNIT_CASE(dm_test_get_elapse_time_large_delta),
+	KUNIT_CASE(dm_test_get_elapse_time_wraparound),
+	/* dm_perf_trace_timestamp */
+	KUNIT_CASE(dm_test_perf_trace_timestamp_basic),
+	/* dm_trace_smu_enter */
+	KUNIT_CASE(dm_test_trace_smu_enter_null_ctx),
+	KUNIT_CASE(dm_test_trace_smu_enter_with_params),
+	/* dm_trace_smu_exit */
+	KUNIT_CASE(dm_test_trace_smu_exit_success_null_ctx),
+	KUNIT_CASE(dm_test_trace_smu_exit_failure_null_ctx),
+	KUNIT_CASE(dm_test_trace_smu_exit_with_response),
+	/* dm_query_extended_brightness_caps */
+	KUNIT_CASE(dm_test_query_brightness_caps_null_ctx),
+	KUNIT_CASE(dm_test_query_brightness_caps_null_caps),
+	KUNIT_CASE(dm_test_query_brightness_caps_null_driver_ctx),
+	KUNIT_CASE(dm_test_query_brightness_caps_lcd2_null_ctx),
+	KUNIT_CASE(dm_test_query_brightness_caps_lcd1_success),
+	KUNIT_CASE(dm_test_query_brightness_caps_non_lcd1_uses_second_slot),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_services_test_suite = {
+	.name = "amdgpu_dm_services",
+	.test_cases = amdgpu_dm_services_test_cases,
+};
+
+kunit_test_suite(amdgpu_dm_services_test_suite);
+
+MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_services");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.43.0

