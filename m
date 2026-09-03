Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAB36C624D7
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Sep 2026 21:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 486DE10E529;
	Thu,  3 Sep 2026 21:08:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ewJz3SdZ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8B310E529
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Sep 2026 21:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyhcOjDjLbASSyYSG1efci/S9r5Zc4Y27LFmZvdyOUesTjITUkbZEkaWLuYljtYxVAieUHlUzq/NJct0RL1QvIZf2SYILWOZDQAH2EjE/RQDcnAZL5FabhIGwxyKejodSLEUdcDn56kh242lAl2n6hgFpf6tvlQkii6ymPlPMQ1B+E3C2oXkThVRU0bW814eKeKGTbGbL0/8AFcGJRHwMxK0qV46gU1QwN/oNyOD1Fmk7PEc+Z6AB4T++8eWLRSflc2rQAJKFi6vLe6wv1Bu52iVDhsCRinpaBYCCHo8kplsDITsFxlpnq4oBtcTpIU8fj8lYXsrrNeUewD1JIclbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knI4blkmleoByaGU0STqzGnAZLoeAJlqZxUdj4juEGk=;
 b=wKTdkmT0quPfiWyOJ6I4hu0T1dv2wUqUiz+ob2T+QEQr/VGyl6QaxBrSmfIuLVz7dGkD8I+zDSpaMFZgsImMFGOb3cFJMQSfTdFmzYkhUxRTJu/h03XEu01sJvUQ17OFyCKxk5rcpUwa8i+d0FdJn2sVc865B5GpEwzkZruHyegkvRYfbfVfVNBIox3eqbatD2MG7QVDjLVLvwGRyCcntVPDm2u15qYCuzvhyXsROLDamOc3T5deC4v5u685gQ4ytkgEynA4wykPfD4ddzM0Snb6fSvl6Qnty8tTV4aRlPERgv13KKl5xFk6v/jSx83NwhkbKBF5Zzqw0dXK3Gt55w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knI4blkmleoByaGU0STqzGnAZLoeAJlqZxUdj4juEGk=;
 b=ewJz3SdZ2Un+DyEUJqmI2dZ+1VYa2dIHM2ucUqQcWFYnquHmoz94o3RySYfRoT8GuXJd3DMcsGDlweAuaUNeiUGvgggztjXj3uCRuniwqli9NeeCu1Y7qlS8kVKeAXnB72434u1FqfwMPyvGr5EmYZch152FFhikya+WxaKaBY0=
