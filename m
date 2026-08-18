Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625C7C5DF7D
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E685110ECA3;
	Tue, 18 Aug 2026 20:22:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C3GzKHnl";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 637C710EC9C
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nk9hNb4Mu7BJ4SfatRUIIB+BZT50erdh1L78Yz0kAQBieQxvra4s1WcbgrtWD875cILx881BfQ0Jjp6+TprtU2NqxvUR1oU09xD7IHB0rPY5mpq1+ns7r+2+4g3IjIBNQXS6cNJV5O5nrpHN95FeuOujWiL4L/LHJVs3u0WF6zAHxHf/P3WAV+7GRAKuh7pf0Qzo6z9T7l8aHvUKssLk8COFJ2pJQD3WzlKCfNEh7zFwYuVwfki07YlvvJ/FekjjSSVJhbz985SSmeUxvWdw8jlBwuklKD7W6QILtPbaJcPdKLS7AlBFKVm/YOPJkitK4nMPK7PSuT5L0QmcHxdlzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQpwFEQfaOycPDWSfBRn9x+Lg0vgstX3RnNjeue/MNw=;
 b=bVkpEQPiS6MHD95CdQrmMje0seA6VxLcZp47upovpjk/03PitncPUM7w7abeJGsL5W9+JNTlIa8vGHw2sj5yqLtvSLfKZiB6XsGcBo0SGLN5ZFHhqcxWlVwZjc2sBV3NpVVgO+HN2zPdU2w8Zz04wrQz+NLISy62GGP26W8c8gWddfj1gDptgKzaX28ICOhO7+fXsqBeNPyaoSHB2lm8nxfhapv2FvE9bS6zzCTeKQxtXWh6gjghrMxdYuiuZZA4ioBpErU2qKFy7lEEvW5H52j3k8Surc1TLzouvVQX4sQOCO8xfREBCUTf8atxzuPUg4qjwdPnPUaZuoHJKjCYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQpwFEQfaOycPDWSfBRn9x+Lg0vgstX3RnNjeue/MNw=;
 b=C3GzKHnlyw/wGP8IEHG27N+YbxvcKwunDcUTbU8kQCoZ1qvadQ4VJHCsXxrQJpRfPeaHOni67b7K5cFl9vrMAmCT9GTubCXuio0i7ITZvtcCVKPWp9sltBv94PdAde6wW73xEzTDnkwQUDyLWivcNWQsWaVOzDvB3uMOEviFLnY=
Received: from BN9PR03CA0893.namprd03.prod.outlook.com (2603:10b6:408:13c::28)
 by LV3PR12MB9236.namprd12.prod.outlook.com (2603:10b6:408:1a5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:24 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::9d) by BN9PR03CA0893.outlook.office365.com
 (2603:10b6:408:13c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:24 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:14 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:13 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 29/82] drm/amd/display: Test dm_dmub_sw_init
