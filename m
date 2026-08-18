Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46764C5DF8B
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B56BE10ECAC;
	Tue, 18 Aug 2026 20:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H+m6DqDx";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A9710ECB0
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMIa1oRXII3n+0xxgzSZHRJpaaEdPAfSkz2lxSpatIE30C1TMpIVSjde5MhDl8h47tKUATbcd5+PqDkiS5kMkfvly/dyvdXCu1CsuSMU0MOmVY6ehoaH3UArDajTHAwj6/PX6wHMWUEnOPpY1tLMqsXsWptSobU8aEnuMmimt27rkNOubNLqvkn41ZzeaK2Lo5oRbPjgeqEOvH/lon0iheP+Wp3iUO5PqqZD23yGs4xR2fsFCB2GG1NGKAIIGusZqFeNH3L7bxsK2dAwwEHQVZpCc0+ifNAnuhZhJ72xEmA1QZz2Fut8rp0Bif6/W7TBUxwGd0LQw5LqSXC6i1u1cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o91KTAw6rnkCwwBWuaiB0VfYip+AXIIW8gPt+a6PydE=;
 b=syCg8ayjT7fG/zHygEOqFmgU5lKVmTa01aWXNXxzgwkCuZcrxlD7JNPKz4GmdWb8/11nJghzUQ6XXYFB/Dip7HmmGE3r7FHdqWLQohpD7INjk7iQ4UWVYVTHz+PwGxiLb+eg810gdyfDFZ0RES3qhiX/cAi+zidhi29QwzYpKxN7PJwbq8J9vZyDu1+IcEYiJi/Qm83oEv5ZPwlX7+Ss7jF/5oAXyivjGSOxPcXYh3y59Tln9qDn8HmvrRAQkKCOjto81KnNV0JWiczrOCGYhNa30po4jBsMIPoEGVln8eI09Njl293P8CCNBVCzIMRq+GjMDNyiEUS4FeG6eYinGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o91KTAw6rnkCwwBWuaiB0VfYip+AXIIW8gPt+a6PydE=;
 b=H+m6DqDxxrCzvyttwPaLLk6u27Fcw/Qvs4EYIcGH9wf80kaKnosskyF1mLUMlXRImu/4oEGyzakt5fDU+vunVQ2yfwW3aRMxc3qqPWaFq8rnMm5N3YALzy0IGRo60BPhgaG/qRNMfqxTxQpzpvTAkm+UF4MLlPBiYM12oDfzdoY=
Received: from BN9PR03CA0356.namprd03.prod.outlook.com (2603:10b6:408:f6::31)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 20:22:37 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::24) by BN9PR03CA0356.outlook.office365.com
 (2603:10b6:408:f6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.17 via Frontend Transport; Tue,
 18 Aug 2026 20:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Tue, 18 Aug 2026 20:22:36 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:13 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:13 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:12 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 27/82] drm/amd/display: Test VBIOS bounding box