Received: from MW4PR03CA0083.namprd03.prod.outlook.com (2603:10b6:303:b6::28)
 by DS7PR12MB5887.namprd12.prod.outlook.com (2603:10b6:8:7a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Thu, 3 Sep 2026 21:08:35 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:303:b6:cafe::83) by MW4PR03CA0083.outlook.office365.com
 (2603:10b6:303:b6::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 21:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 21:08:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 16:08:32 -0500
Received: from devkfd.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 16:08:31 -0500
From: Gang Ba <Gang.Ba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Jay.Cornwall@amd.com>, <Kent.Russell@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix TCP XNACK scoreboard reset race
Date: Thu, 3 Sep 2026 17:08:25 -0400
Message-ID: <20260903210825.839968-1-Gang.Ba@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|DS7PR12MB5887:EE_
X-MS-Office365-Filtering-Correlation-Id: d4000ec4-ebce-489e-6351-08df09ff8440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|10067099003|18002099003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info: By0XOuLHSRJZgUCuL2cfasVMvALZUNbvTyBrp3A9usRdbfU6swtAqI+Wp31Gc1SoKbDb2X5PAGu2fJQO0f6xaryobQQNNYDk3MfU5u8MhWm4bOTqq3Al9cZVhP77xXDlTXTdPqaYqgI8u8PZ5aj2ZH7+cVvErHTYM607vo5gu2Nn6W5e/YKpgxsqQYiHHrWAF+qZME4zUjS8S3ewHIm5WMnQBHyhtZWZlGyeWmrpZqq8qEyEbQ8dV8hbh3YbwfS9KMeT1/pYxuYL24ZAEP1QHDNLKNvmnjQvFg3cIiDh8KxS1TeuNLzUIKpvO4IGJ2seHv8jPA0VPdeA7yvJcHCdsIz+qJOSyDjtaMq9b2g7/D6IfCIVcsDtohXTj881TML5hcnWq9zBAzgyinWzSZzybcv997PQiw4LXakgj2vRhwSYeXPS14sIjga/hfQj2DFl2fN7RTpaqz2Dmhf+Vg1zZeZrr15Me1zT0xb4oid5YXQSPp8/N5nSD6Yq7d2/X5Tv7UQA0QShZ5IFrVL2abTuqzpM6fNA58VvB5457iDt6XEnwsRtRvFOUN6h90pU6BObLQG3uhVELPxKUSlFMJRaD9jnlSSv/SuzH/bdmNM/zXnuv1RiPO9FMcl+mFoIaXq6ByafRKREcXCTK651PpltEGEHR4p2eBc9vrtnRAHnjmKbuPoDjONjm5R9t3R11dDlspVubZvLW0nrlt5EfalBSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(10067099003)(18002099003)(56012099006)(3023799007)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5SMr+byTdW0jQUD7ZAHyxe3w8jlLlPQQz0cTY7M0JY73VYNZTt5MopZRZOlDbBBJ67FdLoPqHqA6GMVAf+Hz/z/PpeeGJmGonvvW3uOa7GeTXdjEXHVGFM1zbbdSjsI5li3lAysc8lVW2iWrpopPlMcU7g64axef6AFe5bzyXuIUviM3/sBBtDD9H5uEwpxQ8L8aaowfvp2E7Mbvx/aybzFXKe84W6sveE92/5TeS3MZh09SPjIFAlWWz9mG8YJfU+bc1JPQ8sogSCbwklbzl7ImdwOxuzcfDZvi1RwVn2U6WeHh2aOJxI1HgP1jY2iLYtldrkXZ5jj82AASrhYLmAHxec15Dtr69MmhU/1MVo4DBqbBw0gDnQO2Gcg3lra7ZmvnkK2brqIx/1nLtIUZNEXfDvWPJZDBvWXBBqeSEh7VKpPuAoWArt9O2RJj/n8p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 21:08:34.8676 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4000ec4-ebce-489e-6351-08df09ff8440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5887
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

Fix a hardware RTL bug in the TCP XNACK scoreboard reset path where a wave
receiving a no-retry FAULT from UTC and subsequently terminating may leave
its scoreboard entry uncleared when reset events arrive back-to-back.

This can cause a later, unrelated wave using the same slot to incorrectly
inherit the XNACK error state, resulting in its VMEM operations being
dropped even though the wave never faulted.

Signed-off-by: Gang Ba <Gang.Ba@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 10 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       | 83 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h       |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        | 19 +++++
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  1 +
 7 files changed, 115 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 7e9f7a280c1b..98cd0435ced5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -193,5 +193,6 @@ const struct kfd2kgd_calls aldebaran_kfd2kgd = {
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v9_hqd_reset,
-	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell
+	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell,
+	.hqd_gfx_clean_fault = kgd_gfx_v9_clean_fault
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index b30ad9701bce..fc253260ade5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -37,6 +37,7 @@
 #include "soc15.h"
 #include "soc15d.h"
 #include "gfx_v9_0.h"
+#include "gfx_v9_4_2.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
 #include <uapi/linux/kfd_ioctl.h>
 
@@ -1226,11 +1227,15 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 
 uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
 					  int engine, int queue)
-
 {
 	return 0;
 }
 
+void kgd_gfx_v9_clean_fault(struct amdgpu_device *adev)
+{
+	gfx_v9_4_2_clean_fault(adev);
+}
+
 const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
@@ -1261,5 +1266,6 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 	.program_trap_handler_settings = kgd_gfx_v9_program_trap_handler_settings,
 	.hqd_get_pq_addr = kgd_gfx_v9_hqd_get_pq_addr,
 	.hqd_reset = kgd_gfx_v9_hqd_reset,
-	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell
+	.hqd_sdma_get_doorbell = kgd_gfx_v9_hqd_sdma_get_doorbell,
+	.hqd_gfx_clean_fault = kgd_gfx_v9_clean_fault
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 9f43f16a1ace..dba7ace872de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -115,3 +115,4 @@ uint64_t kgd_gfx_v9_hqd_reset(struct amdgpu_device *adev,
 			      unsigned int utimeout);
 uint32_t kgd_gfx_v9_hqd_sdma_get_doorbell(struct amdgpu_device *adev,
 					  int engine, int queue);
+void kgd_gfx_v9_clean_fault(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 8b84bba58752..344156bf20ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -343,6 +343,28 @@ const struct soc15_reg_entry sgpr64_init_regs_aldebaran[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0xffffffff },
 };
 
+static const u32 fault_cleaner_compute_shader_aldebaran[] = {
+	0xbe8000ff, 0x00001000, 0x80808100, 0x86000000, 0xbf85fffd, 0xbf810000
+};
+
+const struct soc15_reg_entry fault_cleaner_init_regs_aldebaran[] = {
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_RESOURCE_LIMITS), 0x0000000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_X), 0x40 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Y), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_NUM_THREAD_Z), 1 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC1), 0xaf0000 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC2), 0xc8 },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_PGM_RSRC3), 0xea4fac },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE0), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE1), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE2), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE3), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE4), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE5), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE6), 0xffffffff },
+	{ SOC15_REG_ENTRY(GC, 0, regCOMPUTE_STATIC_THREAD_MGMT_SE7), 0xffffffff },
+};
+
 static int gfx_v9_4_2_run_shader(struct amdgpu_device *adev,
 				 struct amdgpu_ring *ring,
 				 const u32 *shader_ptr, u32 shader_size,
@@ -692,6 +714,67 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_device *adev)
 	return r;
 }
 
