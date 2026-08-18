Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDCBC5DF89
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2971410ECB1;
	Tue, 18 Aug 2026 20:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xB76B5e5";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5977810ECAB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9aJNEODIZz+ZnZyFZKVMK8syJb0tfSmW/mkYQ/FZv2qJklBJp0Nr/ZgwWy4xou8Y/0a3dz50XoD69a8iG0jkw5hkAF6sb9IER2lf2ODPIwbGlZ6J7cRYaIoWVLuQpXdlSdCSDsVL7DvNwGS7CendZFQ40ob79jWVmrJwU4sSvPwGnxwO04QONXPnJOUJ42RlvzlcG544hOhiXK38w4TuRwRR9vDGofYRYtX26I/v/pEZWvEEQc5p8wPTnbmwaAILfa+BZqjj22UW5JkfcgX4u0mIvYL8uIbZslDC3TFnhpofssIhWFo7+tMmomEcSZYaWQYKZdA542u0G1RN+Cvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXaPg9S/bhjHvpxr5NojmViVZCDGy8klPZvqQCRgDRg=;
 b=AdFM4HUUBwRuzP2OTgjkrFuhx4Ys+c64BYoKZ7n5MD3GNxxgd9E4bGavp6CJ9/XWvclc05lnRwk34VXzd7RZOgNJXac5UruX/0FyOZ38yfHEo6AN8jO5AL0DEYWir2MXQjcyR8KK0XU3xCgPuDXveoCWP82Jo6Xkm8SYixEHuBJGO9v3SFRP6vJGD+pMyx8tattxI1NYhWFd7H/6PHoo067M6oxtdv8MJmChEbtEPb0rMl0SOBOSe7XKKigWkf3vc45ctzfuSI/L2MR9ABfCKUpTVOVzmWjZj3MYBP9Y1Qyz3DWMDdlGsa+WX4evpCaynqfY5QPmFT2Hf6yg1l6Oxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXaPg9S/bhjHvpxr5NojmViVZCDGy8klPZvqQCRgDRg=;
 b=xB76B5e5Top1dAfYNAScUd7vSQFY71YG1yn5I8jCG6Z0wI1bB6hVoe3MjKWWD8Fcko+6xN3CUZxRi9aEEAnJx6NajyXWnkCeJCUAQIXYlnM7X7nowmUVhV7Ll71f4lMw5KokpaI4xEKRQZ8KifTx0jlyspoAHVdsGbfe096LSiI=
Received: from BN9PR03CA0564.namprd03.prod.outlook.com (2603:10b6:408:138::29)
 by SJ1PR12MB6172.namprd12.prod.outlook.com (2603:10b6:a03:459::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:35 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::1f) by BN9PR03CA0564.outlook.office365.com
 (2603:10b6:408:138::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:34 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:09 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:09 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 22/82] drm/amd/display: Test dm_helpers_dmub_set_config_sync
Date: Tue, 18 Aug 2026 16:15:14 -0400
Message-ID: <20260818202139.4172592-23-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SJ1PR12MB6172:EE_
X-MS-Office365-Filtering-Correlation-Id: 23497ef3-a919-4b19-bc70-08defd66706a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: AXefIHFctG+tymPA9swFbFgzHODM1erKtn88hDIQHzbnpXb2lWIkUUvbvxYjUN+RIFfF+z3I5x3Skxq3S4FLrOaO2SkaWNunJgCpQVqr82V4XBgz9fdXmP+aXmHEzSVyO8rTwtVtyT9Esy0JKylrZVUxrgO28x2AivNjfp37li4LrrLQc9EVP1p8hqHGTaOpPHMqXJDn/8j+B1p1wpz/PoFGV7o5JWD3GwpmFcKBF1iWQHXjssu63SBo8Gcako7ksDVk+3XoST4Ll6IQIgIRXFcFPMR7aVgMptoSUVvVwlt//v6/ifRC8inJ3w3Br1BXtNh29WbDm5Hc7Cr+aggjorbWHppDCg6SCzvRi4s5se1K33M/UXyylaQFQNeMFt5Odmj2Bky9D7zsn2DYkNjuxS1VyStzc4xCXBsQ1NjNDOQZAL5CHFu551ZL6xbLDKe+igq5UCQC1DZB4mbF0kuou+tSyuiFbRPyONzDQXnxngabavUJkGDPWuuBUGcbW/PAhd1bIZSAOdB/szArzqziilPRYtwfOwYMwgyLIZgiG6cZmw6v29RaqMYXoHfYh5q1dvpWzU2Y4YF8+bN+paavRC2XBFq+AUy+15XJJ3xyPtKpRvh5VP/X7Oh6AXQMfoNtOwXSqOTe3aqob1/Q4SsB16mm7OxdpfniXxmM0nf30Q7dFmyb9U73uhzLHGzhmi44
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zb1/77M0/6DcrqqirXbhV9zcDrr7CMExp4td30QAig8biOIv4xxb1vI+im0CQUa3br4Qy8qK9C5HqqaBbG1vplfE5Qsd2Vww6ff3X04lh5nNExkTiIOlBp8nbUGaxOvesg542r3Fkj7ZtjcA7A6rQmhNN3WaqtSXQLLU9dGmel2f/OIxo5wNGisuu5vUAH/CoTp2hBh93jhsNLoElw3ERE/2ZKgjZu/MZZTpWU55Sv/XE+UjRFBTlKjZN9XXLLYuc6YOjKwsYgV+sLgFuLMguvYAmiwc10+Tq0ivEuJGVZ7I9Y+MKU3JkIOfOhAGO7ucRi/WbTcnl21qa6NMooIcGIo+qyG20yORoetM/VrNZ+lMlJKCHm+IxfEM/w+w6WdndOpaPNnD6nKKrBencs/Db8PTGbQA62IbCZbTEBK8Y+oTrZ7VNxBpPXC2jNoFYSZF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:34.7275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23497ef3-a919-4b19-bc70-08defd66706a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6172
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
Add a KUnit test for dm_helpers_dmub_set_config_sync() that submits a
SET_CONFIG payload without a DC DMUB service.

