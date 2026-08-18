Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A4DC5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D359510EC9B;
	Tue, 18 Aug 2026 20:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rId+Dg8p";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012051.outbound.protection.outlook.com
 [40.107.200.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8F310EC8D
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLHbNb3HW8SNXtiHRVeZBHABfCvoOoZPbiERSe7loU92CsCDKqGQyW4Wz+0EnyyZlv9aDfSg43jnKIliLjIpH7ZV9zUR3HUIL2rBqZH9vjIBnpW6BHohlt5JsHuC58m+LdFXCZuKXEEzpB9td0NVJbTFMv0iPGPpAmyjfHG5Uiy7QyvTWF0R3Gi5OiMckL8f977POfKDnu/1qJnA/6yMqrLKMO9GnOcSbIwz+13lSWeZTIqSeNWfmiYGSXcIXfV+INwrdPGT0hQAM7VMSc0i+77Z+XgeNUigN7yLotl0FY+DdALzQMueXNY/2f0vkOJZ4gz8bFztixNXWK6S+NcKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hW6V1V1BEmBj24zXR8Gr713CEze/a7H/qlYn9AoIfJY=;
 b=ushMylSFomjGva9bNVUsfqvEkCT3AJuhBBpE+TUryjPrrZpTEptCLfvXzQemddQp/PY8upb5Gf0AStAMRqMUKe0KRE+FnBBPvGzj6byMPAhcwa6iYgQhF3QCKbSQalU+/5OppHce+c/+bDa+d0vipvbGtVAU19Od1fvfpKiyAZogAeOPNs7H1KUcGz6u1w6iifSpPFjfLfFLOBtWF9qvIqYy0YBbndayKWwQu/yURROB4rc2OyKNVqK/fI/NgxjScnUwzrshfA5oKVii/sE0Eop7KiwhD8EDCzPwz3AEVUZ8Q8HjWZL9LI7s2bcrWuyQrgKewNAlg0704iYA1yOuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hW6V1V1BEmBj24zXR8Gr713CEze/a7H/qlYn9AoIfJY=;
 b=rId+Dg8pQsB34ztnU+Vfiyc7mKDa/gyEPauDIK3qyGl8dpcivr+EirfnNc9RG9VqmHI4qtvU5F0ShYBP9dSIIKzFH/tcYhFWR6Yo84xO7LhMs5OiMGuWK6h2HcZFoOWEkAaRBpWLcC5373+KoeSBBo6HB+Mhi8REXt2ZkRbj718=
Received: from BN9PR03CA0899.namprd03.prod.outlook.com (2603:10b6:408:13c::34)
 by IA4PR12MB9811.namprd12.prod.outlook.com (2603:10b6:208:54e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:21 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::31) by BN9PR03CA0899.outlook.office365.com
 (2603:10b6:408:13c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:21 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:08 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:08 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 21/82] drm/amd/display: Test GPU memory allocate and free
 helpers
Date: Tue, 18 Aug 2026 16:15:13 -0400
Message-ID: <20260818202139.4172592-22-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|IA4PR12MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: bda8b927-5712-4090-eb0c-08defd66689b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: sGCsS03Mv+lq1MIhQh3bQSA9UXUeTI2FzPrGsigLpGc7ikgikI0sPW+MxrnYRci4s9lhBEHz3GkbPon/WANKxmk8bUDsXX1Pmj9uS/YjSyq/aTKKmc5JW8k/YOA8qwBCMjdPgzWTQAGVv/qBCoOohzKcjF1l33n8Zuq5r9EktTwrJ3Tv2HyyrxIemwR5oMexU5RfyDuKmju01PJSjVZO+7o5bKpf4ognTqFkzQkT0EgOgLSYlh++1HiHOpaOHOB2zPXGt+vvhwNYSxEUle2HDpSjajdETxwuqoRcaXp+2zcrS39XMEm5etOuosG6bp72lxDfZ2yfOf606fbOvSCHp8nK2D16pIZ+dIZSyINOrGJcbnrs7ewlTzPPVEKRvsaFuHTyI3dX79aPbmP42l6t8WpRT3U2m5pgr7H/KMP53K5IIvYJoN6sbkOzjTnQOhMB2K8m9bdkJ6QuO+PVMupPlfaQmtmkheYtpeBT5bYxKqA2eEd+u80hSogLFcXXa681UzBVFYpTJAKa68jA9t4tnFl2FR/SQIx5TbX3xkjnrXj+mFIQbJVtA491BxDVSPNiIl2Zv1WsQ4I19sCIAqww45xkg4hMdQsjYUtrRYCKBWY7Enr4lMB6q9XMx7tkqXEX6FA1/MbzOg3Ayi7ZODIF4p23zPhyj4QgEvEicY1yNTUagsaQek3CmgNnbU5PYsNh8yWoxuO6KIu2RM236kbqtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7dnBfFsJ6Uz/94QyVDFxY0T02CHewxGW95BkivP7XHDPeg3YiNAKk889h8O1xN64+GbNtAPpzLvtyyPIJv8YE0jJJLp+MppzfHMJVDLAL3m/JNqlNX8A/eyUKWzLgsxr7qPlsZcDtHNu+3o/bZGYH44fQHZH/8lNP9xE16Cw8DzuP2eWFow67EAM/EGnclC5+UndXvANyvI/4/B0GUq4uYEOd4IMgepg3nPVTEdFtSt3C1o5LNOpRNsJ8INsLQKSSe+ywKv1CGKkYx1et6m+tmCE5OhrWQoOM80PuQJxrGnyvvErrprcjFfi+ApGLA7cg7DPDZdygg1vcEvxfPd0D310nynJKCCICpi212MfTsnUTbGyYrz4I4SNhazglr2eUR+vRBnRPAM/M9bzIbl4MpQniVDFfNHGCqcdunurWXK/O0RsRd4RzHB9CnNegJI/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:21.6300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bda8b927-5712-4090-eb0c-08defd66689b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9811
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
Add a KUnit test for dm_helpers_allocate_gpu_mem() and
dm_helpers_free_gpu_mem() that allocates a DMUB tracebuffer and frees it
again, checking the returned CPU pointer and GPU address.

[HOW]
amdgpu_bo_create_kernel() and amdgpu_bo_free_kernel() need a live TTM
device, so both are replaced by a fake through the existing
amdgpu_dm_services KUnit operations table.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  2 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  | 93 +++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 29f254cafae4e..0344ce5ce816b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -1442,6 +1442,7 @@ void *dm_helpers_allocate_gpu_mem(
 
 	return dm_allocate_gpu_mem(adev, type, size, addr);
 }
+EXPORT_IF_KUNIT(dm_helpers_allocate_gpu_mem);
 
 void dm_helpers_free_gpu_mem(
 		struct dc_context *ctx,
@@ -1452,6 +1453,7 @@ void dm_helpers_free_gpu_mem(
 
 	dm_free_gpu_mem(adev, type, pvMem);
 }
+EXPORT_IF_KUNIT(dm_helpers_free_gpu_mem);
 
 bool dm_helpers_dmub_outbox_interrupt_control(struct dc_context *ctx, bool enable)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
index 0314ebb5c8aea..11a5e8f307354 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_helpers_test.c
@@ -3906,6 +3906,97 @@ static void dm_test_submit_i2c_over_aux_unimplemented(struct kunit *test)
 								sizeof(buffer), true));
 }
 
