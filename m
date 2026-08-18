Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABF1C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55BA110EC8C;
	Tue, 18 Aug 2026 20:22:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2wnUbWhE";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC52210EC8C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kl7xSiXw1M1Pghp4rpc2ACQptOMArbfobBZaSETGfLEExYilFdjJg6Zifw7hQhuzQJH0LZ224tIEOFRQOaMHoi+IrfDIFfMbAVxcDR8H9ozDYHU2gJmcGyF0b6J3bWOpDRvIaTW6cK4TwhttC7QG/onzwmVqqF0c1YwpcroBOQFvVy1rD9tS/OChCCxMAnKAzp2jdSZYn4Y6Wu26kbo3YtsR02j8qqRIjeJmki6xpQKBcdVSOwwvQj3g0Yzu2ZHqTQRZaUhcOmxGzU2iV0SVl0qGaWRcVnjs3uBoGRji78x1Wf0XQGBrM46dW1yfet+Kl3kVvLa+KV+1na1CIkcRJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnnczNLhJqHhO2KKwmXcpL1fuwH9gPO5LhcxiVOtb3U=;
 b=YGdBxvpRUv19E8EhjeZHHYwYTVPMWIakZIHjuT+BfQzZNGqa2IEgR5bcrVTTIIhroLtu8kDcx0KUE0Ig8psCHoym46KwV43K4PZ/btHQaKHjPJGPYjjxEzVtfyv/q0+d7vYZwhvXxDwBHgvfAa8XUulEoSVkq3NJc9Cqh8bLX/Zfxf1WvEeC/WoKchIUoWjYhf2R5kUl5KOeTNru5eebo88k42Nn96iNEDAtDZg+IzFSIF/yBGApLnKH1sS3uriR7Tqon5mFZSYNUobYwo2VqczxmndiThz8hrmHPoG10lK1nPeNpOdObRsLI7U3Ph46/sM5tL5Xoosoez19jhhbWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnnczNLhJqHhO2KKwmXcpL1fuwH9gPO5LhcxiVOtb3U=;
 b=2wnUbWhEhoXE9PeukN4B/jrMe0fLH9lNx5qd51Rhx8zGTNPE8Jf6d+CJDUdd6JTPM8JKB54JywKW4YSQQv2lgjL1XSsO6x4z8J2ZpJHGWYJTsuX5IHYmvl+w/br44EB6qkIHee5oazbaJhqTsvRWohqKrJ2/4EacJxIvZ7mdxFg=