Date: Tue, 18 Aug 2026 16:15:19 -0400
Message-ID: <20260818202139.4172592-28-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: ea72ef8f-2ed6-45ea-f1b7-08defd66715f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|18002099003|56012099006|22082099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: rBZX1GE1+yatoDYBeaWRCVKDxXrevH+jtFgcb32dRS5mvMxLpwBWyGn6t2MqBFDR4geL+bCDE/DhknzIkfcn7snFbdIdDJqGdPoHKRTEMSBEJaryZ1cYWWZWPrkGRcNTjHpgDTbr71Ae4drjO/3sBv2+vtgolSjAUg77+WAdrcgUkRftyGf3KNOfa1buPMlvoqZXBugVCQqU1Cd7MU1xrhjWW1PYd75z9aEfoM6sQaYr6lx7tkJv2aDD0vCFegS/FPN2NFWgTwZQ00jytJyHOvuT53oXfVhbkwPLTQiZZUnjbB1T3N46TmNNjaYQcpxgTWrgW8N450jGYEM2LzF62G2ZAL/gZsY6lHmg5uB5YPS8nu+Op1NCMNnMsXgot8HzZFgB6snhsGZRhuIB4TPByptrCwxqI9ay0n7L86d37gaHHXk1jLMUfZh0PsTjaiFESAYgCKrcyWz1uH3udu0fNWGq8u3TJAW00h5WIKf8oAx40roCP/X3UBGj8OaRV6X5m3Tbk5J3O57sByWPz1wnu5/OGHS86vLtwiEqN/A+ecyUUdUoAzXHDxLtWpc1/UV+QksilWsWDhaoEddKayljLGbdALyu3DdAGMtOfEcgcNzcAmrnHRw++NCu1xbPuPDnsQFL2a7WHJ1iPQo49bwuOEZyR4n0wx/i6ekTngJmMy2+PCRkR9AK7M0KUbYClsG82YEbiBnFnjASwCQVYtF/zg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(56012099006)(22082099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0kAARELT1W3+f00DWHaOFCZcA3X+zT7LXLDP9MgQ14uRQKx7svX0CiM3T3sXbB9Y4fGJxtvb03AhSHSMzi+RqhsNEd1IBk7UZchPOnR74pRMDhagfD6P3UL6aXLeZj14TtS4usfExxHC5l2i3bo7EQyMwvQd5TakYUlGVOxWHNmMNafwDIf+Z0zVP8Z5piSwSHVbfJM+07zMiubnflu+OUEEQU2IeyyIjR2lai2y5b21MeZ3KXlljABs6iRXMaOZAaZ3if7ccTWghTYqo0gE0jmU1Zk98ABRBkHiOe3h+zzj0PldJiM6IkZ17q1oqI20CAy2tkCXkQT4RdXToJH6kujOJuSUyJW8zbSWpngEVTK7GwJjycQfYoHy38s2b44Wua6qxizz0WTkxaI4NCtrdCS2/AztFb4hjYQCUy//u7N35RPlUOIfIQlEhIDmSHLn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:36.3368 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea72ef8f-2ed6-45ea-f1b7-08defd66715f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410
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
Add KUnit tests for dm_dmub_get_vbios_bounding_box(), covering the
successful handshake on every ASIC that has a bounding box, the GPU
memory allocation failure path, and both GPINT timeout paths. This also
covers dm_dmub_send_vbios_gpint_command().

[HOW]
Extend the fake CGS device with a fail_on_write hook so a chosen GPINT
write is never acked, which drives the timeout paths without waiting on
real firmware. Reuse the buffer object indirection added for
dm_allocate_gpu_mem() with a fake allocator, since the real path needs a
live TTM device.

The success test walks every ASIC with a bounding box and confirms a
non-zero GART buffer is allocated and that all four address words plus
the copy request are sent. The timeout tests confirm the buffer is
released and the allocation list left empty.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 187 ++++++++++++++++++
 1 file changed, 187 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index 4bba282abd69d..cda048e8297a0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -1353,6 +1353,7 @@ static void dm_test_abort_fused_io_no_dmub_srv(struct kunit *test)
  * at the start of struct cgs_device.
  */
 
+#define DM_TEST_GPINT_REG		(0x34c0 + 0x01f8)
 #define DM_TEST_GPINT_STATUS_MASK	0xF0000000U
 
 struct dm_test_cgs_ctx {
@@ -1362,6 +1363,8 @@ struct dm_test_cgs_ctx {
 	unsigned int read_calls;
 	unsigned int last_write_offset;
 	unsigned int last_read_offset;
+	/* 1-based index of the write that must never be acked; 0 acks all */
+	unsigned int fail_on_write;
 };
 
 static struct dm_test_cgs_ctx dm_test_cgs;
@@ -1372,6 +1375,9 @@ static uint32_t dm_test_cgs_read_register(struct cgs_device *cgs_device,
 	dm_test_cgs.read_calls++;
 	dm_test_cgs.last_read_offset = offset;
 
+	if (dm_test_cgs.fail_on_write == dm_test_cgs.write_calls)
+		return ~dm_test_cgs.last_write;
+
 	/* The firmware acks a GPINT by clearing the status nibble. */
 	return dm_test_cgs.last_write & ~DM_TEST_GPINT_STATUS_MASK;
 }
@@ -1389,13 +1395,89 @@ static const struct cgs_ops dm_test_cgs_ops = {
 	.write_register = dm_test_cgs_write_register,
 };
 
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
+	int create_ret;
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
+	if (dm_test_bo.create_ret)
+		return dm_test_bo.create_ret;
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
 static int dm_test_dmub_hw_access_init(struct kunit *test)
 {
+	void *cpu_ptr;
+
+	cpu_ptr = kunit_kzalloc(test, PAGE_SIZE, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cpu_ptr);
+
+	dm_test_bo = (struct dm_test_bo_ctx) { .cpu_ptr = cpu_ptr };
 	dm_test_cgs = (struct dm_test_cgs_ctx) { .dev.ops = &dm_test_cgs_ops };
 
+	amdgpu_dm_services_kunit_set_ops(&dm_test_services_ops);
+
 	return 0;
 }
 
+static void dm_test_dmub_hw_access_exit(struct kunit *test)
+{
+	amdgpu_dm_services_kunit_set_ops(NULL);
+}
+
+static struct amdgpu_device *dm_test_alloc_adev_with_cgs(struct kunit *test)
+{
+	struct amdgpu_device *adev;
+
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev);
+
+	adev->dm.cgs_device = &dm_test_cgs.dev;
+	INIT_LIST_HEAD(&adev->dm.da_list);
+
+	return adev;
+}
+
 /* Tests for amdgpu_dm_dmub_reg_read() and amdgpu_dm_dmub_reg_write() */
 
 /**
@@ -1427,6 +1509,105 @@ static void dm_test_dmub_reg_write_then_read(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_test_cgs.last_read_offset, 0x1234U);
 }
 
+/* Tests for dm_dmub_get_vbios_bounding_box() */
+
+/**
+ * dm_test_dmub_get_vbios_bounding_box_success - Test the full bounding box handshake
+ * @test: The KUnit test context
+ *
+ * Every ASIC with a bounding box allocates a non-zero GART buffer, then sends
+ * and gets an ack for the four address words and the copy request.
+ */
+static void dm_test_dmub_get_vbios_bounding_box_success(struct kunit *test)
+{
+	static const u32 ip_versions[] = {
+		IP_VERSION(4, 0, 1),
+		IP_VERSION(4, 2, 0),
+		IP_VERSION(4, 2, 1),
+		IP_VERSION(6, 0, 0),
+	};
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_cgs(test);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(ip_versions); i++) {
+		void *bb;
+
+		adev->ip_versions[DCE_HWIP][0] = ip_versions[i];
+
+		bb = dm_dmub_get_vbios_bounding_box(adev);
+
+		KUNIT_EXPECT_PTR_EQ_MSG(test, bb, dm_test_bo.cpu_ptr,
+					"IP version 0x%08x", ip_versions[i]);
+		KUNIT_EXPECT_GT_MSG(test, dm_test_bo.create_size, 0UL,
+				    "IP version 0x%08x", ip_versions[i]);
+		KUNIT_EXPECT_EQ(test, dm_test_bo.create_domain,
+				(u32)AMDGPU_GEM_DOMAIN_GTT);
+		KUNIT_EXPECT_EQ(test, dm_test_cgs.last_write_offset,
+				(unsigned int)DM_TEST_GPINT_REG);
+		/* Four address words plus the copy request per ASIC. */
+		KUNIT_EXPECT_EQ(test, dm_test_cgs.write_calls, 5 * (i + 1));
+
+		dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, bb);
+	}
+}
+
+/**
+ * dm_test_dmub_get_vbios_bounding_box_alloc_fails - Test the allocation failure path
+ * @test: The KUnit test context
+ *
+ * When the GPU memory allocation fails, no GPINT command is sent.
+ */
+static void dm_test_dmub_get_vbios_bounding_box_alloc_fails(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_cgs(test);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(6, 0, 0);
+	dm_test_bo.create_ret = -ENOMEM;
+
+	KUNIT_EXPECT_NULL(test, dm_dmub_get_vbios_bounding_box(adev));
+	KUNIT_EXPECT_EQ(test, dm_test_cgs.write_calls, 0U);
+}
+
+/**
+ * dm_test_dmub_get_vbios_bounding_box_addr_timeout - Test an unacked address word
+ * @test: The KUnit test context
+ *
+ * When the firmware never acks the first address word, the handshake stops
+ * there and the buffer is released.
+ */
+static void dm_test_dmub_get_vbios_bounding_box_addr_timeout(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_cgs(test);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(6, 0, 0);
+	dm_test_cgs.fail_on_write = 1;
+
+	KUNIT_EXPECT_NULL(test, dm_dmub_get_vbios_bounding_box(adev));
+	KUNIT_EXPECT_EQ(test, dm_test_cgs.write_calls, 1U);
+	KUNIT_EXPECT_EQ(test, dm_test_bo.free_calls, 1U);
+	KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.da_list));
+}
+
+/**
+ * dm_test_dmub_get_vbios_bounding_box_copy_timeout - Test an unacked copy request
+ * @test: The KUnit test context
+ *
+ * When all four address words are acked but the copy request is not, the
+ * buffer is released and no bounding box is returned.
+ */
+static void dm_test_dmub_get_vbios_bounding_box_copy_timeout(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_cgs(test);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(6, 0, 0);
+	dm_test_cgs.fail_on_write = 5;
+
+	KUNIT_EXPECT_NULL(test, dm_dmub_get_vbios_bounding_box(adev));
+	KUNIT_EXPECT_EQ(test, dm_test_cgs.write_calls, 5U);
+	KUNIT_EXPECT_EQ(test, dm_test_bo.free_calls, 1U);
+	KUNIT_EXPECT_TRUE(test, list_empty(&adev->dm.da_list));
+}
+
 static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	/* dm_register_dmub_notify_callback() */
 	KUNIT_CASE(dm_test_register_dmub_notify_callback_null_callback),
@@ -1495,12 +1676,18 @@ static struct kunit_suite amdgpu_dm_dmub_test_suite = {
 static struct kunit_case amdgpu_dm_dmub_hw_access_tests[] = {
 	/* amdgpu_dm_dmub_reg_read() and amdgpu_dm_dmub_reg_write() */
 	KUNIT_CASE(dm_test_dmub_reg_write_then_read),
+	/* dm_dmub_get_vbios_bounding_box() */
+	KUNIT_CASE(dm_test_dmub_get_vbios_bounding_box_success),
+	KUNIT_CASE(dm_test_dmub_get_vbios_bounding_box_alloc_fails),
+	KUNIT_CASE(dm_test_dmub_get_vbios_bounding_box_addr_timeout),
+	KUNIT_CASE(dm_test_dmub_get_vbios_bounding_box_copy_timeout),
 	{}
 };
 
 static struct kunit_suite amdgpu_dm_dmub_hw_access_test_suite = {
 	.name = "amdgpu_dm_dmub_hw_access",
 	.init = dm_test_dmub_hw_access_init,
+	.exit = dm_test_dmub_hw_access_exit,
 	.test_cases = amdgpu_dm_dmub_hw_access_tests,
 };
 
-- 
2.43.0