+static int gfx_v9_4_2_clean_shaders(struct amdgpu_device *adev)
+{
+	int r;
+	/* CU_ID: 0~15, SIMD_ID: 0~3, WAVE_ID: 0 ~ 9 */
+	int wb_size = adev->gfx.config.max_shader_engines *
+			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
+	struct amdgpu_ib wb_ib;
+	struct dma_fence *fence = NULL;
+	u32 pattern = 0xa;
+
+	/* bail if the compute ring is not ready */
+	if (!adev->gfx.compute_ring[0].sched.ready)
+		return 0;
+
+	/* allocate the write-back buffer from IB */
+	memset(&wb_ib, 0, sizeof(wb_ib));
+	r = amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),
+			  AMDGPU_IB_POOL_DIRECT, &wb_ib);
+	if (r) {
+		dev_err(adev->dev, "failed to get ib (%d) for wb.\n", r);
+		return r;
+	}
+	memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
+
+	r = gfx_v9_4_2_run_shader(adev,
+			&adev->gfx.compute_ring[0],
+			fault_cleaner_compute_shader_aldebaran,
+			sizeof(fault_cleaner_compute_shader_aldebaran),
+			fault_cleaner_init_regs_aldebaran,
+			ARRAY_SIZE(fault_cleaner_init_regs_aldebaran),
+			adev->gfx.cu_info.number * 32,
+			wb_ib.gpu_addr, pattern, &fence);
+
+	if (r) {
+		dev_err(adev->dev, "failed to clear MI200\n");
+		goto pro_end;
+	}
+
+	/* wait for the GPU to finish processing the IB */
+	r = dma_fence_wait(fence, false);
+	if (r)
+		dev_err(adev->dev, "timeout to clear MI200\n");
+
+pro_end:
+	if (fence)
+		dma_fence_put(fence);
+	amdgpu_ib_free(&wb_ib, NULL);
+
+	if (r)
+		dev_dbg(adev->dev, "Clean MI200 Failed\n");
+	else
+		dev_dbg(adev->dev, "Clean MI200 Successfully\n");
+
+	return r;
+}
+
+void gfx_v9_4_2_clean_fault(struct amdgpu_device *adev)
+{
+	gfx_v9_4_2_clean_shaders(adev);
+}
+
 int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 {
 	/* only support when RAS is enabled */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
index a603724c1dfc..1cbade5ed657 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.h
@@ -30,6 +30,7 @@ void gfx_v9_4_2_init_golden_registers(struct amdgpu_device *adev,
 				      uint32_t die_id);
 void gfx_v9_4_2_init_sq(struct amdgpu_device *adev);
 void gfx_v9_4_2_set_power_brake_sequence(struct amdgpu_device *adev);
+void gfx_v9_4_2_clean_fault(struct amdgpu_device *adev);
 int gfx_v9_4_2_do_edc_gpr_workarounds(struct amdgpu_device *adev);
 
 extern struct amdgpu_gfx_ras gfx_v9_4_2_ras;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 0dd1fd448059..c5b36f0cbe41 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -195,6 +195,20 @@ bool kfd_dbg_ev_raise(uint64_t event_mask,
 	return is_subscribed;
 }
 
+static void gfx942_clean_fault(struct kfd_process_device *pdd)
+{
+	struct device_queue_manager *dqm;
+
+	/* Run the GFX cleaner on the faulting device.
+	 * Only run once per page fault (evicted == 1 after first evict).
+	 */
+	dqm = pdd->dev->dqm;
+	dqm_lock(dqm);
+	if (pdd->qpd.evicted == 1 && dqm->dev->kfd2kgd->hqd_gfx_clean_fault)
+		dqm->dev->kfd2kgd->hqd_gfx_clean_fault(dqm->dev->adev);
+	dqm_unlock(dqm);
+}
+
 /* set pending event queue entry from ring entry  */
 bool kfd_set_dbg_ev_from_interrupt(struct kfd_node *dev,
 				   unsigned int pasid,
@@ -240,6 +254,11 @@ bool kfd_set_dbg_ev_from_interrupt(struct kfd_node *dev,
 			mutex_unlock(&p->mutex);
 		} else if (trap_mask & KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION)) {
 			kfd_evict_process_device(pdd);
+
+			/* GPR cleaner shader for MI2XX */
+			if (KFD_GC_VERSION(dev) == IP_VERSION(9, 4, 2))
+				gfx942_clean_fault(pdd);
+
 			kfd_signal_vm_fault_event(pdd, NULL, exception_data);
 
 			signaled_to_debugger_or_runtime = true;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 01c2631bbdff..d749669f8e6d 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -343,6 +343,7 @@ struct kfd2kgd_calls {
 	int (*hqd_sdma_get_counter)(struct amdgpu_device *adev,
 				    void *mqd, uint32_t num_sdma_queues_per_eng,
 				    uint64_t *val);
+	void (*hqd_gfx_clean_fault)(struct amdgpu_device *adev);
 };
 
 #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
-- 
2.55.0