Received: from CH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::26)
 by IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:00 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:610:1ee:cafe::7d) by CH5P222CA0011.outlook.office365.com
 (2603:10b6:610:1ee::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:21:59 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:21:59 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:21:59 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>
Subject: [PATCH 08/82] drm/amd/display: Test GPU memory allocation
Date: Tue, 18 Aug 2026 16:15:00 -0400
Message-ID: <20260818202139.4172592-9-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: 95e354d1-2ce2-4d1c-5c67-08defd665bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|56012099006|22082099003|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 7volXWIkG2DADhaAqqqK1NEXzNo4WP8zOz1wJWm1IbioxReKrKz1sDbTw2qukF6D5AjyanbZ2zRU9JDd03AEFTPOa1Q7EOZl1MiDxJicLihMmkIJsBq8IrGS09OXWSx33FzVz11tc7ASknTDQxyfS+QATGfwjLiv/qcIC2F3Wt/MBCHT59imx47QfTxeDSF5MALxEbelW3n3x7HhWOJ90l18YZEnO9vrZb3azQUMUkj4ht2VslZ3pl1B5FMsJ5nW3bhWwMC920sGOILZmXr0PPVLj7Wmo7AitaxOB/jR2k6QqyqNB8rqteoEyXFzsGceWc4h+k+w3+XBI4AXskIYCi3tZzzk1K1TGeGhOsCvMNAXET6Cqc4xDx0NLaf3hR3MidH65qF/iDcyF5LwWUqh0DrauSpBNZJq3gVLZO4TLJ6710hM+5S+I6CZsRWrIHAkRsAzGn9KC2+xXP5Vpfe1CmBxzFRM5ezliFBczgAmOsdBOKflx6SvSZm/0AJqVkRx6gM1z+0sdRk5eVk7GP3hy7V+I8gRdvtWtMz3UWApJPKTvzFUAUcUwcjuAK6XvlMyQJ2u1vUQAwywpmG+FSFjIH34veLrVIh4IkWRLvDOUwLTnWdvKKkSdSSDUPvBnE1cEeKc0g4D0cfMOCaxxW0QdkvEhl4iIPrh/QjPVTdvoy3HYYBVNvzNdZr8lUg3+D0ZfXSxihJRFtxlZZ4f3pPfig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099006)(22082099003)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Khrt2M6gEaKdpjiO2Wycj6fDfG7hRZ0FGZYLmM7BwHDPtDEFmHFhMQp5ohZL2h5SosqQEgXFeO5gBDXR5bVGHboQXvGOH0RDuhDELh4fK65BvqcTbPypTEAl407H+jrPLJfjtC2FIKjUNA+pnhRGUNqozqhNs92i//4TGYWBSdgOUjUfZdkr7qm865PshjiEjncdKKwSZOPmVQ1Uk/QXdIHyi+iS3MuPcYbMPVom4MYjYawrkhEGmoLNvnXnFM5EpMLOHKbUZkqqzmxDqhD03qteEJxZ2NYGhSAtbLE2SUaSKAfTNWXD+zz0nvUNls7G1Kbeq3eh9T58fxxqXvcwM0Mv8dsf3+tYI/It3amMoLhVfzoTl5KhLAxCZxUT6i3Cx7An3Y/BS5bfxCtyslWfU1c2s1vX539avLxWrkTKOiBx90i7I+77J8Mgth3XLD9z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:21:59.9199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e354d1-2ce2-4d1c-5c67-08defd665bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335
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
Add KUnit tests covering GART and VRAM domain selection, size and
alignment forwarding, the buffer object creation failure path,
and the free path for a matching pointer, a non-matching pointer
and an empty allocation list.

[HOW]
Add struct amdgpu_dm_services_kunit_ops, a KUnit-only indirection table
for the buffer object calls that would otherwise need a live TTM
device. Tests install their own table to force an error return and to
count calls, which makes the failure and list handling paths reachable
in the UML test environment. The default table points at the existing
AMDGPU functions, so no test-only wrapper is introduced.

Route the affected calls through services_bo_* wrappers, so the KUnit
build dispatches through the table while non-KUnit builds call the same
functions directly.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  10 +
 .../display/amdgpu_dm/amdgpu_dm_services.c    |  35 ++-
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c | 228 +++++++++++++++++-
 3 files changed, 268 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3524931451c86..0217a26283a36 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1188,6 +1188,16 @@ bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
 				     struct drm_connector_state *old_conn_state,
 				     const struct drm_connector *connector,
 				     struct hdcp_workqueue *hdcp_w);
+
+struct amdgpu_dm_services_kunit_ops {
+	int (*bo_create_kernel)(struct amdgpu_device *adev, unsigned long size,
+				int align, u32 domain, struct amdgpu_bo **bo_ptr,
+				u64 *gpu_addr, void **cpu_addr);
+	void (*bo_free_kernel)(struct amdgpu_bo **bo, u64 *gpu_addr,
+			       void **cpu_addr);
+};
+
+void amdgpu_dm_services_kunit_set_ops(const struct amdgpu_dm_services_kunit_ops *ops);
 #endif
 
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
index 6dbc8d1b4ecd3..23f1db81a1544 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_services.c
@@ -38,6 +38,31 @@
 #include "amdgpu_dm_trace.h"
 #include "dm_helpers.h"
 