+/* Tests for dm_helpers_allocate_gpu_mem() and dm_helpers_free_gpu_mem() */
+
+/*
+ * Fake buffer object allocator: amdgpu_bo_create_kernel() and
+ * amdgpu_bo_free_kernel() need a live TTM device, so dm_allocate_gpu_mem() is
+ * routed through this fake.
+ */
+
+#define DM_TEST_FAKE_GPU_ADDR	0x1234ABCD0000ULL
+
+struct dm_test_bo_ctx {
+	void *cpu_ptr;
+	unsigned int create_calls;
+	unsigned int free_calls;
+	unsigned long create_size;
+	u32 create_domain;
+};
+
+static struct dm_test_bo_ctx dm_test_bo;
+
+static int dm_test_bo_create_kernel(struct amdgpu_device *adev, unsigned long size,
+				    int align, u32 domain, struct amdgpu_bo **bo_ptr,
+				    u64 *gpu_addr, void **cpu_addr)
+{
+	dm_test_bo.create_calls++;
+	dm_test_bo.create_size = size;
+	dm_test_bo.create_domain = domain;
+
+	*gpu_addr = DM_TEST_FAKE_GPU_ADDR;
+	*cpu_addr = dm_test_bo.cpu_ptr;
+
+	return 0;
+}
+
+static void dm_test_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr, void **cpu_addr)
+{
+	dm_test_bo.free_calls++;
+
+	*bo = NULL;
+	*gpu_addr = 0;
+	*cpu_addr = NULL;
+}
+
+static const struct amdgpu_dm_services_kunit_ops dm_test_services_ops = {
+	.bo_create_kernel = dm_test_bo_create_kernel,
+	.bo_free_kernel = dm_test_bo_free_kernel,
+};
+
+/**
+ * dm_test_gpu_mem_alloc_and_free - Test the GPU memory helper wrappers
+ * @test: The KUnit test context
+ *
+ * Both helpers only unwrap the device from the DC context and forward to
+ * dm_allocate_gpu_mem()/dm_free_gpu_mem().
+ */
+static void dm_test_gpu_mem_alloc_and_free(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+	struct dc_context *ctx;
+	long long addr = 0;
+	void *cpu_ptr;
+	void *mem;
+
+	adev = dm_kunit_alloc_adev(test);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+	cpu_ptr = kunit_kzalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cpu_ptr);
+
+	ctx->driver_context = adev;
+	INIT_LIST_HEAD(&adev->dm.da_list);
+	dm_test_bo = (struct dm_test_bo_ctx) { .cpu_ptr = cpu_ptr };
+	amdgpu_dm_services_kunit_set_ops(&dm_test_services_ops);
+
+	mem = dm_helpers_allocate_gpu_mem(ctx, DC_MEM_ALLOC_TYPE_GART, 4096, &addr);
+
+	KUNIT_EXPECT_PTR_EQ(test, mem, cpu_ptr);
+	KUNIT_EXPECT_EQ(test, addr, (long long)DM_TEST_FAKE_GPU_ADDR);
+	KUNIT_EXPECT_EQ(test, dm_test_bo.create_calls, 1U);
+	KUNIT_EXPECT_EQ(test, dm_test_bo.create_size, 4096UL);
+	KUNIT_EXPECT_EQ(test, dm_test_bo.create_domain, (u32)AMDGPU_GEM_DOMAIN_GTT);
+
+	dm_helpers_free_gpu_mem(ctx, DC_MEM_ALLOC_TYPE_GART, mem);
+
+	KUNIT_EXPECT_EQ(test, dm_test_bo.free_calls, 1U);
+	KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.da_list));
+
+	amdgpu_dm_services_kunit_set_ops(NULL);
+}
+
 static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	/* edid_extract_panel_id */
 	KUNIT_CASE(dm_test_edid_extract_panel_id_basic),
@@ -4096,6 +4187,8 @@ static struct kunit_case amdgpu_dm_helpers_test_cases[] = {
 	KUNIT_CASE(dm_test_dp_handle_test_pattern_no_pipe),
 	/* dm_helpers_submit_i2c_over_aux */
 	KUNIT_CASE(dm_test_submit_i2c_over_aux_unimplemented),
+	/* dm_helpers_allocate_gpu_mem / dm_helpers_free_gpu_mem */
+	KUNIT_CASE(dm_test_gpu_mem_alloc_and_free),
 	{}
 };
 
-- 
2.43.0