Date: Tue, 18 Aug 2026 16:15:21 -0400
Message-ID: <20260818202139.4172592-30-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|LV3PR12MB9236:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9652b6-95b2-4da1-7563-08defd666a69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|3023799007|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Kzi5M1UhvzEBRrZFuGUnLkM41TA8OjCqjWWGWaNgOz3QPPojmaQGg9Z76YTS/L7OK14dAtxv0LuO3w2tDOwg/YeFTkZRh0oDxShQvM1oXtjTRV+8EE1gCU9goyAC9XyfeSYy5W9To0x+wBJgSyHHZiDjdsJli8GG1L4Xu5MHxQmR4BG2DcZTSCQaGo6uIFW3DxHj7I59wD5z3WraVSn1cr2kOfSphf72ree3tGdYxysSlaQk5wOxgXKb+CTodju3Pg0i6VS0EOVZ8I/b6uhn82W39mm5xXezE4bbLVSQHI6up0QRUxu1IiR66PM8QHI2IUbP5LHcVPKvZxye4X5A2iOnG/x0lz/7hm3iw60cY9eyxOHAEqDhzi2Dt33GZg2ro+uStNwucjLWw0jbzj0yjbU4Rq+VVp1H+0JXrCbp+LYhE7VSE01nmjXdu5rFrm/L5e1+HzfrYkQaSSAliKB+0x25JF0GqLJTyxuUbHtV0J5lzAjQGLBvpLdnO3EUHn+6P2xqtTmsx5ST9B4f3p3jOrrx0jeH0QcKOJEXR2/8kgWT4ZS4yN+EgIRt02UKMPujsxwgm8L3MY2OowcNAmT/kxbCZP+gmhOanpcX9d8HcA/EUiq4vWE6HVmS4q+0Ae65gmkLtTYI0HgYPNfyUa5QARoW2V4tFXXAUyualF9Pk45MJyRS0kk40P8ZYyRFjyepQVPvQz1sac1uSV4d3JQDtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(3023799007)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HzWV+pEJo6j8dQp04NRySyuRVb7fY+ijt+0a73VTUWeNBmgywqZQvyYuYhJJlMkQeMgED84yyYEMcBxRX9UH4KW3qmyCNieYtIvXS6Gnz+e+h2u/UhVeuxOcnQ9Zs0UFATj47soKPPN7ccUk3LKSueOWzOstvazU0hkGhRxc5f1Q2W3lfWzq1vQE5PPV0H9Ss56BdCqKXX8ccTl/jCdVqtpWBnEw+nzNRSipJOGmkwBRizccvEjYxGDdmN63pyyJuuaSjDhQKSlgCB3pf1N2bvFw336kBSAVfYK/5LMvfx6lKDZnFR25MAIMeYMXsJtB88aYJCo6BWX5DL7QtTtUskT2jCIXeZb15W+W3XjXJin1FdX7LLLRDJ53K6yqeXW4HyDophQRYgh/B/aAXoIDKiHX+Z9rmeDGwPPbYYQm9qyq8A3TsK276KaBYeCDEGCw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:24.6511 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9652b6-95b2-4da1-7563-08defd666a69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9236
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
Add KUnit tests for dm_dmub_sw_init(), covering the ASIC to DMUB service
mapping for all 19 supported IP versions, the memory domain choice, a
complete successful init, the BSS data region variant and the PSP
firmware load registration.

[HOW]
The framebuffer allocation needs a live TTM device, so add
amdgpu_bo_create_kernel() to the indirection table introduced for the
firmware request. The ASIC mapping and memory domain tests force that
allocation to fail, which walks every ASIC through DMUB service creation
and region calculation without a fake framebuffer.

Grow the fake firmware so its instruction constant region is larger than
two PSP footers. The footer probing in
dmub_srv_get_fw_meta_info_from_raw_fw() walks back from the end of that
region twice, so a region smaller than the footers underflows the size
and reads out of bounds.

Assisted-by: Copilot:Claude-Opus-5
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |  13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |   4 +
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     | 185 +++++++++++++++++-
 3 files changed, 193 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 2b34d5c36b48d..f4b0ced7d391c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -67,6 +67,7 @@ MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 static const struct amdgpu_dm_dmub_kunit_ops amdgpu_dm_dmub_default_ops = {
+	.bo_create_kernel = amdgpu_bo_create_kernel,
 	.ucode_request = amdgpu_ucode_request,
 };
 
@@ -79,10 +80,12 @@ void amdgpu_dm_dmub_kunit_set_ops(const struct amdgpu_dm_dmub_kunit_ops *ops)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_dmub_kunit_set_ops);
 
+#define dmub_bo_create_kernel	amdgpu_dm_dmub_ops->bo_create_kernel
 #define dmub_ucode_request	amdgpu_dm_dmub_ops->ucode_request
 
 #else
 
+#define dmub_bo_create_kernel	amdgpu_bo_create_kernel
 #define dmub_ucode_request	amdgpu_ucode_request
 
 #endif
@@ -683,11 +686,11 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 	 * Allocate a framebuffer based on the total size of all the regions.
 	 * TODO: Move this into GART.
 	 */