The command cannot reach the firmware, so the helper still returns
success while reporting SET_CONFIG_UNKNOWN_ERROR.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  1 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 48 +++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 0344ce5ce816b..7c7783aa40745 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1374,6 +1374,7 @@ int dm_helpers_dmub_set_config_sync(struct dc_context *ctx,
 	return amdgpu_dm_process_dmub_set_config_sync(ctx, link->link_index, payload,
 			operation_result);
 }
+EXPORT_IF_KUNIT(dm_helpers_dmub_set_config_sync);
 
 void dm_set_dcn_clocks(struct dc_context *ctx, struct dc_clocks *clks)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 11a5e8f307354..170e0ee425b23 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -19,6 +19,7 @@
 #include "dc_bios_types.h"
 #include "dm_helpers.h"
 #include "ddc_service_types.h"
+#include "dmub/dmub_srv.h"
 #include "dmub_cmd.h"
 #include "amdgpu_dm_helpers.h"
 #include "amdgpu_dm_kunit_test_helpers.h"
@@ -3997,6 +3998,51 @@ static void dm_test_gpu_mem_alloc_and_free(struct kunit *test)
 	amdgpu_dm_services_kunit_set_ops(NULL);
 }
 
+/* Tests for dm_helpers_dmub_set_config_sync() */
+
+/**
+ * dm_test_dmub_set_config_sync_unknown_error - Test SET_CONFIG without a DMUB service
+ * @test: The KUnit test context
+ *
+ * The helper only unwraps the link index before forwarding. With no DC DMUB
+ * service the command cannot reach the firmware and is reported as completed
+ * with SET_CONFIG_UNKNOWN_ERROR.
+ */
+static void dm_test_dmub_set_config_sync_unknown_error(struct kunit *test)
+{
+	struct set_config_cmd_payload payload = {0};
+	enum set_config_status result = SET_CONFIG_PENDING;
+	struct dmub_notification *notify;
+	struct amdgpu_device *adev;
+	struct dc_context *dc_ctx;
+	struct dc_context *ctx;
+	struct dc_link *link;
+	struct dc *dc;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	dc_ctx = kunit_kzalloc(test, sizeof(*dc_ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc_ctx);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	notify = kunit_kzalloc(test, sizeof(*notify), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, notify);
+	link = dm_kunit_alloc_link(test);
+
+	dc->ctx = dc_ctx;
+	dc->links[0] = link;
+	ctx->dc = dc;
+	ctx->driver_context = adev;
+	adev->dm.dmub_notify = notify;
+	mutex_init(&adev->dm.dpia_aux_lock);
+	init_completion(&adev->dm.dmub_aux_transfer_done);
+
+	KUNIT_EXPECT_EQ(test, dm_helpers_dmub_set_config_sync(ctx, link, &payload, &result), 0);
+	KUNIT_EXPECT_EQ(test, (int)result, (int)SET_CONFIG_UNKNOWN_ERROR);
+}
+
 static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* edid_extract_panel_id */
 	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
@@ -4189,6 +4235,8 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_submit_i2c_over_aux_unimplemented),
 	/* dm_helpers_allocate_gpu_mem / dm_helpers_free_gpu_mem */
 	KUNIT_CASE(dm_test_gpu_mem_alloc_and_free),
+	/* dm_helpers_dmub_set_config_sync */
+	KUNIT_CASE(dm_test_dmub_set_config_sync_unknown_error),
 	{}
 };
 
-- 
2.43.0