+#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+static const struct amdgpu_dm_services_kunit_ops amdgpu_dm_services_default_ops = {
+	.bo_create_kernel = amdgpu_bo_create_kernel,
+	.bo_free_kernel = amdgpu_bo_free_kernel,
+};
+
+static const struct amdgpu_dm_services_kunit_ops *amdgpu_dm_services_ops =
+	&amdgpu_dm_services_default_ops;
+
+void amdgpu_dm_services_kunit_set_ops(const struct amdgpu_dm_services_kunit_ops *ops)
+{
+	amdgpu_dm_services_ops = ops ? ops : &amdgpu_dm_services_default_ops;
+}
+EXPORT_IF_KUNIT(amdgpu_dm_services_kunit_set_ops);
+
+#define services_bo_create_kernel	amdgpu_dm_services_ops->bo_create_kernel
+#define services_bo_free_kernel		amdgpu_dm_services_ops->bo_free_kernel
+
+#else
+
+#define services_bo_create_kernel	amdgpu_bo_create_kernel
+#define services_bo_free_kernel		amdgpu_bo_free_kernel
+
+#endif
+
 	unsigned long long
 	dm_get_elapse_time_in_ns(struct dc_context *ctx,
 				 unsigned long long current_time_stamp,
@@ -113,9 +138,9 @@ dm_allocate_gpu_mem(
 	if (!da)
 		return NULL;
 
-	ret = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
-				      domain, &da->bo,
-				      &da->gpu_addr, &da->cpu_ptr);
+	ret = services_bo_create_kernel(adev, size, PAGE_SIZE,
+					domain, &da->bo,
+					&da->gpu_addr, &da->cpu_ptr);
 
 	*addr = da->gpu_addr;
 
@@ -129,6 +154,7 @@ dm_allocate_gpu_mem(
 
 	return da->cpu_ptr;
 }
+EXPORT_IF_KUNIT(dm_allocate_gpu_mem);
 
 void
 dm_free_gpu_mem(
@@ -141,7 +167,7 @@ dm_free_gpu_mem(
 	/* walk the da list in DM */
 	list_for_each_entry(da, &adev->dm.da_list, list) {
 		if (pvMem == da->cpu_ptr) {
-			amdgpu_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
+			services_bo_free_kernel(&da->bo, &da->gpu_addr, &da->cpu_ptr);
 			list_del(&da->list);
 			kfree(da);
 			break;
@@ -149,3 +175,4 @@ dm_free_gpu_mem(
 	}
 
 }
+EXPORT_IF_KUNIT(dm_free_gpu_mem);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
index e48bac7fb024c..4ff430e4b23b6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_services_test.c
@@ -277,6 +277,212 @@ static void dm_test_query_brightness_caps_non_lcd1_uses_second_slot(struct kunit
 	KUNIT_EXPECT_EQ(test, caps.data_points[0].signal_level, 0);
 }
 
+/* Tests for dm_allocate_gpu_mem() and dm_free_gpu_mem() */
+
+#define DM_TEST_FAKE_GPU_ADDR 0xF00DBEEFULL
+
+struct dm_test_bo_ops_ctx {
+	void *cpu_ptr;
+	u64 gpu_addr;
+	int create_ret;
+	unsigned long create_size;
+	int create_align;
+	u32 create_domain;
+	unsigned int create_calls;
+	unsigned int free_calls;
+};
+
+static struct dm_test_bo_ops_ctx dm_test_bo_ctx;
+
+static int dm_test_bo_create_kernel(struct amdgpu_device *adev, unsigned long size,
+				    int align, u32 domain, struct amdgpu_bo **bo_ptr,
+				    u64 *gpu_addr, void **cpu_addr)
+{
+	dm_test_bo_ctx.create_calls++;
+	dm_test_bo_ctx.create_size = size;
+	dm_test_bo_ctx.create_align = align;
+	dm_test_bo_ctx.create_domain = domain;
+
+	if (dm_test_bo_ctx.create_ret)
+		return dm_test_bo_ctx.create_ret;
+
+	*gpu_addr = dm_test_bo_ctx.gpu_addr;
+	*cpu_addr = dm_test_bo_ctx.cpu_ptr;
+
+	return 0;
+}
+
+static void dm_test_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr, void **cpu_addr)
+{
+	dm_test_bo_ctx.free_calls++;
+
+	*bo = NULL;
+	*gpu_addr = 0;
+	*cpu_addr = NULL;
+}
+
+static const struct amdgpu_dm_services_kunit_ops dm_test_bo_ops = {
+	.bo_create_kernel = dm_test_bo_create_kernel,
+	.bo_free_kernel = dm_test_bo_free_kernel,
+};
+
+/**
+ * dm_test_gpu_mem_init - Install the fake buffer object ops
+ * @test: The KUnit test context
+ *
+ * amdgpu_bo_create_kernel() and amdgpu_bo_free_kernel() need a live TTM
+ * device, so route them through a fake table for the duration of the test.
+ */
+static int dm_test_gpu_mem_init(struct kunit *test)
+{
+	void *cpu_ptr;
+
+	cpu_ptr = kunit_kzalloc(test, sizeof(*cpu_ptr), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cpu_ptr);
+
+	dm_test_bo_ctx = (struct dm_test_bo_ops_ctx) {
+		.cpu_ptr = cpu_ptr,
+		.gpu_addr = DM_TEST_FAKE_GPU_ADDR,
+	};
+
+	amdgpu_dm_services_kunit_set_ops(&dm_test_bo_ops);
+
+	return 0;
+}
+
+static void dm_test_gpu_mem_exit(struct kunit *test)
+{
+	amdgpu_dm_services_kunit_set_ops(NULL);
+}
+
+static struct amdgpu_device *dm_test_alloc_adev(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	INIT_LIST_HEAD(&adev->dm.da_list);
+
+	return adev;
+}
+
+/**
+ * dm_test_allocate_gpu_mem_gart - Test Allocate gpu mem gart
+ * @test: The KUnit test context
+ */
+static void dm_test_allocate_gpu_mem_gart(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev(test);
+	long long addr = 0;
+	void *mem;
+
+	mem = dm_allocate_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, 4096, &addr);
+
+	KUNIT_EXPECT_PTR_EQ(test, mem, dm_test_bo_ctx.cpu_ptr);
+	KUNIT_EXPECT_EQ(test, addr, (long long)DM_TEST_FAKE_GPU_ADDR);
+	KUNIT_EXPECT_EQ(test, dm_test_bo_ctx.create_calls, 1U);
+	KUNIT_EXPECT_EQ(test, dm_test_bo_ctx.create_size, 4096UL);
+	KUNIT_EXPECT_EQ(test, dm_test_bo_ctx.create_align, (int)PAGE_SIZE);
+	KUNIT_EXPECT_EQ(test, dm_test_bo_ctx.create_domain, (u32)AMDGPU_GEM_DOMAIN_GTT);
+	KUNIT_EXPECT_FALSE(test, list_empty(&adev->dm.da_list));
+
+	dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, mem);
+}
+
+/**
+ * dm_test_allocate_gpu_mem_frame_buffer - Test Allocate gpu mem frame buffer
+ * @test: The KUnit test context
+ *
+ * Any non-GART allocation type must land in the VRAM domain.
+ */
+static void dm_test_allocate_gpu_mem_frame_buffer(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev(test);
+	long long addr = 0;
+	void *mem;
+
+	mem = dm_allocate_gpu_mem(adev, DC_MEM_ALLOC_TYPE_FRAME_BUFFER, 8192, &addr);
+
+	KUNIT_EXPECT_PTR_EQ(test, mem, dm_test_bo_ctx.cpu_ptr);
+	KUNIT_EXPECT_EQ(test, dm_test_bo_ctx.create_domain, (u32)AMDGPU_GEM_DOMAIN_VRAM);
+	KUNIT_EXPECT_EQ(test, dm_test_bo_ctx.create_size, 8192UL);
+
+	dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_FRAME_BUFFER, mem);
+}
+
+/**
+ * dm_test_allocate_gpu_mem_create_fails - Test Allocate gpu mem create fails
+ * @test: The KUnit test context
+ */
+static void dm_test_allocate_gpu_mem_create_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev(test);
+	long long addr = 0;
+	void *mem;
+
+	dm_test_bo_ctx.create_ret = -ENOMEM;
+
+	mem = dm_allocate_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, 4096, &addr);
+
+	KUNIT_EXPECT_NULL(test, mem);
+	KUNIT_EXPECT_EQ(test, dm_test_bo_ctx.create_calls, 1U);
+	KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.da_list));
+}
+
+/**
+ * dm_test_free_gpu_mem_matching - Test Free gpu mem matching
+ * @test: The KUnit test context
+ */
+static void dm_test_free_gpu_mem_matching(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev(test);
+	long long addr = 0;
+	void *mem;
+
+	mem = dm_allocate_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, 4096, &addr);
+	KUNIT_ASSERT_NOT_NULL(test, mem);
+
+	dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, mem);
+
+	KUNIT_EXPECT_EQ(test, dm_test_bo_ctx.free_calls, 1U);
+	KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.da_list));
+}
+
+/**
+ * dm_test_free_gpu_mem_no_match - Test Free gpu mem no match
+ * @test: The KUnit test context
+ */
+static void dm_test_free_gpu_mem_no_match(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev(test);
+	long long addr = 0;
+	void *mem;
+
+	mem = dm_allocate_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, 4096, &addr);
+	KUNIT_ASSERT_NOT_NULL(test, mem);
+
+	dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, (char *)mem + 1);
+
+	KUNIT_EXPECT_EQ(test, dm_test_bo_ctx.free_calls, 0U);
+	KUNIT_EXPECT_FALSE(test, list_empty(&adev->dm.da_list));
+
+	dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, mem);
+}
+
+/**
+ * dm_test_free_gpu_mem_empty_list - Test Free gpu mem empty list
+ * @test: The KUnit test context
+ */
+static void dm_test_free_gpu_mem_empty_list(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev(test);
+
+	dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, dm_test_bo_ctx.cpu_ptr);
+
+	KUNIT_EXPECT_EQ(test, dm_test_bo_ctx.free_calls, 0U);
+	KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.da_list));
+}
+
 static struct kunit_case amdgpu_dm_services_test_cases[] = {
 	/* dm_get_elapse_time_in_ns */
 	KUNIT_CASE(dm_test_get_elapse_time_zero_delta),
@@ -307,7 +513,27 @@ static struct kunit_suite amdgpu_dm_services_test_suite = {
 	.test_cases = amdgpu_dm_services_test_cases,
 };
 
-kunit_test_suite(amdgpu_dm_services_test_suite);
+static struct kunit_case amdgpu_dm_services_gpu_mem_test_cases[] = {
+	/* dm_allocate_gpu_mem */
+	KUNIT_CASE(dm_test_allocate_gpu_mem_gart),
+	KUNIT_CASE(dm_test_allocate_gpu_mem_frame_buffer),
+	KUNIT_CASE(dm_test_allocate_gpu_mem_create_fails),
+	/* dm_free_gpu_mem */
+	KUNIT_CASE(dm_test_free_gpu_mem_matching),
+	KUNIT_CASE(dm_test_free_gpu_mem_no_match),
+	KUNIT_CASE(dm_test_free_gpu_mem_empty_list),
+	{}
+};
+
+static struct kunit_suite amdgpu_dm_services_gpu_mem_test_suite = {
+	.name = "amdgpu_dm_services_gpu_mem",
+	.init = dm_test_gpu_mem_init,
+	.exit = dm_test_gpu_mem_exit,
+	.test_cases = amdgpu_dm_services_gpu_mem_test_cases,
+};
+
+kunit_test_suites(&amdgpu_dm_services_test_suite,
+		  &amdgpu_dm_services_gpu_mem_test_suite);
 
 MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_services");
 MODULE_LICENSE("Dual MIT/GPL");
-- 
2.43.0