-	r = amdgpu_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
-				    mem_domain,
-				    &adev->dm.dmub_bo,
-				    &adev->dm.dmub_bo_gpu_addr,
-				    &adev->dm.dmub_bo_cpu_addr);
+	r = dmub_bo_create_kernel(adev, region_info.fb_size, PAGE_SIZE,
+				  mem_domain,
+				  &adev->dm.dmub_bo,
+				  &adev->dm.dmub_bo_gpu_addr,
+				  &adev->dm.dmub_bo_cpu_addr);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
index d178e1bf4dd6b..df3e776c1ad14 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
@@ -78,6 +78,10 @@ void amdgpu_dm_dmub_reg_write(void *ctx, uint32_t address, uint32_t value);
 
 /* Signatures are verbatim copies so an upstream change breaks the default ops. */
 struct amdgpu_dm_dmub_kunit_ops {
+	int (*bo_create_kernel)(struct amdgpu_device *adev,
+				unsigned long size, int align,
+				u32 domain, struct amdgpu_bo **bo_ptr,
+				u64 *gpu_addr, void **cpu_addr);
 	__printf(4, 5)
 	int (*ucode_request)(struct amdgpu_device *adev, const struct firmware **fw,
 			     enum amdgpu_ucode_required required, const char *fmt, ...);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
index fa81413be05f5..1e499acbcb908 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_dmub_test.c
@@ -19,7 +19,13 @@
 #include "dmub/dmub_srv.h"
 #include "amdgpu_dm_dmub.h"
 
-#define DM_TEST_FW_SIZE	512
+/*
+ * The PSP footer probing in dmub_srv_get_fw_meta_info_from_raw_fw() walks back
+ * from the end of the instruction constant region twice, so the fake firmware
+ * needs an instruction constant region larger than two footers.
+ */
+#define DM_TEST_FW_INST_CONST_BYTES	(PSP_HEADER_BYTES_256 + 1024)
+#define DM_TEST_FW_SIZE			(DM_TEST_FW_INST_CONST_BYTES + 1024)
 
 /* Tests for dm_register_dmub_notify_callback() */
 
@@ -112,7 +118,7 @@ static const struct firmware *dm_test_alloc_dmub_fw(struct kunit *test)
 	hdr = (struct dmcub_firmware_header_v1_0 *)data;
 	hdr->header.ucode_array_offset_bytes = cpu_to_le32(0);
 	hdr->header.ucode_version = cpu_to_le32(DMUB_FW_VERSION(9, 9, 9));
-	hdr->inst_const_bytes = cpu_to_le32(PSP_HEADER_BYTES_256);
+	hdr->inst_const_bytes = cpu_to_le32(DM_TEST_FW_INST_CONST_BYTES);
 	hdr->bss_data_bytes = cpu_to_le32(0);
 
 	fw->size = DM_TEST_FW_SIZE;
@@ -1398,8 +1404,8 @@ static const struct cgs_ops dm_test_cgs_ops = {
 
 /*
  * Fake buffer object allocator: amdgpu_bo_create_kernel() and
- * amdgpu_bo_free_kernel() need a live TTM device, so dm_allocate_gpu_mem() is
- * routed through this fake.
+ * amdgpu_bo_free_kernel() need a live TTM device, so both the DMUB framebuffer
+ * allocation and dm_allocate_gpu_mem() are routed through this fake.
  */
 
 #define DM_TEST_FAKE_GPU_ADDR	0x1234ABCD0000ULL
@@ -1469,6 +1475,7 @@ static __printf(4, 5) int dm_test_ucode_request(struct amdgpu_device *adev,
 }
 
 static const struct amdgpu_dm_dmub_kunit_ops dm_test_dmub_ops = {
+	.bo_create_kernel = dm_test_bo_create_kernel,
 	.ucode_request = dm_test_ucode_request,
 };
 
@@ -1720,6 +1727,170 @@ static void dm_test_init_microcode_request_fails(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_init_microcode(adev), -ENOENT);
 }
 
+/* Tests for dm_dmub_sw_init() */
+
+static struct amdgpu_device *dm_test_alloc_adev_for_sw_init(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_with_cgs(test);
+
+	adev->dm.dmub_fw = dm_test_alloc_dmub_fw(test);
+	adev->bios = kunit_kzalloc(test, 4, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, adev->bios);
+	adev->bios_size = 4;
+
+	return adev;
+}
+
+static void dm_test_free_sw_init(struct amdgpu_device *adev)
+{
+	kfree(adev->dm.dmub_srv);
+	kfree(adev->dm.dmub_fb_info);
+	adev->dm.dmub_srv = NULL;
+	adev->dm.dmub_fb_info = NULL;
+}
+
+/**
+ * dm_test_dmub_sw_init_asic_mapping - Test the ASIC to DMUB service mapping
+ * @test: The KUnit test context
+ *
+ * Every supported ASIC must get past DMUB service creation and region
+ * calculation. The framebuffer allocation is forced to fail so the tests stop
+ * before the memory layout is rebased onto a fake buffer.
+ */
+static void dm_test_dmub_sw_init_asic_mapping(struct kunit *test)
+{
+	static const u32 ip_versions[] = {
+		IP_VERSION(2, 1, 0), IP_VERSION(3, 0, 0), IP_VERSION(3, 0, 1),
+		IP_VERSION(3, 0, 2), IP_VERSION(3, 0, 3), IP_VERSION(3, 1, 2),
+		IP_VERSION(3, 1, 3), IP_VERSION(3, 1, 4), IP_VERSION(3, 1, 5),
+		IP_VERSION(3, 1, 6), IP_VERSION(3, 2, 0), IP_VERSION(3, 2, 1),
+		IP_VERSION(3, 5, 0), IP_VERSION(3, 5, 1), IP_VERSION(3, 6, 0),
+		IP_VERSION(4, 0, 1), IP_VERSION(4, 2, 0), IP_VERSION(4, 2, 1),
+		IP_VERSION(6, 0, 0),
+	};
+	struct amdgpu_device *adev = dm_test_alloc_adev_for_sw_init(test);
+	unsigned int i;
+
+	dm_test_bo.create_ret = -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(ip_versions); i++) {
+		adev->ip_versions[DCE_HWIP][0] = ip_versions[i];
+
+		KUNIT_EXPECT_EQ_MSG(test, dm_dmub_sw_init(adev), -ENOMEM,
+				    "IP version 0x%08x", ip_versions[i]);
+
+		dm_test_free_sw_init(adev);
+	}
+
+	KUNIT_EXPECT_EQ(test, dm_test_bo.create_calls, (unsigned int)ARRAY_SIZE(ip_versions));
+}
+
+/**
+ * dm_test_dmub_sw_init_gtt_only_asic - Test the GTT-only memory domain
+ * @test: The KUnit test context
+ *
+ * DCN32 and DCN321 keep the DMUB framebuffer in GTT; every other ASIC also
+ * allows VRAM.
+ */
+static void dm_test_dmub_sw_init_gtt_only_asic(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_for_sw_init(test);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 2, 0);
+	dm_test_bo.create_ret = -ENOMEM;
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_sw_init(adev), -ENOMEM);
+	KUNIT_EXPECT_EQ(test, dm_test_bo.create_domain, (u32)AMDGPU_GEM_DOMAIN_GTT);
+
+	dm_test_free_sw_init(adev);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(3, 5, 0);
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_sw_init(adev), -ENOMEM);
+	KUNIT_EXPECT_EQ(test, dm_test_bo.create_domain,
+			(u32)(AMDGPU_GEM_DOMAIN_GTT | AMDGPU_GEM_DOMAIN_VRAM));
+
+	dm_test_free_sw_init(adev);
+}
+
+/**
+ * dm_test_dmub_sw_init_success - Test a complete software init
+ * @test: The KUnit test context
+ *
+ * With a fake framebuffer allocator and a fake CGS device, software init
+ * should publish the framebuffer info, the bounding box and the instruction
+ * constant size.
+ */
+static void dm_test_dmub_sw_init_success(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_for_sw_init(test);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(6, 0, 0);
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_sw_init(adev), 0);
+	KUNIT_EXPECT_NOT_NULL(test, adev->dm.dmub_srv);
+	KUNIT_EXPECT_NOT_NULL(test, adev->dm.dmub_fb_info);
+	KUNIT_EXPECT_NOT_NULL(test, adev->dm.bb_from_dmub);
+	KUNIT_EXPECT_EQ(test, adev->dm.dmcub_fw_version, DMUB_FW_VERSION(9, 9, 9));
+	/* Meta info lookup fails on the fake firmware and trims a PSP footer. */
+	KUNIT_EXPECT_EQ(test, adev->dm.fw_inst_size,
+			(u32)(DM_TEST_FW_INST_CONST_BYTES - PSP_HEADER_BYTES_256 -
+			      PSP_FOOTER_BYTES_256));
+
+	dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, adev->dm.bb_from_dmub);
+	dm_test_free_sw_init(adev);
+}
+
+/**
+ * dm_test_dmub_sw_init_bss_data - Test software init with a BSS data region
+ * @test: The KUnit test context
+ *
+ * A non-zero BSS data size makes software init point the firmware meta info
+ * lookup at the legacy metadata region instead of the instruction constants.
+ */
+static void dm_test_dmub_sw_init_bss_data(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_for_sw_init(test);
+	struct dmcub_firmware_header_v1_0 *hdr;
+
+	hdr = (struct dmcub_firmware_header_v1_0 *)adev->dm.dmub_fw->data;
+	hdr->bss_data_bytes = cpu_to_le32(512);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(6, 0, 0);
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_sw_init(adev), 0);
+	KUNIT_EXPECT_NOT_NULL(test, adev->dm.dmub_fb_info);
+
+	dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, adev->dm.bb_from_dmub);
+	dm_test_free_sw_init(adev);
+}
+
+/**
+ * dm_test_dmub_sw_init_psp_load - Test the PSP firmware load registration
+ * @test: The KUnit test context
+ *
+ * When the firmware is loaded by the PSP, software init must register the
+ * DMCUB microcode with the AMDGPU firmware loader.
+ */
+static void dm_test_dmub_sw_init_psp_load(struct kunit *test)
+{
+	struct amdgpu_device *adev = dm_test_alloc_adev_for_sw_init(test);
+
+	adev->ip_versions[DCE_HWIP][0] = IP_VERSION(6, 0, 0);
+	adev->firmware.load_type = AMDGPU_FW_LOAD_PSP;
+
+	KUNIT_EXPECT_EQ(test, dm_dmub_sw_init(adev), 0);
+	KUNIT_EXPECT_EQ(test, adev->firmware.ucode[AMDGPU_UCODE_ID_DMCUB].ucode_id,
+			AMDGPU_UCODE_ID_DMCUB);
+	KUNIT_EXPECT_PTR_EQ(test, adev->firmware.ucode[AMDGPU_UCODE_ID_DMCUB].fw,
+			    adev->dm.dmub_fw);
+	KUNIT_EXPECT_EQ(test, adev->firmware.fw_size,
+			(u32)ALIGN(DM_TEST_FW_INST_CONST_BYTES, PAGE_SIZE));
+
+	dm_free_gpu_mem(adev, DC_MEM_ALLOC_TYPE_GART, adev->dm.bb_from_dmub);
+	dm_test_free_sw_init(adev);
+}
+
 static struct kunit_case amdgpu_dm_dmub_tests[] = {
 	/* dm_register_dmub_notify_callback() */
 	KUNIT_CASE(dm_test_register_dmub_notify_callback_null_callback),
@@ -1796,6 +1967,12 @@ static struct kunit_case amdgpu_dm_dmub_hw_access_tests[] = {
 	/* dm_init_microcode() */
 	KUNIT_CASE(dm_test_init_microcode_fw_names),
 	KUNIT_CASE(dm_test_init_microcode_request_fails),
+	/* dm_dmub_sw_init() */
+	KUNIT_CASE(dm_test_dmub_sw_init_asic_mapping),
+	KUNIT_CASE(dm_test_dmub_sw_init_gtt_only_asic),
+	KUNIT_CASE(dm_test_dmub_sw_init_success),
+	KUNIT_CASE(dm_test_dmub_sw_init_bss_data),
+	KUNIT_CASE(dm_test_dmub_sw_init_psp_load),
 	{}
 };
 
-- 
2.43.0

